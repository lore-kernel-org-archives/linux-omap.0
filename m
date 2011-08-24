From: Venkatraman S <svenkatr@ti.com>
Subject: [PATCH 2/2] omap1: Populate nr_irqs field in machine descriptors
Date: Thu, 25 Aug 2011 01:16:55 +0530
Message-ID: <1314215215-18683-3-git-send-email-svenkatr@ti.com>
References: <1314215215-18683-1-git-send-email-svenkatr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33719 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750767Ab1HXTr3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Aug 2011 15:47:29 -0400
In-Reply-To: <1314215215-18683-1-git-send-email-svenkatr@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Venkatraman S <svenkatr@ti.com>

Machine descriptors in board files should have valid
nr_irqs value so that irq handler code can probe it.

Signed-off-by: Venkatraman S <svenkatr@ti.com>
---
 arch/arm/mach-omap1/board-ams-delta.c |    1 +
 arch/arm/mach-omap1/board-fsample.c   |    1 +
 arch/arm/mach-omap1/board-generic.c   |    1 +
 arch/arm/mach-omap1/board-h2.c        |    1 +
 arch/arm/mach-omap1/board-h3.c        |    1 +
 arch/arm/mach-omap1/board-htcherald.c |    1 +
 arch/arm/mach-omap1/board-innovator.c |    1 +
 arch/arm/mach-omap1/board-nokia770.c  |    1 +
 arch/arm/mach-omap1/board-osk.c       |    1 +
 arch/arm/mach-omap1/board-palmte.c    |    1 +
 arch/arm/mach-omap1/board-palmtt.c    |    1 +
 arch/arm/mach-omap1/board-palmz71.c   |    1 +
 arch/arm/mach-omap1/board-perseus2.c  |    1 +
 arch/arm/mach-omap1/board-sx1.c       |    1 +
 arch/arm/mach-omap1/board-voiceblue.c |    1 +
 15 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index 312ea6b..496c07f 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -392,6 +392,7 @@ MACHINE_START(AMS_DELTA, "Amstrad E3 (Delta)")
 	.init_irq	= ams_delta_init_irq,
 	.init_machine	= ams_delta_init,
 	.timer		= &omap1_timer,
+	.nr_irqs 	= NR_IRQS,
 MACHINE_END
 
 EXPORT_SYMBOL(ams_delta_latch1_write);
diff --git a/arch/arm/mach-omap1/board-fsample.c b/arch/arm/mach-omap1/board-fsample.c
index a6b1bea..c76373e 100644
--- a/arch/arm/mach-omap1/board-fsample.c
+++ b/arch/arm/mach-omap1/board-fsample.c
@@ -395,4 +395,5 @@ MACHINE_START(OMAP_FSAMPLE, "OMAP730 F-Sample")
 	.init_irq	= omap_fsample_init_irq,
 	.init_machine	= omap_fsample_init,
 	.timer		= &omap1_timer,
+	.nr_irqs 	= NR_IRQS,
 MACHINE_END
diff --git a/arch/arm/mach-omap1/board-generic.c b/arch/arm/mach-omap1/board-generic.c
index 04fc356..f5cec3e 100644
--- a/arch/arm/mach-omap1/board-generic.c
+++ b/arch/arm/mach-omap1/board-generic.c
@@ -100,4 +100,5 @@ MACHINE_START(OMAP_GENERIC, "Generic OMAP1510/1610/1710")
 	.init_irq	= omap_generic_init_irq,
 	.init_machine	= omap_generic_init,
 	.timer		= &omap1_timer,
+	.nr_irqs 	= NR_IRQS,
 MACHINE_END
diff --git a/arch/arm/mach-omap1/board-h2.c b/arch/arm/mach-omap1/board-h2.c
index cb7fb1a..7dca560 100644
--- a/arch/arm/mach-omap1/board-h2.c
+++ b/arch/arm/mach-omap1/board-h2.c
@@ -467,4 +467,5 @@ MACHINE_START(OMAP_H2, "TI-H2")
 	.init_irq	= h2_init_irq,
 	.init_machine	= h2_init,
 	.timer		= &omap1_timer,
+	.nr_irqs 	= NR_IRQS,
 MACHINE_END
diff --git a/arch/arm/mach-omap1/board-h3.c b/arch/arm/mach-omap1/board-h3.c
index 31f3487..bd27504 100644
--- a/arch/arm/mach-omap1/board-h3.c
+++ b/arch/arm/mach-omap1/board-h3.c
@@ -455,4 +455,5 @@ MACHINE_START(OMAP_H3, "TI OMAP1710 H3 board")
 	.init_irq	= h3_init_irq,
 	.init_machine	= h3_init,
 	.timer		= &omap1_timer,
+	.nr_irqs 	= NR_IRQS,
 MACHINE_END
diff --git a/arch/arm/mach-omap1/board-htcherald.c b/arch/arm/mach-omap1/board-htcherald.c
index 36e06ea..380310c 100644
--- a/arch/arm/mach-omap1/board-htcherald.c
+++ b/arch/arm/mach-omap1/board-htcherald.c
@@ -617,4 +617,5 @@ MACHINE_START(HERALD, "HTC Herald")
 	.init_irq       = htcherald_init_irq,
 	.init_machine   = htcherald_init,
 	.timer          = &omap1_timer,
+	.nr_irqs 	= NR_IRQS,
 MACHINE_END
diff --git a/arch/arm/mach-omap1/board-innovator.c b/arch/arm/mach-omap1/board-innovator.c
index 0b1ba46..64b9764 100644
--- a/arch/arm/mach-omap1/board-innovator.c
+++ b/arch/arm/mach-omap1/board-innovator.c
@@ -465,4 +465,5 @@ MACHINE_START(OMAP_INNOVATOR, "TI-Innovator")
 	.init_irq	= innovator_init_irq,
 	.init_machine	= innovator_init,
 	.timer		= &omap1_timer,
+	.nr_irqs 	= NR_IRQS,
 MACHINE_END
diff --git a/arch/arm/mach-omap1/board-nokia770.c b/arch/arm/mach-omap1/board-nokia770.c
index 5469ce2..77e8bad 100644
--- a/arch/arm/mach-omap1/board-nokia770.c
+++ b/arch/arm/mach-omap1/board-nokia770.c
@@ -270,4 +270,5 @@ MACHINE_START(NOKIA770, "Nokia 770")
 	.init_irq	= omap_nokia770_init_irq,
 	.init_machine	= omap_nokia770_init,
 	.timer		= &omap1_timer,
+	.nr_irqs 	= NR_IRQS,
 MACHINE_END
diff --git a/arch/arm/mach-omap1/board-osk.c b/arch/arm/mach-omap1/board-osk.c
index b08a213..5c9f6ec 100644
--- a/arch/arm/mach-omap1/board-osk.c
+++ b/arch/arm/mach-omap1/board-osk.c
@@ -589,4 +589,5 @@ MACHINE_START(OMAP_OSK, "TI-OSK")
 	.init_irq	= osk_init_irq,
 	.init_machine	= osk_init,
 	.timer		= &omap1_timer,
+	.nr_irqs 	= NR_IRQS,
 MACHINE_END
diff --git a/arch/arm/mach-omap1/board-palmte.c b/arch/arm/mach-omap1/board-palmte.c
index 459cb6b..8266a65 100644
--- a/arch/arm/mach-omap1/board-palmte.c
+++ b/arch/arm/mach-omap1/board-palmte.c
@@ -281,4 +281,5 @@ MACHINE_START(OMAP_PALMTE, "OMAP310 based Palm Tungsten E")
 	.init_irq	= omap_palmte_init_irq,
 	.init_machine	= omap_palmte_init,
 	.timer		= &omap1_timer,
+	.nr_irqs 	= NR_IRQS,
 MACHINE_END
diff --git a/arch/arm/mach-omap1/board-palmtt.c b/arch/arm/mach-omap1/board-palmtt.c
index b214f45..f2f29eb 100644
--- a/arch/arm/mach-omap1/board-palmtt.c
+++ b/arch/arm/mach-omap1/board-palmtt.c
@@ -327,4 +327,5 @@ MACHINE_START(OMAP_PALMTT, "OMAP1510 based Palm Tungsten|T")
 	.init_irq	= omap_palmtt_init_irq,
 	.init_machine	= omap_palmtt_init,
 	.timer		= &omap1_timer,
+	.nr_irqs 	= NR_IRQS,
 MACHINE_END
diff --git a/arch/arm/mach-omap1/board-palmz71.c b/arch/arm/mach-omap1/board-palmz71.c
index 9b0ea48..e2f2c06 100644
--- a/arch/arm/mach-omap1/board-palmz71.c
+++ b/arch/arm/mach-omap1/board-palmz71.c
@@ -347,4 +347,5 @@ MACHINE_START(OMAP_PALMZ71, "OMAP310 based Palm Zire71")
 	.init_irq	= omap_palmz71_init_irq,
 	.init_machine	= omap_palmz71_init,
 	.timer		= &omap1_timer,
+	.nr_irqs 	= NR_IRQS,
 MACHINE_END
diff --git a/arch/arm/mach-omap1/board-perseus2.c b/arch/arm/mach-omap1/board-perseus2.c
index 67acd41..6f99559 100644
--- a/arch/arm/mach-omap1/board-perseus2.c
+++ b/arch/arm/mach-omap1/board-perseus2.c
@@ -356,4 +356,5 @@ MACHINE_START(OMAP_PERSEUS2, "OMAP730 Perseus2")
 	.init_irq	= omap_perseus2_init_irq,
 	.init_machine	= omap_perseus2_init,
 	.timer		= &omap1_timer,
+	.nr_irqs 	= NR_IRQS,
 MACHINE_END
diff --git a/arch/arm/mach-omap1/board-sx1.c b/arch/arm/mach-omap1/board-sx1.c
index 9c3b7c5..55f2801 100644
--- a/arch/arm/mach-omap1/board-sx1.c
+++ b/arch/arm/mach-omap1/board-sx1.c
@@ -427,4 +427,5 @@ MACHINE_START(SX1, "OMAP310 based Siemens SX1")
 	.init_irq	= omap_sx1_init_irq,
 	.init_machine	= omap_sx1_init,
 	.timer		= &omap1_timer,
+	.nr_irqs 	= NR_IRQS,
 MACHINE_END
diff --git a/arch/arm/mach-omap1/board-voiceblue.c b/arch/arm/mach-omap1/board-voiceblue.c
index 036edc0..a955650 100644
--- a/arch/arm/mach-omap1/board-voiceblue.c
+++ b/arch/arm/mach-omap1/board-voiceblue.c
@@ -307,4 +307,5 @@ MACHINE_START(VOICEBLUE, "VoiceBlue OMAP5910")
 	.init_irq	= voiceblue_init_irq,
 	.init_machine	= voiceblue_init,
 	.timer		= &omap1_timer,
+	.nr_irqs 	= NR_IRQS,
 MACHINE_END
-- 
1.7.1

