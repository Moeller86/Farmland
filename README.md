# FarmLand

Gårdsimulator i 90'er-stil, inspireret af SimFarm (Maxis, 1993). Spil alene eller sammen med 1–3 venner over LAN. Al grafik er original og tegnes i kode.

**Version 1.29.0** – versionen står i hovedmenuen (nederst til højre) og i vinduets titel. Se *Versionshistorik* nederst.

## Kom i gang

```
pip install pygame
python farmland.py
```

Bruger du den nyeste Python (3.14), så skriv `pip install pygame-ce` i stedet – pygame findes endnu ikke som færdig pakke til den, og spillet kører lige så godt med pygame-ce.

- **Singleplayer:** *Nyt spil* eller *Fortsæt* under Singleplayer.
- **Multiplayer – vært:** *Vær vært*. Andre finder spillet automatisk på LAN'et eller skriver din IP (vises øverst til højre).
- **Multiplayer – deltag:** *Deltag i et spil på netværket*.
- **Dedikeret server** uden grafik: `python farmland.py --dedicated` (`--load` fortsætter det gemte multiplayer-spil).
- **Hvis spillet går ned**, skrives fejlen i `farmland_fejl.txt` ved siden af spillet, spillet gemmes, og på Windows kommer en besked frem. Fejl i simulationen (hvor spillet kører videre) skrives også i filen. Send den gerne med, når du melder en fejl – den fortæller også versionen.
- **Gemte spil:** det forrige gem ligges som reserve (`.bak`). Er et gemt spil blevet ødelagt (fx ved strømsvigt), indlæses reserven automatisk. Desuden lægges en **sikkerhedskopi i mappen `backup`** højst hvert 20. minut (de 5 nyeste gemmes).
- **Version:** står nederst til højre i startmenuen.
- **Indstillinger i hovedmenuen:** knappen *Indstillinger* ved siden af *Afslut* har to faner: **Indstillinger** (vejreffekter, skel, ½ tempo, lyd, menufarve og skrift) og **Grafik** (klassisk eller pixel for køretøjer, bygninger, veje, dyr og træer). Så kan alt vælges, før spillet starter. Under *Nye spil* vælger du også vejr og skader (tørke, storme, ukrudt …) og årets længde, som nye spil starter med. De hører derefter til det enkelte spil og kan ændres i spillet under F1 › Indstillinger.
- **Gem i multiplayer:** spillet ligger hos værten og gemmes dér – automatisk hvert 5. minut, når værten forlader spillet, og med F5 / *Gem spillet*. Medspillere kan også trykke F5 eller *Gem spillet*: så beder de værten om at gemme, og alle får beskeden *Spillet er gemt*. Med *Fortsæt som vært* indlæses det gemte spil, og når vennerne melder sig ind med samme navn som før, får de deres egen gård tilbage.

### Installationsprogram til vennerne (FarmLand-Setup.exe)

1. Installer Python 3 fra python.org (sæt flueben i *Add python.exe to PATH*).
2. Læg `farmland.py`, `farmland.iss`, `byg_installer.bat` og `README.md` i samme mappe, og **dobbeltklik på `byg_installer.bat`**.
3. Filen bygger spillet og pakker det med det gratis **Inno Setup**. Mangler Inno Setup, prøver den at hente det med *winget* – ellers åbner den siden jrsoftware.org/isdl.php, hvor du henter det, og så kører du filen igen.
4. Til sidst åbner mappen `dist` med **FarmLand-Setup-1.17.0.exe** (versionen står i navnet). Send den fil til vennerne.

Vennerne dobbeltklikker på filen og følger guiden (på dansk). De behøver hverken Python eller administratorrettigheder: spillet lægges som standard i `%LOCALAPPDATA%\Programs\FarmLand` med genvej i Start-menuen og, hvis de vil, på skrivebordet. Det kan afinstalleres under *Indstillinger › Apps*. En ny version installeres bare oven i den gamle – gemte spil og indstillinger bliver liggende, også ved afinstallation. Vælger man at installere for alle brugere (kræver administrator), åbnes Windows Firewall for multiplayer med det samme; ellers spørger Windows første gang, man er vært – svar *Tillad*. Windows SmartScreen kan advare om en ukendt app – vælg *Flere oplysninger › Kør alligevel*. Husk, at alle skal have samme version for at spille sammen.

### Lav en Windows-fil (FarmLand.exe)

1. Installer Python 3 fra python.org (sæt flueben i *Add python.exe to PATH*).
2. Læg `farmland.py`, `byg_exe.bat` og `README.md` i samme mappe, og **dobbeltklik på `byg_exe.bat`**.
3. Efter et par minutter åbner mappen `dist` med **FarmLand.exe** (én fil med traktor-ikon). Den kan kopieres hen, hvor du vil – også til en ven, der ikke har Python.

Gemte spil, indstillinger, backup og fejllog lægges ved siden af FarmLand.exe. Ligger den et sted, hvor man ikke må skrive (fx *Programmer*), bruges `%APPDATA%\FarmLand` i stedet. Første opstart tager et par sekunder, fordi exe-filen pakker sig ud. Windows SmartScreen kan advare om en ukendt app første gang – vælg *Flere oplysninger › Kør alligevel*.
- **Ydelse:** jorden tegnes i færdige stykker på 8×8 felter, der genbruges, indtil noget ændrer sig, og tekster og sprites genbruges. Når man zoomer ud, bages skovens træer med ind i stykkerne – det gør det langt hurtigere at se hele kortet. Billederne konverteres til skærmens format, jordstykkerne tegnes som hurtige farvenøgle-billeder, de mørke slør bag vinduer genbruges, og jordstykkerne må fylde ca. 140 MB hukommelse (lidt mere på store skærme som QHD, højst 300 MB). Når mange stykker skal tegnes om på én gang (fx en ny dag eller vintersne), fordeles arbejdet over nogle billeder, så spillet ikke hakker, og når der er tid til overs, tegnes stykkerne lige uden for skærmen på forhånd. Vejret (regn, tåge, sne og farvetone) lægges på med hurtige blandinger, der også holder på store skærme, og vejfindingen er dobbelt så hurtig.

## Sådan fungerer gården

- **Ét stort kort** (72 × 72 felter) med skove, søer, hovedveje og én by i midten.
- Du starter et **tilfældigt sted** med en grund på 12 × 12 felter græs, et stuehus, et maskinhus og én traktor – den billigste på markedet, en gammel Lanse Bulldog. Der er ingen pløjet mark og kun en kort grussti fra stuehuset til maskinhuset – du lægger selv markerne og vejene, som du vil have dem.
- **Køb jord** op ad din egen grund (300 kr/felt, sø 150 kr) for at udvide.
- **Traktorerne gør markarbejdet:** træk et område med Pløj, Så, Høst eller Sprøjt, så kører traktoren ud og arbejder felt for felt. Opgaver i kø vises med gule rammer, og sprøjtning og høst prioriteres først. Flere traktorer giver hurtigere arbejde (maskinhuset har plads til 2).
- **Byg og køb (B):** et katalog med fire kategorier – bygninger, maskiner, udstyr og dyr. Blad med pilene, se billede, pris og beskrivelse, og køb eller placér på kortet.
- **Maskiner:** 14 traktorer, 2 mejetærskere, 5 lastbiler og 3 biler fra fiktive fabrikanter (Hjort, Cassel, Fendel, Fordal, Fiora, Masse-Fergus, Valmo, Klaas, Kubo, Lanse, Skandia og Merkur). Traktorerne har seks forskellige udseender: **veteran** med åbent førersæde og styrtbøjle, **kompakt**, **klassisk**, **moderne** med lang motorhjelm, stor glaskabine og rotorblink, **knækstyret firehjulstrækker** med tvillinghjul hele vejen rundt og **bæltetraktor**, der kører hurtigere i terræn. Lastbilerne findes som **frontstyret**, **snudebil** og **sættevogn**, og der er en **pickup** blandt bilerne. Kataloget viser typen og er sorteret efter pris. Hver model har hestekræfter, topfart på vej, arbejdsfart i marken, pålidelighed og driftsomkostning – som i OpenTTD. En dyr traktor arbejder hurtigere og går sjældnere i stykker, men koster mere i drift. Går en maskine i stykker, står den på værksted i nogle dage. De største modeller kommer først på markedet efter et par år. Maskinerne har mærkets farver og en lille prik i ejerens farve. Navne og farver står øverst i koden (`MAKERS` og `VEHICLES`), så de kan ændres. Et maskinhus har 6 båse (stort: 12) til maskiner, redskaber og vogne – se *Maskinhuse, båse og redskaber* nedenfor. Gård-fanen viser alle dine maskiner med *Vis* og *Styr*. Har du flere traktorer, tager den **bedste ledige** (mest trækkraft, fart og opgraderinger, mindst slid) altid markopgaven først.
- **Høst med mejetærsker:** traktorerne høster ikke. Har du en mejetærsker, høster den. Har du ingen, sender **maskinstationen** en gul mejetærsker med fører ud fra byen, når du trækker Høst over en mark (25 kr pr. felt, fører og diesel inkl.), og den kører hjem igen, når høsten er i hus.
- **Maskiner uden tag over hovedet:** er der ikke plads i maskinhusene, bliver nye maskiner ikke afvist – de holder udenfor ved stuehuset og slides af vind og vejr (mest i regn, sne og storm). River du et maskinhus ned, flytter maskinerne ud i stedet for at blive solgt, og de kører selv ind, når du bygger et nyt. Har du slet intet maskinhus, koster udstyr og vogne, der står ude, lidt i reparationer hver måned.
- **Vejene først:** maskinerne kører ad veje, så langt de kan, og tager kun turen over græs og marker, når der ikke er nogen vej.
- **Flere traktorer:** har du flere traktorer, arbejder de på hver sin mark – én maskine pr. mark. Trækker du Pløj eller Så over to adskilte marker, tager to traktorer hver sin.
- **Mælkebilen:** mejeriets blå tankbil henter selv mælken hver 10. dag og kører den til **Mejeriet** uden for byen. Kan slås fra under Gård › Dyr, hvis du hellere vil sælge mælken selv.
- **Slagteriet og Mejeriet** ligger lige uden for byen ved hovedvejen. **Kør selv og få 8 % mere:** har du en **kreaturvogn** eller **kreaturbil**, går solgte slagtesvin ikke direkte til slagteriet – læs dem op ved gården (hold stille ved stalden), kør til slagteriet og hold stille. Har du en **mælketankvogn** (ny vogn, 6.000 kr, 600 liter), gælder det samme for mælken og mejeriet. Maskiner, der kører selv (eller har en medhjælper), gør det automatisk. Kører du det ikke ud inden 4 dage, henter slagteriet/mejeriet det selv til den normale pris. Hold musen over bygningerne for at se, hvad de køber.
- **Lyd:** regn, vind og torden, fugle om foråret og sommeren, køer, dieselmotorer (der skifter tone med farten, når du selv kører), knapper og kasseapparat ved salg. Alle lyde laves i koden – der er ingen lydfiler. Lydstyrken vælges under **F1 › Vejr og indstillinger › Skærm**.
- **Styr selv:** højreklik på en traktor og vælg *Styr selv*. **Op/W giver gas, Ned/S bremser og bakker, Venstre/Højre drejer rattet** – som set på skærmen. Traktoren kører i et roligt tempo, ruller lidt ud, når du slipper gassen, og kører hurtigere på vej end i mark og skov. Kameraet følger med. Traktoren bruger det redskab, der er **koblet på** (hent det i maskinhuset og tryk K). Tryk **L** (eller *Sænk* nederst) for at sænke det og kør hen over dine marker – hvert felt, du kører over, bliver behandlet. **L** igen løfter det. Med gødningssprederen vælger du *Gødning* eller *Kalk*, med såmaskinen afgrøden. Mejetærskeren sænker sit skærebord på samme måde. Esc giver traktoren tilbage til de automatiske opgaver. Slipper du rattet, når traktoren peger nogenlunde langs vejene, retter den sig selv ind og kører lige. Kører du ind i noget, glider den langs i stedet for at stoppe brat.
- **Udstyr og leje:** som i SimFarm lejer maskinerne plov, såmaskine og marksprøjte, hvis du ikke selv ejer dem (plov 12, såmaskine 10, sprøjte 8 og gødning 8 kr pr. felt oven i arbejdsprisen). Køb eget udstyr i kataloget for at slippe for lejen. De store udgaver (stor plov, bred såmaskine, stor marksprøjte) gør også arbejdet hurtigere, og et bredt skærebord gør din egen mejetærsker hurtigere.
- **Veje:** grusvej (40 kr/felt) og asfaltvej (120 kr/felt, med hvid stiplet midterstribe) bygges ved at trække en linje – også uden for din egen jord. Køretøjerne kører ad vejene ud til markerne og undgår at køre over afgrøder, skov og grøfter.
- **Vanding med grøfter:** grav grøfter (50 kr/felt) fra en sø eller en brønd (2.000 kr). Vandførende grøfter er blå og holder marker inden for 6 felter fugtige (til hver side af grøften). Tørre grøfter er brune. Du kan bygge en grus- eller asfaltvej hen over en grøft – så lægges der rør (+150 kr pr. felt), og vandet løber videre under vejen (op til 3 felter bred vej). Rørenes ender ses i vejkanten.
- **Grav en sø** (værktøjet *Grav sø*, 400 kr pr. felt, mindst 2×2 felter) på græs, stub eller tom mark på din egen jord. Den virker som en naturlig sø: grøfter kan hente vand i den, markerne lige omkring holder bedre på fugten, og du kan fiske i den (F), når du kører forbi. Skal du kun bruge vand til grøfterne, er en brønd (2.000 kr) ofte billigere.
- **Fyld en sø op** med *Ryd* (600 kr pr. felt – der skal køres jord til). Det virker på søer på din egen jord, også de naturlige. Den opfyldte jord er mager (lav næring og kalk), så den skal gødes og kalkes et par gange, før den giver fuld høst. Mens du trækker, advarer spillet, hvis grøfter får vand fra søen og vil tørre ud.
- **Bygninger:** maskinhus (2×2, 6 båse), stort maskinhus (4×2, 12 båse), kostald (2×2, 10 køer), stor kostald (4×2, 25 køer), svinestald (2×2, 20 grise), stor svinestald (4×2, 50 grise), hønsehus (2×1), fårestald (2×1), hestestald (2×2), plansilo, biogasanlæg (2×2), kornsilo og brønd. Tryk **R** for at dreje en bygning, før du placerer den. Højreklik på stalde, maskinhuse og siloer for at se indholdet. Ryd et hvilket som helst felt af en bygning for at rive hele bygningen ned.
- **Fold og hegn:** køer skal have en fold med hegn, der rører kostalden – 1 felt pr. ko (60 kr/felt). Træk et område med *Fold og hegn*, så sættes hegnet automatisk rundt om kanten. Køerne går ude i folden og æder kun halvt så meget foder fra marts til oktober, når de græsser.
- **Stuehus og tilbygninger:** højreklik på stuehuset. Vælg et nyt **design** – *stort stuehus*, *stråtækt længehus* (2×1, bindingsværk og stråtag, +3 prestige), *tolænget gård* (stuehus og lade i vinkel, 3×2, +3), *moderne landhus* (sort træ og glas, +3), *trelænget gård* (klassisk dansk gård med stuehus, lade og stald om en brolagt gårdsplads, 3×3 felter, +4), *herregård* (+5) eller *firlænget gård* (fire længer om en lukket gårdsplads med portlænge, 4×4 felter, 95.000 kr, +7) – aflange gårde drejes med R – og **placér det selv** med musen, hvor du vil på din jord (det gamle stuehus rives ned og bliver til gårdsplads). Tilføj garage (hvidkalket med rødt tegltag og ledhejseport, plads til 1 bil), **dobbeltgarage** (2×1 felter, to porte, plads til 2 biler, +1 prestige – bilerne kører ind og holder i garagen – **højreklik på garagen** for at se, hvilke biler der står der, og køre en tur med *Styr selv*), anneks (+300 kr husleje om måneden), springvand, pool, gårdbutik og tennisbane – dem placerer du også selv, og de kan **flyttes** bagefter med knappen *Flyt* ud for tilbygningen i stuehusvinduet (15% af prisen, R drejer). Det giver prestige: +1% på alle salgspriser pr. point (højst +10%).
- **Bil:** byg en garage og køb en bil i kataloget. Højreklik på bilen og vælg *Styr selv* for at køre en tur til byen. Der hører du nyt om markedspriserne og sælger lidt på torvet (én gang om måneden).
- **Liv i byen:** små biler og pickupper kører rundt på byens veje – flere, jo større byen bliver.
- **Banken:** tryk *Banken – lån og afdrag* under fanen *Gård*. Du kan have **3 lån ad gangen** (5.000, 10.000 eller 20.000 kr) og låne **højst 30.000 kr pr. spilår**. Hvert lån betales automatisk tilbage med en rate hver måned i 12 måneder, plus 8 % rente om året af restgælden – raterne står i månedens udgifter. Når et lån er betalt ud, eller du indfrier det før tid (knappen *Indfri*), bliver pladsen ledig, og du kan låne igen. Lån fra ældre gemte spil bliver til ét lån, der betales af over et år.
- **Driftsleder:** ansæt en driftsleder under fanen *Råd* (1.500 kr om måneden). Han kigger løbende gården igennem og giver konkrete råd om høst, skadedyr, tørke, såtid, lager, priser, udstyr og lån – både i fanen og i loggen hver måned.
- **Vejr og indstillinger (F1):** slå tørkeperioder, storme, frostskader, skader fra vandmangel, skadedyr og ukrudt til eller fra hver for sig.
- **Transport af høst:** høsten lægges i en markbunke ude på marken og skal køres i hus. En ledig traktor med **tipvogn** (450 enheder) eller en **kornbil** kører selv mellem mark og silo – med synligt læs. Har du ingen transport, kommer **vognmanden** i en hvid lastbil fra byen og kører det for dig (1,20 kr pr. enhed). Høst, der bliver liggende, tager skade af regn, og lageret sætter grænsen for, hvor meget der kan køres hjem.
- **Store vogne** (Byg og køb › Udstyr): hver vogn findes også i en stor udgave på tandemaksel – **stor tipvogn** (900 enheder, 9.500 kr), **stor ballevogn** (24 baller i 3 lag med høj forhæk, 7.500 kr), **stor kreaturvogn** (16 dyreenheder, 8.500 kr) og **stor mælketankvogn** (1.200 liter, 11.000 kr). De tager dobbelt så meget pr. tur (ballevognen halvanden gang), men **kræver en traktor på mindst 100 hk**. Maskiner, der kører selv, tager den store vogn, når traktoren er stærk nok – ellers den almindelige. Trykker du K ved flere vogne, kobles den på, din traktor kan trække.
- **Halmballer:** med ballepresser bliver halmen liggende som rundballer på stubmarken, og en mark med baller kan først pløjes, når de er kørt hjem. Ballerne skal **løftes op med en frontlæsser** – en opgradering på traktoren (højreklik › *Opgrader*, 6.500 kr). Frontlæsseren bærer **2 baller oven på hinanden** (med balleklo 4: to stakke ved siden af hinanden).
  - **Tre slags halmballer** – den presser, du har, bestemmer formen (har du flere, bruges den nyeste; vælg en anden med *Brug denne* i butikken):
    - **Ballepresser** (9.000 kr): rundballer, 8 enheder pr. balle.
    - **Småballepresser** (5.500 kr): små firkantede baller, der samles i pakker – 6 enheder pr. pakke. Billig, men lidt mindre pr. tur.
    - **Bigballepresser** (14.000 kr): store firkantede bigballer, 12 enheder pr. balle – halvanden gang så meget pr. tur som rundballer.
    Frontlæsseren tager 2 baller (pakker) ad gangen og ballevognen 16 (den store 24), uanset formen – så bigballer giver færre ture. Ballerne har hver deres udseende på marken, i læsseren, på vognen og på ballepladsen. Der kan kun være én slags halmballer på samme vogn (wrapballer kan blandes med).
  - **Ballevognen** (Byg og køb › Udstyr, 4.500 kr): en lang fladvogn til **16 rundballer i 2 lag**. Ballerne stables af sig selv i fast rækkefølge – forfra og bagud, to ved siden af hinanden, først nederste lag og så øverste – så du kan se på vognen, hvor mange der er på, og hvornår den er fuld.
  - **Når du selv kører:** kør ballevognen ud på marken og kobl den af (K) – eller lad den sidde på en anden traktor, der holder stille. Tag traktoren med frontlæsser: kør hen til ballerne, **sænk (E)** og **hæv (E)**, så løfter den 2 baller. **Kør helt frem til vognen** – så læsses ballerne af og stables af sig selv (du skal ikke trykke). Panelet viser fx *9/16 baller*. Når vognen er fuld, kobler du den på (K), kører hjem til ballepladsen (eller stalden) og holder stille – så læsses den af. Du kan også køre ballerne direkte hjem i læsseren og sænke (E) ved ballepladsen. Vognen beholder sit læs, når den kobles af.
  - **Ballepladsen** viser stakkene i fast rækkefølge: halmballerne stables stak for stak (3 lag) fra den ene ende af pladsen og wrapballerne fra den anden, så man kan se, hvor fuld den er. Højreklik viser antallet af baller.
  - Maskiner, der kører selv, samler ballerne op med frontlæsser og helst ballevognen (ellers tipvognen). Ballevognen kører kun baller – ikke korn fra markbunken. Har du ingen frontlæsser, kommer vognmanden med sin kranbil og tager dem mod betaling. Tipvognen kan stadig tage baller som før.
- **Salg og køb af afgrøder:** korn, ensilage og halm handles med **grovvarehandlen** i byen (højreklik på den for at se dine ordrer). Når du sælger, er prisen fast, men varen skal køres ind til byen – af din egen tipvogn eller kornbil, eller vognmanden henter den for 0,50 kr pr. enhed (han tager også over, hvis din egen transport ikke har haft tid i 4 dage). Pengene kommer, når læsset er leveret. Købte varer kører grovvarehandlens lastbil ud til gården. Mælk, æg og slagtesvin hentes stadig direkte af mejeriet og slagteriet.
- **Indkøb og lager** (Marked › *Indkøb og lager*): køb **kunstgødning** og **sprøjtemiddel** (pr. felt) og **såsæd** (i kroner) ind på lager. Priserne følger sæsonen – billigst om vinteren, dyrest i forårstravlheden – og grovvarehandlen har jævnligt **tilbud** på 15–30% i 10–20 dage (står i loggen, på Marked-knappen og hos driftslederen). Maskinerne bruger af lageret, når de gøder, sprøjter og sår. Er lageret tomt, købes der på stedet til dagspris + 10%. Samme side viser hele gårdens beholdning: gødning, sprøjtemiddel, såsæd, gylle, korn, ensilage, halm og dieselprisen.
- **Plansilo:** ensilage (kløvergræs og majsensilage) ligger i en **plansilo** (2.000 enheder pr. plansilo) – uden plansilo kan der ligge 1.000 i en stak ved gården. Korn, raps, kartofler og halm ligger i kornlageret.
- **Majsensilage:** under *Dyr* på Gård-fanen vælger du, om majsen høstes som **kernemajs** (til kornlageret, god at sælge) eller som **majsensilage** (hele planten hakkes og køres i plansiloen). Majsensilage giver dobbelt så mange enheder pr. felt, men er mest værd som foder. Køer, der får både græs- og majsensilage (mindst 1/5 af hver), giver **5% mere mælk** oven i bonussen for blandet foder.
- **Veje til hovedvejen:** grusvej og asfalt kan bygges på jord, som ingen ejer, så du kan lave en vej fra gården ud til hovedvejen. Det gør alle transporter meget hurtigere.
- **Transport af dyr:** dyr købes og sælges på **kvægtorvet** i byen og skal køres dertil eller derfra med **kreaturvogn** (bag en traktor) eller **kreaturbil**. Uden egen transport kommer vognmanden med en kreaturbil og kører dem for et gebyr pr. dyr. Højreklik på kvægtorvet for at se priser og leverancer.
- **Lastbiler og vogne** findes i kataloget under *Lastbiler* og *Udstyr*. Lastbiler er hurtige på vej, men langsomme i terræn; vogne kræver ingen plads i maskinhuset.
- Høsten skal kunne være i **kornlageret** – ellers bliver den liggende i marken.
- **Jorden:** hvert felt har næring og ukrudt. Høst udpiner jorden (mest majs og kartofler), og dyrker man samme afgrøde to år i træk, giver det 15% mindre – skifter man afgrøde (sædskifte), giver det 8% mere. **Gød** med traktoren: gylle fra staldene er gratis, ellers bruges kunstgødning (ca. 20 kr/felt). Ukrudt vokser i sæsonen og kan tage op til 40% af høsten – **Sprøjt** fjerner det, og pløjning og såning mindsker det. Holder du musen over en mark, ser du næring, ukrudt, sidste afgrøde og forventet udbytte. **M** skifter mellem kort over fugt, næring og ukrudt.
- **Afgrøder:** vårhvede, vårbyg, majs, kartofler og jordbær sås om foråret. **Vintersæd** – vinterraps (aug–sep), vinterhvede og vinterbyg (sep–okt) – sås efter høst, overvintrer og høstes næste sommer, og giver mere end vårsæd. **Efterafgrøde** (jul–sep) sås på de høstede marker, høstes ikke, men dækker jorden over vinteren, samler næring og kvæler ukrudt – pløj den ned i foråret. Kløvergræs står i flere år. Byg er en ny vare på markedet (Malteriet køber også byg).
- **Årshjulet** (fanen *Råd*): hvad der sker på gården måned for måned – fra planlægning og regnskab i januar over såning, sprøjtning og høst til vintersæd og efterårsarbejde. Hold musen over en måned for at se den. Hver ny måned står årstidens arbejde også i loggen.
- **Vinterservice:** i december–februar koster service det halve, og værkstedet tager også de let slidte maskiner (fra 20% slid).
- **Høsttider:** tørke går nu mest ud over sundheden og dermed udbyttet, ikke over væksten, så høsten kommer til den tid, der står ved såningen (± et par uger). Vinterbyg og vinterraps er klar i juli, vinterhvede, vårbyg og vårhvede i juli–august, kartofler i august og majs i september – så der er tid til at pløje og så vintersæd bagefter.
- **Overmoden afgrøde:** en moden mark kan stå ca. 45 dage uden at tabe sig. Derefter falder udbyttet langsomt (du får besked), og først efter ca. 100 dage er den visnet.
- **Markarbejdet går hurtigt:** en traktor pløjer eller sår en mark på ca. 60 felter på 1–1½ uge, og en mejetærsker høster endnu hurtigere. Mens du trækker med et værktøj, står antal felter og prisen ved musen – også når du køber jord.
- **Hele marken på én gang:** et sammenhængende stykke mark med samme afgrøde, der er sået omtrent samtidig, vokser i takt og bliver moden samme dag – også selvom traktoren har brugt nogle dage på at så den. Ukrudtet fordeler sig jævnt over marken. Sundheden er stadig pr. felt, så en plet med skadedyr eller tørke kan give mindre høst dér.
- **Stubmark:** efter høst står marken med stub og skal **pløjes**, før den kan sås igen. Hold musen over marken, eller se under Gård › Marker, hvor mange felter der venter. Driftslederen minder dig om det. Kløvergræs står stadig i flere år og skal ikke pløjes mellem slættene.
- **Såtid og høst:** når du vælger afgrøde til *Så*, står der hvornår den kan sås, og hvornår den forventes klar til høst, hvis du sår i dag (fx "sås nu, klar til høst først i august"). Hold musen over en mark for at se forventet høst, og over en afgrøde under *Marked* for såtid, høsttid og hvor længe den kan stå moden.
- **Kløvergræs:** står i flere år og gror op igen efter hver slæt. Giver **ensilage** til køerne og bygger næring op i jorden. Pløjes det ned, får den næste afgrøde et skub.
- **Stor mejetærsker:** *Hjort S790* (78.000 kr, fra år 5) – en kæmpe moderne mejetærsker med 12 meters skærebord, næsten halvanden gang så hurtig som Lexion 480. Fylder en hel række i maskinhuset.
- **Rendegraver** (Småkøretøjer, 18.000 kr): gul rendegraver med frontskovl og gravearm. Har du en, koster **Grøft**, **Grav sø** og **Ryd** 40% mindre (beskeden viser, hvad du sparede), og frontskovlen løfter baller (E).
- **Læhegn:** under *Gårdhegn* kan du nu vælge **Læhegn** (60 kr pr. stykke) – en række buske og små træer langs skellet. Marker inden for 3 felter af et læhegn får læ: storm og tørke skader kun 60% så meget.
- **Kartofler:** med en **kartoffeloptager** (Byg og køb › Udstyr, 16.000 kr) tager dine traktorer selv kartoflerne op – uden leje til maskinstationen. Uden optager høster mejetærskeren (eller maskinstationen) dem, men knuser hver femte kartoffel (80% udbytte). Kører du selv: kobl optageren på og sænk den (L) i kartoffelmarken. Et **kartoffellager** (2×2, 9.000 kr, 1.500 enheder i kornlageret) er et kølelager: kartofler sælges 15% dyrere i januar–juni.
- **Stubharve** (Udstyr, 6.000 kr): et hurtigt alternativ til ploven på stubmark – dobbelt så hurtig og kun 3 kr pr. felt, men den fjerner ikke ukrudtet helt. Vælg *Pløj* og så *Stubharve* i boksen øverst (græs og døde afgrøder pløjes stadig), eller kobl den på, når du selv kører.
- **Malkerobot** (opgradering af kostalden – højreklik på den): 22.000 kr / 35.000 kr for en stor kostald, 20% mere mælk fra køerne i stalden.
- **Fodersilo** (1×1, 7.000 kr, 1.000 enheder i kornlageret): med en fodersilo fodres der efter en foderplan – dyrene får det billigste korn først (højreklik på siloen for at se rækkefølgen i dag), og grise og høns giver 10% mere med blandet kraftfoder.
- **Små opgaver på gården:** mug staldene ud med gummiged eller minilæsser (E ved stalddøren, +5% i 30 dage) · lap huller i hegnet efter storm fra en ATV, UTV eller terrænbil (O) · hjælp til ved kælvning og læmning om foråret (kør hen til dyret i folden inden for 3 dage – så får du et dyr mere). Det er alt sammen bonusser – springer du det over, går gården fint alligevel.
- **Økologisk produktion:** grise og høns kan gå på græs (knappen *Øko* i Gård-fanen) i en fold ved svinestalden eller hønsehuset – 4 grise eller 25 høns pr. foldfelt – og giver så 30% økotillæg på svinekød og æg (men 10% mindre ydelse og 15% mere foder).
- **Låger:** foldens hegn spærrer, når du selv kører. Klik på hegnet med *Fold og hegn* for at sætte en låge (150 kr – den første i hver fold følger med) eller åbne/lukke den; mens du kører, bruger du **O**. En åben låge med dyr i folden kan give et udbrud: dyret går rundt uden for lågen og giver intet, til du lukker lågen (eller det selv går hjem efter et par dage).
- **Baller i folden:** med en læsser kan du tage baller fra lageret ved ballepladsen (E) og sætte dem i en foderhæk i folden (E). Dyrene i folden yder 5% mere i 30 dage – én balle rækker til 20 køer eller heste (60 får). Wrapballer ædes samtidig som ensilage. Hækken tømmes langsomt, så man kan se, hvornår der skal en ny; Gård-fanen viser bonussen under *Trivsel*.
- **Rundbuehal** (3×2, buer af stål med dug over): byg den som **maskinhal** (5.000 kr, 4 rækker med 2 båse – flere båse for pengene end et maskinhus) eller som **halmlager** (4.500 kr, 1.000 enheder baller ud over ballepladsen – ballerne køres herhen, og stakkene ved porten viser, hvor fuld hallen er) eller som **foderhal** (4.500 kr, 1.500 enheder græs- og majsensilage oven i plansiloen – ensilagen ligger under tag, så der spildes 5% mindre, når køer, får og heste fodres; stakken under plasten vokser, når hallen fyldes). Højreklik for at bygge den om for 500 kr. Bliver en maskinhal til halmlager, holder maskinerne udenfor, hvis der ikke er plads i andre maskinhuse.
- **Større stalde og malkerobot:** **stort hønsehus** (3×2, 6.000 kr, 150 høns) og **stor fårestald** (3×2, 11.000 kr, 80 får) – billigere pr. dyr end de små. **Malkerobot** (1×1, 35.000 kr): køerne malkes efter behov og giver mere mælk (nu en opgradering af kostalden – se nedenfor).
- **Halm og gylle:** med en **ballepresser** giver hvede og raps også halm. Halm som strøelse får dyrene til at yde 15% mere, og køer på blandet foder (ensilage og korn) giver 20% mere mælk. Dyrene giver gylle, som løber af sig selv ned i fortanken under staldene (200) og videre i en **gylletank** (bygning, 1×1, 6.500 kr, 2.000 enheder pr. tank). Er der fuldt, går den nye gylle til spilde, og du får besked. Når du vælger **Gød**, vælger du øverst **Gylle** (gratis, 8 enheder pr. felt – kan kun vælges, når der er nok i tanken) eller **Kunstgødning**. Valget gælder dine egne maskiner og maskinstationen. Løber gyllen tør undervejs, bruges kunstgødning. Gyllen køres ud med en **gyllevogn** (Byg og køb › Udstyr, 7.500 kr) – uden egen gyllevogn lejes en for 6 kr pr. felt. **Gyllevogn med slæbeslanger** (12.500 kr) lægger gyllen ned ved jorden, så marken får 30% mere næring pr. felt. Kører du selv, bestemmer redskabet: gyllevognen kører gylle ud, gødningssprederen kunstgødning og kalk. **Sultne dyr giver intet:** får køer, høns, får eller grise ikke (næsten) alt det foder, de skal have, giver de ingen mælk, æg, uld eller tilvækst den dag – først når der er foder nok igen.
- **Opgaver (kontrakter):** naboer og byens virksomheder tilbyder opgaver – pløj, så, høst, gød eller sprøjt naboens mark med dine egne maskiner, eller lever varer til møllen, mejeriet, slagteriet osv. Tilbuddene er fælles i multiplayer: den første, der tager opgaven, får den. Højst 3 opgaver ad gangen.

## Nyt på egnen

- **Kalkning:** hvert felt har en kalktilstand, som falder langsomt (især når du gøder). Under 55 giver marken mindre – ned til 75% af normal høst. Træk **Kalk** over marken (kalk købes under *Indkøb og lager*, spredeudstyret lejes, hvis du ikke har en gødningsspreder). Det skal typisk gøres hvert 3.–4. år. **M** viser nu også et kalkkort, og driftslederen siger til, når marker bliver sure.
- **Skovbrug og savværk:** for at fælde skov skal du først have en **skovvogn med kran** (udstyr, 8.500 kr) og en **tømmerplads** ved gården (bygning, 2.500 kr, 5.000 enheder – flere pladser giver mere plads). **Fæld skov** (20 kr/felt) giver 25 enheder tømmer pr. felt, som lægges som en stak træstammer i skoven, køres direkte hen til tømmerpladsen (ikke til siloen) og stables synligt dér. Stammer og korn køres altid hver for sig – også når du selv kører. Tømmeret sælges til **savværket** i byen – som korn, med egen vogn eller vognmanden. Kører du selv, kobler du skovvognen på (K) og sænker den (L). Ældre gemte spil, der allerede havde tømmer, beholder deres plads og får skovvognen. **Plant skov** sætter små træer, der vokser i ca. 2½ år, før de kan fældes igen – hold musen over for at se hvor længe.
- **Frugtplantage:** æbler og pærer plantes i mar–apr eller november og giver frugt hvert år i sep–okt. Træerne blomstrer om foråret og tåler tørke, men frost i marts–april koster lidt. Frugten plukkes af en **traktor** (ikke mejetærskeren – 12 kr/felt i leje af plukkeudstyr) og sælges til Frugtpakkeriet. Pløj plantagen, hvis du vil af med den.
- **Biogasanlæg** (2×2, 40.000 kr): laver strøm af dagens gylle fra staldene og – hvis du vil – af overskydende ensilage ud over 30 dages foder. Strømmen sælges til nettet og står som *Strøm* i regnskabet. Højreklik på anlægget for at se produktionen og slå ensilage til eller fra.
- **Gårdbutik** (tilbygning til stuehuset, 8.000 kr): sælger lidt æg, mælk, jordbær, kartofler, æbler og pærer direkte til kunderne hver dag – 35% over markedsprisen. Jo flere veje tæt på gården, jo tættere på hovedvejen og jo større byen er, desto flere kunder (se *kunder %* ved stuehuset).
- **Får og heste:** **fårestald** (2×1, 30 får) giver uld, og fårene nøjes med ⅓ felt fold hver. **Hestestald** (2×2, 6 heste) er pensionsheste – ejerne betaler 7 kr om dagen pr. hest. Begge skal have fold ved stalden og æder ensilage eller korn som køerne (halvt om sommeren, når de græsser).
- **Egnens avis:** knappen *Avis* øverst viser egnens lokalavis med tilbud, tørke og storme, rekordhøster, nye maskiner, byens vækst og små lokale nyheder. Store nyheder åbner avisen af sig selv. Tallet på knappen er ulæste nyheder.
- **Årets gård:** hvert nytår kåres Årets gård blandt jer og tre af naboerne efter formue, høst og dyr. Vinderen får 5.000 kr og en pokal, som vises ved navnet under *Gård*. Resultatet står i avisen.
- **Marked:** listen over varer kan nu rulles med musehjulet, og varer du har på lager står øverst.

## Kortet: størrelse, egn, terræn og byen

Efter valgene under *Nyt spil* / *Vær vært* trykker du **Vælg kort ›** – lidt som i SimFarm, hvor man valgte egn og landskab:

- **Størrelse:** lille (56×56 felter), normal (72×72) eller stort (96×96). Et stort kort giver plads til at vokse og til flere naboer. Minikortet har samme størrelse, uanset kortet.
- **Egn** – hver egn har sit eget landskab, sin egen jord, sit eget vejr og sin egen jordpris:
  - *Blandet egn:* lidt af det hele (som hidtil).
  - *Vestjylland:* få søer, sandjord med lav næring og kalk, billig jord (210 kr/felt), meget blæst (vindmøllerne giver 35 % mere) og flere tørkesomre.
  - *Lolland-Falster:* flad, fed jord med høj næring og kalk, lidt skov og få søer – men jorden er dyr (380 kr/felt).
  - *Søhøjlandet:* bakket med mange søer og meget skov – godt for dyr, skovbrug og fiskeri; mindre tørke og mindre vind.
  - *Marsken:* flad og våd med mange små søer og god jord, meget regn, sjælden tørke og meget blæst. Om vinteren kan en **stormflod** oversvømme markerne langs søerne, så afgrøderne tager skade.
- **Byen ligger** i midten, ved kanten af kortet, ved en stor sø eller et tilfældigt sted. Hovedvejene går altid gennem byen og ud til kanten af kortet, og byens forretninger følger med.
- **Terræn: Fladt land eller Bakket terræn.** Fladt land er standard (som hidtil). Vælger du *Bakket terræn*, får kortet bløde bakker og dale som i Transport Tycoon/OpenTTD: hvert felt har en højde i sine fire hjørner, og to nabohjørner er højst ét trin fra hinanden, så et felt er enten fladt eller skråner ét trin. Skråningerne får lys og skygge, og vejene følger bakkerne.
  - Du kan stadig pløje, så, høste og køre overalt – også på skråningerne.
  - **Fugt:** bakketoppe tørrer hurtigere ud, og vandet samler sig i lavningerne. Det kan ses på fugtkortet.
  - **Fart:** maskinerne kører langsommere op ad bakke og lidt hurtigere ned ad bakke – både når de kører selv, og når du styrer.
  - **Bygninger står på fladt land:** når du bygger, jævnes jorden under bygningen, og omgivelserne følger med i en jævn skråning. Søer ligger altid fladt – graver du en sø, graves der ned til feltets laveste hjørne. Byen, traktortræk-pladsen, slagteriet og mejeriet ligger på fladt land.
  - Hvor bakket landet er, afhænger af egnen: Søhøjlandet er mest bakket, Lolland-Falster og Marsken næsten flade.
  - Minikortet viser højderne med lys og skygge. Gamle gemte spil er fladt land.
- **Forhåndsvisning:** et minikort viser landskabet, før du starter. **Nyt kort** slår et nyt op, og **kortnummeret** kan du skrive selv: samme nummer og samme valg giver præcis det samme kort, så du kan spille det igen eller dele det med en ven.
- Kortet gemmes med spillet. Gamle gemte spil fortsætter på det normale kort med byen i midten.
- Dedikeret server: `--kort=stor --egn=marsken --by=kant --terraen=bakket --kortnummer=48213` (alle frivillige).

## Spiltilstande

Når du trykker *Nyt spil* eller *Vær vært*, vælger du, hvordan I vil spille. Valget gemmes med spillet.

- **Farm Manager** (som i SimFarm): træk en opgave med Pløj, Så, Høst osv., så kører maskinerne selv ud og gør den. Du kan stadig tage rattet på en maskine med *Styr selv*, når du har lyst.
- **Manuel styring:** du er traktorfører og kører alle maskinerne selv. Når du trækker Pløj, Så osv., bliver det kun en **plan** med gule rammer på kortet, og felterne strøges af planen, efterhånden som du kører dem. **Tab** skifter til næste maskine, og højreklik › *Styr selv* vælger en bestemt.
  - **Læs op og af:** har traktoren en tipvogn (kobles på af sig selv), eller kører du en kornbil, læsses der op, når du **kører langsomt helt hen til markbunken** (vognen skal over bunken – du behøver ikke stoppe), og af, når vognen kører helt hen til lageret (siloen) eller ballepladsen. At holde stille i nærheden virker stadig. Solgte varer læsses op ved gården og leveres ved at holde stille ved grovvarehandlen eller savværket i byen – så får du pengene uden vognmandens gebyr. Et panel over kørepanelet viser, hvor meget du har på.
  - **Medhjælpere:** højreklik på en maskine og vælg *Ansæt medhjælper* (1.200 kr om måneden). Så kører den maskine selv dine planlagte opgaver og transporter, præcis som i *Farm Manager*.
  - **Hjælp udefra:** maskinstationen og vognmanden kan stadig hyres. Har du ingen mejetærsker, kommer maskinstationen, når du planlægger høst. Har du egen transport, venter vognmanden 4 dage, før han kører høsten eller dine salg mod betaling – så du kan nå det selv.
  - Traktoren kan plukke frugt i plantagen (tast 3), men korn skal høstes med en mejetærsker.
- **Startkapital** (vælges under *Økonomi* ved nyt spil): **25.000 kr** (standard, den klassiske udfordring) eller **45.000 kr** (lidt mere luft til den første maskine eller stald). Computernaboerne starter med det samme. Dedikeret server: `--45000`.
- **Sandkasse** (vælges under *Økonomi*, både i singleplayer og multiplayer): pengene slipper aldrig op, alle maskiner kan købes fra første dag, og der er ingen lån eller kåring af Årets gård. Alt andet – årstider, vejr, dyr, dyrskue og markarbejde – er som normalt, så man kan bygge og lege i fred. Valget gemmes med spillet.
- **½ tempo, når du kører:** sætter du dig bag rattet (*Styr selv*), går tiden ned på ½ tempo, så man kan nå at køre. Tab til næste maskine holder tempoet, og Esc stiller det tilbage til, hvad du kørte med før – medmindre du selv har skiftet tempo undervejs, så beholdes dit valg. I multiplayer bliver det din stemme i tempo-afstemningen. Kan slås fra under *Menu › Vejr og indstillinger*.
- **Småkøretøjer** (Byg og køb › Småkøretøjer): havetraktor (2.500 kr), ATV (3.500 kr), UTV med lad og styrtbøjle (5.000 kr), gaffeltruck (5.500 kr), minilæsser med skovl (7.000 kr), firehjulstrukket terrænbil (8.000 kr) og **gummiged** (12.500 kr). Gummigeden er en knækstyret læsser med lukket førerhus og skovl: den løfter baller som minilæsseren, og så længe du har en, spildes der mindre ved udfodringen – køer, får og heste klarer sig med 10% mindre grovfoder. De står i maskinhuset (1 bås) eller på fliserne og er til, når du selv kører: ATV'en, UTV'en og minilæsseren er hurtige i terræn og skov (godt til jagt og fisketure), terrænbilen er hurtig på vejen og kan køre ind til byen og høre nyt fra markedet ligesom bilen. **Gaffeltrucken og minilæsseren løfter halm- og wrapballer** med E, præcis som en traktor med frontlæsser: sænk ved ballerne, hæv for at tage dem op, kør helt frem til en vogn på marken (så læsses de af af sig selv) – eller sænk igen ved ballepladsen. De tager ikke andet markarbejde og kræver ingen garage.
- **Græsplæne** (værktøjet Græsplæne, 30 kr/felt): så plæne på græs eller tom mark på din jord. Græsset gror fra marts til oktober (hurtigst i forsommeren) og går fra nyslået med striber over halvlangt til groet til med totter og mælkebøtter. Havetraktoren har en klipper under bugen: kør selv og tryk **L** for at sænke den, så slås hvert felt, du kører over. Når du ikke selv kører (eller har en medhjælper på den), slår havetraktoren plænen en gang om ugen af sig selv. En velholdt plæne (mindst 4 felter) giver +1 prestige, en tilgroet giver −1.
- **Fliser:** værktøjet *Fliser* (80 kr pr. felt) lægger en flisebelagt plads – fx foran maskinhuset eller som parkeringsplads. Træk en firkant på græs, tom mark eller grusvej på din jord. Maskiner, der ikke er plads til i maskinhusene, parkerer helst på fliserne og **slides kun halvt så meget af vind og vejr** som på græsset. Redskaber og vogne, der står ude, stilles også helst på fliser. Maskinerne kører hurtigt på fliser (lidt hurtigere end grusvej). **Fast plads (lineup):** kører du selv (*Styr selv*), og holder stille på et flisefelt, parkerer **P** maskinen dér – den får sin faste plads og holder fremover på netop det felt og vender, som den gjorde, da du trykkede P. Så kan du stille alle gårdens maskiner op på række. Skal den ind igen, så kør den hen foran maskinhuset og tryk P. *Ryd* fjerner fliserne igen. Fliserne følger valget for *veje og pladser* under Grafik.
- **Gårdhegn:** værktøjet *Gårdhegn* sætter et stakit op langs en linje, du trækker – ligesom en vej (først vandret, så lodret). Hegnet sættes i **yderkanten**: på den side af linjen, der vender ud mod vejen, naboen eller jord, der ikke er din – og midt på din egen jord på siden væk fra stuehuset. Så kan du fx trække langs vejen og hele vejen rundt om gården. Vælg farve i den lille boks øverst: **hvid, sort eller træ**. Det koster 25 kr pr. stykke; hvor linjen går over en vej eller din grusvej, bliver der en låge. Træk samme linje igen i en anden farve for at male hegnet om (gratis), eller i samme farve for at tage det ned – *Ryd* fjerner det også. Hegnet er pynt og spærrer ikke for maskiner eller dyr.
- **Farve på menuerne:** under *Menu › Indstillinger* kan menuerne, panelerne, knapperne og vinduerne skiftes fra den brune farve til **grøn** eller **blå**. Kortet, tekst og guldfarvede overskrifter er uændrede. Valget gælder kun på din egen computer.
- **Skrift i menuerne:** *Skarp* (standard) bruger en skrift lavet til skærme – Segoe UI eller Tahoma på Windows – i samme størrelse som før, så teksten i menuerne og fanerne (Gård, Marked, Opgaver …) står tydeligt. *Klassisk* er spillets gamle skrift. Vælges under *Menu › Indstillinger*.
- **Automatik** (Menu › Automatik, eller knappen øverst i fanen Opgaver): en oversigt over alt det, der kører af sig selv på din gård, med Til/Fra for hver: høst og varer med egne vogne, baller med frontlæsser, dyr og egen levering, mejeriets tankbil, vognmanden fra byen, maskinstationens mejetærsker, havetraktoren, vask, service – og **køb foder automatisk**, når det slipper op (15% over markedsprisen, slået fra fra start). Hold musen over en linje for at se, hvad der sker, når den er slået fra. Slår du fx egne vogne fra, kører du selv – eller vognmanden, hvis den er slået til. Gælder kun din egen gård; computernaboerne har alt slået til.
- **Årets længde:** under *F1 › Indstillinger* kan året gøres længere: *Normal*, *+20 %* (standard) eller *+50 %*. Dagene varer længere, og maskinerne – både dem, der kører selv, og den du styrer – når tilsvarende mere pr. dag, så der er bedre tid til at pløje, så og høste, før sæsonen er forbi. Afgrøderne gror stadig lige mange dage. Gælder for alle spillere i spillet.
- **Tekststørrelse:** under *Indstillinger › Skrift og tekststørrelse* kan teksten gøres større – 100 %, 115 %, 125 % eller 140 %. Det gælder menuen i højre side, avisen, beskederne i bunden, teksterne, når musen holdes over noget, panelet, når du selv kører (Styr selv), og vinduerne Årsrapport, Byg og køb, Banken og Maskinhuset (de bliver aldrig større end skærmen). Er der mere i en fane, end der er plads til, ruller du med musehjulet over menuen. Menuen i højre side bliver bredere med, så alt stadig er på plads. Godt på store skærme (fx QHD). Valget huskes på computeren.
- **Grafik (klassisk eller pixel):** i menuen (F1) har fanen **Grafik** et valg for hver del af spillet med et lille eksempel på begge udgaver: **køretøjer** (traktorer, redskaber, vogne, lastbiler, mejetærskere og bilerne i byen – bygget af små 3D-klodser, hjulene drejer, når de kører), **bygninger** (alle gårdens bygninger, tilbygninger og byens huse og projekter i klodsstil med kontur og skygge – balle- og tømmerpladsens stakke vokser stadig), **veje og pladser** (asfalt med kantsten og stiplet midterstribe, grusveje og byens fliser) **dyr** (køer, får, heste og vildtet som håndtegnede pixelfigurer) og **træer og skov** (gran og løvtræer af klodser i alle fire årstider – blomster om foråret, gule og røde blade om efteråret, bare kroner om vinteren og sne på grenene). Vindmøllernes vinger følger valget for bygninger. Du kan blande dem frit og skifte midt i spillet; valget gælder kun på din egen computer. Kort, marker og vand er altid klassiske. **Pixel er standard**, og nye ting tegnes fremover kun i pixel – vælger du klassisk, vises de i pixel.
- **Guidet første år** (vælges under *Vejledning*, slået til fra start – vælg *Uden vejledning*, hvis du kender spillet): et lille panel øverst til venstre på kortet fører dig gennem det første år med 12 små opgaver (13 med *Manuel styring*): pløj, så, gød, hold øje med skadedyr, høst, kør høsten hjem, sælg og så vintersæd. Værktøjet, du skal bruge, blinker gult i menuen. Hver opgave klares af sig selv, når du har gjort den, og giver et tilskud på 250 kr – når hele året er gennemført, får du 1.500 kr oveni. *Skjul* folder panelet sammen, *Spring* springer en opgave over, og *Stop* slår vejledningen fra. Fortryder du, eller startede du uden, slår knappen *Start vejledning* i menuen (F1) den til igen. I multiplayer har hver spiller sin egen vejledning.
- **Computernaboer** (vælges ved *Nyt spil* og *Vær vært*: ingen, 1, 2 eller 3 – i singleplayer er 2 valgt fra start): computerstyrede gårde i hver sit hjørne af kortet – de hjørner, der ligger længst fra din gård – hver med sin egen farve og sit navn over gården. Karen Kristensen dyrker mest korn og raps, Poul Nielsen har malkekøer og korn, og Grethe Pedersen har svin, høns og majs. De pløjer, sår, gøder, sprøjter og høster med deres egne maskiner (også med *Manuel styring*), bygger stalde og siloer, låner og afdrager i banken, køber maskiner og mere jord, når der er råd – og sælger på det **samme marked** som dig, så priserne kan falde, når de sælger meget. De er med i kåringen af Årets gård. Under fanen *Fælles* kan du se deres formue og lager og sende dem varer eller penge. I multiplayer tæller de ikke med i de 4 pladser til spillere og kan ikke overtages. De vælger drift efter egnen (fx flere køer i Søhøjlandet og mere korn på Lolland-Falster), stiller op til **dyrskuet** og **traktortrækket**, sælger vådt korn hurtigt, bygger vindmølle (især på blæsende egne), solceller og korntørreri, køber vandingsanlæg og sneplov og vander i tørke og rydder sne for kommunen, når de har råd. Dedikeret server: `--naboer=2`.
- **Hver sin gård** (multiplayer): hver spiller har sin egen gård, penge og maskiner.
- **Fælles gård** (multiplayer): 2–4 spillere driver én gård sammen – samme penge, jord, dyr og maskiner. Hver spiller kører sin egen maskine (man kan ikke tage en maskine, en anden kører), og navnet står over maskinen. Øverst står, hvem der er med. Kombinér gerne med *Manuel styring*, så én pløjer, mens en anden kører høsten hjem.
- **Glat kørsel over netværket:** når du selv styrer, beregner din egen computer bevægelsen med det samme, og værten kontrollerer den. De andre spilleres maskiner opdateres 20 gange i sekundet, så man kan se hinanden køre uden hak.
- Dedikeret server: `python farmland.py --dedicated --styr-selv --faelles --sandkasse --naboer=2` (alle valg er frivillige).

## Mudder, værksted, baller og markkort

- **Mudder:** maskinerne bliver synligt beskidte, når de arbejder eller kører i våde marker (i regn, eller når jorden er meget fugtig). Snavsede maskiner slides op til en tredjedel hurtigere, får færre point på dyrskuet, og kører en meget beskidt maskine mudder ud på landevejen, kan kommunen give en bøde. Højreklik på en maskine for at se snavs og driftstimer.
- **Vaskeplads** (bygning, 3.500 kr): kør selv hen på den og hold stille, så kører højtryksrenseren. Maskiner, der kører af sig selv (eller har en medhjælper), bliver vasket, når de holder hjemme – og en maskine kan også vaskes med *Vask* i dens vindue. Hver vask koster 20 kr i vand og sæbe.
- **Værksted** (bygning, 12.000 kr): køb **reservedele** (300 kr stk.) i værkstedets vindue. Går en maskine i stykker, reparerer du den selv på én dag med én reservedel i stedet for at vente tre dage på mekanikeren. Service bliver 40% billigere, og det er her, opgraderinger til maskinerne monteres.
- **Timetæller og servicebog:** hver maskine tæller sine driftstimer, og *Servicebog* i maskinens vindue viser de seneste vaske, service, reparationer og opgraderinger med dato og pris.
- **Wrapballer:** med en **wrappresser** (udstyr, 9.500 kr) bliver kløvergræsset presset til hvide wrapballer på marken i stedet for at ligge i en bunke. De samles op som halmballer (frontlæsser og tipvogn, eller vognmanden), kan ligge udenfor uden plansilo og er ensilage, som dyrene æder, når plansiloen er tom. De kan også sælges under Marked.
- **Balleplads** (bygning, 2×2, 3.000 kr, 1.200 baller): halm- og wrapballer køres hertil og stables synligt – stakkene vokser, efterhånden som pladsen fyldes. Uden balleplads er der plads til 300 baller i en stak ved gården. Halm ligger ikke længere i kornlageret.
- **Markkort (F3** eller *Markkort* under Gård › Marker): alle dine marker med størrelse, hvad der står nu, kalk, næring og ukrudt – og historik for de seneste år (afgrøde, høst og udbytte pr. felt). Giv markerne navne med *Omdøb*, så står navnet på kortet. *Vis* hopper hen til marken.

## Traktortræk

- Hvert år i **juli** kommer der en invitation til **traktortræk** (**8.–20. august**, startgebyr 300 kr). Svar under *Traktortræk*-knappen øverst.
- **Traktortræk-banen** ligger lige uden for byen ved en af hovedvejene: en grusparkering ved vejen, en jordbane med startstreg og en tribune med publikum og skilt. Mens trækket står på, hænger der flag langs tribunen, slæden venter ved startstregen, og naboernes og egnens traktorer holder på række på parkeringen (de to båse ved starten er holdt fri til jer). Kør din traktor ud på parkeringen eller banen og tryk **T**. Ældre gemte spil får banen, første gang de indlæses (er der ikke plads, bruges festpladsen ved kvægtorvet).
- **Kør selv** en traktor derhen (Styr selv) og tryk **T** (eller *Start*). Så begynder minispillet: hold **↑/W** (eller mellemrum) for at give gas, og hold nålen på omdrejningstælleren i det **grønne felt**. For lidt gas, og motoren går i stå – for meget, og hjulene spinder. Banen er ujævn, så nålen hopper.
- Slæden bliver tungere, jo længere den kommer. Hvor langt man kan nå, afhænger af traktorens trækkraft, **frontvægt**, **tvillinghjul**, **tuning** og slid – og af hvor godt du holder omdrejningerne. Hele vejen til 100 m er et **full pull**!
- Du har **2 forsøg**, det bedste tæller. Egnens andre landmænd er også med. Præmier: 4.000, 2.000 og 1.000 kr – og omtale i avisen.

## Egnens Dyrskue

- **Hvert år i maj** kommer en invitation til dyrskuet på kvægtorvet i byen (8.–15. juni, bedømmelse 13. juni). Tryk på **Dyrskue**-knappen øverst til højre: *Deltag* (standgebyr 500 kr), *Afslå* eller *Svar senere*. Du kan melde fra igen, indtil der er dømt.
- **Tilmelding:** vælg op til **2 maskiner** og nogle **dyr** (højst 3 køer, 5 får, 2 heste og 3 grise).
  - Maskinerne skal **stå på dyrskuet** ved bedømmelsen: kør dem selv til kvægtorvet og slip dem der – eller tryk *Send derhen*, så kører en medhjælper dem.
  - Dyrene køres derhen med din kreaturvogn eller kreaturbil – eller af vognmanden mod betaling – når du trykker *Send dyrene afsted*.
- **Bedømmelse:** maskiner får point for lavt slid, nylig service, opgraderinger og model – og publikum elsker gamle veterantraktorer. Dyr får point for foder, strøelse, fold og blandet foder (køer).
- **Præmier:** rosetter og 3.000 / 1.500 / 750 kr til de tre bedste i hver kategori mod naboerne (og de andre spillere). En 1. plads giver 2% bedre priser et år (højst 5%). Egnens avis skriver om vinderne.
- **Messetilbud:** under dyrskuet koster nye maskiner 10% mindre, og brugte maskiner sælges for 70% i stedet for 60%.
- Efter dyrskuet kører maskinerne selv hjem, og dyrene bliver kørt hjem igen.

## Dieseltank, opgraderinger og GPS

- **Dieseltank** (bygning, 6.000 kr, 3.000 liter): højreklik på den og køb diesel hos tankbilen med 8% rabat – bedst, når dieselprisen er lav (du får et tip i loggen). Så tanker dine egne maskiner fra tanken i stedet for at betale dagsprisen. Tanken ses under Gård og Marked.
- **Maskinernes egen tank:** hver maskine har sin egen dieseltank (traktorer ca. 70–110 liter, mejetærskere og lastbiler mere) med en **tankmåler** nederst, mens du selv kører, og i maskinens vindue. Er dieslen ved at slippe op, vises en lille gul/rød måler over maskinen.
  - **Maskiner, der kører selv**, tanker op, når de holder hjemme: fra gårdens dieseltank, ellers kommer tankbilen til dagsprisen. Har de under 15% tilbage, kører de hjem og tanker, før de fortsætter.
  - **Når du selv kører:** hold stille ved gårdens dieseltank – eller ved pumpen ved grovvarehandlen i byen (dagspris + 10%) – så tanker du op.
  - **Løber en maskine tør**, går motoren ud. Kører du selv, kan du *ringe efter tankbilen*; kører den selv, kommer tankbilen automatisk. En nødtankning koster 400 kr ekstra plus dieslen og fylder tanken 40%. Er gårdens dieseltank tom, tanker du ved grovvarehandlen eller bestiller diesel hos tankbilen.
- **Opgraderinger pr. maskine:** højreklik på en maskine › *Opgrader*, tryk *Vis* ud for maskinen i Gård-fanen, eller klik på den i maskinhuset (højreklik på huset) › *Opgraderinger*. Det kræver dit eget **værksted**: når du har købt en opgradering, kører maskinen selv hen foran værkstedet og får den monteret (kører du selv, så hold stille foran værkstedet et par sekunder). Halvdelen af prisen kommer igen, når maskinen sælges.
  - **GPS-autostyring** (traktor og mejetærsker, 6.000 kr)
  - **Tvillinghjul** (3.000 kr): 25% hurtigere i marken og i terræn – ses som dobbelte baghjul på traktoren
  - **Frontvægt** (traktor, 1.500 kr): 30% mindre slid ved markarbejde
  - **Motortuning** (4.000 kr): 15% hurtigere arbejde, 10% mere diesel
  - **Større lad** (lastbil, 5.000 kr): 25% mere last pr. tur
  - **Frontlæsser** (traktor, 6.500 kr): løfter 2 halmballer ad gangen op på ballevognen (eller tipvognen) – skal til for selv at samle baller op
  - **Balleklo** (traktor med frontlæsser, gaffeltruck, minilæsser og gummiged, 2.500 kr): løfter dobbelt så mange baller ad gangen (4 – to stakke à 2)
  - **Ekstra dieseltank** (alle maskiner, 2.000 kr – 800 kr på småkøretøjer): 50% større tank
  - **Terrændæk** (ATV, UTV, terrænbil, minilæsser og gummiged, 1.500 kr): 25% hurtigere i marken, skoven og terrænet – ses som større, grovere hjul
  - **Sneplov/sneblad** (lastbil og traktor 5.500 kr · ATV, UTV og terrænbil 2.500 kr): rydder vejene for kommunen; sænkes med L, når du selv kører
  - **Bredt klippebord** (havetraktor, 1.200 kr): klipper tre felter i bredden, når du selv kører, og slår plænen hver 4. dag af sig selv, så den holder sig pæn
  - Har en maskine mange mulige opgraderinger, vises de i to kolonner.
- **GPS-autostyring:** når du selv kører, slår **G** GPS'en til. Sænk redskabet, så holder traktoren sporet lige og farten selv, og ved markkanten vender den og kører tilbage i næste række – den følger den plan, du har trukket for redskabet (ellers kun marker og stub). Når marken er færdig, stopper den. **Ned/S** bremser, gas kører videre, rattet tager over, og **G** slår den fra.

## Jagt og fiskeri

- **Jagthytte** (Byg og køb › Bygninger, 12.000 kr, højst 2): placér den på din egen jord ved en skov – eller **i statsskoven** (skov uden ejer, mod en jagtleje på 150 kr pr. måned). Der skal være skov tæt på. Går du på jagt inden for 5 felter af hytten, kan du jage **hver 2. dag** (ellers hver 5.), der skal mindre skov til, rådyr og vildsvin kommer oftere frem, du har lidt længere tid til at skyde og rammer lidt bedre, og vildtet vejer **20 % mere**. Højreklik på hytten for at se, hvis den er, eller sælge den (halv pris). **I multiplayer kan hytten lejes ud** (højreklik › *Lej den ud*, eller under Handel › Udlejning): flere kan leje den på én gang i 3, 7 eller 14 dage og får samme fordele – også i ejerens egen skov ved hytten. **Fællesjagt:** går I på jagt ved samme hytte samtidig, driver I vildtet frem sammen, og hvert skud giver 15 % mere vildt pr. jagtkammerat (højst 3).
- **Jagtbutikken** ligger i byen ved hovedvejen (højreklik på den). Her løser du **jagttegn** (800 kr, gælder et år) og køber **haglgevær** (fasan, gråand og hare), **riffel** (rådyr og vildsvin), **fiskestang** og **fiskegrej de luxe** (flere og større fisk). Butikken viser **jagttiderne** og køber dit vildt og dine fisk – de kan også sælges i gårdbutikken eller under Marked.
- **Du kører selv derhen:** tag traktoren, bilen eller en anden maskine med *Styr selv* og hold stille:
  - **ved en sø** – tryk **F** for en fisketur. Den går af sig selv og giver fx aborrer, skaller, gedder, ørreder eller karper efter årstiden. Fiskene bider bedst i regn og tåge, der fiskes ikke i storm, og når søen er frosset til, må du vente. Store søer har større gedder.
  - **ved kanten af en skov** (din egen eller statsskov – ikke naboens) – tryk **J** for at gå på jagt. Efter lidt tid kommer et dyr frem ved skovkanten, og du har et par sekunder til at trykke **J** igen for at skyde.
- **Jagttider:** rådyr og fasan okt–jan, gråand sep–dec, hare okt–dec, vildsvin hele året, og hvid stork er fredet hele året. Skyder du et dyr uden for jagttiden, giver jagtbetjenten en **bøde** (2.000–15.000 kr) – så lad være med at skyde, hvis du er i tvivl. Du skal også have det rette våben.
- Efter en tur skal vildtet og fiskene have ro i nogle dage (jagt 5 dage, fiskeri 3 dage). Nederst over kørepanelet står det, når du holder et sted, hvor man kan fiske eller jage.
- **Egnens avis** skriver om rekordfisk, kæmpe vildsvin og jægere, der har fået bøde.

## Grafik

- Spillet bruger den originale grafik. Et Pixel-tema i OpenTTD-stil er påbegyndt, men sat på pause (valget er skjult).
- **Ikoner** på alle værktøjerne i venstre side (plov, såsæk, aks, sprøjte, kalk, økse, veje, grøft, hegn, bulldozer, træ og hus).

## Balance (økonomien)

Økonomien er afstemt med en simulator, hvor automatiske spillere med forskellige strategier (korn, raps, kartofler, svin og høns, køer, skov) kører flere spilår i vejret. Målet: det første år går til at komme i gang (græs skal pløjes, udstyr købes), og derefter giver en ganske almindelig drift overskud – mere, hvis man sælger, når priserne er gode, har sit eget udstyr og holder øje med marken.

- Bladlus kommer sjældnere, gør mindre skade og holdes væk i 40 dage efter sprøjtning. Tørke og storm skader afgrøderne mindre (men kan stadig koste en del af høsten – grøfter og brønde hjælper).
- Maskinstation, leje af udstyr og vognmand er billigere, såsæd, kunstgødning og sprøjtemiddel koster mindre, og kornsorterne giver lidt mere.
- Korn, raps, majs og kartofler betaler bedre, og markedet tåler større salg, før prisen falder. Lageret ved gården rummer 1.200 enheder fra start.
- Dyrene var alt for gode forretninger i forhold til markerne: køerne giver nu 1,4 liter mælk om dagen (før 3), hønsene 0,5 æg, og pensionshestene 7 kr om dagen. Køer er stadig den bedste forretning, men kræver stald, fold og foder.

## Årstider i byen og på landet

- **Storke** (april–juni): de går og snapper frøer på pløjede marker og stubmarker, og et par stykker flyver over landskabet. Avisen skriver, når de er tilbage.
- **Høstfest** (20.–27. september): telt og flag på torvet, flagranker på husene. Hele ugen betaler byen **10 % mere** for dine varer, og gårdbutikkerne har dobbelt så mange kunder.
- **Halloween** (24.–30. oktober): græskarlygter på trapperne i byen og ved stuehusene – og en bunke græskar på torvet.
- **Jul** (december): lyskæder på husene i byen og på stuehusene, og et stort juletræ med stjerne på torvet.
- **Juletræssalg:** har du en **gårdbutik** og **skov på din jord**, sælger butikken juletræer fra 1. til 24. december (125 kr stk., op til 1½ træ pr. skovfelt om året – med travlhed efter hvor mange kunder butikken har). For hver 8 træer bliver et skovfelt tæt på gården til ungskov, som gror til igen. Små juletræer står ved butikken, så længe der er nogen tilbage. Indtægten står i årsrapporten som *Juletræssalg*.

## Vanding, energi og vinterarbejde

- **Vandingsanlæg** (Byg og køb › Udstyr, 7.500 kr): en slangetromle med vandkanon. Træk med værktøjet **Vand** hen over tørre marker (under 80 % fugt), så kører traktoren ud og vander dem op til 92 % fugt – det holder en uges tid, også i tørke. Det koster 4 kr pr. felt plus diesel, og der skal være vand **højst 8 felter væk**: en sø (også en selvgravet), en brønd eller en grøft med vand. I *Styr selv* kobler du tromlen på i maskinhuset og sænker med L. Vander du lige før høst, bliver kornet vådt (se korntørreri).
- **Vindmølle** (28.000 kr, 1 felt): sælger strøm hver dag. Den giver mest i blæsevejr (regn og sne) og om vinteren, mindre i sol og tørke, og vingerne drejer efter vinden. I storm står den stille, og der er en lille risiko for skader (2.500 kr og 5 dages stilstand). Den skal stå **mindst 5 felter fra stuehuse** – også naboernes – og byen. Tjener sig hjem på 5–8 år.
- **Solcelleanlæg** (15.000 kr, 2×2 felter): giver mest i solskin om sommeren og næsten intet om vinteren – en god makker til vindmøllen. Højreklik på møllen eller anlægget viser dagens vind/sol og årets strøm.
- Strømmen står i årsrapporten under *Strøm (biogas, vind og sol)* og i **Hvad tjener penge? (F4)** under *Energi* med indtægt, udgifter og resultat for hvert anlæg.
- **Sneplov** (Udstyr, 4.500 kr): når der ligger sne, bliver vejene hvide. Træk med værktøjet **Sneplov** hen over vejene – traktoren rydder dem (de bliver sorte igen), og **kommunen betaler 12 kr pr. offentligt vejfelt**. Ny sne dækker vejene igen. Plovet sidder foran, så i *Styr selv* sænker du den bare med L, når der ligger sne. **Lastbiler** kan også få en sneplov som opgradering (5.500 kr – højreklik på lastbilen, den monteres på værkstedet). Lastbilen rydder vejene cirka dobbelt så hurtigt som en traktor, og har du kun sneplov på lastbilen, bliver traktorerne hjemme. **Traktorer** kan også få sneploven som opgradering (5.500 kr), så den sidder fast på netop den traktor. Ploven ses foran maskinen, så længe den er monteret, og under *Opgrader* kan den **afmonteres** og sættes på igen. På en traktor deler sneploven plads med frontlæsseren: mens ploven sidder på, kan læsseren ikke bruges – afmontér ploven, så er læsseren klar igen.
- **Vådt korn og korntørreri:** korn (hvede, byg, majs og raps), der høstes i regn eller storm eller fra en meget våd mark, er **vådt**. Vådt korn mugner 1 % om dagen og sælges med 10 % fugtfradrag. Et **korntørreri** (12.000 kr, 2×2 felter) tørrer 80 enheder om dagen for 0,4 kr pr. enhed. Gård-fanen og siloen viser, hvor meget der er vådt.

## Byggeri og skel

- **Skel om din jord** (F1 › Vejr og indstillinger › Skærm): som **hegn** (standard), som **rød linje** eller **skjult**. Er skellet skjult, vises det som rød linje, når du bygger, køber jord eller trækker med et værktøj.
- **Drej og se det før du bygger:** alle bygninger – også stuehuset, den trelængede gård og tilbygningerne – kan drejes med **R**, og du ser en gennemsigtig udgave af bygningen ved musen, så du kan se, hvilken vej den vender, før du klikker.
- **Flyt en bygning:** højreklik på bygningen og tryk *Flyt* (på maskinhuse: *Flyt huset* øverst i vinduet). Bygningen følger musen som en gennemsigtig skygge – **R** drejer, klik sætter den, **Esc** fortryder. Det koster 15 % af byggeprisen (mindst 150 kr), og den kan godt flyttes et enkelt felt eller bare drejes på stedet. Maskiner, redskaber og båse følger med maskinhuset, og lageret følger med siloer og dieseltanken. En stald kan ikke flyttes væk fra folden, hvis dyrene så mister deres plads. Stuehuset flyttes, når du opgraderer det.

## Maskinhuse, båse og redskaber

- **Højreklik på dit maskinhus** for at se det **uden tag**. Maskinhuset er delt op i rækker, som hver er to båse dybe: et maskinhus har 3 rækker (6 båse), et stort maskinhus 6 rækker (12 båse).
  - En **traktor, et redskab eller en vogn** fylder 1 bås. En **lastbil eller mejetærsker** fylder en hel række (2 båse).
  - **Træk med musen** for at flytte tingene rundt, præcis som du vil have dem. Står der noget i vejen, bytter de plads – eller det flytter udenfor, hvis der ikke er plads.
  - **Udenfor-feltet** nederst viser det, der står ude ved gården. Træk noget derud for at stille det udenfor, eller ind i en ledig bås for at få det i ly. Redskaber, der står ude i marken, skal hentes med en traktor.
  - Klik på en maskine for *Styr selv*, *Service* og *Sælg*. Maskiner, der er ude at køre, vises gennemsigtige med "ude".
  - **Flyt til andet maskinhus:** har du flere maskinhuse (de hedder *Maskinhus 1*, *Maskinhus 2* osv.), så klik på en maskine, et redskab eller en vogn og vælg *Flyt til andet maskinhus …* og huset. Maskinen kører selv derover og parkerer i en ledig bås; redskaber og vogne flyttes med det samme.
  - **Parkér, når du selv kører:** hold stille foran et af dine maskinhuse og tryk **P** (eller *Parkér* i boksen) – så holder maskinen i en ledig bås i det hus, og du slipper styringen.
- Er der ikke plads, står nye maskiner, redskaber og vogne udenfor ved gården – maskinerne slides af vejret, og redskaber og vogne, der står ude, koster 1% af deres pris i reparationer hver måned.
- **Kobl redskaber på, når du selv kører:** bak traktoren hen til ploven, såmaskinen, sprøjten, gødningsprederen eller tipvognen – enten der, hvor den står på jorden, eller ind mod maskinhuset, hvor den står – og tryk **K**. Står der flere ting i maskinhuset, vises knapper, så du kan vælge. **K** igen kobler af: ind mod maskinhuset kommer redskabet i en ledig bås, ellers bliver det stående på jorden, hvor du er (og kan hentes igen senere).
  - Når du selv kører, skal redskabet være koblet på, før du kan sænke det – man lejer ikke længere udstyr undervejs. (Maskiner, der kører selv, lejer stadig, hvis du ikke har redskabet.)
  - Tipvognen skal også kobles på, før du kan læsse høst.
  - Et redskab bliver siddende på traktoren, når du slipper den. Maskiner, der kører af sig selv, bruger gårdens redskaber automatisk.

## Årstider og vejr på skærmen

- **Årstiderne ses på kortet:** friskt grønt med blomster om foråret, lidt tørrere græs om sommeren, gult græs og løv i gult, orange og rødt om efteråret, og bladløse træer om vinteren.
- **Sne og is:** når det sner, lægger sneen sig på marker, græs og træer, og søerne fryser til. Den smelter igen i mildt vejr og er væk til april. Byens gader og vejene bliver ryddet.
- **Vejret ses på skærmen:** regn, sne, lyn i stormvejr, skyskygger der glider hen over landskabet, tåge om efteråret og i marts, en varm tone i tørke og en kold i frost. Overgangene sker langsomt.
- Tåge er kun stemning og skader ikke afgrøderne.
- Vejreffekterne kan slås fra under **F1 › Vejr og indstillinger › Skærm**. Det gælder kun din egen computer.

## Diesel og slid

Holdt mildt, så spillet kan køre i baggrunden uden pasning:

- **Diesel** trækkes automatisk, når maskinerne arbejder og kører – ingen tankning. En mellemtraktor bruger ca. 0,3 liter pr. felt (knap 3 kr), store maskiner lidt mere, men de arbejder også hurtigere. Dieselprisen svinger lidt og står nederst under *Marked*. Forbruget står i den månedlige besked og i årsrapporten.
- **Slid:** maskinerne slides langsomt af arbejdet (en travl traktor ca. 15–20% om året). Slidte maskiner går lidt oftere i stykker. Pålidelige mærker slides langsommere.
- **Service:** værkstedet servicerer selv en maskine, når den er over 50% slidt og holder hjemme – det koster lidt, og den er som ny bagefter. Du kan også selv vælge *Service* ved at højreklikke på maskinen eller maskinhuset.
- Slid kan slås helt fra under **F1 › Vejr og indstillinger**.

## Byen vokser

- **Havreby** vokser, når gårdene handler med den: salg på markedet, leverancer til opgaver, dyr til kvægtorvet, ture til torvet i bil og bidrag til fælles byggerier. Hver 3.500 kr, byen handler for, giver et nyt hus – først på de tomme grunde inde i byen, siden som forstæder med villaer langs vejene ud af byen. Der bygges aldrig tæt op ad jeres jord.
- **Byen vokser også af sig selv:** et nyt hus hvert kvartal (4–5 om året), selv om ingen handler med den. Handel får den stadig til at vokse meget hurtigere, og den naturlige vækst tæller ikke med i byens trin.
- **Nye udstykninger:** når der ikke er flere grunde, anlægger kommunen en **ny vej** (6 felter) ud i landskabet fra en af de eksisterende veje – med byggegrunde og nye parcelhuse på begge sider. Vejene får navne som *Stationsvej*, *Skolevej* og *Birkevej*, avisen skriver om hver ny udstykning, og de står i byens vindue.
- **Kommunen vil købe jord:** fra stationsby og op byder kommunen hvert forår på op til 12 felter af din ubrugte jord (græs, stub eller tom mark uden bygninger) tæt ved byen eller de nye veje – 750 kr pr. felt, 2½ gange jordprisen. Buddet står øverst under fanen *Opgaver* i 30 dage: **Sælg**, **Nej tak** eller **Vis** (jorden markeres på kortet). Det er helt frivilligt.
- Byen går gennem fem trin: **landsby → stationsby (40.000 kr) → købstad (120.000 kr) → handelsby (280.000 kr) → provinsby (560.000 kr)**. Undervejs får den købmand, bager, café, skole, rådhus, hotel og etageboliger, og der kommer mere trafik.
- Hvert trin gælder for alle gårde: markedet tager 25% mere, før prisen falder, når I sælger, lokale varer (mælk, æg, svin, jordbær og kartofler) giver 4% mere, og opgaverne betaler 10% mere. Fra købstad er der også flere tilbud på opgaver.
- **Højreklik på byen** (eller *Byen*-knappen under Gård) for at se indbyggere, trin, fordele og en graf over væksten. I multiplayer bygger I byen op sammen.

## Hjælp i spillet

- **F1** åbner hjælpen med fire faner: *Sådan spiller du*, **Flere funktioner** (økonomi og budget, markplan, søer og vanding, vådt korn, energi, sneplov, flytning af bygninger, gårdhegn, byens vækst, årstider, naboer og kort), *Indstillinger* og **Grafik**.
- **Driftslederen** (fanen *Råd*) giver også råd om det nye: vådt korn uden tørreri, vandingsanlæg ved tørre marker, sneplov når der ligger sne, vindmølle på blæsende egne, at han kan passe markerne for dig – og advarer, når budgettet viser, at pengene slipper op.

## Årsrapport

- Hvert nytår får du en **årsrapport** (åbner selv, eller **F2** / *Årsrapport* under Gård). Den viser indtægter og udgifter fordelt på salg, dyr, opgaver, drift, renter, markarbejde, maskiner, byggeri, jord, vognmand m.m., årets resultat, formue og hvad du har høstet og produceret.
- Grafer: resultat år for år, formue og penge måned for måned og priserne på de vigtigste varer i procent af normalprisen. Skift mellem årene med piletasterne – *I år* viser tallene indtil nu.
- **Hvad tjener penge? (F4, eller fanen i årsrapporten):** driftsregnskab for det valgte år.
  - **Afgrøder:** felter, udgifter, høstens værdi, resultat og resultat pr. felt for hver afgrøde – så man kan se, om raps slår hvede.
  - **Markerne:** de bedste og dårligste marker med afgrøde og resultat pr. felt.
  - **Dyr:** gennemsnitligt antal, indtægt (produktion og salg af dyr), foder og strøelse, stald og indkøb – og resultatet for hver dyreart.
  - **Maskiner:** felter kørt, udgifter (diesel, reparation og faste udgifter), udgift pr. felt, og hvad maskinstationen ca. ville have taget for det samme – så man kan se, om mejetærskeren betaler sig.
  - En graf viser resultatet år for år fordelt på marker, dyr og maskiner.
  - Høst og produktion er sat til dagens pris, da den blev høstet eller produceret (uanset hvornår du sælger). Markens udgifter – såsæd, gødning (også fra lageret), sprøjtning, kalk, arbejde, leje og diesel – samles på hvert felt og lægges på høsten, også når der blev sået året før. Jordskat, bygninger og renter fordeles ikke.
- **Budget (F6, eller fanen i årsrapporten):** pengestrømmen de næste 12 måneder – måned for måned: høsten (regnet solgt, når den er moden, til en pris midt mellem dagens og normalprisen), dyrenes produktion, strøm fra vind og sol, faste udgifter, lånenes renter og afdrag, foder, der skal købes, når lageret slipper op, og høstarbejde. Til sidst netto og hvor mange penge der er på kontoen hver måned – med en graf. Går kontoen i minus, står det øverst, og driftslederen advarer i februar–marts og juli–august. Varer på lageret og nye køb er ikke med.
- **Udgifter og vedligehold (F7, eller fanen i årsrapporten):** de faste udgifter post for post (gården, ejendomsskat, bygninger, maskiner, vogne, løn), lånenes rente og afdrag, hvad hver dyreart giver og koster om måneden, og hvad der er brugt i sidste og denne måned fordelt på diesel, værksted, leje, vognmand, foderkøb osv. Dyrene koster kun foder og staldenes vedligehold (plus malkerobottens service) – halm til strøelse tages fra lageret, og gyllen er gratis gødning.
- **Markkortet (F3)** viser økonomien for hver mark: udgifter, høstens værdi og resultat (også pr. felt) for seneste høst, og hvad der er brugt på marken til næste høst. Det samme står, når du holder musen over en mark.
- **Markplan (højreklik på en mark, eller *Plan* i markkortet):** viser jordens tilstand (næring, kalk, ukrudt og fugt), sædskiftet de seneste år og **forslag til næste afgrøde** – de bedste afgrøder med såtid, forventet udbytte og resultat pr. felt og for hele marken, regnet ud fra markens jord, sædskiftet, dagens priser og de normale udgifter (når du har høstet en afgrøde mindst 10 felter, vejer dine egne udbytter halvt med). Begrundelserne står under hver afgrøde, fx *godt sædskifte: +8 %*, *samme afgrøde som sidst: -15 %* eller *sur jord – kalk først*.
  - **Vælg** en afgrøde som plan for marken – den står i markkortet og ved musen. **Udfør nu** sætter pløjning, kalkning, gødskning og såning i gang i den rigtige rækkefølge, når det er såtid.
  - **Lad driftslederen passe marken** (kræver en driftsleder, *Råd*-fanen): han pløjer, kalker, gøder og sår – din planlagte afgrøde, ellers den, der giver mest lige nu – sprøjter mod skadedyr og ukrudt, vander i tørke (hvis du har et vandingsanlæg) og sætter høsten i gang, når hele marken er moden. Hele marken sås på én gang, og ét trin ad gangen. Det koster 5 kr pr. felt om måneden oven i hans løn – bekvemt, men lidt dyrere end at gøre det selv. Salget bestemmer du stadig. Med *Manuel styring* bliver hans opgaver planer med gule rammer, som du eller en medhjælper kører.

## Samarbejde i multiplayer

- **Marked:** under hver vare står, hvad hele lageret er værd lige nu (prisen falder lidt, når man sælger meget), og øverst hvad alle afgrøderne tilsammen giver. *Sælg alle afgrøder* sælger hvede, majs, kartofler, raps og jordbær i ét hug – har du dyr, gemmes foder til ca. en måned.
- **Tiden styres i fællesskab:** vil én skrue op eller ned for hastigheden, kommer der en afstemning øverst på skærmen hos alle, og flertallet bestemmer (den der foreslår, tæller som ja; er I to, skal begge sige ja). Afstemningen står åben i 20 sekunder. Pause virker altid med det samme, og det gør det også at fortsætte i den hastighed, I holdt pause fra. Trykker en anden på den samme hastighed, tæller det som en ja-stemme.
- **Delt marked:** store salg presser prisen for alle.
- **Handel:** send penge og varer direkte til naboerne.
- **Udlejning af maskiner** (Handel › *Udlejning af maskiner*): sæt en maskine, et redskab eller en vogn til leje med en pris pr. dag (vælg med pilene). De andre kan leje den i 3, 7 eller 14 dage – lejen betales med det samme, og maskinen står hos den, der lejer, indtil tiden er gået (eller den afleveres før). Lejede ting kan ikke sælges.
- **Maskinstation mellem gårdene:** har du planlagt en opgave (fx høst eller pløjning), kan du trykke *Bestil* ud for den i Gård-fanen og vælge en anden gård og en pris pr. felt. Siger de ja (fanen Opgaver), flyttes opgaven over til dem: deres maskiner kører ud på din jord, du betaler arbejdet pr. felt plus såsæd og gødning, og høsten havner i din markbunke. Computernaboerne svarer dagen efter, hvis de har maskinen og prisen er god nok. Opgiver maskinstationen, får du de resterende felter tilbage.
- **Leveringsaftaler** (fanen Opgaver): slagteriet, mejeriet, møllen, malteriet, frugtpakkeriet og flere tilbyder en fast pris (15–30 % over markedet) for en større mængde inden en frist. Den første, der siger ja, får aftalen (højst 2 ad gangen). Alt, hvad du sælger af varen, går til aftalen først – også mælken, mejeriet henter. Mangler der noget ved fristen, er boden 20 % af det manglende.
- **Byens bestillinger** (fanen Fælles): fx julemarkedet, byfesten eller skolernes madordning skal bruge en stor mængde af én vare. Alle gårde kan levere (10, 100 eller alt), får 10 % over markedsprisen med det samme, og bliver det hele leveret i tide, deles en bonus efter, hvor meget hver har leveret – søjlen viser hver gårds andel i sin farve. Computernaboerne leverer også. Faste ordninger (skolernes madordning, kommunens kornlager, forsamlingshuset) har **et helt år** til levering; fester og markeder (julemarkedet, byfesten, høstfesten, rideskolens stævne) skal have varerne inden festen (40–60 dage). Der kan være to bestillinger i gang på én gang, men højst én helårsordning.
- **Fælles byggerier i byen:** vandingsnet, andelsmejeri, jernbanestation og forsøgsstation.
- **Fælles vejr og skadedyr:** tørke rammer alle, og bladlus spreder sig over skellet.

## Netværk

| Port  | Protokol | Formål                    |
|-------|----------|---------------------------|
| 47998 | TCP      | Selve spillet             |
| 47999 | UDP      | Automatisk søgning på LAN |

Windows spørger første gang om firewall-adgang for Python – tillad *Private netværk*. Singleplayer bruger kun din egen maskine og åbner ingen porte udadtil.

Alle computere skal køre **samme version** af FarmLand. Har gæsten en anden version, siger værten det med det samme ("Værten kører FarmLand 1.1.0, men du har …"), og på listen over spil på netværket står værtens version ud for spil, der ikke passer.

## Styring

Venstre træk = værktøj · Tab = næste maskine (Styr selv) · L = sænk/løft redskab · K = kobl redskab på/af · T = traktortræk (på festpladsen) · E = frontlæsser · P = parkér i maskinhuset · G = GPS · F3 = markkort · F/J = fisketur/jagt, mens du kører · Højreklik/træk = flyt kort · Scroll eller +/- = zoom · B = byg og køb · WASD/piletaster · klik på minikortet · H = din gård · T = byen · 1/2/3/4 = spillerne · Mellemrum = pause · hastighed: ¼ (meget langsom, ca. 72 min. pr. år), ½ (langsom, ca. 36 min.), > (normal, ca. 14 min.), >> og >>> (tiderne gælder årets længde +20 %) – i multiplayer kræver en ny hastighed flertal · F2 = årsrapport · M = fugtkort · Enter = chat · F1/Esc = menu · F5 = gem · F11 = fuldskærm til/fra (kan også vælges under Indstillinger › Visning: Vindue eller Fuldskærm – valget huskes til næste gang)

Spillet gemmes automatisk hvert 5. minut og når du forlader det. Der er 5 gemmepladser til singleplayer og 5 til spil som vært (`farmland_single.json`, `farmland_single_2.json` … / `farmland_multi.json` …) – vælg plads ved nyt spil, og find dem alle under *Alle* ved *Fortsæt*. Gemte spil fra den forrige version kan stadig indlæses – spillet hed tidligere *Høstland*, og gemte spil og indstillinger med de gamle navne (`hoestland_…json`) flyttes automatisk over, første gang du starter FarmLand.

## Versionshistorik

Versionsnummeret er *større.funktioner.rettelser*: nye funktioner hæver det midterste tal (1.1 → 1.2), rettelser det sidste (1.1.0 → 1.1.1).

### 1.29.0
Gør gården pæn – en ny fane **Pynt** under *Byg og køb* (alle i ren pixelgrafik):
- **Flagstang med Dannebrog** (1.500 kr): flaget vajer efter vinden.
- **Gårdskilt med postkasse** (800 kr): skiltet viser gårdens navn, når man zoomer ind. Højreklik på skiltet › *Skift navn …* for at give gården et navn (tomt = "Joakims gård"). I multiplayer ser alle navnet.
- **Havemøbler** (bord, bænke og parasol, 900 kr), **vandpumpe med trillebør** (600 kr) og **redskabsskur** (2.500 kr).
- **Lygtepæl** (400 kr): tænder om natten og kaster et varmt lys, når nat er slået til.
- **Bøgehæk** som ny slags gårdhegn (40 kr pr. stykke): grøn om sommeren og brun om vinteren.
- **Brosten** som ny belægning under *Veje* (110 kr pr. felt) – fliser og brosten kan skiftes ud med hinanden.
Flagstang, gårdskilt og havemøbler giver hver lidt prestige.

### 1.28.0
- **Riv ned:** højreklik på en af dine bygninger › *Riv ned …* (også i maskinhusets vindue, og når du klikker på en bygning med *Ryd*). Først vises, hvad der sker: dyr, der ikke længere er plads til (og hvad de sælges for), maskiner, der må holde udenfor, et lager, der bliver for lille, en malkerobot eller kalve, der forsvinder med, og hvor meget de faste udgifter falder. Du får 25% af byggeprisen tilbage for materialerne (nedrivningen koster 100 kr). *Ryd* river ikke længere bygninger ned ved et uheld, når man trækker hen over dem.

### 1.27.1
- **Menuen i spillet kan rulles:** ved stor tekst på en lille skærm kunne den nederste linje under Indstillinger (skrift og tekststørrelse) gemme sig bag knapperne. Nu kan indholdet i alle menuens faner rulles med musehjulet – en rullebjælke og "rul for mere" viser, når der er mere.

### 1.27.0
Tre nye fællesprojekter i byen (Fælles-fanen) – alle kan bidrage, og gamle gemte spil får byggepladserne med:
- **Fælles biogasanlæg** (30.000 kr + 1.500 enheder gylle): hver dag får alle strøm for gyllen fra deres dyr, og den afgassede gylle bliver i gyllelageret som gødning. Har man sit eget biogasanlæg, går gyllen dertil som før.
- **Fælles maskinstation** (40.000 kr + 150 tømmer): den store fælles mejetærsker høster for alle uden egen mejetærsker til halv pris (9 kr pr. felt i stedet for 18) og 60% hurtigere.
- **Fælles vindmøllepark** (60.000 kr): vindmøllerne sælger strøm hver dag (ca. 60 kr om dagen ved normal vind, intet i storm), og hver spiller får sin andel efter, hvor mange penge han eller hun har givet. Fælles-fanen viser din andel og hvad du har fået.

### 1.26.0
- **Scenarier** (vælges under Nyt spil): *Normal*, *Nedslidt gård* (udpint, sur jord fuld af ukrudt og en slidt traktor – men 8.000 kr ekstra), *Fars gård* (mere jord, kostald med 10 køer og fold, kornsilo og en ekstra traktor – men et lån på 60.000 kr over 5 år) og *Økologisk* (ingen sprøjtemidler og ingen kunstgødning – kun gylle, pløjning og sædskifte – til gengæld 20% mere for det, du sælger; du starter med et hønsehus og 30 høns på græs).
- **Baller i foderhækken** (ny automatik, slået til fra start): har du en traktor med frontlæsser eller en læsser, sætter karlen en ny halm- eller wrapballe i foldene, når den gamle er ædt op (20 kr pr. balle).
- **Værtens adresser:** som vært er *Vært: …* øverst til højre nu en knap. Den viser alle dine adresser (lokalt net, Tailscale/VPN), porten og kort, hvordan vennerne kommer med over internettet.
- **Flere beskeder:** når gylletanken er tom, og der gødes med kunstgødning i stedet, og når du ikke har penge til at betale en nabo for arbejde på din mark (før fik kun naboen besked).
- **Rullebar værktøjslinje:** er der ikke plads til alle værktøjerne (lille skærm eller stor tekst), kan listen rulles med musehjulet, og *Byg og køb* står fast nederst.
- **Fælles nat i multiplayer:** natten følger nu værtens ur, så alle har nat samtidig.

### 1.25.0
- **Nat (eksperiment):** slå den til under Indstillinger › *Nat (eksperiment)*. Så skifter det mellem dag og nat – et døgn tager ca. 6 minutter, mens spillet kører (står stille på pause), og vinternætterne er længere end sommernætterne. Om natten lyser stuehusene, staldene, laden, drivhuset og husene i byen, maskinerne kører med lygter, og der er arbejdslys på dem, der arbejder i marken. Det er kun på skærmen – det ændrer ikke på spillet – og er slået fra fra start.
- **Balance:** de nye ting er regnet igennem sammen. Bierne giver lidt mindre (højst ca. 0,35 kg honning om dagen, og honning koster 30 kr), og kalvene drikker 2,5 liter mælk om dagen de første 60 dage. Afkastet pr. år er nu ca. 25–60% af prisen for halmfyr, drivhus, mølle, bistader og kalvehytter – lidt under en ko eller en mark med hvede, men de kræver ikke mere jord.
- **Andedammen fryser til** om vinteren (is og sne på sivene), og ænderne er væk til foråret.
- **Computernaboerne bruger de nye ting:** kvæggårdene høster majs som ensilage og bygger kalvehytter og foderhal, korngårdene bygger bistader, halmfyr og mølle, og de rige naboer bygger lade, drivhus og andedam og får hund og kat.
- **Sælg alle afgrøder** sælger nu også mel, honning, tomater og agurker.
- **F1-hjælpen** nævner de nye bygninger, hund og kat og F7.

### 1.24.0
- **Tre nye blå Fordal-traktorer** – de klassiske blå med firkantet snude og lys grill:
  - **Fordal 5000** (10.500 kr, 65 hk): lille, uden førerhus, med sæde og styrtbøjle. Billig og pålidelig.
  - **Fordal 7600** (14.500 kr, 97 hk): mellemklassen med kantet førerhus og hvidt tag.
  - **Fordal TW-25** (25.000 kr, 150 hk, fra år 2): stor, med lang firkantet snude, tvillinghjul bagpå og stort kantet førerhus.
- **Spillet starter i ½ tid** – både nye og fortsatte spil. Skift som før med knapperne øverst.

### 1.23.0
Fem nye bygninger under Byg og køb – alle i pixelgrafik:
- **Halmfyr** (14.000 kr, 2×1): murstenshus med høj skorsten og en stak rundballer. Fra oktober til april brænder det op til 5 enheder overskudshalm om dagen og giver 7 kr pr. enhed som varme til stuehuset og fjernvarme til byen – mere end halmen kan sælges for. En måneds strøelse gemmes altid til dyrene. Der kommer røg ud af skorstenen, når det brænder, og det kan slås fra ved fyret.
- **Kalvehytter** (3.000 kr, 2×1, plads til 6 kalve): tre hvide kalveiglooer med små folde. Køerne får ca. én kalv om året, når der er plads. Kalvene drikker 2,5 liter mælk om dagen de første 60 dage, og efter 120 dage bliver de til køer (hvis der er plads i stalden) eller sælges for 900 kr – det vælges ved hytterne. Kalve fra en kælvning, når stalden er fuld, kommer også herud.
- **Hollandsk mølle** (16.000 kr, 1 felt): grundmuret fod, tjæret krop, galleri og mørk hat med fire vinger, der drejer, når den maler. Den maler op til 40 enheder hvede til **mel** om dagen (mere i blæsevejr, næsten intet i tåge). Mel (20 kr) sælges til bageren – hvede er 15 kr. Et vartegn: +1 prestige. Kan stoppes ved møllen.
- **Drivhus** (20.000 kr, 3×2): glashus med hvide sprosser og tomater og agurker bag glasset – ca. 5 enheder om dagen hele året (lidt mindre midt om vinteren), som torvehandleren køber. Fra oktober til april koster varmen 25 kr om dagen, men den er gratis, når et halmfyr brænder.
- **Andedam** (2.500 kr, 2×2): dam med siv, dunhammere, en badebro og tre ænder, der svømmer rundt. Pynter: +1 prestige.

### 1.22.0
- **Rød lade** (Byg og køb, 9.000 kr, 3×2 felter): den klassiske røde lade med lodrette brædder, hvide kanter, gambreltag med knæk, store porte med hvidt kryds, høloftslem og en lille kuppel med vindfløj. Nedenunder er der 3 rækker med 2 båse til maskiner, og på høloftet plads til 600 enheder halm- og wrapballer (ballerne køres også herhen fra marken). Kun i pixelgrafik.
- **Bistader** (Byg og køb, 1.800 kr, 1 felt): tre bistader på paller. Fra april til september laver bierne honning – op til ca. 0,35 kg om dagen pr. plads – af blomsterne inden for 4 felter (raps, frugttræer, jordbær og kløvergræs giver mest, græs og skov lidt). Flere bistader tæt på hinanden deler blomsterne. Honningen sælges til torvehandleren. Raps, frugt og jordbær inden for 4 felter af et bistade giver **10% mere** – også naboens. Højreklik for at se blomster og honning pr. dag.
- **Gårdhund og gårdkat** (Gård-fanen › Dyr): hunden (2.500 kr + 60 kr/md) driver udbrudte køer, får og heste tilbage i folden dagen efter, så du ikke selv skal ud. Katten (400 kr + 20 kr/md) holder musene væk – uden kat kommer der en gang imellem mus i kornlageret, der æder 2% af kornet. Begge løber rundt på gårdspladsen ved stuehuset (hunden trisser rundt og logrer, katten sover i solen).

### 1.21.0
- **Billigste foder først:** uden fodersilo æder dyrene nu kartofler, majs, byg og så hvede (før majs, byg, hvede og kartofler til sidst) – det dyre korn bliver til salg. Med fodersilo vælges stadig det, der er billigst på markedet i dag. Har du kartofler, du vil gemme til salg fra kølelageret, så husk at dyrene tager dem først.
- **Sælg alle afgrøder** gemmer nu det foder, dyrene alligevel æder først (det billigste), og sælger det dyre korn.
- **Driftslederen gøder undervejs:** falder næringen under 40% i snit, mens afgrøden vokser, sætter han en ekstra gødskning i gang.
- **Ting, der gik i stå uden besked, er rettet eller giver nu besked:**
  - En stor vogn tæller ikke længere som egen transport, når ingen af traktorerne er stærke nok til at trække den (før kom vognmanden aldrig, og høsten blev liggende). Købes en vogn, ingen traktor kan trække, siger spillet til.
  - Vognmand-automatikken gælder nu kun høst og baller fra marken – købte og solgte varer og dyr bliver altid leveret (før kunne de blive hængende for evigt, når den var slået fra). Kan din egen dyretransport ikke køre, tager vognmanden dyrene.
  - Opgaver, der ikke er kommet i gang efter 5 dage, giver besked om hvorfor: ingen mejetærsker og maskinstationen slået fra, ingen maskine til opgaven, Styr selv uden medhjælper, eller baller på felterne.
  - Fuldt lager giver den rigtige besked for kornlager, plansilo, tømmerplads og balleplads – hver for sig – også når kun ét af lagrene er fuldt.
  - Kan ballerne slet ikke hentes (ingen frontlæsser og vognmanden slået fra), siges det til, og grovvarehandlen køber dem efter 3 dage (hvis *Overskudsballer sælges fra marken* er slået til). Ligger høsten i marken med vognmanden slået fra og ingen egen transport, kommer der også en advarsel.

### 1.20.0
- **Færre halmballer:** halmen er nu 40% af kornhøsten (før 60%) – ca. 2 rundballer pr. felt vinterhvede i stedet for 3.
- **Advarsel, når ballepladsen er fuld:** før blev ballerne bare liggende på markerne uden besked, og felter med baller blev ikke pløjet eller sået. Nu siger spillet til, hvor mange baller der ligger ude.
- **Overskudsballer sælges fra marken** (ny automatik, slået til fra start): har ballepladsen været fuld i 3 dage, køber grovvarehandlen ballerne direkte på marken til markedsprisen minus kørsel, så markerne kan pløjes igen. Kan slås fra under Menu › Automatik.

### 1.19.0
- **Rul i beskederne:** hold musen over beskedfeltet i bunden og rul op med musehjulet for at læse ældre beskeder (de sidste 200). En rullebjælke viser, hvor du er, og knappen *Til nyeste* hopper tilbage. Er du rullet op, bliver teksten stående, selv om der kommer nye beskeder.

### 1.18.1
- **Grøfter rækker længere:** en vandførende grøft holder nu marker inden for **6 felter** fugtige (før 2), så én grøft langs marken vander en stor del af den.

### 1.18.0
- **Udgifter og vedligehold (F7):** ny side i årsrapporten med de faste udgifter post for post – gården, ejendomsskat, hver bygning, hver maskine og vogn, løn og lån – samlet i grupper med procent af det hele. Ved siden af står, hvad hver dyreart anslået giver og koster om måneden (foder til markedspris, stald og malkerobot), og **hvor pengene gik hen** i sidste måned og denne måned (diesel, værksted, leje, vognmand, foderkøb …) med et råd om den største løbende udgift. *Udgifter pr. måned* i Gård-fanen viser genvejen.

### 1.17.1
- **Byg-filerne virker med den nyeste Python:** pygame findes endnu ikke som færdig pakke til Python 3.14, så `byg_installer.bat` og `byg_exe.bat` gik i stå, når pip prøvede at bygge det selv. Nu bruges det pygame, der allerede er installeret – ellers hentes en færdig pakke, og findes der ingen, bruges **pygame-ce** (samme bibliotek i en nyere udgave, som spillet også kører med).
- F1-hjælpen nævner foderhallen og majsensilagen.

### 1.17.0
- **Majsensilage:** majsen kan nu høstes som majsensilage i stedet for kernemajs (vælges under *Dyr* på Gård-fanen). Hele planten hakkes og køres i plansiloen – dobbelt så mange enheder pr. felt, og køer med både græs- og majsensilage giver 5% mere mælk. Græs- og majsensilage fodres blandet efter, hvor meget der er af hver.
- **Foderhal:** rundbuehallen kan nu også være foderhal (1.500 enheder ensilage under tag, 5% mindre spild ved udfodringen). Den kan bygges direkte eller bygges om fra maskinhal og halmlager for 500 kr – i pixelgrafik med en ensilagestak under sort plast og bildæk.
- **Installationsprogram:** `byg_installer.bat` laver **FarmLand-Setup-x.y.z.exe** med Inno Setup – en dansk installationsguide, som vennerne kan køre uden Python og uden administrator. Spillet installeres som en mappe og starter derfor hurtigere end den enkelte exe-fil.

### 1.16.0
- **Balance:** økologiske grise og høns giver stadig 30% økotillæg, men de giver nu 10% mindre og æder 15% mere foder – før blev overskuddet mere end fordoblet, nu er det ca. 20% bedre end konventionelt. Malkerobotten giver 20% mere mælk (før 25%).

### 1.15.0
- **Computernaboerne bruger de nye ting:** de bygger gylletank, når tanken er fuld, fodersilo (svinegårde), malkerobot i kostalden (kvæggårde med råd til det), rundbuehal til halm (korngårde), lægger folde ved svinestald og hønsehus og går over til økologi – og deres 'karl' mugger staldene ud og sætter baller i foderhækkene.
- **F1-hjælpen er opdateret** med folde og låger, små opgaver, økologi, malkerobot, rundbuehal, allé, gemmepladser og de samlede værktøjer; lange linjer brydes nu pænt.
- **Hurtigere:** foldene regnes kun om, når en fold, en bygning eller ejeren af et felt ændrer sig – ikke ved hvert skridt i markarbejdet.

### 1.14.1
- **Rettelse: hver fold hører til sin egen stald.** Før blev alle folde lagt sammen til én stor, og dyrene blev fordelt efter, hvilken fold der lå øverst på kortet – så køerne kunne flytte over i en ny fold ved svinestalden. Nu går køer, får og heste kun i folde, der rører deres egen stald (og deler kun en fold, hvis den rører flere stalde), og økologiske grise og høns kun i folde ved svinestalden/hønsehuset. Pladsen til dyr tælles også pr. fold.

### 1.14.0
- **Malkerobotten er nu en opgradering af kostalden** i stedet for en bygning for sig: højreklik på kostalden › *Installer* (22.000 kr i en kostald, 35.000 kr i en stor; service 150 kr om måneden). Køerne i den stald giver 25% mere mælk, og der ses et lille robotrum på staldens forside. Gamle malkerobot-bygninger flyttes automatisk ind i den nærmeste kostald.
- **Skrift og tekststørrelse gælder nu også menuerne:** hovedmenuen (med nyt spil, kortvalg, gemte spil og indstillinger) og menuen i spillet (F1) bliver større med tekststørrelsen – men aldrig større end skærmen.

### 1.13.0
- **Økologiske grise og høns på græs:** tryk *Øko* ud for grise eller høns i Gård-fanen. Så går de ude i en fold ved stalden (4 grise eller 25 høns pr. foldfelt – folden skal røre svinestalden eller hønsehuset, og den deles med køer, får og heste, der får plads først). For den del, der går ude, får du 30% økotillæg oven i værdien af svinekød og æg, men de giver 10% mindre og æder 15% mere (står i årsrapporten som *Økotillæg*). Er folden for lille, får kun en del af dyrene tillægget – det koster aldrig noget at have det slået til. Grisene og hønsene ses rode rundt i folden.

### 1.12.0
- **Færre punkter i værktøjslinjen:** Grusvej, Asfaltvej og Fliser er samlet under **Veje**, og **Fold og hegn** har fået **Låge** som underpunkt. Vælg punktet, og vælg så i boksen øverst på kortet. Med *Låge* klikker du på hegnet om en fold for at sætte en låge – eller på en låge for at åbne/lukke den. Værktøjslinjen husker det seneste undervalg.

### 1.11.2
- **Markarbejde starter i et hjørne:** når en maskine går i gang med en ny mark (eller en ny stribe længere væk), starter den i det hjørne af marken, der ligger nærmest – ikke midt i marken – og kører så række for række.

### 1.11.1
- **Allé er nu sit eget valg** under Gårdhegn (ved siden af Hvid, Sort, Træ og Læhegn). Læhegn opfører sig igen som før – det sættes i yderkanten, også langs veje – og kun *Allé* planter træer på begge sider af vejen. Prisen ved musen viser nu også den rigtige pris for læhegn.

### 1.11.0
- **Allé:** vælg Gårdhegn › Allé og træk hen ad en vej, så plantes der træer på begge sider af vejen. Vejen eller jorden ved siden af skal være din; der plantes ikke hen over sideveje, i byen eller ind i bygninger. Alléen giver læ for storm og tørke ligesom et almindeligt læhegn. Træk samme linje igen for at fjerne den.
- **Store maskiner kører ikke længere hurtigere i marken end på vejen.** Før kørte fx en stor mejetærsker 2–3 gange så hurtigt hen over marken, som den kører på vejen. Nu tager store maskiner i stedet en bredere stribe pr. tur (et bredt skærebord eller en stor plov: Dominator 3 felter, Lexion 4, S790 5, de store traktorer 2), og farten i marken er højst ca. 80% af farten i terræn. Arbejdet bliver lige så hurtigt færdigt (lidt hurtigere, fordi de vender færre gange).

### 1.10.4
- Køerne brøler nu **kun**, når dyrene mangler foder – ellers er der ingen kolyd.

### 1.10.3
- **Lyd:** køernes brøl var bare stemning (hvert 10.–25. sekund, når der var køer på skærmen) og betød ikke, at noget var galt. Nu brøler køerne kun i ny og næ (hvert 40.–90. sekund), men tydeligt og ofte, når dine dyr faktisk mangler foder – og så står det også i beskederne (hver 5. dag i stedet for hver 15.) og i Gård-fanen.

### 1.10.2
- Værkstedet har fået sit gamle udseende tilbage.

### 1.10.1
- **Større tekst** i vinduet, når man højreklikker på en bygning – lange linjer brydes nu pænt, og vinduet bliver bredere efter behov (følger også tekststørrelsen).
- **Nyt værksted (pixel):** en høj stålhal på muret sokkel med en stor, åben port med gul/sort karm – inde står en traktor på liften – og et lille kontor med vindue og dør.

### 1.10.0
- **Brage L120 – klassisk stor gummiged** (24.000 kr, gul med kantet førerhus, store dæk og bred skovl): løfter 4 baller ad gangen (8 med balleklo), mugger staldene ud, og med den på gården klarer køer, får og heste sig med 15% mindre grovfoder (den lille gummiged: 10%).

### 1.9.0
- **5 gemmepladser** til singleplayer og 5 til spil som vært. *Fortsæt* fortsætter det senest gemte spil; knappen *Alle* under den viser alle pladser med dato, spillere og hvornår de blev gemt – spil eller slet (Slet skal bekræftes). Ved et nyt spil vælger du pladsen nederst på kortsiden (første tomme plads er valgt; en optaget plads viser, hvad der overskrives). Tidligere gemte spil ligger i plads 1.

### 1.8.1
- **Rettelse:** traktoren kunne stadig se ud til at vende frem og tilbage under markarbejde. Årsagen var de hurtige positionsbeskeder (20 pr. sekund) for maskiner på vej mellem to felter: de sendte maskinens rå position (feltets midte), mens de almindelige beskeder sendte den udglattede – så maskinen hoppede frem og tilbage. Nu sender begge det samme.

### 1.8.0
- **Udmugning:** hold ved stalddøren med gummigeden eller minilæsseren og tryk E – stalden mugges ud og får frisk strøelse: dyrene i den yder 5% mere i 30 dage, og møget kommer i gylletanken. En lille møddingbunke ved porten viser, at der er muget for nylig.
- **Hul i hegnet efter storm:** stormen kan slå hul i foldens hegn – så kan dyrene smutte ud ligesom ad en åben låge. Kør ud på en ATV, UTV eller terrænbil og tryk O ved hullet, eller klik på det med *Fold og hegn* (50 kr).
- **Kælvning og læmning om foråret:** en ko eller et får lægger sig ude i folden (et gult udråbstegn). Kør derud inden for 3 dage, så får du en kalv eller et lam mere (er der ikke plads, sælges det til naboen).

### 1.7.0
- **Låger i foldens hegn:** hegnet spærrer nu, når du selv kører – ind og ud af folden går gennem en låge. Klik på hegnet med *Fold og hegn* for at sætte en låge (150 kr; hver fold får automatisk én gratis, også i gamle gemte spil) eller åbne/lukke den. Mens du kører, åbner og lukker **O** den nærmeste låge. Står en låge åben, kan en ko, et får eller en hest smutte ud og gå en tur – den giver intet, før den er tilbage (luk lågen, eller vent et par dage). Maskiner, der kører selv, åbner og lukker selv.

### 1.6.0
- **Baller i folden:** kør en halm- eller wrapballe ud i folden med en læsser (frontlæsser, minilæsser, gummiged eller gaffeltruck) og sænk den (E) – så står den i en foderhæk, og køer, får og heste yder 5% mere (mælk, uld, rideskolens betaling) i 30 dage. Én balle rækker til 20 køer/heste eller 60 får; store flokke skal have flere. Wrapballer ædes samtidig som ensilage. Læsseren kan nu også løfte baller fra lageret ved ballepladsen (E). Bonussen kommer oven i strøelsen (+15%) og er aldrig et krav.

### 1.5.0
- **Rullebjælke i sidepanelet til højre:** er teksten forstørret (eller skærmen lav), får fanerne Gård, Opgaver, Handel, Fælles og Råd en tydelig rullebjælke. Træk i den, klik over/under den for en side ad gangen, eller brug musehjulet. En lille pil nederst viser, at der er mere.

### 1.4.2
- **Rettelse:** ved langsom hastighed kunne traktoren se ud til at vende frem og tilbage på marken, når den gik fra ét felt til det næste (den hoppede tilbage til feltets midte). Nu kører den jævnt videre – også hen til første felt og væk fra marken bagefter.

### 1.4.1
- **Rettelse:** med flere traktorer kunne en traktor gå i gang med at pløje og så overlade marken til en bedre traktor, der blev ledig (fx efter værksted eller tankning). Nu gør den, der er i gang, marken færdig – den bedre traktor tager den næste mark.

### 1.4.0
- **Nye stuehuse:** stråtækt længehus (2×1), tolænget gård (3×2), moderne landhus (1×1) og firlænget gård (4×4, +7 prestige). Stuehusvinduet viser design og tilbygninger i to spalter.

### 1.3.0
- **Rundbuehal**, som enten kan være maskinhal eller halmlager og kan bygges om for 500 kr.

### 1.2.1
- **Pixel er nu standardgrafik** for køretøjer, bygninger, veje, dyr og træer (tidligere valg i indstillingerne bevares). Nye ting tegnes fremover kun i pixel.

### 1.2.0
- **Fodersilo** med foderplan: billigste korn først, og grise og høns giver 10% mere.
- **Tekststørrelsen** gælder nu også Årsrapport, Byg og køb, Banken og Maskinhuset – vinduerne bliver aldrig større end skærmen.
- **Rettelse:** bankens overskrift sad for højt.

### 1.1.0
- **Nye maskiner og redskaber:** store vogne (tipvogn, ballevogn, kreaturvogn, mælketankvogn), gummiged, rendegraver, Hjort S790-mejetærsker, gyllevogn (også med slæbeslanger), kartoffeloptager og stubharve.
- **Nye bygninger:** gylletank, kartoffellager, malkerobot, stort hønsehus og stor fårestald – og læhegn under Gårdhegn.
- **Spillet:** årets længde kan vælges (+20 % som standard), sultne dyr giver intet, automatisk foderkøb, byens faste ordninger løber et helt år, og fanen *Automatik* samler alt det, der kører af sig selv.
- **Visning og menuer:** tekststørrelse 100–140 % (også i Styr selv-panelet), rulning i sidepanelet, vejr og skader for nye spil i hovedmenuen, og knappen *Afskedig* ved driftslederen.
- **Rettelser:** lastbiler og maskiner kører glat og tager hjørnerne, maskinerne kører over egen mark i stedet for omveje ad asfalten, tømmer køres til tømmerpladsen, stammer i skoven ligner stammer, grøftekanter bliver hvide i sne, og kalkning viser sprederen.
- **Multiplayer:** værten tjekker, at alle har samme version, og siger tydeligt til, hvis ikke.

### 1.0
- Første udgave.
