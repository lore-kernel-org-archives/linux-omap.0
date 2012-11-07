From: Igor Grinberg <grinberg@compulab.co.il>
Subject: [PATCH] ARM: OMAP2+: timer: remove CONFIG_OMAP_32K_TIMER
Date: Wed,  7 Nov 2012 16:42:24 +0200
Message-ID: <1352299344-8011-1-git-send-email-grinberg@compulab.co.il>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:55998 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751719Ab2KGOmi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 7 Nov 2012 09:42:38 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Igor Grinberg <grinberg@compulab.co.il>, Jon Hunter <jon-hunter@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Vaibhav Hiremath <hvaibhav@ti.com>

CONFIG_OMAP_32K_TIMER is kind of standing on the single zImage way.
Make OMAP2+ timer code independant from the CONFIG_OMAP_32K_TIMER
setting.
To remove the dependancy, several conversions/additions had to be done:
1) Timer structures and initialization functions are named by the platform
   name and the clock source in use. The decision which timer is
   used is done statically from the machine_desc structure. In the
   future it should come from DT.
2) Settings under the CONFIG_OMAP_32K_TIMER option are expanded into
   separate timer structures along with the timer init functions.
   This removes the CONFIG_OMAP_32K_TIMER on OMAP2+ timer code.
3) Since we have all the timers defined inside machine_desc structure
   and we no longer need the fallback to gp_timer clock source in case
   32k_timer clock source is unavailable (namely on AM33xx), we no
   longer need the #ifdef around __omap2_sync32k_clocksource_init()
   function. Remove the #ifdef CONFIG_OMAP_32K_TIMER around the
   __omap2_sync32k_clocksource_init() function.

Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
Cc: Jon Hunter <jon-hunter@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Vaibhav Hiremath <hvaibhav@ti.com>
---
Finally I'm sending this out...
I've lost following Tony's branches and deciding which one to base on,
so I used linux-omap/master as a base for the patch.
Tony, tell me if you want it based on some other branch.
This has been compile tested on omap1|2plus_defconfig only.

 arch/arm/mach-omap2/board-2430sdp.c        |    2 +-
 arch/arm/mach-omap2/board-3430sdp.c        |    2 +-
 arch/arm/mach-omap2/board-3630sdp.c        |    2 +-
 arch/arm/mach-omap2/board-4430sdp.c        |    2 +-
 arch/arm/mach-omap2/board-am3517crane.c    |    2 +-
 arch/arm/mach-omap2/board-am3517evm.c      |    2 +-
 arch/arm/mach-omap2/board-apollon.c        |    2 +-
 arch/arm/mach-omap2/board-cm-t35.c         |   18 ++--
 arch/arm/mach-omap2/board-cm-t3517.c       |    2 +-
 arch/arm/mach-omap2/board-devkit8000.c     |    2 +-
 arch/arm/mach-omap2/board-generic.c        |   14 ++--
 arch/arm/mach-omap2/board-h4.c             |    2 +-
 arch/arm/mach-omap2/board-igep0020.c       |    4 +-
 arch/arm/mach-omap2/board-ldp.c            |    2 +-
 arch/arm/mach-omap2/board-n8x0.c           |    6 +-
 arch/arm/mach-omap2/board-omap3beagle.c    |    2 +-
 arch/arm/mach-omap2/board-omap3encore.c    |    2 +-
 arch/arm/mach-omap2/board-omap3evm.c       |    2 +-
 arch/arm/mach-omap2/board-omap3logic.c     |    4 +-
 arch/arm/mach-omap2/board-omap3pandora.c   |    2 +-
 arch/arm/mach-omap2/board-omap3stalker.c   |    2 +-
 arch/arm/mach-omap2/board-omap3touchbook.c |    2 +-
 arch/arm/mach-omap2/board-omap4panda.c     |    2 +-
 arch/arm/mach-omap2/board-omap4pcm049.c    |    2 +-
 arch/arm/mach-omap2/board-overo.c          |    2 +-
 arch/arm/mach-omap2/board-rm680.c          |    4 +-
 arch/arm/mach-omap2/board-rx51.c           |    2 +-
 arch/arm/mach-omap2/board-ti8168evm.c      |    4 +-
 arch/arm/mach-omap2/board-zoom.c           |    4 +-
 arch/arm/mach-omap2/common.h               |   17 ++-
 arch/arm/mach-omap2/timer.c                |  162 ++++++++++++++--------------
 arch/arm/plat-omap/Kconfig                 |    5 +
 32 files changed, 147 insertions(+), 137 deletions(-)

diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index d1c0162..90c1584 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -284,6 +284,6 @@ MACHINE_START(OMAP_2430SDP, "OMAP2430 sdp2430 board")
 	.handle_irq	= omap2_intc_handle_irq,
 	.init_machine	= omap_2430sdp_init,
 	.init_late	= omap2430_init_late,
-	.timer		= &omap2_timer,
+	.timer		= &omap2_sync32k_timer,
 	.restart	= omap_prcm_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 79fd904..e14b355 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -596,6 +596,6 @@ MACHINE_START(OMAP_3430SDP, "OMAP3430 3430SDP board")
 	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= omap_3430sdp_init,
 	.init_late	= omap3430_init_late,
-	.timer		= &omap3_timer,
+	.timer		= &omap3_sync32k_timer,
 	.restart	= omap_prcm_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-3630sdp.c b/arch/arm/mach-omap2/board-3630sdp.c
index 81871b1..030d292 100644
--- a/arch/arm/mach-omap2/board-3630sdp.c
+++ b/arch/arm/mach-omap2/board-3630sdp.c
@@ -211,6 +211,6 @@ MACHINE_START(OMAP_3630SDP, "OMAP 3630SDP board")
 	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= omap_sdp_init,
 	.init_late	= omap3630_init_late,
-	.timer		= &omap3_timer,
+	.timer		= &omap3_sync32k_timer,
 	.restart	= omap_prcm_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index fd80d97..c29e446 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -880,6 +880,6 @@ MACHINE_START(OMAP_4430SDP, "OMAP4430 4430SDP board")
 	.handle_irq	= gic_handle_irq,
 	.init_machine	= omap_4430sdp_init,
 	.init_late	= omap4430_init_late,
-	.timer		= &omap4_timer,
+	.timer		= &omap4_local_sync32k_timer,
 	.restart	= omap_prcm_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-am3517crane.c b/arch/arm/mach-omap2/board-am3517crane.c
index 603503c..db2c007 100644
--- a/arch/arm/mach-omap2/board-am3517crane.c
+++ b/arch/arm/mach-omap2/board-am3517crane.c
@@ -92,6 +92,6 @@ MACHINE_START(CRANEBOARD, "AM3517/05 CRANEBOARD")
 	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= am3517_crane_init,
 	.init_late	= am35xx_init_late,
-	.timer		= &omap3_timer,
+	.timer		= &omap3_sync32k_timer,
 	.restart	= omap_prcm_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index 96d6c5a..8802928 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -392,6 +392,6 @@ MACHINE_START(OMAP3517EVM, "OMAP3517/AM3517 EVM")
 	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= am3517_evm_init,
 	.init_late	= am35xx_init_late,
-	.timer		= &omap3_timer,
+	.timer		= &omap3_sync32k_timer,
 	.restart	= omap_prcm_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-apollon.c b/arch/arm/mach-omap2/board-apollon.c
index 64cf1bd..d7fa83c 100644
--- a/arch/arm/mach-omap2/board-apollon.c
+++ b/arch/arm/mach-omap2/board-apollon.c
@@ -337,6 +337,6 @@ MACHINE_START(OMAP_APOLLON, "OMAP24xx Apollon")
 	.handle_irq	= omap2_intc_handle_irq,
 	.init_machine	= omap_apollon_init,
 	.init_late	= omap2420_init_late,
-	.timer		= &omap2_timer,
+	.timer		= &omap2_sync32k_timer,
 	.restart	= omap_prcm_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index a8cad22..6cfed1a 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -750,19 +750,19 @@ MACHINE_START(CM_T35, "Compulab CM-T35")
 	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= cm_t35_init,
 	.init_late	= omap35xx_init_late,
-	.timer		= &omap3_timer,
+	.timer		= &omap3_sync32k_timer,
 	.restart	= omap_prcm_restart,
 MACHINE_END
 
 MACHINE_START(CM_T3730, "Compulab CM-T3730")
-	.atag_offset    = 0x100,
-	.reserve        = omap_reserve,
-	.map_io         = omap3_map_io,
-	.init_early     = omap3630_init_early,
-	.init_irq       = omap3_init_irq,
+	.atag_offset	= 0x100,
+	.reserve	= omap_reserve,
+	.map_io		= omap3_map_io,
+	.init_early	= omap3630_init_early,
+	.init_irq	= omap3_init_irq,
 	.handle_irq	= omap3_intc_handle_irq,
-	.init_machine   = cm_t3730_init,
-	.init_late     = omap3630_init_late,
-	.timer          = &omap3_timer,
+	.init_machine	= cm_t3730_init,
+	.init_late	= omap3630_init_late,
+	.timer		= &omap3_sync32k_timer,
 	.restart	= omap_prcm_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-cm-t3517.c b/arch/arm/mach-omap2/board-cm-t3517.c
index 2786647..4af5b75 100644
--- a/arch/arm/mach-omap2/board-cm-t3517.c
+++ b/arch/arm/mach-omap2/board-cm-t3517.c
@@ -297,6 +297,6 @@ MACHINE_START(CM_T3517, "Compulab CM-T3517")
 	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= cm_t3517_init,
 	.init_late	= am35xx_init_late,
-	.timer		= &omap3_timer,
+	.timer		= &omap3_sync32k_timer,
 	.restart	= omap_prcm_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 933479e..3b2f5e58 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -642,6 +642,6 @@ MACHINE_START(DEVKIT8000, "OMAP3 Devkit8000")
 	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= devkit8000_init,
 	.init_late	= omap35xx_init_late,
-	.timer		= &omap3_secure_timer,
+	.timer		= &omap3_secure_sync32k_timer,
 	.restart	= omap_prcm_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index d690180..b57f4ac 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -55,7 +55,7 @@ DT_MACHINE_START(OMAP242X_DT, "Generic OMAP2420 (Flattened Device Tree)")
 	.init_irq	= omap_intc_of_init,
 	.handle_irq	= omap2_intc_handle_irq,
 	.init_machine	= omap_generic_init,
-	.timer		= &omap2_timer,
+	.timer		= &omap2_sync32k_timer,
 	.dt_compat	= omap242x_boards_compat,
 	.restart	= omap_prcm_restart,
 MACHINE_END
@@ -74,7 +74,7 @@ DT_MACHINE_START(OMAP243X_DT, "Generic OMAP2430 (Flattened Device Tree)")
 	.init_irq	= omap_intc_of_init,
 	.handle_irq	= omap2_intc_handle_irq,
 	.init_machine	= omap_generic_init,
-	.timer		= &omap2_timer,
+	.timer		= &omap2_sync32k_timer,
 	.dt_compat	= omap243x_boards_compat,
 	.restart	= omap_prcm_restart,
 MACHINE_END
@@ -93,7 +93,7 @@ DT_MACHINE_START(OMAP3_DT, "Generic OMAP3 (Flattened Device Tree)")
 	.init_irq	= omap_intc_of_init,
 	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= omap_generic_init,
-	.timer		= &omap3_timer,
+	.timer		= &omap3_sync32k_timer,
 	.dt_compat	= omap3_boards_compat,
 	.restart	= omap_prcm_restart,
 MACHINE_END
@@ -110,7 +110,7 @@ DT_MACHINE_START(OMAP3_GP_DT, "Generic OMAP3-GP (Flattened Device Tree)")
 	.init_irq	= omap_intc_of_init,
 	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= omap_generic_init,
-	.timer		= &omap3_secure_timer,
+	.timer		= &omap3_secure_sync32k_timer,
 	.dt_compat	= omap3_gp_boards_compat,
 	.restart	= omap_prcm_restart,
 MACHINE_END
@@ -129,7 +129,7 @@ DT_MACHINE_START(AM33XX_DT, "Generic AM33XX (Flattened Device Tree)")
 	.init_irq	= omap_intc_of_init,
 	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= omap_generic_init,
-	.timer		= &omap3_am33xx_timer,
+	.timer		= &omap3_am33xx_gp_timer,
 	.dt_compat	= am33xx_boards_compat,
 MACHINE_END
 #endif
@@ -149,7 +149,7 @@ DT_MACHINE_START(OMAP4_DT, "Generic OMAP4 (Flattened Device Tree)")
 	.handle_irq	= gic_handle_irq,
 	.init_machine	= omap_generic_init,
 	.init_late	= omap4430_init_late,
-	.timer		= &omap4_timer,
+	.timer		= &omap4_local_sync32k_timer,
 	.dt_compat	= omap4_boards_compat,
 	.restart	= omap_prcm_restart,
 MACHINE_END
@@ -169,7 +169,7 @@ DT_MACHINE_START(OMAP5_DT, "Generic OMAP5 (Flattened Device Tree)")
 	.init_irq	= omap_gic_of_init,
 	.handle_irq	= gic_handle_irq,
 	.init_machine	= omap_generic_init,
-	.timer		= &omap5_timer,
+	.timer		= &omap5_realtime_sync32k_timer,
 	.dt_compat	= omap5_boards_compat,
 	.restart	= omap_prcm_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
index 8668c72..cf404f3 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -385,6 +385,6 @@ MACHINE_START(OMAP_H4, "OMAP2420 H4 board")
 	.handle_irq	= omap2_intc_handle_irq,
 	.init_machine	= omap_h4_init,
 	.init_late	= omap2420_init_late,
-	.timer		= &omap2_timer,
+	.timer		= &omap2_sync32k_timer,
 	.restart	= omap_prcm_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index dbc705a..279af3f 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -650,7 +650,7 @@ MACHINE_START(IGEP0020, "IGEP v2 board")
 	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= igep_init,
 	.init_late	= omap35xx_init_late,
-	.timer		= &omap3_timer,
+	.timer		= &omap3_sync32k_timer,
 	.restart	= omap_prcm_restart,
 MACHINE_END
 
@@ -663,6 +663,6 @@ MACHINE_START(IGEP0030, "IGEP OMAP3 module")
 	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= igep_init,
 	.init_late	= omap35xx_init_late,
-	.timer		= &omap3_timer,
+	.timer		= &omap3_sync32k_timer,
 	.restart	= omap_prcm_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index 1164b10..7508f4c 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -435,6 +435,6 @@ MACHINE_START(OMAP_LDP, "OMAP LDP board")
 	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= omap_ldp_init,
 	.init_late	= omap3430_init_late,
-	.timer		= &omap3_timer,
+	.timer		= &omap3_sync32k_timer,
 	.restart	= omap_prcm_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
index 123fda3..49dc3eb 100644
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -731,7 +731,7 @@ MACHINE_START(NOKIA_N800, "Nokia N800")
 	.handle_irq	= omap2_intc_handle_irq,
 	.init_machine	= n8x0_init_machine,
 	.init_late	= omap2420_init_late,
-	.timer		= &omap2_timer,
+	.timer		= &omap2_sync32k_timer,
 	.restart	= omap_prcm_restart,
 MACHINE_END
 
@@ -744,7 +744,7 @@ MACHINE_START(NOKIA_N810, "Nokia N810")
 	.handle_irq	= omap2_intc_handle_irq,
 	.init_machine	= n8x0_init_machine,
 	.init_late	= omap2420_init_late,
-	.timer		= &omap2_timer,
+	.timer		= &omap2_sync32k_timer,
 	.restart	= omap_prcm_restart,
 MACHINE_END
 
@@ -757,6 +757,6 @@ MACHINE_START(NOKIA_N810_WIMAX, "Nokia N810 WiMAX")
 	.handle_irq	= omap2_intc_handle_irq,
 	.init_machine	= n8x0_init_machine,
 	.init_late	= omap2420_init_late,
-	.timer		= &omap2_timer,
+	.timer		= &omap2_sync32k_timer,
 	.restart	= omap_prcm_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 5a3800d..cd6e636 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -544,6 +544,6 @@ MACHINE_START(OMAP3_BEAGLE, "OMAP3 Beagle Board")
 	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= omap3_beagle_init,
 	.init_late	= omap3_init_late,
-	.timer		= &omap3_secure_timer,
+	.timer		= &omap3_secure_sync32k_timer,
 	.restart	= omap_prcm_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-omap3encore.c b/arch/arm/mach-omap2/board-omap3encore.c
index 675c47a..6e92d6a 100644
--- a/arch/arm/mach-omap2/board-omap3encore.c
+++ b/arch/arm/mach-omap2/board-omap3encore.c
@@ -326,5 +326,5 @@ MACHINE_START(ENCORE, "encore")
 	.init_irq	= omap3_init_irq,
 	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= omap_encore_init,
-	.timer		= &omap3_timer,
+	.timer		= &omap3_sync32k_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 3c0b9a9..d72bc7e 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -756,6 +756,6 @@ MACHINE_START(OMAP3EVM, "OMAP3 EVM")
 	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= omap3_evm_init,
 	.init_late	= omap35xx_init_late,
-	.timer		= &omap3_timer,
+	.timer		= &omap3_sync32k_timer,
 	.restart	= omap_prcm_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-omap3logic.c b/arch/arm/mach-omap2/board-omap3logic.c
index e84e2a8..28b5d65 100644
--- a/arch/arm/mach-omap2/board-omap3logic.c
+++ b/arch/arm/mach-omap2/board-omap3logic.c
@@ -231,7 +231,7 @@ MACHINE_START(OMAP3_TORPEDO, "Logic OMAP3 Torpedo board")
 	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= omap3logic_init,
 	.init_late	= omap35xx_init_late,
-	.timer		= &omap3_timer,
+	.timer		= &omap3_sync32k_timer,
 	.restart	= omap_prcm_restart,
 MACHINE_END
 
@@ -244,6 +244,6 @@ MACHINE_START(OMAP3530_LV_SOM, "OMAP Logic 3530 LV SOM board")
 	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= omap3logic_init,
 	.init_late	= omap35xx_init_late,
-	.timer		= &omap3_timer,
+	.timer		= &omap3_sync32k_timer,
 	.restart	= omap_prcm_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index ce31bd3..074d84d 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -618,6 +618,6 @@ MACHINE_START(OMAP3_PANDORA, "Pandora Handheld Console")
 	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= omap3pandora_init,
 	.init_late	= omap35xx_init_late,
-	.timer		= &omap3_timer,
+	.timer		= &omap3_sync32k_timer,
 	.restart	= omap_prcm_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-omap3stalker.c b/arch/arm/mach-omap2/board-omap3stalker.c
index ba11245..9e6c92a 100644
--- a/arch/arm/mach-omap2/board-omap3stalker.c
+++ b/arch/arm/mach-omap2/board-omap3stalker.c
@@ -426,6 +426,6 @@ MACHINE_START(SBC3530, "OMAP3 STALKER")
 	.handle_irq		= omap3_intc_handle_irq,
 	.init_machine		= omap3_stalker_init,
 	.init_late		= omap35xx_init_late,
-	.timer			= &omap3_secure_timer,
+	.timer			= &omap3_secure_sync32k_timer,
 	.restart		= omap_prcm_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-omap3touchbook.c b/arch/arm/mach-omap2/board-omap3touchbook.c
index a225d81..7ae22d4 100644
--- a/arch/arm/mach-omap2/board-omap3touchbook.c
+++ b/arch/arm/mach-omap2/board-omap3touchbook.c
@@ -386,6 +386,6 @@ MACHINE_START(TOUCHBOOK, "OMAP3 touchbook Board")
 	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= omap3_touchbook_init,
 	.init_late	= omap3430_init_late,
-	.timer		= &omap3_secure_timer,
+	.timer		= &omap3_secure_sync32k_timer,
 	.restart	= omap_prcm_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index 8c00b99..02eb646 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -523,6 +523,6 @@ MACHINE_START(OMAP4_PANDA, "OMAP4 Panda board")
 	.handle_irq	= gic_handle_irq,
 	.init_machine	= omap4_panda_init,
 	.init_late	= omap4430_init_late,
-	.timer		= &omap4_timer,
+	.timer		= &omap4_local_sync32k_timer,
 	.restart	= omap_prcm_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-omap4pcm049.c b/arch/arm/mach-omap2/board-omap4pcm049.c
index 47a710e..7f3ffdd 100644
--- a/arch/arm/mach-omap2/board-omap4pcm049.c
+++ b/arch/arm/mach-omap2/board-omap4pcm049.c
@@ -538,5 +538,5 @@ MACHINE_START(PCM049, "phyCORE OMAP4")
 	.init_irq	= gic_init_irq,
 	.handle_irq	= gic_handle_irq,
 	.init_machine	= pcm049_init,
-	.timer		= &omap4_timer,
+	.timer		= &omap4_local_sync32k_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index 1cfb037..864be4c 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -552,6 +552,6 @@ MACHINE_START(OVERO, "Gumstix Overo")
 	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= overo_init,
 	.init_late	= omap35xx_init_late,
-	.timer		= &omap3_timer,
+	.timer		= &omap3_sync32k_timer,
 	.restart	= omap_prcm_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-rm680.c b/arch/arm/mach-omap2/board-rm680.c
index 1997e0e..5514d2e 100644
--- a/arch/arm/mach-omap2/board-rm680.c
+++ b/arch/arm/mach-omap2/board-rm680.c
@@ -147,7 +147,7 @@ MACHINE_START(NOKIA_RM680, "Nokia RM-680 board")
 	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= rm680_init,
 	.init_late	= omap3630_init_late,
-	.timer		= &omap3_timer,
+	.timer		= &omap3_sync32k_timer,
 	.restart	= omap_prcm_restart,
 MACHINE_END
 
@@ -160,6 +160,6 @@ MACHINE_START(NOKIA_RM696, "Nokia RM-696 board")
 	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= rm680_init,
 	.init_late	= omap3630_init_late,
-	.timer		= &omap3_timer,
+	.timer		= &omap3_sync32k_timer,
 	.restart	= omap_prcm_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/board-rx51.c
index c388aec..03ae3f3 100644
--- a/arch/arm/mach-omap2/board-rx51.c
+++ b/arch/arm/mach-omap2/board-rx51.c
@@ -126,6 +126,6 @@ MACHINE_START(NOKIA_RX51, "Nokia RX-51 board")
 	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= rx51_init,
 	.init_late	= omap3430_init_late,
-	.timer		= &omap3_timer,
+	.timer		= &omap3_sync32k_timer,
 	.restart	= omap_prcm_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-ti8168evm.c b/arch/arm/mach-omap2/board-ti8168evm.c
index 5e672c2..9f03177 100644
--- a/arch/arm/mach-omap2/board-ti8168evm.c
+++ b/arch/arm/mach-omap2/board-ti8168evm.c
@@ -43,7 +43,7 @@ MACHINE_START(TI8168EVM, "ti8168evm")
 	.map_io		= ti81xx_map_io,
 	.init_early	= ti81xx_init_early,
 	.init_irq	= ti81xx_init_irq,
-	.timer		= &omap3_timer,
+	.timer		= &omap3_sync32k_timer,
 	.init_machine	= ti81xx_evm_init,
 	.init_late	= ti81xx_init_late,
 	.restart	= omap_prcm_restart,
@@ -55,7 +55,7 @@ MACHINE_START(TI8148EVM, "ti8148evm")
 	.map_io		= ti81xx_map_io,
 	.init_early	= ti81xx_init_early,
 	.init_irq	= ti81xx_init_irq,
-	.timer		= &omap3_timer,
+	.timer		= &omap3_sync32k_timer,
 	.init_machine	= ti81xx_evm_init,
 	.init_late	= ti81xx_init_late,
 	.restart	= omap_prcm_restart,
diff --git a/arch/arm/mach-omap2/board-zoom.c b/arch/arm/mach-omap2/board-zoom.c
index 8feb4d9..b906430 100644
--- a/arch/arm/mach-omap2/board-zoom.c
+++ b/arch/arm/mach-omap2/board-zoom.c
@@ -137,7 +137,7 @@ MACHINE_START(OMAP_ZOOM2, "OMAP Zoom2 board")
 	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= omap_zoom_init,
 	.init_late	= omap3430_init_late,
-	.timer		= &omap3_timer,
+	.timer		= &omap3_sync32k_timer,
 	.restart	= omap_prcm_restart,
 MACHINE_END
 
@@ -150,6 +150,6 @@ MACHINE_START(OMAP_ZOOM3, "OMAP Zoom3 board")
 	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= omap_zoom_init,
 	.init_late	= omap3630_init_late,
-	.timer		= &omap3_timer,
+	.timer		= &omap3_sync32k_timer,
 	.restart	= omap_prcm_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index fd97f31..153aa39 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -135,12 +135,17 @@ static inline void omap5_map_common_io(void)
 
 extern void omap2_init_common_infrastructure(void);
 
-extern struct sys_timer omap2_timer;
-extern struct sys_timer omap3_timer;
-extern struct sys_timer omap3_secure_timer;
-extern struct sys_timer omap3_am33xx_timer;
-extern struct sys_timer omap4_timer;
-extern struct sys_timer omap5_timer;
+extern struct sys_timer omap2_sync32k_timer;
+extern struct sys_timer omap2_gp_timer;
+extern struct sys_timer omap3_sync32k_timer;
+extern struct sys_timer omap3_gp_timer;
+extern struct sys_timer omap3_secure_sync32k_timer;
+extern struct sys_timer omap3_secure_gp_timer;
+extern struct sys_timer omap3_am33xx_gp_timer;
+extern struct sys_timer omap4_local_sync32k_timer;
+extern struct sys_timer omap4_local_gp_timer;
+extern struct sys_timer omap5_realtime_sync32k_timer;
+extern struct sys_timer omap5_realtime_gp_timer;
 
 void omap2420_init_early(void);
 void omap2430_init_early(void);
diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 684d2fc..a4ad7a0 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -63,20 +63,8 @@
 #define OMAP2_32K_SOURCE	"func_32k_ck"
 #define OMAP3_32K_SOURCE	"omap_32k_fck"
 #define OMAP4_32K_SOURCE	"sys_32k_ck"
-
-#ifdef CONFIG_OMAP_32K_TIMER
-#define OMAP2_CLKEV_SOURCE	OMAP2_32K_SOURCE
-#define OMAP3_CLKEV_SOURCE	OMAP3_32K_SOURCE
-#define OMAP4_CLKEV_SOURCE	OMAP4_32K_SOURCE
-#define OMAP3_SECURE_TIMER	12
 #define TIMER_PROP_SECURE	"ti,timer-secure"
-#else
-#define OMAP2_CLKEV_SOURCE	OMAP2_MPU_SOURCE
-#define OMAP3_CLKEV_SOURCE	OMAP3_MPU_SOURCE
-#define OMAP4_CLKEV_SOURCE	OMAP4_MPU_SOURCE
-#define OMAP3_SECURE_TIMER	1
-#define TIMER_PROP_SECURE	"ti,timer-alwon"
-#endif
+#define TIMER_PROP_ALWON	"ti,timer-alwon"
 
 #define REALTIME_COUNTER_BASE				0x48243200
 #define INCREMENTER_NUMERATOR_OFFSET			0x10
@@ -216,7 +204,7 @@ void __init omap_dmtimer_init(void)
 
 	/* If we are a secure device, remove any secure timer nodes */
 	if ((omap_type() != OMAP2_DEVICE_TYPE_GP)) {
-		np = omap_get_timer_dt(omap_timer_match, "ti,timer-secure");
+		np = omap_get_timer_dt(omap_timer_match, TIMER_PROP_SECURE);
 		if (np)
 			of_node_put(np);
 	}
@@ -378,9 +366,8 @@ static u32 notrace dmtimer_read_sched_clock(void)
 	return 0;
 }
 
-#ifdef CONFIG_OMAP_32K_TIMER
 /* Setup free-running counter for clocksource */
-static int __init omap2_sync32k_clocksource_init(void)
+static int __init __omap2_sync32k_clocksource_init(void)
 {
 	int ret;
 	struct device_node *np = NULL;
@@ -439,15 +426,9 @@ static int __init omap2_sync32k_clocksource_init(void)
 
 	return ret;
 }
-#else
-static inline int omap2_sync32k_clocksource_init(void)
-{
-	return -ENODEV;
-}
-#endif
 
-static void __init omap2_gptimer_clocksource_init(int gptimer_id,
-						const char *fck_source)
+static void __init omap2_gp_clocksource_init(int gptimer_id,
+					     const char *fck_source)
 {
 	int res;
 
@@ -466,23 +447,10 @@ static void __init omap2_gptimer_clocksource_init(int gptimer_id,
 			gptimer_id, clksrc.rate);
 }
 
-static void __init omap2_clocksource_init(int gptimer_id,
-						const char *fck_source)
+static void __init omap2_sync32k_clocksource_init(int gptimer_id,
+						  const char *fck_source)
 {
-	/*
-	 * First give preference to kernel parameter configuration
-	 * by user (clocksource="gp_timer").
-	 *
-	 * In case of missing kernel parameter for clocksource,
-	 * first check for availability for 32k-sync timer, in case
-	 * of failure in finding 32k_counter module or registering
-	 * it as clocksource, execution will fallback to gp-timer.
-	 */
-	if (use_gptimer_clksrc == true)
-		omap2_gptimer_clocksource_init(gptimer_id, fck_source);
-	else if (omap2_sync32k_clocksource_init())
-		/* Fall back to gp-timer code */
-		omap2_gptimer_clocksource_init(gptimer_id, fck_source);
+	__omap2_sync32k_clocksource_init();
 }
 
 #ifdef CONFIG_SOC_HAS_REALTIME_COUNTER
@@ -563,52 +531,64 @@ static inline void __init realtime_counter_init(void)
 {}
 #endif
 
-#define OMAP_SYS_TIMER_INIT(name, clkev_nr, clkev_src, clkev_prop,	\
-				clksrc_nr, clksrc_src)			\
-static void __init omap##name##_timer_init(void)			\
+#define OMAP_SYS_TIMER_INIT(n, clksrc_name, clkev_nr, clkev_src,	\
+				clkev_prop, clksrc_nr, clksrc_src)	\
+static void __init omap##n##_##clksrc_name##_timer_init(void)		\
 {									\
 	omap_dmtimer_init();						\
 	omap2_gp_clockevent_init((clkev_nr), clkev_src, clkev_prop);	\
-	omap2_clocksource_init((clksrc_nr), clksrc_src);		\
+									\
+	if (use_gptimer_clksrc)						\
+		omap2_gp_clocksource_init((clksrc_nr), clksrc_src);	\
+	else								\
+		omap2_##clksrc_name##_clocksource_init((clksrc_nr),	\
+						       clksrc_src);	\
 }
 
-#define OMAP_SYS_TIMER(name)						\
-struct sys_timer omap##name##_timer = {					\
-	.init	= omap##name##_timer_init,				\
-};
+#define OMAP_SYS_TIMER(n, clksrc)					\
+struct sys_timer omap##n##_##clksrc##_timer = {				\
+	.init	= omap##n##_##clksrc##_timer_init,			\
+}
 
 #ifdef CONFIG_ARCH_OMAP2
-OMAP_SYS_TIMER_INIT(2, 1, OMAP2_CLKEV_SOURCE, "ti,timer-alwon",
-		    2, OMAP2_MPU_SOURCE)
-OMAP_SYS_TIMER(2)
+OMAP_SYS_TIMER_INIT(2, sync32k, 1, OMAP2_32K_SOURCE, TIMER_PROP_ALWON,
+		    2, OMAP2_MPU_SOURCE);
+OMAP_SYS_TIMER(2, sync32k);
+OMAP_SYS_TIMER_INIT(2, gp, 1, OMAP2_MPU_SOURCE, TIMER_PROP_ALWON,
+		    2, OMAP2_MPU_SOURCE);
+OMAP_SYS_TIMER(2, gp);
 #endif
 
 #ifdef CONFIG_ARCH_OMAP3
-OMAP_SYS_TIMER_INIT(3, 1, OMAP3_CLKEV_SOURCE, "ti,timer-alwon",
-		    2, OMAP3_MPU_SOURCE)
-OMAP_SYS_TIMER(3)
-OMAP_SYS_TIMER_INIT(3_secure, OMAP3_SECURE_TIMER, OMAP3_CLKEV_SOURCE,
-			TIMER_PROP_SECURE, 2, OMAP3_MPU_SOURCE)
-OMAP_SYS_TIMER(3_secure)
+OMAP_SYS_TIMER_INIT(3, sync32k, 1, OMAP3_32K_SOURCE, TIMER_PROP_ALWON,
+		    2, OMAP3_MPU_SOURCE);
+OMAP_SYS_TIMER(3, sync32k);
+OMAP_SYS_TIMER_INIT(3, gp, 1, OMAP3_MPU_SOURCE, TIMER_PROP_ALWON,
+		    2, OMAP3_MPU_SOURCE);
+OMAP_SYS_TIMER(3, gp);
+OMAP_SYS_TIMER_INIT(3_secure, sync32k, 12, OMAP3_32K_SOURCE, TIMER_PROP_SECURE,
+		    2, OMAP3_MPU_SOURCE);
+OMAP_SYS_TIMER(3_secure, sync32k);
+OMAP_SYS_TIMER_INIT(3_secure, gp, 1, OMAP3_MPU_SOURCE, TIMER_PROP_ALWON,
+		    2, OMAP3_MPU_SOURCE);
+OMAP_SYS_TIMER(3_secure, gp);
 #endif
 
 #ifdef CONFIG_SOC_AM33XX
-OMAP_SYS_TIMER_INIT(3_am33xx, 1, OMAP4_MPU_SOURCE, "ti,timer-alwon",
-		    2, OMAP4_MPU_SOURCE)
-OMAP_SYS_TIMER(3_am33xx)
+OMAP_SYS_TIMER_INIT(3_am33xx, gp, 1, OMAP4_MPU_SOURCE, TIMER_PROP_ALWON,
+		    2, OMAP4_MPU_SOURCE);
+OMAP_SYS_TIMER(3_am33xx, gp);
 #endif
 
 #ifdef CONFIG_ARCH_OMAP4
+OMAP_SYS_TIMER_INIT(4, sync32k, 1, OMAP4_32K_SOURCE, TIMER_PROP_ALWON,
+		    2, OMAP4_MPU_SOURCE);
+OMAP_SYS_TIMER_INIT(4, gp, 1, OMAP4_MPU_SOURCE, TIMER_PROP_ALWON,
+		    2, OMAP4_MPU_SOURCE);
 #ifdef CONFIG_LOCAL_TIMERS
-static DEFINE_TWD_LOCAL_TIMER(twd_local_timer,
-			      OMAP44XX_LOCAL_TWD_BASE, 29);
-#endif
-
-static void __init omap4_timer_init(void)
+static DEFINE_TWD_LOCAL_TIMER(twd_local_timer, OMAP44XX_LOCAL_TWD_BASE, 29);
+static void __init omap4_local_timer_init(void)
 {
-	omap2_gp_clockevent_init(1, OMAP4_CLKEV_SOURCE, "ti,timer-alwon");
-	omap2_clocksource_init(2, OMAP4_MPU_SOURCE);
-#ifdef CONFIG_LOCAL_TIMERS
 	/* Local timers are not supprted on OMAP4430 ES1.0 */
 	if (omap_rev() != OMAP4430_REV_ES1_0) {
 		int err;
@@ -622,25 +602,45 @@ static void __init omap4_timer_init(void)
 		if (err)
 			pr_err("twd_local_timer_register failed %d\n", err);
 	}
+}
+#else
+static inline void omap4_local_timer_init(void) {}
 #endif
+
+#define OMAP4_LOCAL_TIMER_INIT(clksrc_name)				\
+static void __init omap4_local_##clksrc_name##_timer_init(void)		\
+{									\
+	omap4_##clksrc_name##_timer_init();				\
+	omap4_local_timer_init();					\
 }
-OMAP_SYS_TIMER(4)
+OMAP4_LOCAL_TIMER_INIT(sync32k);
+OMAP_SYS_TIMER(4_local, sync32k);
+OMAP4_LOCAL_TIMER_INIT(gp);
+OMAP_SYS_TIMER(4_local, gp);
 #endif
 
 #ifdef CONFIG_SOC_OMAP5
-static void __init omap5_timer_init(void)
-{
-	int err;
-
-	omap2_gp_clockevent_init(1, OMAP4_CLKEV_SOURCE, "ti,timer-alwon");
-	omap2_clocksource_init(2, OMAP4_MPU_SOURCE);
-	realtime_counter_init();
-
-	err = arch_timer_of_register();
-	if (err)
-		pr_err("%s: arch_timer_register failed %d\n", __func__, err);
+OMAP_SYS_TIMER_INIT(5, sync32k, 1, OMAP4_32K_SOURCE, TIMER_PROP_ALWON,
+		    2, OMAP4_MPU_SOURCE);
+OMAP_SYS_TIMER_INIT(5, gp, 1, OMAP4_MPU_SOURCE, TIMER_PROP_ALWON,
+		    2, OMAP4_MPU_SOURCE);
+#define OMAP5_REALTIME_TIMER_INIT(clksrc_name)				\
+static void __init omap5_realtime_##clksrc_name##_timer_init(void)	\
+{									\
+	int err;							\
+									\
+	omap5_##clksrc_name##_timer_init();				\
+	realtime_counter_init();					\
+									\
+	err = arch_timer_of_register();					\
+	if (err)							\
+		pr_err("%s: arch_timer_register failed %d\n",		\
+			__func__, err);					\
 }
-OMAP_SYS_TIMER(5)
+OMAP5_REALTIME_TIMER_INIT(sync32k);
+OMAP_SYS_TIMER(5_realtime, sync32k);
+OMAP5_REALTIME_TIMER_INIT(gp);
+OMAP_SYS_TIMER(5_realtime, gp);
 #endif
 
 /**
diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index 82fcb20..9b36a2ad 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -154,6 +154,11 @@ config OMAP_32K_TIMER
 	  intra-tick resolution than OMAP_MPU_TIMER. The 32KHz timer is
 	  currently only available for OMAP16XX, 24XX, 34XX and OMAP4/5.
 
+	  On OMAP2PLUS this value is only used for CONFIG_HZ and
+	  CLOCK_TICK_RATE compile time calculation.
+	  The actual timer selection is done in the in the board file
+	  through (DT_)MACHINE_START structure.
+
 config OMAP3_L2_AUX_SECURE_SAVE_RESTORE
 	bool "OMAP3 HS/EMU save and restore for L2 AUX control register"
 	depends on ARCH_OMAP3 && PM
-- 
1.7.3.4

