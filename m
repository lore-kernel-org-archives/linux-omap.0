From: Riku Voipio <riku.voipio@iki.fi>
Subject: Re: [i2c] N800 problems with MMC, LM8323 on current linux-omap git head
Date: Wed, 23 Jul 2008 12:38:49 +0300
Message-ID: <20080723093849.GA13505@kos.to>
References: <20080722124743.GA5820@kos.to> <90eb4be1e5a489819f08e76ad872e920@felipebalbi.com> <20080722133742.GA7492@kos.to> <20080722134314.GC8318@fluff.org.uk> <eb09f11f1e5a25903cfd4c2157ecbba5@felipebalbi.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="45Z9DzgjV8m4Oswq"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from naru.obs2.net ([84.20.150.76]:41614 "EHLO narury.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752012AbYGWJiw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Jul 2008 05:38:52 -0400
Content-Disposition: inline
In-Reply-To: <eb09f11f1e5a25903cfd4c2157ecbba5@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: Ben Dooks <ben-linux@fluff.org>, linux-omap@vger.kernel.org, i2c@lm-sensors.org


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 22, 2008 at 09:20:46AM -0500, Felipe Balbi wrote:
> On Tue, 22 Jul 2008 14:43:14 +0100, Ben Dooks <ben-linux@fluff.org> wrote:
> > Split them into a common and then machine specfic structures, you are
> > allowed to register more than one board per bus.

> Good to know :-)

Indeed - compared to my previous version, this one makes the boardfile
even smaller:

   text    data     bss     dec     hex filename
   2362    1552       4    3918     f4e old/arch/arm/mach-omap2/board-n800.o
   2354    1456       4    3814     ee6 new/arch/arm/mach-omap2/board-n800.o


> Riku, could you update your patch then ?

tested and attached.

> but it anyways doesn't annul the need of a better error handling
> in lm8323. I think both patches will need to be applied :-)

true. 

-- 
"rm -rf" only sounds scary if you don't have backups

--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0001-Separate-i2c_board_info-for-n800-and-n810.patch"

>From 1e9d7271505e85c99fe9b46653569ff6216e07b3 Mon Sep 17 00:00:00 2001
From: Riku Voipio <riku.voipio@iki.fi>
Date: Tue, 22 Jul 2008 12:29:31 +0300
Subject: [PATCH] Separate i2c_board_info for n800 and n810

n800 and n810 have different peripherals on the second i2c bus
(tea5761 on n800 and lm8323 on n810). Split the i2c_board_info to
common and hw specific to avoid probing nonexistent devices.

Signed-off-by: Riku Voipio <riku.voipio@iki.fi>
---
 arch/arm/mach-omap2/board-n800.c |   36 ++++++++++++++++++++++--------------
 1 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-omap2/board-n800.c b/arch/arm/mach-omap2/board-n800.c
index ae85c2c..e156dbd 100644
--- a/arch/arm/mach-omap2/board-n800.c
+++ b/arch/arm/mach-omap2/board-n800.c
@@ -642,30 +642,31 @@ static struct i2c_board_info __initdata n800_i2c_board_info_1[] = {
 
 extern struct tcm825x_platform_data n800_tcm825x_platform_data;
 
-static struct i2c_board_info __initdata_or_module n800_i2c_board_info_2[] = {
-#if defined (CONFIG_VIDEO_TCM825X) || defined (CONFIG_VIDEO_TCM825X_MODULE)
+static struct i2c_board_info __initdata_or_module n8x0_i2c_board_info_2[] = {
 	{
 		I2C_BOARD_INFO(TCM825X_NAME, TCM825X_I2C_ADDR),
 		.platform_data = &n800_tcm825x_platform_data,
 	},
-#endif
-#if defined(CONFIG_RADIO_TEA5761) || defined(CONFIG_RADIO_TEA5761_MODULE)
 	{
-		I2C_BOARD_INFO("tea5761", 0x10),
+		I2C_BOARD_INFO("tsl2563", 0x29),
 	},
-#endif
-#ifdef CONFIG_MACH_NOKIA_N810
 	{
-		I2C_BOARD_INFO("lm8323", 0x45),
-		.irq		= OMAP_GPIO_IRQ(109),
-		.platform_data	= &lm8323_pdata,
+		I2C_BOARD_INFO("lp5521", 0x32),
 	},
-#endif
+};
+
+
+static struct i2c_board_info __initdata_or_module n800_i2c_board_info_2[] = {
 	{
-		I2C_BOARD_INFO("tsl2563", 0x29),
+		I2C_BOARD_INFO("tea5761", 0x10),
 	},
+};
+
+static struct i2c_board_info __initdata_or_module n810_i2c_board_info_2[] = {
 	{
-		I2C_BOARD_INFO("lp5521", 0x32),
+		I2C_BOARD_INFO("lm8323", 0x45),
+		.irq		= OMAP_GPIO_IRQ(109),
+		.platform_data	= &lm8323_pdata,
 	},
 };
 
@@ -690,8 +691,15 @@ void __init nokia_n800_common_init(void)
 	omap_serial_init();
 	omap_register_i2c_bus(1, 400, n800_i2c_board_info_1,
 			      ARRAY_SIZE(n800_i2c_board_info_1));
-	omap_register_i2c_bus(2, 400, n800_i2c_board_info_2,
+	omap_register_i2c_bus(2, 400, n8x0_i2c_board_info_2,
 			      ARRAY_SIZE(n800_i2c_board_info_2));
+	if (machine_is_nokia_n800())
+		i2c_register_board_info(2, n800_i2c_board_info_2,
+			ARRAY_SIZE(n800_i2c_board_info_2));
+	if (machine_is_nokia_n810())
+	    i2c_register_board_info(2, n810_i2c_board_info_2,
+			ARRAY_SIZE(n810_i2c_board_info_2));
+		
 	mipid_dev_init();
 	blizzard_dev_init();
 }
-- 
1.5.5.4


--45Z9DzgjV8m4Oswq--
