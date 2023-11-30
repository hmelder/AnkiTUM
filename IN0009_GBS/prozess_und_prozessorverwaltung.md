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

## Was ist der virtuelle Addressraum?

Der virtuelle Addressraum ist eine Abstraktion des physischen Speichers.
Jeder Prozess verfügt über einen eigenen Addressraum, die voneinnander
*abgeschottet* sind.


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

## Warum lässt sich ein Prozess und Thread konzeptuell trennen?

Ressourcen und Kontrollfluss sind unabhängige Konzepte und lassen sich trennen.

## Eigenschaften eines Threads

- Abstraktion eines physischen Prozessors
- Jeder Prozess hat einen eigenen Kontrollfluss
- Threads eines Prozesses teilen sich den Addressraum
- Eigener Befehlzähler

## Thread-Kontext

Der Thread-Kontext umfasst u.a:
- Programmzähler
- Registerwerte 
- Stackpointer auf eigenem Stack

## Was sind die 5 möglichen Zustände eines Threads?
- (erzeugt)
- rechenwillig
- rechnend
- wartend
- terminiert

## Warum haben Threads generell einen geringeren Overhead als Prozesse?

- Einfache Kommunikation zwischen Threads einens Prozesses über gemeinsamen Addressraum (Anstelle von aufwendiger inter-prozess-communication (IPC))
- Erstellen eines Threads wesentlich geringer als einen Prozess zu erzeugen (Faktor 10-100)
- Schneller Kontextwechsel

## Was ist der Process Control Block (PCB)?

Speicherung von Informationen über:
- *Prozessverwaltung*
- *Speicherverwaltung* (engl. memory management)
- *Dateiverwaltung* (engl. file management)

## Welche Informationen werden für die Speicherverwaltung eines Prozesses benötigt?

Pointer zu Code-, Daten-, und Stack-Segment
Anfang und Größe der Segmente.

## Welche Informationen werden für die Dateiverwaltung eines Prozesses benötigt?

- Root Verzeichnis
- File Deskriptoren
- UID und GID

## Was ist eine Prozesstabelle

Eine verkettete Liste von PCBs

## BS Dienste zur Prozessverwaltung

- Dienste zur Erzeugung eines Prozesses
- Dienste zur Terminierung von Prozessen
- Strategien zur Prozessorzuteilung (Scheduling)
- Dienste zur Prozessor-Anbundung (Dispatching)

## Auslöser einer Prozesserzeugung

- Während der Systeminitialisierung (Init started daemons)
- Durch andere Prozesse (z.B. via fork)
- Durch einen Benutzer (Beispiel: Starten eines Programmes)
- Durch das BS (z.B. Batch-Systeme)

## Was macht der POSIX-Systemcall `fork`?

- Kindprozess mit gleichem Speicherabbild (Kopie)
	- Auch file descriptors
- Vergabe einer neuen PID
- Prozesse laufen unabhängig voneinander

## Was ist die Besonderheit bei dem Rückgabewert von `fork`?

Eltern-Prozess bekommt die PID des Kindes zurückgegeben, während der
Kindprozess `0` zurückgegeben bekommt. Das kann nützlich sein, um
z.B. das Speicherabbild des Kindes zu überschreiben.

## Welche Arten der Prozessterminierung gibt es?

- Normale Beendigung (freiwillig)
  - `void exit (int status)`
  - `return status` aus `main()`
- Vorzeitige Beendigung durch Fehler (freiwillig)
  - Fehler wird von Programm abgefangen. Programm terminiert.
- Vorzeitige Beendigung durch *fatalen* Fehler
  - Exception wird nicht abgefangen, oder kann nicht abgefangen werden (i.e. Segmentation Fault)
- Terminierung durch einen anderen Prozess
  - Durch senden eines Signals

## Welche PID hat der Prozess init?

PID=1. Init ist der erste Prozess der bei einem UNIX(-ähnlichen) System startet.

## Wer started PID 1?

Der Kernel.

## (Extra) Was würde passieren, wenn PID 1 crashed?
- Alle Kinder sind nun Weisen (Praktisch alle anderen Prozesse)
- Init ist normalerweise verantwortlich für das Herunterfahren und Neustarten des Systemes
- PID 1 kann nicht neugestartet werden -> System Neustart notwendig

## Was ist eine Prozessgruppe?
Eine Prozessgruppe ist eine Gruppe von einem oder mehreren Prozessen, die für
Zwecke der Jobsteuerung und Signalverarbeitung als eine einzelne Einheit
behandelt werden.

Jeder Prozess inkl. seiner Kinder formen eine Prozessgruppe (Mit PPID identifiziert).

## Warum sind Prozesshierarchien natürlich in UNIX(-ähnlichen) Systemen?
Ein Prozess wird von einem bestehenden Prozess erstellt und ist somit sein Kind.
Der erste Prozess (PID 1) wird allerdings vom BS gestartet.

## Zombies in Prozesshierarchien
- Entsteht, wenn ein Kind-Prozess seine Ausführung beendet, bevor der Eltern-Prozess endet.
- Speicher des Kind-Prozesses wird freigegeben, aber sein Exit-Status wird in den Process Control Block (PCB) geschrieben, wodurch ein Zombie entsteht.
- Belegen Platz in der Prozesstabelle.
- Führen keinen Code mehr aus

## Umgang mit Zombie-Prozessen
- Der Eltern-Prozess kann `wait` oder `waitpid` verwenden, um auf die Beendigung des Kind-Prozesses zu warten.
- Der Eltern-Prozess blockiert (wird in die Wait-Queue eingefügt), bis das Kind terminiert.
- Nach der Beendigung des Kindes kann der Elternprozess den Grund der Terminierung erfragen.
- Das Lesen des Exit-Status des Kindes entfernt den Zombie-Prozess.

## Waisenprozesse
- Waisen entstehen, wenn der Eltern-Prozess vor dem Kind-Prozess endet.
- Der verwaiste Kind-Prozess wird vom Init-Prozess adoptiert (PPID = 1).

## Was ist erforderlich, damit ein Waisenprozess zu einem Daemon wird?
Loslösung von Gruppen-ID und Benutzer-ID und die Umleitung von Filedeskriptoren
(stdin, stdout, stderr).

## Prozesshierarchien in Windows
- Windows hat keine Prozesshierarchien ähnlich wie Unix/Linux.
- Jeder Windows-Prozess erhält bei der Erstellung einen eindeutigen Handle.
- Handles können zwischen Prozessen übertragen werden.

## Welche zwei Hauptaufgaben werden in der Prozessorverwaltung unterschieden?
- Verwaltung in Dispatcher und Scheduler aufgeteilt. Der Dispatcher realisiert
Prozess-Zustandsübergänge von rechenwillig nach rechnend, während der Scheduler
die Reihenfolge der Prozessausführung bestimmt.

## Welche Rolle spielt der Scheduler in der Prozessorverwaltung?

- Verwaltet die Warteschlange der rechenwilligen Prozesse (Run
Queue)
- Wählt mit Hilfe von Scheduling-Algorithmen den nächste(n) Prozess(e) zur
Ausführung aus

## Was macht ein Dispatcher?
- Implementiert Zustandsübergang zwischen rechnend und rechenwillig
- Dispatcher entzieht dem rechnenden Prozess/Thread die CPU und teilt sie einem
anderen rechenbereitem Prozess/Thread zu

## Abfolge von Dispatching
1. **Ändert den Zustand** des rechnenden Prozesses zu wartend oder rechenbereit
2. **Sichert den Kontext** des zuvor rechnenden Prozesses/Threads im PCB
3. **Lädt den Kontext** des rechenbereiten Prozesses/Threads
4. **Ändert den Zustand** des rechenbereiten Prozesses zu rechnend

## Strategische Entscheidungen des Schedulers
Der Scheduler trifft strategische Entscheidungen darüber, welchen Prozess oder
Thread er wann und wie lange an die CPU bindet. In Multiprozessor-Systemen
entscheidet er auch, an welche CPU der Prozess gebunden wird.

## Wie nutzt der Scheduler das typische Verhalten von Prozessen für das Scheduling?
Der Scheduler berücksichtigt, dass CPU-Nutzungs-Bursts sich mit I/O-Wartephasen
abwechseln. Er beachtet sowohl CPU-limitierte als auch I/O-limitierte Prozesse,
um eine effiziente CPU-Zuteilung zu erreichen.

## Scheduler-Aktivierung
Der Scheduler wird bei bestimmten Ereignissen aktiv:
- Erzeugung neuer Prozesse
- Terminierung von Prozessen
- Wenn ein Prozess blockiert wird (z.B. durch I/O oder Semaphoren)
- Interrupts, wie beispielsweise von einem I/O-Gerät

## Welche Rolle spielt der Scheduler bei Prozessblockierungen und Interrupts?
- Prozessblockierungen: Entscheidungen bei Blockierung durch I/O, Semaphoren etc.
- Belegte Ressourcen: Was passiert, wenn ein blockierender Prozess eine benötigte Ressource belegt?
- Nächster Prozess: Auswahl, wenn der nächste Prozess die belegte Ressource benötigt.
- Interrupts: Aufwecken blockierter Prozesse durch I/O-Geräte-Interrupts.
- Timer-Interrupts: Scheduling-Entscheidungen bei jedem Timer-Interrupt.

## Thread Implementierungen
- User-Level-Threads (Scheduling im User-Space)
  - Meistens nur koorperativ (nicht-preemptiv)
- Kernel-Level-Threads
  - Threadtabelle im Kern. BS kontrolliert Zuteilung. 
  - Thread-Operationen führen zu einem Trap in den Kern (Syscall)
- Hybride Implementierung (n:m Abbildung zwischen n Threads in User-Space und m
Kernel Threads)

## Vorteile von User-Level Threads
- BS-unabhängig
- Schnelles Umschalten zwischen User-Level-Threads (keine Syscalls)
- Anwendungsspezifisches Scheduling

## Nachteile von User-Level Threads
- Blockieren eines Threads
- Threads werden eingesetzt, um blockierende Aufrufe zu parallelisieren
- Threads können die CPU monopolisieren

## Vorteile von Kernel-Level Threads
1. **CPU-Scheduling und Multi-Processing**:
   - Echte Parallelität
2. **Einfacheres Blocking und I/O-Operationen**:
   - Wenn ein Kernel-Thread eine blockierende I/O-Operation durchführt, kann das Betriebssystem andere Threads im selben Prozess weiterlaufen lassen.
   - User-Level-Threads würden bei einer blockierenden Operation den gesamten Prozess blockieren.
3. **Prioritätsgesteuertes Scheduling**:
   - Das Betriebssystem kann Kernel-Threads basierend auf Prioritäten planen, was für Echtzeitanwendungen entscheidend sein kann.

## Nachteile von Kernel-Level Threads
1. **Overhead bei der Kontextumschaltung**:
   - System Calls notwendig
2. **Höhere Erzeugungs- und Verwaltungskosten**:
   - Das Erstellen und Verwalten von Kernel-Threads ist oft aufwendiger als bei User-Level-Threads.
   - Jeder Kernel-Thread benötigt eigene Kernel-Ressourcen, was bei vielen Threads zu einem erhöhten Ressourcenbedarf führt.
3. **Skalierbarkeitsprobleme**:
   - Betriebssysteme begrenzen häufig die Anzahl der Threads, die ein Prozess haben kann, was die Skalierbarkeit von Anwendungen mit vielen Threads einschränken kann.
4. **Geringere Flexibilität in der Scheduling-Politik**:
   - Bei Kernel-Level-Threads ist das Scheduling meist fest im Kernel verankert, was die Anpassung an spezifische Anwendungsbedürfnisse erschwert.

## Unix-Threads
- UNIX-Systeme unterstützen Kernel-Level Threads.
- LinuxThreads: Erste Thread-Implementierung unter Linux.
	- Gemeinsame Ressourcen: Adressraum, Datei-Deskriptoren, Signale etc.
	- Eigene IDs: Jeder Thread hat unterschiedliche PIDs und PPIDs.
	- Manager-Thread: Benötigt für Erzeugung und Terminierung von Threads.
	- Thread-Erzeugung: Verwendung des Systemcalls clone().
- Java Threads (JVM Verwendet NPTL)
	- Java Thread wird 1:1 auf einen Kernel-Level-Thread abgebildet

## Wichtige POSIX Threads Funktionen
- pthread_create (Erstellen eines neuen Threads)
- pthread_exit (Aufrufender Thread wird beendet)
- pthread_join (Warten auf die Terminierung und Rückgabewert des Threads)

## Was sind Scheduling Ziele für alle Systeme?
- **Fairness**: Jeder Prozess soll einen fairen Anteil der CPU erhalten
- **Balance**: Alle Teile des Systems (CPU, I/O) möglichst effektiv auslasten

## Was sind Scheduling Ziele für Batch-Systeme?
- **Durchsatz**: Maximiere Anzahl der Aufträge pro Zeit, Maß für Systemauslastung
- **Ausführungszeit**: Minimiere Ausführungszeit
- **CPU Belegung**: Konstante Belegung der CPU

## Was sind Scheduling Ziele für Interaktive-Systeme?
- **Antwortzeit**: Minimiere die Antwortzeit für eingehende Anfragen
- **Proportionalität**: Berücksichtige die Erwartungshaltung der Benutzer

## Was sind Scheduling Ziele für Echtzeit-Systeme?
- **Deadlines einhalten**: Vermeide Datenverlust (Soft-Deadlines).
- **Vorhersagbarkeit**: Vermeide Qualitätsverlust z.B. in Multimediasystemen

## Was sind Kriterien zur Auswahl von Prozessen
- Fairness vs. Priorität
- I/O vs. CPU-Bound Prozesse
- Wartezeit
- CPU-Belegung vs. Durchsatz

## Welche prinzipiellen Scheduling-Klassen gibt es?
- **Nicht-unterbrechend** (non-preemptive)
- **Unterbrechend** (preemptive)

## Was zeichnet nicht-unterbrechendes Scheduling aus?
Prozesse werden so lange ausgeführt, bis sie blockieren oder freiwillig
die CPU abgeben.

## Was zeichnet unterbrechendes Scheduling aus?
Prozesse werden beim Auftreten von bestimmten Ereignissen (z.B.
Timer-Interrupt) unterbrochen.

## Welche drei Scheduling Strategien können für Batch-Systeme genutzt werden? Sind sie unterbrechend?
- **First-Come-First-Served** (FCFS): nicht unterbrechend
- **Shortest Job First** (SJF): nicht unterbrechend
- **Shortest Remaining Time Next** (SRTN) unterbrechend

## Wie ist FCFS aufgebaut?
- FIFO-Run-Queue (Ready-Queue) mit rechenwilligen Prozessen
- Prozess wird so lange ausgeführt, bis er blockiert, oder freiwillig die CPU abgibt
- Bei Abgabe wird der nächste Prozess aus der FIFO Queue aktiv

## Welchen Nachteil hat die FCFS Scheduling Strategie?
Der Hauptnachteil der FCFS-Scheduling-Strategie ist der Convoy-Effekt, bei dem
lange Prozesse kürzere Prozesse in der Warteschlange blockieren, was zu
ineffizienter CPU-Nutzung und längeren Wartezeiten führt.

## Warum sind "Shortest Job First" und "Shortest Remaining Time Next" ungeeignet für Scheduling in interaktiven Systemen?
Die Ausführungszeiten müssen vorab bekannt sein.

## Wann wird ein Prozess bei "Shortest Remaining Time Next" unterbrochen?
Bei Ankunft neuer Prozesse.

## Wie funktioniert die SJF Scheduling Strategie?
- CPU wird einem Prozess mit der kürzesten Rechenzeit zugewiesen

## Wann ist die SJF Scheduling Strategie optimal?
Wenn alle Jobs am Anfang vorliegen und alle Rechenzeiten bekannt sind.

## Wie können auch Prozesse mit unbekannter Rechenzeit mit der SJF Scheduling Strategie verarbeitet werden?
Die Rechenzeit wird in Phasen approximiert. Dabei wird die nächste Rechenphase
abgeschätzt und mit der letzten (tatsächlichen) Ausführungszeit korrigiert.

TODO: Formel

## Beschreibe wie die SRTN Scheduling Strategie funktioniert.
SRTN (Shortest Remaining Time Next) ist die unterbrechbare Variante von Shortest Job First (SJF).

1. Sobald ein neuer Prozess rechenwillig wird, wird seine Gesamt-Rechenzeit mit
der verbleibenden Zeit des aktiven Prozesses verglichen
2. Ist die Rechenzeit des neuen Prozesses kürzer, wird der aktive Prozess unterbrochen.

## Nenne zwei Scheduling Strategien für interaktive Systeme.
- **Round-Robin Scheduling** (RR)
- **Priority Scheduling**

## Was passiert, wenn das Zeitquantum bei m Round-Robin Scheduling Algorithmus zu kurz gewählt wird?
Es werden zu viele teure Kontextwechsel erzeugt.

## Was passiert, wenn das Zeitquantum bei m Round-Robin Scheduling Algorithmus zu lang gewählt wird?
Das Verhalten ist ähnlich wie bei einem FCFS-Scheduling, was zu langen
Wartezeiten für andere Prozesse und einer verringerten Systemreaktivität führt.

## Wie heißen die zwei vorgestellten Scheduling-Strategien für Echtzeit-Systeme?
- **Earliest Deadline First** (EDF)
- **Rate-Monotonic Scheduling** (RMS)