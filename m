From: Venkatraman S <svenkatr@ti.com>
Subject: [PATCH 1/2] omap2+: Populate nr_irqs field in machine descriptors
Date: Thu, 25 Aug 2011 01:16:54 +0530
Message-ID: <1314215215-18683-2-git-send-email-svenkatr@ti.com>
References: <1314215215-18683-1-git-send-email-svenkatr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38749 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750767Ab1HXTrZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Aug 2011 15:47:25 -0400
In-Reply-To: <1314215215-18683-1-git-send-email-svenkatr@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Venkatraman S <svenkatr@ti.com>

Machine descriptors in board files should have valid
nr_irqs value so that irq handler code can probe it.

Signed-off-by: Venkatraman S <svenkatr@ti.com>
---
 arch/arm/mach-omap2/board-2430sdp.c        |    1 +
 arch/arm/mach-omap2/board-3430sdp.c        |    1 +
 arch/arm/mach-omap2/board-3630sdp.c        |    1 +
 arch/arm/mach-omap2/board-4430sdp.c        |    1 +
 arch/arm/mach-omap2/board-am3517crane.c    |    1 +
 arch/arm/mach-omap2/board-am3517evm.c      |    1 +
 arch/arm/mach-omap2/board-apollon.c        |    1 +
 arch/arm/mach-omap2/board-cm-t35.c         |    2 ++
 arch/arm/mach-omap2/board-cm-t3517.c       |    1 +
 arch/arm/mach-omap2/board-devkit8000.c     |    1 +
 arch/arm/mach-omap2/board-generic.c        |    1 +
 arch/arm/mach-omap2/board-h4.c             |    1 +
 arch/arm/mach-omap2/board-igep0020.c       |    2 ++
 arch/arm/mach-omap2/board-ldp.c            |    1 +
 arch/arm/mach-omap2/board-n8x0.c           |    3 +++
 arch/arm/mach-omap2/board-omap3beagle.c    |    1 +
 arch/arm/mach-omap2/board-omap3evm.c       |    1 +
 arch/arm/mach-omap2/board-omap3logic.c     |    2 ++
 arch/arm/mach-omap2/board-omap3pandora.c   |    1 +
 arch/arm/mach-omap2/board-omap3stalker.c   |    1 +
 arch/arm/mach-omap2/board-omap3touchbook.c |    1 +
 arch/arm/mach-omap2/board-omap4panda.c     |    1 +
 arch/arm/mach-omap2/board-overo.c          |    1 +
 arch/arm/mach-omap2/board-rm680.c          |    1 +
 arch/arm/mach-omap2/board-rx51.c           |    1 +
 arch/arm/mach-omap2/board-ti8168evm.c      |    1 +
 arch/arm/mach-omap2/board-zoom.c           |    2 ++
 27 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index 2028464..68edea8 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -263,4 +263,5 @@ MACHINE_START(OMAP_2430SDP, "OMAP2430 sdp2430 board")
 	.init_irq	= omap2_init_irq,
 	.init_machine	= omap_2430sdp_init,
 	.timer		= &omap2_timer,
+	.nr_irqs 	= NR_IRQS,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index bd600cf..e4a323b 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -736,4 +736,5 @@ MACHINE_START(OMAP_3430SDP, "OMAP3430 3430SDP board")
 	.init_irq	= omap3_init_irq,
 	.init_machine	= omap_3430sdp_init,
 	.timer		= &omap3_timer,
+	.nr_irqs 	= NR_IRQS,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-3630sdp.c b/arch/arm/mach-omap2/board-3630sdp.c
index e4f37b5..2183ea8 100644
--- a/arch/arm/mach-omap2/board-3630sdp.c
+++ b/arch/arm/mach-omap2/board-3630sdp.c
@@ -222,4 +222,5 @@ MACHINE_START(OMAP_3630SDP, "OMAP 3630SDP board")
 	.init_irq	= omap3_init_irq,
 	.init_machine	= omap_sdp_init,
 	.timer		= &omap3_timer,
+	.nr_irqs 	= NR_IRQS,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index c7cef44..88e7848 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -845,4 +845,5 @@ MACHINE_START(OMAP_4430SDP, "OMAP4430 4430SDP board")
 	.init_irq	= gic_init_irq,
 	.init_machine	= omap_4430sdp_init,
 	.timer		= &omap4_timer,
+	.nr_irqs 	= NR_IRQS,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-am3517crane.c b/arch/arm/mach-omap2/board-am3517crane.c
index 933e935..6d494d6 100644
--- a/arch/arm/mach-omap2/board-am3517crane.c
+++ b/arch/arm/mach-omap2/board-am3517crane.c
@@ -105,4 +105,5 @@ MACHINE_START(CRANEBOARD, "AM3517/05 CRANEBOARD")
 	.init_irq	= omap3_init_irq,
 	.init_machine	= am3517_crane_init,
 	.timer		= &omap3_timer,
+	.nr_irqs 	= NR_IRQS,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index f3006c3..f5f169c 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -497,4 +497,5 @@ MACHINE_START(OMAP3517EVM, "OMAP3517/AM3517 EVM")
 	.init_irq	= omap3_init_irq,
 	.init_machine	= am3517_evm_init,
 	.timer		= &omap3_timer,
+	.nr_irqs 	= NR_IRQS,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-apollon.c b/arch/arm/mach-omap2/board-apollon.c
index 7021170..b817a0d 100644
--- a/arch/arm/mach-omap2/board-apollon.c
+++ b/arch/arm/mach-omap2/board-apollon.c
@@ -357,4 +357,5 @@ MACHINE_START(OMAP_APOLLON, "OMAP24xx Apollon")
 	.init_irq	= omap2_init_irq,
 	.init_machine	= omap_apollon_init,
 	.timer		= &omap2_timer,
+	.nr_irqs 	= NR_IRQS,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index 3af8aab..d22ec1c 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -641,6 +641,7 @@ MACHINE_START(CM_T35, "Compulab CM-T35")
 	.init_irq	= omap3_init_irq,
 	.init_machine	= cm_t35_init,
 	.timer		= &omap3_timer,
+	.nr_irqs 	= NR_IRQS,
 MACHINE_END
 
 MACHINE_START(CM_T3730, "Compulab CM-T3730")
@@ -651,4 +652,5 @@ MACHINE_START(CM_T3730, "Compulab CM-T3730")
 	.init_irq       = omap3_init_irq,
 	.init_machine   = cm_t3730_init,
 	.timer          = &omap3_timer,
+	.nr_irqs 	= NR_IRQS,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-cm-t3517.c b/arch/arm/mach-omap2/board-cm-t3517.c
index 05c72f4..5569077 100644
--- a/arch/arm/mach-omap2/board-cm-t3517.c
+++ b/arch/arm/mach-omap2/board-cm-t3517.c
@@ -306,4 +306,5 @@ MACHINE_START(CM_T3517, "Compulab CM-T3517")
 	.init_irq	= omap3_init_irq,
 	.init_machine	= cm_t3517_init,
 	.timer		= &omap3_timer,
+	.nr_irqs 	= NR_IRQS,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index b6002ec..a6cbf61 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -674,4 +674,5 @@ MACHINE_START(DEVKIT8000, "OMAP3 Devkit8000")
 	.init_irq	= devkit8000_init_irq,
 	.init_machine	= devkit8000_init,
 	.timer		= &omap3_secure_timer,
+	.nr_irqs 	= NR_IRQS,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index 54db41a..ad59314 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -73,4 +73,5 @@ MACHINE_START(OMAP_GENERIC, "Generic OMAP24xx")
 	.init_irq	= omap2_init_irq,
 	.init_machine	= omap_generic_init,
 	.timer		= &omap2_timer,
+	.nr_irqs 	= NR_IRQS,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
index 45de2b3..37cad3e 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -389,4 +389,5 @@ MACHINE_START(OMAP_H4, "OMAP2420 H4 board")
 	.init_irq	= omap_h4_init_irq,
 	.init_machine	= omap_h4_init,
 	.timer		= &omap2_timer,
+	.nr_irqs 	= NR_IRQS,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index 35be778..786849a 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -679,6 +679,7 @@ MACHINE_START(IGEP0020, "IGEP v2 board")
 	.init_irq	= omap3_init_irq,
 	.init_machine	= igep_init,
 	.timer		= &omap3_timer,
+	.nr_irqs 	= NR_IRQS,
 MACHINE_END
 
 MACHINE_START(IGEP0030, "IGEP OMAP3 module")
@@ -689,4 +690,5 @@ MACHINE_START(IGEP0030, "IGEP OMAP3 module")
 	.init_irq	= omap3_init_irq,
 	.init_machine	= igep_init,
 	.timer		= &omap3_timer,
+	.nr_irqs 	= NR_IRQS,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index 218764c..d06c656 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -340,4 +340,5 @@ MACHINE_START(OMAP_LDP, "OMAP LDP board")
 	.init_irq	= omap3_init_irq,
 	.init_machine	= omap_ldp_init,
 	.timer		= &omap3_timer,
+	.nr_irqs 	= NR_IRQS,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
index e11f0c5..2de8c03 100644
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -702,6 +702,7 @@ MACHINE_START(NOKIA_N800, "Nokia N800")
 	.init_irq	= omap2_init_irq,
 	.init_machine	= n8x0_init_machine,
 	.timer		= &omap2_timer,
+	.nr_irqs 	= NR_IRQS,
 MACHINE_END
 
 MACHINE_START(NOKIA_N810, "Nokia N810")
@@ -712,6 +713,7 @@ MACHINE_START(NOKIA_N810, "Nokia N810")
 	.init_irq	= omap2_init_irq,
 	.init_machine	= n8x0_init_machine,
 	.timer		= &omap2_timer,
+	.nr_irqs 	= NR_IRQS,
 MACHINE_END
 
 MACHINE_START(NOKIA_N810_WIMAX, "Nokia N810 WiMAX")
@@ -722,4 +724,5 @@ MACHINE_START(NOKIA_N810_WIMAX, "Nokia N810 WiMAX")
 	.init_irq	= omap2_init_irq,
 	.init_machine	= n8x0_init_machine,
 	.timer		= &omap2_timer,
+	.nr_irqs 	= NR_IRQS,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 3ae16b4..2b2f7a5 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -564,4 +564,5 @@ MACHINE_START(OMAP3_BEAGLE, "OMAP3 Beagle Board")
 	.init_irq	= omap3_beagle_init_irq,
 	.init_machine	= omap3_beagle_init,
 	.timer		= &omap3_secure_timer,
+	.nr_irqs 	= NR_IRQS,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index c452b3f..a322609 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -688,4 +688,5 @@ MACHINE_START(OMAP3EVM, "OMAP3 EVM")
 	.init_irq	= omap3_init_irq,
 	.init_machine	= omap3_evm_init,
 	.timer		= &omap3_timer,
+	.nr_irqs 	= NR_IRQS,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-omap3logic.c b/arch/arm/mach-omap2/board-omap3logic.c
index 703aeb5..9b438dc 100644
--- a/arch/arm/mach-omap2/board-omap3logic.c
+++ b/arch/arm/mach-omap2/board-omap3logic.c
@@ -215,6 +215,7 @@ MACHINE_START(OMAP3_TORPEDO, "Logic OMAP3 Torpedo board")
 	.init_irq	= omap3_init_irq,
 	.init_machine	= omap3logic_init,
 	.timer		= &omap3_timer,
+	.nr_irqs 	= NR_IRQS,
 MACHINE_END
 
 MACHINE_START(OMAP3530_LV_SOM, "OMAP Logic 3530 LV SOM board")
@@ -224,4 +225,5 @@ MACHINE_START(OMAP3530_LV_SOM, "OMAP Logic 3530 LV SOM board")
 	.init_irq	= omap3_init_irq,
 	.init_machine	= omap3logic_init,
 	.timer		= &omap3_timer,
+	.nr_irqs 	= NR_IRQS,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index 080d7bd..441a35e 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -613,4 +613,5 @@ MACHINE_START(OMAP3_PANDORA, "Pandora Handheld Console")
 	.init_irq	= omap3_init_irq,
 	.init_machine	= omap3pandora_init,
 	.timer		= &omap3_timer,
+	.nr_irqs 	= NR_IRQS,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-omap3stalker.c b/arch/arm/mach-omap2/board-omap3stalker.c
index 8e10498..c491bd1 100644
--- a/arch/arm/mach-omap2/board-omap3stalker.c
+++ b/arch/arm/mach-omap2/board-omap3stalker.c
@@ -500,4 +500,5 @@ MACHINE_START(SBC3530, "OMAP3 STALKER")
 	.init_irq		= omap3_stalker_init_irq,
 	.init_machine		= omap3_stalker_init,
 	.timer			= &omap3_secure_timer,
+	.nr_irqs 	= NR_IRQS,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-omap3touchbook.c b/arch/arm/mach-omap2/board-omap3touchbook.c
index 852ea04..24a1c32 100644
--- a/arch/arm/mach-omap2/board-omap3touchbook.c
+++ b/arch/arm/mach-omap2/board-omap3touchbook.c
@@ -411,4 +411,5 @@ MACHINE_START(TOUCHBOOK, "OMAP3 touchbook Board")
 	.init_irq	= omap3_touchbook_init_irq,
 	.init_machine	= omap3_touchbook_init,
 	.timer		= &omap3_secure_timer,
+	.nr_irqs 	= NR_IRQS,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index 9aaa960..451a0a6 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -590,4 +590,5 @@ MACHINE_START(OMAP4_PANDA, "OMAP4 Panda board")
 	.init_irq	= gic_init_irq,
 	.init_machine	= omap4_panda_init,
 	.timer		= &omap4_timer,
+	.nr_irqs 	= NR_IRQS,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index f949a99..1c0175b 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -568,4 +568,5 @@ MACHINE_START(OVERO, "Gumstix Overo")
 	.init_irq	= omap3_init_irq,
 	.init_machine	= overo_init,
 	.timer		= &omap3_timer,
+	.nr_irqs 	= NR_IRQS,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-rm680.c b/arch/arm/mach-omap2/board-rm680.c
index 7dfed24..596b713 100644
--- a/arch/arm/mach-omap2/board-rm680.c
+++ b/arch/arm/mach-omap2/board-rm680.c
@@ -160,4 +160,5 @@ MACHINE_START(NOKIA_RM680, "Nokia RM-680 board")
 	.init_irq	= omap3_init_irq,
 	.init_machine	= rm680_init,
 	.timer		= &omap3_timer,
+	.nr_irqs 	= NR_IRQS,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/board-rx51.c
index 5ea142f..1e38168 100644
--- a/arch/arm/mach-omap2/board-rx51.c
+++ b/arch/arm/mach-omap2/board-rx51.c
@@ -163,4 +163,5 @@ MACHINE_START(NOKIA_RX51, "Nokia RX-51 board")
 	.init_irq	= omap3_init_irq,
 	.init_machine	= rx51_init,
 	.timer		= &omap3_timer,
+	.nr_irqs 	= NR_IRQS,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-ti8168evm.c b/arch/arm/mach-omap2/board-ti8168evm.c
index a85d5b0..b1d6420 100644
--- a/arch/arm/mach-omap2/board-ti8168evm.c
+++ b/arch/arm/mach-omap2/board-ti8168evm.c
@@ -54,4 +54,5 @@ MACHINE_START(TI8168EVM, "ti8168evm")
 	.init_irq	= ti816x_init_irq,
 	.timer		= &omap3_timer,
 	.init_machine	= ti8168_evm_init,
+	.nr_irqs 	= NR_IRQS,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-zoom.c b/arch/arm/mach-omap2/board-zoom.c
index 8a98c3c..080713e 100644
--- a/arch/arm/mach-omap2/board-zoom.c
+++ b/arch/arm/mach-omap2/board-zoom.c
@@ -140,6 +140,7 @@ MACHINE_START(OMAP_ZOOM2, "OMAP Zoom2 board")
 	.init_irq	= omap3_init_irq,
 	.init_machine	= omap_zoom_init,
 	.timer		= &omap3_timer,
+	.nr_irqs 	= NR_IRQS,
 MACHINE_END
 
 MACHINE_START(OMAP_ZOOM3, "OMAP Zoom3 board")
@@ -150,4 +151,5 @@ MACHINE_START(OMAP_ZOOM3, "OMAP Zoom3 board")
 	.init_irq	= omap3_init_irq,
 	.init_machine	= omap_zoom_init,
 	.timer		= &omap3_timer,
+	.nr_irqs 	= NR_IRQS,
 MACHINE_END
-- 
1.7.1

