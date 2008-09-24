From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/5] Don't use __init but __devinit to define probe function.  A pointer to
Date: Wed, 24 Sep 2008 16:29:11 +0300
Message-ID: <1222262955-13599-2-git-send-email-tony@atomide.com>
References: <1222262955-13599-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:61603 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753702AbYIXN33 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Sep 2008 09:29:29 -0400
In-Reply-To: <1222262955-13599-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, =?utf-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@strlen.de>, Russell King <rmk+kernel@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>

=46rom: Uwe Kleine-K=C3=B6nig <ukleinek@strlen.de>

	echo -n omap-mcbsp.1 > /sys/bus/platform/driver/omap-mcbsp/unbind
	echo -n omap-mcbsp.1 > /sys/bus/platform/driver/omap-mcbsp/bind

While at it move the remove function to the .devexit.text section.

Signed-off-by: Uwe Kleine-K=C3=B6nig <ukleinek@strlen.de>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/mcbsp.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index e63990f..e0803a8 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -804,7 +804,7 @@ EXPORT_SYMBOL(omap_mcbsp_set_spi_mode);
  * McBSP1 and McBSP3 are directly mapped on 1610 and 1510.
  * 730 has only 2 McBSP, and both of them are MPU peripherals.
  */
-static int __init omap_mcbsp_probe(struct platform_device *pdev)
+static int __devinit omap_mcbsp_probe(struct platform_device *pdev)
 {
 	struct omap_mcbsp_platform_data *pdata =3D pdev->dev.platform_data;
 	int id =3D pdev->id - 1;
@@ -868,7 +868,7 @@ exit:
 	return ret;
 }
=20
-static int omap_mcbsp_remove(struct platform_device *pdev)
+static int __devexit omap_mcbsp_remove(struct platform_device *pdev)
 {
 	struct omap_mcbsp *mcbsp =3D platform_get_drvdata(pdev);
=20
@@ -894,7 +894,7 @@ static int omap_mcbsp_remove(struct platform_device=
 *pdev)
=20
 static struct platform_driver omap_mcbsp_driver =3D {
 	.probe		=3D omap_mcbsp_probe,
-	.remove		=3D omap_mcbsp_remove,
+	.remove		=3D __devexit_p(omap_mcbsp_remove),
 	.driver		=3D {
 		.name	=3D "omap-mcbsp",
 	},
--=20
1.5.6.rc3.21.g8c6b5

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
