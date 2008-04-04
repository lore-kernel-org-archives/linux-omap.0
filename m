From: Andrzej Zaborowski <balrogg@gmail.com>
Subject: [PATCH] Stop AIC23 driver from Oopsing.
Date: Fri,  4 Apr 2008 02:56:34 +0200
Message-ID: <12072705941142-git-send-email-balrogg@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 3a.49.1343.static.theplanet.com ([67.19.73.58]:37558 "EHLO
	pug.o-hand.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754779AbYDCXwI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 Apr 2008 19:52:08 -0400
Received: from borg (cjx126.neoplus.adsl.tpnet.pl [83.31.73.126])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pug.o-hand.com (Postfix) with ESMTP id 6E702E2B47D
	for <linux-omap@vger.kernel.org>; Thu,  3 Apr 2008 19:52:05 -0400 (EDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Andrzej Zaborowski <balrog@zabor.org>

Prevent AIC23 driver Oopsing when no AIC23 is present by moving some of the
initialisation to after the chip is found.  There seems to be more that
should be fixed in this driver but with this change it can at least be
compiled into a kernel safely.

Signed-off-by: Andrzej Zaborowski <balrog@zabor.org>
---
 drivers/i2c/chips/tlv320aic23.c |   94 ++++++++++++++++++++------------------
 1 files changed, 49 insertions(+), 45 deletions(-)

diff --git a/drivers/i2c/chips/tlv320aic23.c b/drivers/i2c/chips/tlv320aic23.c
index a2ec4bc..544cc28 100644
--- a/drivers/i2c/chips/tlv320aic23.c
+++ b/drivers/i2c/chips/tlv320aic23.c
@@ -54,6 +54,7 @@ I2C_CLIENT_INSMOD;
 static struct i2c_driver aic23_driver;
 static struct i2c_client *new_client;
 static int selftest;
+static struct platform_device audio_i2c_device;
 
 static struct aic23_info {
 	u16 volume_reg_left;
@@ -95,6 +96,38 @@ int aic23_write_value(u8 reg, u16 value)
 	return 0;
 }
 
+/*
+ * Configures the McBSP3 which is used to send clock to the AIC23 codec.
+ * The input clock rate from DSP is 12MHz.
+ * The DSP clock must be on before this is called.
+ */
+static int omap_mcbsp3_aic23_clock_init(void)
+{
+	u16 w;
+
+	/* enable 12MHz clock to mcbsp 1 & 3 */
+	__raw_writew(__raw_readw(DSP_IDLECT2) | (1<<1), DSP_IDLECT2);
+	__raw_writew(__raw_readw(DSP_RSTCT2) | 1 | 1<<1, DSP_RSTCT2);
+
+	/* disable sample rate generator */
+	OMAP_MCBSP_WRITE(OMAP1610_MCBSP3_BASE, SPCR1, 0x0000);
+	OMAP_MCBSP_WRITE(OMAP1610_MCBSP3_BASE, SPCR2, 0x0000);
+
+	/* pin control register */
+	OMAP_MCBSP_WRITE(OMAP1610_MCBSP3_BASE, PCR0,(CLKXM | CLKXP | CLKRP));
+
+	/* configure srg to send 12MHz pulse from dsp peripheral clock */
+	OMAP_MCBSP_WRITE(OMAP1610_MCBSP3_BASE, SRGR1, 0x0000);
+	OMAP_MCBSP_WRITE(OMAP1610_MCBSP3_BASE, SRGR2, CLKSM);
+
+	/* enable sample rate generator */
+	w = OMAP_MCBSP_READ(OMAP1610_MCBSP3_BASE, SPCR2);
+	OMAP_MCBSP_WRITE(OMAP1610_MCBSP3_BASE, SPCR2, (w | FREE | GRST));
+	printk("Clock enabled to MCBSP1 & 3 \n");
+
+	return 0;
+}
+
 static int aic23_detect_client(struct i2c_adapter *adapter, int address,
 				     int kind)
 {
@@ -103,7 +136,7 @@ static int aic23_detect_client(struct i2c_adapter *adapter, int address,
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_WORD_DATA |
 				     I2C_FUNC_SMBUS_WRITE_BYTE)) {
-		printk(KERN_WARNING "%s functinality check failed\n",
+		printk(KERN_WARNING "%s functionality check failed\n",
 		       client_name);
 		return err;
 	}
@@ -128,6 +161,19 @@ static int aic23_detect_client(struct i2c_adapter *adapter, int address,
 		kfree(new_client);
 		return err;
 	}
+
+	if (platform_device_register(&audio_i2c_device)) {
+		printk(KERN_WARNING "Failed to register audio i2c device\n");
+		selftest = -ENODEV;
+		return selftest;
+	}
+	/* FIXME: Do in board-specific file */
+	omap_mcbsp3_aic23_clock_init();
+
+	if (!aic23_info_l.power_down)
+		aic23_power_up();
+	aic23_info_l.initialized = 1;
+
 	return 0;
 }
 
@@ -135,6 +181,8 @@ static int aic23_detach_client(struct i2c_client *client)
 {
 	int err;
 
+	platform_device_unregister(&audio_i2c_device);
+
 	if ((err = i2c_detach_client(client))) {
 		printk("aic23.o: Client deregistration failed, \
 		       client not detached.\n");
@@ -162,38 +210,6 @@ static struct i2c_driver aic23_driver = {
 	.detach_client	= aic23_detach_client,
 };
 
-/*
- * Configures the McBSP3 which is used to send clock to the AIC23 codec.
- * The input clock rate from DSP is 12MHz.
- * The DSP clock must be on before this is called.
- */
-static int omap_mcbsp3_aic23_clock_init(void)
-{
-	u16 w;
-
-	/* enable 12MHz clock to mcbsp 1 & 3 */
-	__raw_writew(__raw_readw(DSP_IDLECT2) | (1<<1), DSP_IDLECT2);
-	__raw_writew(__raw_readw(DSP_RSTCT2) | 1 | 1<<1, DSP_RSTCT2);
-
-	/* disable sample rate generator */
-	OMAP_MCBSP_WRITE(OMAP1610_MCBSP3_BASE, SPCR1, 0x0000);
-	OMAP_MCBSP_WRITE(OMAP1610_MCBSP3_BASE, SPCR2, 0x0000);
-
-	/* pin control register */
-	OMAP_MCBSP_WRITE(OMAP1610_MCBSP3_BASE, PCR0,(CLKXM | CLKXP | CLKRP));
-
-	/* configure srg to send 12MHz pulse from dsp peripheral clock */
-	OMAP_MCBSP_WRITE(OMAP1610_MCBSP3_BASE, SRGR1, 0x0000);
-	OMAP_MCBSP_WRITE(OMAP1610_MCBSP3_BASE, SRGR2, CLKSM);
-
-	/* enable sample rate generator */
-	w = OMAP_MCBSP_READ(OMAP1610_MCBSP3_BASE, SPCR2);
-	OMAP_MCBSP_WRITE(OMAP1610_MCBSP3_BASE, SPCR2, (w | FREE | GRST));
-	printk("Clock enabled to MCBSP1 & 3 \n");
-
-	return 0;
-}
-
 static void update_volume_left(int volume)
 {
 	u16 val = 0;
@@ -633,17 +649,6 @@ static int __init aic23_init(void)
 		return selftest;
 	}
 
-	if (platform_device_register(&audio_i2c_device)) {
-		printk(KERN_WARNING "Failed to register audio i2c device\n");
-		platform_driver_unregister(&audio_i2c_driver);
-		selftest = -ENODEV;
-		return selftest;
-	}
-	/* FIXME: Do in board-specific file */
-	omap_mcbsp3_aic23_clock_init();
-	if (!aic23_info_l.power_down)
-		aic23_power_up();
-	aic23_info_l.initialized = 1;
 	printk("TLV320AIC23 I2C version %s (%s)\n",
 	       TLV320AIC23_VERSION, TLV320AIC23_DATE);
 
@@ -655,7 +660,6 @@ static void __exit aic23_exit(void)
 	aic23_power_down();
 	i2c_del_driver(&aic23_driver);
 
-	platform_device_unregister(&audio_i2c_device);
 	platform_driver_unregister(&audio_i2c_driver);
 }
 
-- 
1.5.3.4

