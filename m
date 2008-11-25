From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH 05/10] omap mailbox: fix empty struct device for omap1
Date: Tue, 25 Nov 2008 11:39:53 +0200
Message-ID: <1227605998-13531-6-git-send-email-Hiroshi.DOYU@nokia.com>
References: <1227605998-13531-1-git-send-email-Hiroshi.DOYU@nokia.com>
 <1227605998-13531-2-git-send-email-Hiroshi.DOYU@nokia.com>
 <1227605998-13531-3-git-send-email-Hiroshi.DOYU@nokia.com>
 <1227605998-13531-4-git-send-email-Hiroshi.DOYU@nokia.com>
 <1227605998-13531-5-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:34880 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752314AbYKYJkY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Nov 2008 04:40:24 -0500
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id mAP9eLDV029860
	for <linux-omap@vger.kernel.org>; Tue, 25 Nov 2008 11:40:22 +0200
Received: from oreo.research.nokia.com (esdhcp04130.research.nokia.com [172.21.41.30])
	by mgw-int01.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id mAP9dxqn016087
	for <linux-omap@vger.kernel.org>; Tue, 25 Nov 2008 11:39:59 +0200
In-Reply-To: <1227605998-13531-5-git-send-email-Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/mach-omap1/devices.c |    2 +-
 arch/arm/mach-omap1/mailbox.c |   31 +++++++++++++++++--------------
 2 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-omap1/devices.c b/arch/arm/mach-omap1/devices.c
index 77382d8..b4b6106 100644
--- a/arch/arm/mach-omap1/devices.c
+++ b/arch/arm/mach-omap1/devices.c
@@ -86,7 +86,7 @@ static struct resource mbox_resources[] = {
 };
 
 static struct platform_device mbox_device = {
-	.name		= "mailbox",
+	.name		= "omap1-mailbox",
 	.id		= -1,
 	.num_resources	= ARRAY_SIZE(mbox_resources),
 	.resource	= mbox_resources,
diff --git a/arch/arm/mach-omap1/mailbox.c b/arch/arm/mach-omap1/mailbox.c
index 59abbf3..d4b2e94 100644
--- a/arch/arm/mach-omap1/mailbox.c
+++ b/arch/arm/mach-omap1/mailbox.c
@@ -1,7 +1,7 @@
 /*
  * Mailbox reservation modules for DSP
  *
- * Copyright (C) 2006 Nokia Corporation
+ * Copyright (C) 2006-2008 Nokia Corporation
  * Written by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
  *
  * This file is subject to the terms and conditions of the GNU General Public
@@ -17,6 +17,8 @@
 #include <mach/mailbox.h>
 #include <mach/irqs.h>
 
+#define DRV_NAME "omap1-mailbox"
+
 #define MAILBOX_ARM2DSP1		0x00
 #define MAILBOX_ARM2DSP1b		0x04
 #define MAILBOX_DSP2ARM1		0x08
@@ -27,7 +29,7 @@
 #define MAILBOX_DSP2ARM1_Flag		0x1c
 #define MAILBOX_DSP2ARM2_Flag		0x20
 
-unsigned long mbox_base;
+static void __iomem *mbox_base;
 
 struct omap_mbox1_fifo {
 	unsigned long cmd;
@@ -40,14 +42,14 @@ struct omap_mbox1_priv {
 	struct omap_mbox1_fifo rx_fifo;
 };
 
-static inline int mbox_read_reg(unsigned int reg)
+static inline int mbox_read_reg(size_t ofs)
 {
-	return __raw_readw(mbox_base + reg);
+	return __raw_readw(mbox_base + ofs);
 }
 
-static inline void mbox_write_reg(unsigned int val, unsigned int reg)
+static inline void mbox_write_reg(u32 val, size_t ofs)
 {
-	__raw_writew(val, mbox_base + reg);
+	__raw_writew(val, mbox_base + ofs);
 }
 
 /* msg */
@@ -143,7 +145,7 @@ struct omap_mbox mbox_dsp_info = {
 };
 EXPORT_SYMBOL(mbox_dsp_info);
 
-static int __init omap1_mbox_probe(struct platform_device *pdev)
+static int __devinit omap1_mbox_probe(struct platform_device *pdev)
 {
 	struct resource *res;
 	int ret = 0;
@@ -170,12 +172,10 @@ static int __init omap1_mbox_probe(struct platform_device *pdev)
 	}
 	mbox_dsp_info.irq = res->start;
 
-	ret = omap_mbox_register(&mbox_dsp_info);
-
-	return ret;
+	return omap_mbox_register(&pdev->dev, &mbox_dsp_info);
 }
 
-static int omap1_mbox_remove(struct platform_device *pdev)
+static int __devexit omap1_mbox_remove(struct platform_device *pdev)
 {
 	omap_mbox_unregister(&mbox_dsp_info);
 
@@ -184,9 +184,9 @@ static int omap1_mbox_remove(struct platform_device *pdev)
 
 static struct platform_driver omap1_mbox_driver = {
 	.probe	= omap1_mbox_probe,
-	.remove	= omap1_mbox_remove,
+	.remove	= __devexit_p(omap1_mbox_remove),
 	.driver	= {
-		.name	= "mailbox",
+		.name	= DRV_NAME,
 	},
 };
 
@@ -203,4 +203,7 @@ static void __exit omap1_mbox_exit(void)
 module_init(omap1_mbox_init);
 module_exit(omap1_mbox_exit);
 
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("omap mailbox: omap1 architecture specific functions");
+MODULE_AUTHOR("Hiroshi DOYU" <Hiroshi.DOYU@nokia.com>);
+MODULE_ALIAS("platform:"DRV_NAME");
-- 
1.6.0.3.613.g9f8f13

