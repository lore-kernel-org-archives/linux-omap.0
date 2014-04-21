From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 03/10] usb: phy: mv-u3d: switch over to writel/readl
Date: Mon, 21 Apr 2014 14:06:46 -0500
Message-ID: <20140421190646.GL22794@saruman.home>
References: <1398095812-14222-1-git-send-email-balbi@ti.com>
 <1398095812-14222-4-git-send-email-balbi@ti.com>
 <20140421190444.GF14470@kroah.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DN8g+DOX2TxGxleI"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53391 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753325AbaDUTJL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 Apr 2014 15:09:11 -0400
Content-Disposition: inline
In-Reply-To: <20140421190444.GF14470@kroah.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Felipe Balbi <balbi@ti.com>, Linux USB Mailing List <linux-usb@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, leigh@solinno.co.uk, Tony Lindgren <tony@atomide.com>

--DN8g+DOX2TxGxleI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 21, 2014 at 12:04:44PM -0700, Greg KH wrote:
> On Mon, Apr 21, 2014 at 10:56:45AM -0500, Felipe Balbi wrote:
> > by removing the _relaxed suffix, we can build
> > this driver in other architectures.
>=20
> Odd, why was the _relaxed variants used here at all?  Someone trying to
> optimize something ahead of time?

that has been there since its inception in commit
a67e76ac904cb48946262bf353f1df0d1b349368. My guess is that someone
wanted to avoid the memory barriers imposed by writel()/readl().

--=20
balbi

--DN8g+DOX2TxGxleI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTVWxGAAoJEIaOsuA1yqREZ8IP/3yKk8joYPBVufJctYCOFYDs
hdXdrbGsCeh1TOG72sEK1wevxgl+y9Jrfjfgy76mROK6j4KrNtX3I2zVaGoiDd9M
Au+4W4E8LmyRNRqPuiH754jz0MOH5laTPAe4XIohYUkTvYadLX9vGv9ugPrn6NmE
w3p5vs6FaxWmePmX2CxaBCQvZMfyzhQ0JEjvTjWg/Zp9HDfRn5rX9RjZmwPQIp4Y
Wzdhn+t98T1fL3YaBdn43v6xuKZIWybs/r3Vap6Ev4HhfrTzNir9vTQx7e4GZ9tb
3R52sul/Rm/dBOp6aIDXFOxeZBqviSsrobQUhGAxibbJ03ve1cfiJDGeLPLgdJHN
JbBKR/WDnMMmjrDt9ICK5HkBFOkC0y6RWuQ5txcHv3kyS0lTsfZisfQirXLN0GXE
pXT7tt/XcfYYU1/iGfNSBBFu3JRA9GAZ86kbhmGb3Db6DcugHJFTJKyCrj3OYyj9
Sb2MlL8k/BFEXRSZfknKqdvU5VMG9MRiySVFnL7C+YntBo46ISWCiUGCUpNyJJEX
6CqNBEIAShZx3oBHBrv/0FHXsvVMcyBWq869lIrwJg6OYjneYlY+Kxg4qN1LLV7W
/eLRgApkq2Rb7zfYfxI2J8Xs27ym0Fm4/iIq53V7hdMgi4nEAY93X94+wO0tF1GZ
7sV3V3IIRPRjY7oZXAHl
=q/eg
-----END PGP SIGNATURE-----

--DN8g+DOX2TxGxleI--
