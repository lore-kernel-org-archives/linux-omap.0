From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 01/10] omap: Use separate init_irq functions to avoid
	cpu_is_omap tests early
Date: Mon, 28 Mar 2011 15:21:28 -0700
Message-ID: <20110328222128.4046.70846.stgit@baageli.muru.com>
References: <20110328221501.4046.41079.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:20547 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754691Ab1C1WVb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Mar 2011 18:21:31 -0400
In-Reply-To: <20110328221501.4046.41079.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

This allows us to remove cpu_is_omap calls from init_irq functions
and the irq handler. There should not be any need for cpu_is_omap
as at this point we only care about SoC generation, and not about
subcategories.

The main reason for the patch is that we want to initialize only
minimal omap specific code from the init_early call, and this and
the following patches get us closer to that goal.

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
 arch/arm/mach-omap1/irq.c                  |    2 -
 arch/arm/mach-omap2/board-2430sdp.c        |    2 -
 arch/arm/mach-omap2/board-3430sdp.c        |    2 -
 arch/arm/mach-omap2/board-3630sdp.c        |    2 -
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
 arch/arm/mach-omap2/board-n8x0.c           |    6 +-
 arch/arm/mach-omap2/board-omap3beagle.c    |    2 -
 arch/arm/mach-omap2/board-omap3evm.c       |    2 -
 arch/arm/mach-omap2/board-omap3logic.c     |    4 +
 arch/arm/mach-omap2/board-omap3pandora.c   |    2 -
 arch/arm/mach-omap2/board-omap3stalker.c   |    2 -
 arch/arm/mach-omap2/board-omap3touchbook.c |    2 -
 arch/arm/mach-omap2/board-overo.c          |    2 -
 arch/arm/mach-omap2/board-rm680.c          |    2 -
 arch/arm/mach-omap2/board-rx51.c           |    2 -
 arch/arm/mach-omap2/board-ti8168evm.c      |    7 --
 arch/arm/mach-omap2/board-zoom.c           |    4 +
 arch/arm/mach-omap2/io.c                   |   17 ------
 arch/arm/mach-omap2/irq.c                  |   84 ++++++++++++++++++++--------
 arch/arm/mach-omap2/omap4-common.c         |    6 ++
 arch/arm/plat-omap/include/plat/irqs.h     |    6 ++
 46 files changed, 117 insertions(+), 93 deletions(-)

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index de88c92..17ed757 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -138,7 +138,7 @@ void ams_delta_latch2_write(u16 mask, u16 value)
 static void __init ams_delta_init_irq(void)
 {
 	omap1_init_common_hw();
-	omap_init_irq();
+	omap1_init_irq();
 }
 
 static struct map_desc ams_delta_io_desc[] __initdata = {
diff --git a/arch/arm/mach-omap1/board-fsample.c b/arch/arm/mach-omap1/board-fsample.c
index 87f173d..eaff305 100644
--- a/arch/arm/mach-omap1/board-fsample.c
+++ b/arch/arm/mach-omap1/board-fsample.c
@@ -329,7 +329,7 @@ static void __init omap_fsample_init(void)
 static void __init omap_fsample_init_irq(void)
 {
 	omap1_init_common_hw();
-	omap_init_irq();
+	omap1_init_irq();
 }
 
 /* Only FPGA needs to be mapped here. All others are done with ioremap */
diff --git a/arch/arm/mach-omap1/board-generic.c b/arch/arm/mach-omap1/board-generic.c
index 23f4ab9..3fd6b40 100644
--- a/arch/arm/mach-omap1/board-generic.c
+++ b/arch/arm/mach-omap1/board-generic.c
@@ -31,7 +31,7 @@
 static void __init omap_generic_init_irq(void)
 {
 	omap1_init_common_hw();
-	omap_init_irq();
+	omap1_init_irq();
 }
 
 /* assume no Mini-AB port */
diff --git a/arch/arm/mach-omap1/board-h2.c b/arch/arm/mach-omap1/board-h2.c
index ba3bd09..8147b04 100644
--- a/arch/arm/mach-omap1/board-h2.c
+++ b/arch/arm/mach-omap1/board-h2.c
@@ -376,7 +376,7 @@ static struct i2c_board_info __initdata h2_i2c_board_info[] = {
 static void __init h2_init_irq(void)
 {
 	omap1_init_common_hw();
-	omap_init_irq();
+	omap1_init_irq();
 }
 
 static struct omap_usb_config h2_usb_config __initdata = {
diff --git a/arch/arm/mach-omap1/board-h3.c b/arch/arm/mach-omap1/board-h3.c
index ac48677..1b448f6 100644
--- a/arch/arm/mach-omap1/board-h3.c
+++ b/arch/arm/mach-omap1/board-h3.c
@@ -439,7 +439,7 @@ static void __init h3_init(void)
 static void __init h3_init_irq(void)
 {
 	omap1_init_common_hw();
-	omap_init_irq();
+	omap1_init_irq();
 }
 
 static void __init h3_map_io(void)
diff --git a/arch/arm/mach-omap1/board-htcherald.c b/arch/arm/mach-omap1/board-htcherald.c
index ba05a51..1bd4d8e 100644
--- a/arch/arm/mach-omap1/board-htcherald.c
+++ b/arch/arm/mach-omap1/board-htcherald.c
@@ -605,7 +605,7 @@ static void __init htcherald_init_irq(void)
 {
 	printk(KERN_INFO "htcherald_init_irq.\n");
 	omap1_init_common_hw();
-	omap_init_irq();
+	omap1_init_irq();
 }
 
 MACHINE_START(HERALD, "HTC Herald")
diff --git a/arch/arm/mach-omap1/board-innovator.c b/arch/arm/mach-omap1/board-innovator.c
index 2d9b8cb..5926b0c 100644
--- a/arch/arm/mach-omap1/board-innovator.c
+++ b/arch/arm/mach-omap1/board-innovator.c
@@ -292,7 +292,7 @@ static void __init innovator_init_smc91x(void)
 static void __init innovator_init_irq(void)
 {
 	omap1_init_common_hw();
-	omap_init_irq();
+	omap1_init_irq();
 }
 
 #ifdef CONFIG_ARCH_OMAP15XX
diff --git a/arch/arm/mach-omap1/board-nokia770.c b/arch/arm/mach-omap1/board-nokia770.c
index cfd0849..e3cf21d 100644
--- a/arch/arm/mach-omap1/board-nokia770.c
+++ b/arch/arm/mach-omap1/board-nokia770.c
@@ -51,7 +51,7 @@ static void __init omap_nokia770_init_irq(void)
 	omap_writew((omap_readw(0xfffb5004) & ~2), 0xfffb5004);
 
 	omap1_init_common_hw();
-	omap_init_irq();
+	omap1_init_irq();
 }
 
 static const unsigned int nokia770_keymap[] = {
diff --git a/arch/arm/mach-omap1/board-osk.c b/arch/arm/mach-omap1/board-osk.c
index 7c5e211..aed8202 100644
--- a/arch/arm/mach-omap1/board-osk.c
+++ b/arch/arm/mach-omap1/board-osk.c
@@ -282,7 +282,7 @@ static void __init osk_init_cf(void)
 static void __init osk_init_irq(void)
 {
 	omap1_init_common_hw();
-	omap_init_irq();
+	omap1_init_irq();
 }
 
 static struct omap_usb_config osk_usb_config __initdata = {
diff --git a/arch/arm/mach-omap1/board-palmte.c b/arch/arm/mach-omap1/board-palmte.c
index c9d38f4..8b6a881 100644
--- a/arch/arm/mach-omap1/board-palmte.c
+++ b/arch/arm/mach-omap1/board-palmte.c
@@ -62,7 +62,7 @@
 static void __init omap_palmte_init_irq(void)
 {
 	omap1_init_common_hw();
-	omap_init_irq();
+	omap1_init_irq();
 }
 
 static const unsigned int palmte_keymap[] = {
diff --git a/arch/arm/mach-omap1/board-palmtt.c b/arch/arm/mach-omap1/board-palmtt.c
index f04f2d3..f2de43d 100644
--- a/arch/arm/mach-omap1/board-palmtt.c
+++ b/arch/arm/mach-omap1/board-palmtt.c
@@ -266,7 +266,7 @@ static struct spi_board_info __initdata palmtt_boardinfo[] = {
 static void __init omap_palmtt_init_irq(void)
 {
 	omap1_init_common_hw();
-	omap_init_irq();
+	omap1_init_irq();
 }
 
 static struct omap_usb_config palmtt_usb_config __initdata = {
diff --git a/arch/arm/mach-omap1/board-palmz71.c b/arch/arm/mach-omap1/board-palmz71.c
index d7bbbe7..7904018 100644
--- a/arch/arm/mach-omap1/board-palmz71.c
+++ b/arch/arm/mach-omap1/board-palmz71.c
@@ -61,7 +61,7 @@ static void __init
 omap_palmz71_init_irq(void)
 {
 	omap1_init_common_hw();
-	omap_init_irq();
+	omap1_init_irq();
 }
 
 static const unsigned int palmz71_keymap[] = {
diff --git a/arch/arm/mach-omap1/board-perseus2.c b/arch/arm/mach-omap1/board-perseus2.c
index 3c8ee84..7f019e5 100644
--- a/arch/arm/mach-omap1/board-perseus2.c
+++ b/arch/arm/mach-omap1/board-perseus2.c
@@ -297,7 +297,7 @@ static void __init omap_perseus2_init(void)
 static void __init omap_perseus2_init_irq(void)
 {
 	omap1_init_common_hw();
-	omap_init_irq();
+	omap1_init_irq();
 }
 /* Only FPGA needs to be mapped here. All others are done with ioremap */
 static struct map_desc omap_perseus2_io_desc[] __initdata = {
diff --git a/arch/arm/mach-omap1/board-sx1.c b/arch/arm/mach-omap1/board-sx1.c
index d41fe2d..027520f 100644
--- a/arch/arm/mach-omap1/board-sx1.c
+++ b/arch/arm/mach-omap1/board-sx1.c
@@ -411,7 +411,7 @@ static void __init omap_sx1_init(void)
 static void __init omap_sx1_init_irq(void)
 {
 	omap1_init_common_hw();
-	omap_init_irq();
+	omap1_init_irq();
 }
 /*----------------------------------------*/
 
diff --git a/arch/arm/mach-omap1/board-voiceblue.c b/arch/arm/mach-omap1/board-voiceblue.c
index bdc0ac8..a843f4c 100644
--- a/arch/arm/mach-omap1/board-voiceblue.c
+++ b/arch/arm/mach-omap1/board-voiceblue.c
@@ -162,7 +162,7 @@ static struct omap_board_config_kernel voiceblue_config[] = {
 static void __init voiceblue_init_irq(void)
 {
 	omap1_init_common_hw();
-	omap_init_irq();
+	omap1_init_irq();
 }
 
 static void __init voiceblue_map_io(void)
diff --git a/arch/arm/mach-omap1/irq.c b/arch/arm/mach-omap1/irq.c
index 731dd33..7d49359 100644
--- a/arch/arm/mach-omap1/irq.c
+++ b/arch/arm/mach-omap1/irq.c
@@ -175,7 +175,7 @@ static struct irq_chip omap_irq_chip = {
 	.irq_set_wake	= omap_wake_irq,
 };
 
-void __init omap_init_irq(void)
+void __init omap1_init_irq(void)
 {
 	int i, j;
 
diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index 1fa6bb8..3d5a1de 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -277,7 +277,7 @@ MACHINE_START(OMAP_2430SDP, "OMAP2430 sdp2430 board")
 	.reserve	= omap_reserve,
 	.map_io		= omap_2430sdp_map_io,
 	.init_early	= omap_2430sdp_init_early,
-	.init_irq	= omap_init_irq,
+	.init_irq	= omap2_init_irq,
 	.init_machine	= omap_2430sdp_init,
 	.timer		= &omap_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 9afd087..8859a74 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -909,7 +909,7 @@ MACHINE_START(OMAP_3430SDP, "OMAP3430 3430SDP board")
 	.reserve	= omap_reserve,
 	.map_io		= omap3_map_io,
 	.init_early	= omap_3430sdp_init_early,
-	.init_irq	= omap_init_irq,
+	.init_irq	= omap3_init_irq,
 	.init_machine	= omap_3430sdp_init,
 	.timer		= &omap_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-3630sdp.c b/arch/arm/mach-omap2/board-3630sdp.c
index a5933cc..2ec2d76 100644
--- a/arch/arm/mach-omap2/board-3630sdp.c
+++ b/arch/arm/mach-omap2/board-3630sdp.c
@@ -219,7 +219,7 @@ MACHINE_START(OMAP_3630SDP, "OMAP 3630SDP board")
 	.reserve	= omap_reserve,
 	.map_io		= omap3_map_io,
 	.init_early	= omap_sdp_init_early,
-	.init_irq	= omap_init_irq,
+	.init_irq	= omap3_init_irq,
 	.init_machine	= omap_sdp_init,
 	.timer		= &omap_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-am3517crane.c b/arch/arm/mach-omap2/board-am3517crane.c
index a890d24..bbd9c14 100644
--- a/arch/arm/mach-omap2/board-am3517crane.c
+++ b/arch/arm/mach-omap2/board-am3517crane.c
@@ -110,7 +110,7 @@ MACHINE_START(CRANEBOARD, "AM3517/05 CRANEBOARD")
 	.reserve	= omap_reserve,
 	.map_io		= omap3_map_io,
 	.init_early	= am3517_crane_init_early,
-	.init_irq	= omap_init_irq,
+	.init_irq	= omap3_init_irq,
 	.init_machine	= am3517_crane_init,
 	.timer		= &omap_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index ce7d5e6..6fc0479 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -516,7 +516,7 @@ MACHINE_START(OMAP3517EVM, "OMAP3517/AM3517 EVM")
 	.reserve	= omap_reserve,
 	.map_io		= omap3_map_io,
 	.init_early	= am3517_evm_init_early,
-	.init_irq	= omap_init_irq,
+	.init_irq	= omap3_init_irq,
 	.init_machine	= am3517_evm_init,
 	.timer		= &omap_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-apollon.c b/arch/arm/mach-omap2/board-apollon.c
index f4f8374..e764c9c 100644
--- a/arch/arm/mach-omap2/board-apollon.c
+++ b/arch/arm/mach-omap2/board-apollon.c
@@ -357,7 +357,7 @@ MACHINE_START(OMAP_APOLLON, "OMAP24xx Apollon")
 	.reserve	= omap_reserve,
 	.map_io		= omap_apollon_map_io,
 	.init_early	= omap_apollon_init_early,
-	.init_irq	= omap_init_irq,
+	.init_irq	= omap2_init_irq,
 	.init_machine	= omap_apollon_init,
 	.timer		= &omap_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index 02a12b4..bc37d72 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -806,7 +806,7 @@ MACHINE_START(CM_T35, "Compulab CM-T35")
 	.reserve	= omap_reserve,
 	.map_io		= omap3_map_io,
 	.init_early	= cm_t35_init_early,
-	.init_irq	= omap_init_irq,
+	.init_irq	= omap3_init_irq,
 	.init_machine	= cm_t35_init,
 	.timer		= &omap_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-cm-t3517.c b/arch/arm/mach-omap2/board-cm-t3517.c
index a27e3ee..b5618a6 100644
--- a/arch/arm/mach-omap2/board-cm-t3517.c
+++ b/arch/arm/mach-omap2/board-cm-t3517.c
@@ -306,7 +306,7 @@ MACHINE_START(CM_T3517, "Compulab CM-T3517")
 	.reserve        = omap_reserve,
 	.map_io		= omap3_map_io,
 	.init_early	= cm_t3517_init_early,
-	.init_irq	= omap_init_irq,
+	.init_irq	= omap3_init_irq,
 	.init_machine	= cm_t3517_init,
 	.timer		= &omap_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 65f9fde..9fedcd6 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -457,7 +457,7 @@ static void __init devkit8000_init_early(void)
 
 static void __init devkit8000_init_irq(void)
 {
-	omap_init_irq();
+	omap3_init_irq();
 #ifdef CONFIG_OMAP_32K_TIMER
 	omap2_gp_clockevent_set_gptimer(12);
 #endif
diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index 73e3c31..ccd503a 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -70,7 +70,7 @@ MACHINE_START(OMAP_GENERIC, "Generic OMAP24xx")
 	.reserve	= omap_reserve,
 	.map_io		= omap_generic_map_io,
 	.init_early	= omap_generic_init_early,
-	.init_irq	= omap_init_irq,
+	.init_irq	= omap2_init_irq,
 	.init_machine	= omap_generic_init,
 	.timer		= &omap_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
index bac7933..2e16d6c 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -298,7 +298,7 @@ static void __init omap_h4_init_early(void)
 
 static void __init omap_h4_init_irq(void)
 {
-	omap_init_irq();
+	omap2_init_irq();
 }
 
 static struct at24_platform_data m24c01 = {
diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index 5f8a2fd..8bf2650 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -708,7 +708,7 @@ MACHINE_START(IGEP0020, "IGEP v2 board")
 	.reserve	= omap_reserve,
 	.map_io		= omap3_map_io,
 	.init_early	= igep2_init_early,
-	.init_irq	= omap_init_irq,
+	.init_irq	= omap3_init_irq,
 	.init_machine	= igep2_init,
 	.timer		= &omap_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-igep0030.c b/arch/arm/mach-omap2/board-igep0030.c
index b10db0e..f83a0fe 100644
--- a/arch/arm/mach-omap2/board-igep0030.c
+++ b/arch/arm/mach-omap2/board-igep0030.c
@@ -452,7 +452,7 @@ MACHINE_START(IGEP0030, "IGEP OMAP3 module")
 	.reserve	= omap_reserve,
 	.map_io		= omap3_map_io,
 	.init_early	= igep3_init_early,
-	.init_irq	= omap_init_irq,
+	.init_irq	= omap3_init_irq,
 	.init_machine	= igep3_init,
 	.timer		= &omap_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index e2ba779..5036e7d 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -466,7 +466,7 @@ MACHINE_START(OMAP_LDP, "OMAP LDP board")
 	.reserve	= omap_reserve,
 	.map_io		= omap3_map_io,
 	.init_early	= omap_ldp_init_early,
-	.init_irq	= omap_init_irq,
+	.init_irq	= omap3_init_irq,
 	.init_machine	= omap_ldp_init,
 	.timer		= &omap_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
index e710cd9..cf9e980 100644
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -705,7 +705,7 @@ MACHINE_START(NOKIA_N800, "Nokia N800")
 	.reserve	= omap_reserve,
 	.map_io		= n8x0_map_io,
 	.init_early	= n8x0_init_early,
-	.init_irq	= omap_init_irq,
+	.init_irq	= omap2_init_irq,
 	.init_machine	= n8x0_init_machine,
 	.timer		= &omap_timer,
 MACHINE_END
@@ -715,7 +715,7 @@ MACHINE_START(NOKIA_N810, "Nokia N810")
 	.reserve	= omap_reserve,
 	.map_io		= n8x0_map_io,
 	.init_early	= n8x0_init_early,
-	.init_irq	= omap_init_irq,
+	.init_irq	= omap2_init_irq,
 	.init_machine	= n8x0_init_machine,
 	.timer		= &omap_timer,
 MACHINE_END
@@ -725,7 +725,7 @@ MACHINE_START(NOKIA_N810_WIMAX, "Nokia N810 WiMAX")
 	.reserve	= omap_reserve,
 	.map_io		= n8x0_map_io,
 	.init_early	= n8x0_init_early,
-	.init_irq	= omap_init_irq,
+	.init_irq	= omap2_init_irq,
 	.init_machine	= n8x0_init_machine,
 	.timer		= &omap_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 33007fd..8db46ec 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -540,7 +540,7 @@ static void __init omap3_beagle_init_early(void)
 
 static void __init omap3_beagle_init_irq(void)
 {
-	omap_init_irq();
+	omap3_init_irq();
 #ifdef CONFIG_OMAP_32K_TIMER
 	omap2_gp_clockevent_set_gptimer(12);
 #endif
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 5a1a916..ddddd3c 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -894,7 +894,7 @@ MACHINE_START(OMAP3EVM, "OMAP3 EVM")
 	.reserve	= omap_reserve,
 	.map_io		= omap3_map_io,
 	.init_early	= omap3_evm_init_early,
-	.init_irq	= omap_init_irq,
+	.init_irq	= omap3_init_irq,
 	.init_machine	= omap3_evm_init,
 	.timer		= &omap_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-omap3logic.c b/arch/arm/mach-omap2/board-omap3logic.c
index b726943..2183199 100644
--- a/arch/arm/mach-omap2/board-omap3logic.c
+++ b/arch/arm/mach-omap2/board-omap3logic.c
@@ -225,7 +225,7 @@ MACHINE_START(OMAP3_TORPEDO, "Logic OMAP3 Torpedo board")
 	.boot_params	= 0x80000100,
 	.map_io		= omap3_map_io,
 	.init_early	= omap3logic_init_early,
-	.init_irq	= omap_init_irq,
+	.init_irq	= omap3_init_irq,
 	.init_machine	= omap3logic_init,
 	.timer		= &omap_timer,
 MACHINE_END
@@ -234,7 +234,7 @@ MACHINE_START(OMAP3530_LV_SOM, "OMAP Logic 3530 LV SOM board")
 	.boot_params	= 0x80000100,
 	.map_io		= omap3_map_io,
 	.init_early	= omap3logic_init_early,
-	.init_irq	= omap_init_irq,
+	.init_irq	= omap3_init_irq,
 	.init_machine	= omap3logic_init,
 	.timer		= &omap_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index 07dba88..06d532c 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -720,7 +720,7 @@ MACHINE_START(OMAP3_PANDORA, "Pandora Handheld Console")
 	.reserve	= omap_reserve,
 	.map_io		= omap3_map_io,
 	.init_early	= omap3pandora_init_early,
-	.init_irq	= omap_init_irq,
+	.init_irq	= omap3_init_irq,
 	.init_machine	= omap3pandora_init,
 	.timer		= &omap_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-omap3stalker.c b/arch/arm/mach-omap2/board-omap3stalker.c
index a6e0b91..e5e37cb 100644
--- a/arch/arm/mach-omap2/board-omap3stalker.c
+++ b/arch/arm/mach-omap2/board-omap3stalker.c
@@ -587,7 +587,7 @@ static void __init omap3_stalker_init_early(void)
 
 static void __init omap3_stalker_init_irq(void)
 {
-	omap_init_irq();
+	omap3_init_irq();
 #ifdef CONFIG_OMAP_32K_TIMER
 	omap2_gp_clockevent_set_gptimer(12);
 #endif
diff --git a/arch/arm/mach-omap2/board-omap3touchbook.c b/arch/arm/mach-omap2/board-omap3touchbook.c
index 127cb17..c9261d4 100644
--- a/arch/arm/mach-omap2/board-omap3touchbook.c
+++ b/arch/arm/mach-omap2/board-omap3touchbook.c
@@ -422,7 +422,7 @@ static void __init omap3_touchbook_init_early(void)
 
 static void __init omap3_touchbook_init_irq(void)
 {
-	omap_init_irq();
+	omap3_init_irq();
 #ifdef CONFIG_OMAP_32K_TIMER
 	omap2_gp_clockevent_set_gptimer(12);
 #endif
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index 59ca333..826df4b 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -790,7 +790,7 @@ MACHINE_START(OVERO, "Gumstix Overo")
 	.reserve	= omap_reserve,
 	.map_io		= omap3_map_io,
 	.init_early	= overo_init_early,
-	.init_irq	= omap_init_irq,
+	.init_irq	= omap3_init_irq,
 	.init_machine	= overo_init,
 	.timer		= &omap_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-rm680.c b/arch/arm/mach-omap2/board-rm680.c
index 2af8b05..c5e382d 100644
--- a/arch/arm/mach-omap2/board-rm680.c
+++ b/arch/arm/mach-omap2/board-rm680.c
@@ -178,7 +178,7 @@ MACHINE_START(NOKIA_RM680, "Nokia RM-680 board")
 	.reserve	= omap_reserve,
 	.map_io		= rm680_map_io,
 	.init_early	= rm680_init_early,
-	.init_irq	= omap_init_irq,
+	.init_irq	= omap3_init_irq,
 	.init_machine	= rm680_init,
 	.timer		= &omap_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/board-rx51.c
index e964895..ceb17c5 100644
--- a/arch/arm/mach-omap2/board-rx51.c
+++ b/arch/arm/mach-omap2/board-rx51.c
@@ -151,7 +151,7 @@ MACHINE_START(NOKIA_RX51, "Nokia RX-51 board")
 	.reserve	= omap_reserve,
 	.map_io		= rx51_map_io,
 	.init_early	= rx51_init_early,
-	.init_irq	= omap_init_irq,
+	.init_irq	= omap3_init_irq,
 	.init_machine	= rx51_init,
 	.timer		= &omap_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-ti8168evm.c b/arch/arm/mach-omap2/board-ti8168evm.c
index 09fa7bf..713c20f 100644
--- a/arch/arm/mach-omap2/board-ti8168evm.c
+++ b/arch/arm/mach-omap2/board-ti8168evm.c
@@ -33,11 +33,6 @@ static void __init ti8168_init_early(void)
 	omap2_init_common_devices(NULL, NULL);
 }
 
-static void __init ti8168_evm_init_irq(void)
-{
-	omap_init_irq();
-}
-
 static void __init ti8168_evm_init(void)
 {
 	omap_serial_init();
@@ -56,7 +51,7 @@ MACHINE_START(TI8168EVM, "ti8168evm")
 	.boot_params	= 0x80000100,
 	.map_io		= ti8168_evm_map_io,
 	.init_early	= ti8168_init_early,
-	.init_irq	= ti8168_evm_init_irq,
+	.init_irq	= ti816x_init_irq,
 	.timer		= &omap_timer,
 	.init_machine	= ti8168_evm_init,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-zoom.c b/arch/arm/mach-omap2/board-zoom.c
index 4b133d7..97a3f0b 100644
--- a/arch/arm/mach-omap2/board-zoom.c
+++ b/arch/arm/mach-omap2/board-zoom.c
@@ -137,7 +137,7 @@ MACHINE_START(OMAP_ZOOM2, "OMAP Zoom2 board")
 	.reserve	= omap_reserve,
 	.map_io		= omap3_map_io,
 	.init_early	= omap_zoom_init_early,
-	.init_irq	= omap_init_irq,
+	.init_irq	= omap3_init_irq,
 	.init_machine	= omap_zoom_init,
 	.timer		= &omap_timer,
 MACHINE_END
@@ -147,7 +147,7 @@ MACHINE_START(OMAP_ZOOM3, "OMAP Zoom3 board")
 	.reserve	= omap_reserve,
 	.map_io		= omap3_map_io,
 	.init_early	= omap_zoom_init_early,
-	.init_irq	= omap_init_irq,
+	.init_irq	= omap3_init_irq,
 	.init_machine	= omap_zoom_init,
 	.timer		= &omap_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 441e79d..2ce1ce6 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -333,23 +333,9 @@ static int _set_hwmod_postsetup_state(struct omap_hwmod *oh, void *data)
 	return omap_hwmod_set_postsetup_state(oh, *(u8 *)data);
 }
 
+/* See irq.c, omap4-common.c and entry-macro.S */
 void __iomem *omap_irq_base;
 
-/*
- * Initialize asm_irq_base for entry-macro.S
- */
-static inline void omap_irq_base_init(void)
-{
-	if (cpu_is_omap24xx())
-		omap_irq_base = OMAP2_L4_IO_ADDRESS(OMAP24XX_IC_BASE);
-	else if (cpu_is_omap34xx())
-		omap_irq_base = OMAP2_L4_IO_ADDRESS(OMAP34XX_IC_BASE);
-	else if (cpu_is_omap44xx())
-		omap_irq_base = OMAP2_L4_IO_ADDRESS(OMAP44XX_GIC_CPU_BASE);
-	else
-		pr_err("Could not initialize omap_irq_base\n");
-}
-
 void __init omap2_init_common_infrastructure(void)
 {
 	u8 postsetup_state;
@@ -422,7 +408,6 @@ void __init omap2_init_common_devices(struct omap_sdrc_params *sdrc_cs0,
 		_omap2_init_reprogram_sdrc();
 	}
 
-	omap_irq_base_init();
 }
 
 /*
diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index bc524b9..33a5c0d 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -103,28 +103,36 @@ static void omap_ack_irq(struct irq_data *d)
 	intc_bank_write_reg(0x1, &irq_banks[0], INTC_CONTROL);
 }
 
+static inline void _omap_mask_irq(int irq)
+{
+	int offset = irq & (~(IRQ_BITS_PER_REG - 1));
+	irq &= (IRQ_BITS_PER_REG - 1);
+	intc_bank_write_reg(1 << irq, &irq_banks[0], INTC_MIR_SET0 + offset);
+}
+
 static void omap_mask_irq(struct irq_data *d)
 {
 	unsigned int irq = d->irq;
-	int offset = irq & (~(IRQ_BITS_PER_REG - 1));
 
-	if (cpu_is_omap34xx() && !cpu_is_ti816x()) {
-		int spurious = 0;
+	_omap_mask_irq(irq);
+}
 
-		/*
-		 * INT_34XX_GPT12_IRQ is also the spurious irq. Maybe because
-		 * it is the highest irq number?
-		 */
-		if (irq == INT_34XX_GPT12_IRQ)
-			spurious = omap_check_spurious(irq);
+static void omap_mask_irq_omap3(struct irq_data *d)
+{
+	unsigned int irq = d->irq;
+	int spurious = 0;
 
-		if (!spurious)
-			previous_irq = irq;
-	}
+	/*
+	 * INT_34XX_GPT12_IRQ is also the spurious irq. Maybe because
+	 * it is the highest irq number?
+	 */
+	if (irq == INT_34XX_GPT12_IRQ)
+		spurious = omap_check_spurious(irq);
 
-	irq &= (IRQ_BITS_PER_REG - 1);
+	if (!spurious)
+		previous_irq = irq;
 
-	intc_bank_write_reg(1 << irq, &irq_banks[0], INTC_MIR_SET0 + offset);
+	_omap_mask_irq(irq);
 }
 
 static void omap_unmask_irq(struct irq_data *d)
@@ -143,6 +151,12 @@ static void omap_mask_ack_irq(struct irq_data *d)
 	omap_ack_irq(d);
 }
 
+static void omap_mask_ack_irq_omap3(struct irq_data *d)
+{
+	omap_mask_irq_omap3(d);
+	omap_ack_irq(d);
+}
+
 static struct irq_chip omap_irq_chip = {
 	.name		= "INTC",
 	.irq_ack	= omap_mask_ack_irq,
@@ -186,25 +200,16 @@ int omap_irq_pending(void)
 	return 0;
 }
 
-void __init omap_init_irq(void)
+static inline void omap_init_irq(u32 base, int nr_irqs)
 {
 	unsigned long nr_of_irqs = 0;
 	unsigned int nr_banks = 0;
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(irq_banks); i++) {
-		unsigned long base = 0;
 		struct omap_irq_bank *bank = irq_banks + i;
 
-		if (cpu_is_omap24xx())
-			base = OMAP24XX_IC_BASE;
-		else if (cpu_is_omap34xx())
-			base = OMAP34XX_IC_BASE;
-
-		BUG_ON(!base);
-
-		if (cpu_is_ti816x())
-			bank->nr_irqs = 128;
+		bank->nr_irqs = nr_irqs;
 
 		/* Static mapping, never released */
 		bank->base_reg = ioremap(base, SZ_4K);
@@ -229,6 +234,35 @@ void __init omap_init_irq(void)
 	}
 }
 
+void __init omap2_init_irq(void)
+{
+	omap_irq_base = ioremap(OMAP24XX_IC_BASE, SZ_4K);
+	if (WARN_ON(!omap_irq_base))
+		return;
+
+	omap_init_irq(OMAP24XX_IC_BASE, 96);
+}
+
+void __init omap3_init_irq(void)
+{
+	omap_irq_base = ioremap(OMAP34XX_IC_BASE, SZ_4K);
+	if (WARN_ON(!omap_irq_base))
+		return;
+
+	omap_irq_chip.irq_ack = omap_mask_ack_irq_omap3;
+	omap_irq_chip.irq_mask = omap_mask_irq_omap3;
+	omap_init_irq(OMAP34XX_IC_BASE, 96);
+}
+
+void __init ti816x_init_irq(void)
+{
+	omap_irq_base = ioremap(OMAP34XX_IC_BASE, SZ_4K);
+	if (WARN_ON(!omap_irq_base))
+		return;
+
+	omap_init_irq(OMAP34XX_IC_BASE, 128);
+}
+
 #ifdef CONFIG_ARCH_OMAP3
 static struct omap3_intc_regs intc_context[ARRAY_SIZE(irq_banks)];
 
diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
index 9ef8c29..1c3bcf1 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -19,6 +19,8 @@
 #include <asm/hardware/gic.h>
 #include <asm/hardware/cache-l2x0.h>
 
+#include <plat/irqs.h>
+
 #include <mach/hardware.h>
 #include <mach/omap4-common.h>
 
@@ -34,6 +36,10 @@ void __init gic_init_irq(void)
 	void __iomem *gic_cpu_base;
 
 	/* Static mapping, never released */
+	omap_irq_base = ioremap(OMAP44XX_GIC_CPU_BASE, SZ_4K);
+	BUG_ON(!omap_irq_base);
+
+	/* Static mapping, never released */
 	gic_dist_base_addr = ioremap(OMAP44XX_GIC_DIST_BASE, SZ_4K);
 	BUG_ON(!gic_dist_base_addr);
 
diff --git a/arch/arm/plat-omap/include/plat/irqs.h b/arch/arm/plat-omap/include/plat/irqs.h
index 5a25098..c884320 100644
--- a/arch/arm/plat-omap/include/plat/irqs.h
+++ b/arch/arm/plat-omap/include/plat/irqs.h
@@ -428,7 +428,11 @@
 #define INTCPS_NR_IRQS		96
 
 #ifndef __ASSEMBLY__
-extern void omap_init_irq(void);
+extern void __iomem *omap_irq_base;
+void omap1_init_irq(void);
+void omap2_init_irq(void);
+void omap3_init_irq(void);
+void ti816x_init_irq(void);
 extern int omap_irq_pending(void);
 void omap_intc_save_context(void);
 void omap_intc_restore_context(void);

