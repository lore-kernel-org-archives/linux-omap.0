From: Russ Dill <Russ.Dill@ti.com>
Subject: [PATCH v2] [OMAP] Mark Beagleboard-xM MMC bus as 4-bit
Date: Mon,  7 May 2012 19:24:09 -0700
Message-ID: <1336443849-22753-1-git-send-email-Russ.Dill@ti.com>
References: <20120507203139.GL5088@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:54932 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757860Ab2EHCYR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 May 2012 22:24:17 -0400
Received: by obbtb18 with SMTP id tb18so9117093obb.19
        for <linux-omap@vger.kernel.org>; Mon, 07 May 2012 19:24:17 -0700 (PDT)
In-Reply-To: <20120507203139.GL5088@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Russ Dill <Russ.Dill@ti.com>

On Beagleboard-xM (all revisions) only MMC1_DAT0-MMC1_DAT3 are wired up.
Tested on Beagleboard-xM Rev C1 and Beagleboard Rev B4.

v2 - Moved logic into omap3_beagle_init_rev

Signed-off-by: Russ Dill <Russ.Dill@ti.com>
---
 arch/arm/mach-omap2/board-omap3beagle.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 7be8d65..ae7d3a7 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -83,11 +83,13 @@ static struct {
 	int usb_pwr_level;
 	int reset_gpio;
 	int usr_button_gpio;
+	int mmc_caps;
 } beagle_config = {
 	.mmc1_gpio_wp = -EINVAL,
 	.usb_pwr_level = GPIOF_OUT_INIT_LOW,
 	.reset_gpio = 129,
 	.usr_button_gpio = 4,
+	.mmc_caps = MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA,
 };
 
 static struct gpio omap3_beagle_rev_gpios[] __initdata = {
@@ -145,10 +147,12 @@ static void __init omap3_beagle_init_rev(void)
 		printk(KERN_INFO "OMAP3 Beagle Rev: xM Ax/Bx\n");
 		omap3_beagle_version = OMAP3BEAGLE_BOARD_XM;
 		beagle_config.usb_pwr_level = GPIOF_OUT_INIT_HIGH;
+		beagle_config.mmc_caps &= ~MMC_CAP_8_BIT_DATA;
 		break;
 	case 2:
 		printk(KERN_INFO "OMAP3 Beagle Rev: xM C\n");
 		omap3_beagle_version = OMAP3BEAGLE_BOARD_XMC;
+		beagle_config.mmc_caps &= ~MMC_CAP_8_BIT_DATA;
 		break;
 	default:
 		printk(KERN_INFO "OMAP3 Beagle Rev: unknown %hd\n", beagle_rev);
@@ -251,7 +255,7 @@ static void __init beagle_display_init(void)
 static struct omap2_hsmmc_info mmc[] = {
 	{
 		.mmc		= 1,
-		.caps		= MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA,
+		.caps		= MMC_CAP_4_BIT_DATA,
 		.gpio_wp	= -EINVAL,
 		.deferred	= true,
 	},
@@ -523,6 +527,7 @@ static void __init omap3_beagle_init(void)
 
 	if (beagle_config.mmc1_gpio_wp != -EINVAL)
 		omap_mux_init_gpio(beagle_config.mmc1_gpio_wp, OMAP_PIN_INPUT);
+	mmc[0].caps = beagle_config.mmc_caps;
 	omap_hsmmc_init(mmc);
 
 	omap3_beagle_i2c_init();
-- 
1.7.9.5

