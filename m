From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 2/2] i2c-omap: don't compile in OMAP15xx I2C ISR for
	non-OMAP15xx builds
Date: Thu, 17 Jul 2008 19:44:14 -0600
Message-ID: <20080718014413.22295.44792.stgit@localhost.localdomain>
References: <20080718013912.22295.5368.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:50370 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757717AbYGRBos (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Jul 2008 21:44:48 -0400
In-Reply-To: <20080718013912.22295.5368.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Skip compiling OMAP15xx I2C ISR for non-OMAP15xx builds.  Saves 400 bytes
of text for most OMAP builds.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---

 drivers/i2c/busses/i2c-omap.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index ed60693..1bf0ad6 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -529,6 +529,9 @@ omap_i2c_ack_stat(struct omap_i2c_dev *dev, u16 stat)
 	omap_i2c_write_reg(dev, OMAP_I2C_STAT_REG, stat);
 }
 
+/* rev1 devices are apparently only on some 15xx */
+#ifdef CONFIG_ARCH_OMAP15XX
+
 static irqreturn_t
 omap_i2c_rev1_isr(int this_irq, void *dev_id)
 {
@@ -583,6 +586,9 @@ omap_i2c_rev1_isr(int this_irq, void *dev_id)
 
 	return IRQ_HANDLED;
 }
+#else
+#define omap_i2c_rev1_isr		0
+#endif
 
 static irqreturn_t
 omap_i2c_isr(int this_irq, void *dev_id)
@@ -844,14 +850,14 @@ static struct platform_driver omap_i2c_driver = {
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


