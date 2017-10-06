From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Questions about bluetooth on N900
Date: Fri, 6 Oct 2017 09:29:57 +0200
Message-ID: <20171006072957.GA18994@amd>
References: <87tvzow7jv.fsf@sange.fi>
 <20170927160611.GA10775@xo-6d-61-c0.localdomain>
 <87h8vkpvtu.fsf@sange.fi>
 <20171001090133.GA16848@amd>
 <20171001145051.7pyzz4bpodkd6i2b@earth>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171001145051.7pyzz4bpodkd6i2b@earth>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Aura Kelloniemi <kaura.dev@sange.fi>, pali.rohar@gmail.com, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com
List-Id: linux-omap@vger.kernel.org


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > >  > There is some interest. I'd like to have working bluetooth, and pe=
ople from postmarketos
> > >  > would probably like something, too. Unfortunately my experience is=
 same as yours -- current
> > >  > mainline does not work well on N900.
> > >=20
> > > I might try debugging that at some point, but I doubt I can resolve t=
he issue,
> > > because I have no experience in serial port programming. With latest =
BlueZ I
> > > got my braille display working for few seconds, before it stalled.
> > >=20
> > >  > > I'm considering to rebase the old hci_h4p driver on current main=
line, because
> > >  > > I just need a working BT connection, not code that is of good qu=
ality. Some
> > >=20
> > >  > Ok, I may save you some work. I have rebased version, it should be=
 in
> > >  > linux-n900 on kernel.org.
> > >=20
> > > I found a repo from
> > > https://kernel.googlesource.com/pub/scm/linux/kernel/git/pavel/linux-=
n900/. I
> > > assume that's what you meant.
> > >=20
> > > The latest version is based on 4.13, but it has also some changes whi=
ch seem
> > > not to be related to BT. I incorporated them also, but I don't know i=
f they
> > > are valid.
> >=20
> > Feel free to take those or not.
> >=20
> > > I was lucky that you had done rebasing of nokia_h4p, because I wouldn=
't have
> > > known what to do with DTS.
> > >=20
> > > Unfortunately the driver does not work properly. I can access N900 to=
 some
> > > extent with my braille display, but the connection has random freezes=
, and
> > > accessing my GPS receiver (through RFCOMM) causes the whole system to=
 hang.
> > >=20
> > > I get the following message to syslog something like 100 times per se=
cond when
> > > BRLTTY (the braille display daemon) is communicating with the display:
> > > Got IIR_RX_TIMEOUT, handling it as IIR_DRI
> > >=20
> > > Active BT connection also seems to trigger a bug in nokia_h4p related=
 to
> > > spinlocks. This happens in random intervals between 0.1 s and 30 s.
> > >=20
> > > The bugs are:
> > > BUG: scheduling while atomic
> > > and
> > > BUG: workqueue leaked lock or atomic
> > >=20
> > > Stack traces suggest that it is (at least sometimes) caused by h4p_se=
t_clk
> > > calling clk_prepare_enable and clk_disable_unprepare functions, which=
 should
> > > only be used in non-atomic context.
> > >=20
> > > So, I thought it would be good for you to know that BT does not reall=
y work. I
> > > would like to work on this, but I'm afraid my knowledge is too limite=
d to
> > > track this down. It would be good to know what is causing those IIR RX
> > > timeouts.
> > >=20
> > > Also working on an obsolete driver feels like stupid now that there i=
s a
> > > driver written more properly.
> >=20
> > Yes, fixing obsolete driver is hard and has drawbacks. The new one
> > should be fixed.
> >=20
> > I believe the way forward would be
> >=20
> > a) add logging to the old driver, to see exact data being exchanged
> > during initialization.
> >=20
> > b) add logging to the new driver, and compare old and new driver
> >=20
> > c) fix the new driver to do the initialization same way the old driver
> > did
>=20
> FWIW I don't think the problem on N900 with hci_nokia ("new") driver is
> related to incorrect data/packets being sent. I'm pretty sure there is
> still some problem with the handling of flow control signals (RTS/CTS +
> the GPIOs) resulting in packets not being sent and/or received properly.

Yes, that's possible. So logging RTS/CTS + gpio transitions along with
data will be useful.
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlnXMPUACgkQMOfwapXb+vLIdACgklep7BL/prdEupAyERGMYKhM
9yMAoMAwd3yTIY0saQyNXlayNNV7tHBn
=kXzC
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--
