# Z80-Washing-Machine
Proiect realizat pe macheta Z80

<hr>
	
<h1><b> Documentație proiect </b><br><br>
MAȘINĂ DE SPĂLAT HAINE</h1>

<br>






<b>Disciplina: 			Microcontrolere</b><br>
<b>Profesor îndrumător:</b>	Costache Alexandru<br>
<b>Studenți:</b>		<br>	Hermenean Vlad-Costin<br>
Petrea Gabriel-Cătălin<br>
Povăr Luminița<br>
Ursu Florina Oana<br>

<b>Anul 3, TST </b> <br><br>


	
<h2>Cuprins</h2>
<h3>I.	Descriere proiect</h3>
<h3>II.	Descrierea parților componente utilizate</h3>
<h4>1.	Z80	</h4>
<h4>2.	Memorie 	</h4>	
<h4>3.	Afișor		</h4>
<h4>4.	Tastatura	</h4>	
<h3>III.	Plan de testare</h3>
<h4>1.	Meniu de selecție a tipului de utilizator	</h4>	
<h4>2.	Meniul de administrator	</h4>	
<h4>3.	Meniul de utilizator		</h4>
<h3>IV.	Diagrama de funcționare</h3>


<hr>
	

<br>
<h3>I.	Descriere proiect</h3>
	Tema pe care am ales-o reprezintă : mașină de spălat haine. Acest proiect este realizat pe macheta Z80 și are două opțiuni de selecție a tipului de utilizator : ADMIN(tasta ”A”) sau USER(tasta ”B”).
 În cazul în care a fost selectat meniul de Admin (tasta ”A”) , trebuie introdusă parola ”AA33A3” (dacă este introdusă de 3 ori o parolă greșită, programul se întoarce in meniul de selectare a tipului de utilizator). După ce a fost introdusa parola corecta, pe ecran apare pentru 2 secunde mesajul ”Admin”, pentru a ne informa ca logarea a avut loc cu succes. In meniul de Admin se poate selecta dacă opțiunea de stoarcere să fie activa sau nu (on – tasta ”1”; off – tasta ”0” ) ceea ce va afecta meniul utilizatorului. Modul implicit este cu stoarcerea activata (1). Când se dorește se poate ieși din meniul de Admin apăsând tasta GO (F2), ceea ce ne va trimite la meniul de selecție a tipului de utilizator.  
În cazul în care a fost selectat meniul de User (tasta ”B”), pe ecran apare pentru 2 secunde mesajul ”User”, pentru a ne informa ca logarea a avut loc cu succes. Apoi pe ecran se afișează (”F C E? ”) care reprezintă de fapt lista de selecție a tipului de spălare.  Daca opțiunea de stoarcere este dezactivata, in funcție de ce tip de spălare am ales, Fast (tasta ”F”), Cotton (tasta ”C”) sau Eco (tasta ”E”), se afișează mesajul corespunzător programului de spălare (Fast/ Cotton/ Eco) pentru o perioadă diferita de timp (pentru Fast – 1 secundă; pentru Cotton și Eco – 2 secunde). Daca opțiunea de stoarcere a fost activată, atunci pe ecran se afișează numele programului de spălare, urmat de ”dr” (Fas-dr / Cot-dr/ Eco-dr). La sfârșitul programului de spălare se afișează pe ecran mesajul ”done” pentru 2 secund, iar apoi suntem aduși înapoi la meniul de selecție dintre Admin/User.

<br><br>
<h3>II.	Descrierea parților componente utilizate</h3>
<h4>1.	Z80</h4>
Microprocesorul pe care se face rularea programului. Este un procesor pe 8 biți (ALU accepta operanzi reprezentați pe 8 biți). Magistrala de date e de 8 biți, iar cea de adrese de 16 biți (spațiul de memorie e 64 kB)
<h4>2.	Memorie</h4>
Locul  in care am stocat variabilele utilizate in program.
<h4>3.	Afișor</h4>
Format din 6 afișoare cu 7 segmente si punctul zecimal. 
<h4>4.	Tastatura</h4>
Dispozitiv de intrare. E structurata sub forma matriceala, in fiecare nod de intersecție fiind amplasata o tasta.

<br><br>
<h3>III.	Plan de testare</h3>
<h4>1.	Meniu de selecție a tipului de utilizator</h4>
	Apăsăm tasta ADDR (G) și tastăm adresa 3000. După ce apăsăm GO (F2) ne apare pe emulator textul ”Ad-Usr”. Aici trebuie să selectăm din două opțiuni : dacă dorim să intrăm în modul ADMIN trebuie să apăsăm tasta ”A” . Dacă dorim să intrăm în modul USER trebuie să apăsăm tasta ”B”. La apăsarea oricărei alte taste programul nu reacționează. 

<br>&emsp;
 ![image](https://user-images.githubusercontent.com/103102760/230599693-c8f732fd-ebf3-4b9a-b965-4a9d2f5b5abf.png)


<h4>2.	Meniul de administrator</h4>
<p><b>2.1.</b> Dacă am apăsat tasta ”A” ni se afișează pe emulator textul ”PASS”, care ne indică faptul că putem intra în meniul de ADMIN doar daca introducem parola corectă ”AA33A3”. Dacă introducem de 3 ori greșit parola, programul ne va întoarce in meniul de selecție al tipului de utilizator.</p>

<br>&emsp;
![image](https://user-images.githubusercontent.com/103102760/230599776-528d0ae8-3236-4ca5-81f1-da4c8469f960.png)


<p><b>2.2.</b>	După ce am introdus parola corectă ni se afișează mesajul ”Admin” pentru două secunde pentru a ne informa ca ne-am logat.</p>

<br>&emsp;
![image](https://user-images.githubusercontent.com/103102760/230599814-d0df052c-6b58-4b93-af36-5bdbc5825eae.png)


<p><b>2.3.</b>	După două secunde putem observa un alt mesaj, ”dry-On”, deoarece inițial este prestabilită stoarcerea activă, însă administratorul poate să modifice acest lucru. Dacă se apasă tasta ”1” nu se modifica nimic, deoarece stoarcerea e deja activată. Dacă se apasă tasta ”0”, adică se dezactivează stoarcerea, pe ecran apare ”dry-of”. La apăsarea tastei GO (F2) programul se întoarce in meniul de selecție al tipului de utilizator. La apăsarea oricărei alte taste programul nu reacționează.</p>

<br>&emsp;
![image](https://user-images.githubusercontent.com/103102760/230599910-f2a793d4-e057-4a15-9cd3-35575aee7dc5.png)
&emsp;
![image](https://user-images.githubusercontent.com/103102760/230599949-af3f9a8c-2611-40a2-86db-4f2768e7d4f2.png)


 <br>


<h4>3.	Meniul de utilizator</h4>

<p><b>3.1.</b>	Dacă am apăsat tasta ”B” intrăm în meniul de utilizator și mesajul ”User” pentru două secunde pentru a ne informa ce tip de utilizator am ales.</p> 

<br>&emsp;
![image](https://user-images.githubusercontent.com/103102760/230600028-6184bfea-e99f-411f-9842-952741ae179b.png)


<p><b>3.2.</b>	Apoi pe ecran se afișează textul ”F C E?” care înseamnă de fapt lista din cele 3 tipuri de spălare : Fast (tasta ”F”), Cotton (tasta ”C”), Eco (tasta ”E”).</p> 


<br>&emsp;
![image](https://user-images.githubusercontent.com/103102760/230600055-709a7b90-6c39-4c00-9dbf-8f323d4340db.png)


<p><b>3.3.</b> Din meniul de utilizator se poate ieși oricând in meniul de selecție al tipului de utilizator apăsând tasta ‚”GO” (F2)</p> 


<p><b>3.4.</b> Pentru cazul în care administratorul a selectat ca opțiunea de stoarcere sa fie activată, pe ecran sunt afișate următoarele trei cazuri, in funcție de modul de spălare ales (în funcție de tasta apăsata – F, C sau E):</p> 

<br>&emsp;
![image](https://user-images.githubusercontent.com/103102760/230600107-2d10ef97-ac76-4b6c-9ae5-11f542b28743.png)
![image](https://user-images.githubusercontent.com/103102760/230600120-68a2008f-782e-4d87-806f-41e781508151.png)
![image](https://user-images.githubusercontent.com/103102760/230600139-b897a9cc-f9cf-4af1-8f79-a78908e4dbf2.png)



   
&emsp;3.4.1. După terminarea programului de spălat ales, pe ecran se va afișa timp de 2 secunde mesajul ”done” ce indica sfârșitul acestuia, iar apoi programul ne trimite in meniul de selectare al tipului de utilizator. 
  
<br>&emsp;
![image](https://user-images.githubusercontent.com/103102760/230600189-5a54d3f4-30b8-4c86-9751-76cd61c1582c.png)
&emsp;
![image](https://user-images.githubusercontent.com/103102760/230600216-24c2130e-1562-4921-ae38-9da08d28257d.png)


<br>
<p><b>3.5.</b> Pentru cazul în care administratorul a selectat ca opțiunea de stoarcere sa fie dezactivată, pe ecran sunt afișate următoarele trei cazuri, in funcție de modul de spălare ales (în funcție de tasta apăsata – F, C sau E):</h5>

<br>&emsp;
![image](https://user-images.githubusercontent.com/103102760/230600247-dd16f2f9-cb29-4f01-895c-ce3de0f9671a.png)
![image](https://user-images.githubusercontent.com/103102760/230600261-3f21fcb5-4aec-4c7b-8ea1-4ed33f8c95b2.png)
![image](https://user-images.githubusercontent.com/103102760/230600270-597b2e25-6085-4d01-9840-9dfa1c8ec145.png)



&emsp;3.5.1. După terminarea programului de spălat ales, pe ecran se va afișa timp de 2 secunde mesajul ”done” ce indica sfârșitul acestuia, iar apoi programul ne trimite in meniul de selectare al tipului de utilizator. 

<br>&emsp;
![image](https://user-images.githubusercontent.com/103102760/230600316-9ad07e20-c6bb-400d-96d8-d60b210043f3.png)
&emsp;
![image](https://user-images.githubusercontent.com/103102760/230600331-cf3592c7-cdc0-4298-b81d-a478c6935c76.png)




<br><br>
<h3>IV.	Diagrama de funcționare </h3>
<br>&emsp;
![image](https://user-images.githubusercontent.com/103102760/230600908-bd175144-a53e-43e4-b0f4-da523de59591.png)

