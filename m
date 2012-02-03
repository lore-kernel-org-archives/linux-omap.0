From: NeilBrown <neilb@suse.de>
Subject: Re: patch "tty: serial: OMAP: ensure FIFO levels are set correctly
 in non-DMA" added to tty tree
Date: Sat, 4 Feb 2012 09:10:48 +1100
Message-ID: <20120204091048.00c7e027@notabene.brown>
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
	<alpine.DEB.2.00.1202031243270.27947@utopia.booyaka.com>
	<alpine.DEB.2.00.1202031432080.27947@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/0.E7+2uffOjLYNTl5S=AskQ"; protocol="application/pgp-signature"
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.00.1202031432080.27947@utopia.booyaka.com>
Sender: linux-serial-owner@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Grazvydas Ignotas <notasas@gmail.com>, Greg KH <gregkh@suse.de>, greg@kroah.com, khilman@ti.com, govindraj.raja@ti.com, tomi.valkeinen@ti.com, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--Sig_/0.E7+2uffOjLYNTl5S=AskQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 3 Feb 2012 14:42:09 -0700 (MST) Paul Walmsley <paul@pwsan.com> wrot=
e:

> One correction on this part...
>=20
> On Fri, 3 Feb 2012, Paul Walmsley wrote:
>=20
> > On Fri, 3 Feb 2012, NeilBrown wrote:
> >=20
> > > My theory is that there is a delay between the falling RX line waking=
 the
> > > system up, and the CPU enabling the UART - whether enabling the clock=
s or
> > > doing a full config, I am not sure - though I think the former.
> > >=20
> > > Maybe if we could enable the UART clocks immediately after returning =
from the
> > > WFI instruction we could avoid the corruption....
> >=20
> > The PRCM should be re-enabling the UART's functional clock itself, with=
 no=20
> > kernel involvement.  The sequence should go something like this=20
> > (simplified):
> >=20
> > 1. I/O wakeup occurs
> >=20
> > 2. CORE & PER powerdomains are awakened
> >=20
> > 3. The UART notices an event on its input lines and deasserts its idle-=
ack
>=20
> It just occurred to me that, supposedly, the only UART input line that is=
=20
> attached to the SWAKEUP signal is CTS.  So the UART may not in fact be=20
> able to deassert its idle-ack autonomously at this point.

How does that relate to the RX_CTS_WU_EN bit which enables an interrupt on=
=20
    "a falling edge of pins RX, nCTS, or nDSR"

This seems to be a "wakeup interrupt", bit it isn't clear what it wakes us.

>=20
> So you might want to give your clock re-enable after WFI idea a shot!  It=
=20
> would be interesting if it helps.

Might be a bit beyond me at the moment :-(

Thanks,
NeilBrown

>=20
> I regret the oversight,=20
>=20
>=20
> - Paul


--Sig_/0.E7+2uffOjLYNTl5S=AskQ
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQIVAwUBTyxbaTnsnt1WYoG5AQKukg/8CiNXLevn0vwfV9D0OxNJZh0JZh02HitE
l5o98xwxoRfkDtcuYJL9jVRhZzrXYRbjsBS7ti9rZ772W4sQ6JG/HMZD80JBNNmB
QiEofhw5uAIVJTJUvPxxAtSA0UW6LM8lcbOORHgsZMS70cTFviokAtcQ0jftcjC1
+Uep4gUrXxW1iHuoP7wTeOXjwAMwDtJdtVN8u+UsVYH4SHjFFbafWKFcPT6i79TS
wb3haLVFiYXm+Ie28Ye5+5NXR25mOk+2IyIyni/mTLvWSPUi6GwgS8NiwdhjADh9
mDZEuMGIpqjRU8eikkpWbxwrkD4rmobCi+Tk8gtpprxolAeWcr0rKNqQgTCIp19Y
9iavXdTsQGRAcnlK+AfPeWMv8FWOSmRaUqLofdJ2ij2HnESeXCaMUvwHqPIoSlls
bN+qCsy1/CidIC0oY6NhHCoqSgcI8hVl7a/9F/wSTFyFfRRhv3z3t0KOcIsToB33
fFPBLtQo9YuqoP309c11TEF6ude7nYFI+Ih/eKFxFJ10U1q+6asoELIN+AWgVys0
7D7gsGinwspl/lK4wbNJsF7yI0aVrGH2Ct0cLwTbovmmQGcZZtiq3kYodGLytPUj
m6texG/aQijJaImKvDVSbHVslVNbH5AKJcZr5Hz4/JVvbDL3POLeuShYhkyXadnh
oE9a7gFELuo=
=bvFG
-----END PGP SIGNATURE-----

--Sig_/0.E7+2uffOjLYNTl5S=AskQ--
