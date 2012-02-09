From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAPDSS: HDMI: Add M2 divider while calculating pll
Date: Thu, 09 Feb 2012 09:46:56 +0200
Message-ID: <1328773616.1909.13.camel@deskari>
References: <1328706825-23555-1-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-eQz57BOGcLLI/4X4Urh/"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:56497 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751426Ab2BIHrC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Feb 2012 02:47:02 -0500
Received: by lagp5 with SMTP id p5so1534104lag.2
        for <linux-omap@vger.kernel.org>; Wed, 08 Feb 2012 23:46:59 -0800 (PST)
In-Reply-To: <1328706825-23555-1-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mythripk@ti.com
Cc: linux-omap@vger.kernel.org


--=-eQz57BOGcLLI/4X4Urh/
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, 2012-02-08 at 18:43 +0530, mythripk@ti.com wrote:
> From: Mythri P K <mythripk@ti.com>
>=20
> While calculating regm and regmf value add M2 divider in the equation.
>=20
> Signed-off-by: Mythri P K <mythripk@ti.com>

Please spend a bit more time on commit descriptions. What's M2? Why
wasn't it used before? What does this change affect? Is it a fix or a
new feature?

 Tomi


--=-eQz57BOGcLLI/4X4Urh/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPM3nwAAoJEPo9qoy8lh71x+oP/2CyxCwhNLTa+0wQXCc+FChy
T8PZ8fDjoE/jiqT/q4DXgBP7d2iDbbZljGz0ZbUD1xaFKJw8gXgqQOI5q9QgS7Em
X0bf2PMYmwxt34s3+XPJ4uWd6cyOox4wr/tfWd2VLz5pd4IbwyeMxNW1JpOoe17u
4YQ+FS+ZrTg7DBZzYnbD1s8JWpTmgZOE5o3w92WwefornMDUZ594yjeSaHEFr097
hN8g3hMgvdLmwUIP8js3eebCc2ynvE4oSZFnWKJXCFkpuAbKTvrEI3BsjyJmNgA0
a1EpXIEfvEHcdFdtcvP8Qs4XDEdi9D4c6RJGW4f6gfzeSjrgJrZBKIotmnxtbgp6
oRqw5na0Hd+vcRn25hOlyVNcttfXm6GWEL4ml/FYGpLcSlteD7BRjBEr4q8GH16t
LB8xwWkIBldf3q37hhCISdOQVA92mafDnSKPIi6bxLWqG6yu8U+x5Dmq/N7kewC2
ztbCg8B8GpKCyDVF0KitmOMH5KPXx/Mofa9unyBTSTy1umJ3K8TkB1ImOvUXOY8I
gtMo/P2tzBJqs1oOyEbDaOBGWpLG/x4yOjfgzCpoHl+WAf2NFXIz58EHMILRJr1T
ftcWquEkzaHENiF4N8FxJWBSR9gTh8lXKLq3ecxIv89wuYD8r8jKFLUg6ZOmynrN
VE07loCVBqLyZrw00WN4
=KUTM
-----END PGP SIGNATURE-----

--=-eQz57BOGcLLI/4X4Urh/--

