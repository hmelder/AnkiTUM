import click
import ruamel.yaml
from ruamel.yaml import CommentedMap


class DuplicateIDError(Exception):
    def __init__(self, id: int):
        self.id = id


def collect_existingIDs(cards):
    """
    Collects all IDs in the list of cards and returns them as a set
    """
    found_ids = set()
    for card in cards:
        if "id" in card:
            if card["id"] in found_ids:
                raise DuplicateIDError(card["id"])

            found_ids.add(card["id"])

    return found_ids


@click.command()
@click.argument("file_path", type=click.Path(exists=True))
def insert_ids(file_path, verbose=True):
    """
    Inserts missing IDs into yaml file. If duplicate IDs exist, returns exit code 1
    """
    yaml = ruamel.yaml.YAML()

    with open(file_path, "r") as file:
        try:
            data = yaml.load(file)

            if "cards" in data and isinstance(data["cards"], list):
                try:
                    existingIDs: set[int] = collect_existingIDs(data["cards"])

                except DuplicateIDError as e:
                    click.echo(f"Duplicate IDs {e.id}! Please fix manually")
                    exit(1)

                index = 0

                if verbose:
                    click.echo(f"Found existing IDs: {existingIDs}")

                for card in data["cards"]:
                    if isinstance(card, CommentedMap):

                        if "id" in card:
                            continue

                        # skip existing IDs
                        while index in existingIDs:
                            index += 1

                        existingIDs.add(index)

                        card.insert(1, "id", index, "(generated)")

                with open(file_path, "w") as output_file:
                    yaml.dump(data, output_file)

                click.echo(f"Inserted \"id\" attributes into each object in \"cards\" list in {file_path}")

            else:
                click.echo("Error: \"cards\" key not found or is not a list in the YAML file.", err=True)

        except ruamel.yaml.YAMLError as e:
            click.echo(f"Error parsing YAML in file {file_path}: {e}", err=True)


if __name__ == "__main__":
    insert_ids()
