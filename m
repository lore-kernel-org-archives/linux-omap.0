From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 7/8] i2c-omap: Don't compile in OMAP15xx I2C ISR for non-OMAP15xx builds
Date: Thu, 25 Sep 2008 10:16:33 +0300
Message-ID: <1222326994-26836-8-git-send-email-tony@atomide.com>
References: <1222326994-26836-1-git-send-email-tony@atomide.com>
 <1222326994-26836-2-git-send-email-tony@atomide.com>
 <1222326994-26836-3-git-send-email-tony@atomide.com>
 <1222326994-26836-4-git-send-email-tony@atomide.com>
 <1222326994-26836-5-git-send-email-tony@atomide.com>
 <1222326994-26836-6-git-send-email-tony@atomide.com>
 <1222326994-26836-7-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:55612 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752231AbYIYHRB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Sep 2008 03:17:01 -0400
In-Reply-To: <1222326994-26836-7-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: i2c@lm-sensors.org
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>

From: Paul Walmsley <paul@pwsan.com>

Skip compiling OMAP15xx I2C ISR for non-OMAP15xx builds.  Saves 400 bytes
of text for most OMAP builds.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/i2c/busses/i2c-omap.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 52ecddd..9ac64c7 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -510,6 +510,9 @@ omap_i2c_ack_stat(struct omap_i2c_dev *dev, u16 stat)
 	omap_i2c_write_reg(dev, OMAP_I2C_STAT_REG, stat);
 }
 
+/* rev1 devices are apparently only on some 15xx */
+#ifdef CONFIG_ARCH_OMAP15XX
+
 static irqreturn_t
 omap_i2c_rev1_isr(int this_irq, void *dev_id)
 {
@@ -564,6 +567,9 @@ omap_i2c_rev1_isr(int this_irq, void *dev_id)
 
 	return IRQ_HANDLED;
 }
+#else
+#define omap_i2c_rev1_isr		0
+#endif
 
 static irqreturn_t
 omap_i2c_isr(int this_irq, void *dev_id)
@@ -840,14 +846,14 @@ static struct platform_driver omap_i2c_driver = {
 };
 
 /* I2C may be needed to bring up other drivers */
-static int __init
+static int __devinit
 omap_i2c_init_driver(void)
 {
 	return platform_driver_register(&omap_i2c_driver);
 }
 subsys_initcall(omap_i2c_init_driver);
 
-static void __exit omap_i2c_exit_driver(void)
+static void __devexit omap_i2c_exit_driver(void)
 {
 	platform_driver_unregister(&omap_i2c_driver);
 }
-- 
1.5.6.rc3.21.g8c6b5

