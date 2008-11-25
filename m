From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH 06/10] omap mailbox: fix empty struct device for omap2
Date: Tue, 25 Nov 2008 11:39:54 +0200
Message-ID: <1227605998-13531-7-git-send-email-Hiroshi.DOYU@nokia.com>
References: <1227605998-13531-1-git-send-email-Hiroshi.DOYU@nokia.com>
 <1227605998-13531-2-git-send-email-Hiroshi.DOYU@nokia.com>
 <1227605998-13531-3-git-send-email-Hiroshi.DOYU@nokia.com>
 <1227605998-13531-4-git-send-email-Hiroshi.DOYU@nokia.com>
 <1227605998-13531-5-git-send-email-Hiroshi.DOYU@nokia.com>
 <1227605998-13531-6-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:34859 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752220AbYKYJkT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Nov 2008 04:40:19 -0500
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id mAP9e173029701
	for <linux-omap@vger.kernel.org>; Tue, 25 Nov 2008 11:40:16 +0200
Received: from oreo.research.nokia.com (esdhcp04130.research.nokia.com [172.21.41.30])
	by mgw-int02.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id mAP9dxRi001534
	for <linux-omap@vger.kernel.org>; Tue, 25 Nov 2008 11:39:59 +0200
In-Reply-To: <1227605998-13531-6-git-send-email-Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/mach-omap2/devices.c |    2 +-
 arch/arm/mach-omap2/mailbox.c |   15 +++++++++------
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index d385f0f..95d8673 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -118,7 +118,7 @@ static struct resource mbox_resources[] = {
 };
 
 static struct platform_device mbox_device = {
-	.name		= "mailbox",
+	.name		= "omap2-mailbox",
 	.id		= -1,
 	.num_resources	= ARRAY_SIZE(mbox_resources),
 	.resource	= mbox_resources,
diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
index 7c4d6ef..12715d8 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -18,6 +18,8 @@
 #include <mach/mailbox.h>
 #include <mach/irqs.h>
 
+#define DRV_NAME "omap2-mailbox"
+
 #define MAILBOX_REVISION		0x000
 #define MAILBOX_SYSCONFIG		0x010
 #define MAILBOX_SYSSTATUS		0x014
@@ -234,7 +236,7 @@ static struct omap_mbox mbox_iva_info = {
 };
 #endif
 
-static int __init omap2_mbox_probe(struct platform_device *pdev)
+static int __devinit omap2_mbox_probe(struct platform_device *pdev)
 {
 	struct resource *res;
 	int ret = 0;
@@ -258,7 +260,7 @@ static int __init omap2_mbox_probe(struct platform_device *pdev)
 	}
 	mbox_dsp_info.irq = res->start;
 
-	ret = omap_mbox_register(&mbox_dsp_info);
+	ret = omap_mbox_register(&pdev->dev, &mbox_dsp_info);
 	if (!ret)
 		goto err_dsp;
 
@@ -272,7 +274,7 @@ static int __init omap2_mbox_probe(struct platform_device *pdev)
 	}
 	mbox_iva_info.irq = res->start;
 
-	ret = omap_mbox_register(&mbox_iva_info);
+	ret = omap_mbox_register(&pdev->dev, &mbox_iva_info);
 	if (!ret)
 		goto err_iva1;
 #endif
@@ -285,7 +287,7 @@ err_dsp:
 	return ret;
 }
 
-static int omap2_mbox_remove(struct platform_device *pdev)
+static int __devexit omap2_mbox_remove(struct platform_device *pdev)
 {
 #if defined(CONFIG_ARCH_OMAP2420)
 	omap_mbox_unregister(&mbox_iva_info);
@@ -297,9 +299,9 @@ static int omap2_mbox_remove(struct platform_device *pdev)
 
 static struct platform_driver omap2_mbox_driver = {
 	.probe = omap2_mbox_probe,
-	.remove = omap2_mbox_remove,
+	.remove = __devexit_p(omap2_mbox_remove),
 	.driver = {
-		.name = "mailbox",
+		.name = DRV_NAME,
 	},
 };
 
@@ -319,3 +321,4 @@ module_exit(omap2_mbox_exit);
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("omap mailbox: omap2/3 architecture specific functions");
 MODULE_AUTHOR("Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Paul Mundt");
+MODULE_ALIAS("platform:"DRV_NAME);
-- 
1.6.0.3.613.g9f8f13

