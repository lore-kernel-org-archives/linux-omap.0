From: Pavel Machek <pavel@ucw.cz>
Subject: bq27xxx: what is going on with MSLEEP() macro
Date: Mon, 25 Sep 2017 10:05:11 +0200
Message-ID: <20170925080510.GA31768@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="9jxsPFA5p3P2qPhR"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: sebastian.reichel@collabora.co.uk, pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com, kernel@networkimprov.net
List-Id: linux-omap@vger.kernel.org


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

0670c9b35 drivers/power/supply/bq27xxx_battery.c #define BQ27XXX_MSLEEP(i) =
usleep_range((i)*1000, (i)*1000+500)

Liam, is this really neccessary? Defining MSLEEP to be USLEEP_RANGE is
quite sneaky and confusing. Plus I don't believe we should be
usleep-ing for 25msec. Can we just replace it with regular msleep?

0670c9b35 drivers/power/supply/bq27xxx_battery.c         /* DO NOT read BQ2=
7XXX_DM_CKSUM
here to verify it! That may cause NVM

Normal kernel style for multi-line comments is

/*
 * foo
 */

Can you fix those?

Thanks,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--9jxsPFA5p3P2qPhR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlnIuLYACgkQMOfwapXb+vIL6QCfTi1+/E3yAmGNblgCPRxhoVjR
6fIAn1CnL63kQP79UGGfXmnKsFfj7cL5
=b+kv
-----END PGP SIGNATURE-----

--9jxsPFA5p3P2qPhR--
