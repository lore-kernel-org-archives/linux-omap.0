From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/9] OMAP: remove OMAP_TAG_UART, v2
Date: Mon, 24 Aug 2009 15:54:52 +0300
Message-ID: <20090824125451.GK7069@atomide.com>
References: <20090811094348.32577.81307.stgit@localhost> <20090811094756.32577.86259.stgit@localhost> <20090813091631.GM6132@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="J/dobhs11T7y2rNN"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:54221 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750748AbZHXMzN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Aug 2009 08:55:13 -0400
Content-Disposition: inline
In-Reply-To: <20090813091631.GM6132@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, Kalle Valo <kalle.valo@iki.fi>, linux-omap@vger.kernel.org


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Russell King - ARM Linux <linux@arm.linux.org.uk> [090813 12:16]:
> On Tue, Aug 11, 2009 at 12:47:56PM +0300, Tony Lindgren wrote:
> > From: Kalle Valo <kalle.valo@iki.fi>
> > 
> > Omap tags are deprecrated and convert all OMAP_TAG_UART cases to use
> > omap_uart_platform_data instead.
> 
> Ok.

Even better, we don't even need the platform_data for uarts as they
can be enabled as needed after Kevin's changes below.

Tony

--J/dobhs11T7y2rNN
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="remove-tag-uart-v2.patch"

>From e0996084329371976ffe17e65bfacc11562c4d51 Mon Sep 17 00:00:00 2001
From: Kalle Valo <kalle.valo@iki.fi>
Date: Mon, 24 Aug 2009 12:26:34 +0300
Subject: [PATCH] OMAP: UART: drop OMAP_TAG_UART, enable all UARTs, auto-disabled on idle

OMAP tags are deprecrated so drop them.

Drop UART config data which decides which UARTs to enable during boot.
This is no longer necessary since serial core code disables clocks
after inactivity.

Background: with new UART idle code, all on-chip UARTs are idled using
a configurable inactivity timer (default 5 seconds.)  After the
inactivity timer, UART clocks are disabled automatically.

Signed-off-by: Kalle Valo <kalle.valo@iki.fi>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index 8b40aac..5807732 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -162,10 +162,6 @@ static struct omap_lcd_config ams_delta_lcd_config __initdata = {
 	.ctrl_name	= "internal",
 };
 
-static struct omap_uart_config ams_delta_uart_config __initdata = {
-	.enabled_uarts = 1,
-};
-
 static struct omap_usb_config ams_delta_usb_config __initdata = {
 	.register_host	= 1,
 	.hmc_mode	= 16,
@@ -174,7 +170,6 @@ static struct omap_usb_config ams_delta_usb_config __initdata = {
 
 static struct omap_board_config_kernel ams_delta_config[] = {
 	{ OMAP_TAG_LCD,		&ams_delta_lcd_config },
-	{ OMAP_TAG_UART,	&ams_delta_uart_config },
 };
 
 static struct resource ams_delta_kp_resources[] = {
diff --git a/arch/arm/mach-omap1/board-fsample.c b/arch/arm/mach-omap1/board-fsample.c
index 19e0e92..a7ead1b 100644
--- a/arch/arm/mach-omap1/board-fsample.c
+++ b/arch/arm/mach-omap1/board-fsample.c
@@ -240,16 +240,11 @@ static int nand_dev_ready(struct omap_nand_platform_data *data)
 	return gpio_get_value(P2_NAND_RB_GPIO_PIN);
 }
 
-static struct omap_uart_config fsample_uart_config __initdata = {
-	.enabled_uarts = ((1 << 0) | (1 << 1)),
-};
-
 static struct omap_lcd_config fsample_lcd_config __initdata = {
 	.ctrl_name	= "internal",
 };
 
 static struct omap_board_config_kernel fsample_config[] = {
-	{ OMAP_TAG_UART,	&fsample_uart_config },
 	{ OMAP_TAG_LCD,		&fsample_lcd_config },
 };
 
diff --git a/arch/arm/mach-omap1/board-generic.c b/arch/arm/mach-omap1/board-generic.c
index e724940..fb47239 100644
--- a/arch/arm/mach-omap1/board-generic.c
+++ b/arch/arm/mach-omap1/board-generic.c
@@ -57,12 +57,7 @@ static struct omap_usb_config generic1610_usb_config __initdata = {
 };
 #endif
 
-static struct omap_uart_config generic_uart_config __initdata = {
-	.enabled_uarts = ((1 << 0) | (1 << 1) | (1 << 2)),
-};
-
 static struct omap_board_config_kernel generic_config[] __initdata = {
-	{ OMAP_TAG_UART,	&generic_uart_config },
 };
 
 static void __init omap_generic_init(void)
diff --git a/arch/arm/mach-omap1/board-h2.c b/arch/arm/mach-omap1/board-h2.c
index f695aa0..aab8603 100644
--- a/arch/arm/mach-omap1/board-h2.c
+++ b/arch/arm/mach-omap1/board-h2.c
@@ -360,16 +360,11 @@ static struct omap_usb_config h2_usb_config __initdata = {
 	.pins[1]	= 3,
 };
 
-static struct omap_uart_config h2_uart_config __initdata = {
-	.enabled_uarts = ((1 << 0) | (1 << 1) | (1 << 2)),
-};
-
 static struct omap_lcd_config h2_lcd_config __initdata = {
 	.ctrl_name	= "internal",
 };
 
 static struct omap_board_config_kernel h2_config[] __initdata = {
-	{ OMAP_TAG_UART,	&h2_uart_config },
 	{ OMAP_TAG_LCD,		&h2_lcd_config },
 };
 
diff --git a/arch/arm/mach-omap1/board-h3.c b/arch/arm/mach-omap1/board-h3.c
index f597968..89586b8 100644
--- a/arch/arm/mach-omap1/board-h3.c
+++ b/arch/arm/mach-omap1/board-h3.c
@@ -313,16 +313,11 @@ static struct omap_usb_config h3_usb_config __initdata = {
 	.pins[1]	= 3,
 };
 
-static struct omap_uart_config h3_uart_config __initdata = {
-	.enabled_uarts = ((1 << 0) | (1 << 1) | (1 << 2)),
-};
-
 static struct omap_lcd_config h3_lcd_config __initdata = {
 	.ctrl_name	= "internal",
 };
 
 static struct omap_board_config_kernel h3_config[] __initdata = {
-	{ OMAP_TAG_UART,	&h3_uart_config },
 	{ OMAP_TAG_LCD,		&h3_lcd_config },
 };
 
diff --git a/arch/arm/mach-omap1/board-innovator.c b/arch/arm/mach-omap1/board-innovator.c
index 2fd9826..cc2abbb 100644
--- a/arch/arm/mach-omap1/board-innovator.c
+++ b/arch/arm/mach-omap1/board-innovator.c
@@ -368,13 +368,8 @@ static inline void innovator_mmc_init(void)
 }
 #endif
 
-static struct omap_uart_config innovator_uart_config __initdata = {
-	.enabled_uarts = ((1 << 0) | (1 << 1) | (1 << 2)),
-};
-
 static struct omap_board_config_kernel innovator_config[] = {
 	{ OMAP_TAG_LCD,		NULL },
-	{ OMAP_TAG_UART,	&innovator_uart_config },
 };
 
 static void __init innovator_init(void)
diff --git a/arch/arm/mach-omap1/board-osk.c b/arch/arm/mach-omap1/board-osk.c
index cf3247b..ed891b8 100644
--- a/arch/arm/mach-omap1/board-osk.c
+++ b/arch/arm/mach-omap1/board-osk.c
@@ -293,10 +293,6 @@ static struct omap_usb_config osk_usb_config __initdata = {
 	.pins[0]	= 2,
 };
 
-static struct omap_uart_config osk_uart_config __initdata = {
-	.enabled_uarts = (1 << 0),
-};
-
 #ifdef	CONFIG_OMAP_OSK_MISTRAL
 static struct omap_lcd_config osk_lcd_config __initdata = {
 	.ctrl_name	= "internal",
@@ -304,7 +300,6 @@ static struct omap_lcd_config osk_lcd_config __initdata = {
 #endif
 
 static struct omap_board_config_kernel osk_config[] __initdata = {
-	{ OMAP_TAG_UART,		&osk_uart_config },
 #ifdef	CONFIG_OMAP_OSK_MISTRAL
 	{ OMAP_TAG_LCD,			&osk_lcd_config },
 #endif
diff --git a/arch/arm/mach-omap1/board-palmte.c b/arch/arm/mach-omap1/board-palmte.c
index 886b4c0..90dd043 100644
--- a/arch/arm/mach-omap1/board-palmte.c
+++ b/arch/arm/mach-omap1/board-palmte.c
@@ -212,10 +212,6 @@ static struct omap_lcd_config palmte_lcd_config __initdata = {
 	.ctrl_name	= "internal",
 };
 
-static struct omap_uart_config palmte_uart_config __initdata = {
-	.enabled_uarts = (1 << 0) | (1 << 1) | (0 << 2),
-};
-
 #ifdef CONFIG_APM
 /*
  * Values measured in 10 minute intervals averaged over 10 samples.
@@ -302,7 +298,6 @@ static void palmte_get_power_status(struct apm_power_info *info, int *battery)
 
 static struct omap_board_config_kernel palmte_config[] __initdata = {
 	{ OMAP_TAG_LCD,		&palmte_lcd_config },
-	{ OMAP_TAG_UART,	&palmte_uart_config },
 };
 
 static struct spi_board_info palmte_spi_info[] __initdata = {
diff --git a/arch/arm/mach-omap1/board-palmtt.c b/arch/arm/mach-omap1/board-palmtt.c
index 4f1b448..8256139 100644
--- a/arch/arm/mach-omap1/board-palmtt.c
+++ b/arch/arm/mach-omap1/board-palmtt.c
@@ -274,13 +274,8 @@ static struct omap_lcd_config palmtt_lcd_config __initdata = {
 	.ctrl_name	= "internal",
 };
 
-static struct omap_uart_config palmtt_uart_config __initdata = {
-	.enabled_uarts = (1 << 0) | (1 << 1) | (0 << 2),
-};
-
 static struct omap_board_config_kernel palmtt_config[] __initdata = {
 	{ OMAP_TAG_LCD,		&palmtt_lcd_config	},
-	{ OMAP_TAG_UART,	&palmtt_uart_config	},
 };
 
 static void __init omap_mpu_wdt_mode(int mode) {
diff --git a/arch/arm/mach-omap1/board-palmz71.c b/arch/arm/mach-omap1/board-palmz71.c
index 9a55c3c..81b6bde 100644
--- a/arch/arm/mach-omap1/board-palmz71.c
+++ b/arch/arm/mach-omap1/board-palmz71.c
@@ -244,13 +244,8 @@ static struct omap_lcd_config palmz71_lcd_config __initdata = {
 	.ctrl_name = "internal",
 };
 
-static struct omap_uart_config palmz71_uart_config __initdata = {
-	.enabled_uarts = (1 << 0) | (1 << 1) | (0 << 2),
-};
-
 static struct omap_board_config_kernel palmz71_config[] __initdata = {
 	{OMAP_TAG_LCD,	&palmz71_lcd_config},
-	{OMAP_TAG_UART,	&palmz71_uart_config},
 };
 
 static irqreturn_t
diff --git a/arch/arm/mach-omap1/board-perseus2.c b/arch/arm/mach-omap1/board-perseus2.c
index 3b9f907..8340669 100644
--- a/arch/arm/mach-omap1/board-perseus2.c
+++ b/arch/arm/mach-omap1/board-perseus2.c
@@ -208,16 +208,11 @@ static int nand_dev_ready(struct omap_nand_platform_data *data)
 	return gpio_get_value(P2_NAND_RB_GPIO_PIN);
 }
 
-static struct omap_uart_config perseus2_uart_config __initdata = {
-	.enabled_uarts = ((1 << 0) | (1 << 1)),
-};
-
 static struct omap_lcd_config perseus2_lcd_config __initdata = {
 	.ctrl_name	= "internal",
 };
 
 static struct omap_board_config_kernel perseus2_config[] __initdata = {
-	{ OMAP_TAG_UART,	&perseus2_uart_config },
 	{ OMAP_TAG_LCD,		&perseus2_lcd_config },
 };
 
diff --git a/arch/arm/mach-omap1/board-sx1.c b/arch/arm/mach-omap1/board-sx1.c
index c096577..02c85ca 100644
--- a/arch/arm/mach-omap1/board-sx1.c
+++ b/arch/arm/mach-omap1/board-sx1.c
@@ -369,13 +369,8 @@ static struct platform_device *sx1_devices[] __initdata = {
 };
 /*-----------------------------------------*/
 
-static struct omap_uart_config sx1_uart_config __initdata = {
-	.enabled_uarts = ((1 << 0) | (1 << 1) | (1 << 2)),
-};
-
 static struct omap_board_config_kernel sx1_config[] __initdata = {
 	{ OMAP_TAG_LCD,	&sx1_lcd_config },
-	{ OMAP_TAG_UART,	&sx1_uart_config },
 };
 
 /*-----------------------------------------*/
diff --git a/arch/arm/mach-omap1/board-voiceblue.c b/arch/arm/mach-omap1/board-voiceblue.c
index 98275e0..c06e7a5 100644
--- a/arch/arm/mach-omap1/board-voiceblue.c
+++ b/arch/arm/mach-omap1/board-voiceblue.c
@@ -140,12 +140,7 @@ static struct omap_usb_config voiceblue_usb_config __initdata = {
 	.pins[2]	= 6,
 };
 
-static struct omap_uart_config voiceblue_uart_config __initdata = {
-	.enabled_uarts = ((1 << 0) | (1 << 1) | (1 << 2)),
-};
-
 static struct omap_board_config_kernel voiceblue_config[] = {
-	{ OMAP_TAG_UART, &voiceblue_uart_config },
 };
 
 static void __init voiceblue_init_irq(void)
diff --git a/arch/arm/mach-omap1/serial.c b/arch/arm/mach-omap1/serial.c
index 6f54b2c..d496e50 100644
--- a/arch/arm/mach-omap1/serial.c
+++ b/arch/arm/mach-omap1/serial.c
@@ -109,7 +109,6 @@ static struct platform_device serial_device = {
 void __init omap_serial_init(void)
 {
 	int i;
-	const struct omap_uart_config *info;
 
 	if (cpu_is_omap730()) {
 		serial_platform_data[0].regshift = 0;
@@ -131,19 +130,9 @@ void __init omap_serial_init(void)
 		serial_platform_data[2].uartclk = OMAP1510_BASE_BAUD * 16;
 	}
 
-	info = omap_get_config(OMAP_TAG_UART, struct omap_uart_config);
-	if (info == NULL)
-		return;
-
 	for (i = 0; i < OMAP_MAX_NR_PORTS; i++) {
 		unsigned char reg;
 
-		if (!((1 << i) & info->enabled_uarts)) {
-			serial_platform_data[i].membase = NULL;
-			serial_platform_data[i].mapbase = 0;
-			continue;
-		}
-
 		switch (i) {
 		case 0:
 			uart1_ck = clk_get(NULL, "uart1_ck");
diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index 8ec2a13..7f5a74d 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -146,12 +146,7 @@ static void __init omap_2430sdp_init_irq(void)
 	omap_gpio_init();
 }
 
-static struct omap_uart_config sdp2430_uart_config __initdata = {
-	.enabled_uarts = ((1 << 0) | (1 << 1) | (1 << 2)),
-};
-
 static struct omap_board_config_kernel sdp2430_config[] = {
-	{OMAP_TAG_UART, &sdp2430_uart_config},
 	{OMAP_TAG_LCD, &sdp2430_lcd_config},
 };
 
diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index ac262cd..7e9b76c 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -174,16 +174,11 @@ static void __init omap_3430sdp_init_irq(void)
 	omap_gpio_init();
 }
 
-static struct omap_uart_config sdp3430_uart_config __initdata = {
-	.enabled_uarts	= ((1 << 0) | (1 << 1) | (1 << 2)),
-};
-
 static struct omap_lcd_config sdp3430_lcd_config __initdata = {
 	.ctrl_name	= "internal",
 };
 
 static struct omap_board_config_kernel sdp3430_config[] __initdata = {
-	{ OMAP_TAG_UART,	&sdp3430_uart_config },
 	{ OMAP_TAG_LCD,		&sdp3430_lcd_config },
 };
 
diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index bdfda36..f22f429 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -47,7 +47,6 @@ static struct omap_lcd_config sdp4430_lcd_config __initdata = {
 };
 
 static struct omap_board_config_kernel sdp4430_config[] __initdata = {
-	{ OMAP_TAG_UART,	&sdp4430_uart_config },
 	{ OMAP_TAG_LCD,		&sdp4430_lcd_config },
 };
 
diff --git a/arch/arm/mach-omap2/board-apollon.c b/arch/arm/mach-omap2/board-apollon.c
index dcfc20d..615f21d 100644
--- a/arch/arm/mach-omap2/board-apollon.c
+++ b/arch/arm/mach-omap2/board-apollon.c
@@ -256,10 +256,6 @@ static void __init omap_apollon_init_irq(void)
 	apollon_init_smc91x();
 }
 
-static struct omap_uart_config apollon_uart_config __initdata = {
-	.enabled_uarts = (1 << 0) | (0 << 1) | (0 << 2),
-};
-
 static struct omap_usb_config apollon_usb_config __initdata = {
 	.register_dev	= 1,
 	.hmc_mode	= 0x14,	/* 0:dev 1:host1 2:disable */
@@ -272,7 +268,6 @@ static struct omap_lcd_config apollon_lcd_config __initdata = {
 };
 
 static struct omap_board_config_kernel apollon_config[] = {
-	{ OMAP_TAG_UART,	&apollon_uart_config },
 	{ OMAP_TAG_LCD,		&apollon_lcd_config },
 };
 
diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index fd00aa0..3e401c5 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -37,12 +37,7 @@ static void __init omap_generic_init_irq(void)
 	omap_init_irq();
 }
 
-static struct omap_uart_config generic_uart_config __initdata = {
-	.enabled_uarts = ((1 << 0) | (1 << 1) | (1 << 2)),
-};
-
 static struct omap_board_config_kernel generic_config[] = {
-	{ OMAP_TAG_UART,	&generic_uart_config },
 };
 
 static void __init omap_generic_init(void)
diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
index 7b1d61d..b6501d2 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -276,10 +276,6 @@ static void __init omap_h4_init_irq(void)
 	h4_init_flash();
 }
 
-static struct omap_uart_config h4_uart_config __initdata = {
-	.enabled_uarts = ((1 << 0) | (1 << 1) | (1 << 2)),
-};
-
 static struct omap_lcd_config h4_lcd_config __initdata = {
 	.ctrl_name	= "internal",
 };
@@ -318,7 +314,6 @@ static struct omap_usb_config h4_usb_config __initdata = {
 };
 
 static struct omap_board_config_kernel h4_config[] = {
-	{ OMAP_TAG_UART,	&h4_uart_config },
 	{ OMAP_TAG_LCD,		&h4_lcd_config },
 };
 
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index ea383f8..2dd6806 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -276,10 +276,6 @@ static void __init omap_ldp_init_irq(void)
 	ldp_init_smsc911x();
 }
 
-static struct omap_uart_config ldp_uart_config __initdata = {
-	.enabled_uarts	= ((1 << 0) | (1 << 1) | (1 << 2)),
-};
-
 static struct platform_device ldp_lcd_device = {
 	.name		= "ldp_lcd",
 	.id		= -1,
@@ -290,7 +286,6 @@ static struct omap_lcd_config ldp_lcd_config __initdata = {
 };
 
 static struct omap_board_config_kernel ldp_config[] __initdata = {
-	{ OMAP_TAG_UART,	&ldp_uart_config },
 	{ OMAP_TAG_LCD,		&ldp_lcd_config },
 };
 
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index e00ba12..2013607 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -108,10 +108,6 @@ static struct platform_device omap3beagle_nand_device = {
 
 #include "sdram-micron-mt46h32m32lf-6.h"
 
-static struct omap_uart_config omap3_beagle_uart_config __initdata = {
-	.enabled_uarts	= ((1 << 0) | (1 << 1) | (1 << 2)),
-};
-
 static struct twl4030_hsmmc_info mmc[] = {
 	{
 		.mmc		= 1,
@@ -345,7 +341,6 @@ static struct platform_device keys_gpio = {
 };
 
 static struct omap_board_config_kernel omap3_beagle_config[] __initdata = {
-	{ OMAP_TAG_UART,	&omap3_beagle_uart_config },
 	{ OMAP_TAG_LCD,		&omap3_beagle_lcd_config },
 };
 
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index c4b1446..3e04353 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -92,10 +92,6 @@ static inline void __init omap3evm_init_smc911x(void)
 	gpio_direction_input(OMAP3EVM_ETHR_GPIO_IRQ);
 }
 
-static struct omap_uart_config omap3_evm_uart_config __initdata = {
-	.enabled_uarts	= ((1 << 0) | (1 << 1) | (1 << 2)),
-};
-
 static struct twl4030_hsmmc_info mmc[] = {
 	{
 		.mmc		= 1,
@@ -287,7 +283,6 @@ static void __init omap3_evm_init_irq(void)
 }
 
 static struct omap_board_config_kernel omap3_evm_config[] __initdata = {
-	{ OMAP_TAG_UART,	&omap3_evm_uart_config },
 	{ OMAP_TAG_LCD,		&omap3_evm_lcd_config },
 };
 
diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index 864ee3d..8236708 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -213,10 +213,6 @@ static struct twl4030_hsmmc_info omap3pandora_mmc[] = {
 	{}	/* Terminator */
 };
 
-static struct omap_uart_config omap3pandora_uart_config __initdata = {
-	.enabled_uarts	= (1 << 2), /* UART3 */
-};
-
 static struct regulator_consumer_supply pandora_vmmc1_supply = {
 	.supply			= "vmmc",
 };
@@ -376,7 +372,6 @@ static struct omap_lcd_config omap3pandora_lcd_config __initdata = {
 };
 
 static struct omap_board_config_kernel omap3pandora_config[] __initdata = {
-	{ OMAP_TAG_UART,	&omap3pandora_uart_config },
 	{ OMAP_TAG_LCD,		&omap3pandora_lcd_config },
 };
 
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index 6bce230..eb78e6e 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -271,9 +271,6 @@ static void __init overo_flash_init(void)
 			printk(KERN_ERR "Unable to register NAND device\n");
 	}
 }
-static struct omap_uart_config overo_uart_config __initdata = {
-	.enabled_uarts	= ((1 << 0) | (1 << 1) | (1 << 2)),
-};
 
 static struct twl4030_hsmmc_info mmc[] = {
 	{
@@ -378,7 +375,6 @@ static struct omap_lcd_config overo_lcd_config __initdata = {
 };
 
 static struct omap_board_config_kernel overo_config[] __initdata = {
-	{ OMAP_TAG_UART,	&overo_uart_config },
 	{ OMAP_TAG_LCD,		&overo_lcd_config },
 };
 
diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/board-rx51.c
index 1c9e07f..c0d1340 100644
--- a/arch/arm/mach-omap2/board-rx51.c
+++ b/arch/arm/mach-omap2/board-rx51.c
@@ -31,10 +31,6 @@
 #include <mach/gpmc.h>
 #include <mach/usb.h>
 
-static struct omap_uart_config rx51_uart_config = {
-	.enabled_uarts	= ((1 << 0) | (1 << 1) | (1 << 2)),
-};
-
 static struct omap_lcd_config rx51_lcd_config = {
 	.ctrl_name	= "internal",
 };
@@ -52,7 +48,6 @@ static struct omap_fbmem_config rx51_fbmem2_config = {
 };
 
 static struct omap_board_config_kernel rx51_config[] = {
-	{ OMAP_TAG_UART,	&rx51_uart_config },
 	{ OMAP_TAG_FBMEM,	&rx51_fbmem0_config },
 	{ OMAP_TAG_FBMEM,	&rx51_fbmem1_config },
 	{ OMAP_TAG_FBMEM,	&rx51_fbmem2_config },
diff --git a/arch/arm/mach-omap2/board-zoom2.c b/arch/arm/mach-omap2/board-zoom2.c
index 427b7b8..3a42eca 100644
--- a/arch/arm/mach-omap2/board-zoom2.c
+++ b/arch/arm/mach-omap2/board-zoom2.c
@@ -30,12 +30,7 @@ static void __init omap_zoom2_init_irq(void)
 	omap_gpio_init();
 }
 
-static struct omap_uart_config zoom2_uart_config __initdata = {
-	.enabled_uarts	= ((1 << 0) | (1 << 1) | (1 << 2)),
-};
-
 static struct omap_board_config_kernel zoom2_config[] __initdata = {
-	{ OMAP_TAG_UART,	&zoom2_uart_config },
 };
 
 static struct twl4030_gpio_platform_data zoom2_gpio_data = {
diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 4244900..409b033 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -555,7 +555,6 @@ static struct omap_uart_state omap_uart[OMAP_MAX_NR_PORTS] = {
 void __init omap_serial_init(void)
 {
 	int i;
-	const struct omap_uart_config *info;
 	char name[16];
 
 	/*
@@ -564,23 +563,12 @@ void __init omap_serial_init(void)
 	 * if not needed.
 	 */
 
-	info = omap_get_config(OMAP_TAG_UART, struct omap_uart_config);
-
-	if (info == NULL)
-		return;
-
 	for (i = 0; i < OMAP_MAX_NR_PORTS; i++) {
 		struct omap_uart_state *uart = &omap_uart[i];
 		struct platform_device *pdev = &uart->pdev;
 		struct device *dev = &pdev->dev;
 		struct plat_serial8250_port *p = dev->platform_data;
 
-		if (!(info->enabled_uarts & (1 << i))) {
-			p->membase = NULL;
-			p->mapbase = 0;
-			continue;
-		}
-
 		sprintf(name, "uart%d_ick", i+1);
 		uart->ick = clk_get(NULL, name);
 		if (IS_ERR(uart->ick)) {
diff --git a/arch/arm/plat-omap/include/mach/board.h b/arch/arm/plat-omap/include/mach/board.h
index 0d12586..8e913c3 100644
--- a/arch/arm/plat-omap/include/mach/board.h
+++ b/arch/arm/plat-omap/include/mach/board.h
@@ -18,7 +18,6 @@
 #define OMAP_TAG_CLOCK		0x4f01
 #define OMAP_TAG_LCD		0x4f05
 #define OMAP_TAG_GPIO_SWITCH	0x4f06
-#define OMAP_TAG_UART		0x4f07
 #define OMAP_TAG_FBMEM		0x4f08
 #define OMAP_TAG_STI_CONSOLE	0x4f09
 #define OMAP_TAG_CAMERA_SENSOR	0x4f0a

--J/dobhs11T7y2rNN--
