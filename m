From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: =?UTF-8?q?=5BPATCH=5D=20omapfb=3A=20In=20omapfb=5Fprobe=20return=20-EPROBE=5FDEFER=20when=20display=20driver=20is=20not=20loaded=20yet?=
Date: Wed, 10 Jul 2013 15:08:59 +0200
Message-ID: <1373461739-10168-1-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ea0-f172.google.com ([209.85.215.172]:53110 "EHLO
	mail-ea0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750921Ab3GJNJX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Jul 2013 09:09:23 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>

* On RX-51 probing for acx565akm driver is later then for omapfb which =
cause that omapfb probe fail and framebuffer is not working
* EPROBE_DEFER causing that kernel try to probe for omapfb later again =
which fixing this problem

* Without this patch display on Nokia RX-51 (N900) phone not working

Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
---
 drivers/video/omap2/omapfb/omapfb-main.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/o=
map2/omapfb/omapfb-main.c
index 856917b..93e7c84 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -2419,6 +2419,15 @@ static int omapfb_probe(struct platform_device *=
pdev)
 	if (omapdss_is_initialized() =3D=3D false)
 		return -EPROBE_DEFER;
=20
+	dssdev =3D NULL;
+	for_each_dss_dev(dssdev) {
+		if (!dssdev->driver) {
+			dev_warn(&pdev->dev, "no driver for display: %s\n",
+				dssdev->name);
+			return -EPROBE_DEFER;
+		}
+	}
+
 	if (pdev->num_resources !=3D 0) {
 		dev_err(&pdev->dev, "probed for an unknown device\n");
 		r =3D -ENODEV;
--=20
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
