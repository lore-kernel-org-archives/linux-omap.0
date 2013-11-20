From: Felipe Balbi <balbi@ti.com>
Subject: [RFT/RFC/PATCH 24/31] arm: omap: irq: call set_handle_irq() from .init_irq
Date: Wed, 20 Nov 2013 12:09:11 -0600
Message-ID: <1384970958-4118-25-git-send-email-balbi@ti.com>
References: <1384970958-4118-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48486 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754673Ab3KTSKt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Nov 2013 13:10:49 -0500
In-Reply-To: <1384970958-4118-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>

the idea is that board-files won't need to set
.handle_irq on their machine_descs, which lets
us drop a little more pointless code.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/board-2430sdp.c        | 1 -
 arch/arm/mach-omap2/board-3430sdp.c        | 1 -
 arch/arm/mach-omap2/board-am3517crane.c    | 1 -
 arch/arm/mach-omap2/board-am3517evm.c      | 1 -
 arch/arm/mach-omap2/board-cm-t35.c         | 2 --
 arch/arm/mach-omap2/board-cm-t3517.c       | 1 -
 arch/arm/mach-omap2/board-devkit8000.c     | 1 -
 arch/arm/mach-omap2/board-h4.c             | 1 -
 arch/arm/mach-omap2/board-ldp.c            | 1 -
 arch/arm/mach-omap2/board-n8x0.c           | 3 ---
 arch/arm/mach-omap2/board-omap3beagle.c    | 1 -
 arch/arm/mach-omap2/board-omap3logic.c     | 2 --
 arch/arm/mach-omap2/board-omap3pandora.c   | 1 -
 arch/arm/mach-omap2/board-omap3stalker.c   | 1 -
 arch/arm/mach-omap2/board-omap3touchbook.c | 1 -
 arch/arm/mach-omap2/board-overo.c          | 1 -
 arch/arm/mach-omap2/board-rx51.c           | 1 -
 arch/arm/mach-omap2/irq.c                  | 3 +++
 18 files changed, 3 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index c711ad6..39504f8 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -265,7 +265,6 @@ MACHINE_START(OMAP_2430SDP, "OMAP2430 sdp2430 board")
 	.map_io		= omap243x_map_io,
 	.init_early	= omap2430_init_early,
 	.init_irq	= omap2_init_irq,
-	.handle_irq	= omap2_intc_handle_irq,
 	.init_machine	= omap_2430sdp_init,
 	.init_late	= omap2430_init_late,
 	.init_time	= omap2_sync32k_timer_init,
diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index d95d0ef..d21a304 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -625,7 +625,6 @@ MACHINE_START(OMAP_3430SDP, "OMAP3430 3430SDP board")
 	.map_io		= omap3_map_io,
 	.init_early	= omap3430_init_early,
 	.init_irq	= omap3_init_irq,
-	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= omap_3430sdp_init,
 	.init_late	= omap3430_init_late,
 	.init_time	= omap3_sync32k_timer_init,
diff --git a/arch/arm/mach-omap2/board-am3517crane.c b/arch/arm/mach-omap2/board-am3517crane.c
index 0d499a1..212c316 100644
--- a/arch/arm/mach-omap2/board-am3517crane.c
+++ b/arch/arm/mach-omap2/board-am3517crane.c
@@ -142,7 +142,6 @@ MACHINE_START(CRANEBOARD, "AM3517/05 CRANEBOARD")
 	.map_io		= omap3_map_io,
 	.init_early	= am35xx_init_early,
 	.init_irq	= omap3_init_irq,
-	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= am3517_crane_init,
 	.init_late	= am35xx_init_late,
 	.init_time	= omap3_sync32k_timer_init,
diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index 543d9a8..489ad02 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -371,7 +371,6 @@ MACHINE_START(OMAP3517EVM, "OMAP3517/AM3517 EVM")
 	.map_io		= omap3_map_io,
 	.init_early	= am35xx_init_early,
 	.init_irq	= omap3_init_irq,
-	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= am3517_evm_init,
 	.init_late	= am35xx_init_late,
 	.init_time	= omap3_sync32k_timer_init,
diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index 8dd0ec8..2c27014 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -750,7 +750,6 @@ MACHINE_START(CM_T35, "Compulab CM-T35")
 	.map_io		= omap3_map_io,
 	.init_early	= omap35xx_init_early,
 	.init_irq	= omap3_init_irq,
-	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= cm_t35_init,
 	.init_late	= omap35xx_init_late,
 	.init_time	= omap3_sync32k_timer_init,
@@ -763,7 +762,6 @@ MACHINE_START(CM_T3730, "Compulab CM-T3730")
 	.map_io		= omap3_map_io,
 	.init_early	= omap3630_init_early,
 	.init_irq	= omap3_init_irq,
-	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= cm_t3730_init,
 	.init_late     = omap3630_init_late,
 	.init_time	= omap3_sync32k_timer_init,
diff --git a/arch/arm/mach-omap2/board-cm-t3517.c b/arch/arm/mach-omap2/board-cm-t3517.c
index 4eb5e6f..8a2c167 100644
--- a/arch/arm/mach-omap2/board-cm-t3517.c
+++ b/arch/arm/mach-omap2/board-cm-t3517.c
@@ -329,7 +329,6 @@ MACHINE_START(CM_T3517, "Compulab CM-T3517")
 	.map_io		= omap3_map_io,
 	.init_early	= am35xx_init_early,
 	.init_irq	= omap3_init_irq,
-	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= cm_t3517_init,
 	.init_late	= am35xx_init_late,
 	.init_time	= omap3_gptimer_timer_init,
diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index cdc4fb9..d8e4f34 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -647,7 +647,6 @@ MACHINE_START(DEVKIT8000, "OMAP3 Devkit8000")
 	.map_io		= omap3_map_io,
 	.init_early	= omap35xx_init_early,
 	.init_irq	= omap3_init_irq,
-	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= devkit8000_init,
 	.init_late	= omap35xx_init_late,
 	.init_time	= omap3_secure_sync32k_timer_init,
diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
index f780834..d1a9924 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -357,7 +357,6 @@ MACHINE_START(OMAP_H4, "OMAP2420 H4 board")
 	.map_io		= omap242x_map_io,
 	.init_early	= omap2420_init_early,
 	.init_irq	= omap2_init_irq,
-	.handle_irq	= omap2_intc_handle_irq,
 	.init_machine	= omap_h4_init,
 	.init_late	= omap2420_init_late,
 	.init_time	= omap2_sync32k_timer_init,
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index 4ec8d82..fdb9759 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -417,7 +417,6 @@ MACHINE_START(OMAP_LDP, "OMAP LDP board")
 	.map_io		= omap3_map_io,
 	.init_early	= omap3430_init_early,
 	.init_irq	= omap3_init_irq,
-	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= omap_ldp_init,
 	.init_late	= omap3430_init_late,
 	.init_time	= omap3_sync32k_timer_init,
diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
index 827d1500..18810d8 100644
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -724,7 +724,6 @@ MACHINE_START(NOKIA_N800, "Nokia N800")
 	.map_io		= omap242x_map_io,
 	.init_early	= omap2420_init_early,
 	.init_irq	= omap2_init_irq,
-	.handle_irq	= omap2_intc_handle_irq,
 	.init_machine	= n8x0_init_machine,
 	.init_late	= omap2420_init_late,
 	.init_time	= omap2_sync32k_timer_init,
@@ -737,7 +736,6 @@ MACHINE_START(NOKIA_N810, "Nokia N810")
 	.map_io		= omap242x_map_io,
 	.init_early	= omap2420_init_early,
 	.init_irq	= omap2_init_irq,
-	.handle_irq	= omap2_intc_handle_irq,
 	.init_machine	= n8x0_init_machine,
 	.init_late	= omap2420_init_late,
 	.init_time	= omap2_sync32k_timer_init,
@@ -750,7 +748,6 @@ MACHINE_START(NOKIA_N810_WIMAX, "Nokia N810 WiMAX")
 	.map_io		= omap242x_map_io,
 	.init_early	= omap2420_init_early,
 	.init_irq	= omap2_init_irq,
-	.handle_irq	= omap2_intc_handle_irq,
 	.init_machine	= n8x0_init_machine,
 	.init_late	= omap2420_init_late,
 	.init_time	= omap2_sync32k_timer_init,
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index d6ed819..bb3b9ca 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -588,7 +588,6 @@ MACHINE_START(OMAP3_BEAGLE, "OMAP3 Beagle Board")
 	.map_io		= omap3_map_io,
 	.init_early	= omap3_init_early,
 	.init_irq	= omap3_init_irq,
-	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= omap3_beagle_init,
 	.init_late	= omap3_init_late,
 	.init_time	= omap3_secure_sync32k_timer_init,
diff --git a/arch/arm/mach-omap2/board-omap3logic.c b/arch/arm/mach-omap2/board-omap3logic.c
index bab51e6..6049f60 100644
--- a/arch/arm/mach-omap2/board-omap3logic.c
+++ b/arch/arm/mach-omap2/board-omap3logic.c
@@ -230,7 +230,6 @@ MACHINE_START(OMAP3_TORPEDO, "Logic OMAP3 Torpedo board")
 	.map_io		= omap3_map_io,
 	.init_early	= omap35xx_init_early,
 	.init_irq	= omap3_init_irq,
-	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= omap3logic_init,
 	.init_late	= omap35xx_init_late,
 	.init_time	= omap3_sync32k_timer_init,
@@ -243,7 +242,6 @@ MACHINE_START(OMAP3530_LV_SOM, "OMAP Logic 3530 LV SOM board")
 	.map_io		= omap3_map_io,
 	.init_early	= omap35xx_init_early,
 	.init_irq	= omap3_init_irq,
-	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= omap3logic_init,
 	.init_late	= omap35xx_init_late,
 	.init_time	= omap3_sync32k_timer_init,
diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index de1bc6b..cb675fe 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -622,7 +622,6 @@ MACHINE_START(OMAP3_PANDORA, "Pandora Handheld Console")
 	.map_io		= omap3_map_io,
 	.init_early	= omap35xx_init_early,
 	.init_irq	= omap3_init_irq,
-	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= omap3pandora_init,
 	.init_late	= omap35xx_init_late,
 	.init_time	= omap3_sync32k_timer_init,
diff --git a/arch/arm/mach-omap2/board-omap3stalker.c b/arch/arm/mach-omap2/board-omap3stalker.c
index 119efaf..06db64b 100644
--- a/arch/arm/mach-omap2/board-omap3stalker.c
+++ b/arch/arm/mach-omap2/board-omap3stalker.c
@@ -430,7 +430,6 @@ MACHINE_START(SBC3530, "OMAP3 STALKER")
 	.map_io			= omap3_map_io,
 	.init_early		= omap35xx_init_early,
 	.init_irq		= omap3_init_irq,
-	.handle_irq		= omap3_intc_handle_irq,
 	.init_machine		= omap3_stalker_init,
 	.init_late		= omap35xx_init_late,
 	.init_time		= omap3_secure_sync32k_timer_init,
diff --git a/arch/arm/mach-omap2/board-omap3touchbook.c b/arch/arm/mach-omap2/board-omap3touchbook.c
index 7da48bc..d454508 100644
--- a/arch/arm/mach-omap2/board-omap3touchbook.c
+++ b/arch/arm/mach-omap2/board-omap3touchbook.c
@@ -388,7 +388,6 @@ MACHINE_START(TOUCHBOOK, "OMAP3 touchbook Board")
 	.map_io		= omap3_map_io,
 	.init_early	= omap3430_init_early,
 	.init_irq	= omap3_init_irq,
-	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= omap3_touchbook_init,
 	.init_late	= omap3430_init_late,
 	.init_time	= omap3_secure_sync32k_timer_init,
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index f6d3841..2dae6cc 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -564,7 +564,6 @@ MACHINE_START(OVERO, "Gumstix Overo")
 	.map_io		= omap3_map_io,
 	.init_early	= omap35xx_init_early,
 	.init_irq	= omap3_init_irq,
-	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= overo_init,
 	.init_late	= omap35xx_init_late,
 	.init_time	= omap3_sync32k_timer_init,
diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/board-rx51.c
index db168c9..2d1e5a6 100644
--- a/arch/arm/mach-omap2/board-rx51.c
+++ b/arch/arm/mach-omap2/board-rx51.c
@@ -134,7 +134,6 @@ MACHINE_START(NOKIA_RX51, "Nokia RX-51 board")
 	.map_io		= omap3_map_io,
 	.init_early	= omap3430_init_early,
 	.init_irq	= omap3_init_irq,
-	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= rx51_init,
 	.init_late	= omap3430_init_late,
 	.init_time	= omap3_sync32k_timer_init,
diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index 6b9bf0b..d936955 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -287,16 +287,19 @@ asmlinkage void __exception_irq_entry omap2_intc_handle_irq(struct pt_regs *regs
 void __init omap2_init_irq(void)
 {
 	omap_init_irq(OMAP24XX_IC_BASE, 96, NULL);
+	set_handle_irq(omap2_intc_handle_irq);
 }
 
 void __init omap3_init_irq(void)
 {
 	omap_init_irq(OMAP34XX_IC_BASE, 96, NULL);
+	set_handle_irq(omap2_intc_handle_irq);
 }
 
 void __init ti81xx_init_irq(void)
 {
 	omap_init_irq(OMAP34XX_IC_BASE, 128, NULL);
+	set_handle_irq(omap2_intc_handle_irq);
 }
 
 static int __init intc_of_init(struct device_node *node,
-- 
1.8.4.GIT

