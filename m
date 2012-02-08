From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: [PATCH 04/14] ARM: OMAP3+: SmartReflex: Add a shutdown hook
Date: Wed,  8 Feb 2012 18:43:49 +0100
Message-ID: <1328723039-15952-5-git-send-email-j-pihet@ti.com>
References: <1328723039-15952-1-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:55967 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756333Ab2BHRo2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Feb 2012 12:44:28 -0500
Received: by wgbdt10 with SMTP id dt10so853447wgb.1
        for <linux-omap@vger.kernel.org>; Wed, 08 Feb 2012 09:44:26 -0800 (PST)
In-Reply-To: <1328723039-15952-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>
Cc: balbi@ti.com, nm@ti.com, Jean Pihet <j-pihet@ti.com>

From: Nishanth Menon <nm@ti.com>

SmartReflex fix for erratum ID i724.

Since OMAP's VP and PRM modules do not get reset by warm reset,
we should ensure that proper shutdown procedure is followed prior
to allowing the kernel to reboot back up.

Without this patch, Smartreflex module might be left active or
system might be caught in an indeterminate sequence when reboot
is triggered, leaving the next reboot behavior to be unpredictable.

Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/smartreflex.c |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index ec2b0e7..9c39484 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -1055,8 +1055,32 @@ static int __devexit omap_sr_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static void __devexit omap_sr_shutdown(struct platform_device *pdev)
+{
+	struct omap_sr_data *pdata = pdev->dev.platform_data;
+	struct omap_sr *sr_info;
+
+	if (!pdata) {
+		dev_err(&pdev->dev, "%s: platform data missing\n", __func__);
+		return;
+	}
+
+	sr_info = _sr_lookup(pdata->voltdm);
+	if (IS_ERR(sr_info)) {
+		dev_warn(&pdev->dev, "%s: omap_sr struct not found\n",
+			__func__);
+		return;
+	}
+
+	if (sr_info->autocomp_active)
+		sr_stop_vddautocomp(sr_info);
+
+	return;
+}
+
 static struct platform_driver smartreflex_driver = {
 	.remove         = omap_sr_remove,
+	.shutdown	= __devexit_p(omap_sr_shutdown),
 	.driver		= {
 		.name	= "smartreflex",
 	},
-- 
1.7.5.4

