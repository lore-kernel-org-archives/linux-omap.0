From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 1/8] OMAP2+: io: split omap2_init_common_hw()
Date: Tue, 16 Nov 2010 03:18:05 -0700
Message-ID: <20101116101801.22777.41352.stgit@twilight.localdomain>
References: <20101116101615.22777.49212.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:51522 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934146Ab0KPKTM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Nov 2010 05:19:12 -0500
In-Reply-To: <20101116101615.22777.49212.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>

Split omap2_init_common_hw() into two functions.  The first,
omap2_init_common_infrastructure(), initializes the hwmod code and
data, the OMAP PM code, and the clock code and data.  The second,
omap2_init_common_devices(), handles any other early device
initialization that, for whatever reason, has not been or cannot be
moved to initcalls or early platform devices.

This patch is required for the hwmod postsetup patch, which allows
board files to change the state that hwmods should be placed into at
the conclusion of the hwmod _setup() function.  For example, for a
board whose creators wish to ensure watchdog coverage across the
entire kernel boot process, code to change the watchdog's postsetup
state will be added in the board-*.c file between the
omap2_init_common_infrastructure() and omap2_init_common_devices() function
calls.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-2430sdp.c        |    3 ++-
 arch/arm/mach-omap2/board-3430sdp.c        |    3 ++-
 arch/arm/mach-omap2/board-3630sdp.c        |    5 +++--
 arch/arm/mach-omap2/board-4430sdp.c        |    3 ++-
 arch/arm/mach-omap2/board-am3517evm.c      |    4 ++--
 arch/arm/mach-omap2/board-apollon.c        |    3 ++-
 arch/arm/mach-omap2/board-cm-t35.c         |    3 ++-
 arch/arm/mach-omap2/board-cm-t3517.c       |    3 ++-
 arch/arm/mach-omap2/board-devkit8000.c     |    5 +++--
 arch/arm/mach-omap2/board-generic.c        |    3 ++-
 arch/arm/mach-omap2/board-h4.c             |    3 ++-
 arch/arm/mach-omap2/board-igep0020.c       |    4 +++-
 arch/arm/mach-omap2/board-igep0030.c       |    4 +++-
 arch/arm/mach-omap2/board-ldp.c            |    3 ++-
 arch/arm/mach-omap2/board-n8x0.c           |    3 ++-
 arch/arm/mach-omap2/board-omap3beagle.c    |    5 +++--
 arch/arm/mach-omap2/board-omap3evm.c       |    3 ++-
 arch/arm/mach-omap2/board-omap3logic.c     |    3 ++-
 arch/arm/mach-omap2/board-omap3pandora.c   |    5 +++--
 arch/arm/mach-omap2/board-omap3stalker.c   |    3 ++-
 arch/arm/mach-omap2/board-omap3touchbook.c |    5 +++--
 arch/arm/mach-omap2/board-omap4panda.c     |    3 ++-
 arch/arm/mach-omap2/board-overo.c          |    5 +++--
 arch/arm/mach-omap2/board-rx51.c           |    3 ++-
 arch/arm/mach-omap2/board-zoom.c           |    9 +++++----
 arch/arm/mach-omap2/io.c                   |   16 ++++++++++++----
 arch/arm/plat-omap/include/plat/io.h       |    5 +++--
 27 files changed, 76 insertions(+), 41 deletions(-)

diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index b527f8d..7de5e5a 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -143,7 +143,8 @@ static void __init omap_2430sdp_init_irq(void)
 {
 	omap_board_config = sdp2430_config;
 	omap_board_config_size = ARRAY_SIZE(sdp2430_config);
-	omap2_init_common_hw(NULL, NULL);
+	omap2_init_common_infrastructure();
+	omap2_init_common_devices(NULL, NULL);
 	omap_init_irq();
 	omap_gpio_init();
 }
diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 4e3742c..2452dac8c 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -326,7 +326,8 @@ static void __init omap_3430sdp_init_irq(void)
 	omap_board_config = sdp3430_config;
 	omap_board_config_size = ARRAY_SIZE(sdp3430_config);
 	omap3_pm_init_cpuidle(omap3_cpuidle_params_table);
-	omap2_init_common_hw(hyb18m512160af6_sdrc_params, NULL);
+	omap2_init_common_infrastructure();
+	omap2_init_common_devices(hyb18m512160af6_sdrc_params, NULL);
 	omap_init_irq();
 	omap_gpio_init();
 }
diff --git a/arch/arm/mach-omap2/board-3630sdp.c b/arch/arm/mach-omap2/board-3630sdp.c
index bbcf580..40e816a 100644
--- a/arch/arm/mach-omap2/board-3630sdp.c
+++ b/arch/arm/mach-omap2/board-3630sdp.c
@@ -73,8 +73,9 @@ static void __init omap_sdp_init_irq(void)
 {
 	omap_board_config = sdp_config;
 	omap_board_config_size = ARRAY_SIZE(sdp_config);
-	omap2_init_common_hw(h8mbx00u0mer0em_sdrc_params,
-			h8mbx00u0mer0em_sdrc_params);
+	omap2_init_common_infrastructure();
+	omap2_init_common_devices(h8mbx00u0mer0em_sdrc_params,
+				  h8mbx00u0mer0em_sdrc_params);
 	omap_init_irq();
 	omap_gpio_init();
 }
diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index df5a425..d6f4798 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -217,7 +217,8 @@ static void __init omap_4430sdp_init_irq(void)
 {
 	omap_board_config = sdp4430_config;
 	omap_board_config_size = ARRAY_SIZE(sdp4430_config);
-	omap2_init_common_hw(NULL, NULL);
+	omap2_init_common_infrastructure();
+	omap2_init_common_devices(NULL, NULL);
 #ifdef CONFIG_OMAP_32K_TIMER
 	omap2_gp_clockevent_set_gptimer(1);
 #endif
diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index 0739950..14039f5 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -389,8 +389,8 @@ static void __init am3517_evm_init_irq(void)
 {
 	omap_board_config = am3517_evm_config;
 	omap_board_config_size = ARRAY_SIZE(am3517_evm_config);
-
-	omap2_init_common_hw(NULL, NULL);
+	omap2_init_common_infrastructure();
+	omap2_init_common_devices(NULL, NULL);
 	omap_init_irq();
 	omap_gpio_init();
 }
diff --git a/arch/arm/mach-omap2/board-apollon.c b/arch/arm/mach-omap2/board-apollon.c
index 2c6db1a..294bfdf 100644
--- a/arch/arm/mach-omap2/board-apollon.c
+++ b/arch/arm/mach-omap2/board-apollon.c
@@ -278,7 +278,8 @@ static void __init omap_apollon_init_irq(void)
 {
 	omap_board_config = apollon_config;
 	omap_board_config_size = ARRAY_SIZE(apollon_config);
-	omap2_init_common_hw(NULL, NULL);
+	omap2_init_common_infrastructure();
+	omap2_init_common_devices(NULL, NULL);
 	omap_init_irq();
 	omap_gpio_init();
 	apollon_init_smc91x();
diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index 63f764e..583b2ca 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -683,7 +683,8 @@ static void __init cm_t35_init_irq(void)
 	omap_board_config = cm_t35_config;
 	omap_board_config_size = ARRAY_SIZE(cm_t35_config);
 
-	omap2_init_common_hw(mt46h32m32lf6_sdrc_params,
+	omap2_init_common_infrastructure();
+	omap2_init_common_devices(mt46h32m32lf6_sdrc_params,
 			     mt46h32m32lf6_sdrc_params);
 	omap_init_irq();
 	omap_gpio_init();
diff --git a/arch/arm/mach-omap2/board-cm-t3517.c b/arch/arm/mach-omap2/board-cm-t3517.c
index 1dd303e..3820a3c 100644
--- a/arch/arm/mach-omap2/board-cm-t3517.c
+++ b/arch/arm/mach-omap2/board-cm-t3517.c
@@ -248,7 +248,8 @@ static void __init cm_t3517_init_irq(void)
 	omap_board_config = cm_t3517_config;
 	omap_board_config_size = ARRAY_SIZE(cm_t3517_config);
 
-	omap2_init_common_hw(NULL, NULL);
+	omap2_init_common_infrastructure();
+	omap2_init_common_devices(NULL, NULL);
 	omap_init_irq();
 	omap_gpio_init();
 }
diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 53ac762..39cc593 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -444,8 +444,9 @@ static struct platform_device keys_gpio = {
 
 static void __init devkit8000_init_irq(void)
 {
-	omap2_init_common_hw(mt46h32m32lf6_sdrc_params,
-			     mt46h32m32lf6_sdrc_params);
+	omap2_init_common_infrastructure();
+	omap2_init_common_devices(mt46h32m32lf6_sdrc_params,
+				  mt46h32m32lf6_sdrc_params);
 	omap_init_irq();
 #ifdef CONFIG_OMAP_32K_TIMER
 	omap2_gp_clockevent_set_gptimer(12);
diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index b1c2c9a..0e3d81e 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -37,7 +37,8 @@ static void __init omap_generic_init_irq(void)
 {
 	omap_board_config = generic_config;
 	omap_board_config_size = ARRAY_SIZE(generic_config);
-	omap2_init_common_hw(NULL, NULL);
+	omap2_init_common_infrastructure();
+	omap2_init_common_devices(NULL, NULL);
 	omap_init_irq();
 }
 
diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
index 929993b..259a765 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -291,7 +291,8 @@ static void __init omap_h4_init_irq(void)
 {
 	omap_board_config = h4_config;
 	omap_board_config_size = ARRAY_SIZE(h4_config);
-	omap2_init_common_hw(NULL, NULL);
+	omap2_init_common_infrastructure();
+	omap2_init_common_devices(NULL, NULL);
 	omap_init_irq();
 	omap_gpio_init();
 	h4_init_flash();
diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index fe76b59..dc01b89 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -482,7 +482,9 @@ static struct platform_device *igep2_devices[] __initdata = {
 
 static void __init igep2_init_irq(void)
 {
-	omap2_init_common_hw(m65kxxxxam_sdrc_params, m65kxxxxam_sdrc_params);
+	omap2_init_common_infrastructure();
+	omap2_init_common_devices(m65kxxxxam_sdrc_params,
+				  m65kxxxxam_sdrc_params);
 	omap_init_irq();
 	omap_gpio_init();
 }
diff --git a/arch/arm/mach-omap2/board-igep0030.c b/arch/arm/mach-omap2/board-igep0030.c
index 22b0b25..a8907c5 100644
--- a/arch/arm/mach-omap2/board-igep0030.c
+++ b/arch/arm/mach-omap2/board-igep0030.c
@@ -289,7 +289,9 @@ static struct twl4030_usb_data igep3_twl4030_usb_data = {
 
 static void __init igep3_init_irq(void)
 {
-	omap2_init_common_hw(m65kxxxxam_sdrc_params, m65kxxxxam_sdrc_params);
+	omap2_init_common_infrastructure();
+	omap2_init_common_devices(m65kxxxxam_sdrc_params,
+				  m65kxxxxam_sdrc_params);
 	omap_init_irq();
 	omap_gpio_init();
 }
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index 001fd97..0e373f3 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -292,7 +292,8 @@ static void __init omap_ldp_init_irq(void)
 {
 	omap_board_config = ldp_config;
 	omap_board_config_size = ARRAY_SIZE(ldp_config);
-	omap2_init_common_hw(NULL, NULL);
+	omap2_init_common_infrastructure();
+	omap2_init_common_devices(NULL, NULL);
 	omap_init_irq();
 	omap_gpio_init();
 	ldp_init_smsc911x();
diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
index ebd460e..20dc4c1 100644
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -741,7 +741,8 @@ static void __init n8x0_map_io(void)
 
 static void __init n8x0_init_irq(void)
 {
-	omap2_init_common_hw(NULL, NULL);
+	omap2_init_common_infrastructure();
+	omap2_init_common_devices(NULL, NULL);
 	omap_init_irq();
 	omap_gpio_init();
 }
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 14f4224..4b48e55 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -484,8 +484,9 @@ static struct platform_device keys_gpio = {
 
 static void __init omap3_beagle_init_irq(void)
 {
-	omap2_init_common_hw(mt46h32m32lf6_sdrc_params,
-			     mt46h32m32lf6_sdrc_params);
+	omap2_init_common_infrastructure();
+	omap2_init_common_devices(mt46h32m32lf6_sdrc_params,
+				  mt46h32m32lf6_sdrc_params);
 	omap_init_irq();
 #ifdef CONFIG_OMAP_32K_TIMER
 	omap2_gp_clockevent_set_gptimer(12);
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index b04365c..c82a80a 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -623,7 +623,8 @@ static void __init omap3_evm_init_irq(void)
 {
 	omap_board_config = omap3_evm_config;
 	omap_board_config_size = ARRAY_SIZE(omap3_evm_config);
-	omap2_init_common_hw(mt46h32m32lf6_sdrc_params, NULL);
+	omap2_init_common_infrastructure();
+	omap2_init_common_devices(mt46h32m32lf6_sdrc_params, NULL);
 	omap_init_irq();
 	omap_gpio_init();
 }
diff --git a/arch/arm/mach-omap2/board-omap3logic.c b/arch/arm/mach-omap2/board-omap3logic.c
index 5f7d2c1..8ee2478 100644
--- a/arch/arm/mach-omap2/board-omap3logic.c
+++ b/arch/arm/mach-omap2/board-omap3logic.c
@@ -197,7 +197,8 @@ static inline void __init board_smsc911x_init(void)
 
 static void __init omap3logic_init_irq(void)
 {
-	omap2_init_common_hw(NULL, NULL);
+	omap2_init_common_infrastructure();
+	omap2_init_common_devices(NULL, NULL);
 	omap_init_irq();
 	omap_gpio_init();
 }
diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index 89ed1be..a9eb59d 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -636,8 +636,9 @@ static struct spi_board_info omap3pandora_spi_board_info[] __initdata = {
 
 static void __init omap3pandora_init_irq(void)
 {
-	omap2_init_common_hw(mt46h32m32lf6_sdrc_params,
-			     mt46h32m32lf6_sdrc_params);
+	omap2_init_common_infrastructure();
+	omap2_init_common_devices(mt46h32m32lf6_sdrc_params,
+				  mt46h32m32lf6_sdrc_params);
 	omap_init_irq();
 	omap_gpio_init();
 }
diff --git a/arch/arm/mach-omap2/board-omap3stalker.c b/arch/arm/mach-omap2/board-omap3stalker.c
index f252721..a92d4ea 100644
--- a/arch/arm/mach-omap2/board-omap3stalker.c
+++ b/arch/arm/mach-omap2/board-omap3stalker.c
@@ -584,7 +584,8 @@ static void __init omap3_stalker_init_irq(void)
 {
 	omap_board_config = omap3_stalker_config;
 	omap_board_config_size = ARRAY_SIZE(omap3_stalker_config);
-	omap2_init_common_hw(mt46h32m32lf6_sdrc_params, NULL);
+	omap2_init_common_infrastructure();
+	omap2_init_common_devices(mt46h32m32lf6_sdrc_params, NULL);
 	omap_init_irq();
 #ifdef CONFIG_OMAP_32K_TIMER
 	omap2_gp_clockevent_set_gptimer(12);
diff --git a/arch/arm/mach-omap2/board-omap3touchbook.c b/arch/arm/mach-omap2/board-omap3touchbook.c
index 41104bb..f9281de 100644
--- a/arch/arm/mach-omap2/board-omap3touchbook.c
+++ b/arch/arm/mach-omap2/board-omap3touchbook.c
@@ -422,8 +422,9 @@ static void __init omap3_touchbook_init_irq(void)
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
 	omap_board_config = omap3_touchbook_config;
 	omap_board_config_size = ARRAY_SIZE(omap3_touchbook_config);
-	omap2_init_common_hw(mt46h32m32lf6_sdrc_params,
-			     mt46h32m32lf6_sdrc_params);
+	omap2_init_common_infrastructure();
+	omap2_init_common_devices(mt46h32m32lf6_sdrc_params,
+				  mt46h32m32lf6_sdrc_params);
 	omap_init_irq();
 #ifdef CONFIG_OMAP_32K_TIMER
 	omap2_gp_clockevent_set_gptimer(12);
diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index 1ecd0a6..53ea55e 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -76,7 +76,8 @@ static struct platform_device *panda_devices[] __initdata = {
 
 static void __init omap4_panda_init_irq(void)
 {
-	omap2_init_common_hw(NULL, NULL);
+	omap2_init_common_infrastructure();
+	omap2_init_common_devices(NULL, NULL);
 	gic_init_irq();
 	omap_gpio_init();
 }
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index 7053bc0..03fa2fd 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -413,8 +413,9 @@ static void __init overo_init_irq(void)
 {
 	omap_board_config = overo_config;
 	omap_board_config_size = ARRAY_SIZE(overo_config);
-	omap2_init_common_hw(mt46h32m32lf6_sdrc_params,
-			     mt46h32m32lf6_sdrc_params);
+	omap2_init_common_infrastructure();
+	omap2_init_common_devices(mt46h32m32lf6_sdrc_params,
+				  mt46h32m32lf6_sdrc_params);
 	omap_init_irq();
 	omap_gpio_init();
 }
diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/board-rx51.c
index 36f2cf4..74f1f92 100644
--- a/arch/arm/mach-omap2/board-rx51.c
+++ b/arch/arm/mach-omap2/board-rx51.c
@@ -105,8 +105,9 @@ static void __init rx51_init_irq(void)
 	omap_board_config = rx51_config;
 	omap_board_config_size = ARRAY_SIZE(rx51_config);
 	omap3_pm_init_cpuidle(rx51_cpuidle_params);
+	omap2_init_common_infrastructure();
 	sdrc_params = rx51_get_sdram_timings();
-	omap2_init_common_hw(sdrc_params, sdrc_params);
+	omap2_init_common_devices(sdrc_params, sdrc_params);
 	omap_init_irq();
 	omap_gpio_init();
 }
diff --git a/arch/arm/mach-omap2/board-zoom.c b/arch/arm/mach-omap2/board-zoom.c
index 3da69e4..057638f 100644
--- a/arch/arm/mach-omap2/board-zoom.c
+++ b/arch/arm/mach-omap2/board-zoom.c
@@ -35,12 +35,13 @@
 
 static void __init omap_zoom_init_irq(void)
 {
+	omap2_init_common_infrastructure();
 	if (machine_is_omap_zoom2())
-		omap2_init_common_hw(mt46h32m32lf6_sdrc_params,
-				mt46h32m32lf6_sdrc_params);
+		omap2_init_common_devices(mt46h32m32lf6_sdrc_params,
+					  mt46h32m32lf6_sdrc_params);
 	else if (machine_is_omap_zoom3())
-		omap2_init_common_hw(h8mbx00u0mer0em_sdrc_params,
-				h8mbx00u0mer0em_sdrc_params);
+		omap2_init_common_devices(h8mbx00u0mer0em_sdrc_params,
+					  h8mbx00u0mer0em_sdrc_params);
 
 	omap_init_irq();
 	omap_gpio_init();
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 40562dd..90ce77a 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -311,11 +311,8 @@ static int __init _omap2_init_reprogram_sdrc(void)
 	return v;
 }
 
-void __init omap2_init_common_hw(struct omap_sdrc_params *sdrc_cs0,
-				 struct omap_sdrc_params *sdrc_cs1)
+void __init omap2_init_common_infrastructure(void)
 {
-	u8 skip_setup_idle = 0;
-
 	pwrdm_init(powerdomains_omap);
 	clkdm_init(clockdomains_omap, clkdm_autodeps);
 	if (cpu_is_omap242x())
@@ -340,6 +337,17 @@ void __init omap2_init_common_hw(struct omap_sdrc_params *sdrc_cs0,
 		omap4xxx_clk_init();
 	else
 		pr_err("Could not init clock framework - unknown CPU\n");
+}
+
+/*
+ * XXX Ideally, this function will dwindle into nothingness over time;
+ * almost all device init code should be possible through initcalls
+ * and other generalized mechanisms
+ */
+void __init omap2_init_common_devices(struct omap_sdrc_params *sdrc_cs0,
+				      struct omap_sdrc_params *sdrc_cs1)
+{
+	u8 skip_setup_idle = 0;
 
 	omap_serial_early_init();
 
diff --git a/arch/arm/plat-omap/include/plat/io.h b/arch/arm/plat-omap/include/plat/io.h
index 128b549..f0ad64c 100644
--- a/arch/arm/plat-omap/include/plat/io.h
+++ b/arch/arm/plat-omap/include/plat/io.h
@@ -291,8 +291,9 @@ static inline void omap44xx_map_common_io(void)
 }
 #endif
 
-extern void omap2_init_common_hw(struct omap_sdrc_params *sdrc_cs0,
-				 struct omap_sdrc_params *sdrc_cs1);
+extern void omap2_init_common_infrastructure(void);
+extern void omap2_init_common_devices(struct omap_sdrc_params *sdrc_cs0,
+				      struct omap_sdrc_params *sdrc_cs1);
 
 #define __arch_ioremap(p,s,t)	omap_ioremap(p,s,t)
 #define __arch_iounmap(v)	omap_iounmap(v)


