From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 06/26] OMAPDSS: if dssdev->name==NULL, use alias
Date: Thu, 12 Dec 2013 16:19:01 +0200
Message-ID: <52A9C5D5.80801@ti.com>
References: <1386160133-24026-1-git-send-email-tomi.valkeinen@ti.com> <20131212100527.GA860@earth.universe> <52A9C470.2030102@ti.com> <1793565.XC2oCqQxA8@avalon>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="2Qo9jq6WDJNwb26CuPg2bro1D0mI2XJ04"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36756 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751512Ab3LLOTJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Dec 2013 09:19:09 -0500
In-Reply-To: <1793565.XC2oCqQxA8@avalon>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Sebastian Reichel <sre@ring0.de>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, Archit Taneja <archit@ti.com>, Darren Etheridge <detheridge@ti.com>, Tony Lindgren <tony@atomide.com>

--2Qo9jq6WDJNwb26CuPg2bro1D0mI2XJ04
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-12-12 16:15, Laurent Pinchart wrote:

> As you mentioned in your previous e-mail, if the labels are used by oma=
pfb=20
> only, I won't strongly push to keep them. I wonder, however, when using=
=20
> DRM/KMS, where do the connector labels that are displayed by xrandr for=
=20
> instance come from ?

drivers/gpu/drm/drm_crtc.c has lists, with names like "DVI-D", "HDMI-A",
for connectors and encoders. Maybe from those.

 Tomi



--2Qo9jq6WDJNwb26CuPg2bro1D0mI2XJ04
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSqcXVAAoJEPo9qoy8lh71iOgQAJgn/kX6+ErjCTHyze/P41RT
OhwUsZHTwpH9C6lSmAaGJ8Mm7pO7/h08V0OTNMXfb/OA6fKiuJBJFl92NYjD+79q
/Af6j7MYdPQIo7+XGul+3jqfH5oDfM0+CSu/ipih9RoNqHaQSVOqrRtY4EJHUMvs
OGYasP7+0nLWFFbfSfat+4b+waUX8unCMiZRGe0MnaCGlKLaXocJq2sJdbJSGxFM
g5SXMS87TT64YwhTYeqIlwB+nCm+iNfERH451h9VMdbtYLsmEW9B3OhcS6ChgOpE
4XvGGZgdTjxX7Ks6UiwYxIYhTeL2DWIsAJKeipxmLmRJ/8wcG/5hV9NetFvNOPlZ
3CjQkUH5FH8Du7wAt2Ph9zjQ5/ItWV8dSP8VJupWrhAhmIsxtmLrg4qSRZTJMIp8
6wzkF1Chg37E7Q062XcGfun1K2c45eGd2ej7n9C3DSnoy0O0/7iLYQFus3wi9mPP
BrTyQL2j5HX8b2Izzr9yHqqv4jVPn130cWw3awuZTSVhyYIvOl9SfnxUFdtJcxWU
couXER+airm/GVULo8VjBBehKVbVtutW5e2KUCSvSuUozb4+jBvocJomE9czPPv4
HAMmFshaoNJ/iO8icMxmRHl7xLN5QmxcKopCfEUslE1nbPxxaYABe9bKHwi36Hja
M9DPd7xRS/HN9kbVlEBT
=kzgG
-----END PGP SIGNATURE-----

--2Qo9jq6WDJNwb26CuPg2bro1D0mI2XJ04--
