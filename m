From: Sebastian Reichel <sre@debian.org>
Subject: rx51: "omapfb: no driver for display"
Date: Sun, 27 Mar 2011 04:39:01 +0200
Message-ID: <20110327023901.GB20163@earth.universe>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comu.ring0.de ([46.4.151.82]:46503 "EHLO smtp.ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751746Ab1C0DMD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 26 Mar 2011 23:12:03 -0400
Received: from sre.ring0.de (unknown [93.223.82.105])
	by smtp.ring0.de (Postfix) with ESMTP id 54F1D2B8010
	for <linux-omap@vger.kernel.org>; Sun, 27 Mar 2011 02:46:33 +0000 (UTC)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I've got problems getting a working tty with the mainline 2.6.38
kernel on my Nokia N900. Here is the related output from dmesg:

$ grep -E "(omapdss|omapfb|acx565akm)" dmesg
[    0.890899] omapdss CORE: clk ick, rate 83000000
[    0.890930] omapdss CORE: clk dss1_fck, rate 96000000
[    0.890991] omapdss CORE: clk dss2_fck, rate 19200000
[    0.891021] omapdss CORE: clk tv_fck, rate 54000000
[    0.891052] omapdss CORE: clk video_fck, rate 96000000
[    0.891143] omapdss CORE: initial ctx id 0
[    0.950469] omapdss CORE: save context
[    0.950714] omapdss CORE: bus_match. dev display0/panel-acx565akm, drv panel-acx565akm
[    0.950775] omapdss CORE: driver_probe: dev display0/panel-acx565akm, drv panel-acx565akm
[    0.950805] omapdss SDI: SDI init
[    1.004455] omapdss CORE: save context
[    1.059173] omapdss CORE: save context
[    1.113830] omapdss CORE: save context
[    1.129608] acx565akm spi1.2: omapfb: acx565akm rev 8b LCD detected
[    1.130065] omapdss CORE: probe done for device display0
[    1.130096] omapdss CORE: bus_match. dev display1/venc, drv panel-acx565akm
[    1.303741] OMAPFB: omapfb_init
[    1.303894] OMAPFB: omapfb_probe
[    1.303924] omapfb omapfb: no driver for display
[    1.304016] omapfb omapfb: failed to setup omapfb

You can find the full dmesg and the full kernel config at [0] and
[1]. Can you tell me the reason for the "no driver for display"
message? I thought acx565akm has been registered as display driver
directly before.

[0] http://pkg-n900.alioth.debian.org/kernel/2.6.38/config-2.6.38-1-omap
[1] http://pkg-n900.alioth.debian.org/kernel/2.6.38/dmesg

-- Sebastian

--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCAAGBQJNjqNFAAoJENju1/PIO/qaWNYQAJA4b8nqK4y8OmQ1xdgODoPZ
Px9uk41uoR9/xS1Y8fvp5LyButGKKzidqWBRu6RJqpRbYepr2Cq1/dcxFplzkmy1
awt7iuP63WNtsIw9x67IG25jyC+aC+9a+RrPeD3NihbQDZPIwhgdt3RCoryRHXZO
uETyB1g5BlAJWwgGKMZc4HolzuUcSoqb98nhPtkidl6p1l55bE3LZJtDwISbVa42
+i9jTbsz43gJ8kjgGiU6uKFM3HPyWnFFIUu9E3YX0Gh/XvN0GycQhQME4WoB5Ea5
9MrdYukfxIU6Zr898+zSd0v8UewpaZj8rSeQpHtquAzAn2Ng5CdfW+2BqGrs1Rpr
snpSGstR8jkB1aos5Q4I8GyT4uV0hrRpcSPpUgGwzhSj3l/jDI2esN1PphWkdOWm
Y1NlwcS1HdljOodh4D674QOF8a1j6XLIiCsCTAfcX+1ZtOuQL0BEByo/Hxqp4QRR
yZRAALE8W9lkWF8SZYsIwPh3CJATOstlF95isWEpCtT8KwB0lXnNgBf78pxTWvir
OnQwukMIQhoCsC6nIyb1YPu20a6yMx4n2L0VtxA56Bdc7yt4SDhDZMG7qjMPIniB
QBFIQ/Ac9gQwJpGGGG153YmW/531iOWPxhQV9vtrLvRzmZH/4cEBBHM6UjwbhgPU
LfAgaFg0COJqyM4MeQj1
=Jcs5
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--
