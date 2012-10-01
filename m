From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH V2 5/7] ARM: OMAP1: Remove omap_reserve() callback for all omap1 boards
Date: Tue, 2 Oct 2012 00:17:04 +0530
Message-ID: <1349117226-4980-6-git-send-email-lokeshvutla@ti.com>
References: <1349117226-4980-1-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46612 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751373Ab2JASrn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 1 Oct 2012 14:47:43 -0400
In-Reply-To: <1349117226-4980-1-git-send-email-lokeshvutla@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, santosh.shilimkar@ti.com, lokeshvutla@ti.com

omap_reserve() is a stub for omap1. So dropping
omap_reserve callback from all OMAP1 board files.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 arch/arm/mach-omap1/board-ams-delta.c |    1 -
 arch/arm/mach-omap1/board-fsample.c   |    1 -
 arch/arm/mach-omap1/board-generic.c   |    1 -
 arch/arm/mach-omap1/board-h2.c        |    1 -
 arch/arm/mach-omap1/board-h3.c        |    1 -
 arch/arm/mach-omap1/board-htcherald.c |    1 -
 arch/arm/mach-omap1/board-innovator.c |    1 -
 arch/arm/mach-omap1/board-nokia770.c  |    1 -
 arch/arm/mach-omap1/board-osk.c       |    1 -
 arch/arm/mach-omap1/board-palmte.c    |    1 -
 arch/arm/mach-omap1/board-palmtt.c    |    1 -
 arch/arm/mach-omap1/board-palmz71.c   |    1 -
 arch/arm/mach-omap1/board-perseus2.c  |    1 -
 arch/arm/mach-omap1/board-sx1.c       |    1 -
 arch/arm/mach-omap1/board-voiceblue.c |    1 -
 15 files changed, 15 deletions(-)

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index 9518bf5..e50b022 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -613,7 +613,6 @@ MACHINE_START(AMS_DELTA, "Amstrad E3 (Delta)")
 	.atag_offset	= 0x100,
 	.map_io		= ams_delta_map_io,
 	.init_early	= omap1_init_early,
-	.reserve	= omap_reserve,
 	.init_irq	= omap1_init_irq,
 	.init_machine	= ams_delta_init,
 	.init_late	= ams_delta_init_late,
diff --git a/arch/arm/mach-omap1/board-fsample.c b/arch/arm/mach-omap1/board-fsample.c
index 4b6de70..acd3ba6 100644
--- a/arch/arm/mach-omap1/board-fsample.c
+++ b/arch/arm/mach-omap1/board-fsample.c
@@ -362,7 +362,6 @@ MACHINE_START(OMAP_FSAMPLE, "OMAP730 F-Sample")
 	.atag_offset	= 0x100,
 	.map_io		= omap_fsample_map_io,
 	.init_early	= omap1_init_early,
-	.reserve	= omap_reserve,
 	.init_irq	= omap1_init_irq,
 	.init_machine	= omap_fsample_init,
 	.init_late	= omap1_init_late,
diff --git a/arch/arm/mach-omap1/board-generic.c b/arch/arm/mach-omap1/board-generic.c
index 4ec579f..608e7d2 100644
--- a/arch/arm/mach-omap1/board-generic.c
+++ b/arch/arm/mach-omap1/board-generic.c
@@ -81,7 +81,6 @@ MACHINE_START(OMAP_GENERIC, "Generic OMAP1510/1610/1710")
 	.atag_offset	= 0x100,
 	.map_io		= omap16xx_map_io,
 	.init_early	= omap1_init_early,
-	.reserve	= omap_reserve,
 	.init_irq	= omap1_init_irq,
 	.init_machine	= omap_generic_init,
 	.init_late	= omap1_init_late,
diff --git a/arch/arm/mach-omap1/board-h2.c b/arch/arm/mach-omap1/board-h2.c
index 4c2cb8e..fdc847d 100644
--- a/arch/arm/mach-omap1/board-h2.c
+++ b/arch/arm/mach-omap1/board-h2.c
@@ -459,7 +459,6 @@ MACHINE_START(OMAP_H2, "TI-H2")
 	.atag_offset	= 0x100,
 	.map_io		= omap16xx_map_io,
 	.init_early     = omap1_init_early,
-	.reserve	= omap_reserve,
 	.init_irq	= omap1_init_irq,
 	.init_machine	= h2_init,
 	.init_late	= omap1_init_late,
diff --git a/arch/arm/mach-omap1/board-h3.c b/arch/arm/mach-omap1/board-h3.c
index 3e638b8..2768f99 100644
--- a/arch/arm/mach-omap1/board-h3.c
+++ b/arch/arm/mach-omap1/board-h3.c
@@ -452,7 +452,6 @@ MACHINE_START(OMAP_H3, "TI OMAP1710 H3 board")
 	.atag_offset	= 0x100,
 	.map_io		= omap16xx_map_io,
 	.init_early     = omap1_init_early,
-	.reserve	= omap_reserve,
 	.init_irq	= omap1_init_irq,
 	.init_machine	= h3_init,
 	.init_late	= omap1_init_late,
diff --git a/arch/arm/mach-omap1/board-htcherald.c b/arch/arm/mach-omap1/board-htcherald.c
index 87ab208..bd0d6fd 100644
--- a/arch/arm/mach-omap1/board-htcherald.c
+++ b/arch/arm/mach-omap1/board-htcherald.c
@@ -600,7 +600,6 @@ MACHINE_START(HERALD, "HTC Herald")
 	.atag_offset    = 0x100,
 	.map_io         = htcherald_map_io,
 	.init_early     = omap1_init_early,
-	.reserve	= omap_reserve,
 	.init_irq       = omap1_init_irq,
 	.init_machine   = htcherald_init,
 	.init_late	= omap1_init_late,
diff --git a/arch/arm/mach-omap1/board-innovator.c b/arch/arm/mach-omap1/board-innovator.c
index db5f7d2..1b7a62e 100644
--- a/arch/arm/mach-omap1/board-innovator.c
+++ b/arch/arm/mach-omap1/board-innovator.c
@@ -454,7 +454,6 @@ MACHINE_START(OMAP_INNOVATOR, "TI-Innovator")
 	.atag_offset	= 0x100,
 	.map_io		= innovator_map_io,
 	.init_early     = omap1_init_early,
-	.reserve	= omap_reserve,
 	.init_irq	= omap1_init_irq,
 	.init_machine	= innovator_init,
 	.init_late	= omap1_init_late,
diff --git a/arch/arm/mach-omap1/board-nokia770.c b/arch/arm/mach-omap1/board-nokia770.c
index 7d5c06d..6b24394 100644
--- a/arch/arm/mach-omap1/board-nokia770.c
+++ b/arch/arm/mach-omap1/board-nokia770.c
@@ -251,7 +251,6 @@ MACHINE_START(NOKIA770, "Nokia 770")
 	.atag_offset	= 0x100,
 	.map_io		= omap16xx_map_io,
 	.init_early     = omap1_init_early,
-	.reserve	= omap_reserve,
 	.init_irq	= omap1_init_irq,
 	.init_machine	= omap_nokia770_init,
 	.init_late	= omap1_init_late,
diff --git a/arch/arm/mach-omap1/board-osk.c b/arch/arm/mach-omap1/board-osk.c
index 5973945..8fd78f7 100644
--- a/arch/arm/mach-omap1/board-osk.c
+++ b/arch/arm/mach-omap1/board-osk.c
@@ -606,7 +606,6 @@ MACHINE_START(OMAP_OSK, "TI-OSK")
 	.atag_offset	= 0x100,
 	.map_io		= omap16xx_map_io,
 	.init_early	= omap1_init_early,
-	.reserve	= omap_reserve,
 	.init_irq	= omap1_init_irq,
 	.init_machine	= osk_init,
 	.init_late	= omap1_init_late,
diff --git a/arch/arm/mach-omap1/board-palmte.c b/arch/arm/mach-omap1/board-palmte.c
index eac94c2..caa1023 100644
--- a/arch/arm/mach-omap1/board-palmte.c
+++ b/arch/arm/mach-omap1/board-palmte.c
@@ -265,7 +265,6 @@ MACHINE_START(OMAP_PALMTE, "OMAP310 based Palm Tungsten E")
 	.atag_offset	= 0x100,
 	.map_io		= omap15xx_map_io,
 	.init_early     = omap1_init_early,
-	.reserve	= omap_reserve,
 	.init_irq	= omap1_init_irq,
 	.init_machine	= omap_palmte_init,
 	.init_late	= omap1_init_late,
diff --git a/arch/arm/mach-omap1/board-palmtt.c b/arch/arm/mach-omap1/board-palmtt.c
index 3c06c0b..38e75a7 100644
--- a/arch/arm/mach-omap1/board-palmtt.c
+++ b/arch/arm/mach-omap1/board-palmtt.c
@@ -311,7 +311,6 @@ MACHINE_START(OMAP_PALMTT, "OMAP1510 based Palm Tungsten|T")
 	.atag_offset	= 0x100,
 	.map_io		= omap15xx_map_io,
 	.init_early     = omap1_init_early,
-	.reserve	= omap_reserve,
 	.init_irq	= omap1_init_irq,
 	.init_machine	= omap_palmtt_init,
 	.init_late	= omap1_init_late,
diff --git a/arch/arm/mach-omap1/board-palmz71.c b/arch/arm/mach-omap1/board-palmz71.c
index be16edd..41e8726 100644
--- a/arch/arm/mach-omap1/board-palmz71.c
+++ b/arch/arm/mach-omap1/board-palmz71.c
@@ -327,7 +327,6 @@ MACHINE_START(OMAP_PALMZ71, "OMAP310 based Palm Zire71")
 	.atag_offset	= 0x100,
 	.map_io		= omap15xx_map_io,
 	.init_early     = omap1_init_early,
-	.reserve	= omap_reserve,
 	.init_irq	= omap1_init_irq,
 	.init_machine	= omap_palmz71_init,
 	.init_late	= omap1_init_late,
diff --git a/arch/arm/mach-omap1/board-perseus2.c b/arch/arm/mach-omap1/board-perseus2.c
index 198b054..5fc074a 100644
--- a/arch/arm/mach-omap1/board-perseus2.c
+++ b/arch/arm/mach-omap1/board-perseus2.c
@@ -324,7 +324,6 @@ MACHINE_START(OMAP_PERSEUS2, "OMAP730 Perseus2")
 	.atag_offset	= 0x100,
 	.map_io		= omap_perseus2_map_io,
 	.init_early     = omap1_init_early,
-	.reserve	= omap_reserve,
 	.init_irq	= omap1_init_irq,
 	.init_machine	= omap_perseus2_init,
 	.init_late	= omap1_init_late,
diff --git a/arch/arm/mach-omap1/board-sx1.c b/arch/arm/mach-omap1/board-sx1.c
index f4c5db9..b2bcf31 100644
--- a/arch/arm/mach-omap1/board-sx1.c
+++ b/arch/arm/mach-omap1/board-sx1.c
@@ -404,7 +404,6 @@ MACHINE_START(SX1, "OMAP310 based Siemens SX1")
 	.atag_offset	= 0x100,
 	.map_io		= omap15xx_map_io,
 	.init_early     = omap1_init_early,
-	.reserve	= omap_reserve,
 	.init_irq	= omap1_init_irq,
 	.init_machine	= omap_sx1_init,
 	.init_late	= omap1_init_late,
diff --git a/arch/arm/mach-omap1/board-voiceblue.c b/arch/arm/mach-omap1/board-voiceblue.c
index ad75e34..1a21101 100644
--- a/arch/arm/mach-omap1/board-voiceblue.c
+++ b/arch/arm/mach-omap1/board-voiceblue.c
@@ -286,7 +286,6 @@ MACHINE_START(VOICEBLUE, "VoiceBlue OMAP5910")
 	.atag_offset	= 0x100,
 	.map_io		= omap15xx_map_io,
 	.init_early     = omap1_init_early,
-	.reserve	= omap_reserve,
 	.init_irq	= omap1_init_irq,
 	.init_machine	= voiceblue_init,
 	.init_late	= omap1_init_late,
-- 
1.7.10.4

