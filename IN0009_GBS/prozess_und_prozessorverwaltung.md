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