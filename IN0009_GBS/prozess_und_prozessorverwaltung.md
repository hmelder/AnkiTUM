# GBS: Kapitel 2: Prozess und Prozessorverwaltung

## Was sind die 5 Stufen um C Quellcode zu einem ausführbaren Programm zu transformieren?
1. Präprozessor (Auflösen von Makros und anderen Direktiven wie #include)
2. Compiler (Übersetzer von C in Assembler)
3. Assembler (Übersetzer von Assemblersprache in ISA-spezifischen Maschinencode)
4. Linker (Binden von einzelnen Modulen zu einer ausführbaren Datei)
5. Loader des Betriebsystems (Laden der gebundenen Objekte in den Speicher)

## Was sind die IOPL Bits im Flag Register eines x86 Prozessors
Die I/O Privilege Level (IOPL) Bits spezifizieren die aktuelle Privilegienlevel.

Die IOPL Bits im Flag Register eines x86 Prozessors definieren das
Privilegienlevel für I/O-Operationen. Es gibt vier Privilegienebenen (Ringe 0
bis 3), wobei Ring 0 das höchste Privileg und Ring 3 das niedrigste darstellt.

## Wie sieht ein Prozess im Speicher aus (x86)
Von 0xFFFF...FFFF nach 0x0000...0000!

1. Stack - Beginnt bei der höchsten Adresse und wächst nach unten. Enthält lokale Variablen und Funktionsaufrufe.
2. Heap - Wächst dynamisch nach oben, liegt direkt über dem Data-Segment.
3. Data - Enthält globale und statische Variablen; liegt über dem Code-Segment.
4. Code/Text - Befindet sich im unteren Teil des Adressraums; enthält ausführbaren Programmcode.

## Was ist ein Prozesskontext?

Der Prozesskontext umfasst alle Informationen, die ein Betriebssystem über einen
Prozess speichert, um dessen Ausführungszustand zu verwalten.

## Prozesskontext im Betriebssystem: Registerzustände
- Registerinhalte
- Program Counter
- Stack Pointer
- Statusregister

## Prozesskontext im Betriebssystem: Prozessidentifikation und -zustand
- Prozesszustand
- Priorität
- Process ID (PID)
- Parent PID (PPID)
- Process Group ID (PGID)

## Prozesskontext im Betriebssystem: Ressourcenverweise und Sicherheitskontext
- Pointer auf Speichersegmente
- Größe der Segmente
- Dateideskriptoren
- User ID (UID)
- Group ID (GID)

## Warum ist die Prozess-Verarbeitung oftmals nur quasi-parallel?

In Einprozessorsystemen kann die CPU tatsächlich nur einen Prozess gleichzeitig
ausführen. Quasi-Parallelität entsteht durch schnelles Umschalten zwischen
Prozessen (Scheduling), wodurch der Eindruck simultaner Ausführung entsteht.

## Wie beeinflusst der I/O-Warteanteil p die CPU-Auslastung bei n Prozessen?

Ist der Anteil der Wartezeit auf I/O für einen Prozess p, so ist die erwartete
CPU-Auslastung bei n gleichzeitig laufenden Prozessen probabilistisch 1 - p^n.

## Was sind die Zustände eines Prozesses?

- **ready**: Der Prozess ist bereit zur Ausführung und wartet auf Zuweisung eines Prozessors.
- **running**: Der Prozess wird aktuell auf dem Prozessor ausgeführt.
- **blocked/waiting**: Der Prozess kann nicht fortgesetzt werden, bis ein bestimmtes Ereignis eintritt.
- **swapped out/ausgelagert**: Der Prozess wurde aus dem Arbeitsspeicher ausgelagert.
- **swapped in/eingelagert**: Ein ausgelagerter Prozess wird wieder in den Arbeitsspeicher geladen.

## Was initiiert der Zustandsübergang 'add' bei einem Prozess?

Der Zustandsübergang 'add' fügt einen neu erzeugten Prozess zur Menge der rechenwilligen (ready) Prozesse hinzu.

## Welche Wirkung hat der Zustandsübergang 'assign' auf einen Prozess?

Der Zustandsübergang 'assign' ordnet einem Prozess die CPU zu und ändert seinen Status auf 'running'.

## Durch was wird der Zustandsübergang 'block' bei einem Prozess veranlasst?

Der Zustandsübergang 'block' wird durch einen I/O-Aufruf oder eine
Synchronisationsoperation ausgelöst und versetzt den Prozess in den Zustand
'blocked/waiting'.

## Wann erfolgt der Zustandsübergang eines Prozesses zurück in 'ready'?

Der Zustandsübergang zurück in 'ready' erfolgt, nachdem die blockierende
Operation beendet ist oder die Blockade aufgehoben wurde.

## Welcher Zustandsübergang wird mit 'resign' beschrieben?

Der Zustandsübergang 'resign' entzieht einem laufenden Prozess die CPU, wodurch
er in den Zustand 'ready' zurückkehrt.

## Was kennzeichnet den Zustandsübergang 'retire' bei einem Prozess?

Der Zustandsübergang 'retire' tritt ein, wenn ein Prozess seine Ausführung
beendet und aus dem System entfernt wird.

## Was resultiert aus dem Zustandsübergang 'swap out' für einen Prozess?

Der Zustandsübergang 'swap out' lagert einen Prozess aus dem Arbeitsspeicher in
die Swap-Datei auf der Festplatte aus.

## Welchen Zustand erreicht ein Prozess durch den Zustandsübergang 'swap in'?

Durch den Zustandsübergang 'swap in' wird ein ausgelagerter Prozess wieder in
den Arbeitsspeicher geladen.

## Prozess vs. Thread

- **Prozess**: Einzelne Ausführungseinheit mit eigenem Adressraum, die Ressourcen wie CPU und Speicher nutzt.
- **Thread**: Leichtgewichtiger Prozess innerhalb eines Prozesses, der einen eigenen Kontrollfluss hat, aber Ressourcen mit anderen Threads teilt.

## Thread-Kontext

Der Thread-Kontext umfasst den Programmzähler, die Registerwerte und einen
eigenen Stack für Unterprogrammaufrufe (Stackpointer), die zur Verwaltung der
Ausführungszustände eines Threads erforderlich sind.