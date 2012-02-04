From: NeilBrown <neilb@suse.de>
Subject: Re: patch "tty: serial: OMAP: ensure FIFO levels are set correctly
 in non-DMA" added to tty tree
Date: Sat, 4 Feb 2012 13:31:01 +1100
Message-ID: <20120204133101.1ab3500f@notabene.brown>
References: <13274430881471@kroah.org>
	<alpine.DEB.2.00.1201251156361.5324@utopia.booyaka.com>
	<20120126042155.GA3185@suse.de>
	<alpine.DEB.2.00.1201252124470.11174@utopia.booyaka.com>
	<20120126191604.GA15516@suse.de>
	<alpine.DEB.2.00.1201261225520.32667@utopia.booyaka.com>
	<alpine.DEB.2.00.1202021302070.586@utopia.booyaka.com>
	<20120203150708.386951d2@notabene.brown>
	<alpine.DEB.2.00.1202022137150.586@utopia.booyaka.com>
	<20120203205401.5ddf241d@notabene.brown>
	<CANOLnONsZKHJPbEx2+ic3EZ1PqcD30VT4Z2bR5iW-JNQJQL0GA@mail.gmail.com>
	<20120203231113.25ae2d3a@notabene.brown>
	<EF62F09C0797D947AD4180A1043C0DF73492FFC3@DLEE10.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/5nQB1w_Ii=4s_ffzt.GXUvg"; protocol="application/pgp-signature"
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <EF62F09C0797D947AD4180A1043C0DF73492FFC3@DLEE10.ent.ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: Grazvydas Ignotas <notasas@gmail.com>, Paul Walmsley <paul@pwsan.com>, Greg KH <gregkh@suse.de>, "greg@kroah.com" <greg@kroah.com>, "Hilman, Kevin" <khilman@ti.com>, "R, Govindraj" <govindraj.raja@ti.com>, "Valkeinen, Tomi" <tomi.valkeinen@ti.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

--Sig_/5nQB1w_Ii=4s_ffzt.GXUvg
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sat, 4 Feb 2012 00:23:09 +0000 "Woodruff, Richard" <r-woodruff2@ti.com>
wrote:

>=20
> > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > owner@vger.kernel.org] On Behalf Of NeilBrown
>=20
> > > Not sure if it's the same problem but with 3530 on 3.2 with
> > > sleep_timeout set, I usually get first char dropped (as expected) but
> > > sometimes I get corrupted char instead too. Corrupt char seems to
> > > almost always happen if I set cpufreq to powersave, on performace it's
> > > almost always ok, so maybe it's some timing problem,
> >=20
> > I see that too - I'm glad someone else does :-)
>=20
> When you have aggressive PM working at the SOC level you many times lost =
a character on UART every since OMAP2. A strange but true statement is it i=
s nice to see it losing a character on mainline as it as in indication that=
 PM is likely working.
>=20
> If you just hook up simple RX and TX lines and not other flow control it =
is very likely especially with older OMAPs you can lose the 'wake' characte=
r on debug console. The UART operates on a derived clock from a 96MHz DPLL =
which was probably stopped. When the wakeup event hits the IO ring many int=
ernals may need to repower and its source DPLL needs to relock. This all ca=
n take a while and you can lose the start bit at high baud rate. If you use=
 flow control you might be able to get ahead of it.

So... if flow control is available, then when we idle the uart we should set
the trigger so that RTS is de-asserted as soon as one character arrives.
That would minimise the number of corrupt character we receive and ensure we
resync as early as possible (I have seen 2 corrupt characters when CR,NL
arrive back-to-back.  Neither get through correctly).

Actually ... could we make the off-mode setting of the RTS pin be "ready to
send", but as soon as we wake up, it is reset to "don't send now" until
everything is properly awake and configured?  That should ensure only one
byte is lost.


> Outside of debug console, this loss has not been huge. Protocols like ird=
a would retransmit their magic wake packets. You can move between DMA and i=
nterrupt modes with activity. So far there has been a work around per attac=
hed device.


What about bluetooth?  HCI/UART doesn't seem to have a lot of error
handling.  Maybe it has enough though.
(I have bluetooth on UART1 ... of course we might not have the same problems
on UART1 .. I haven't played with bluetooth much yet).

Thanks for the insights,

NeilBrown

--Sig_/5nQB1w_Ii=4s_ffzt.GXUvg
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQIVAwUBTyyYZTnsnt1WYoG5AQIl6BAAqlCIdQZZAiWEFsc6jwwbH/s5cyj4C1cA
g716jh9uX9sw0UV0PCjl/jcJkCFAwWSYcdE7ilT6+/oeSROAjifqTGcGs1umybNy
CRLJL3hN3zid1li+5vDLoy/GUXIvgnGEaeXLLNj3o1uPGl68MuPTrwd0T8oc1lSl
hTxIQcRbLqDdzfTR+DveFsgZ4OBk1E5GcSNTEe0/lQBTxtn1T8O0DXkr2eMSqbYu
wXVZ3cJJ7s3a1W8XtVXg9BwAGq9zwkVsrnnOnsifSCW4vbkYExuvfHtXa+1Ez2q0
wTBsa5hBWqivq5tn2fKx2K2MGTbW38UweIWd6Lw+gSVivrkn1LtzAiQSjvVQNsCu
RDgH92keq9OYw8NVfI1a5c7A0XrSdy39C3eltL5NTaMoSXr4CJxJSfYucJtuGbRR
IvyQ8Jvsn4D5aXKnrYk8qmJMGtGNeuDM208/6JTQ1QeFDGiNpJDjnkgXqiSvIHfE
UfRUTAAgIZ/PNF7Plc2Z7qr940ZWbaZLAkl7C0MydE8BWvrPb/41GH3DLQGmz2kT
Z/iw1rnOYIp53WNbXviy3v0jBpbUpyLaxf7AO7rbb5qAqT5Vf2SvaU9L8sak6uzR
oisN9ShrWMcKNUrn89JS2fJKuLYtTiRWCWs0PRAhkC/RBVyII/eGWUIii7WuKn8i
oTYp4gBlovA=
=5LPb
-----END PGP SIGNATURE-----

--Sig_/5nQB1w_Ii=4s_ffzt.GXUvg--
