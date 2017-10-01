From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Questions about bluetooth on N900
Date: Sun, 1 Oct 2017 11:01:33 +0200
Message-ID: <20171001090133.GA16848@amd>
References: <87tvzow7jv.fsf@sange.fi>
 <20170927160611.GA10775@xo-6d-61-c0.localdomain>
 <87h8vkpvtu.fsf@sange.fi>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87h8vkpvtu.fsf@sange.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Aura Kelloniemi <kaura.dev@sange.fi>, pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com
List-Id: linux-omap@vger.kernel.org


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

>  > There is some interest. I'd like to have working bluetooth, and people=
 from postmarketos
>  > would probably like something, too. Unfortunately my experience is sam=
e as yours -- current
>  > mainline does not work well on N900.
>=20
> I might try debugging that at some point, but I doubt I can resolve the i=
ssue,
> because I have no experience in serial port programming. With latest Blue=
Z I
> got my braille display working for few seconds, before it stalled.
>=20
>  > > I'm considering to rebase the old hci_h4p driver on current mainline=
, because
>  > > I just need a working BT connection, not code that is of good qualit=
y. Some
>=20
>  > Ok, I may save you some work. I have rebased version, it should be in
>  > linux-n900 on kernel.org.
>=20
> I found a repo from
> https://kernel.googlesource.com/pub/scm/linux/kernel/git/pavel/linux-n900=
/. I
> assume that's what you meant.
>=20
> The latest version is based on 4.13, but it has also some changes which s=
eem
> not to be related to BT. I incorporated them also, but I don't know if th=
ey
> are valid.

Feel free to take those or not.

> I was lucky that you had done rebasing of nokia_h4p, because I wouldn't h=
ave
> known what to do with DTS.
>=20
> Unfortunately the driver does not work properly. I can access N900 to some
> extent with my braille display, but the connection has random freezes, and
> accessing my GPS receiver (through RFCOMM) causes the whole system to han=
g.
>=20
> I get the following message to syslog something like 100 times per second=
 when
> BRLTTY (the braille display daemon) is communicating with the display:
> Got IIR_RX_TIMEOUT, handling it as IIR_DRI
>=20
> Active BT connection also seems to trigger a bug in nokia_h4p related to
> spinlocks. This happens in random intervals between 0.1 s and 30 s.
>=20
> The bugs are:
> BUG: scheduling while atomic
> and
> BUG: workqueue leaked lock or atomic
>=20
> Stack traces suggest that it is (at least sometimes) caused by h4p_set_clk
> calling clk_prepare_enable and clk_disable_unprepare functions, which sho=
uld
> only be used in non-atomic context.
>=20
> So, I thought it would be good for you to know that BT does not really wo=
rk. I
> would like to work on this, but I'm afraid my knowledge is too limited to
> track this down. It would be good to know what is causing those IIR RX
> timeouts.
>=20
> Also working on an obsolete driver feels like stupid now that there is a
> driver written more properly.

Yes, fixing obsolete driver is hard and has drawbacks. The new one
should be fixed.

I believe the way forward would be

a) add logging to the old driver, to see exact data being exchanged
during initialization.

b) add logging to the new driver, and compare old and new driver

c) fix the new driver to do the initialization same way the old driver
did

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlnQru0ACgkQMOfwapXb+vJWHACgu+I4s5p9qPwXSitYu2jItPp2
Wo4An02CGPnkRySWZk9mlC+waF27ImYn
=yK6B
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--
