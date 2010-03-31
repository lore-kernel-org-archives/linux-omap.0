From: Charulatha V <charu@ti.com>
Subject: [PATCH 7/8] OMAP2PLUS:GPIO:Move gpio_init from board files to init_common_hw
Date: Wed, 31 Mar 2010 17:53:58 +0530
Message-ID: <1270038239-1090-8-git-send-email-charu@ti.com>
References: <1270038239-1090-1-git-send-email-charu@ti.com>
 <1270038239-1090-2-git-send-email-charu@ti.com>
 <1270038239-1090-3-git-send-email-charu@ti.com>
 <1270038239-1090-4-git-send-email-charu@ti.com>
 <1270038239-1090-5-git-send-email-charu@ti.com>
 <1270038239-1090-6-git-send-email-charu@ti.com>
 <1270038239-1090-7-git-send-email-charu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53194 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932593Ab0CaMTb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 31 Mar 2010 08:19:31 -0400
In-Reply-To: <1270038239-1090-7-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: rnayak@ti.com, paul@pwsan.com, tony@atomide.com, Charulatha V <charu@ti.com>

This is preparation for early platform device implementation
for GPIO in OMAP2PLUS. This patch moves initialization of gpio
from board files to omap2_init_common_hw API in io.c

Init_irq needs to be done before gpio_init, the init_irq
is called before omap2_init_common_hw in board files

Signed-off-by: Charulatha V <charu@ti.com>
---
 arch/arm/mach-omap2/board-2430sdp.c        |    3 +--
 arch/arm/mach-omap2/board-3430sdp.c        |    3 +--
 arch/arm/mach-omap2/board-3630sdp.c        |    3 +--
 arch/arm/mach-omap2/board-4430sdp.c        |    3 +--
 arch/arm/mach-omap2/board-am3517evm.c      |    3 +--
 arch/arm/mach-omap2/board-apollon.c        |    3 +--
 arch/arm/mach-omap2/board-cm-t35.c         |    3 +--
 arch/arm/mach-omap2/board-devkit8000.c     |    3 +--
 arch/arm/mach-omap2/board-generic.c        |    2 +-
 arch/arm/mach-omap2/board-h4.c             |    3 +--
 arch/arm/mach-omap2/board-igep0020.c       |    3 +--
 arch/arm/mach-omap2/board-ldp.c            |    3 +--
 arch/arm/mach-omap2/board-n8x0.c           |    3 +--
 arch/arm/mach-omap2/board-omap3beagle.c    |    3 +--
 arch/arm/mach-omap2/board-omap3evm.c       |    3 +--
 arch/arm/mach-omap2/board-omap3pandora.c   |    3 +--
 arch/arm/mach-omap2/board-omap3touchbook.c |    3 +--
 arch/arm/mach-omap2/board-overo.c          |    3 +--
 arch/arm/mach-omap2/board-rx51.c           |    3 +--
 arch/arm/mach-omap2/board-zoom2.c          |    3 +--
 arch/arm/mach-omap2/board-zoom3.c          |    3 +--
 arch/arm/mach-omap2/io.c                   |    2 ++
 22 files changed, 23 insertions(+), 41 deletions(-)

diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index 01d113f..7f55fcf 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -146,9 +146,8 @@ static void __init omap_2430sdp_init_irq(void)
 {
 	omap_board_config = sdp2430_config;
 	omap_board_config_size = ARRAY_SIZE(sdp2430_config);
-	omap2_init_common_hw(NULL, NULL);
 	omap_init_irq();
-	omap_gpio_init();
+	omap2_init_common_hw(NULL, NULL);
 }
 
 static struct twl4030_gpio_platform_data sdp2430_gpio_data = {
diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 5822bcf..6cd640c 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -327,9 +327,8 @@ static void __init omap_3430sdp_init_irq(void)
 	omap_board_config = sdp3430_config;
 	omap_board_config_size = ARRAY_SIZE(sdp3430_config);
 	omap3_pm_init_cpuidle(omap3_cpuidle_params_table);
-	omap2_init_common_hw(hyb18m512160af6_sdrc_params, NULL);
 	omap_init_irq();
-	omap_gpio_init();
+	omap2_init_common_hw(hyb18m512160af6_sdrc_params, NULL);
 }
 
 static int sdp3430_batt_table[] = {
diff --git a/arch/arm/mach-omap2/board-3630sdp.c b/arch/arm/mach-omap2/board-3630sdp.c
index 504d2bd..843a729 100644
--- a/arch/arm/mach-omap2/board-3630sdp.c
+++ b/arch/arm/mach-omap2/board-3630sdp.c
@@ -79,10 +79,9 @@ static void __init omap_sdp_init_irq(void)
 {
 	omap_board_config = sdp_config;
 	omap_board_config_size = ARRAY_SIZE(sdp_config);
+	omap_init_irq();
 	omap2_init_common_hw(h8mbx00u0mer0em_sdrc_params,
 			h8mbx00u0mer0em_sdrc_params);
-	omap_init_irq();
-	omap_gpio_init();
 }
 
 #ifdef CONFIG_OMAP_MUX
diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index b88f28c..baf5955 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -97,12 +97,11 @@ static void __init omap_4430sdp_init_irq(void)
 {
 	omap_board_config = sdp4430_config;
 	omap_board_config_size = ARRAY_SIZE(sdp4430_config);
+	gic_init_irq();
 	omap2_init_common_hw(NULL, NULL);
 #ifdef CONFIG_OMAP_32K_TIMER
 	omap2_gp_clockevent_set_gptimer(1);
 #endif
-	gic_init_irq();
-	omap_gpio_init();
 }
 
 static struct omap_musb_board_data musb_board_data = {
diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index 6ae8805..ea52dc9 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -268,9 +268,8 @@ static void __init am3517_evm_init_irq(void)
 	omap_board_config = am3517_evm_config;
 	omap_board_config_size = ARRAY_SIZE(am3517_evm_config);
 
-	omap2_init_common_hw(NULL, NULL);
 	omap_init_irq();
-	omap_gpio_init();
+	omap2_init_common_hw(NULL, NULL);
 }
 
 static const struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
diff --git a/arch/arm/mach-omap2/board-apollon.c b/arch/arm/mach-omap2/board-apollon.c
index aa69fb9..3fe86df 100644
--- a/arch/arm/mach-omap2/board-apollon.c
+++ b/arch/arm/mach-omap2/board-apollon.c
@@ -277,9 +277,8 @@ static void __init omap_apollon_init_irq(void)
 {
 	omap_board_config = apollon_config;
 	omap_board_config_size = ARRAY_SIZE(apollon_config);
-	omap2_init_common_hw(NULL, NULL);
 	omap_init_irq();
-	omap_gpio_init();
+	omap2_init_common_hw(NULL, NULL);
 	apollon_init_smc91x();
 }
 
diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index 2de4f79..596acba 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -701,10 +701,9 @@ static void __init cm_t35_init_irq(void)
 	omap_board_config = cm_t35_config;
 	omap_board_config_size = ARRAY_SIZE(cm_t35_config);
 
+	omap_init_irq();
 	omap2_init_common_hw(mt46h32m32lf6_sdrc_params,
 			     mt46h32m32lf6_sdrc_params);
-	omap_init_irq();
-	omap_gpio_init();
 }
 
 static void __init cm_t35_map_io(void)
diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 5bfc13b..0e8d38c 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -481,13 +481,12 @@ static void __init devkit8000_init_irq(void)
 {
 	omap_board_config = devkit8000_config;
 	omap_board_config_size = ARRAY_SIZE(devkit8000_config);
+	omap_init_irq();
 	omap2_init_common_hw(mt46h32m32lf6_sdrc_params,
 			     mt46h32m32lf6_sdrc_params);
-	omap_init_irq();
 #ifdef CONFIG_OMAP_32K_TIMER
 	omap2_gp_clockevent_set_gptimer(12);
 #endif
-	omap_gpio_init();
 }
 
 static void __init devkit8000_ads7846_init(void)
diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index 16cc068..9ba0777 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -38,8 +38,8 @@ static void __init omap_generic_init_irq(void)
 {
 	omap_board_config = generic_config;
 	omap_board_config_size = ARRAY_SIZE(generic_config);
-	omap2_init_common_hw(NULL, NULL);
 	omap_init_irq();
+	omap2_init_common_hw(NULL, NULL);
 }
 
 static void __init omap_generic_init(void)
diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
index 0665f2c..a143e64 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -312,9 +312,8 @@ static void __init omap_h4_init_irq(void)
 {
 	omap_board_config = h4_config;
 	omap_board_config_size = ARRAY_SIZE(h4_config);
-	omap2_init_common_hw(NULL, NULL);
 	omap_init_irq();
-	omap_gpio_init();
+	omap2_init_common_hw(NULL, NULL);
 	h4_init_flash();
 }
 
diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index 3c7789d..885313e 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -404,9 +404,8 @@ static void __init igep2_init_irq(void)
 {
 	omap_board_config = igep2_config;
 	omap_board_config_size = ARRAY_SIZE(igep2_config);
-	omap2_init_common_hw(m65kxxxxam_sdrc_params, m65kxxxxam_sdrc_params);
 	omap_init_irq();
-	omap_gpio_init();
+	omap2_init_common_hw(m65kxxxxam_sdrc_params, m65kxxxxam_sdrc_params);
 }
 
 static struct twl4030_codec_audio_data igep2_audio_data = {
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index 5fcb52e..f0d6ad9 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -290,9 +290,8 @@ static void __init omap_ldp_init_irq(void)
 {
 	omap_board_config = ldp_config;
 	omap_board_config_size = ARRAY_SIZE(ldp_config);
-	omap2_init_common_hw(NULL, NULL);
 	omap_init_irq();
-	omap_gpio_init();
+	omap2_init_common_hw(NULL, NULL);
 	ldp_init_smsc911x();
 }
 
diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
index 131ce3c..396ef39 100644
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -673,9 +673,8 @@ static void __init n8x0_map_io(void)
 
 static void __init n8x0_init_irq(void)
 {
-	omap2_init_common_hw(NULL, NULL);
 	omap_init_irq();
-	omap_gpio_init();
+	omap2_init_common_hw(NULL, NULL);
 }
 
 static void __init n8x0_init_machine(void)
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 962d377..96d44f4 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -357,13 +357,12 @@ static void __init omap3_beagle_init_irq(void)
 {
 	omap_board_config = omap3_beagle_config;
 	omap_board_config_size = ARRAY_SIZE(omap3_beagle_config);
+	omap_init_irq();
 	omap2_init_common_hw(mt46h32m32lf6_sdrc_params,
 			     mt46h32m32lf6_sdrc_params);
-	omap_init_irq();
 #ifdef CONFIG_OMAP_32K_TIMER
 	omap2_gp_clockevent_set_gptimer(12);
 #endif
-	omap_gpio_init();
 }
 
 static struct platform_device *omap3_beagle_devices[] __initdata = {
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 017bb2f..a592773 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -626,9 +626,8 @@ static void __init omap3_evm_init_irq(void)
 {
 	omap_board_config = omap3_evm_config;
 	omap_board_config_size = ARRAY_SIZE(omap3_evm_config);
-	omap2_init_common_hw(mt46h32m32lf6_sdrc_params, NULL);
 	omap_init_irq();
-	omap_gpio_init();
+	omap2_init_common_hw(mt46h32m32lf6_sdrc_params, NULL);
 }
 
 static struct platform_device *omap3_evm_devices[] __initdata = {
diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index 395d049..7606170 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -533,10 +533,9 @@ static struct spi_board_info omap3pandora_spi_board_info[] __initdata = {
 
 static void __init omap3pandora_init_irq(void)
 {
+	omap_init_irq();
 	omap2_init_common_hw(mt46h32m32lf6_sdrc_params,
 			     mt46h32m32lf6_sdrc_params);
-	omap_init_irq();
-	omap_gpio_init();
 }
 
 static struct platform_device *omap3pandora_devices[] __initdata = {
diff --git a/arch/arm/mach-omap2/board-omap3touchbook.c b/arch/arm/mach-omap2/board-omap3touchbook.c
index 2504d41..fa35ffe 100644
--- a/arch/arm/mach-omap2/board-omap3touchbook.c
+++ b/arch/arm/mach-omap2/board-omap3touchbook.c
@@ -439,13 +439,12 @@ static void __init omap3_touchbook_init_irq(void)
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
 	omap_board_config = omap3_touchbook_config;
 	omap_board_config_size = ARRAY_SIZE(omap3_touchbook_config);
+	omap_init_irq();
 	omap2_init_common_hw(mt46h32m32lf6_sdrc_params,
 			     mt46h32m32lf6_sdrc_params);
-	omap_init_irq();
 #ifdef CONFIG_OMAP_32K_TIMER
 	omap2_gp_clockevent_set_gptimer(12);
 #endif
-	omap_gpio_init();
 }
 
 static struct platform_device *omap3_touchbook_devices[] __initdata = {
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index 8848c7c..830515e 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -384,10 +384,9 @@ static void __init overo_init_irq(void)
 {
 	omap_board_config = overo_config;
 	omap_board_config_size = ARRAY_SIZE(overo_config);
+	omap_init_irq();
 	omap2_init_common_hw(mt46h32m32lf6_sdrc_params,
 			     mt46h32m32lf6_sdrc_params);
-	omap_init_irq();
-	omap_gpio_init();
 }
 
 static struct platform_device *overo_devices[] __initdata = {
diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/board-rx51.c
index b155c36..dbaaf56 100644
--- a/arch/arm/mach-omap2/board-rx51.c
+++ b/arch/arm/mach-omap2/board-rx51.c
@@ -105,9 +105,8 @@ static void __init rx51_init_irq(void)
 	omap_board_config_size = ARRAY_SIZE(rx51_config);
 	omap3_pm_init_cpuidle(rx51_cpuidle_params);
 	sdrc_params = rx51_get_sdram_timings();
-	omap2_init_common_hw(sdrc_params, sdrc_params);
 	omap_init_irq();
-	omap_gpio_init();
+	omap2_init_common_hw(sdrc_params, sdrc_params);
 }
 
 extern void __init rx51_peripherals_init(void);
diff --git a/arch/arm/mach-omap2/board-zoom2.c b/arch/arm/mach-omap2/board-zoom2.c
index 9a26f84..6238338 100644
--- a/arch/arm/mach-omap2/board-zoom2.c
+++ b/arch/arm/mach-omap2/board-zoom2.c
@@ -28,10 +28,9 @@
 
 static void __init omap_zoom2_init_irq(void)
 {
+	omap_init_irq();
 	omap2_init_common_hw(mt46h32m32lf6_sdrc_params,
 				 mt46h32m32lf6_sdrc_params);
-	omap_init_irq();
-	omap_gpio_init();
 }
 
 /* REVISIT: These audio entries can be removed once MFD code is merged */
diff --git a/arch/arm/mach-omap2/board-zoom3.c b/arch/arm/mach-omap2/board-zoom3.c
index cd3e40c..ff2fb22 100644
--- a/arch/arm/mach-omap2/board-zoom3.c
+++ b/arch/arm/mach-omap2/board-zoom3.c
@@ -38,10 +38,9 @@ static void __init omap_zoom_init_irq(void)
 {
 	omap_board_config = zoom_config;
 	omap_board_config_size = ARRAY_SIZE(zoom_config);
+	omap_init_irq();
 	omap2_init_common_hw(h8mbx00u0mer0em_sdrc_params,
 			h8mbx00u0mer0em_sdrc_params);
-	omap_init_irq();
-	omap_gpio_init();
 }
 
 #ifdef CONFIG_OMAP_MUX
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 87f676a..e6e5834 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -34,6 +34,7 @@
 #include <plat/gpmc.h>
 #include <plat/serial.h>
 #include <plat/vram.h>
+#include <plat/gpio.h>
 
 #include "clock2xxx.h"
 #include "clock3xxx.h"
@@ -339,4 +340,5 @@ void __init omap2_init_common_hw(struct omap_sdrc_params *sdrc_cs0,
 		_omap2_init_reprogram_sdrc();
 	}
 	gpmc_init();
+	omap_gpio_init();
 }
-- 
1.6.3.3

