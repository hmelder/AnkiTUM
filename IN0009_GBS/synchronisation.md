# GBS: Kapitel 3: Parallele Systeme und Synchronisation

## Welche Interaktionen zwischen Prozessen sind möglich?
- **Kausale Beziehungen**
- **Kommunikation**: Austausch von Nachrichten (Auch Rechensystem unabhängig)
- **Koordinierung**
- **Konkurrenz**: Prozesse konkurrieren um gemeinsame Ressourcen

## Warum kann die Parallelität von Aktivitäten zu nicht-deterministischem Verhalten von Prozessen führen?
- Scheduler bestimmt über den Ablauf eines Prozesses (Meistens viele Faktoren z.B. Interrupts).
- Multi-Core/CPU Systeme mit echter Parallelität

## Wie können parallele Aktivitäten auf der Modell-Ebene beschrieben werden?
- **Aktionsstrukturen**: Fokus auf Aktionen und deren Abhängigkeiten
- **Petri-Netze**: Fokus auf Zuständen und Zustandsübergängen

## Wie können parallele Aktivitäten auf der Programmiersprachen-Ebene beschrieben werden?
- POSIX Threads (pthread_create, etc.)
- Prozesshierachien (fork, join)
- Kommunikationskonzepte (send, recv)
- Synchronisationskonzepte (lock, unlock)

## Wie können parallele Aktivitäten auf der Betriebssystem-Ebene beschrieben werden?
- Prozesse (Programme in Ausführung)
- Threads (Leichtgewichtige Prozesse)
- Kommunikation
  - Shared Memory
  - Dateien
  - Nachrichten
- Synchronisation
  - Locks
  - Interrupts

## Mit welchen zwei Sichten kann das Verhalten von Aktivitäten beschrieben werden?
- **Aktionen**: Modellierenden Einheiten (z.B. C-Anweisungen, Maschinenbefehl)
- **Ereignisse** Modellierten Einheiten, die Veränderungen bewirken

## Was sind die fünf primären Eigenschaften paralleler Systeme
- Determiniertheit
- Störungsfreiheit
  - Ausführungsreihenfolge die Aktionen und Ergebnisse nicht beeinflusst
- Wechselseitiger Ausschluss (engl. mutual exclusion)
  - Max. ein Prozess greift gleichzeitig auf eine gemeinsame Ressource zu
- Verklemmungsfreiheit (engl. Deadlock)
  - Zyklische Wartesituation zwischen mehreren Prozessen
- Kein Verhungern (engl. Starvation)
  - Keine Prozesse die nie ausgeführt werden

## Was ist eine Race Condition?
- Mindestens zwei Prozesse greifen lesend oder schreibend auf
gemeinsame Ressourcen zu
- Das Ergebnis hängt von der Reihenfolge der Prozess-Ausführung ab

## Wie können Race Conditions verhindert werden?
Wechselseitiger Ausschluss (engl. mutual exclusion) von konkurrierenden Aktionen.

## Was ist ein kritischer Abschnitt?
In Kritischen Abschnitten greifen Prozesse auf gemeinsame
Ressourcen zu.

## Was sind die vier Phasen des kritischen Abschnitts
1. Ausführung der **un**kritischen Abschnitte
2. **Betreten** eines kritischen Abschnitts
3. **Ausführung** der Aktionen des kritischen Abschnitts
4. **Verlassen** des kritischen Abschnitts

## Was ist das Leser-Schreiber-Problem?
- Mehrere Leser sind gleichzeitig zugelassen
- Mehrere Schreiber dürfen nicht gleichzeitig aktiv sein
- Leser und Schreiber dürfen auch nicht gleichzeitig aktiv sein

## Was sind die vier Anforderungen an die Realisierung des wechselseitigen Ausschlusses?
1. Abschnitte sind **wechselseitig** ausgeschlossen
2. **Nicht** von einer Reihenfolge abhängig sein
3. Keine Annahmen über die **Ausführungszeit** eines Prozesses
4. Kein Prozess darf einen anderen Prozess *unendlich lange daran hindern*, seinen kritischen Abschnitt auszuführen

## Wie kann der wechselseitige Ausschluss auf der Hardwareebene implementiert werden?
- Interrupts sperren (disabling), Unterbrechungssperre
- Atomare Maschinenbefehle u.a. TSL, cmpxchg

## Nenne zwei einfache Betriebsystemdienste die als Locking Mechanismen dienen.`
- Dienste mit *aktiven* Warten: z.B. Spin-Lock
- Dienste mit *passiven* Warten: sleep, wakeup

## Warum kann man ein Mutex auch als eine binäre Semaphore bezeichnen?
Eine binäre Semaphore hat nur zwei Zustände: 0 und 1. Ein Mutex ist ähnlich, da er ebenfalls nur zwei Zustände hat: gesperrt (locked) und entsperrt (unlocked).

## Was ist das Konzept von Eigentum bei einem Mutex?
Konzept von "Eigentum": Nur der Thread, der den Mutex gesperrt hat, darf ihn auch wieder entsperren.

## Was passiert mit einem aktiven Prozess, wenn ein Interrupt signalisiert wird?
Bei Signalisierung eines Interrupts wird der aktive Prozess unterbrochen und in den Zustand rechenwillig/wartend überführt, wobei er die CPU freigibt. Die Unterbrechung wird dann durch einen Handler (oder Interrupt Service Routine ISR) behandelt.

## Warum ist eine Unterbrechungssperre nur bei Ein-Prozessorsystemen zur Realisierung kritischer Abschnitte geeignet?
In Multi-Prozessor Systemen verhindert die Unterbrechungssperre auf **einem** CPU nicht, dass andere Prozessoren auf die geteilte Ressource zuzugreifen.

## Warum müssen Kritische Abschnitte, die durch Unterbrechungssperren geschützt sind, kurz sein?
Lange kritische Abschnitte mit deaktivierten Interrupts verhindern das Behandlen von anderen wichtigen Unterbrechnungen. Die Folge sind Verzögerungen, oder das Verpassen von Events/Benachrichtigungen.

## Warum sollte das Konzept einer Unterbrechnungssperre höchstens im Betriebssystem-Kern verwendet werden?
- Grundbaustein für wichtige Dienste im Betriebsystem. Falsche Anwendung kann zur Instabilität, oder zum Absturz führen.
- Einschränkung der Privilegien auf Nutzerebene

## Wofür kann der "Compare and Exchange" Befehl verwendet werden?
Atomarer Austausch von zwei Werten.

Beispiel Spin-Lock:
```asm
enter_crit_region:
  mov rax, $0 ; Expected val
  mov rbx, $42 ; New value
  cmpxchg [lock], rbx
  jne enter_crit_region ; Busy-Waiting
  ret

leave_crit_region:
  mov [lock], $0 ; Reset lock to 0
ret
```

## Wann sind Spin-Locks (aktives Warten) von Vorteil?
- (Sehr) kurze Wartezeiten (gerade bei Multi-Core/CPU Systemen)
- Weniger Overhead (kein Kontextswitch) kann bei schnellen Wechseln (bzw. sehr kurzen kritischen Abschnitten) effizienter sein

## Kann aktives Warten zum Problem werden?
Bei längeren kritischen Abschnitten, oder Wartezeiten.

## Erkläre die Semantik der P-Operation bei Semaphoren und wie sie funktioniert.
Die P-Operation (down) dekrementiert die Kontrollvariable s. Falls s < 0 wird, muss der Prozess warten. Bei passivem Warten wird der Prozess in den Zustand wartend überführt und in einer Wait-Queue verwaltet.

## Was wird durch die V-Operation bei Semaphoren erreicht und wie interagiert sie mit der Wait-Queue? 
Die V-Operation (up) inkrementiert die Kontrollvariable s. Bei passivem Warten wird, falls die Wait-Queue nicht leer ist, ein Prozess aus der Queue in den Zustand rechenbereit überführt.

## Beschreibe, wie Semaphoren zur Realisierung kritischer Abschnitte genutzt werden.
Semaphoren werden verwendet, indem ein Semaphor-Objekt definiert und seine Kontrollvariable initialisiert wird. Kritische Abschnitte werden dann mit P- und V-Operationsaufrufen geklammert, um wechselseitigen Ausschluss zu gewährleisten.

## Wie wird das Erzeuger-Verbraucher-Problem unter Verwendung von Semaphoren korrekt gelöst?
Zur Lösung werden zwei zusätzliche Semaphore verwendet: "voll", initialisiert mit 0, zählt die Elemente im Puffer, und "leer", initialisiert mit der Anzahl der Pufferplätze, zählt die freien Pufferplätze. Der Producer und Consumer nutzen diese Semaphore, um den Zugriff auf den Puffer zu synchronisieren.

# Warum reicht bei dem Erzeuger-Verbraucher-Problem nicht ein einziges Semaphor?

## Was ist das Monitor-Konzept?
- Ziel: Abstrahieren von Semaphoren und Integrierung in Datenstrukturen
- Vermeiden von Problemen, wie
  - vertauschen der Operationen P und V
  - vergessen der zu einer P- zugehörigen V-Operation
- Beispiel: Methoden *Produce* und *Consume* auf gekapselten Puffer

## Warum sind Mutexe != binäre Semaphore?
- Mutexe haben einen **Owner**, Semaphore haben **keine** Owner.
- Mutexe sind Locks: Sie realisieren mutual exclusion und können vor Races schützen.
- Semaphore dienen zum Synchronisieren von Aktionen: z.B. im Producer-Consumer Problem modellieren sie die Anzahl der vollen bzw. leeren Plätze im Puffer.

## Was ist das "Speisende Philosophen" Problem?

## Was sind die Takeaways vom "Speisenden Philosophen" Problem?
- Kritische Abschnitte so kurz wie möglich halten, da unser Programm sonst zu einem sequentiellen Ablauf degeneriert.
- Es kann immer nur ein Philosoph gleichzeitig essen.
- Ressourcen erst belegen, wenn alle verfügbar sind.

## Nenne die vier Bedingung für Deadlocks.
1. **Exklusiv** nutzbare Ressource (Mutual Exclusion)
2. **Belegen und Anfordern** (Hold-and-wait)
3. **Nicht Entziehbar** (no-preemption)
4. **Zyklische Wartebedingung** (Circular wait): zyklische Kette von min. zwei Prozessen, die jeweils auf eine Ressource warten, die vom nächsten Prozess in der Kette belegt ist.

Es müssen alle vier Bedingungen erfüllt sein, damit ein Deadlock auftreten kann.

## Wie können Deadlocks modelliert werden?
Die vier Deadlock Bedingungen können durch einen gerichteten Graphen, den **Belegungsanforderungsgraphen**, modelliert werden.
- **Knoten**: Prozesse (Kreise) und Ressourcen (Quadrate)
- **Kanten**
  - Prozess A belegt Ressource R: gerichtete Kante *von R zu A*
  - Prozess A fordert Ressource R an: gerichtete Kante *von A zu R*

## Nenne die vier Strategien zum Umgang mit Deadlocks.
1. **Ignorieren**: Vogel-Strauß Methode, wird in BS häufig gemacht z.B. Verwaltung der Prozesstabelle im Linux Kernel.
2. **Deadlock-Detection** (Erkennung): Das BS erkennt und beseitigt Deadlocks, falls sie auftreten sollten
3. **Deadlock-Prevention** (Verhinderung): BS setzt eine der Deadlock-Bedingungen außer Kraft
4. **Deadlock-Avoidance** (Vermeidung): BS führt **keine** Ressourcenzuteilung durch, die potentiell in einem Deadlock enden könnte

## Wann kann das Ignorieren eines Deadlocks sinnvoll sein?
Wenn Prozesse neugestartet werden können, oder die Kosten für die Erkennung zu hoch sind.

## Was sind mögliche Probleme bei der Deadlock Erkennung?
Komplexität, höhere CPU Nutzung und Execution delay.

## Was ist ein Problem bei der Vermeidung von Deadlocks?
- Geringerer Durchsatz
- Komplexität
- Schlechte Skalierbarkeit

## Vorteil und Nachteil des Bankiers-Algorithmus zur Vermeidung von Deadlocks.
- Vorteil: Kein Ressourcen Entzug
- Nachteil: Zukünftiger Bedarf muss bekannt sein

## Vorteil und Nachteil zur Verhinderung von Deadlocks mittels fester Reihenfolge bei Zuteilung.
- Vorteil: Keine Laufzeitprüfungen
- Nachteil: Statisch, inflexibel

## Vorteil und Nachteil bei Erkennung von Deadlocks mittels periodischen Aufrufen:
- Vorteil: Interaktive Reaktion
- Nachteil: Verlust durch Abbruch