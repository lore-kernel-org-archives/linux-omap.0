From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH/RESEND 0/2] usb: musb: am335x support part-2
Date: Thu, 8 Nov 2012 20:17:08 +0200
Message-ID: <20121108181707.GB2228@arwen.pp.htv.fi>
References: <cover.1352213124.git.afzal@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="H+4ONPRPur6+Ovig"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36344 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756500Ab2KHSXR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 Nov 2012 13:23:17 -0500
Content-Disposition: inline
In-Reply-To: <cover.1352213124.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Afzal Mohammed <afzal@ti.com>
Cc: Felipe Balbi <balbi@ti.com>, Benoit Cousson <b-cousson@ti.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

--H+4ONPRPur6+Ovig
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Nov 06, 2012 at 08:44:59PM +0530, Afzal Mohammed wrote:
> Hi Balbi,
>=20
> This is a resend of remaining changes to get am335x usb working. These
> were sent on 31 Oct with subject, "usb: musb: dsps: fixes for -rc.

there is no more time for this to reach -rc. Do we need it for v3.8
merge window ?

> First one restores capability to support at least one instance of musb.
> Without it, even a single instance can't be supported as change which
> is reverted by it was made along with multi phy changes and nop
> transciever dt support, both other changes didn't make it to mainline.=20
>=20
> Second one corrects binding document; changes were made in driver as
> per review comments, but documentation was not updated.

second one is clearly not for -rc.

--=20
balbi

--H+4ONPRPur6+Ovig
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQm/cjAAoJEIaOsuA1yqRE9a8P/2fFbKAs1cfx8/ry6i2qpioT
8KWLvyyJpseCX66HGGH/Qep5nroM62PR7Ea4+B5JqLvr8wQ9BH3eMi//LyRMtDOY
WM0byb5Nk1uOXwOvurWb3FpqVD57opmBcKmhkiHKMtqS6lKdqtS8FoDuGAgNKUwH
mQwJFNG52pO+GKl+kL20hV5+D0ydr0EqXpP7Ar8QOrH7DQxWYh6eNGTdaBf5bjZj
gvEj1gm1A83K6e83C+InzdX1P+0aI1Z4KrqXdsi3XyxtKkcHrKv/ccjdyxJknXwW
DqArglLqt1nL9aDWkJWMyZY7yWdBIxI+Wz61J+Nwu2/Sv1hNcgo9/GSpSScPT6cq
75bAeCDMTkZq0nVgku2xrAwbvgrSnGb0MKquhzjzpdLjsDSHJDVi0kn862rEsA+h
Fc5kEQMbqid/fOreCO2XqzvLy217qLReKyieab6dUUN0WLsGrQ0XH+2rvVlD91Jy
D/BZD1tQ9QrcpIhkGDkkJW0W1yJa+LwN2vV0oCLHf9dlHSxGklroAftSYp6bQwAX
3UOkCBrRWI7f6W1Py1IBr43NsolcHkJGEuY00aFQZRtcSLn8i0UrrgO1Lz+JpJ/V
/Rvn8cfQPGasQLueYxJXqLt66NsHd35zs08+x9krGwTltpOUprruSEi6Vxe51Q0l
Z6G5x/rJSH0d+LHQibHm
=GwIK
-----END PGP SIGNATURE-----

--H+4ONPRPur6+Ovig--
