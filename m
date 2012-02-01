From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: [PATCH 05/20] ARM: OMAP3+: SmartReflex: Add a shutdown hook
Date: Wed,  1 Feb 2012 09:49:44 +0100
Message-ID: <1328086199-28486-6-git-send-email-j-pihet@ti.com>
References: <1328086199-28486-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:40135 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755321Ab2BAIuV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Feb 2012 03:50:21 -0500
Received: by werb13 with SMTP id b13so753770wer.19
        for <linux-omap@vger.kernel.org>; Wed, 01 Feb 2012 00:50:20 -0800 (PST)
In-Reply-To: <1328086199-28486-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balbi@ti.com, nm@ti.com
Cc: Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Jean Pihet <j-pihet@ti.com>

From: Nishanth Menon <nm@ti.com>

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
index d7294c6..f384c19 100644
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
+	.shutdown	= omap_sr_shutdown,
 	.driver		= {
 		.name	= "smartreflex",
 	},
-- 
1.7.5.4

