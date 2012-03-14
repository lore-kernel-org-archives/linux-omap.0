From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] omap2+: add drm device
Date: Wed, 14 Mar 2012 14:38:57 +0200
Message-ID: <1331728737.2386.76.camel@deskari>
References: <1331670878-12951-1-git-send-email-rob.clark@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-mTrexnYL/G/glN+jxTjR"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:44712 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760930Ab2CNMjD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Mar 2012 08:39:03 -0400
Received: by mail-lb0-f174.google.com with SMTP id gm6so765024lbb.19
        for <linux-omap@vger.kernel.org>; Wed, 14 Mar 2012 05:38:59 -0700 (PDT)
In-Reply-To: <1331670878-12951-1-git-send-email-rob.clark@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Clark <rob.clark@linaro.org>
Cc: dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, patches@linaro.org, Greg KH <greg@kroah.com>, Andy Gross <andy.gross@ti.com>, Rob Clark <rob@ti.com>


--=-mTrexnYL/G/glN+jxTjR
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, 2012-03-13 at 15:34 -0500, Rob Clark wrote:
> From: Andy Gross <andy.gross@ti.com>
>=20
> Register OMAP DRM/KMS platform device, and reserve a CMA region for
> the device to use for buffer allocation.  DMM is split into a
> separate device using hwmod.

What's the diff with this and the previous one?

I see you still have the platform data there. You didn't comment on
that. Where is it used after the board files are gone when we use DT?

And how about the size of the contiguous memory area, it was left a bit
unclear to me why it cannot be dynamic.

 Tomi


--=-mTrexnYL/G/glN+jxTjR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPYJFhAAoJEPo9qoy8lh71OAQP/ieo1KVEYuLQg9sCLfsTCp59
S4uJWF2obXwe6fhDNDYojcJzYFkj06gOZPoYEBpDrnpWTCZa7sHge/+uE6xBTrx7
lfrdvEGGl0NUcOs/5uSnDMZW3H+lkw0O5zaugrhFDkKzzDQi4Zy09LDCJpqNHLGc
3W/RFNiySHAGLyc41COyQrhhwa1eWfCyPfor6AUyv386i8gF0LAI2KxfjnSFi8Qy
66lCl90ltr4qUUGpTWqxt6bv7xBCoRHpYMztP7qZihGkjsIbdTzvg5HY05Zudtv5
0CCSl746xmpVkjwaVoq0zNhky8ZiWlPhCVMzrqfrNjkRkMn9dmKE2XuwJml/IHSu
Y3UP/H5+y5loLkZ4qIPRjZaiUBpSlZkOsZkjbhD28jwoU372Riy9ieOFpkCkC7zy
qCOAyQtE2BHw0xa/SxU1djpfo+HRGFZ7JuOMWXzKqoYB+xbsmSoMm7OTyoT6ei4w
MoR5zoq4X78cbD9wrk8+M0BXm9BI/dd5l71Dw945IX2VohJf2Yv2H+XnIxwuKa9F
huhvnO2IMX+MCd2a5fmbtVHyCnkQizhDCFfsrbBUHdlZ20p0ehyZFPEAAFO33Hxf
OT0UG/uQx4GdNwQBHiAKm56COxrXBHCpe7p8wZbe0vYx8ZgI9pg9D6j9/k5otKEM
153qYK9+HfxfcZXO3y8D
=GYdG
-----END PGP SIGNATURE-----

--=-mTrexnYL/G/glN+jxTjR--

