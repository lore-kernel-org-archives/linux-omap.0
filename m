From: "witek mark" <witek_temp@wp.pl>
Subject: Re: [RFC][PATCH 4/5] input: serio: add
 supportforAmstrad Delta serial keyboard port
Date: Thu, 17 Dec 2009 17:37:58 +0100
Message-ID: <4b2a5e66d26737.02520544@wp.pl>
References: <D615D960-7E56-492A-9CA0-BA66CF3AAF9B@gmail.com><200912122134.08795.jkrzyszt@tis.icnet.pl><20091212232003.GA16760@core.coreip.homeip.net><200912140111.36458.jkrzyszt@tis.icnet.pl>
	<4b2a5010773714.47572109@wp.pl>
Reply-To: Discussion of the Amstrad E3 emailer hardware/software
	<e3-hacking@earth.li>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <e3-hacking-bounces@earth.li>
In-reply-to: <D615D960-7E56-492A-9CA0-BA66CF3AAF9B@gmail.com><200912122134.08795.jkrzyszt@tis.icnet.pl><20091212232003.GA16760@core.coreip.homeip.net><200912140111.36458.jkrzyszt@tis.icnet.pl>
	<4b2a5010773714.47572109@wp.pl>
Content-Disposition: inline
List-Unsubscribe: <http://www.earth.li/cgi-bin/mailman/options/e3-hacking>,
	<mailto:e3-hacking-request@earth.li?subject=unsubscribe>
List-Archive: <http://www.earth.li/pipermail/e3-hacking>
List-Post: <mailto:e3-hacking@earth.li>
List-Help: <mailto:e3-hacking-request@earth.li?subject=help>
List-Subscribe: <http://www.earth.li/cgi-bin/mailman/listinfo/e3-hacking>,
	<mailto:e3-hacking-request@earth.li?subject=subscribe>
Sender: e3-hacking-bounces@earth.li
Errors-To: e3-hacking-bounces@earth.li
Cc: e3-hacking <e3-hacking@earth.li>, Tony Lindgren <tony@atomide.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

I'm sorry for my latest mail written in Polish. I wanted to consult some =

amstrad keyboard thing with Janusz Krzysztofik. I accidently put to many =

recipients.


regards

Witold Markowski






Dnia 17-12-2009 o godz. 16:36 witek mark napisa=B3(a):
> Witam,
> =

> =

> Od jakiego=B6 czasu obserwuj=EA grup=EA dyskusyjn=B1 Amstrada. Sam posiad=
am
> jeden egzemplarz i co=B6 tam sobie na nim pr=F3buj=EA uruchomi=E6.
> Chcia=B3em si=EA podzieli=E6 kilkoma spostrze=BFeniami dotycz=B1cymi klaw=
iatury.
> Na razie nie odpisuj=EA na grup=EA tylko do Pana.
> =

> Zaintrygowany mailem dotycz=B1cym klawiatury postanowi=B3em j=B1 rozkr=EA=
ci=E6 aby
> zobaczy=E6 co w =B6rodku jest. Okazuje si=EA, =BFe p=B3ytka klawiatury je=
st
> "przyspawana" do jednej ze stron obudowy. Trzeba by wy=B3ama=E6 par=EA
> zatrzask=F3w, =BFeby obejrze=E6 te stron=EA p=B3ytki drukowanej, gdzie s=
=B1
> rozmieszczone elementy - dlatego na razie da=B3em sobie z tym spok=F3j. I=
d=B1c
> dalej rozkr=EAci=B3em tego gamepada. Jak si=EA ponadto okazuje ten gamepad
> wpina si=EA mi=EAdzy amstrada a klawiatur=EA. Klawiatura i gamepad maj=B1
> interfejs z=B3o=BFony z czterech pin=F3w i po sprawdzeniu miernikiem okaz=
uj=EA
> si=EA, =BFe klawiatura i gamepad je=B6li si=EA je po=B3=B1czy razem do am=
strada to
> s=B1 one pod=B3=B1czone r=F3wnolegle do tych pin=F3w (jestem tego pewien =
na 90%).
> Ponadto po rozkr=EAceniu gamepada ukaza=B3a mi si=EA p=B3ytka drukowana a=
le
> niestety nie wiem co to jest za chip elektroniczny w =B6rodku, gdy=BF ma =
on
> posta=E6 "czarnego okr=B1g=B3ego kleksa plastikowego" (szkoda, =BFe nie z=
robi=B3em
> zdj=EAcia). Jedno jest pewne: na tej p=B3ytce te cztery piny interfejsu b=
y=B3y
> opisane jako GND, VCC, CLK i DATA. Czyli wnioskuj=B1c musi to by=E6 jaki=
=B6
> interfejs szeregowy. Ponadto wiemy ju=BF, =BFe klawiatura i gamepad s=B1
> pod=B3=B1czane r=F3wnolegle do amstrada, czyli musi to by=E6 interfejs
> szeregowy, kt=F3ry niejako "wspiera" po=B3=B1czenie kilku urz=B1dze=F1 do=
 jednej
> magistrali.
> Mo=BFe to jest zwyk=B3y interfejs szeregowy typu rs232?
> Za=B3=F3=BFmy na chwilk=EA, =BFe jest to interfejs rs232. Mo=BFemy wtedy =
stwierdzi=E6,
> =BFe:
> a) klawiatura generuje jaki=B6 zestaw kod=F3w klawiszy,
> b) gamepad generuje ten sam zestaw kod=F3w klawiszy - mo=BFe i tak by=E6,
> wtedy gamepad zachowuje si=EA jako "specjalna klawiatura na potrzeby gier"
> i tak naprawd=EA mo=BFna powiedzie=E6 =BFe na amstradzie gra si=EA na kla=
wiaturze
> a gamepad tylko u=B3atwia "wciskanie guzik=F3w",
> c) pisze Pan, =BFe je=B6li gamepad i klawiatura s=B1 pod=B3=B1czone jedno=
cze=B6nie i
> jednocze=B6nie cos na nich naciskamy to obserwuje Pan w sterowniku b=B3=
=EAdy
> typu: parity check failed, invalid stop bit. O ile moja znajomo=B6=E6
> protoko=B3=F3w transmisji jest dobra, to wychodzi na to, =BFe te b=B3=EAdy
> wyst=EApuj=B1 w=B3a=B6nie w transmisji szeregowej rs232 (chyba, =BFe jest=
 jaki=B6
> inny podobny protok=F3=B3 transmisji). O ile naciska Pan przycisk tylko na
> jednym urz=B1dzeniu to wszystko jest w porz=B1dku; urz=B1dzenie wysy=B3a =
np kod
> klawisza, a interfejs szeregowy dodaje jeszcze bity parzysto=B6ci
> (kontrola b=B3=EAd=F3w) i stopu. Je=B6li teraz zaczniemy co=B6 naciska=E6=
 na drugim
> urz=B1dzeniu to ono r=F3wnie=BF wysy=B3a sw=F3j kod b=B3=EAdu, bity parzy=
sto=B6ci i bity
> stopu. Wtedy mo=BFe dochodzi=E6 np do kolizji (klawiatura wysy=B3a w danym
> momencie bit stopu a gamepad wysy=B3a sw=F3j kod klawisza) i port szerego=
wy
> w amstradzie "g=B3upieje" i zg=B3asza b=B3=EAdy typu parity check failed,
> invalid stop bit). Generalnie w porcie szeregowym typu rs232 mo=BFna
> pod=B3=B1czy=E6 kilka urz=B1dze=F1 r=F3wnolegle, tylko jak przynajmniej d=
wa zaczn=B1
> nadawa=E6 w tej samej chwili to zaczynaj=B1 si=EA kolizje.
> =

> W sterownikach linuxa nie jestem za mocny dlatego nie mam poj=EAcia jak
> jest napisany dotychczasowy driver. Gdybym mia=B3 oscyloskop to bym
> sprawdzi=B3 komunikacj=EA na tych pinach i by si=EA okaza=B3o czy to jest
> rzeczywi=B6cie transmisja typu rs232.
> =

> =

> Co Pan my=B6li o moich tezach? A mog=EA dosta=E6 Pa=F1skie logi ze sterow=
nika?
> Mo=BFe co=B6 uda si=EA wymy=B6li=E6.
> =

> =

> pozdrawiam
> =

> =

> Witold Markowski
> =

> =

> =

> =

> =

> =

> =

> =

> =

> Dnia 14-12-2009 o godz. 1:11 Janusz Krzysztofik napisa=B3(a):
> > Hi Dmitry,
> > =

> > Sunday 13 December 2009 00:20:03 Dmitry Torokhov napisa=B3(a):
> > >
> > > atkbd is supposed to support PS/2 devices speaking AT keyboard protoc=
ol.
> > > We also do support such devices behind dumb controllers that do not
> > > allow querying the device but we expect those to at least produce the
> > > standard scancodes.
> > =

> > As far as I can understand, using the atkbd driver is not a good idea in
> > this
> > case because of the keyboard not producing standard scancodes, correct?
> > =

> > Isn't the hpps2atkbd.h provided keycode table an already supported way =
of
> > introducing exceptions to this standard scancodes requirement? Why
> > couldn't
> > this method be reused here?
> > =

> > What I am afraid of is if the driver supposed to be created instead
> > wouldn't
> > require reiplementing most of the atkbd code.
> > =

> > > I would need to know a bit more about the gamepad, but so far I still
> > > think that current attempot of creating intermediate serio module whi=
ch
> > > allows to use atkbd driver is not the proper solution.
> > =

> > I modified the serio driver to send exactly what it gets from the buffer
> > and
> > examined its output with serio_raw. The gamepad (can be connected
> > simultaneously) appeared to send exactly the same scancodes as the
> > keyboard
> > did. I couldn't see how those might be destinguished whether coming from
> > the
> > keybord or from the gamepad. Thus, handling them both together as a sin=
gle
> > device would probably be the only option here.
> > =

> > With both devices connected and keys pressed simultaneously, errors
> > occure at
> > the lowest level: parity check failed, invalid stop bit, etc. I don't
> > think
> > it would be possible to do anything about this. But this also means that
> > trying to query them in order to get a sensible response would probably=
 be
> > not reliable.
> > =

> > Any thoughts?
> > =

> > Thanks,
> > Janusz
> > =

> > _______________________________________________
> > e3-hacking mailing list
> > e3-hacking@earth.li
> > http://www.earth.li/cgi-bin/mailman/listinfo/e3-hacking
> =

> ----------------------------------------------------
> Ko=B3odziej b=EAdzie mia=BFd=BFy=B3 na ringu
> 18 grudnia, Gala Boksu w =A3odzi
> Zobacz:
> http://klik.wp.pl/?adr=3Dhttp%3A%2F%2Fcorto.www.wp.pl%2Fas%2Fwojak18grudn=
ia.html&sid=3D926
> =

> =

> =

> _______________________________________________
> e3-hacking mailing list
> e3-hacking@earth.li
> http://www.earth.li/cgi-bin/mailman/listinfo/e3-hacking

----------------------------------------------------
Podniebny prezent =B6wi=B1teczny
Niepowtarzalny, dla ka=BFdego
Ekspresowa dostawa
Sprawd=BC: http://klik.wp.pl/?adr=3Dwww.skacz.pl&sid=3D933
