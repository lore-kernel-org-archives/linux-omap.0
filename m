From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/3] ARM: OMAP: Introduce SoC specific early_init
Date: Wed, 24 Aug 2011 06:35:29 -0700
Message-ID: <20110824133528.GC2963@atomide.com>
References: <20110824115048.2985.24230.stgit@kaulin>
 <20110824115436.2985.14338.stgit@kaulin>
 <4E54F300.308@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:62019 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751087Ab1HXNfg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Aug 2011 09:35:36 -0400
Content-Disposition: inline
In-Reply-To: <4E54F300.308@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Igor Grinberg <grinberg@compulab.co.il> [110824 05:15]:
> 
> On 08/24/11 14:54, Tony Lindgren wrote:
> > @@ -637,7 +632,7 @@ MACHINE_START(CM_T35, "Compulab CM-T35")
> >  	.boot_params	= 0x80000100,
> >  	.reserve	= omap_reserve,
> >  	.map_io		= omap3_map_io,
> > -	.init_early	= cm_t35_init_early,
> > +	.init_early	= omap35xx_init_early,
> >  	.init_irq	= omap3_init_irq,
> >  	.init_machine	= cm_t35_init,
> >  	.timer		= &omap3_timer,
> > @@ -647,7 +642,7 @@ MACHINE_START(CM_T3730, "Compulab CM-T3730")
> >  	.boot_params    = 0x80000100,
> >  	.reserve        = omap_reserve,
> >  	.map_io         = omap3_map_io,
> > -	.init_early     = cm_t35_init_early,
> > +	.init_early     = am35xx_init_early,
> 
> Although this does not meter with the current implementation,
> but for the sake of completeness, this should be omap3630_init_early.

Updated patch below, can you please check?

Regards,

Tony


From: Tony Lindgren <tony@atomide.com>
Date: Mon, 22 Aug 2011 23:57:24 -0700
Subject: [PATCH] ARM: OMAP: Introduce SoC specific early_init

Introduce them for each omap variant and just make them all call
omap2_init_common_infrastructure for now. Do this for each board-*.c
file except for board-generic and board-omap3beagle as they use
the same machine ID for multiple SoCs.

No functional changes.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index a4f43ee..618216c 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -141,11 +141,6 @@ static struct omap_board_config_kernel sdp2430_config[] __initdata = {
 	{OMAP_TAG_LCD, &sdp2430_lcd_config},
 };
 
-static void __init omap_2430sdp_init_early(void)
-{
-	omap2_init_common_infrastructure();
-}
-
 static struct regulator_consumer_supply sdp2430_vmmc1_supplies[] = {
 	REGULATOR_SUPPLY("vmmc", "omap_hsmmc.0"),
 };
@@ -259,7 +254,7 @@ MACHINE_START(OMAP_2430SDP, "OMAP2430 sdp2430 board")
 	.boot_params	= 0x80000100,
 	.reserve	= omap_reserve,
 	.map_io		= omap_2430sdp_map_io,
-	.init_early	= omap_2430sdp_init_early,
+	.init_early	= omap2430_init_early,
 	.init_irq	= omap2_init_irq,
 	.init_machine	= omap_2430sdp_init,
 	.timer		= &omap2_timer,
diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index cc8e148..9bb48ea 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -225,11 +225,6 @@ static struct omap_dss_board_info sdp3430_dss_data = {
 static struct omap_board_config_kernel sdp3430_config[] __initdata = {
 };
 
-static void __init omap_3430sdp_init_early(void)
-{
-	omap2_init_common_infrastructure();
-}
-
 static struct omap2_hsmmc_info mmc[] = {
 	{
 		.mmc		= 1,
@@ -732,7 +727,7 @@ MACHINE_START(OMAP_3430SDP, "OMAP3430 3430SDP board")
 	.boot_params	= 0x80000100,
 	.reserve	= omap_reserve,
 	.map_io		= omap3_map_io,
-	.init_early	= omap_3430sdp_init_early,
+	.init_early	= omap3430_init_early,
 	.init_irq	= omap3_init_irq,
 	.init_machine	= omap_3430sdp_init,
 	.timer		= &omap3_timer,
diff --git a/arch/arm/mach-omap2/board-3630sdp.c b/arch/arm/mach-omap2/board-3630sdp.c
index 96766e9..94febc8 100644
--- a/arch/arm/mach-omap2/board-3630sdp.c
+++ b/arch/arm/mach-omap2/board-3630sdp.c
@@ -70,11 +70,6 @@ static const struct usbhs_omap_board_data usbhs_bdata __initconst = {
 static struct omap_board_config_kernel sdp_config[] __initdata = {
 };
 
-static void __init omap_sdp_init_early(void)
-{
-	omap2_init_common_infrastructure();
-}
-
 #ifdef CONFIG_OMAP_MUX
 static struct omap_board_mux board_mux[] __initdata = {
 	{ .reg_offset = OMAP_MUX_TERMINATOR },
@@ -218,7 +213,7 @@ MACHINE_START(OMAP_3630SDP, "OMAP 3630SDP board")
 	.boot_params	= 0x80000100,
 	.reserve	= omap_reserve,
 	.map_io		= omap3_map_io,
-	.init_early	= omap_sdp_init_early,
+	.init_early	= omap3630_init_early,
 	.init_irq	= omap3_init_irq,
 	.init_machine	= omap_sdp_init,
 	.timer		= &omap3_timer,
diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index bbe3735..ab19d30 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -389,11 +389,6 @@ static struct omap_board_config_kernel sdp4430_config[] __initdata = {
 	{ OMAP_TAG_LCD,		&sdp4430_lcd_config },
 };
 
-static void __init omap_4430sdp_init_early(void)
-{
-	omap2_init_common_infrastructure();
-}
-
 static struct omap_musb_board_data musb_board_data = {
 	.interface_type		= MUSB_INTERFACE_UTMI,
 	.mode			= MUSB_OTG,
@@ -841,7 +836,7 @@ MACHINE_START(OMAP_4430SDP, "OMAP4430 4430SDP board")
 	.boot_params	= 0x80000100,
 	.reserve	= omap_reserve,
 	.map_io		= omap_4430sdp_map_io,
-	.init_early	= omap_4430sdp_init_early,
+	.init_early	= omap4430_init_early,
 	.init_irq	= gic_init_irq,
 	.init_machine	= omap_4430sdp_init,
 	.timer		= &omap4_timer,
diff --git a/arch/arm/mach-omap2/board-am3517crane.c b/arch/arm/mach-omap2/board-am3517crane.c
index 4701e8c..9e1b2c2 100644
--- a/arch/arm/mach-omap2/board-am3517crane.c
+++ b/arch/arm/mach-omap2/board-am3517crane.c
@@ -47,11 +47,6 @@ static struct omap_board_mux board_mux[] __initdata = {
 };
 #endif
 
-static void __init am3517_crane_init_early(void)
-{
-	omap2_init_common_infrastructure();
-}
-
 static struct usbhs_omap_board_data usbhs_bdata __initdata = {
 	.port_mode[0] = OMAP_EHCI_PORT_MODE_PHY,
 	.port_mode[1] = OMAP_USBHS_PORT_MODE_UNUSED,
@@ -101,7 +96,7 @@ MACHINE_START(CRANEBOARD, "AM3517/05 CRANEBOARD")
 	.boot_params	= 0x80000100,
 	.reserve	= omap_reserve,
 	.map_io		= omap3_map_io,
-	.init_early	= am3517_crane_init_early,
+	.init_early	= am35xx_init_early,
 	.init_irq	= omap3_init_irq,
 	.init_machine	= am3517_crane_init,
 	.timer		= &omap3_timer,
diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index b5391a1..7d84294 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -362,10 +362,6 @@ static struct omap_dss_board_info am3517_evm_dss_data = {
 /*
  * Board initialization
  */
-static void __init am3517_evm_init_early(void)
-{
-	omap2_init_common_infrastructure();
-}
 
 static struct omap_musb_board_data musb_board_data = {
 	.interface_type         = MUSB_INTERFACE_ULPI,
@@ -493,7 +489,7 @@ MACHINE_START(OMAP3517EVM, "OMAP3517/AM3517 EVM")
 	.boot_params	= 0x80000100,
 	.reserve	= omap_reserve,
 	.map_io		= omap3_map_io,
-	.init_early	= am3517_evm_init_early,
+	.init_early	= am35xx_init_early,
 	.init_irq	= omap3_init_irq,
 	.init_machine	= am3517_evm_init,
 	.timer		= &omap3_timer,
diff --git a/arch/arm/mach-omap2/board-apollon.c b/arch/arm/mach-omap2/board-apollon.c
index 6d88ffa..cf546f8 100644
--- a/arch/arm/mach-omap2/board-apollon.c
+++ b/arch/arm/mach-omap2/board-apollon.c
@@ -273,11 +273,6 @@ static struct omap_board_config_kernel apollon_config[] __initdata = {
 	{ OMAP_TAG_LCD,		&apollon_lcd_config },
 };
 
-static void __init omap_apollon_init_early(void)
-{
-	omap2_init_common_infrastructure();
-}
-
 static struct gpio apollon_gpio_leds[] __initdata = {
 	{ LED0_GPIO13, GPIOF_OUT_INIT_LOW, "LED0" }, /* LED0 - AA10 */
 	{ LED1_GPIO14, GPIOF_OUT_INIT_LOW, "LED1" }, /* LED1 - AA6  */
@@ -353,7 +348,7 @@ MACHINE_START(OMAP_APOLLON, "OMAP24xx Apollon")
 	.boot_params	= 0x80000100,
 	.reserve	= omap_reserve,
 	.map_io		= omap_apollon_map_io,
-	.init_early	= omap_apollon_init_early,
+	.init_early	= omap2420_init_early,
 	.init_irq	= omap2_init_irq,
 	.init_machine	= omap_apollon_init,
 	.timer		= &omap2_timer,
diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index 0f25496..e15d39b 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -471,11 +471,6 @@ static void __init cm_t35_init_i2c(void)
 	omap3_pmic_init("tps65930", &cm_t35_twldata);
 }
 
-static void __init cm_t35_init_early(void)
-{
-	omap2_init_common_infrastructure();
-}
-
 #ifdef CONFIG_OMAP_MUX
 static struct omap_board_mux board_mux[] __initdata = {
 	/* nCS and IRQ for CM-T35 ethernet */
@@ -637,7 +632,7 @@ MACHINE_START(CM_T35, "Compulab CM-T35")
 	.boot_params	= 0x80000100,
 	.reserve	= omap_reserve,
 	.map_io		= omap3_map_io,
-	.init_early	= cm_t35_init_early,
+	.init_early	= omap35xx_init_early,
 	.init_irq	= omap3_init_irq,
 	.init_machine	= cm_t35_init,
 	.timer		= &omap3_timer,
@@ -647,7 +642,7 @@ MACHINE_START(CM_T3730, "Compulab CM-T3730")
 	.boot_params    = 0x80000100,
 	.reserve        = omap_reserve,
 	.map_io         = omap3_map_io,
-	.init_early     = cm_t35_init_early,
+	.init_early     = omap3630_init_early,
 	.init_irq       = omap3_init_irq,
 	.init_machine   = cm_t3730_init,
 	.timer          = &omap3_timer,
diff --git a/arch/arm/mach-omap2/board-cm-t3517.c b/arch/arm/mach-omap2/board-cm-t3517.c
index 88e1f74..867bf67 100644
--- a/arch/arm/mach-omap2/board-cm-t3517.c
+++ b/arch/arm/mach-omap2/board-cm-t3517.c
@@ -251,11 +251,6 @@ static inline void cm_t3517_init_nand(void) {}
 static struct omap_board_config_kernel cm_t3517_config[] __initdata = {
 };
 
-static void __init cm_t3517_init_early(void)
-{
-	omap2_init_common_infrastructure();
-}
-
 #ifdef CONFIG_OMAP_MUX
 static struct omap_board_mux board_mux[] __initdata = {
 	/* GPIO186 - Green LED */
@@ -302,7 +297,7 @@ MACHINE_START(CM_T3517, "Compulab CM-T3517")
 	.boot_params	= 0x80000100,
 	.reserve        = omap_reserve,
 	.map_io		= omap3_map_io,
-	.init_early	= cm_t3517_init_early,
+	.init_early	= am35xx_init_early,
 	.init_irq	= omap3_init_irq,
 	.init_machine	= cm_t3517_init,
 	.timer		= &omap3_timer,
diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 631dc58..4b1f6c6 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -397,12 +397,6 @@ static struct platform_device keys_gpio = {
 	},
 };
 
-
-static void __init devkit8000_init_early(void)
-{
-	omap2_init_common_infrastructure();
-}
-
 static void __init devkit8000_init_irq(void)
 {
 	omap3_init_irq();
@@ -670,7 +664,7 @@ MACHINE_START(DEVKIT8000, "OMAP3 Devkit8000")
 	.boot_params	= 0x80000100,
 	.reserve	= omap_reserve,
 	.map_io		= omap3_map_io,
-	.init_early	= devkit8000_init_early,
+	.init_early	= omap35xx_init_early,
 	.init_irq	= devkit8000_init_irq,
 	.init_machine	= devkit8000_init,
 	.timer		= &omap3_secure_timer,
diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
index 84ca5c0..948fde0 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -290,11 +290,6 @@ static struct omap_board_config_kernel h4_config[] __initdata = {
 	{ OMAP_TAG_LCD,		&h4_lcd_config },
 };
 
-static void __init omap_h4_init_early(void)
-{
-	omap2_init_common_infrastructure();
-}
-
 static void __init omap_h4_init_irq(void)
 {
 	omap2_init_irq();
@@ -385,7 +380,7 @@ MACHINE_START(OMAP_H4, "OMAP2420 H4 board")
 	.boot_params	= 0x80000100,
 	.reserve	= omap_reserve,
 	.map_io		= omap_h4_map_io,
-	.init_early	= omap_h4_init_early,
+	.init_early	= omap2420_init_early,
 	.init_irq	= omap_h4_init_irq,
 	.init_machine	= omap_h4_init,
 	.timer		= &omap2_timer,
diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index 1b2309f..7b66338 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -491,11 +491,6 @@ static struct platform_device *igep_devices[] __initdata = {
 	&igep_vwlan_device,
 };
 
-static void __init igep_init_early(void)
-{
-	omap2_init_common_infrastructure();
-}
-
 static int igep2_keymap[] = {
 	KEY(0, 0, KEY_LEFT),
 	KEY(0, 1, KEY_RIGHT),
@@ -675,7 +670,7 @@ MACHINE_START(IGEP0020, "IGEP v2 board")
 	.boot_params	= 0x80000100,
 	.reserve	= omap_reserve,
 	.map_io		= omap3_map_io,
-	.init_early	= igep_init_early,
+	.init_early	= omap35xx_init_early,
 	.init_irq	= omap3_init_irq,
 	.init_machine	= igep_init,
 	.timer		= &omap3_timer,
@@ -685,7 +680,7 @@ MACHINE_START(IGEP0030, "IGEP OMAP3 module")
 	.boot_params	= 0x80000100,
 	.reserve	= omap_reserve,
 	.map_io		= omap3_map_io,
-	.init_early	= igep_init_early,
+	.init_early	= omap35xx_init_early,
 	.init_irq	= omap3_init_irq,
 	.init_machine	= igep_init,
 	.timer		= &omap3_timer,
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index c45a0f4..401b944 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -193,11 +193,6 @@ static struct omap_board_config_kernel ldp_config[] __initdata = {
 	{ OMAP_TAG_LCD,		&ldp_lcd_config },
 };
 
-static void __init omap_ldp_init_early(void)
-{
-	omap2_init_common_infrastructure();
-}
-
 static struct twl4030_gpio_platform_data ldp_gpio_data = {
 	.gpio_base	= OMAP_MAX_GPIO_LINES,
 	.irq_base	= TWL4030_GPIO_IRQ_BASE,
@@ -336,7 +331,7 @@ MACHINE_START(OMAP_LDP, "OMAP LDP board")
 	.boot_params	= 0x80000100,
 	.reserve	= omap_reserve,
 	.map_io		= omap3_map_io,
-	.init_early	= omap_ldp_init_early,
+	.init_early	= omap3430_init_early,
 	.init_irq	= omap3_init_irq,
 	.init_machine	= omap_ldp_init,
 	.timer		= &omap3_timer,
diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
index 2545a4a..77a4e19 100644
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -622,11 +622,6 @@ static void __init n8x0_map_io(void)
 	omap242x_map_common_io();
 }
 
-static void __init n8x0_init_early(void)
-{
-	omap2_init_common_infrastructure();
-}
-
 #ifdef CONFIG_OMAP_MUX
 static struct omap_board_mux board_mux[] __initdata = {
 	/* I2S codec port pins for McBSP block */
@@ -698,7 +693,7 @@ MACHINE_START(NOKIA_N800, "Nokia N800")
 	.boot_params	= 0x80000100,
 	.reserve	= omap_reserve,
 	.map_io		= n8x0_map_io,
-	.init_early	= n8x0_init_early,
+	.init_early	= omap2420_init_early,
 	.init_irq	= omap2_init_irq,
 	.init_machine	= n8x0_init_machine,
 	.timer		= &omap2_timer,
@@ -708,7 +703,7 @@ MACHINE_START(NOKIA_N810, "Nokia N810")
 	.boot_params	= 0x80000100,
 	.reserve	= omap_reserve,
 	.map_io		= n8x0_map_io,
-	.init_early	= n8x0_init_early,
+	.init_early	= omap2420_init_early,
 	.init_irq	= omap2_init_irq,
 	.init_machine	= n8x0_init_machine,
 	.timer		= &omap2_timer,
@@ -718,7 +713,7 @@ MACHINE_START(NOKIA_N810_WIMAX, "Nokia N810 WiMAX")
 	.boot_params	= 0x80000100,
 	.reserve	= omap_reserve,
 	.map_io		= n8x0_map_io,
-	.init_early	= n8x0_init_early,
+	.init_early	= omap2420_init_early,
 	.init_irq	= omap2_init_irq,
 	.init_machine	= n8x0_init_machine,
 	.timer		= &omap2_timer,
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 0735bca..a1184b3 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -520,11 +520,6 @@ static int __init omap3_evm_i2c_init(void)
 static struct omap_board_config_kernel omap3_evm_config[] __initdata = {
 };
 
-static void __init omap3_evm_init_early(void)
-{
-	omap2_init_common_infrastructure();
-}
-
 static struct usbhs_omap_board_data usbhs_bdata __initdata = {
 
 	.port_mode[0] = OMAP_USBHS_PORT_MODE_UNUSED,
@@ -684,7 +679,7 @@ MACHINE_START(OMAP3EVM, "OMAP3 EVM")
 	.boot_params	= 0x80000100,
 	.reserve	= omap_reserve,
 	.map_io		= omap3_map_io,
-	.init_early	= omap3_evm_init_early,
+	.init_early	= omap35xx_init_early,
 	.init_irq	= omap3_init_irq,
 	.init_machine	= omap3_evm_init,
 	.timer		= &omap3_timer,
diff --git a/arch/arm/mach-omap2/board-omap3logic.c b/arch/arm/mach-omap2/board-omap3logic.c
index 2e0b011..3a1dd84 100644
--- a/arch/arm/mach-omap2/board-omap3logic.c
+++ b/arch/arm/mach-omap2/board-omap3logic.c
@@ -182,11 +182,6 @@ static inline void __init board_smsc911x_init(void)
 	gpmc_smsc911x_init(&board_smsc911x_data);
 }
 
-static void __init omap3logic_init_early(void)
-{
-	omap2_init_common_infrastructure();
-}
-
 #ifdef CONFIG_OMAP_MUX
 static struct omap_board_mux board_mux[] __initdata = {
 	{ .reg_offset = OMAP_MUX_TERMINATOR },
@@ -211,7 +206,7 @@ static void __init omap3logic_init(void)
 MACHINE_START(OMAP3_TORPEDO, "Logic OMAP3 Torpedo board")
 	.boot_params	= 0x80000100,
 	.map_io		= omap3_map_io,
-	.init_early	= omap3logic_init_early,
+	.init_early	= omap35xx_init_early,
 	.init_irq	= omap3_init_irq,
 	.init_machine	= omap3logic_init,
 	.timer		= &omap3_timer,
@@ -220,7 +215,7 @@ MACHINE_END
 MACHINE_START(OMAP3530_LV_SOM, "OMAP Logic 3530 LV SOM board")
 	.boot_params	= 0x80000100,
 	.map_io		= omap3_map_io,
-	.init_early	= omap3logic_init_early,
+	.init_early	= omap35xx_init_early,
 	.init_irq	= omap3_init_irq,
 	.init_machine	= omap3logic_init,
 	.timer		= &omap3_timer,
diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index 0f70566..e46bf52 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -525,11 +525,6 @@ static struct spi_board_info omap3pandora_spi_board_info[] __initdata = {
 	}
 };
 
-static void __init omap3pandora_init_early(void)
-{
-	omap2_init_common_infrastructure();
-}
-
 static void __init pandora_wl1251_init(void)
 {
 	struct wl12xx_platform_data pandora_wl1251_pdata;
@@ -609,7 +604,7 @@ MACHINE_START(OMAP3_PANDORA, "Pandora Handheld Console")
 	.boot_params	= 0x80000100,
 	.reserve	= omap_reserve,
 	.map_io		= omap3_map_io,
-	.init_early	= omap3pandora_init_early,
+	.init_early	= omap35xx_init_early,
 	.init_irq	= omap3_init_irq,
 	.init_machine	= omap3pandora_init,
 	.timer		= &omap3_timer,
diff --git a/arch/arm/mach-omap2/board-omap3stalker.c b/arch/arm/mach-omap2/board-omap3stalker.c
index 04981f9..807c274 100644
--- a/arch/arm/mach-omap2/board-omap3stalker.c
+++ b/arch/arm/mach-omap2/board-omap3stalker.c
@@ -428,11 +428,6 @@ static int __init omap3_stalker_i2c_init(void)
 static struct omap_board_config_kernel omap3_stalker_config[] __initdata = {
 };
 
-static void __init omap3_stalker_init_early(void)
-{
-	omap2_init_common_infrastructure();
-}
-
 static void __init omap3_stalker_init_irq(void)
 {
 	omap3_init_irq();
@@ -496,7 +491,7 @@ MACHINE_START(SBC3530, "OMAP3 STALKER")
 	/* Maintainer: Jason Lam -lzg@ema-tech.com */
 	.boot_params		= 0x80000100,
 	.map_io			= omap3_map_io,
-	.init_early		= omap3_stalker_init_early,
+	.init_early		= omap35xx_init_early,
 	.init_irq		= omap3_stalker_init_irq,
 	.init_machine		= omap3_stalker_init,
 	.timer			= &omap3_secure_timer,
diff --git a/arch/arm/mach-omap2/board-omap3touchbook.c b/arch/arm/mach-omap2/board-omap3touchbook.c
index b3fe7ad..f7f1809 100644
--- a/arch/arm/mach-omap2/board-omap3touchbook.c
+++ b/arch/arm/mach-omap2/board-omap3touchbook.c
@@ -326,11 +326,6 @@ static struct omap_board_mux board_mux[] __initdata = {
 };
 #endif
 
-static void __init omap3_touchbook_init_early(void)
-{
-	omap2_init_common_infrastructure();
-}
-
 static void __init omap3_touchbook_init_irq(void)
 {
 	omap3_init_irq();
@@ -407,7 +402,7 @@ MACHINE_START(TOUCHBOOK, "OMAP3 touchbook Board")
 	.boot_params	= 0x80000100,
 	.reserve	= omap_reserve,
 	.map_io		= omap3_map_io,
-	.init_early	= omap3_touchbook_init_early,
+	.init_early	= omap3430_init_early,
 	.init_irq	= omap3_touchbook_init_irq,
 	.init_machine	= omap3_touchbook_init,
 	.timer		= &omap3_secure_timer,
diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index b730ca5..1bce765 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -95,11 +95,6 @@ static struct platform_device *panda_devices[] __initdata = {
 	&wl1271_device,
 };
 
-static void __init omap4_panda_init_early(void)
-{
-	omap2_init_common_infrastructure();
-}
-
 static const struct usbhs_omap_board_data usbhs_bdata __initconst = {
 	.port_mode[0] = OMAP_EHCI_PORT_MODE_PHY,
 	.port_mode[1] = OMAP_USBHS_PORT_MODE_UNUSED,
@@ -586,7 +581,7 @@ MACHINE_START(OMAP4_PANDA, "OMAP4 Panda board")
 	.boot_params	= 0x80000100,
 	.reserve	= omap_reserve,
 	.map_io		= omap4_panda_map_io,
-	.init_early	= omap4_panda_init_early,
+	.init_early	= omap4430_init_early,
 	.init_irq	= gic_init_irq,
 	.init_machine	= omap4_panda_init,
 	.timer		= &omap4_timer,
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index c3bd1af..7228ae5 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -478,11 +478,6 @@ static int __init overo_spi_init(void)
 	return 0;
 }
 
-static void __init overo_init_early(void)
-{
-	omap2_init_common_infrastructure();
-}
-
 static const struct usbhs_omap_board_data usbhs_bdata __initconst = {
 	.port_mode[0] = OMAP_USBHS_PORT_MODE_UNUSED,
 	.port_mode[1] = OMAP_EHCI_PORT_MODE_PHY,
@@ -564,7 +559,7 @@ MACHINE_START(OVERO, "Gumstix Overo")
 	.boot_params	= 0x80000100,
 	.reserve	= omap_reserve,
 	.map_io		= omap3_map_io,
-	.init_early	= overo_init_early,
+	.init_early	= omap35xx_init_early,
 	.init_irq	= omap3_init_irq,
 	.init_machine	= overo_init,
 	.timer		= &omap3_timer,
diff --git a/arch/arm/mach-omap2/board-rm680.c b/arch/arm/mach-omap2/board-rm680.c
index a6f76e1..a3182e8 100644
--- a/arch/arm/mach-omap2/board-rm680.c
+++ b/arch/arm/mach-omap2/board-rm680.c
@@ -123,11 +123,6 @@ static void __init rm680_peripherals_init(void)
 	omap2_hsmmc_init(mmc);
 }
 
-static void __init rm680_init_early(void)
-{
-	omap2_init_common_infrastructure();
-}
-
 #ifdef CONFIG_OMAP_MUX
 static struct omap_board_mux board_mux[] __initdata = {
 	{ .reg_offset = OMAP_MUX_TERMINATOR },
@@ -158,7 +153,7 @@ MACHINE_START(NOKIA_RM680, "Nokia RM-680 board")
 	.boot_params	= 0x80000100,
 	.reserve	= omap_reserve,
 	.map_io		= rm680_map_io,
-	.init_early	= rm680_init_early,
+	.init_early	= omap3630_init_early,
 	.init_irq	= omap3_init_irq,
 	.init_machine	= rm680_init,
 	.timer		= &omap3_timer,
diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/board-rx51.c
index 656a8b5..32a79e2 100644
--- a/arch/arm/mach-omap2/board-rx51.c
+++ b/arch/arm/mach-omap2/board-rx51.c
@@ -102,11 +102,6 @@ static struct omap_board_config_kernel rx51_config[] = {
 	{ OMAP_TAG_LCD,		&rx51_lcd_config },
 };
 
-static void __init rx51_init_early(void)
-{
-	omap2_init_common_infrastructure();
-}
-
 extern void __init rx51_peripherals_init(void);
 
 #ifdef CONFIG_OMAP_MUX
@@ -161,7 +156,7 @@ MACHINE_START(NOKIA_RX51, "Nokia RX-51 board")
 	.boot_params	= 0x80000100,
 	.reserve	= rx51_reserve,
 	.map_io		= rx51_map_io,
-	.init_early	= rx51_init_early,
+	.init_early	= omap3430_init_early,
 	.init_irq	= omap3_init_irq,
 	.init_machine	= rx51_init,
 	.timer		= &omap3_timer,
diff --git a/arch/arm/mach-omap2/board-ti8168evm.c b/arch/arm/mach-omap2/board-ti8168evm.c
index e249c3d..981ca00 100644
--- a/arch/arm/mach-omap2/board-ti8168evm.c
+++ b/arch/arm/mach-omap2/board-ti8168evm.c
@@ -27,11 +27,6 @@
 static struct omap_board_config_kernel ti8168_evm_config[] __initdata = {
 };
 
-static void __init ti8168_init_early(void)
-{
-	omap2_init_common_infrastructure();
-}
-
 static void __init ti8168_evm_init(void)
 {
 	omap_serial_init();
@@ -50,7 +45,7 @@ MACHINE_START(TI8168EVM, "ti8168evm")
 	/* Maintainer: Texas Instruments */
 	.boot_params	= 0x80000100,
 	.map_io		= ti8168_evm_map_io,
-	.init_early	= ti8168_init_early,
+	.init_early	= ti816x_init_early,
 	.init_irq	= ti816x_init_irq,
 	.timer		= &omap3_timer,
 	.init_machine	= ti8168_evm_init,
diff --git a/arch/arm/mach-omap2/board-zoom.c b/arch/arm/mach-omap2/board-zoom.c
index 5695264..d56c796 100644
--- a/arch/arm/mach-omap2/board-zoom.c
+++ b/arch/arm/mach-omap2/board-zoom.c
@@ -34,11 +34,6 @@
 
 #define ZOOM3_EHCI_RESET_GPIO		64
 
-static void __init omap_zoom_init_early(void)
-{
-	omap2_init_common_infrastructure();
-}
-
 #ifdef CONFIG_OMAP_MUX
 static struct omap_board_mux board_mux[] __initdata = {
 	/* WLAN IRQ - GPIO 162 */
@@ -138,7 +133,7 @@ MACHINE_START(OMAP_ZOOM2, "OMAP Zoom2 board")
 	.boot_params	= 0x80000100,
 	.reserve	= omap_reserve,
 	.map_io		= omap3_map_io,
-	.init_early	= omap_zoom_init_early,
+	.init_early	= omap3430_init_early,
 	.init_irq	= omap3_init_irq,
 	.init_machine	= omap_zoom_init,
 	.timer		= &omap3_timer,
@@ -148,7 +143,7 @@ MACHINE_START(OMAP_ZOOM3, "OMAP Zoom3 board")
 	.boot_params	= 0x80000100,
 	.reserve	= omap_reserve,
 	.map_io		= omap3_map_io,
-	.init_early	= omap_zoom_init_early,
+	.init_early	= omap3630_init_early,
 	.init_irq	= omap3_init_irq,
 	.init_machine	= omap_zoom_init,
 	.timer		= &omap3_timer,
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 9258a5c..132724c 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -400,6 +400,46 @@ void __init omap2_init_common_infrastructure(void)
 		pr_err("Could not init clock framework - unknown SoC\n");
 }
 
+void __init omap2420_init_early(void)
+{
+	omap2_init_common_infrastructure();
+}
+
+void __init omap2430_init_early(void)
+{
+	omap2_init_common_infrastructure();
+}
+
+void __init omap3430_init_early(void)
+{
+	omap2_init_common_infrastructure();
+}
+
+void __init omap35xx_init_early(void)
+{
+	omap2_init_common_infrastructure();
+}
+
+void __init omap3630_init_early(void)
+{
+	omap2_init_common_infrastructure();
+}
+
+void __init am35xx_init_early(void)
+{
+	omap2_init_common_infrastructure();
+}
+
+void __init ti816x_init_early(void)
+{
+	omap2_init_common_infrastructure();
+}
+
+void __init omap4430_init_early(void)
+{
+	omap2_init_common_infrastructure();
+}
+
 void __init omap_sdrc_init(struct omap_sdrc_params *sdrc_cs0,
 				      struct omap_sdrc_params *sdrc_cs1)
 {
diff --git a/arch/arm/plat-omap/include/plat/common.h b/arch/arm/plat-omap/include/plat/common.h
index 4564cc6..5cac97e 100644
--- a/arch/arm/plat-omap/include/plat/common.h
+++ b/arch/arm/plat-omap/include/plat/common.h
@@ -45,6 +45,15 @@ extern unsigned long long notrace omap_32k_sched_clock(void);
 
 extern void omap_reserve(void);
 
+void omap2420_init_early(void);
+void omap2430_init_early(void);
+void omap3430_init_early(void);
+void omap35xx_init_early(void);
+void omap3630_init_early(void);
+void am35xx_init_early(void);
+void ti816x_init_early(void);
+void omap4430_init_early(void);
+
 /*
  * IO bases for various OMAP processors
  * Except the tap base, rest all the io bases
