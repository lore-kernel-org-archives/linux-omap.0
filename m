From: Sebastian Reichel <sre@ring0.de>
Subject: Re: runtime check for omap-aes bus access permission (was: Re:
 3.13-rc3 (commit 7ce93f3) breaks Nokia N900 DT boot)
Date: Sun, 8 Dec 2013 00:03:06 +0100
Message-ID: <20131207230305.GA9103@earth.universe>
References: <20131206213613.GA19648@earth.universe>
 <201312070918.32471@pali>
 <20131207134818.GA933@earth.universe>
 <201312071457.38836@pali>
 <20131207165104.GD11015@atomide.com>
 <20131207184958.GB3704@earth.universe>
 <20131207211137.GR26766@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ring0.de ([91.143.88.219]:49411 "EHLO smtp.ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754726Ab3LGXDj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 7 Dec 2013 18:03:39 -0500
Content-Disposition: inline
In-Reply-To: <20131207211137.GR26766@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, linux-omap@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>, Joel Fernandes <joelf@ti.com>


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 07, 2013 at 01:11:37PM -0800, Tony Lindgren wrote:
> > I asked Pali to send me his copy of the updated NOLO bootloader,
> > so that I can test this. I just checked the omap documentation
> > (I only have access to the public one) and crypto related stuff
> > is not documented for the L3_PM_READ_PERMISSION register. There
> > are a couple of reserved bits, which may be used for this, though.
> >=20
> > I also CC'd Joel Fernandes, since he worked on the driver before and
> > may have access to the documentation.
>=20
> Looks like at least the 36xx public version referenced here has them:
>=20
> http://www.spinics.net/lists/linux-omap/msg21857.html
>=20
> I'd assume the registers are the same for 34xx since we don't have
> them defined separately in the kernel.

I can't find it in the omap36xx documentation either. Maybe I search
at the wrong position. I tried to find something crypto related in

Table 9-89. L3_PM_READ_PERMISSION_i

-- Sebastian

--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBCAAGBQJSo6kpAAoJENju1/PIO/qaGkoQAKc0rM0PnIEc7NAQaWCfUe2J
slSnftQH09lXJQ2vkjTU7eThWkOZI5RPjH2ykSu4z7F3AOQfzvcUU9zGl5Ke5Suu
Vfmi/qcY8I3nbEyodB9wmDwaoHqWRPfombg7BG7IZNoZIZ7JVI0892RGYc0FXNpV
MWkmglrOE1D+JNoEU/YG4/U0vczLG9kXx+TMe1hSV6zTxPeDbrq9ojWMOnc0h39D
3eBdum38X+mv+v+JgtAOW3MhJfnIrBoHJR8+ao0NaOG1CzNqp8WBkN4B7ScgBTS/
FEh8wfYxI0WhYEFKpbDbGDpBLVtOzZHPbYYDKjYgF9JYLnTto7mXTrjGnb9Q2FQK
VQr765RuOnNiddSfc+mLTgMNer+EoTMLXC3oCHRO1+5eXWufnIgUNTRlFqcaPP+9
FnXZ6klBOGJXSPazfogP3BCjcrc8/VLiM1k51EG476l4N9nwZTKg4aB5wVrojS1v
OV5Gn/ZFXwvRl3hJuXIX/Iuq95FXVM+0NOClvoCyc7ifJkl6YRWtAg7FLpikyYMB
8PN0y5ybxuwAni4rWqk9XwwYG+qBsqQcXbUry+FLMY08Cut5k527FM2Guek0ZpR2
JaKQ0UCC4KjmPvUKDKjzuc5BKPtw1jBDlIHJUdA2ord3qCX19RDXKYIFk7VeHjAx
+UjCLcS+9Xo9hNORxiv/
=70zG
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--
