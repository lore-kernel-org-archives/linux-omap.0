From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi/omap2: Let device core handle pinctrl
Date: Tue, 7 May 2013 09:55:35 +0100
Message-ID: <20130507085535.GN7478@sirena.org.uk>
References: <1367868998-12667-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <1BAFE6F6C881BF42822005164F1491C33EBE473A@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ztcJpsdPpsnnlAp8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1BAFE6F6C881BF42822005164F1491C33EBE473A@DBDE04.ent.ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Grant Likely <grant.likely@linaro.org>, "spi-devel-general@lists.sourceforge.net" <spi-devel-general@lists.sourceforge.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org


--ztcJpsdPpsnnlAp8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 07, 2013 at 03:56:09AM +0000, Hebbar, Gururaja wrote:

> There are cases where driver('s) needs to place pin-mux's to sleep on sus=
pend
> & default/idle on resume. For such cases Pinctrl needs to be handled insi=
de=20
> the driver. Example [1].

Well, obviously - but at the minute the driver is pure boilerplate.
There's also been some discussion about factoring out the suspend/resume
code since it's going to get equally repetitive.

> I will be submitting a patch to enhance the existing pinctrl support for=
=20
> spi omap2 shortly which does above work.

How soon is shortly?

--ztcJpsdPpsnnlAp8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRiMGEAAoJELSic+t+oim97SMP/0fqs04Yw/xucmdnRiHEDMRc
VVyRsTH1D91qye854TVNngo5Ob1tCnnluhNycuT2kLbRxeIbOWXKNEjYBTvjFpYv
puXOUnJYJfjm64DFa7HXa78YOci6pUqEbVbRICU5/CiJu3PIlstC/47sGh+VfV1Y
E58dr/5doqJxGUug+0V3cr/83IGn0j5NWSmbyYfvN3MX3HPRDLdrAY1NeDFcactf
OSNa7o+YdJq0dcD2w5IhDJbnMXqV5L/rc54kOhFX8kox5jnB5HSY7nH70XgB2Jgf
LsZnzXFxfj3utzr8Rb8Mzz0DJVvu9ToN/mYc6aGzUFfPj43YDf4TUWHiQncsoFfR
bkoppL5EFyp5/ZAUOGcpfnVNv/ovok18edjRtEk+nlyGRdPg14x+4RVzYMvKz0st
AwNWPZr55Ol9qAL+zz/J6rIGJMTY3zfVDD1MSZt8iIOJ9Xn1t38/2YSi0gv27/Iy
Wd17tmvnUO/eUZeirpX7PAdPrG3bY2izkIT7RKxgNRGuzGp8uXH/TM19h2TEf2gz
6z8nS6iHlMK76DvCHlflKVj6LWXJQE9KyVKdhEwtEmMhZdDt1/tC5hvyVqoBmFt/
8eAMuznFuKNQPS/YzJTj08y3wcj5urO8orp8/W92SRK3qQEnuxnzpr9LJpiy4lPi
/UN8+uThgEsZnc47oH2G
=eMXk
-----END PGP SIGNATURE-----

--ztcJpsdPpsnnlAp8--
