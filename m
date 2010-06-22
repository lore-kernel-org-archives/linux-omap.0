From: Charulatha V <charu@ti.com>
Subject: [PATCH:v4 13/13] OMAP: GPIO: Remove omap_gpio_init()
Date: Tue, 22 Jun 2010 20:31:56 +0530
Message-ID: <1277218916-15213-14-git-send-email-charu@ti.com>
References: <1277218916-15213-1-git-send-email-charu@ti.com>
 <1277218916-15213-2-git-send-email-charu@ti.com>
 <1277218916-15213-3-git-send-email-charu@ti.com>
 <1277218916-15213-4-git-send-email-charu@ti.com>
 <1277218916-15213-5-git-send-email-charu@ti.com>
 <1277218916-15213-6-git-send-email-charu@ti.com>
 <1277218916-15213-7-git-send-email-charu@ti.com>
 <1277218916-15213-8-git-send-email-charu@ti.com>
 <1277218916-15213-9-git-send-email-charu@ti.com>
 <1277218916-15213-10-git-send-email-charu@ti.com>
 <1277218916-15213-11-git-send-email-charu@ti.com>
 <1277218916-15213-12-git-send-email-charu@ti.com>
 <1277218916-15213-13-git-send-email-charu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41827 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758650Ab0FVPBb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Jun 2010 11:01:31 -0400
In-Reply-To: <1277218916-15213-13-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, tony@atomide.com, rnayak@ti.com, p-basak2@ti.com, b-cousson@ti.com, Charulatha V <charu@ti.com>

This patch removes the usage of omap_gpio_init() from all
omap board files since omap_gpio_init() does nothing, after gpio
is implemented as a platform device.

Signed-off-by: Charulatha V <charu@ti.com>
Signed-off-by: Basak, Partha <p-basak2@ti.com>
---
 arch/arm/mach-omap1/board-ams-delta.c      |    1 -
 arch/arm/mach-omap1/board-fsample.c        |    1 -
 arch/arm/mach-omap1/board-h2.c             |    1 -
 arch/arm/mach-omap1/board-h3.c             |    1 -
 arch/arm/mach-omap1/board-htcherald.c      |    1 -
 arch/arm/mach-omap1/board-innovator.c      |    1 -
 arch/arm/mach-omap1/board-nokia770.c       |    1 -
 arch/arm/mach-omap1/board-osk.c            |    1 -
 arch/arm/mach-omap1/board-palmte.c         |    1 -
 arch/arm/mach-omap1/board-palmz71.c        |    1 -
 arch/arm/mach-omap1/board-perseus2.c       |    1 -
 arch/arm/mach-omap1/board-sx1.c            |    1 -
 arch/arm/mach-omap1/board-voiceblue.c      |    1 -
 arch/arm/mach-omap2/board-2430sdp.c        |    1 -
 arch/arm/mach-omap2/board-3430sdp.c        |    1 -
 arch/arm/mach-omap2/board-3630sdp.c        |    1 -
 arch/arm/mach-omap2/board-4430sdp.c        |    1 -
 arch/arm/mach-omap2/board-am3517evm.c      |    1 -
 arch/arm/mach-omap2/board-apollon.c        |    1 -
 arch/arm/mach-omap2/board-cm-t35.c         |    1 -
 arch/arm/mach-omap2/board-devkit8000.c     |    1 -
 arch/arm/mach-omap2/board-h4.c             |    1 -
 arch/arm/mach-omap2/board-igep0020.c       |    1 -
 arch/arm/mach-omap2/board-ldp.c            |    1 -
 arch/arm/mach-omap2/board-n8x0.c           |    1 -
 arch/arm/mach-omap2/board-omap3beagle.c    |    1 -
 arch/arm/mach-omap2/board-omap3evm.c       |    1 -
 arch/arm/mach-omap2/board-omap3pandora.c   |    1 -
 arch/arm/mach-omap2/board-omap3stalker.c   |    1 -
 arch/arm/mach-omap2/board-omap3touchbook.c |    1 -
 arch/arm/mach-omap2/board-overo.c          |    1 -
 arch/arm/mach-omap2/board-rx51.c           |    1 -
 arch/arm/mach-omap2/board-zoom2.c          |    1 -
 arch/arm/mach-omap2/board-zoom3.c          |    1 -
 arch/arm/plat-omap/gpio.c                  |    6 ------
 arch/arm/plat-omap/include/plat/gpio.h     |    1 -
 36 files changed, 0 insertions(+), 41 deletions(-)

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index fdd1dd5..75d1bd0 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -136,7 +136,6 @@ static void __init ams_delta_init_irq(void)
 {
 	omap1_init_common_hw();
 	omap_init_irq();
-	omap_gpio_init();
 }
 
 static struct map_desc ams_delta_io_desc[] __initdata = {
diff --git a/arch/arm/mach-omap1/board-fsample.c b/arch/arm/mach-omap1/board-fsample.c
index 096f2ed..8d9d6e8 100644
--- a/arch/arm/mach-omap1/board-fsample.c
+++ b/arch/arm/mach-omap1/board-fsample.c
@@ -313,7 +313,6 @@ static void __init omap_fsample_init_irq(void)
 {
 	omap1_init_common_hw();
 	omap_init_irq();
-	omap_gpio_init();
 	fsample_init_smc91x();
 }
 
diff --git a/arch/arm/mach-omap1/board-h2.c b/arch/arm/mach-omap1/board-h2.c
index d1100e4..dd04ef5 100644
--- a/arch/arm/mach-omap1/board-h2.c
+++ b/arch/arm/mach-omap1/board-h2.c
@@ -383,7 +383,6 @@ static void __init h2_init_irq(void)
 {
 	omap1_init_common_hw();
 	omap_init_irq();
-	omap_gpio_init();
 	h2_init_smc91x();
 }
 
diff --git a/arch/arm/mach-omap1/board-h3.c b/arch/arm/mach-omap1/board-h3.c
index a53ab82..ac8af4b 100644
--- a/arch/arm/mach-omap1/board-h3.c
+++ b/arch/arm/mach-omap1/board-h3.c
@@ -422,7 +422,6 @@ static void __init h3_init_irq(void)
 {
 	omap1_init_common_hw();
 	omap_init_irq();
-	omap_gpio_init();
 	h3_init_smc91x();
 }
 
diff --git a/arch/arm/mach-omap1/board-htcherald.c b/arch/arm/mach-omap1/board-htcherald.c
index 8e313b4..6ff6f30 100644
--- a/arch/arm/mach-omap1/board-htcherald.c
+++ b/arch/arm/mach-omap1/board-htcherald.c
@@ -278,7 +278,6 @@ static void __init htcherald_init(void)
 {
 	printk(KERN_INFO "HTC Herald init.\n");
 
-	omap_gpio_init();
 
 	omap_board_config = htcherald_config;
 	omap_board_config_size = ARRAY_SIZE(htcherald_config);
diff --git a/arch/arm/mach-omap1/board-innovator.c b/arch/arm/mach-omap1/board-innovator.c
index 5d12fd3..28bb2cd 100644
--- a/arch/arm/mach-omap1/board-innovator.c
+++ b/arch/arm/mach-omap1/board-innovator.c
@@ -290,7 +290,6 @@ static void __init innovator_init_irq(void)
 {
 	omap1_init_common_hw();
 	omap_init_irq();
-	omap_gpio_init();
 #ifdef CONFIG_ARCH_OMAP15XX
 	if (cpu_is_omap1510()) {
 		omap1510_fpga_init_irq();
diff --git a/arch/arm/mach-omap1/board-nokia770.c b/arch/arm/mach-omap1/board-nokia770.c
index 71e1a3f..6ea838c 100644
--- a/arch/arm/mach-omap1/board-nokia770.c
+++ b/arch/arm/mach-omap1/board-nokia770.c
@@ -379,7 +379,6 @@ static void __init omap_nokia770_init(void)
 	platform_add_devices(nokia770_devices, ARRAY_SIZE(nokia770_devices));
 	spi_register_board_info(nokia770_spi_board_info,
 				ARRAY_SIZE(nokia770_spi_board_info));
-	omap_gpio_init();
 	omap_serial_init();
 	omap_register_i2c_bus(1, 100, NULL, 0);
 	omap_dsp_init();
diff --git a/arch/arm/mach-omap1/board-osk.c b/arch/arm/mach-omap1/board-osk.c
index 80d8620..2db7712 100644
--- a/arch/arm/mach-omap1/board-osk.c
+++ b/arch/arm/mach-omap1/board-osk.c
@@ -283,7 +283,6 @@ static void __init osk_init_irq(void)
 {
 	omap1_init_common_hw();
 	omap_init_irq();
-	omap_gpio_init();
 	osk_init_smc91x();
 	osk_init_cf();
 }
diff --git a/arch/arm/mach-omap1/board-palmte.c b/arch/arm/mach-omap1/board-palmte.c
index 569b4c9..3864eab 100644
--- a/arch/arm/mach-omap1/board-palmte.c
+++ b/arch/arm/mach-omap1/board-palmte.c
@@ -63,7 +63,6 @@ static void __init omap_palmte_init_irq(void)
 {
 	omap1_init_common_hw();
 	omap_init_irq();
-	omap_gpio_init();
 }
 
 static const int palmte_keymap[] = {
diff --git a/arch/arm/mach-omap1/board-palmz71.c b/arch/arm/mach-omap1/board-palmz71.c
index 6641de9..8e3174d 100644
--- a/arch/arm/mach-omap1/board-palmz71.c
+++ b/arch/arm/mach-omap1/board-palmz71.c
@@ -62,7 +62,6 @@ omap_palmz71_init_irq(void)
 {
 	omap1_init_common_hw();
 	omap_init_irq();
-	omap_gpio_init();
 }
 
 static int palmz71_keymap[] = {
diff --git a/arch/arm/mach-omap1/board-perseus2.c b/arch/arm/mach-omap1/board-perseus2.c
index e854d57..d9f1ce7 100644
--- a/arch/arm/mach-omap1/board-perseus2.c
+++ b/arch/arm/mach-omap1/board-perseus2.c
@@ -281,7 +281,6 @@ static void __init omap_perseus2_init_irq(void)
 {
 	omap1_init_common_hw();
 	omap_init_irq();
-	omap_gpio_init();
 	perseus2_init_smc91x();
 }
 /* Only FPGA needs to be mapped here. All others are done with ioremap */
diff --git a/arch/arm/mach-omap1/board-sx1.c b/arch/arm/mach-omap1/board-sx1.c
index 2fb1e5f..f19e32c 100644
--- a/arch/arm/mach-omap1/board-sx1.c
+++ b/arch/arm/mach-omap1/board-sx1.c
@@ -409,7 +409,6 @@ static void __init omap_sx1_init_irq(void)
 {
 	omap1_init_common_hw();
 	omap_init_irq();
-	omap_gpio_init();
 }
 /*----------------------------------------*/
 
diff --git a/arch/arm/mach-omap1/board-voiceblue.c b/arch/arm/mach-omap1/board-voiceblue.c
index 87b9436..df5e975 100644
--- a/arch/arm/mach-omap1/board-voiceblue.c
+++ b/arch/arm/mach-omap1/board-voiceblue.c
@@ -158,7 +158,6 @@ static void __init voiceblue_init_irq(void)
 {
 	omap1_init_common_hw();
 	omap_init_irq();
-	omap_gpio_init();
 }
 
 static void __init voiceblue_init(void)
diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index a11a575..07a75d2 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -148,7 +148,6 @@ static void __init omap_2430sdp_init_irq(void)
 	omap_board_config_size = ARRAY_SIZE(sdp2430_config);
 	omap2_init_common_hw(NULL, NULL);
 	omap_init_irq();
-	omap_gpio_init();
 }
 
 static struct twl4030_gpio_platform_data sdp2430_gpio_data = {
diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index f474a80..abc4d28 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -328,7 +328,6 @@ static void __init omap_3430sdp_init_irq(void)
 	omap3_pm_init_cpuidle(omap3_cpuidle_params_table);
 	omap2_init_common_hw(hyb18m512160af6_sdrc_params, NULL);
 	omap_init_irq();
-	omap_gpio_init();
 }
 
 static int sdp3430_batt_table[] = {
diff --git a/arch/arm/mach-omap2/board-3630sdp.c b/arch/arm/mach-omap2/board-3630sdp.c
index 504d2bd..3a47578 100644
--- a/arch/arm/mach-omap2/board-3630sdp.c
+++ b/arch/arm/mach-omap2/board-3630sdp.c
@@ -82,7 +82,6 @@ static void __init omap_sdp_init_irq(void)
 	omap2_init_common_hw(h8mbx00u0mer0em_sdrc_params,
 			h8mbx00u0mer0em_sdrc_params);
 	omap_init_irq();
-	omap_gpio_init();
 }
 
 #ifdef CONFIG_OMAP_MUX
diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index e4a5d66..0094cfb 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -131,7 +131,6 @@ static void __init omap_4430sdp_init_irq(void)
 	omap2_gp_clockevent_set_gptimer(1);
 #endif
 	gic_init_irq();
-	omap_gpio_init();
 }
 
 static struct omap_musb_board_data musb_board_data = {
diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index af383a8..abf2703 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -372,7 +372,6 @@ static void __init am3517_evm_init_irq(void)
 
 	omap2_init_common_hw(NULL, NULL);
 	omap_init_irq();
-	omap_gpio_init();
 }
 
 static const struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
diff --git a/arch/arm/mach-omap2/board-apollon.c b/arch/arm/mach-omap2/board-apollon.c
index aa69fb9..269cd73 100644
--- a/arch/arm/mach-omap2/board-apollon.c
+++ b/arch/arm/mach-omap2/board-apollon.c
@@ -279,7 +279,6 @@ static void __init omap_apollon_init_irq(void)
 	omap_board_config_size = ARRAY_SIZE(apollon_config);
 	omap2_init_common_hw(NULL, NULL);
 	omap_init_irq();
-	omap_gpio_init();
 	apollon_init_smc91x();
 }
 
diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index e679a2c..af6d039 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -705,7 +705,6 @@ static void __init cm_t35_init_irq(void)
 	omap2_init_common_hw(mt46h32m32lf6_sdrc_params,
 			     mt46h32m32lf6_sdrc_params);
 	omap_init_irq();
-	omap_gpio_init();
 }
 
 static void __init cm_t35_map_io(void)
diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 77022b5..55addbc 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -472,7 +472,6 @@ static void __init devkit8000_init_irq(void)
 #ifdef CONFIG_OMAP_32K_TIMER
 	omap2_gp_clockevent_set_gptimer(12);
 #endif
-	omap_gpio_init();
 }
 
 static void __init devkit8000_ads7846_init(void)
diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
index 0665f2c..bd4e4ef 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -314,7 +314,6 @@ static void __init omap_h4_init_irq(void)
 	omap_board_config_size = ARRAY_SIZE(h4_config);
 	omap2_init_common_hw(NULL, NULL);
 	omap_init_irq();
-	omap_gpio_init();
 	h4_init_flash();
 }
 
diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index d55c57b..0e004cb 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -406,7 +406,6 @@ static void __init igep2_init_irq(void)
 	omap_board_config_size = ARRAY_SIZE(igep2_config);
 	omap2_init_common_hw(m65kxxxxam_sdrc_params, m65kxxxxam_sdrc_params);
 	omap_init_irq();
-	omap_gpio_init();
 }
 
 static struct twl4030_codec_audio_data igep2_audio_data = {
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index fefd7e6..f60cda8 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -291,7 +291,6 @@ static void __init omap_ldp_init_irq(void)
 	omap_board_config_size = ARRAY_SIZE(ldp_config);
 	omap2_init_common_hw(NULL, NULL);
 	omap_init_irq();
-	omap_gpio_init();
 	ldp_init_smsc911x();
 }
 
diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
index 3ccc34e..8efaacd 100644
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -646,7 +646,6 @@ static void __init n8x0_init_irq(void)
 {
 	omap2_init_common_hw(NULL, NULL);
 	omap_init_irq();
-	omap_gpio_init();
 }
 
 static void __init n8x0_init_machine(void)
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 69b154c..19da4fa 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -410,7 +410,6 @@ static void __init omap3_beagle_init_irq(void)
 #ifdef CONFIG_OMAP_32K_TIMER
 	omap2_gp_clockevent_set_gptimer(12);
 #endif
-	omap_gpio_init();
 }
 
 static struct platform_device *omap3_beagle_devices[] __initdata = {
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index b952610..f67e611 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -627,7 +627,6 @@ static void __init omap3_evm_init_irq(void)
 	omap_board_config_size = ARRAY_SIZE(omap3_evm_config);
 	omap2_init_common_hw(mt46h32m32lf6_sdrc_params, NULL);
 	omap_init_irq();
-	omap_gpio_init();
 }
 
 static struct platform_device *omap3_evm_devices[] __initdata = {
diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index db06dc9..ef415e3 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -536,7 +536,6 @@ static void __init omap3pandora_init_irq(void)
 	omap2_init_common_hw(mt46h32m32lf6_sdrc_params,
 			     mt46h32m32lf6_sdrc_params);
 	omap_init_irq();
-	omap_gpio_init();
 }
 
 static struct platform_device *omap3pandora_devices[] __initdata = {
diff --git a/arch/arm/mach-omap2/board-omap3stalker.c b/arch/arm/mach-omap2/board-omap3stalker.c
index a04cffd..bccf466 100644
--- a/arch/arm/mach-omap2/board-omap3stalker.c
+++ b/arch/arm/mach-omap2/board-omap3stalker.c
@@ -588,7 +588,6 @@ static void __init omap3_stalker_init_irq(void)
 #ifdef CONFIG_OMAP_32K_TIMER
 	omap2_gp_clockevent_set_gptimer(12);
 #endif
-	omap_gpio_init();
 }
 
 static struct platform_device *omap3_stalker_devices[] __initdata = {
diff --git a/arch/arm/mach-omap2/board-omap3touchbook.c b/arch/arm/mach-omap2/board-omap3touchbook.c
index 2f5f823..252aaed 100644
--- a/arch/arm/mach-omap2/board-omap3touchbook.c
+++ b/arch/arm/mach-omap2/board-omap3touchbook.c
@@ -444,7 +444,6 @@ static void __init omap3_touchbook_init_irq(void)
 #ifdef CONFIG_OMAP_32K_TIMER
 	omap2_gp_clockevent_set_gptimer(12);
 #endif
-	omap_gpio_init();
 }
 
 static struct platform_device *omap3_touchbook_devices[] __initdata = {
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index 79ac414..6fa95e5 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -399,7 +399,6 @@ static void __init overo_init_irq(void)
 	omap2_init_common_hw(mt46h32m32lf6_sdrc_params,
 			     mt46h32m32lf6_sdrc_params);
 	omap_init_irq();
-	omap_gpio_init();
 }
 
 static struct platform_device *overo_devices[] __initdata = {
diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/board-rx51.c
index 1b86b5b..4e9b749 100644
--- a/arch/arm/mach-omap2/board-rx51.c
+++ b/arch/arm/mach-omap2/board-rx51.c
@@ -108,7 +108,6 @@ static void __init rx51_init_irq(void)
 	sdrc_params = rx51_get_sdram_timings();
 	omap2_init_common_hw(sdrc_params, sdrc_params);
 	omap_init_irq();
-	omap_gpio_init();
 }
 
 extern void __init rx51_peripherals_init(void);
diff --git a/arch/arm/mach-omap2/board-zoom2.c b/arch/arm/mach-omap2/board-zoom2.c
index 803ef14..67bee0a 100644
--- a/arch/arm/mach-omap2/board-zoom2.c
+++ b/arch/arm/mach-omap2/board-zoom2.c
@@ -31,7 +31,6 @@ static void __init omap_zoom2_init_irq(void)
 	omap2_init_common_hw(mt46h32m32lf6_sdrc_params,
 				 mt46h32m32lf6_sdrc_params);
 	omap_init_irq();
-	omap_gpio_init();
 }
 
 /* REVISIT: These audio entries can be removed once MFD code is merged */
diff --git a/arch/arm/mach-omap2/board-zoom3.c b/arch/arm/mach-omap2/board-zoom3.c
index 3314704..4285d43 100644
--- a/arch/arm/mach-omap2/board-zoom3.c
+++ b/arch/arm/mach-omap2/board-zoom3.c
@@ -41,7 +41,6 @@ static void __init omap_zoom_init_irq(void)
 	omap2_init_common_hw(h8mbx00u0mer0em_sdrc_params,
 			h8mbx00u0mer0em_sdrc_params);
 	omap_init_irq();
-	omap_gpio_init();
 }
 
 #ifdef CONFIG_OMAP_MUX
diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 7f8ef27..e6d7abe 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -2109,12 +2109,6 @@ static int __init omap_gpio_drv_reg(void)
 }
 postcore_initcall(omap_gpio_drv_reg);
 
-/* TODO: Remove omap_gpio_init() and its usage from board files */
-int __init omap_gpio_init(void)
-{
-	return 0;
-}
-
 static int __init omap_gpio_sysinit(void)
 {
 	int ret = 0;
diff --git a/arch/arm/plat-omap/include/plat/gpio.h b/arch/arm/plat-omap/include/plat/gpio.h
index b7adc5a..3c158cf 100644
--- a/arch/arm/plat-omap/include/plat/gpio.h
+++ b/arch/arm/plat-omap/include/plat/gpio.h
@@ -94,7 +94,6 @@ struct omap_gpio_platform_data {
 /* TODO: Analyze removing gpio_bank_count usage from driver code */
 extern int gpio_bank_count;
 
-extern int omap_gpio_init(void);	/* Call from board init only */
 extern void omap2_gpio_prepare_for_idle(int power_state);
 extern void omap2_gpio_resume_after_idle(void);
 extern void omap_set_gpio_debounce(int gpio, int enable);
-- 
1.6.3.3

