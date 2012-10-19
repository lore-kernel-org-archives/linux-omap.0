From: Felipe Balbi <balbi@ti.com>
Subject: Re: OMAP baseline test results for v3.7-rc1
Date: Fri, 19 Oct 2012 22:01:36 +0300
Message-ID: <20121019190136.GA4229@arwen.pp.htv.fi>
References: <alpine.DEB.2.00.1210180517450.8674@utopia.booyaka.com>
 <alpine.DEB.2.00.1210191645390.10773@utopia.booyaka.com>
 <20121019190358.GI1613@blackmetal.musicnaut.iki.fi>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36065 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754803Ab2JSTHX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Oct 2012 15:07:23 -0400
Content-Disposition: inline
In-Reply-To: <20121019190358.GI1613@blackmetal.musicnaut.iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 19, 2012 at 10:03:58PM +0300, Aaro Koskinen wrote:
> Hi,
>=20
> On Fri, Oct 19, 2012 at 04:55:38PM +0000, Paul Walmsley wrote:
> > On Thu, 18 Oct 2012, Paul Walmsley wrote:
> >=20
> > > Here are some basic OMAP test results for Linux v3.7-rc1.
> > > Logs and other details at http://www.pwsan.com/omap/testlogs/test_v3.=
7-rc1/
> >=20
> > And here's two more.
>=20
> [...]
>=20
> > * 3530ES3 Beagle: I2C timeouts during userspace init
> >   - May be related to the threaded IRQ conversion of the I2C driver
> >   - Unknown cause
>=20
> FYI, I saw I2C hangs also on Nokia N900 with v3.7-rc1 (omap_i2c
> omap_i2c.1: timeout waiting for bus ready). After several reboots they
> disappered (kernel binary was the same), and I have been unable to
> reproduce them since.

any change you have those logs saved somewhere ? Want to see if it's the
same problem triggered by RTC.

--=20
balbi

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQgaOQAAoJEIaOsuA1yqREhEAP/1qvlj4XACvlL3nwtfiZovkz
/NUQlc6yRdm7rdWzhW8WJro7J05Wlg7HKUq6BPRcuWi8Sm+RcVI3GPOWaCKW8VgS
V+1AYuDhp4Uicm/25nMKVLWd5LPxmGYQVXL9/ELalPj5mp55c2kz7tEj7GiE+aJt
t1FIkzX/T8bVU11MhG6s0rLYj29ccLnW7bVEct4+pUp2OEFj0nksTxn3Z7OkaH51
2bkphn/WtECOEmpxAMe6PpVbGtKnBatMZwZzalUubCnQFVtCac4vZLlv93qqZV2t
4PifkZqMAfOO6fhB8CoBSg4SvaOp0KEQTcrGejufAjU4WQOIgG70jeGG1/3ILknr
B+2APpooESgX5H9MnngYhaY19QqLvJo0vgqkB3Bxw936tFa8NijkSyBfg2c+TcVs
k4O66iXZwoxURG070AeX2H1WvV5AlBBSJn9heHhZDd7fb3Kx4uPt4gapYrBiI65C
PD8UoLALQ6tPBhkAtXaybrp08ECgkKVUynG+sPamjBLPrJ5jZGe6K9CQV0E4cFK0
/jMLA1aZCkDttRUvg8WwKZ13fMHluPglDYX9ltMFTI2rAkh332nl4JQO1kjrrdkh
I0wVwUjc+tarGPE8rjEJ6iiqVccnCLB84KkKmXFy/56cQdgawxd/oKAkyBbhy1FM
mWlJZCGJPuN5F98KwP+m
=Svu4
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--
