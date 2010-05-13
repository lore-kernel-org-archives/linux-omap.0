From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC] Initial attempt to make ARM use LMB
Date: Thu, 13 May 2010 18:40:23 +0100
Message-ID: <20100513174023.GB13001@n2100.arm.linux.org.uk>
References: <20100325233248.GM24984@n2100.arm.linux.org.uk> <20100505150209.GC2606@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:49966 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753104Ab0EMRkn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 May 2010 13:40:43 -0400
Content-Disposition: inline
In-Reply-To: <20100505150209.GC2606@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

And here's a patch which converts the OMAP FB code to use lmb_reserve
instead of poking about with bootmem stuff.  Untested, so I'd like to
hear back whether it works.

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index 7fc11c3..87b94a8 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -285,6 +285,7 @@ MACHINE_START(AMS_DELTA, "Amstrad E3 (Delta)")
 	.io_pg_offst	= ((0xfef00000) >> 18) & 0xfffc,
 	.boot_params	= 0x10000100,
 	.map_io		= ams_delta_map_io,
+	.reserve	= omap1_reserve,
 	.init_irq	= ams_delta_init_irq,
 	.init_machine	= ams_delta_init,
 	.timer		= &omap_timer,
diff --git a/arch/arm/mach-omap1/board-fsample.c b/arch/arm/mach-omap1/board-fsample.c
index 096f2ed..d7ea74a 100644
--- a/arch/arm/mach-omap1/board-fsample.c
+++ b/arch/arm/mach-omap1/board-fsample.c
@@ -378,6 +378,7 @@ MACHINE_START(OMAP_FSAMPLE, "OMAP730 F-Sample")
 	.io_pg_offst	= ((0xfef00000) >> 18) & 0xfffc,
 	.boot_params	= 0x10000100,
 	.map_io		= omap_fsample_map_io,
+	.reserve	= omap1_reserve,
 	.init_irq	= omap_fsample_init_irq,
 	.init_machine	= omap_fsample_init,
 	.timer		= &omap_timer,
diff --git a/arch/arm/mach-omap1/board-generic.c b/arch/arm/mach-omap1/board-generic.c
index e1195a3..12e2f23 100644
--- a/arch/arm/mach-omap1/board-generic.c
+++ b/arch/arm/mach-omap1/board-generic.c
@@ -98,6 +98,7 @@ MACHINE_START(OMAP_GENERIC, "Generic OMAP1510/1610/1710")
 	.io_pg_offst	= ((0xfef00000) >> 18) & 0xfffc,
 	.boot_params	= 0x10000100,
 	.map_io		= omap_generic_map_io,
+	.reserve	= omap1_reserve,
 	.init_irq	= omap_generic_init_irq,
 	.init_machine	= omap_generic_init,
 	.timer		= &omap_timer,
diff --git a/arch/arm/mach-omap1/board-h2.c b/arch/arm/mach-omap1/board-h2.c
index d1100e4..616ffa8 100644
--- a/arch/arm/mach-omap1/board-h2.c
+++ b/arch/arm/mach-omap1/board-h2.c
@@ -467,6 +467,7 @@ MACHINE_START(OMAP_H2, "TI-H2")
 	.io_pg_offst	= ((0xfef00000) >> 18) & 0xfffc,
 	.boot_params	= 0x10000100,
 	.map_io		= h2_map_io,
+	.reserve	= omap1_reserve,
 	.init_irq	= h2_init_irq,
 	.init_machine	= h2_init,
 	.timer		= &omap_timer,
diff --git a/arch/arm/mach-omap1/board-h3.c b/arch/arm/mach-omap1/board-h3.c
index a53ab82..bd3d037 100644
--- a/arch/arm/mach-omap1/board-h3.c
+++ b/arch/arm/mach-omap1/board-h3.c
@@ -437,6 +437,7 @@ MACHINE_START(OMAP_H3, "TI OMAP1710 H3 board")
 	.io_pg_offst	= ((0xfef00000) >> 18) & 0xfffc,
 	.boot_params	= 0x10000100,
 	.map_io		= h3_map_io,
+	.reserve	= omap1_reserve,
 	.init_irq	= h3_init_irq,
 	.init_machine	= h3_init,
 	.timer		= &omap_timer,
diff --git a/arch/arm/mach-omap1/board-htcherald.c b/arch/arm/mach-omap1/board-htcherald.c
index 8e313b4..8e67a10 100644
--- a/arch/arm/mach-omap1/board-htcherald.c
+++ b/arch/arm/mach-omap1/board-htcherald.c
@@ -304,6 +304,7 @@ MACHINE_START(HERALD, "HTC Herald")
 	.io_pg_offst    = ((0xfef00000) >> 18) & 0xfffc,
 	.boot_params    = 0x10000100,
 	.map_io         = htcherald_map_io,
+	.reserve	= omap1_reserve,
 	.init_irq       = htcherald_init_irq,
 	.init_machine   = htcherald_init,
 	.timer          = &omap_timer,
diff --git a/arch/arm/mach-omap1/board-innovator.c b/arch/arm/mach-omap1/board-innovator.c
index 5d12fd3..39bd476 100644
--- a/arch/arm/mach-omap1/board-innovator.c
+++ b/arch/arm/mach-omap1/board-innovator.c
@@ -463,6 +463,7 @@ MACHINE_START(OMAP_INNOVATOR, "TI-Innovator")
 	.io_pg_offst	= ((0xfef00000) >> 18) & 0xfffc,
 	.boot_params	= 0x10000100,
 	.map_io		= innovator_map_io,
+	.reserve	= omap1_reserve,
 	.init_irq	= innovator_init_irq,
 	.init_machine	= innovator_init,
 	.timer		= &omap_timer,
diff --git a/arch/arm/mach-omap1/board-nokia770.c b/arch/arm/mach-omap1/board-nokia770.c
index 71e1a3f..615670a 100644
--- a/arch/arm/mach-omap1/board-nokia770.c
+++ b/arch/arm/mach-omap1/board-nokia770.c
@@ -400,6 +400,7 @@ MACHINE_START(NOKIA770, "Nokia 770")
 	.io_pg_offst	= ((0xfef00000) >> 18) & 0xfffc,
 	.boot_params	= 0x10000100,
 	.map_io		= omap_nokia770_map_io,
+	.reserve	= omap1_reserve,
 	.init_irq	= omap_nokia770_init_irq,
 	.init_machine	= omap_nokia770_init,
 	.timer		= &omap_timer,
diff --git a/arch/arm/mach-omap1/board-osk.c b/arch/arm/mach-omap1/board-osk.c
index 80d8620..bd94eb2 100644
--- a/arch/arm/mach-omap1/board-osk.c
+++ b/arch/arm/mach-omap1/board-osk.c
@@ -584,6 +584,7 @@ MACHINE_START(OMAP_OSK, "TI-OSK")
 	.io_pg_offst	= ((0xfef00000) >> 18) & 0xfffc,
 	.boot_params	= 0x10000100,
 	.map_io		= osk_map_io,
+	.reserve	= omap1_reserve,
 	.init_irq	= osk_init_irq,
 	.init_machine	= osk_init,
 	.timer		= &omap_timer,
diff --git a/arch/arm/mach-omap1/board-palmte.c b/arch/arm/mach-omap1/board-palmte.c
index 569b4c9..151719f 100644
--- a/arch/arm/mach-omap1/board-palmte.c
+++ b/arch/arm/mach-omap1/board-palmte.c
@@ -373,6 +373,7 @@ MACHINE_START(OMAP_PALMTE, "OMAP310 based Palm Tungsten E")
 	.io_pg_offst	= ((0xfef00000) >> 18) & 0xfffc,
 	.boot_params	= 0x10000100,
 	.map_io		= omap_palmte_map_io,
+	.reserve	= omap1_reserve,
 	.init_irq	= omap_palmte_init_irq,
 	.init_machine	= omap_palmte_init,
 	.timer		= &omap_timer,
diff --git a/arch/arm/mach-omap1/board-palmtt.c b/arch/arm/mach-omap1/board-palmtt.c
index 6ad49a2..5034a28 100644
--- a/arch/arm/mach-omap1/board-palmtt.c
+++ b/arch/arm/mach-omap1/board-palmtt.c
@@ -321,6 +321,7 @@ MACHINE_START(OMAP_PALMTT, "OMAP1510 based Palm Tungsten|T")
 	.io_pg_offst	= ((0xfef00000) >> 18) & 0xfffc,
 	.boot_params	= 0x10000100,
 	.map_io		= omap_palmtt_map_io,
+	.reserve	= omap1_reserve,
 	.init_irq	= omap_palmtt_init_irq,
 	.init_machine	= omap_palmtt_init,
 	.timer		= &omap_timer,
diff --git a/arch/arm/mach-omap1/board-palmz71.c b/arch/arm/mach-omap1/board-palmz71.c
index 6641de9..ea1b033 100644
--- a/arch/arm/mach-omap1/board-palmz71.c
+++ b/arch/arm/mach-omap1/board-palmz71.c
@@ -338,10 +338,12 @@ omap_palmz71_map_io(void)
 }
 
 MACHINE_START(OMAP_PALMZ71, "OMAP310 based Palm Zire71")
-	.phys_io = 0xfff00000,
-	.io_pg_offst = ((0xfef00000) >> 18) & 0xfffc,
-	.boot_params = 0x10000100,.map_io = omap_palmz71_map_io,
-	.init_irq = omap_palmz71_init_irq,
-	.init_machine = omap_palmz71_init,
-	.timer = &omap_timer,
+	.phys_io	= 0xfff00000,
+	.io_pg_offst	= ((0xfef00000) >> 18) & 0xfffc,
+	.boot_params	= 0x10000100,
+	.map_io		= omap_palmz71_map_io,
+	.reserve	= omap1_reserve,
+	.init_irq	= omap_palmz71_init_irq,
+	.init_machine	= omap_palmz71_init,
+	.timer		= &omap_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap1/board-perseus2.c b/arch/arm/mach-omap1/board-perseus2.c
index e854d57..1a0ac1c 100644
--- a/arch/arm/mach-omap1/board-perseus2.c
+++ b/arch/arm/mach-omap1/board-perseus2.c
@@ -339,6 +339,7 @@ MACHINE_START(OMAP_PERSEUS2, "OMAP730 Perseus2")
 	.io_pg_offst	= ((0xfef00000) >> 18) & 0xfffc,
 	.boot_params	= 0x10000100,
 	.map_io		= omap_perseus2_map_io,
+	.reserve	= omap1_reserve,
 	.init_irq	= omap_perseus2_init_irq,
 	.init_machine	= omap_perseus2_init,
 	.timer		= &omap_timer,
diff --git a/arch/arm/mach-omap1/board-sx1.c b/arch/arm/mach-omap1/board-sx1.c
index 2fb1e5f..2a833a1 100644
--- a/arch/arm/mach-omap1/board-sx1.c
+++ b/arch/arm/mach-omap1/board-sx1.c
@@ -423,7 +423,8 @@ MACHINE_START(SX1, "OMAP310 based Siemens SX1")
 	.io_pg_offst	= ((0xfef00000) >> 18) & 0xfffc,
 	.boot_params	= 0x10000100,
 	.map_io		= omap_sx1_map_io,
-	.init_irq		= omap_sx1_init_irq,
+	.reserve	= omap1_reserve,
+	.init_irq	= omap_sx1_init_irq,
 	.init_machine	= omap_sx1_init,
 	.timer		= &omap_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap1/board-voiceblue.c b/arch/arm/mach-omap1/board-voiceblue.c
index 87b9436..fd47c5f 100644
--- a/arch/arm/mach-omap1/board-voiceblue.c
+++ b/arch/arm/mach-omap1/board-voiceblue.c
@@ -287,6 +287,7 @@ MACHINE_START(VOICEBLUE, "VoiceBlue OMAP5910")
 	.io_pg_offst	= ((0xfef00000) >> 18) & 0xfffc,
 	.boot_params	= 0x10000100,
 	.map_io		= voiceblue_map_io,
+	.reserve	= omap1_reserve,
 	.init_irq	= voiceblue_init_irq,
 	.init_machine	= voiceblue_init,
 	.timer		= &omap_timer,
diff --git a/arch/arm/mach-omap1/io.c b/arch/arm/mach-omap1/io.c
index d9b8d82..f872406 100644
--- a/arch/arm/mach-omap1/io.c
+++ b/arch/arm/mach-omap1/io.c
@@ -12,6 +12,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/io.h>
+#include <linux/omapfb.h>
 
 #include <asm/tlb.h>
 #include <asm/mach/map.h>
@@ -22,7 +23,6 @@
 
 extern void omap_check_revision(void);
 extern void omap_sram_init(void);
-extern void omapfb_reserve_sdram(void);
 
 /*
  * The machine specific code may provide the extra mapping besides the
@@ -122,7 +122,6 @@ void __init omap1_map_common_io(void)
 #endif
 
 	omap_sram_init();
-	omapfb_reserve_sdram();
 }
 
 /*
@@ -144,3 +143,7 @@ void __init omap1_init_common_hw(void)
 	omap1_mux_init();
 }
 
+void __init omap1_reserve(void)
+{
+	omapfb_reserve_sdram_lmb();
+}
diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index 01d113f..e7a4802 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -229,7 +229,9 @@ MACHINE_START(OMAP_2430SDP, "OMAP2430 sdp2430 board")
 	.io_pg_offst	= ((0xfa000000) >> 18) & 0xfffc,
 	.boot_params	= 0x80000100,
 	.map_io		= omap_2430sdp_map_io,
+	.reserve	= omap2_reserve,
 	.init_irq	= omap_2430sdp_init_irq,
 	.init_machine	= omap_2430sdp_init,
 	.timer		= &omap_timer,
 MACHINE_END
+
diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 5822bcf..cec2948 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -816,6 +816,7 @@ MACHINE_START(OMAP_3430SDP, "OMAP3430 3430SDP board")
 	.io_pg_offst	= ((0xfa000000) >> 18) & 0xfffc,
 	.boot_params	= 0x80000100,
 	.map_io		= omap_3430sdp_map_io,
+	.reserve	= omap2_reserve,
 	.init_irq	= omap_3430sdp_init_irq,
 	.init_machine	= omap_3430sdp_init,
 	.timer		= &omap_timer,
diff --git a/arch/arm/mach-omap2/board-3630sdp.c b/arch/arm/mach-omap2/board-3630sdp.c
index a0a2a11..4fb164c 100644
--- a/arch/arm/mach-omap2/board-3630sdp.c
+++ b/arch/arm/mach-omap2/board-3630sdp.c
@@ -107,6 +107,7 @@ MACHINE_START(OMAP_3630SDP, "OMAP 3630SDP board")
 	.io_pg_offst	= ((0xfa000000) >> 18) & 0xfffc,
 	.boot_params	= 0x80000100,
 	.map_io		= omap_sdp_map_io,
+	.reserve	= omap2_reserve,
 	.init_irq	= omap_sdp_init_irq,
 	.init_machine	= omap_sdp_init,
 	.timer		= &omap_timer,
diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index b88f28c..a8bb755 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -134,6 +134,7 @@ MACHINE_START(OMAP_4430SDP, "OMAP4430 4430SDP board")
 	.io_pg_offst	= ((0xfa000000) >> 18) & 0xfffc,
 	.boot_params	= 0x80000100,
 	.map_io		= omap_4430sdp_map_io,
+	.reserve	= omap2_reserve,
 	.init_irq	= omap_4430sdp_init_irq,
 	.init_machine	= omap_4430sdp_init,
 	.timer		= &omap_timer,
diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index 6ae8805..39c5c8a 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -326,6 +326,7 @@ MACHINE_START(OMAP3517EVM, "OMAP3517/AM3517 EVM")
 	.io_pg_offst	= ((0xd8000000) >> 18) & 0xfffc,
 	.boot_params	= 0x80000100,
 	.map_io		= am3517_evm_map_io,
+	.reserve	= omap2_reserve,
 	.init_irq	= am3517_evm_init_irq,
 	.init_machine	= am3517_evm_init,
 	.timer		= &omap_timer,
diff --git a/arch/arm/mach-omap2/board-apollon.c b/arch/arm/mach-omap2/board-apollon.c
index aa69fb9..dc2d735 100644
--- a/arch/arm/mach-omap2/board-apollon.c
+++ b/arch/arm/mach-omap2/board-apollon.c
@@ -346,6 +346,7 @@ MACHINE_START(OMAP_APOLLON, "OMAP24xx Apollon")
 	.io_pg_offst	= ((0xfa000000) >> 18) & 0xfffc,
 	.boot_params	= 0x80000100,
 	.map_io		= omap_apollon_map_io,
+	.reserve	= omap2_reserve,
 	.init_irq	= omap_apollon_init_irq,
 	.init_machine	= omap_apollon_init,
 	.timer		= &omap_timer,
diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index 2de4f79..166bd03 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -836,6 +836,7 @@ MACHINE_START(CM_T35, "Compulab CM-T35")
 	.io_pg_offst	= ((0xd8000000) >> 18) & 0xfffc,
 	.boot_params	= 0x80000100,
 	.map_io		= cm_t35_map_io,
+	.reserve	= omap2_reserve,
 	.init_irq	= cm_t35_init_irq,
 	.init_machine	= cm_t35_init,
 	.timer		= &omap_timer,
diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 5bfc13b..9f41c49 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -691,6 +691,7 @@ MACHINE_START(DEVKIT8000, "OMAP3 Devkit8000")
 	.io_pg_offst	= ((0xd8000000) >> 18) & 0xfffc,
 	.boot_params	= 0x80000100,
 	.map_io		= devkit8000_map_io,
+	.reserve	= omap2_reserve,
 	.init_irq	= devkit8000_init_irq,
 	.init_machine	= devkit8000_init,
 	.timer		= &omap_timer,
diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index 16cc068..227e80b 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -59,6 +59,7 @@ MACHINE_START(OMAP_GENERIC, "Generic OMAP24xx")
 	.io_pg_offst	= ((0xfa000000) >> 18) & 0xfffc,
 	.boot_params	= 0x80000100,
 	.map_io		= omap_generic_map_io,
+	.reserve	= omap2_reserve,
 	.init_irq	= omap_generic_init_irq,
 	.init_machine	= omap_generic_init,
 	.timer		= &omap_timer,
diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
index 0665f2c..5743a51 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -378,6 +378,7 @@ MACHINE_START(OMAP_H4, "OMAP2420 H4 board")
 	.io_pg_offst	= ((0xfa000000) >> 18) & 0xfffc,
 	.boot_params	= 0x80000100,
 	.map_io		= omap_h4_map_io,
+	.reserve	= omap2_reserve,
 	.init_irq	= omap_h4_init_irq,
 	.init_machine	= omap_h4_init,
 	.timer		= &omap_timer,
diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index 3c7789d..8242921 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -543,6 +543,7 @@ MACHINE_START(IGEP0020, "IGEP v2 board")
 	.io_pg_offst	= ((0xfa000000) >> 18) & 0xfffc,
 	.boot_params	= 0x80000100,
 	.map_io		= igep2_map_io,
+	.reserve	= omap2_reserve,
 	.init_irq	= igep2_init_irq,
 	.init_machine	= igep2_init,
 	.timer		= &omap_timer,
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index 5fcb52e..80d10cd 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -418,6 +418,7 @@ MACHINE_START(OMAP_LDP, "OMAP LDP board")
 	.io_pg_offst	= ((0xfa000000) >> 18) & 0xfffc,
 	.boot_params	= 0x80000100,
 	.map_io		= omap_ldp_map_io,
+	.reserve	= omap2_reserve,
 	.init_irq	= omap_ldp_init_irq,
 	.init_machine	= omap_ldp_init,
 	.timer		= &omap_timer,
diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
index da9bcb8..a426063 100644
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -687,6 +687,7 @@ MACHINE_START(NOKIA_N810_WIMAX, "Nokia N810 WiMAX")
 	.io_pg_offst	= ((0xfa000000) >> 18) & 0xfffc,
 	.boot_params	= 0x80000100,
 	.map_io		= n8x0_map_io,
+	.reserve	= omap2_reserve,
 	.init_irq	= n8x0_init_irq,
 	.init_machine	= n8x0_init_machine,
 	.timer		= &omap_timer,
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 962d377..5df89f6 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -470,6 +470,7 @@ MACHINE_START(OMAP3_BEAGLE, "OMAP3 Beagle Board")
 	.io_pg_offst	= ((0xfa000000) >> 18) & 0xfffc,
 	.boot_params	= 0x80000100,
 	.map_io		= omap3_beagle_map_io,
+	.reserve	= omap2_reserve,
 	.init_irq	= omap3_beagle_init_irq,
 	.init_machine	= omap3_beagle_init,
 	.timer		= &omap_timer,
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 017bb2f..49aa19c 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -726,6 +726,7 @@ MACHINE_START(OMAP3EVM, "OMAP3 EVM")
 	.io_pg_offst	= ((0xfa000000) >> 18) & 0xfffc,
 	.boot_params	= 0x80000100,
 	.map_io		= omap3_evm_map_io,
+	.reserve	= omap2_reserve,
 	.init_irq	= omap3_evm_init_irq,
 	.init_machine	= omap3_evm_init,
 	.timer		= &omap_timer,
diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index 395d049..ca289ed 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -601,6 +601,7 @@ MACHINE_START(OMAP3_PANDORA, "Pandora Handheld Console")
 	.io_pg_offst	= ((0xfa000000) >> 18) & 0xfffc,
 	.boot_params	= 0x80000100,
 	.map_io		= omap3pandora_map_io,
+	.reserve	= omap2_reserve,
 	.init_irq	= omap3pandora_init_irq,
 	.init_machine	= omap3pandora_init,
 	.timer		= &omap_timer,
diff --git a/arch/arm/mach-omap2/board-omap3touchbook.c b/arch/arm/mach-omap2/board-omap3touchbook.c
index 2504d41..c59050d 100644
--- a/arch/arm/mach-omap2/board-omap3touchbook.c
+++ b/arch/arm/mach-omap2/board-omap3touchbook.c
@@ -572,6 +572,7 @@ MACHINE_START(TOUCHBOOK, "OMAP3 touchbook Board")
 	.io_pg_offst	= ((0xd8000000) >> 18) & 0xfffc,
 	.boot_params	= 0x80000100,
 	.map_io		= omap3_touchbook_map_io,
+	.reserve	= omap2_reserve,
 	.init_irq	= omap3_touchbook_init_irq,
 	.init_machine	= omap3_touchbook_init,
 	.timer		= &omap_timer,
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index 8848c7c..af67079 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -483,6 +483,7 @@ MACHINE_START(OVERO, "Gumstix Overo")
 	.io_pg_offst	= ((0xfa000000) >> 18) & 0xfffc,
 	.boot_params	= 0x80000100,
 	.map_io		= overo_map_io,
+	.reserve	= omap2_reserve,
 	.init_irq	= overo_init_irq,
 	.init_machine	= overo_init,
 	.timer		= &omap_timer,
diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/board-rx51.c
index b155c36..390a0bc 100644
--- a/arch/arm/mach-omap2/board-rx51.c
+++ b/arch/arm/mach-omap2/board-rx51.c
@@ -152,6 +152,7 @@ MACHINE_START(NOKIA_RX51, "Nokia RX-51 board")
 	.io_pg_offst	= ((0xfa000000) >> 18) & 0xfffc,
 	.boot_params	= 0x80000100,
 	.map_io		= rx51_map_io,
+	.reserve	= omap2_reserve,
 	.init_irq	= rx51_init_irq,
 	.init_machine	= rx51_init,
 	.timer		= &omap_timer,
diff --git a/arch/arm/mach-omap2/board-zoom2.c b/arch/arm/mach-omap2/board-zoom2.c
index 9a26f84..377c9ba 100644
--- a/arch/arm/mach-omap2/board-zoom2.c
+++ b/arch/arm/mach-omap2/board-zoom2.c
@@ -95,6 +95,7 @@ MACHINE_START(OMAP_ZOOM2, "OMAP Zoom2 board")
 	.io_pg_offst	= ((0xfa000000) >> 18) & 0xfffc,
 	.boot_params	= 0x80000100,
 	.map_io		= omap_zoom2_map_io,
+	.reserve	= omap2_reserve,
 	.init_irq	= omap_zoom2_init_irq,
 	.init_machine	= omap_zoom2_init,
 	.timer		= &omap_timer,
diff --git a/arch/arm/mach-omap2/board-zoom3.c b/arch/arm/mach-omap2/board-zoom3.c
index cd3e40c..d33cf07 100644
--- a/arch/arm/mach-omap2/board-zoom3.c
+++ b/arch/arm/mach-omap2/board-zoom3.c
@@ -77,6 +77,7 @@ MACHINE_START(OMAP_ZOOM3, "OMAP Zoom3 board")
 	.io_pg_offst	= ((0xfa000000) >> 18) & 0xfffc,
 	.boot_params	= 0x80000100,
 	.map_io		= omap_zoom_map_io,
+	.reserve	= omap2_reserve,
 	.init_irq	= omap_zoom_init_irq,
 	.init_machine	= omap_zoom_init,
 	.timer		= &omap_timer,
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 87f676a..b761904 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -232,7 +232,6 @@ static void __init _omap2_map_common_io(void)
 
 	omap2_check_revision();
 	omap_sram_init();
-	omapfb_reserve_sdram();
 	omap_vram_reserve_sdram();
 }
 
@@ -340,3 +339,9 @@ void __init omap2_init_common_hw(struct omap_sdrc_params *sdrc_cs0,
 	}
 	gpmc_init();
 }
+
+void __init omap2_reserve(void)
+{
+	omapfb_reserve_sdram_lmb();
+}
+
diff --git a/arch/arm/plat-omap/fb.c b/arch/arm/plat-omap/fb.c
index d3eea4f..8d9afff 100644
--- a/arch/arm/plat-omap/fb.c
+++ b/arch/arm/plat-omap/fb.c
@@ -26,7 +26,7 @@
 #include <linux/mm.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
-#include <linux/bootmem.h>
+#include <linux/lmb.h>
 #include <linux/io.h>
 #include <linux/omapfb.h>
 
@@ -171,49 +171,54 @@ static int check_fbmem_region(int region_idx, struct omapfb_mem_region *rg,
 	return 0;
 }
 
-/*
- * Called from map_io. We need to call to this early enough so that we
- * can reserve the fixed SDRAM regions before VM could get hold of them.
- */
-void __init omapfb_reserve_sdram(void)
+void __init omapfb_reserve_sdram_lmb(void)
 {
-	struct bootmem_data	*bdata;
-	unsigned long		sdram_start, sdram_size;
-	unsigned long		reserved;
-	int			i;
-
-	if (config_invalid)
-		return;
+	unsigned long reserved = 0;
+	int i;
 
-	bdata = NODE_DATA(0)->bdata;
-	sdram_start = bdata->node_min_pfn << PAGE_SHIFT;
-	sdram_size = (bdata->node_low_pfn << PAGE_SHIFT) - sdram_start;
-	reserved = 0;
 	for (i = 0; ; i++) {
-		struct omapfb_mem_region	rg;
+		struct omapfb_mem_region rg;
+		struct lmb_property res;
 
 		if (get_fbmem_region(i, &rg) < 0)
 			break;
+
 		if (i == OMAPFB_PLANE_NUM) {
-			printk(KERN_ERR
-				"Extraneous FB mem configuration entries\n");
+			pr_err("Extraneous FB mem configuration entries\n");
 			config_invalid = 1;
 			return;
 		}
+
 		/* Check if it's our memory type. */
-		if (set_fbmem_region_type(&rg, OMAPFB_MEMTYPE_SDRAM,
-				          sdram_start, sdram_size) < 0 ||
-		    (rg.type != OMAPFB_MEMTYPE_SDRAM))
+		if (rg.type != 0 && rg.type != OMAPFB_MEMTYPE_SDRAM)
 			continue;
-		BUG_ON(omapfb_config.mem_desc.region[i].size);
-		if (check_fbmem_region(i, &rg, sdram_start, sdram_size) < 0) {
+
+		/* Does it fall within SDRAM ? */
+		res.base = rg.paddr;
+		res.size = rg.size;
+		if (lmb_find(&res) || res.base != rg.paddr || res.size != rg.size)
+			continue;
+
+		rg.type = OMAPFB_MEMTYPE_SDRAM;
+
+		if (rg.size == 0) {
+			pr_err("Zero size for FB region %d\n", i);
 			config_invalid = 1;
 			return;
 		}
+
 		if (rg.paddr) {
-			reserve_bootmem(rg.paddr, rg.size, BOOTMEM_DEFAULT);
+			if (lmb_is_region_reserved(rg.paddr, rg.size)) {
+				pr_err("Trying to use reserved memory for FB region %d\n", i);
+				config_invalid = 1;
+				return;
+			}
+
+			lmb_reserve(rg.paddr, rg.size);
 			reserved += rg.size;
 		}
+
+		BUG_ON(omapfb_config.mem_desc.region[i].size);
 		omapfb_config.mem_desc.region[i] = rg;
 		configured_regions++;
 	}
@@ -359,7 +364,10 @@ static inline int omap_init_fb(void)
 
 arch_initcall(omap_init_fb);
 
-void omapfb_reserve_sdram(void) {}
+void omapfb_reserve_sdram_lmb(void)
+{
+}
+
 unsigned long omapfb_reserve_sram(unsigned long sram_pstart,
 				  unsigned long sram_vstart,
 				  unsigned long sram_size,
@@ -375,7 +383,10 @@ void omapfb_set_platform_data(struct omapfb_platform_data *data)
 {
 }
 
-void omapfb_reserve_sdram(void) {}
+void omapfb_reserve_sdram_lmb(void)
+{
+}
+
 unsigned long omapfb_reserve_sram(unsigned long sram_pstart,
 				  unsigned long sram_vstart,
 				  unsigned long sram_size,
diff --git a/arch/arm/plat-omap/include/plat/common.h b/arch/arm/plat-omap/include/plat/common.h
index 7556e27..49d662c 100644
--- a/arch/arm/plat-omap/include/plat/common.h
+++ b/arch/arm/plat-omap/include/plat/common.h
@@ -37,6 +37,9 @@ extern void __iomem *gic_cpu_base_addr;
 extern void omap_map_common_io(void);
 extern struct sys_timer omap_timer;
 
+extern void omap1_reserve(void);
+extern void omap2_reserve(void);
+
 /*
  * IO bases for various OMAP processors
  * Except the tap base, rest all the io bases
diff --git a/include/linux/omapfb.h b/include/linux/omapfb.h
index 9bdd914..45707be 100644
--- a/include/linux/omapfb.h
+++ b/include/linux/omapfb.h
@@ -253,7 +253,7 @@ struct omapfb_platform_data {
 /* in arch/arm/plat-omap/fb.c */
 extern void omapfb_set_platform_data(struct omapfb_platform_data *data);
 extern void omapfb_set_ctrl_platform_data(void *pdata);
-extern void omapfb_reserve_sdram(void);
+extern void omapfb_reserve_sdram_lmb(void);
 
 #endif
 
