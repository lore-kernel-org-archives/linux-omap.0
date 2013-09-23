From: Sebastian Reichel <sre@ring0.de>
Subject: Re: [PATCH 4/4] RX-51: Add platform function and data for bq24150a
 charger
Date: Mon, 23 Sep 2013 22:47:15 +0200
Message-ID: <20130923204714.GB22995@earth.universe>
References: <1378630239-10006-1-git-send-email-pali.rohar@gmail.com>
 <201309232116.19161@pali>
 <20130923200008.GA21808@earth.universe>
 <201309232206.47391@pali>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vGgW1X5XWziG23Ko"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201309232206.47391@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, freemangordon@abv.bg, aaro.koskinen@iki.fi, pavel@ucw.cz
List-Id: linux-omap@vger.kernel.org


--vGgW1X5XWziG23Ko
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2013 at 10:06:46PM +0200, Pali Roh=E1r wrote:
> On Monday 23 September 2013 22:00:09 Sebastian Reichel wrote:
> > On Mon, Sep 23, 2013 at 09:16:18PM +0200, Pali Roh=E1r wrote:
> > > It is not as simple as it looks. This is reason why I
> > > submited this patch long time after I submited bq2415x
> > > driver.
> > >=20
> > > Problem is that for rx51 is needed specific function which
> > > connect to two drivers (bq2415x and isp1704) plus it call
> > > specific rx51 board functions.
> > >=20
> > > Something which cannot be in DT (unless DT support C/ASM
> > > code).
> >=20
> > mh could isp1704 driver expose the data via the regulator
> > framework?
>=20
> No, isp1704 is power supply driver and export data via power=20
> supply (sysfs) interface. It is not regulator but charger driver.

well it does not charge the battery directly, but just provides a
power line with 5 Volt and a specified amount of current to the
system, doesn't it?

=46rom my POV this is a candiate for the regulator framework:

https://www.kernel.org/doc/Documentation/power/regulator/overview.txt

-- Sebastian

--vGgW1X5XWziG23Ko
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBCAAGBQJSQKjSAAoJENju1/PIO/qa+8sP+wfWRfRSXNYLypgsVcts915N
/28LyZzg9roUtzo2XZvx3KcY1XM6XfXPeEc3ELmySx2/g6xyXD3PLNA8ZVDFc6Us
3uU5CorwWrBWInBMaiKi3jyKOdr8rsk6VZ7ZXNDHXtRwaencoo3nZw6aD9cYtUuH
PG/9FvKAT/KHvHpmWA/uXX3iVKeR2QDhLtJ+sZb04LKtLwNG523Qz8dG59CCRivG
xOhDAyY8Clmb9O7JM2vEHIYbRLRJBo1HXY2zwbJ4Y4qtv/6Ko0HqWKWZmRClF1oy
+MPutgnr5jUPyr18cHeXGx3k0LYXwpa/NqwXY7gAVn58wAN23P/gYMOIO5xC62Xj
r5x0YdidwkRNheH60N8bW+ifLMLl0bGOy6QmgPcfl3Az7u2gnyPB78TbzGAugm4a
rTbtIycX25UF2Dw7A/3mH2nM5JrEIFRe/oZDggLV5XtppCBZTL/f+bV+eTXZ/7WS
jSUqhH1xgKfABP/cyEnJAMLoIvtpFUdVQhB3jXmJqwMFBn6c5M2fzUduUALx9MS9
7eiczgJ0/rtdvprgMNiA1G/ikcfJe9CdKLa51Dbg7FWZ6hNgTtdC+AYwm8H9bxR/
GtUPyxIbpoCy/H0N984dCrF+9sBFmowh7andidE7OhkLSGMHEtX7OsHREXNz+y3x
L+wJmo9OYGYrUYi8SH+v
=4716
-----END PGP SIGNATURE-----

--vGgW1X5XWziG23Ko--
