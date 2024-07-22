# AnkiTUM

**Mirror**: [https://mirror.hugomelder.com/anki-decks/](https://mirror.hugomelder.com/anki-decks/)

## Overview
AnkiTUM is a collaborative repository for computer science students at the Technical University of Munich to create and share flashcards for various CS modules. The flashcards are generated from yaml files, making it easy to contribute and maintain the content.

Please note that AnkiTUM is still in developement. You can help contribute to the parser here: https://github.com/hmelder/AnkiTUM-Runtime.

If you have any suggestions or bugs to report, you can create an issue. Please submit bug reports regarding the parser to the "runtime" repository.

### Downloading
Prebuilt flashcard packages (apkg files) are available on my HTTP [mirror](https://mirror.hugomelder.com/anki-decks/), and are updated automatically.

To install the prebuilt flashcard packages:

1. Extract the `.apkg` files from the `.zip` file.
2. Import the `.apkg` file into your Anki application.

### Updating Flashcards
When new flashcards are added or existing ones are updated, simply download the
latest artifact and import it into Anki. Anki is designed to manage updates
efficiently, meaning your progress with the cards, including study stats and
scheduling, will not be lost when you update a deck with a newly downloaded
package.


## Contributing

### !! Anki deck to YAML reverse parser coming soon !!

### Guidelines
We welcome contributions from TUM students to enhance and expand the AnkiTUM
flashcard collection. To contribute, follow these guidelines:

0. **Fork this Repository:** In order to contribute you need to create a fork of this repository

1. **Create Your Flashcards:** Add or edit yaml files following the specified format for decks.
2. **Test Locally:** Generate the flashcards locally using the provided instructions to ensure they are formatted correctly.
3. **Commit Your Changes:** Once you've tested your flashcards, commit the changes to your forked repository.
4. **Submit a Pull Request (PR):** Create a PR against the main AnkiTUM repository. Include a short description of your changes and any other relevant information.
5. **Review:** Wait for a repository maintainer to review your PR. Be responsive to any feedback or required changes.

### Best Practices
- Ensure your flashcards are accurate and relevant to the CS modules.
- Check for duplicates to avoid redundant content.
- Keep your yaml files organized by module and topic.
- Leave two lines between each "card" declaration, so the yaml is easier to read

By following these guidelines, you'll help maintain the quality and usefulness
of the AnkiTUM flashcard repository for all students. Your contributions are
greatly appreciated!


## Flashcard Format
We use [YAML](https://yaml.org/) to write decks which are then converted to Anki decks using [AnkiTUM-Runtime](https://github.com/hmelder/AnkiTUM-Runtime).

Take a look at the YAML files inside this project to get a feel for it!

Anki supports various kinds of cards, including the **basic**, **markdown** and **cloze**
cards. Basic cards have a front and a back just like classic flash cards. Markdown/md_basic cards allow markdown styling. 
Cloze types do not have a back. They contain "clozes" which are words or phrases
inside a sentence that are blacked out and get revealed when the user turns the
card around.

Our converter supports plaintext, markdown, and latex. You can also include images in your flashcards.
Additionally, Card and Deck IDs must be set in ordner for anki to merge old versions of the decks with new versions-
Thankfully, we have a script which automatically adds missing IDs to cards, so you dont have to worry about them at all.
AnkiTum Bot will add the IDs for you.

Here is an example of a basic card with markdown:

```yaml
# The unique ID of the deck
id: 123 # this is optional, you can let the bot add the ID
# Deck Title
title: IPC
authors: Joe

# A list of cards 
cards:
- type: markdown
  # Front and Back are formatted in Markdown
  front: Welche Interaktionen zwischen Prozessen sind möglich?
  back: |+
    - **Kausale Beziehungen**
    - **Kommunikation**: Austausch von Nachrichten (Auch Rechensystem unabhängig)
    - **Koordinierung**
    - **Konkurrenz**: Prozesse konkurrieren um gemeinsame Ressourcen

# A plaintext card
- type: basic
  front: Hello?
  back: World!
```

Tip: the |+ operator easily lets you write out long strings in yaml without having to surround them with quotes. 


## Generating Flashcards Locally
Our runtume script will generate anki decks from yaml files.
To generate flashcards on your local machine, you need to have Python installed. Follow these steps:

1. Clone the AnkiTUM repository.
2. Navigate to the cloned directory.
3. Create a virtual environment: `python -m venv ankitum-env`
4. Activate the virtual environment:
   - On macOS and Linux: `source ankitum-env/bin/activate`
5. Install the converter (Make sure that you are still in the venv):
   - `git clone https://github.com/hmelder/AnkiTUM-Runtime`
   - `pip3 install -r AnkiTUM-Runtime/requirements.txt`
   - `pip3 install ./AnkiTUM-Runtime`
6. Run `sh build.sh`. This will create `build/` with all the resulting decks

## Releases

Modules are released when they reach a stable iteration, reflecting the latest
contributions at that time.
