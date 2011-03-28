From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 02/10] omap: Set separate timer init functions to avoid
	cpu_is_omap tests
Date: Mon, 28 Mar 2011 15:21:32 -0700
Message-ID: <20110328222132.4046.44058.stgit@baageli.muru.com>
References: <20110328221501.4046.41079.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:20298 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755144Ab1C1WVe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Mar 2011 18:21:34 -0400
In-Reply-To: <20110328221501.4046.41079.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

This is needed for the following patches to initialize non-sys_timer
hardware later on. Again, there's no need to do cpu_is_omap calls
as we only care about the major omap generation. We can do this with
the .timer entry alone.

Note that for now we just set stubs for the various sys_timer
entries that will get populated in a later patch. Also the following
patches will remove the omap_dm_timer_init calls and make it an
arch_initcall.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/board-ams-delta.c      |    2 -
 arch/arm/mach-omap1/board-fsample.c        |    2 -
 arch/arm/mach-omap1/board-generic.c        |    2 -
 arch/arm/mach-omap1/board-h2.c             |    2 -
 arch/arm/mach-omap1/board-h3.c             |    2 -
 arch/arm/mach-omap1/board-htcherald.c      |    2 -
 arch/arm/mach-omap1/board-innovator.c      |    2 -
 arch/arm/mach-omap1/board-nokia770.c       |    2 -
 arch/arm/mach-omap1/board-osk.c            |    2 -
 arch/arm/mach-omap1/board-palmte.c         |    2 -
 arch/arm/mach-omap1/board-palmtt.c         |    2 -
 arch/arm/mach-omap1/board-palmz71.c        |    2 -
 arch/arm/mach-omap1/board-perseus2.c       |    2 -
 arch/arm/mach-omap1/board-sx1.c            |    2 -
 arch/arm/mach-omap1/board-voiceblue.c      |    2 -
 arch/arm/mach-omap1/time.c                 |    6 +--
 arch/arm/mach-omap2/board-2430sdp.c        |    2 -
 arch/arm/mach-omap2/board-3430sdp.c        |    2 -
 arch/arm/mach-omap2/board-3630sdp.c        |    2 -
 arch/arm/mach-omap2/board-4430sdp.c        |    2 -
 arch/arm/mach-omap2/board-am3517crane.c    |    2 -
 arch/arm/mach-omap2/board-am3517evm.c      |    2 -
 arch/arm/mach-omap2/board-apollon.c        |    2 -
 arch/arm/mach-omap2/board-cm-t35.c         |    2 -
 arch/arm/mach-omap2/board-cm-t3517.c       |    2 -
 arch/arm/mach-omap2/board-devkit8000.c     |    2 -
 arch/arm/mach-omap2/board-generic.c        |    2 -
 arch/arm/mach-omap2/board-h4.c             |    2 -
 arch/arm/mach-omap2/board-igep0020.c       |    2 -
 arch/arm/mach-omap2/board-igep0030.c       |    2 -
 arch/arm/mach-omap2/board-ldp.c            |    2 -
 arch/arm/mach-omap2/board-n8x0.c           |    6 +--
 arch/arm/mach-omap2/board-omap3beagle.c    |    2 -
 arch/arm/mach-omap2/board-omap3evm.c       |    2 -
 arch/arm/mach-omap2/board-omap3logic.c     |    4 +-
 arch/arm/mach-omap2/board-omap3pandora.c   |    2 -
 arch/arm/mach-omap2/board-omap3stalker.c   |    2 -
 arch/arm/mach-omap2/board-omap3touchbook.c |    2 -
 arch/arm/mach-omap2/board-omap4panda.c     |    2 -
 arch/arm/mach-omap2/board-overo.c          |    2 -
 arch/arm/mach-omap2/board-rm680.c          |    2 -
 arch/arm/mach-omap2/board-rx51.c           |    2 -
 arch/arm/mach-omap2/board-ti8168evm.c      |    2 -
 arch/arm/mach-omap2/board-zoom.c           |    4 +-
 arch/arm/mach-omap2/timer-gp.c             |   63 ++++++++++++++++++++++++----
 arch/arm/plat-omap/include/plat/common.h   |    7 +++
 arch/arm/plat-omap/include/plat/dmtimer.h  |    1 
 47 files changed, 111 insertions(+), 60 deletions(-)

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index 17ed757..f1ac7fb 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -391,7 +391,7 @@ MACHINE_START(AMS_DELTA, "Amstrad E3 (Delta)")
 	.reserve	= omap_reserve,
 	.init_irq	= ams_delta_init_irq,
 	.init_machine	= ams_delta_init,
-	.timer		= &omap_timer,
+	.timer		= &omap1_timer,
 MACHINE_END
 
 EXPORT_SYMBOL(ams_delta_latch1_write);
diff --git a/arch/arm/mach-omap1/board-fsample.c b/arch/arm/mach-omap1/board-fsample.c
index eaff305..a6b1bea 100644
--- a/arch/arm/mach-omap1/board-fsample.c
+++ b/arch/arm/mach-omap1/board-fsample.c
@@ -394,5 +394,5 @@ MACHINE_START(OMAP_FSAMPLE, "OMAP730 F-Sample")
 	.reserve	= omap_reserve,
 	.init_irq	= omap_fsample_init_irq,
 	.init_machine	= omap_fsample_init,
-	.timer		= &omap_timer,
+	.timer		= &omap1_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap1/board-generic.c b/arch/arm/mach-omap1/board-generic.c
index 3fd6b40..04fc356 100644
--- a/arch/arm/mach-omap1/board-generic.c
+++ b/arch/arm/mach-omap1/board-generic.c
@@ -99,5 +99,5 @@ MACHINE_START(OMAP_GENERIC, "Generic OMAP1510/1610/1710")
 	.reserve	= omap_reserve,
 	.init_irq	= omap_generic_init_irq,
 	.init_machine	= omap_generic_init,
-	.timer		= &omap_timer,
+	.timer		= &omap1_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap1/board-h2.c b/arch/arm/mach-omap1/board-h2.c
index 8147b04..cb7fb1a 100644
--- a/arch/arm/mach-omap1/board-h2.c
+++ b/arch/arm/mach-omap1/board-h2.c
@@ -466,5 +466,5 @@ MACHINE_START(OMAP_H2, "TI-H2")
 	.reserve	= omap_reserve,
 	.init_irq	= h2_init_irq,
 	.init_machine	= h2_init,
-	.timer		= &omap_timer,
+	.timer		= &omap1_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap1/board-h3.c b/arch/arm/mach-omap1/board-h3.c
index 1b448f6..31f3487 100644
--- a/arch/arm/mach-omap1/board-h3.c
+++ b/arch/arm/mach-omap1/board-h3.c
@@ -454,5 +454,5 @@ MACHINE_START(OMAP_H3, "TI OMAP1710 H3 board")
 	.reserve	= omap_reserve,
 	.init_irq	= h3_init_irq,
 	.init_machine	= h3_init,
-	.timer		= &omap_timer,
+	.timer		= &omap1_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap1/board-htcherald.c b/arch/arm/mach-omap1/board-htcherald.c
index 1bd4d8e..36e06ea 100644
--- a/arch/arm/mach-omap1/board-htcherald.c
+++ b/arch/arm/mach-omap1/board-htcherald.c
@@ -616,5 +616,5 @@ MACHINE_START(HERALD, "HTC Herald")
 	.reserve	= omap_reserve,
 	.init_irq       = htcherald_init_irq,
 	.init_machine   = htcherald_init,
-	.timer          = &omap_timer,
+	.timer          = &omap1_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap1/board-innovator.c b/arch/arm/mach-omap1/board-innovator.c
index 5926b0c..0b1ba46 100644
--- a/arch/arm/mach-omap1/board-innovator.c
+++ b/arch/arm/mach-omap1/board-innovator.c
@@ -464,5 +464,5 @@ MACHINE_START(OMAP_INNOVATOR, "TI-Innovator")
 	.reserve	= omap_reserve,
 	.init_irq	= innovator_init_irq,
 	.init_machine	= innovator_init,
-	.timer		= &omap_timer,
+	.timer		= &omap1_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap1/board-nokia770.c b/arch/arm/mach-omap1/board-nokia770.c
index e3cf21d..5469ce2 100644
--- a/arch/arm/mach-omap1/board-nokia770.c
+++ b/arch/arm/mach-omap1/board-nokia770.c
@@ -269,5 +269,5 @@ MACHINE_START(NOKIA770, "Nokia 770")
 	.reserve	= omap_reserve,
 	.init_irq	= omap_nokia770_init_irq,
 	.init_machine	= omap_nokia770_init,
-	.timer		= &omap_timer,
+	.timer		= &omap1_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap1/board-osk.c b/arch/arm/mach-omap1/board-osk.c
index aed8202..2de8791 100644
--- a/arch/arm/mach-omap1/board-osk.c
+++ b/arch/arm/mach-omap1/board-osk.c
@@ -588,5 +588,5 @@ MACHINE_START(OMAP_OSK, "TI-OSK")
 	.reserve	= omap_reserve,
 	.init_irq	= osk_init_irq,
 	.init_machine	= osk_init,
-	.timer		= &omap_timer,
+	.timer		= &omap1_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap1/board-palmte.c b/arch/arm/mach-omap1/board-palmte.c
index 8b6a881..459cb6b 100644
--- a/arch/arm/mach-omap1/board-palmte.c
+++ b/arch/arm/mach-omap1/board-palmte.c
@@ -280,5 +280,5 @@ MACHINE_START(OMAP_PALMTE, "OMAP310 based Palm Tungsten E")
 	.reserve	= omap_reserve,
 	.init_irq	= omap_palmte_init_irq,
 	.init_machine	= omap_palmte_init,
-	.timer		= &omap_timer,
+	.timer		= &omap1_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap1/board-palmtt.c b/arch/arm/mach-omap1/board-palmtt.c
index f2de43d..b214f45 100644
--- a/arch/arm/mach-omap1/board-palmtt.c
+++ b/arch/arm/mach-omap1/board-palmtt.c
@@ -326,5 +326,5 @@ MACHINE_START(OMAP_PALMTT, "OMAP1510 based Palm Tungsten|T")
 	.reserve	= omap_reserve,
 	.init_irq	= omap_palmtt_init_irq,
 	.init_machine	= omap_palmtt_init,
-	.timer		= &omap_timer,
+	.timer		= &omap1_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap1/board-palmz71.c b/arch/arm/mach-omap1/board-palmz71.c
index 7904018..be8f5c6 100644
--- a/arch/arm/mach-omap1/board-palmz71.c
+++ b/arch/arm/mach-omap1/board-palmz71.c
@@ -346,5 +346,5 @@ MACHINE_START(OMAP_PALMZ71, "OMAP310 based Palm Zire71")
 	.reserve	= omap_reserve,
 	.init_irq	= omap_palmz71_init_irq,
 	.init_machine	= omap_palmz71_init,
-	.timer		= &omap_timer,
+	.timer		= &omap1_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap1/board-perseus2.c b/arch/arm/mach-omap1/board-perseus2.c
index 7f019e5..67acd41 100644
--- a/arch/arm/mach-omap1/board-perseus2.c
+++ b/arch/arm/mach-omap1/board-perseus2.c
@@ -355,5 +355,5 @@ MACHINE_START(OMAP_PERSEUS2, "OMAP730 Perseus2")
 	.reserve	= omap_reserve,
 	.init_irq	= omap_perseus2_init_irq,
 	.init_machine	= omap_perseus2_init,
-	.timer		= &omap_timer,
+	.timer		= &omap1_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap1/board-sx1.c b/arch/arm/mach-omap1/board-sx1.c
index 027520f..9e43cd9 100644
--- a/arch/arm/mach-omap1/board-sx1.c
+++ b/arch/arm/mach-omap1/board-sx1.c
@@ -426,5 +426,5 @@ MACHINE_START(SX1, "OMAP310 based Siemens SX1")
 	.reserve	= omap_reserve,
 	.init_irq	= omap_sx1_init_irq,
 	.init_machine	= omap_sx1_init,
-	.timer		= &omap_timer,
+	.timer		= &omap1_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap1/board-voiceblue.c b/arch/arm/mach-omap1/board-voiceblue.c
index a843f4c..6e67ae1 100644
--- a/arch/arm/mach-omap1/board-voiceblue.c
+++ b/arch/arm/mach-omap1/board-voiceblue.c
@@ -306,5 +306,5 @@ MACHINE_START(VOICEBLUE, "VoiceBlue OMAP5910")
 	.reserve	= omap_reserve,
 	.init_irq	= voiceblue_init_irq,
 	.init_machine	= voiceblue_init,
-	.timer		= &omap_timer,
+	.timer		= &omap1_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap1/time.c b/arch/arm/mach-omap1/time.c
index 6885d2f..df9c9a6 100644
--- a/arch/arm/mach-omap1/time.c
+++ b/arch/arm/mach-omap1/time.c
@@ -322,7 +322,7 @@ static inline int omap_32k_timer_usable(void)
  * Timer initialization
  * ---------------------------------------------------------------------------
  */
-static void __init omap_timer_init(void)
+static void __init omap1_timer_init(void)
 {
 	if (omap_32k_timer_usable()) {
 		preferred_sched_clock_init(1);
@@ -332,6 +332,6 @@ static void __init omap_timer_init(void)
 	}
 }
 
-struct sys_timer omap_timer = {
-	.init		= omap_timer_init,
+struct sys_timer omap1_timer = {
+	.init		= omap1_timer_init,
 };
diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index 3d5a1de..aa61aef 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -279,5 +279,5 @@ MACHINE_START(OMAP_2430SDP, "OMAP2430 sdp2430 board")
 	.init_early	= omap_2430sdp_init_early,
 	.init_irq	= omap2_init_irq,
 	.init_machine	= omap_2430sdp_init,
-	.timer		= &omap_timer,
+	.timer		= &omap243x_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 8859a74..7194546 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -911,5 +911,5 @@ MACHINE_START(OMAP_3430SDP, "OMAP3430 3430SDP board")
 	.init_early	= omap_3430sdp_init_early,
 	.init_irq	= omap3_init_irq,
 	.init_machine	= omap_3430sdp_init,
-	.timer		= &omap_timer,
+	.timer		= &omap3_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-3630sdp.c b/arch/arm/mach-omap2/board-3630sdp.c
index 2ec2d76..e4f37b5 100644
--- a/arch/arm/mach-omap2/board-3630sdp.c
+++ b/arch/arm/mach-omap2/board-3630sdp.c
@@ -221,5 +221,5 @@ MACHINE_START(OMAP_3630SDP, "OMAP 3630SDP board")
 	.init_early	= omap_sdp_init_early,
 	.init_irq	= omap3_init_irq,
 	.init_machine	= omap_sdp_init,
-	.timer		= &omap_timer,
+	.timer		= &omap3_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 56702c5..f740c40 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -827,5 +827,5 @@ MACHINE_START(OMAP_4430SDP, "OMAP4430 4430SDP board")
 	.init_early	= omap_4430sdp_init_early,
 	.init_irq	= gic_init_irq,
 	.init_machine	= omap_4430sdp_init,
-	.timer		= &omap_timer,
+	.timer		= &omap4_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-am3517crane.c b/arch/arm/mach-omap2/board-am3517crane.c
index bbd9c14..d70007c 100644
--- a/arch/arm/mach-omap2/board-am3517crane.c
+++ b/arch/arm/mach-omap2/board-am3517crane.c
@@ -112,5 +112,5 @@ MACHINE_START(CRANEBOARD, "AM3517/05 CRANEBOARD")
 	.init_early	= am3517_crane_init_early,
 	.init_irq	= omap3_init_irq,
 	.init_machine	= am3517_crane_init,
-	.timer		= &omap_timer,
+	.timer		= &omap3_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index 6fc0479..7195b1a 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -518,5 +518,5 @@ MACHINE_START(OMAP3517EVM, "OMAP3517/AM3517 EVM")
 	.init_early	= am3517_evm_init_early,
 	.init_irq	= omap3_init_irq,
 	.init_machine	= am3517_evm_init,
-	.timer		= &omap_timer,
+	.timer		= &omap3_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-apollon.c b/arch/arm/mach-omap2/board-apollon.c
index e764c9c..2507b07 100644
--- a/arch/arm/mach-omap2/board-apollon.c
+++ b/arch/arm/mach-omap2/board-apollon.c
@@ -359,5 +359,5 @@ MACHINE_START(OMAP_APOLLON, "OMAP24xx Apollon")
 	.init_early	= omap_apollon_init_early,
 	.init_irq	= omap2_init_irq,
 	.init_machine	= omap_apollon_init,
-	.timer		= &omap_timer,
+	.timer		= &omap242x_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index bc37d72..b85f34e 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -808,5 +808,5 @@ MACHINE_START(CM_T35, "Compulab CM-T35")
 	.init_early	= cm_t35_init_early,
 	.init_irq	= omap3_init_irq,
 	.init_machine	= cm_t35_init,
-	.timer		= &omap_timer,
+	.timer		= &omap3_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-cm-t3517.c b/arch/arm/mach-omap2/board-cm-t3517.c
index b5618a6..6c4d08c 100644
--- a/arch/arm/mach-omap2/board-cm-t3517.c
+++ b/arch/arm/mach-omap2/board-cm-t3517.c
@@ -308,5 +308,5 @@ MACHINE_START(CM_T3517, "Compulab CM-T3517")
 	.init_early	= cm_t3517_init_early,
 	.init_irq	= omap3_init_irq,
 	.init_machine	= cm_t3517_init,
-	.timer		= &omap_timer,
+	.timer		= &omap3_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 9fedcd6..cd465fa 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -816,5 +816,5 @@ MACHINE_START(DEVKIT8000, "OMAP3 Devkit8000")
 	.init_early	= devkit8000_init_early,
 	.init_irq	= devkit8000_init_irq,
 	.init_machine	= devkit8000_init,
-	.timer		= &omap_timer,
+	.timer		= &omap3_beagle_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index ccd503a..c6ecf60 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -72,5 +72,5 @@ MACHINE_START(OMAP_GENERIC, "Generic OMAP24xx")
 	.init_early	= omap_generic_init_early,
 	.init_irq	= omap2_init_irq,
 	.init_machine	= omap_generic_init,
-	.timer		= &omap_timer,
+	.timer		= &omap3_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
index 2e16d6c..1a22962 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -388,5 +388,5 @@ MACHINE_START(OMAP_H4, "OMAP2420 H4 board")
 	.init_early	= omap_h4_init_early,
 	.init_irq	= omap_h4_init_irq,
 	.init_machine	= omap_h4_init,
-	.timer		= &omap_timer,
+	.timer		= &omap242x_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index 8bf2650..aee8861 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -710,5 +710,5 @@ MACHINE_START(IGEP0020, "IGEP v2 board")
 	.init_early	= igep2_init_early,
 	.init_irq	= omap3_init_irq,
 	.init_machine	= igep2_init,
-	.timer		= &omap_timer,
+	.timer		= &omap3_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-igep0030.c b/arch/arm/mach-omap2/board-igep0030.c
index f83a0fe..6077113 100644
--- a/arch/arm/mach-omap2/board-igep0030.c
+++ b/arch/arm/mach-omap2/board-igep0030.c
@@ -454,5 +454,5 @@ MACHINE_START(IGEP0030, "IGEP OMAP3 module")
 	.init_early	= igep3_init_early,
 	.init_irq	= omap3_init_irq,
 	.init_machine	= igep3_init,
-	.timer		= &omap_timer,
+	.timer		= &omap3_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index 5036e7d..e96d51f 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -468,5 +468,5 @@ MACHINE_START(OMAP_LDP, "OMAP LDP board")
 	.init_early	= omap_ldp_init_early,
 	.init_irq	= omap3_init_irq,
 	.init_machine	= omap_ldp_init,
-	.timer		= &omap_timer,
+	.timer		= &omap3_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
index cf9e980..4906e32 100644
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -707,7 +707,7 @@ MACHINE_START(NOKIA_N800, "Nokia N800")
 	.init_early	= n8x0_init_early,
 	.init_irq	= omap2_init_irq,
 	.init_machine	= n8x0_init_machine,
-	.timer		= &omap_timer,
+	.timer		= &omap242x_timer,
 MACHINE_END
 
 MACHINE_START(NOKIA_N810, "Nokia N810")
@@ -717,7 +717,7 @@ MACHINE_START(NOKIA_N810, "Nokia N810")
 	.init_early	= n8x0_init_early,
 	.init_irq	= omap2_init_irq,
 	.init_machine	= n8x0_init_machine,
-	.timer		= &omap_timer,
+	.timer		= &omap242x_timer,
 MACHINE_END
 
 MACHINE_START(NOKIA_N810_WIMAX, "Nokia N810 WiMAX")
@@ -727,5 +727,5 @@ MACHINE_START(NOKIA_N810_WIMAX, "Nokia N810 WiMAX")
 	.init_early	= n8x0_init_early,
 	.init_irq	= omap2_init_irq,
 	.init_machine	= n8x0_init_machine,
-	.timer		= &omap_timer,
+	.timer		= &omap242x_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 8db46ec..a4206be 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -689,5 +689,5 @@ MACHINE_START(OMAP3_BEAGLE, "OMAP3 Beagle Board")
 	.init_early	= omap3_beagle_init_early,
 	.init_irq	= omap3_beagle_init_irq,
 	.init_machine	= omap3_beagle_init,
-	.timer		= &omap_timer,
+	.timer		= &omap3_beagle_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index ddddd3c..4e08569 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -896,5 +896,5 @@ MACHINE_START(OMAP3EVM, "OMAP3 EVM")
 	.init_early	= omap3_evm_init_early,
 	.init_irq	= omap3_init_irq,
 	.init_machine	= omap3_evm_init,
-	.timer		= &omap_timer,
+	.timer		= &omap3_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-omap3logic.c b/arch/arm/mach-omap2/board-omap3logic.c
index 2183199..7e8ce0a 100644
--- a/arch/arm/mach-omap2/board-omap3logic.c
+++ b/arch/arm/mach-omap2/board-omap3logic.c
@@ -227,7 +227,7 @@ MACHINE_START(OMAP3_TORPEDO, "Logic OMAP3 Torpedo board")
 	.init_early	= omap3logic_init_early,
 	.init_irq	= omap3_init_irq,
 	.init_machine	= omap3logic_init,
-	.timer		= &omap_timer,
+	.timer		= &omap3_timer,
 MACHINE_END
 
 MACHINE_START(OMAP3530_LV_SOM, "OMAP Logic 3530 LV SOM board")
@@ -236,5 +236,5 @@ MACHINE_START(OMAP3530_LV_SOM, "OMAP Logic 3530 LV SOM board")
 	.init_early	= omap3logic_init_early,
 	.init_irq	= omap3_init_irq,
 	.init_machine	= omap3logic_init,
-	.timer		= &omap_timer,
+	.timer		= &omap3_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index 06d532c..aea233c 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -722,5 +722,5 @@ MACHINE_START(OMAP3_PANDORA, "Pandora Handheld Console")
 	.init_early	= omap3pandora_init_early,
 	.init_irq	= omap3_init_irq,
 	.init_machine	= omap3pandora_init,
-	.timer		= &omap_timer,
+	.timer		= &omap3_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-omap3stalker.c b/arch/arm/mach-omap2/board-omap3stalker.c
index e5e37cb..fd863cf 100644
--- a/arch/arm/mach-omap2/board-omap3stalker.c
+++ b/arch/arm/mach-omap2/board-omap3stalker.c
@@ -661,5 +661,5 @@ MACHINE_START(SBC3530, "OMAP3 STALKER")
 	.init_early		= omap3_stalker_init_early,
 	.init_irq		= omap3_stalker_init_irq,
 	.init_machine		= omap3_stalker_init,
-	.timer			= &omap_timer,
+	.timer			= &omap3_beagle_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-omap3touchbook.c b/arch/arm/mach-omap2/board-omap3touchbook.c
index c9261d4..84f4be0 100644
--- a/arch/arm/mach-omap2/board-omap3touchbook.c
+++ b/arch/arm/mach-omap2/board-omap3touchbook.c
@@ -546,5 +546,5 @@ MACHINE_START(TOUCHBOOK, "OMAP3 touchbook Board")
 	.init_early	= omap3_touchbook_init_early,
 	.init_irq	= omap3_touchbook_init_irq,
 	.init_machine	= omap3_touchbook_init,
-	.timer		= &omap_timer,
+	.timer		= &omap3_beagle_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index f3a7b10..e7ce10d 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -749,5 +749,5 @@ MACHINE_START(OMAP4_PANDA, "OMAP4 Panda board")
 	.init_early	= omap4_panda_init_early,
 	.init_irq	= gic_init_irq,
 	.init_machine	= omap4_panda_init,
-	.timer		= &omap_timer,
+	.timer		= &omap4_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index 826df4b..f221463 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -792,5 +792,5 @@ MACHINE_START(OVERO, "Gumstix Overo")
 	.init_early	= overo_init_early,
 	.init_irq	= omap3_init_irq,
 	.init_machine	= overo_init,
-	.timer		= &omap_timer,
+	.timer		= &omap3_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-rm680.c b/arch/arm/mach-omap2/board-rm680.c
index c5e382d..7a355e7 100644
--- a/arch/arm/mach-omap2/board-rm680.c
+++ b/arch/arm/mach-omap2/board-rm680.c
@@ -180,5 +180,5 @@ MACHINE_START(NOKIA_RM680, "Nokia RM-680 board")
 	.init_early	= rm680_init_early,
 	.init_irq	= omap3_init_irq,
 	.init_machine	= rm680_init,
-	.timer		= &omap_timer,
+	.timer		= &omap3_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/board-rx51.c
index ceb17c5..3506597 100644
--- a/arch/arm/mach-omap2/board-rx51.c
+++ b/arch/arm/mach-omap2/board-rx51.c
@@ -153,5 +153,5 @@ MACHINE_START(NOKIA_RX51, "Nokia RX-51 board")
 	.init_early	= rx51_init_early,
 	.init_irq	= omap3_init_irq,
 	.init_machine	= rx51_init,
-	.timer		= &omap_timer,
+	.timer		= &omap3_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-ti8168evm.c b/arch/arm/mach-omap2/board-ti8168evm.c
index 713c20f..a85d5b0 100644
--- a/arch/arm/mach-omap2/board-ti8168evm.c
+++ b/arch/arm/mach-omap2/board-ti8168evm.c
@@ -52,6 +52,6 @@ MACHINE_START(TI8168EVM, "ti8168evm")
 	.map_io		= ti8168_evm_map_io,
 	.init_early	= ti8168_init_early,
 	.init_irq	= ti816x_init_irq,
-	.timer		= &omap_timer,
+	.timer		= &omap3_timer,
 	.init_machine	= ti8168_evm_init,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-zoom.c b/arch/arm/mach-omap2/board-zoom.c
index 97a3f0b..8a98c3c 100644
--- a/arch/arm/mach-omap2/board-zoom.c
+++ b/arch/arm/mach-omap2/board-zoom.c
@@ -139,7 +139,7 @@ MACHINE_START(OMAP_ZOOM2, "OMAP Zoom2 board")
 	.init_early	= omap_zoom_init_early,
 	.init_irq	= omap3_init_irq,
 	.init_machine	= omap_zoom_init,
-	.timer		= &omap_timer,
+	.timer		= &omap3_timer,
 MACHINE_END
 
 MACHINE_START(OMAP_ZOOM3, "OMAP Zoom3 board")
@@ -149,5 +149,5 @@ MACHINE_START(OMAP_ZOOM3, "OMAP Zoom3 board")
 	.init_early	= omap_zoom_init_early,
 	.init_irq	= omap3_init_irq,
 	.init_machine	= omap_zoom_init,
-	.timer		= &omap_timer,
+	.timer		= &omap3_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/timer-gp.c b/arch/arm/mach-omap2/timer-gp.c
index 3b9cf85..b7ea047 100644
--- a/arch/arm/mach-omap2/timer-gp.c
+++ b/arch/arm/mach-omap2/timer-gp.c
@@ -247,20 +247,67 @@ static void __init omap2_gp_clocksource_init(void)
 }
 #endif
 
-static void __init omap2_gp_timer_init(void)
+#ifdef CONFIG_ARCH_OMAP2
+static void __init omap242x_timer_init(void)
 {
-#ifdef CONFIG_LOCAL_TIMERS
-	if (cpu_is_omap44xx()) {
-		twd_base = ioremap(OMAP44XX_LOCAL_TWD_BASE, SZ_256);
-		BUG_ON(!twd_base);
-	}
+	omap_dm_timer_init();
+	omap2_gp_clockevent_init();
+	omap2_gp_clocksource_init();
+}
+
+struct sys_timer omap242x_timer = {
+	.init	= omap242x_timer_init,
+};
+
+static void __init omap243x_timer_init(void)
+{
+	omap_dm_timer_init();
+	omap2_gp_clockevent_init();
+	omap2_gp_clocksource_init();
+}
+
+struct sys_timer omap243x_timer = {
+	.init	= omap243x_timer_init,
+};
 #endif
+
+#ifdef CONFIG_ARCH_OMAP3
+static void __init omap3_timer_init(void)
+{
 	omap_dm_timer_init();
+	omap2_gp_clockevent_init();
+	omap2_gp_clocksource_init();
+}
+
+struct sys_timer omap3_timer = {
+	.init	= omap3_timer_init,
+};
+
+static void __init omap3_beagle_timer_init(void)
+{
+	omap_dm_timer_init();
+	omap2_gp_clockevent_init();
+	omap2_gp_clocksource_init();
+}
 
+struct sys_timer omap3_beagle_timer = {
+	.init	= omap3_beagle_timer_init,
+};
+#endif
+
+#ifdef CONFIG_ARCH_OMAP4
+static void __init omap4_timer_init(void)
+{
+#ifdef CONFIG_LOCAL_TIMERS
+	twd_base = ioremap(OMAP44XX_LOCAL_TWD_BASE, SZ_256);
+	BUG_ON(!twd_base);
+#endif
+	omap_dm_timer_init();
 	omap2_gp_clockevent_init();
 	omap2_gp_clocksource_init();
 }
 
-struct sys_timer omap_timer = {
-	.init	= omap2_gp_timer_init,
+struct sys_timer omap4_timer = {
+	.init	= omap4_timer_init,
 };
+#endif
diff --git a/arch/arm/plat-omap/include/plat/common.h b/arch/arm/plat-omap/include/plat/common.h
index 5288130..619f9b3 100644
--- a/arch/arm/plat-omap/include/plat/common.h
+++ b/arch/arm/plat-omap/include/plat/common.h
@@ -34,7 +34,12 @@
 struct sys_timer;
 
 extern void omap_map_common_io(void);
-extern struct sys_timer omap_timer;
+extern struct sys_timer omap1_timer;
+extern struct sys_timer omap242x_timer;
+extern struct sys_timer omap243x_timer;
+extern struct sys_timer omap3_timer;
+extern struct sys_timer omap3_beagle_timer;
+extern struct sys_timer omap4_timer;
 extern bool omap_32k_timer_init(void);
 extern int __init omap_init_clocksource_32k(void);
 extern unsigned long long notrace omap_32k_sched_clock(void);
diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/plat-omap/include/plat/dmtimer.h
index d6c70d2..330bd17 100644
--- a/arch/arm/plat-omap/include/plat/dmtimer.h
+++ b/arch/arm/plat-omap/include/plat/dmtimer.h
@@ -57,7 +57,6 @@
 #define OMAP_TIMER_IP_VERSION_1                        0x1
 struct omap_dm_timer;
 extern struct omap_dm_timer *gptimer_wakeup;
-extern struct sys_timer omap_timer;
 struct clk;
 
 int omap_dm_timer_init(void);

