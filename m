From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 10/10] ARM: OMAP: Remove unused platform devices, v3
Date: Thu, 15 Jan 2009 15:10:55 +0200
Message-ID: <20090115131054.GD4128@atomide.com>
References: <20090112143405.24205.52151.stgit@localhost> <20090112145005.24205.31628.stgit@localhost> <20090115121118.GB4128@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="AkbCVLjbJ9qUtAXD"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:52135 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757529AbZAONK5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Jan 2009 08:10:57 -0500
Content-Disposition: inline
In-Reply-To: <20090115121118.GB4128@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: Arun KS <arunks@mistralsolutions.com>, linux-omap@vger.kernel.org, Jarkko Nikula <jarkko.nikula@nokia.com>


--AkbCVLjbJ9qUtAXD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Tony Lindgren <tony@atomide.com> [090115 14:13]:
> * Tony Lindgren <tony@atomide.com> [090112 16:51]:
> > This patch removes old platform devices. The should be now
> > replaced with ASoC driver. For boards not yet using ASoC,
> > please see sound/soc/omap/osk5912.c.
> > 
> > Add dummy aic23_power_up and aic23_power_down functions for 770
> > to keep things compiling.
> > 
> > This patch is based on an earlier patch by Arun KS.
> 
> Updates to fix H2 compile as noted by Russell King. ALso remove
> unused gpio_switch and nand code.

One more update, now with include fixes for sx1 and 770.

Tony

--AkbCVLjbJ9qUtAXD
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="unused-v3.patch"

>From e999bbe7f1318390e997d13e508e4f16b1b130af Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Thu, 15 Jan 2009 13:55:59 +0200
Subject: [PATCH] ARM: OMAP: Remove unused platform devices, v3

This patch removes old platform devices. Alsa should now
be using the ASoC driver. For boards not yet using ASoC,
please see sound/soc/omap/osk5912.c.

Add dummy aic23_power_up and aic23_power_down functions for 770
to keep things compiling.

Remove references to omap_gpio_switch, and unused h2_nand_dev_ready
function.

This patch is based on an earlier patch by Arun KS.

Cc: Jarkko Nikula <jarkko.nikula@nokia.com>
Signed-off-by: Arun KS <arunks@mistralsolutions.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap1/board-h2.c b/arch/arm/mach-omap1/board-h2.c
index b240c5f..0d784a7 100644
--- a/arch/arm/mach-omap1/board-h2.c
+++ b/arch/arm/mach-omap1/board-h2.c
@@ -37,16 +37,14 @@
 #include <asm/mach/flash.h>
 #include <asm/mach/map.h>
 
-#include <mach/gpio-switch.h>
 #include <mach/mux.h>
+#include <mach/dma.h>
 #include <mach/tc.h>
 #include <mach/nand.h>
 #include <mach/irda.h>
 #include <mach/usb.h>
 #include <mach/keypad.h>
 #include <mach/common.h>
-#include <mach/mcbsp.h>
-#include <mach/omap-alsa.h>
 
 static int h2_keymap[] = {
 	KEY(0, 0, KEY_LEFT),
@@ -292,41 +290,6 @@ static struct platform_device h2_lcd_device = {
 	.id		= -1,
 };
 
-static struct omap_mcbsp_reg_cfg mcbsp_regs = {
-	.spcr2 = FREE | FRST | GRST | XRST | XINTM(3),
-	.spcr1 = RINTM(3) | RRST,
-	.rcr2  = RPHASE | RFRLEN2(OMAP_MCBSP_WORD_8) |
-                RWDLEN2(OMAP_MCBSP_WORD_16) | RDATDLY(1),
-	.rcr1  = RFRLEN1(OMAP_MCBSP_WORD_8) | RWDLEN1(OMAP_MCBSP_WORD_16),
-	.xcr2  = XPHASE | XFRLEN2(OMAP_MCBSP_WORD_8) |
-                XWDLEN2(OMAP_MCBSP_WORD_16) | XDATDLY(1) | XFIG,
-	.xcr1  = XFRLEN1(OMAP_MCBSP_WORD_8) | XWDLEN1(OMAP_MCBSP_WORD_16),
-	.srgr1 = FWID(15),
-	.srgr2 = GSYNC | CLKSP | FSGM | FPER(31),
-
-	.pcr0  = CLKXM | CLKRM | FSXP | FSRP | CLKXP | CLKRP,
-	/*.pcr0 = CLKXP | CLKRP,*/        /* mcbsp: slave */
-};
-
-static struct omap_alsa_codec_config alsa_config = {
-	.name                   = "H2 TSC2101",
-	.mcbsp_regs_alsa        = &mcbsp_regs,
-	.codec_configure_dev    = NULL, /* tsc2101_configure, */
-	.codec_set_samplerate   = NULL, /* tsc2101_set_samplerate, */
-	.codec_clock_setup      = NULL, /* tsc2101_clock_setup, */
-	.codec_clock_on         = NULL, /* tsc2101_clock_on, */
-	.codec_clock_off        = NULL, /* tsc2101_clock_off, */
-	.get_default_samplerate = NULL, /* tsc2101_get_default_samplerate, */
-};
-
-static struct platform_device h2_mcbsp1_device = {
-	.name	= "omap_alsa_mcbsp",
-	.id	= 1,
-	.dev = {
-		.platform_data	= &alsa_config,
-	},
-};
-
 static struct platform_device *h2_devices[] __initdata = {
 	&h2_nor_device,
 	&h2_nand_device,
@@ -334,7 +297,6 @@ static struct platform_device *h2_devices[] __initdata = {
 	&h2_irda_device,
 	&h2_kp_device,
 	&h2_lcd_device,
-	&h2_mcbsp1_device,
 };
 
 static void __init h2_init_smc91x(void)
@@ -409,11 +371,6 @@ static struct omap_board_config_kernel h2_config[] __initdata = {
 
 #define H2_NAND_RB_GPIO_PIN	62
 
-static int h2_nand_dev_ready(struct omap_nand_platform_data *data)
-{
-	return gpio_get_value(H2_NAND_RB_GPIO_PIN);
-}
-
 static void __init h2_init(void)
 {
 	/* Here we assume the NOR boot config:  NOR on CS3 (possibly swapped
diff --git a/arch/arm/mach-omap1/board-h3.c b/arch/arm/mach-omap1/board-h3.c
index 5157eea..bf08b6a 100644
--- a/arch/arm/mach-omap1/board-h3.c
+++ b/arch/arm/mach-omap1/board-h3.c
@@ -49,8 +49,6 @@
 #include <mach/keypad.h>
 #include <mach/dma.h>
 #include <mach/common.h>
-#include <mach/mcbsp.h>
-#include <mach/omap-alsa.h>
 
 #define H3_TS_GPIO	48
 
@@ -387,41 +385,6 @@ static struct spi_board_info h3_spi_board_info[] __initdata = {
 	},
 };
 
-static struct omap_mcbsp_reg_cfg mcbsp_regs = {
-	.spcr2 = FREE | FRST | GRST | XRST | XINTM(3),
-	.spcr1 = RINTM(3) | RRST,
-	.rcr2  = RPHASE | RFRLEN2(OMAP_MCBSP_WORD_8) |
-                RWDLEN2(OMAP_MCBSP_WORD_16) | RDATDLY(1),
-	.rcr1  = RFRLEN1(OMAP_MCBSP_WORD_8) | RWDLEN1(OMAP_MCBSP_WORD_16),
-	.xcr2  = XPHASE | XFRLEN2(OMAP_MCBSP_WORD_8) |
-                XWDLEN2(OMAP_MCBSP_WORD_16) | XDATDLY(1) | XFIG,
-	.xcr1  = XFRLEN1(OMAP_MCBSP_WORD_8) | XWDLEN1(OMAP_MCBSP_WORD_16),
-	.srgr1 = FWID(15),
-	.srgr2 = GSYNC | CLKSP | FSGM | FPER(31),
-
-	.pcr0  = CLKRM | SCLKME | FSXP | FSRP | CLKXP | CLKRP,
-	/*.pcr0 = CLKXP | CLKRP,*/        /* mcbsp: slave */
-};
-
-static struct omap_alsa_codec_config alsa_config = {
-	.name                   = "H3 TSC2101",
-	.mcbsp_regs_alsa        = &mcbsp_regs,
-	.codec_configure_dev    = NULL, /* tsc2101_configure, */
-	.codec_set_samplerate   = NULL, /* tsc2101_set_samplerate, */
-	.codec_clock_setup      = NULL, /* tsc2101_clock_setup, */
-	.codec_clock_on         = NULL, /* tsc2101_clock_on, */
-	.codec_clock_off        = NULL, /* tsc2101_clock_off, */
-	.get_default_samplerate = NULL, /* tsc2101_get_default_samplerate, */
-};
-
-static struct platform_device h3_mcbsp1_device = {
-	.name	= "omap_alsa_mcbsp",
-	.id	= 1,
-	.dev = {
-		.platform_data	= &alsa_config,
-	},
-};
-
 static struct platform_device *devices[] __initdata = {
 	&nor_device,
 	&nand_device,
@@ -430,7 +393,6 @@ static struct platform_device *devices[] __initdata = {
 	&h3_irda_device,
 	&h3_kp_device,
 	&h3_lcd_device,
-	&h3_mcbsp1_device,
 };
 
 static struct omap_usb_config h3_usb_config __initdata = {
@@ -472,18 +434,6 @@ static struct i2c_board_info __initdata h3_i2c_board_info[] = {
 	},
 };
 
-static struct omap_gpio_switch h3_gpio_switches[] __initdata = {
-	{
-		.name			= "mmc_slot",
-		.gpio                   = OMAP_MPUIO(1),
-		.type                   = OMAP_GPIO_SWITCH_TYPE_COVER,
-		.debounce_rising        = 100,
-		.debounce_falling       = 0,
-		.notify                 = h3_mmc_slot_cover_handler,
-		.notify_data            = NULL,
-	},
-};
-
 #define H3_NAND_RB_GPIO_PIN	10
 
 static int nand_dev_ready(struct omap_nand_platform_data *data)
diff --git a/arch/arm/mach-omap1/board-innovator.c b/arch/arm/mach-omap1/board-innovator.c
index af2fb90..071cd02 100644
--- a/arch/arm/mach-omap1/board-innovator.c
+++ b/arch/arm/mach-omap1/board-innovator.c
@@ -37,8 +37,6 @@
 #include <mach/usb.h>
 #include <mach/keypad.h>
 #include <mach/common.h>
-#include <mach/mcbsp.h>
-#include <mach/omap-alsa.h>
 #include <mach/mmc.h>
 
 static int innovator_keymap[] = {
@@ -115,42 +113,6 @@ static struct platform_device innovator_flash_device = {
 	.resource	= &innovator_flash_resource,
 };
 
-#define DEFAULT_BITPERSAMPLE 16
-
-static struct omap_mcbsp_reg_cfg mcbsp_regs = {
-	.spcr2 = FREE | FRST | GRST | XRST | XINTM(3),
-	.spcr1 = RINTM(3) | RRST,
-	.rcr2 = RPHASE | RFRLEN2(OMAP_MCBSP_WORD_8) |
-	    RWDLEN2(OMAP_MCBSP_WORD_16) | RDATDLY(0),
-	.rcr1 = RFRLEN1(OMAP_MCBSP_WORD_8) | RWDLEN1(OMAP_MCBSP_WORD_16),
-	.xcr2 = XPHASE | XFRLEN2(OMAP_MCBSP_WORD_8) |
-	    XWDLEN2(OMAP_MCBSP_WORD_16) | XDATDLY(0) | XFIG,
-	.xcr1 = XFRLEN1(OMAP_MCBSP_WORD_8) | XWDLEN1(OMAP_MCBSP_WORD_16),
-	.srgr1 = FWID(DEFAULT_BITPERSAMPLE - 1),
-	.srgr2 = GSYNC | CLKSP | FSGM | FPER(DEFAULT_BITPERSAMPLE * 2 - 1),
-	/*.pcr0 = FSXM | FSRM | CLKXM | CLKRM | CLKXP | CLKRP,*/ /* mcbsp: master */
-	.pcr0 = CLKXP | CLKRP,  /* mcbsp: slave */
-};
-
-static struct omap_alsa_codec_config alsa_config = {
-	.name			= "OMAP Innovator AIC23",
-	.mcbsp_regs_alsa	= &mcbsp_regs,
-	.codec_configure_dev	= NULL, /* aic23_configure, */
-	.codec_set_samplerate	= NULL, /* aic23_set_samplerate, */
-	.codec_clock_setup	= NULL, /* aic23_clock_setup, */
-	.codec_clock_on		= NULL, /* aic23_clock_on, */
-	.codec_clock_off	= NULL, /* aic23_clock_off, */
-	.get_default_samplerate	= NULL, /* aic23_get_default_samplerate, */
-};
-
-static struct platform_device innovator_mcbsp1_device = {
-	.name	= "omap_alsa_mcbsp",
- 	.id	= 1,
-	.dev = {
-		.platform_data	= &alsa_config,
-	},
-};
-
 static struct resource innovator_kp_resources[] = {
 	[0] = {
 		.start	= INT_KEYBOARD,
@@ -227,7 +189,6 @@ static struct platform_device innovator1510_spi_device = {
 static struct platform_device *innovator1510_devices[] __initdata = {
 	&innovator_flash_device,
 	&innovator1510_smc91x_device,
-	&innovator_mcbsp1_device,
 	&innovator_kp_device,
 	&innovator1510_lcd_device,
 	&innovator1510_spi_device,
diff --git a/arch/arm/mach-omap1/board-nokia770.c b/arch/arm/mach-omap1/board-nokia770.c
index 4970c40..af51e0b 100644
--- a/arch/arm/mach-omap1/board-nokia770.c
+++ b/arch/arm/mach-omap1/board-nokia770.c
@@ -32,7 +32,6 @@
 #include <mach/keypad.h>
 #include <mach/common.h>
 #include <mach/dsp_common.h>
-#include <mach/aic23.h>
 #include <mach/omapfb.h>
 #include <mach/lcd_mipid.h>
 #include <mach/mmc.h>
@@ -261,6 +260,13 @@ static DEFINE_MUTEX(audio_pwr_lock);
  */
 static int audio_pwr_state = -1;
 
+static inline void aic23_power_up(void)
+{
+}
+static inline void aic23_power_down(void)
+{
+}
+
 /*
  * audio_pwr_up / down should be called under audio_pwr_lock
  */
diff --git a/arch/arm/mach-omap1/board-osk.c b/arch/arm/mach-omap1/board-osk.c
index d17952f..1a16ecb 100644
--- a/arch/arm/mach-omap1/board-osk.c
+++ b/arch/arm/mach-omap1/board-osk.c
@@ -51,8 +51,6 @@
 #include <mach/mux.h>
 #include <mach/tc.h>
 #include <mach/common.h>
-#include <mach/mcbsp.h>
-#include <mach/omap-alsa.h>
 
 static struct mtd_partition osk_partitions[] = {
 	/* bootloader (U-Boot, etc) in first sector */
@@ -141,47 +139,10 @@ static struct platform_device osk5912_cf_device = {
 	.resource	= osk5912_cf_resources,
 };
 
-#define DEFAULT_BITPERSAMPLE 16
-
-static struct omap_mcbsp_reg_cfg mcbsp_regs = {
-	.spcr2 = FREE | FRST | GRST | XRST | XINTM(3),
-	.spcr1 = RINTM(3) | RRST,
-	.rcr2 = RPHASE | RFRLEN2(OMAP_MCBSP_WORD_8) |
-	    RWDLEN2(OMAP_MCBSP_WORD_16) | RDATDLY(0),
-	.rcr1 = RFRLEN1(OMAP_MCBSP_WORD_8) | RWDLEN1(OMAP_MCBSP_WORD_16),
-	.xcr2 = XPHASE | XFRLEN2(OMAP_MCBSP_WORD_8) |
-	    XWDLEN2(OMAP_MCBSP_WORD_16) | XDATDLY(0) | XFIG,
-	.xcr1 = XFRLEN1(OMAP_MCBSP_WORD_8) | XWDLEN1(OMAP_MCBSP_WORD_16),
-	.srgr1 = FWID(DEFAULT_BITPERSAMPLE - 1),
-	.srgr2 = GSYNC | CLKSP | FSGM | FPER(DEFAULT_BITPERSAMPLE * 2 - 1),
-	/*.pcr0 = FSXM | FSRM | CLKXM | CLKRM | CLKXP | CLKRP,*/ /* mcbsp: master */
-	.pcr0 = CLKXP | CLKRP,  /* mcbsp: slave */
-};
-
-static struct omap_alsa_codec_config alsa_config = {
-	.name			= "OSK AIC23",
-	.mcbsp_regs_alsa	= &mcbsp_regs,
-	.codec_configure_dev	= NULL, /* aic23_configure, */
-	.codec_set_samplerate	= NULL, /* aic23_set_samplerate, */
-	.codec_clock_setup	= NULL, /* aic23_clock_setup, */
-	.codec_clock_on		= NULL, /* aic23_clock_on, */
-	.codec_clock_off	= NULL, /* aic23_clock_off, */
-	.get_default_samplerate	= NULL, /* aic23_get_default_samplerate, */
-};
-
-static struct platform_device osk5912_mcbsp1_device = {
-	.name	= "omap_alsa_mcbsp",
-	.id	= 1,
-	.dev = {
-		.platform_data	= &alsa_config,
-	},
-};
-
 static struct platform_device *osk5912_devices[] __initdata = {
 	&osk5912_flash_device,
 	&osk5912_smc91x_device,
 	&osk5912_cf_device,
-	&osk5912_mcbsp1_device,
 };
 
 static struct gpio_led tps_leds[] = {
diff --git a/arch/arm/mach-omap1/board-palmte.c b/arch/arm/mach-omap1/board-palmte.c
index 00322f4..99f2b43 100644
--- a/arch/arm/mach-omap1/board-palmte.c
+++ b/arch/arm/mach-omap1/board-palmte.c
@@ -42,8 +42,6 @@
 #include <mach/irda.h>
 #include <mach/keypad.h>
 #include <mach/common.h>
-#include <mach/mcbsp.h>
-#include <mach/omap-alsa.h>
 
 static void __init omap_palmte_init_irq(void)
 {
@@ -203,24 +201,6 @@ static struct omap_uart_config palmte_uart_config __initdata = {
 	.enabled_uarts = (1 << 0) | (1 << 1) | (0 << 2),
 };
 
-static struct omap_mcbsp_reg_cfg palmte_mcbsp1_regs = {
-	.spcr2	= FRST | GRST | XRST | XINTM(3),
-	.xcr2	= XDATDLY(1) | XFIG,
-	.xcr1	= XWDLEN1(OMAP_MCBSP_WORD_32),
-	.pcr0	= SCLKME | FSXP | CLKXP,
-};
-
-static struct omap_alsa_codec_config palmte_alsa_config = {
-	.name			= "TSC2102 audio",
-	.mcbsp_regs_alsa	= &palmte_mcbsp1_regs,
-	.codec_configure_dev	= NULL,	/* tsc2102_configure, */
-	.codec_set_samplerate	= NULL,	/* tsc2102_set_samplerate, */
-	.codec_clock_setup	= NULL,	/* tsc2102_clock_setup, */
-	.codec_clock_on		= NULL,	/* tsc2102_clock_on, */
-	.codec_clock_off	= NULL,	/* tsc2102_clock_off, */
-	.get_default_samplerate	= NULL,	/* tsc2102_get_default_samplerate, */
-};
-
 #ifdef CONFIG_APM
 /*
  * Values measured in 10 minute intervals averaged over 10 samples.
diff --git a/arch/arm/mach-omap1/board-palmtt.c b/arch/arm/mach-omap1/board-palmtt.c
index 5c001af..1cbc127 100644
--- a/arch/arm/mach-omap1/board-palmtt.c
+++ b/arch/arm/mach-omap1/board-palmtt.c
@@ -30,7 +30,6 @@
 #include <asm/mach/flash.h>
 
 #include <mach/led.h>
-#include <mach/mcbsp.h>
 #include <mach/gpio.h>
 #include <mach/mux.h>
 #include <mach/usb.h>
@@ -40,7 +39,6 @@
 #include <mach/irda.h>
 #include <mach/keypad.h>
 #include <mach/common.h>
-#include <mach/omap-alsa.h>
 
 #include <linux/spi/spi.h>
 #include <linux/spi/ads7846.h>
@@ -122,44 +120,6 @@ static struct platform_device palmtt_flash_device = {
 	.resource	= &palmtt_flash_resource,
 };
 
-#define DEFAULT_BITPERSAMPLE 16
-
-static struct omap_mcbsp_reg_cfg mcbsp_regs = {
-	.spcr2		= FREE | FRST | GRST | XRST | XINTM(3),
-	.spcr1		= RINTM(3) | RRST,
-	.rcr2		= RPHASE | RFRLEN2(OMAP_MCBSP_WORD_8) |
-				RWDLEN2(OMAP_MCBSP_WORD_16) | RDATDLY(0),
-	.rcr1		= RFRLEN1(OMAP_MCBSP_WORD_8) |
-				RWDLEN1(OMAP_MCBSP_WORD_16),
-	.xcr2		= XPHASE | XFRLEN2(OMAP_MCBSP_WORD_8) |
-				XWDLEN2(OMAP_MCBSP_WORD_16) | XDATDLY(0) | XFIG,
-	.xcr1		= XFRLEN1(OMAP_MCBSP_WORD_8) |
-				XWDLEN1(OMAP_MCBSP_WORD_16),
-	.srgr1		= FWID(DEFAULT_BITPERSAMPLE - 1),
-	.srgr2		= GSYNC | CLKSP | FSGM |
-				FPER(DEFAULT_BITPERSAMPLE * 2 - 1),
-	.pcr0		= CLKXP | CLKRP,	/* mcbsp: slave */
-};
-
-static struct omap_alsa_codec_config alsa_config = {
-	.name			= "PalmTT AIC23",
-	.mcbsp_regs_alsa	= &mcbsp_regs,
-	.codec_configure_dev	= NULL, /* aic23_configure, */
-	.codec_set_samplerate	= NULL, /* aic23_set_samplerate, */
-	.codec_clock_setup	= NULL, /* aic23_clock_setup, */
-	.codec_clock_on		= NULL, /* aic23_clock_on, */
-	.codec_clock_off	= NULL, /* aic23_clock_off, */
-	.get_default_samplerate	= NULL, /* aic23_get_default_samplerate, */
-};
-
-static struct platform_device palmtt_mcbsp1_device = {
-	.name	= "omap_alsa_mcbsp",
-	.id	= 1,
-	.dev	= {
-		.platform_data	= &alsa_config,
-	},
-};
-
 static struct resource palmtt_kp_resources[] = {
 	[0] = {
 		.start	= INT_KEYBOARD,
@@ -257,7 +217,6 @@ static struct platform_device palmtt_led_device = {
 
 static struct platform_device *palmtt_devices[] __initdata = {
 	&palmtt_flash_device,
-	&palmtt_mcbsp1_device,
 	&palmtt_kp_device,
 	&palmtt_lcd_device,
 	&palmtt_irda_device,
diff --git a/arch/arm/mach-omap1/board-palmz71.c b/arch/arm/mach-omap1/board-palmz71.c
index cc05257..baf5efb 100644
--- a/arch/arm/mach-omap1/board-palmz71.c
+++ b/arch/arm/mach-omap1/board-palmz71.c
@@ -32,7 +32,6 @@
 #include <asm/mach/map.h>
 #include <asm/mach/flash.h>
 
-#include <mach/mcbsp.h>
 #include <mach/gpio.h>
 #include <mach/mux.h>
 #include <mach/usb.h>
@@ -179,41 +178,6 @@ static struct platform_device palmz71_spi_device = {
 	.id	= -1,
 };
 
-#define DEFAULT_BITPERSAMPLE 16
-
-static struct omap_mcbsp_reg_cfg mcbsp_regs = {
-	.spcr2	= FREE | FRST | GRST | XRST | XINTM(3),
-	.spcr1	= RINTM(3) | RRST,
-	.rcr2	= RPHASE | RFRLEN2(OMAP_MCBSP_WORD_8) |
-			RWDLEN2(OMAP_MCBSP_WORD_16) | RDATDLY(0),
-	.rcr1	= RFRLEN1(OMAP_MCBSP_WORD_8) | RWDLEN1(OMAP_MCBSP_WORD_16),
-	.xcr2	= XPHASE | XFRLEN2(OMAP_MCBSP_WORD_8) |
-			XWDLEN2(OMAP_MCBSP_WORD_16) | XDATDLY(0) | XFIG,
-	.xcr1	= XFRLEN1(OMAP_MCBSP_WORD_8) | XWDLEN1(OMAP_MCBSP_WORD_16),
-	.srgr1	= FWID(DEFAULT_BITPERSAMPLE - 1),
-	.srgr2	= GSYNC | CLKSP | FSGM | FPER(DEFAULT_BITPERSAMPLE * 2 - 1),
-	.pcr0	= CLKXP | CLKRP,	/* mcbsp: slave */
-};
-
-static struct omap_alsa_codec_config alsa_config = {
-	.name			= "PalmZ71 AIC23",
-	.mcbsp_regs_alsa	= &mcbsp_regs,
-	.codec_configure_dev	= NULL,	/* aic23_configure */
-	.codec_set_samplerate	= NULL,	/* aic23_set_samplerate */
-	.codec_clock_setup	= NULL,	/* aic23_clock_setup */
-	.codec_clock_on		= NULL,	/* aic23_clock_on */
-	.codec_clock_off	= NULL,	/* aic23_clock_off */
-	.get_default_samplerate	= NULL,	/* aic23_get_default_samplerate */
-};
-
-static struct platform_device palmz71_mcbsp1_device = {
-	.name	= "omap_alsa_mcbsp",
-	.id	= 1,
-	.dev = {
-		.platform_data = &alsa_config,
-	},
-};
-
 static struct omap_backlight_config palmz71_backlight_config = {
 	.default_intensity	= 0xa0,
 };
@@ -229,7 +193,6 @@ static struct platform_device palmz71_backlight_device = {
 static struct platform_device *devices[] __initdata = {
 	&palmz71_rom_device,
 	&palmz71_kp_device,
-	&palmz71_mcbsp1_device,
 	&palmz71_lcd_device,
 	&palmz71_irda_device,
 	&palmz71_spi_device,
diff --git a/arch/arm/mach-omap1/board-sx1.c b/arch/arm/mach-omap1/board-sx1.c
index 09a2422..28c76a1 100644
--- a/arch/arm/mach-omap1/board-sx1.c
+++ b/arch/arm/mach-omap1/board-sx1.c
@@ -34,13 +34,12 @@
 
 #include <mach/gpio.h>
 #include <mach/mux.h>
+#include <mach/dma.h>
 #include <mach/irda.h>
 #include <mach/usb.h>
 #include <mach/tc.h>
 #include <mach/board.h>
 #include <mach/common.h>
-#include <mach/mcbsp.h>
-#include <mach/omap-alsa.h>
 #include <mach/keypad.h>
 
 /* Write to I2C device */
@@ -254,35 +253,6 @@ static struct platform_device sx1_irda_device = {
 	.resource	= sx1_irda_resources,
 };
 
-/*----------- McBSP & Sound -------------------------*/
-
-/* Playback interface - McBSP1 */
-static struct omap_mcbsp_reg_cfg mcbsp1_regs = {
-	.spcr2	= XINTM(3),	/* SPCR2=30 */
-	.spcr1	= RINTM(3),	/* SPCR1=30 */
-	.rcr2	= 0,	/* RCR2 =00 */
-	.rcr1	= RFRLEN1(1) | RWDLEN1(OMAP_MCBSP_WORD_16),	/* RCR1=140 */
-	.xcr2	= 0,	/* XCR2 = 0 */
-	.xcr1	= XFRLEN1(1) | XWDLEN1(OMAP_MCBSP_WORD_16),	/* XCR1 = 140 */
-	.srgr1	= FWID(15) | CLKGDV(12),	/* SRGR1=0f0c */
-	.srgr2	= FSGM | FPER(31),	/* SRGR2=101f */
-	.pcr0	= FSXM | FSRM | CLKXM | CLKRM | FSXP | FSRP | CLKXP | CLKRP,
-						/* PCR0 =0f0f */
-};
-
-static struct omap_alsa_codec_config sx1_alsa_config = {
-	.name			= "SX1 EGold",
-	.mcbsp_regs_alsa	= &mcbsp1_regs,
-};
-
-static struct platform_device sx1_mcbsp1_device = {
-	.name	= "omap_alsa_mcbsp",
-	.id	= 1,
-	.dev = {
-		.platform_data	= &sx1_alsa_config,
-	},
-};
-
 /*----------- MTD -------------------------*/
 
 static struct mtd_partition sx1_partitions[] = {
@@ -394,7 +364,6 @@ static struct platform_device *sx1_devices[] __initdata = {
 	&sx1_flash_device,
 	&sx1_kp_device,
 	&sx1_lcd_device,
-	&sx1_mcbsp1_device,
 	&sx1_irda_device,
 };
 /*-----------------------------------------*/
diff --git a/arch/arm/plat-omap/include/mach/aic23.h b/arch/arm/plat-omap/include/mach/aic23.h
deleted file mode 100644
index 5ccedac..0000000
--- a/arch/arm/plat-omap/include/mach/aic23.h
+++ /dev/null
@@ -1,116 +0,0 @@
-/*
- * arch/arm/plat-omap/include/mach/aic23.h
- *
- * Hardware definitions for TI TLV320AIC23 audio codec
- *
- * Copyright (C) 2002 RidgeRun, Inc.
- * Author: Steve Johnson
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the
- * Free Software Foundation; either version 2 of the License, or (at your
- * option) any later version.
- *
- * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
- * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN
- * NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
- * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
- * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- * You should have received a copy of the  GNU General Public License along
- * with this program; if not, write  to the Free Software Foundation, Inc.,
- * 675 Mass Ave, Cambridge, MA 02139, USA.
- */
-
-#ifndef __ASM_ARCH_AIC23_H
-#define __ASM_ARCH_AIC23_H
-
-// Codec TLV320AIC23
-#define LEFT_LINE_VOLUME_ADDR		0x00
-#define RIGHT_LINE_VOLUME_ADDR		0x01
-#define LEFT_CHANNEL_VOLUME_ADDR	0x02
-#define RIGHT_CHANNEL_VOLUME_ADDR	0x03
-#define ANALOG_AUDIO_CONTROL_ADDR	0x04
-#define DIGITAL_AUDIO_CONTROL_ADDR	0x05
-#define POWER_DOWN_CONTROL_ADDR		0x06
-#define DIGITAL_AUDIO_FORMAT_ADDR	0x07
-#define SAMPLE_RATE_CONTROL_ADDR	0x08
-#define DIGITAL_INTERFACE_ACT_ADDR	0x09
-#define RESET_CONTROL_ADDR		0x0F
-
-// Left (right) line input volume control register
-#define LRS_ENABLED			0x0100
-#define LIM_MUTED			0x0080
-#define LIV_DEFAULT			0x0017
-#define LIV_MAX				0x001f
-#define LIV_MIN				0x0000
-
-// Left (right) channel headphone volume control register
-#define LZC_ON				0x0080
-#define LHV_DEFAULT			0x0079
-#define LHV_MAX				0x007f
-#define LHV_MIN				0x0000
-
-// Analog audio path control register
-#define STA_REG(x)			((x)<<6)
-#define STE_ENABLED			0x0020
-#define DAC_SELECTED			0x0010
-#define BYPASS_ON			0x0008
-#define INSEL_MIC			0x0004
-#define MICM_MUTED			0x0002
-#define MICB_20DB			0x0001
-
-// Digital audio path control register
-#define DACM_MUTE			0x0008
-#define DEEMP_32K			0x0002
-#define DEEMP_44K			0x0004
-#define DEEMP_48K			0x0006
-#define ADCHP_ON			0x0001
-
-// Power control down register
-#define DEVICE_POWER_OFF	  	0x0080
-#define CLK_OFF				0x0040
-#define OSC_OFF				0x0020
-#define OUT_OFF				0x0010
-#define DAC_OFF				0x0008
-#define ADC_OFF				0x0004
-#define MIC_OFF				0x0002
-#define LINE_OFF			0x0001
-
-// Digital audio interface register
-#define MS_MASTER			0x0040
-#define LRSWAP_ON			0x0020
-#define LRP_ON				0x0010
-#define IWL_16				0x0000
-#define IWL_20				0x0004
-#define IWL_24				0x0008
-#define IWL_32				0x000C
-#define FOR_I2S				0x0002
-#define FOR_DSP				0x0003
-
-// Sample rate control register
-#define CLKOUT_HALF			0x0080
-#define CLKIN_HALF			0x0040
-#define BOSR_384fs			0x0002 // BOSR_272fs when in USB mode
-#define USB_CLK_ON			0x0001
-#define SR_MASK                         0xf
-#define CLKOUT_SHIFT                    7
-#define CLKIN_SHIFT                     6
-#define SR_SHIFT                        2
-#define BOSR_SHIFT                      1
-
-// Digital interface register
-#define ACT_ON				0x0001
-
-#define TLV320AIC23ID1                  (0x1a)	// cs low
-#define TLV320AIC23ID2                  (0x1b)	// cs high
-
-void aic23_power_up(void);
-void aic23_power_down(void);
-
-#endif /* __ASM_ARCH_AIC23_H */

--AkbCVLjbJ9qUtAXD--
