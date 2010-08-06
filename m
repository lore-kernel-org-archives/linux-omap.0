From: Charulatha V <charu@ti.com>
Subject: [PATCH 13/13 v5] OMAP: GPIO: Remove omap_gpio_init()
Date: Fri,  6 Aug 2010 18:04:25 +0530
Message-ID: <1281098065-24177-14-git-send-email-charu@ti.com>
References: <1281098065-24177-1-git-send-email-charu@ti.com>
 <1281098065-24177-2-git-send-email-charu@ti.com>
 <1281098065-24177-3-git-send-email-charu@ti.com>
 <1281098065-24177-4-git-send-email-charu@ti.com>
 <1281098065-24177-5-git-send-email-charu@ti.com>
 <1281098065-24177-6-git-send-email-charu@ti.com>
 <1281098065-24177-7-git-send-email-charu@ti.com>
 <1281098065-24177-8-git-send-email-charu@ti.com>
 <1281098065-24177-9-git-send-email-charu@ti.com>
 <1281098065-24177-10-git-send-email-charu@ti.com>
 <1281098065-24177-11-git-send-email-charu@ti.com>
 <1281098065-24177-12-git-send-email-charu@ti.com>
 <1281098065-24177-13-git-send-email-charu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48639 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934526Ab0HFMbs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Aug 2010 08:31:48 -0400
In-Reply-To: <1281098065-24177-13-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, khilman@deeprootsystems.com, b-cousson@ti.com, rnayak@ti.com, Charulatha V <charu@ti.com>, "Basak, Partha" <p-basak2@ti.com>

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
 arch/arm/mach-omap2/board-omap4panda.c     |    1 -
 arch/arm/mach-omap2/board-overo.c          |    1 -
 arch/arm/mach-omap2/board-rx51.c           |    1 -
 arch/arm/mach-omap2/board-zoom2.c          |    1 -
 arch/arm/mach-omap2/board-zoom3.c          |    1 -
 35 files changed, 0 insertions(+), 35 deletions(-)

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index 41992ab..774867f 100644
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
index 180ce79..09b6165 100644
--- a/arch/arm/mach-omap1/board-fsample.c
+++ b/arch/arm/mach-omap1/board-fsample.c
@@ -325,7 +325,6 @@ static void __init omap_fsample_init_irq(void)
 {
 	omap1_init_common_hw();
 	omap_init_irq();
-	omap_gpio_init();
 	fsample_init_smc91x();
 }
 
diff --git a/arch/arm/mach-omap1/board-h2.c b/arch/arm/mach-omap1/board-h2.c
index d2cda58..cf9aaff 100644
--- a/arch/arm/mach-omap1/board-h2.c
+++ b/arch/arm/mach-omap1/board-h2.c
@@ -374,7 +374,6 @@ static void __init h2_init_irq(void)
 {
 	omap1_init_common_hw();
 	omap_init_irq();
-	omap_gpio_init();
 	h2_init_smc91x();
 }
 
diff --git a/arch/arm/mach-omap1/board-h3.c b/arch/arm/mach-omap1/board-h3.c
index c2ef4ff..423b45e 100644
--- a/arch/arm/mach-omap1/board-h3.c
+++ b/arch/arm/mach-omap1/board-h3.c
@@ -435,7 +435,6 @@ static void __init h3_init_irq(void)
 {
 	omap1_init_common_hw();
 	omap_init_irq();
-	omap_gpio_init();
 	h3_init_smc91x();
 }
 
diff --git a/arch/arm/mach-omap1/board-htcherald.c b/arch/arm/mach-omap1/board-htcherald.c
index 311899f..bc8f56f 100644
--- a/arch/arm/mach-omap1/board-htcherald.c
+++ b/arch/arm/mach-omap1/board-htcherald.c
@@ -278,7 +278,6 @@ static void __init htcherald_init(void)
 {
 	printk(KERN_INFO "HTC Herald init.\n");
 
-	omap_gpio_init();
 
 	omap_board_config = htcherald_config;
 	omap_board_config_size = ARRAY_SIZE(htcherald_config);
diff --git a/arch/arm/mach-omap1/board-innovator.c b/arch/arm/mach-omap1/board-innovator.c
index 3daf87a..27c283d 100644
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
index 51a4539..397febe 100644
--- a/arch/arm/mach-omap1/board-nokia770.c
+++ b/arch/arm/mach-omap1/board-nokia770.c
@@ -246,7 +246,6 @@ static void __init omap_nokia770_init(void)
 	platform_add_devices(nokia770_devices, ARRAY_SIZE(nokia770_devices));
 	spi_register_board_info(nokia770_spi_board_info,
 				ARRAY_SIZE(nokia770_spi_board_info));
-	omap_gpio_init();
 	omap_serial_init();
 	omap_register_i2c_bus(1, 100, NULL, 0);
 	hwa742_dev_init();
diff --git a/arch/arm/mach-omap1/board-osk.c b/arch/arm/mach-omap1/board-osk.c
index 679740c..fcd67d0 100644
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
index 782bb25..69708ac 100644
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
index 6636290..644d217 100644
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
index 34ab354..d8dbb4a 100644
--- a/arch/arm/mach-omap1/board-perseus2.c
+++ b/arch/arm/mach-omap1/board-perseus2.c
@@ -293,7 +293,6 @@ static void __init omap_perseus2_init_irq(void)
 {
 	omap1_init_common_hw();
 	omap_init_irq();
-	omap_gpio_init();
 	perseus2_init_smc91x();
 }
 /* Only FPGA needs to be mapped here. All others are done with ioremap */
diff --git a/arch/arm/mach-omap1/board-sx1.c b/arch/arm/mach-omap1/board-sx1.c
index 2eb148b..18093a5 100644
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
index 6b3cf14..794c497 100644
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
index 8538e41..b86824e 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -144,7 +144,6 @@ static void __init omap_2430sdp_init_irq(void)
 	omap_board_config_size = ARRAY_SIZE(sdp2430_config);
 	omap2_init_common_hw(NULL, NULL);
 	omap_init_irq();
-	omap_gpio_init();
 }
 
 static struct twl4030_gpio_platform_data sdp2430_gpio_data = {
diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 67b95b5..9f38f5f 100644
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
index b359c3f..78973f5 100644
--- a/arch/arm/mach-omap2/board-3630sdp.c
+++ b/arch/arm/mach-omap2/board-3630sdp.c
@@ -76,7 +76,6 @@ static void __init omap_sdp_init_irq(void)
 	omap2_init_common_hw(h8mbx00u0mer0em_sdrc_params,
 			h8mbx00u0mer0em_sdrc_params);
 	omap_init_irq();
-	omap_gpio_init();
 }
 
 #ifdef CONFIG_OMAP_MUX
diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 9447644..b7f6369 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -181,7 +181,6 @@ static void __init omap_4430sdp_init_irq(void)
 	omap2_gp_clockevent_set_gptimer(1);
 #endif
 	gic_init_irq();
-	omap_gpio_init();
 }
 
 static struct omap_musb_board_data musb_board_data = {
diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index 4d0f585..dd7aa66 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -372,7 +372,6 @@ static void __init am3517_evm_init_irq(void)
 
 	omap2_init_common_hw(NULL, NULL);
 	omap_init_irq();
-	omap_gpio_init();
 }
 
 static const struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
diff --git a/arch/arm/mach-omap2/board-apollon.c b/arch/arm/mach-omap2/board-apollon.c
index c6421a7..cd70971 100644
--- a/arch/arm/mach-omap2/board-apollon.c
+++ b/arch/arm/mach-omap2/board-apollon.c
@@ -280,7 +280,6 @@ static void __init omap_apollon_init_irq(void)
 	omap_board_config_size = ARRAY_SIZE(apollon_config);
 	omap2_init_common_hw(NULL, NULL);
 	omap_init_irq();
-	omap_gpio_init();
 	apollon_init_smc91x();
 }
 
diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index e10bc10..000c7d4 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -687,7 +687,6 @@ static void __init cm_t35_init_irq(void)
 	omap2_init_common_hw(mt46h32m32lf6_sdrc_params,
 			     mt46h32m32lf6_sdrc_params);
 	omap_init_irq();
-	omap_gpio_init();
 }
 
 static struct omap_board_mux board_mux[] __initdata = {
diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index a07086d..82b73e5 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -452,7 +452,6 @@ static void __init devkit8000_init_irq(void)
 #ifdef CONFIG_OMAP_32K_TIMER
 	omap2_gp_clockevent_set_gptimer(12);
 #endif
-	omap_gpio_init();
 }
 
 static void __init devkit8000_ads7846_init(void)
diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
index e09bd68..4eb7c24 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -293,7 +293,6 @@ static void __init omap_h4_init_irq(void)
 	omap_board_config_size = ARRAY_SIZE(h4_config);
 	omap2_init_common_hw(NULL, NULL);
 	omap_init_irq();
-	omap_gpio_init();
 	h4_init_flash();
 }
 
diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index 175f043..63a68ef 100644
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
index 00d9b13..097c8b9 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -292,7 +292,6 @@ static void __init omap_ldp_init_irq(void)
 	omap_board_config_size = ARRAY_SIZE(ldp_config);
 	omap2_init_common_hw(NULL, NULL);
 	omap_init_irq();
-	omap_gpio_init();
 	ldp_init_smsc911x();
 }
 
diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
index a3e2b49..afa0ce5 100644
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -648,7 +648,6 @@ static void __init n8x0_init_irq(void)
 {
 	omap2_init_common_hw(NULL, NULL);
 	omap_init_irq();
-	omap_gpio_init();
 }
 
 #ifdef CONFIG_OMAP_MUX
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 87969c7..fda730b 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -393,7 +393,6 @@ static void __init omap3_beagle_init_irq(void)
 #ifdef CONFIG_OMAP_32K_TIMER
 	omap2_gp_clockevent_set_gptimer(12);
 #endif
-	omap_gpio_init();
 }
 
 static struct platform_device *omap3_beagle_devices[] __initdata = {
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 6494dbd..cbb7614 100644
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
index 55836fa..ad9cd5f 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -588,7 +588,6 @@ static void __init omap3pandora_init_irq(void)
 	omap2_init_common_hw(mt46h32m32lf6_sdrc_params,
 			     mt46h32m32lf6_sdrc_params);
 	omap_init_irq();
-	omap_gpio_init();
 }
 
 static void pandora_wl1251_set_power(bool enable)
diff --git a/arch/arm/mach-omap2/board-omap3stalker.c b/arch/arm/mach-omap2/board-omap3stalker.c
index bcd01d2..1fbce09 100644
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
index 663c62d..6118042 100644
--- a/arch/arm/mach-omap2/board-omap3touchbook.c
+++ b/arch/arm/mach-omap2/board-omap3touchbook.c
@@ -427,7 +427,6 @@ static void __init omap3_touchbook_init_irq(void)
 #ifdef CONFIG_OMAP_32K_TIMER
 	omap2_gp_clockevent_set_gptimer(12);
 #endif
-	omap_gpio_init();
 }
 
 static struct platform_device *omap3_touchbook_devices[] __initdata = {
diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index c03d1d5..09b0da1 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -44,7 +44,6 @@ static void __init omap4_panda_init_irq(void)
 {
 	omap2_init_common_hw(NULL, NULL);
 	gic_init_irq();
-	omap_gpio_init();
 }
 
 static struct omap_musb_board_data musb_board_data = {
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index 4c48436..099f4f7 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -415,7 +415,6 @@ static void __init overo_init_irq(void)
 	omap2_init_common_hw(mt46h32m32lf6_sdrc_params,
 			     mt46h32m32lf6_sdrc_params);
 	omap_init_irq();
-	omap_gpio_init();
 }
 
 static struct platform_device *overo_devices[] __initdata = {
diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/board-rx51.c
index a58e8cb..04b0259 100644
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
index 3ad9ecf..634b05b 100644
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
index 6ca0b83..a048981 100644
--- a/arch/arm/mach-omap2/board-zoom3.c
+++ b/arch/arm/mach-omap2/board-zoom3.c
@@ -76,7 +76,6 @@ static void __init omap_zoom_init_irq(void)
 	omap2_init_common_hw(h8mbx00u0mer0em_sdrc_params,
 			h8mbx00u0mer0em_sdrc_params);
 	omap_init_irq();
-	omap_gpio_init();
 }
 
 #ifdef CONFIG_OMAP_MUX
-- 
1.6.3.3

