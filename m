From: Riku Voipio <riku.voipio@iki.fi>
Subject: Re: N800 problems with MMC, LM8323 on current linux-omap git head
Date: Tue, 22 Jul 2008 15:47:43 +0300
Message-ID: <20080722124743.GA5820@kos.to>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="X1bOJ3K7DJ5YkBrT"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from naru.obs2.net ([84.20.150.76]:38293 "EHLO narury.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750798AbYGVNVK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Jul 2008 09:21:10 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com, linux-omap@vger.kernel.org


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> Subject: [PATCH] input: add more error checks to lm8323 driver

> If we can't reach the driver, we stop trying to probe
> it. Useful when building kernel for n800 and n810.

> n800 doesn't have lm8323, so that driver shouldn't probe
> there.

Hmm. I think it would be better to avoid calling the probe
in first place. git diff made the attached patch look more
confusing than it actually is. Personally I'd eliminate
all ifdefs from those i2c_board_info structs.


-- 
"rm -rf" only sounds scary if you don't have backups

--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0001-Separate-i2c_board_info-for-n800-and-n810.patch"

>From 574835f1532f0be01e0456f98bf13ebb954bc6c3 Mon Sep 17 00:00:00 2001
From: Riku Voipio <riku.voipio@iki.fi>
Date: Tue, 22 Jul 2008 00:29:31 +0300
Subject: [PATCH] Separate i2c_board_info for n800 and n810

n800 and n810 have different peripherals, on the second i2c bus
(tea5761 on n800 and lm8323 on n810). Thus they need different
i2c_board_info as well to avoid probing nonexistent devices.
---
 arch/arm/mach-omap2/board-n800.c |   24 +++++++++++++++++++++---
 1 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/board-n800.c b/arch/arm/mach-omap2/board-n800.c
index ae85c2c..95a2727 100644
--- a/arch/arm/mach-omap2/board-n800.c
+++ b/arch/arm/mach-omap2/board-n800.c
@@ -654,13 +654,26 @@ static struct i2c_board_info __initdata_or_module n800_i2c_board_info_2[] = {
 		I2C_BOARD_INFO("tea5761", 0x10),
 	},
 #endif
-#ifdef CONFIG_MACH_NOKIA_N810
+	{
+		I2C_BOARD_INFO("tsl2563", 0x29),
+	},
+	{
+		I2C_BOARD_INFO("lp5521", 0x32),
+	},
+};
+
+static struct i2c_board_info __initdata_or_module n810_i2c_board_info_2[] = {
+#if defined (CONFIG_VIDEO_TCM825X) || defined (CONFIG_VIDEO_TCM825X_MODULE)
+	{
+		I2C_BOARD_INFO(TCM825X_NAME, TCM825X_I2C_ADDR),
+		.platform_data = &n800_tcm825x_platform_data,
+	},
+#endif
 	{
 		I2C_BOARD_INFO("lm8323", 0x45),
 		.irq		= OMAP_GPIO_IRQ(109),
 		.platform_data	= &lm8323_pdata,
 	},
-#endif
 	{
 		I2C_BOARD_INFO("tsl2563", 0x29),
 	},
@@ -690,8 +703,13 @@ void __init nokia_n800_common_init(void)
 	omap_serial_init();
 	omap_register_i2c_bus(1, 400, n800_i2c_board_info_1,
 			      ARRAY_SIZE(n800_i2c_board_info_1));
-	omap_register_i2c_bus(2, 400, n800_i2c_board_info_2,
+	if (machine_is_nokia_n800())
+		omap_register_i2c_bus(2, 400, n800_i2c_board_info_2,
 			      ARRAY_SIZE(n800_i2c_board_info_2));
+	if (machine_is_nokia_n810())
+		omap_register_i2c_bus(2, 400, n810_i2c_board_info_2,
+			      ARRAY_SIZE(n810_i2c_board_info_2));
+		
 	mipid_dev_init();
 	blizzard_dev_init();
 }
-- 
1.5.5.4


--X1bOJ3K7DJ5YkBrT--
