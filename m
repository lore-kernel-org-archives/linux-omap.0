From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] USB: OTG: isp1301_omap: resolve unused variable warning
 from gcc
Date: Mon, 23 Apr 2012 14:59:27 +0300
Message-ID: <20120423115925.GW26302@arwen.pp.htv.fi>
References: <alpine.DEB.2.00.1204201527350.11306@utopia.booyaka.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Hy4a9G0dOYssRJVI"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:52311 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752239Ab2DWMAj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Apr 2012 08:00:39 -0400
Received: by lagw12 with SMTP id w12so8274487lag.6
        for <linux-omap@vger.kernel.org>; Mon, 23 Apr 2012 05:00:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1204201527350.11306@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: balbi@ti.com, Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org


--Hy4a9G0dOYssRJVI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 20, 2012 at 03:29:20PM -0600, Paul Walmsley wrote:
>=20
> Resolve this build warning:
>=20
> drivers/usb/otg/isp1301_omap.c: In function 'isp1301_set_peripheral':
> drivers/usb/otg/isp1301_omap.c:1340:6: warning: unused variable 'l'
>=20
> This shows up when building with the 'omap1_defconfig' and
> '5912osk_testconfig' configs from git://git.pwsan.com/omap_kconfigs.
>=20
> Compile-tested only.
>=20
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Cc: Felipe Balbi <balbi@ti.com>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>

applied, thanks

--=20
balbi

--Hy4a9G0dOYssRJVI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPlUQdAAoJEIaOsuA1yqRE0HIP/1L3KWlf9Vfzjr1sy8af4EFy
8a3j7nF0jnQdqtNMZXcB70GRGgGMVBLlourEFOevwC0uT/q2rY5ffYfqAkeFZX0H
FH74Zc5+DsQ0gok883fxtVmrAoOHKDjobvD2HotRlJABekwCXuGpwFcQWSV8MFwF
7OZJdOUAc3ACh8dR9dXlKlYpFbv1HZZgmDC1Je1TgcDS2kUPtbTzO42OcsyT9l9m
GiHjDL1LGBCcSUSFXMtuZvjxgIziCOa3ogE/nB3mdT7CWSY5s8ftOBPcbbrVoGJr
gnVM4WC+fCxnkWDAn5GDREWvdob8kuvrFCkBs+H7BTntjFsa6ZPqqLnR5ei9oZtb
+6jjCFMiv6GG6cAOdkF3m+jHJ1X44GMVBs3wA5557oiijmHFDY4y6PASi4Ir5/UH
kIzkpV5tpkGN0O7othxhWREuLnyzg5NSA0abdFbI4qSXCvLh7m3aLYwTcKMHnYUV
+FK5NqQMDPDygtjAYeE2mU97vJmi5Ntuq260Mzzwc8EnkGwxesxvj3EltXPBk1EP
YnjVwD9mx9FynivYgDwO64wSwbYmMWschrNn+IHzK/gylBU3nOCxkzX6OmxoXzh8
2W321iP2WCixMTdvK9OHsoRDmSb6qC3aPzoCJoP4eUnjoDBUVsDQI5N8rnL81+oQ
8lkryjsozIZCqfglpNl6
=IFFZ
-----END PGP SIGNATURE-----

--Hy4a9G0dOYssRJVI--
