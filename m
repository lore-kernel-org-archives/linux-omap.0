From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 06/13] ARM: OMAP2+: board files: use SoC-specific system
 restart functions
Date: Thu, 25 Oct 2012 17:21:17 -0600
Message-ID: <20121025232116.17558.72650.stgit@dusk.lan>
References: <20121025231818.17558.57884.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:38287 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750853Ab2JYXYE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Oct 2012 19:24:04 -0400
In-Reply-To: <20121025231818.17558.57884.stgit@dusk.lan>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Modify the board files to use the SoC-specific system restart
functions.  At this point it's possible to remove omap_prcm_restart()
from mach-omap2/prcm.c.

While removing the prototypes for the now-unused restart functions, clean
up a few more obsolete prototypes in mach-omap2/clock.h.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/board-2430sdp.c        |    2 +
 arch/arm/mach-omap2/board-3430sdp.c        |    2 +
 arch/arm/mach-omap2/board-3630sdp.c        |    2 +
 arch/arm/mach-omap2/board-4430sdp.c        |    2 +
 arch/arm/mach-omap2/board-am3517crane.c    |    2 +
 arch/arm/mach-omap2/board-am3517evm.c      |    2 +
 arch/arm/mach-omap2/board-apollon.c        |    2 +
 arch/arm/mach-omap2/board-cm-t35.c         |   18 +++++-----
 arch/arm/mach-omap2/board-cm-t3517.c       |    2 +
 arch/arm/mach-omap2/board-devkit8000.c     |    2 +
 arch/arm/mach-omap2/board-generic.c        |   10 +++--
 arch/arm/mach-omap2/board-h4.c             |    2 +
 arch/arm/mach-omap2/board-igep0020.c       |    4 +-
 arch/arm/mach-omap2/board-ldp.c            |    2 +
 arch/arm/mach-omap2/board-n8x0.c           |    6 ++-
 arch/arm/mach-omap2/board-omap3beagle.c    |    2 +
 arch/arm/mach-omap2/board-omap3evm.c       |    2 +
 arch/arm/mach-omap2/board-omap3logic.c     |    4 +-
 arch/arm/mach-omap2/board-omap3pandora.c   |    2 +
 arch/arm/mach-omap2/board-omap3stalker.c   |    2 +
 arch/arm/mach-omap2/board-omap3touchbook.c |    2 +
 arch/arm/mach-omap2/board-omap4panda.c     |    2 +
 arch/arm/mach-omap2/board-overo.c          |    2 +
 arch/arm/mach-omap2/board-rm680.c          |    4 +-
 arch/arm/mach-omap2/board-rx51.c           |    2 +
 arch/arm/mach-omap2/board-ti8168evm.c      |    4 +-
 arch/arm/mach-omap2/board-zoom.c           |    4 +-
 arch/arm/mach-omap2/clock.h                |   28 ---------------
 arch/arm/mach-omap2/clock2420_data.c       |    4 --
 arch/arm/mach-omap2/clock2430_data.c       |    4 --
 arch/arm/mach-omap2/clock2xxx.c            |   16 ---------
 arch/arm/mach-omap2/common.h               |    1 -
 arch/arm/mach-omap2/prcm.c                 |   52 ----------------------------
 33 files changed, 46 insertions(+), 151 deletions(-)

diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index 95b384d..abfcf6a 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -287,5 +287,5 @@ MACHINE_START(OMAP_2430SDP, "OMAP2430 sdp2430 board")
 	.init_machine	= omap_2430sdp_init,
 	.init_late	= omap2430_init_late,
 	.timer		= &omap2_timer,
-	.restart	= omap_prcm_restart,
+	.restart	= omap2xxx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 96cd369..497a7ac 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -597,5 +597,5 @@ MACHINE_START(OMAP_3430SDP, "OMAP3430 3430SDP board")
 	.init_machine	= omap_3430sdp_init,
 	.init_late	= omap3430_init_late,
 	.timer		= &omap3_timer,
-	.restart	= omap_prcm_restart,
+	.restart	= omap3xxx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-3630sdp.c b/arch/arm/mach-omap2/board-3630sdp.c
index fc224ad..3ffcc15 100644
--- a/arch/arm/mach-omap2/board-3630sdp.c
+++ b/arch/arm/mach-omap2/board-3630sdp.c
@@ -213,5 +213,5 @@ MACHINE_START(OMAP_3630SDP, "OMAP 3630SDP board")
 	.init_machine	= omap_sdp_init,
 	.init_late	= omap3630_init_late,
 	.timer		= &omap3_timer,
-	.restart	= omap_prcm_restart,
+	.restart	= omap3xxx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 3669c12..e26b6e4 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -881,5 +881,5 @@ MACHINE_START(OMAP_4430SDP, "OMAP4430 4430SDP board")
 	.init_machine	= omap_4430sdp_init,
 	.init_late	= omap4430_init_late,
 	.timer		= &omap4_timer,
-	.restart	= omap_prcm_restart,
+	.restart	= omap44xx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-am3517crane.c b/arch/arm/mach-omap2/board-am3517crane.c
index 318fead..9c52315 100644
--- a/arch/arm/mach-omap2/board-am3517crane.c
+++ b/arch/arm/mach-omap2/board-am3517crane.c
@@ -94,5 +94,5 @@ MACHINE_START(CRANEBOARD, "AM3517/05 CRANEBOARD")
 	.init_machine	= am3517_crane_init,
 	.init_late	= am35xx_init_late,
 	.timer		= &omap3_timer,
-	.restart	= omap_prcm_restart,
+	.restart	= omap3xxx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index e162897..24192aaa7 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -393,5 +393,5 @@ MACHINE_START(OMAP3517EVM, "OMAP3517/AM3517 EVM")
 	.init_machine	= am3517_evm_init,
 	.init_late	= am35xx_init_late,
 	.timer		= &omap3_timer,
-	.restart	= omap_prcm_restart,
+	.restart	= omap3xxx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-apollon.c b/arch/arm/mach-omap2/board-apollon.c
index cea3aba..e753792 100644
--- a/arch/arm/mach-omap2/board-apollon.c
+++ b/arch/arm/mach-omap2/board-apollon.c
@@ -338,5 +338,5 @@ MACHINE_START(OMAP_APOLLON, "OMAP24xx Apollon")
 	.init_machine	= omap_apollon_init,
 	.init_late	= omap2420_init_late,
 	.timer		= &omap2_timer,
-	.restart	= omap_prcm_restart,
+	.restart	= omap2xxx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index 376d26e..03bc0b5 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -753,18 +753,18 @@ MACHINE_START(CM_T35, "Compulab CM-T35")
 	.init_machine	= cm_t35_init,
 	.init_late	= omap35xx_init_late,
 	.timer		= &omap3_timer,
-	.restart	= omap_prcm_restart,
+	.restart	= omap3xxx_restart,
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
+	.init_machine	= cm_t3730_init,
 	.init_late     = omap3630_init_late,
-	.timer          = &omap3_timer,
-	.restart	= omap_prcm_restart,
+	.timer		= &omap3_timer,
+	.restart	= omap3xxx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-cm-t3517.c b/arch/arm/mach-omap2/board-cm-t3517.c
index 59c0a45..87202ad 100644
--- a/arch/arm/mach-omap2/board-cm-t3517.c
+++ b/arch/arm/mach-omap2/board-cm-t3517.c
@@ -298,5 +298,5 @@ MACHINE_START(CM_T3517, "Compulab CM-T3517")
 	.init_machine	= cm_t3517_init,
 	.init_late	= am35xx_init_late,
 	.timer		= &omap3_timer,
-	.restart	= omap_prcm_restart,
+	.restart	= omap3xxx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 1fd161e..74099e6 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -640,5 +640,5 @@ MACHINE_START(DEVKIT8000, "OMAP3 Devkit8000")
 	.init_machine	= devkit8000_init,
 	.init_late	= omap35xx_init_late,
 	.timer		= &omap3_secure_timer,
-	.restart	= omap_prcm_restart,
+	.restart	= omap3xxx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index 601ecdf..475e14f 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -57,7 +57,7 @@ DT_MACHINE_START(OMAP242X_DT, "Generic OMAP2420 (Flattened Device Tree)")
 	.init_machine	= omap_generic_init,
 	.timer		= &omap2_timer,
 	.dt_compat	= omap242x_boards_compat,
-	.restart	= omap_prcm_restart,
+	.restart	= omap2xxx_restart,
 MACHINE_END
 #endif
 
@@ -76,7 +76,7 @@ DT_MACHINE_START(OMAP243X_DT, "Generic OMAP2430 (Flattened Device Tree)")
 	.init_machine	= omap_generic_init,
 	.timer		= &omap2_timer,
 	.dt_compat	= omap243x_boards_compat,
-	.restart	= omap_prcm_restart,
+	.restart	= omap2xxx_restart,
 MACHINE_END
 #endif
 
@@ -95,7 +95,7 @@ DT_MACHINE_START(OMAP3_DT, "Generic OMAP3 (Flattened Device Tree)")
 	.init_machine	= omap_generic_init,
 	.timer		= &omap3_timer,
 	.dt_compat	= omap3_boards_compat,
-	.restart	= omap_prcm_restart,
+	.restart	= omap3xxx_restart,
 MACHINE_END
 #endif
 
@@ -134,7 +134,7 @@ DT_MACHINE_START(OMAP4_DT, "Generic OMAP4 (Flattened Device Tree)")
 	.init_late	= omap4430_init_late,
 	.timer		= &omap4_timer,
 	.dt_compat	= omap4_boards_compat,
-	.restart	= omap_prcm_restart,
+	.restart	= omap44xx_restart,
 MACHINE_END
 #endif
 
@@ -154,6 +154,6 @@ DT_MACHINE_START(OMAP5_DT, "Generic OMAP5 (Flattened Device Tree)")
 	.init_machine	= omap_generic_init,
 	.timer		= &omap5_timer,
 	.dt_compat	= omap5_boards_compat,
-	.restart	= omap_prcm_restart,
+	.restart	= omap44xx_restart,
 MACHINE_END
 #endif
diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
index 8d04bf8..a65942e 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -386,5 +386,5 @@ MACHINE_START(OMAP_H4, "OMAP2420 H4 board")
 	.init_machine	= omap_h4_init,
 	.init_late	= omap2420_init_late,
 	.timer		= &omap2_timer,
-	.restart	= omap_prcm_restart,
+	.restart	= omap2xxx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index 48d5e41..8734c0d 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -652,7 +652,7 @@ MACHINE_START(IGEP0020, "IGEP v2 board")
 	.init_machine	= igep_init,
 	.init_late	= omap35xx_init_late,
 	.timer		= &omap3_timer,
-	.restart	= omap_prcm_restart,
+	.restart	= omap3xxx_restart,
 MACHINE_END
 
 MACHINE_START(IGEP0030, "IGEP OMAP3 module")
@@ -665,5 +665,5 @@ MACHINE_START(IGEP0030, "IGEP OMAP3 module")
 	.init_machine	= igep_init,
 	.init_late	= omap35xx_init_late,
 	.timer		= &omap3_timer,
-	.restart	= omap_prcm_restart,
+	.restart	= omap3xxx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index ee8c3cf..6d2892c 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -437,5 +437,5 @@ MACHINE_START(OMAP_LDP, "OMAP LDP board")
 	.init_machine	= omap_ldp_init,
 	.init_late	= omap3430_init_late,
 	.timer		= &omap3_timer,
-	.restart	= omap_prcm_restart,
+	.restart	= omap3xxx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
index d95f727..dd71764 100644
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -689,7 +689,7 @@ MACHINE_START(NOKIA_N800, "Nokia N800")
 	.init_machine	= n8x0_init_machine,
 	.init_late	= omap2420_init_late,
 	.timer		= &omap2_timer,
-	.restart	= omap_prcm_restart,
+	.restart	= omap2xxx_restart,
 MACHINE_END
 
 MACHINE_START(NOKIA_N810, "Nokia N810")
@@ -702,7 +702,7 @@ MACHINE_START(NOKIA_N810, "Nokia N810")
 	.init_machine	= n8x0_init_machine,
 	.init_late	= omap2420_init_late,
 	.timer		= &omap2_timer,
-	.restart	= omap_prcm_restart,
+	.restart	= omap2xxx_restart,
 MACHINE_END
 
 MACHINE_START(NOKIA_N810_WIMAX, "Nokia N810 WiMAX")
@@ -715,5 +715,5 @@ MACHINE_START(NOKIA_N810_WIMAX, "Nokia N810 WiMAX")
 	.init_machine	= n8x0_init_machine,
 	.init_late	= omap2420_init_late,
 	.timer		= &omap2_timer,
-	.restart	= omap_prcm_restart,
+	.restart	= omap2xxx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 388c431..42e8bdd 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -537,5 +537,5 @@ MACHINE_START(OMAP3_BEAGLE, "OMAP3 Beagle Board")
 	.init_machine	= omap3_beagle_init,
 	.init_late	= omap3_init_late,
 	.timer		= &omap3_secure_timer,
-	.restart	= omap_prcm_restart,
+	.restart	= omap3xxx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index b9b776b..8a3cc9d 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -752,5 +752,5 @@ MACHINE_START(OMAP3EVM, "OMAP3 EVM")
 	.init_machine	= omap3_evm_init,
 	.init_late	= omap35xx_init_late,
 	.timer		= &omap3_timer,
-	.restart	= omap_prcm_restart,
+	.restart	= omap3xxx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-omap3logic.c b/arch/arm/mach-omap2/board-omap3logic.c
index 7bd8253..5eed5db 100644
--- a/arch/arm/mach-omap2/board-omap3logic.c
+++ b/arch/arm/mach-omap2/board-omap3logic.c
@@ -235,7 +235,7 @@ MACHINE_START(OMAP3_TORPEDO, "Logic OMAP3 Torpedo board")
 	.init_machine	= omap3logic_init,
 	.init_late	= omap35xx_init_late,
 	.timer		= &omap3_timer,
-	.restart	= omap_prcm_restart,
+	.restart	= omap3xxx_restart,
 MACHINE_END
 
 MACHINE_START(OMAP3530_LV_SOM, "OMAP Logic 3530 LV SOM board")
@@ -248,5 +248,5 @@ MACHINE_START(OMAP3530_LV_SOM, "OMAP Logic 3530 LV SOM board")
 	.init_machine	= omap3logic_init,
 	.init_late	= omap35xx_init_late,
 	.timer		= &omap3_timer,
-	.restart	= omap_prcm_restart,
+	.restart	= omap3xxx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index 00a1f4a..23bf060 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -619,5 +619,5 @@ MACHINE_START(OMAP3_PANDORA, "Pandora Handheld Console")
 	.init_machine	= omap3pandora_init,
 	.init_late	= omap35xx_init_late,
 	.timer		= &omap3_timer,
-	.restart	= omap_prcm_restart,
+	.restart	= omap3xxx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-omap3stalker.c b/arch/arm/mach-omap2/board-omap3stalker.c
index 731235e..4d65d7e 100644
--- a/arch/arm/mach-omap2/board-omap3stalker.c
+++ b/arch/arm/mach-omap2/board-omap3stalker.c
@@ -428,5 +428,5 @@ MACHINE_START(SBC3530, "OMAP3 STALKER")
 	.init_machine		= omap3_stalker_init,
 	.init_late		= omap35xx_init_late,
 	.timer			= &omap3_secure_timer,
-	.restart		= omap_prcm_restart,
+	.restart		= omap3xxx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-omap3touchbook.c b/arch/arm/mach-omap2/board-omap3touchbook.c
index 944ffc4..efcb46f 100644
--- a/arch/arm/mach-omap2/board-omap3touchbook.c
+++ b/arch/arm/mach-omap2/board-omap3touchbook.c
@@ -384,5 +384,5 @@ MACHINE_START(TOUCHBOOK, "OMAP3 touchbook Board")
 	.init_machine	= omap3_touchbook_init,
 	.init_late	= omap3430_init_late,
 	.timer		= &omap3_secure_timer,
-	.restart	= omap_prcm_restart,
+	.restart	= omap3xxx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index bfcd397..c5131d1 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -524,5 +524,5 @@ MACHINE_START(OMAP4_PANDA, "OMAP4 Panda board")
 	.init_machine	= omap4_panda_init,
 	.init_late	= omap4430_init_late,
 	.timer		= &omap4_timer,
-	.restart	= omap_prcm_restart,
+	.restart	= omap44xx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index b700685..fcd5147 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -550,5 +550,5 @@ MACHINE_START(OVERO, "Gumstix Overo")
 	.init_machine	= overo_init,
 	.init_late	= omap35xx_init_late,
 	.timer		= &omap3_timer,
-	.restart	= omap_prcm_restart,
+	.restart	= omap3xxx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-rm680.c b/arch/arm/mach-omap2/board-rm680.c
index 45997bf..5074879 100644
--- a/arch/arm/mach-omap2/board-rm680.c
+++ b/arch/arm/mach-omap2/board-rm680.c
@@ -151,7 +151,7 @@ MACHINE_START(NOKIA_RM680, "Nokia RM-680 board")
 	.init_machine	= rm680_init,
 	.init_late	= omap3630_init_late,
 	.timer		= &omap3_timer,
-	.restart	= omap_prcm_restart,
+	.restart	= omap3xxx_restart,
 MACHINE_END
 
 MACHINE_START(NOKIA_RM696, "Nokia RM-696 board")
@@ -164,5 +164,5 @@ MACHINE_START(NOKIA_RM696, "Nokia RM-696 board")
 	.init_machine	= rm680_init,
 	.init_late	= omap3630_init_late,
 	.timer		= &omap3_timer,
-	.restart	= omap_prcm_restart,
+	.restart	= omap3xxx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/board-rx51.c
index 7bbb05d..237f98b 100644
--- a/arch/arm/mach-omap2/board-rx51.c
+++ b/arch/arm/mach-omap2/board-rx51.c
@@ -127,5 +127,5 @@ MACHINE_START(NOKIA_RX51, "Nokia RX-51 board")
 	.init_machine	= rx51_init,
 	.init_late	= omap3430_init_late,
 	.timer		= &omap3_timer,
-	.restart	= omap_prcm_restart,
+	.restart	= omap3xxx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-ti8168evm.c b/arch/arm/mach-omap2/board-ti8168evm.c
index c4f8833..4385fbb 100644
--- a/arch/arm/mach-omap2/board-ti8168evm.c
+++ b/arch/arm/mach-omap2/board-ti8168evm.c
@@ -45,7 +45,7 @@ MACHINE_START(TI8168EVM, "ti8168evm")
 	.timer		= &omap3_timer,
 	.init_machine	= ti81xx_evm_init,
 	.init_late	= ti81xx_init_late,
-	.restart	= omap_prcm_restart,
+	.restart	= omap44xx_restart,
 MACHINE_END
 
 MACHINE_START(TI8148EVM, "ti8148evm")
@@ -57,5 +57,5 @@ MACHINE_START(TI8148EVM, "ti8148evm")
 	.timer		= &omap3_timer,
 	.init_machine	= ti81xx_evm_init,
 	.init_late	= ti81xx_init_late,
-	.restart	= omap_prcm_restart,
+	.restart	= omap44xx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-zoom.c b/arch/arm/mach-omap2/board-zoom.c
index 4994438..a93106b 100644
--- a/arch/arm/mach-omap2/board-zoom.c
+++ b/arch/arm/mach-omap2/board-zoom.c
@@ -138,7 +138,7 @@ MACHINE_START(OMAP_ZOOM2, "OMAP Zoom2 board")
 	.init_machine	= omap_zoom_init,
 	.init_late	= omap3430_init_late,
 	.timer		= &omap3_timer,
-	.restart	= omap_prcm_restart,
+	.restart	= omap3xxx_restart,
 MACHINE_END
 
 MACHINE_START(OMAP_ZOOM3, "OMAP Zoom3 board")
@@ -151,5 +151,5 @@ MACHINE_START(OMAP_ZOOM3, "OMAP Zoom3 board")
 	.init_machine	= omap_zoom_init,
 	.init_late	= omap3630_init_late,
 	.timer		= &omap3_timer,
-	.restart	= omap_prcm_restart,
+	.restart	= omap3xxx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index 35ec5f3..32b6796 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -94,33 +94,6 @@ extern void omap2_clkt_iclk_deny_idle(struct clk *clk);
 u32 omap2_get_dpll_rate(struct clk *clk);
 void omap2_init_dpll_parent(struct clk *clk);
 
-int omap2_wait_clock_ready(void __iomem *reg, u32 cval, const char *name);
-
-
-#ifdef CONFIG_ARCH_OMAP2
-void omap2xxx_clk_prepare_for_reboot(void);
-#else
-static inline void omap2xxx_clk_prepare_for_reboot(void)
-{
-}
-#endif
-
-#ifdef CONFIG_ARCH_OMAP3
-void omap3_clk_prepare_for_reboot(void);
-#else
-static inline void omap3_clk_prepare_for_reboot(void)
-{
-}
-#endif
-
-#ifdef CONFIG_ARCH_OMAP4
-void omap4_clk_prepare_for_reboot(void);
-#else
-static inline void omap4_clk_prepare_for_reboot(void)
-{
-}
-#endif
-
 int omap2_dflt_clk_enable(struct clk *clk);
 void omap2_dflt_clk_disable(struct clk *clk);
 void omap2_clk_dflt_find_companion(struct clk *clk, void __iomem **other_reg,
@@ -139,7 +112,6 @@ extern const struct clkops clkops_dummy;
 extern const struct clkops clkops_omap2_dflt;
 
 extern struct clk_functions omap2_clk_functions;
-extern struct clk *vclk, *sclk;
 
 extern const struct clksel_rate gpt_32k_rates[];
 extern const struct clksel_rate gpt_sys_rates[];
diff --git a/arch/arm/mach-omap2/clock2420_data.c b/arch/arm/mach-omap2/clock2420_data.c
index 0cae0f5..405a07a 100644
--- a/arch/arm/mach-omap2/clock2420_data.c
+++ b/arch/arm/mach-omap2/clock2420_data.c
@@ -1972,10 +1972,6 @@ int __init omap2420_clk_init(void)
 	 */
 	clk_enable_init_clocks();
 
-	/* Avoid sleeping sleeping during omap2_clk_prepare_for_reboot() */
-	vclk = clk_get(NULL, "virt_prcm_set");
-	sclk = clk_get(NULL, "sys_ck");
-
 	return 0;
 }
 
diff --git a/arch/arm/mach-omap2/clock2430_data.c b/arch/arm/mach-omap2/clock2430_data.c
index 0c4f719..0664fc3 100644
--- a/arch/arm/mach-omap2/clock2430_data.c
+++ b/arch/arm/mach-omap2/clock2430_data.c
@@ -2071,10 +2071,6 @@ int __init omap2430_clk_init(void)
 	 */
 	clk_enable_init_clocks();
 
-	/* Avoid sleeping sleeping during omap2_clk_prepare_for_reboot() */
-	vclk = clk_get(NULL, "virt_prcm_set");
-	sclk = clk_get(NULL, "sys_ck");
-
 	return 0;
 }
 
diff --git a/arch/arm/mach-omap2/clock2xxx.c b/arch/arm/mach-omap2/clock2xxx.c
index 0e71fc2..d830bf9 100644
--- a/arch/arm/mach-omap2/clock2xxx.c
+++ b/arch/arm/mach-omap2/clock2xxx.c
@@ -30,27 +30,11 @@
 #include "cm.h"
 #include "cm-regbits-24xx.h"
 
-struct clk *vclk, *sclk;
-
 /*
  * Omap24xx specific clock functions
  */
 
 /*
- * Set clocks for bypass mode for reboot to work.
- */
-void omap2xxx_clk_prepare_for_reboot(void)
-{
-	u32 rate;
-
-	if (vclk == NULL || sclk == NULL)
-		return;
-
-	rate = clk_get_rate(sclk);
-	clk_set_rate(vclk, rate);
-}
-
-/*
  * Switch the MPU rate if specified on cmdline.  We cannot do this
  * early until cmdline is parsed.  XXX This should be removed from the
  * clock code and handled by the OPP layer code in the near future.
diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index 06dff1a..abd7465 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -114,7 +114,6 @@ void am35xx_init_late(void);
 void ti81xx_init_late(void);
 void omap4430_init_late(void);
 int omap2_common_pm_late_init(void);
-void omap_prcm_restart(char, const char *);
 void omap2xxx_restart(char, const char *);
 void omap3xxx_restart(char, const char *);
 void omap44xx_restart(char, const char *);
diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
index 118dc87..8cb55d3 100644
--- a/arch/arm/mach-omap2/prcm.c
+++ b/arch/arm/mach-omap2/prcm.c
@@ -46,58 +46,6 @@ void __iomem *prcm_mpu_base;
 
 #define MAX_MODULE_ENABLE_WAIT		100000
 
-/* Resets clock rates and reboots the system. Only called from system.h */
-void omap_prcm_restart(char mode, const char *cmd)
-{
-	s16 prcm_offs = 0;
-
-	if (cpu_is_omap24xx()) {
-		omap2xxx_clk_prepare_for_reboot();
-
-		prcm_offs = WKUP_MOD;
-	} else if (cpu_is_omap34xx()) {
-		prcm_offs = OMAP3430_GR_MOD;
-		omap3_ctrl_write_boot_mode((cmd ? (u8)*cmd : 0));
-	} else if (cpu_is_omap44xx()) {
-		omap4_prminst_global_warm_sw_reset(); /* never returns */
-	} else {
-		WARN_ON(1);
-	}
-
-	/*
-	 * As per Errata i520, in some cases, user will not be able to
-	 * access DDR memory after warm-reset.
-	 * This situation occurs while the warm-reset happens during a read
-	 * access to DDR memory. In that particular condition, DDR memory
-	 * does not respond to a corrupted read command due to the warm
-	 * reset occurrence but SDRC is waiting for read completion.
-	 * SDRC is not sensitive to the warm reset, but the interconnect is
-	 * reset on the fly, thus causing a misalignment between SDRC logic,
-	 * interconnect logic and DDR memory state.
-	 * WORKAROUND:
-	 * Steps to perform before a Warm reset is trigged:
-	 * 1. enable self-refresh on idle request
-	 * 2. put SDRC in idle
-	 * 3. wait until SDRC goes to idle
-	 * 4. generate SW reset (Global SW reset)
-	 *
-	 * Steps to be performed after warm reset occurs (in bootloader):
-	 * if HW warm reset is the source, apply below steps before any
-	 * accesses to SDRAM:
-	 * 1. Reset SMS and SDRC and wait till reset is complete
-	 * 2. Re-initialize SMS, SDRC and memory
-	 *
-	 * NOTE: Above work around is required only if arch reset is implemented
-	 * using Global SW reset(GLOBAL_SW_RST). DPLL3 reset does not need
-	 * the WA since it resets SDRC as well as part of cold reset.
-	 */
-
-	/* XXX should be moved to some OMAP2/3 specific code */
-	omap2_prm_set_mod_reg_bits(OMAP_RST_DPLL3_MASK, prcm_offs,
-				   OMAP2_RM_RSTCTRL);
-	omap2_prm_read_mod_reg(prcm_offs, OMAP2_RM_RSTCTRL); /* OCP barrier */
-}
-
 /**
  * omap2_cm_wait_idlest - wait for IDLEST bit to indicate module readiness
  * @reg: physical address of module IDLEST register


