From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 09/16] mfd: omap-usb-host: override number of ports from
 platform data
Date: Wed, 21 Nov 2012 21:47:08 +0200
Message-ID: <20121121194708.GC14290@arwen.pp.htv.fi>
References: <1352990054-14680-1-git-send-email-rogerq@ti.com>
 <1352990054-14680-10-git-send-email-rogerq@ti.com>
 <20121121134516.GK10216@arwen.pp.htv.fi>
 <50ACEA42.2030701@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ghzN8eJ9Qlbqn3iT"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48373 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755883Ab2KUTxj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 Nov 2012 14:53:39 -0500
Content-Disposition: inline
In-Reply-To: <50ACEA42.2030701@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: balbi@ti.com, keshava_mgowda@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

--ghzN8eJ9Qlbqn3iT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Nov 21, 2012 at 04:50:42PM +0200, Roger Quadros wrote:
> On 11/21/2012 03:45 PM, Felipe Balbi wrote:
> > On Thu, Nov 15, 2012 at 04:34:07PM +0200, Roger Quadros wrote:
> >> For some platforms e.g. OMAP5, we cannot rely on USBHOST revision
> >> to determine the number of ports available. In such cases we have
> >=20
> > you need to make it clear *why* we can't. Imagine someone reading this 5
> > years from now... he'll be all like: "why can't I find any documentation
> > about this OMAP5 ? Why was it so special that its revision register
> > wasn't enough to figure out number of ports ?"
>=20
> OK, i'll add a note like this "both OMAP5 and OMAP4 exhibit the same
> revision ID in the USBHOST_REVISION register, but in fact have different
> number of ports physically available on the SoC (i.e. 2 for OMAP4 and 3
> for OMAP5 respectively). So we can't rely on REVISION register to
> determine number of ports for OMAP5 and depend on platform data/Device
> tree instead"

perfect ;-)

--=20
balbi

--ghzN8eJ9Qlbqn3iT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQrS+8AAoJEIaOsuA1yqREZywP/08vcrMZOQs235Ob8OxLUbOL
osCVkAh0x8+lYdCzdbtCgRxS5IhQO0CdrT/r6O5il5JXLw6c+OHIsm4Z2IJ4TE9b
AYfSQXHKPUMuuPoYlVhMUNxmDULIlgs1yALkIgKaxZ+itMeoTYQl2VgZEkztrUmJ
OO9vSEeGE67PPqHnFUuSz4KLpFxRpWMtWWuDBAY9CqdTOrs0BDM857b+MRIP5wLH
TWdb8OBFdy8lIvA6mBv5mvRUwQB/YnOoGw95gR+s6Y8iQ5NQ71xRhbZW2oLAHAyR
bPN+zd+ULzDKYaQbq4DP3qEuDIa4pl6A810gDsdg6LOHsGpIKOcGeMM96Gv9TkJZ
Z3phYFUCaLwSvUSH4bdAmu/HGSbAo0vVAKkkZY5TGOe3r3988gjLR8eeGEEi7sMI
ALiaDdgk7rM3op1xZYIsCrAV6kzFOoTyFbNCQjXMxBiGXri76uWI387QJ7rbpXFa
rfHyC/KK3MIB1xBMj1/woouyA3NmI5rwBLnLkqI0GlqKEiyb7WB81FadDUJAQSWZ
GyGcSV3EXP4mfumjPFotOQZ0dxxW1wjd4n9M1Ap/zGvUNpFBDbStv7H7yamD1PBQ
mclrQcTBNwWlMGFmYZp2MbHSeXGO0yaTbU6LfT7Po4NWf7GmkbDsUkHNlIoubMRU
65CGISo1miDzC71FgPgs
=qX0i
-----END PGP SIGNATURE-----

--ghzN8eJ9Qlbqn3iT--
