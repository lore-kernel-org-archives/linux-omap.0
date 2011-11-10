From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ARM: OMAP: Introduce local common.h files
Date: Thu, 10 Nov 2011 22:29:07 +0000
Message-ID: <20111110222907.GR15294@n2100.arm.linux.org.uk>
References: <20111106135250.GC15294@n2100.arm.linux.org.uk> <20111108004550.GH31337@atomide.com> <20111110201719.GW31337@atomide.com> <20111110202356.GQ15294@n2100.arm.linux.org.uk> <20111110215008.GX31337@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20111110215008.GX31337@atomide.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, Nov 10, 2011 at 01:50:09PM -0800, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [111110 11:49]:
> > On Thu, Nov 10, 2011 at 12:17:19PM -0800, Tony Lindgren wrote:
> > > As suggested by Russell King - ARM Linux <linux@arm.linux.org.uk>,
> > > there's no need to keep local prototypes in non-local headers.
> > > 
> > > Add mach-omap1/common.h and mach-omap2/common.h and move the
> > > local prototypes there from plat/common.h and mach/omap4-common.h.
> > > 
> > > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > 
> > Great, looks fine, thanks.  I suspect the chance of conflicts on this are
> > about the same as the chance of conflicts with the rest of the restart
> > series (in that, new platforms will need to be fixed for both these
> > changes.)
> > 
> > So, I suggest that I add it to my series so I can fix the OMAP changes
> > there so stuff still builds - and then I can see about publishing a more
> > stable branch in a couple of weeks for new platforms to base on.
> 
> OK, a stable branch is needed badly for this.. If possible please
> publish some minimal stable base branch as soon as you can as pretty
> much all omap patches need to be updated for this one.

I want to give it something between a week and two before closing the
window for acked-bys etc (amongst other reasons).

> > If you agree, could you put it in the patch system please?  Thanks.
> 
> Sounds good to me, it there now as patch 7159/1.

Thanks, merged that into the series.  The updated OMAP patch updated is
below, which has been moved to part 2.  Lastly, the final patch of part
2 has been updated to delete the empty arch_reset(), so OMAP is now
entirely free of arch_reset() references.  This leaves a total of 12
references left to nobble.

8<---
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH] ARM: restart: omap: use new restart hook

Hook these platforms restart code into the new restart hook rather
than using arch_reset().

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap1/board-ams-delta.c      |    1 +
 arch/arm/mach-omap1/board-fsample.c        |    1 +
 arch/arm/mach-omap1/board-generic.c        |    1 +
 arch/arm/mach-omap1/board-h2.c             |    1 +
 arch/arm/mach-omap1/board-h3.c             |    1 +
 arch/arm/mach-omap1/board-htcherald.c      |    1 +
 arch/arm/mach-omap1/board-innovator.c      |    1 +
 arch/arm/mach-omap1/board-nokia770.c       |    1 +
 arch/arm/mach-omap1/board-osk.c            |    1 +
 arch/arm/mach-omap1/board-palmte.c         |    1 +
 arch/arm/mach-omap1/board-palmtt.c         |    1 +
 arch/arm/mach-omap1/board-palmz71.c        |    1 +
 arch/arm/mach-omap1/board-perseus2.c       |    1 +
 arch/arm/mach-omap1/board-sx1.c            |    1 +
 arch/arm/mach-omap1/board-voiceblue.c      |    5 ++---
 arch/arm/mach-omap1/common.h               |    1 +
 arch/arm/mach-omap1/reset.c                |    4 +---
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
 arch/arm/mach-omap2/board-generic.c        |    4 ++++
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
 arch/arm/mach-omap2/common.h               |    1 +
 arch/arm/mach-omap2/prcm.c                 |    4 +---
 arch/arm/plat-omap/include/plat/system.h   |    4 +++-
 47 files changed, 59 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index 1b37400..2120369 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -382,6 +382,7 @@ MACHINE_START(AMS_DELTA, "Amstrad E3 (Delta)")
 	.init_irq	= omap1_init_irq,
 	.init_machine	= ams_delta_init,
 	.timer		= &omap1_timer,
+	.restart	= omap1_restart,
 MACHINE_END
 
 EXPORT_SYMBOL(ams_delta_latch1_write);
diff --git a/arch/arm/mach-omap1/board-fsample.c b/arch/arm/mach-omap1/board-fsample.c
index b9c4c0f..0b9464b 100644
--- a/arch/arm/mach-omap1/board-fsample.c
+++ b/arch/arm/mach-omap1/board-fsample.c
@@ -390,4 +390,5 @@ MACHINE_START(OMAP_FSAMPLE, "OMAP730 F-Sample")
 	.init_irq	= omap1_init_irq,
 	.init_machine	= omap_fsample_init,
 	.timer		= &omap1_timer,
+	.restart	= omap1_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap1/board-generic.c b/arch/arm/mach-omap1/board-generic.c
index 7f41d7a..9a5fe58 100644
--- a/arch/arm/mach-omap1/board-generic.c
+++ b/arch/arm/mach-omap1/board-generic.c
@@ -89,4 +89,5 @@ MACHINE_START(OMAP_GENERIC, "Generic OMAP1510/1610/1710")
 	.init_irq	= omap1_init_irq,
 	.init_machine	= omap_generic_init,
 	.timer		= &omap1_timer,
+	.restart	= omap1_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap1/board-h2.c b/arch/arm/mach-omap1/board-h2.c
index 7933b97..00ad6b2 100644
--- a/arch/arm/mach-omap1/board-h2.c
+++ b/arch/arm/mach-omap1/board-h2.c
@@ -456,4 +456,5 @@ MACHINE_START(OMAP_H2, "TI-H2")
 	.init_irq	= omap1_init_irq,
 	.init_machine	= h2_init,
 	.timer		= &omap1_timer,
+	.restart	= omap1_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap1/board-h3.c b/arch/arm/mach-omap1/board-h3.c
index 04be2f8..4a7f251 100644
--- a/arch/arm/mach-omap1/board-h3.c
+++ b/arch/arm/mach-omap1/board-h3.c
@@ -444,4 +444,5 @@ MACHINE_START(OMAP_H3, "TI OMAP1710 H3 board")
 	.init_irq	= omap1_init_irq,
 	.init_machine	= h3_init,
 	.timer		= &omap1_timer,
+	.restart	= omap1_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap1/board-htcherald.c b/arch/arm/mach-omap1/board-htcherald.c
index 46fcfeb..731cc3d 100644
--- a/arch/arm/mach-omap1/board-htcherald.c
+++ b/arch/arm/mach-omap1/board-htcherald.c
@@ -610,4 +610,5 @@ MACHINE_START(HERALD, "HTC Herald")
 	.init_irq       = omap1_init_irq,
 	.init_machine   = htcherald_init,
 	.timer          = &omap1_timer,
+	.restart	= omap1_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap1/board-innovator.c b/arch/arm/mach-omap1/board-innovator.c
index f99d11d..309369e 100644
--- a/arch/arm/mach-omap1/board-innovator.c
+++ b/arch/arm/mach-omap1/board-innovator.c
@@ -460,4 +460,5 @@ MACHINE_START(OMAP_INNOVATOR, "TI-Innovator")
 	.init_irq	= omap1_init_irq,
 	.init_machine	= innovator_init,
 	.timer		= &omap1_timer,
+	.restart	= omap1_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap1/board-nokia770.c b/arch/arm/mach-omap1/board-nokia770.c
index c643423..f9efc03 100644
--- a/arch/arm/mach-omap1/board-nokia770.c
+++ b/arch/arm/mach-omap1/board-nokia770.c
@@ -259,4 +259,5 @@ MACHINE_START(NOKIA770, "Nokia 770")
 	.init_irq	= omap1_init_irq,
 	.init_machine	= omap_nokia770_init,
 	.timer		= &omap1_timer,
+	.restart	= omap1_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap1/board-osk.c b/arch/arm/mach-omap1/board-osk.c
index a409dfc..675de06 100644
--- a/arch/arm/mach-omap1/board-osk.c
+++ b/arch/arm/mach-omap1/board-osk.c
@@ -578,4 +578,5 @@ MACHINE_START(OMAP_OSK, "TI-OSK")
 	.init_irq	= omap1_init_irq,
 	.init_machine	= osk_init,
 	.timer		= &omap1_timer,
+	.restart	= omap1_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap1/board-palmte.c b/arch/arm/mach-omap1/board-palmte.c
index 105292d..81fa27f 100644
--- a/arch/arm/mach-omap1/board-palmte.c
+++ b/arch/arm/mach-omap1/board-palmte.c
@@ -270,4 +270,5 @@ MACHINE_START(OMAP_PALMTE, "OMAP310 based Palm Tungsten E")
 	.init_irq	= omap1_init_irq,
 	.init_machine	= omap_palmte_init,
 	.timer		= &omap1_timer,
+	.restart	= omap1_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap1/board-palmtt.c b/arch/arm/mach-omap1/board-palmtt.c
index 387a900..81cb821 100644
--- a/arch/arm/mach-omap1/board-palmtt.c
+++ b/arch/arm/mach-omap1/board-palmtt.c
@@ -317,4 +317,5 @@ MACHINE_START(OMAP_PALMTT, "OMAP1510 based Palm Tungsten|T")
 	.init_irq	= omap1_init_irq,
 	.init_machine	= omap_palmtt_init,
 	.timer		= &omap1_timer,
+	.restart	= omap1_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap1/board-palmz71.c b/arch/arm/mach-omap1/board-palmz71.c
index df6d15e..e881945 100644
--- a/arch/arm/mach-omap1/board-palmz71.c
+++ b/arch/arm/mach-omap1/board-palmz71.c
@@ -334,4 +334,5 @@ MACHINE_START(OMAP_PALMZ71, "OMAP310 based Palm Zire71")
 	.init_irq	= omap1_init_irq,
 	.init_machine	= omap_palmz71_init,
 	.timer		= &omap1_timer,
+	.restart	= omap1_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap1/board-perseus2.c b/arch/arm/mach-omap1/board-perseus2.c
index 57ecd7e..c000bed 100644
--- a/arch/arm/mach-omap1/board-perseus2.c
+++ b/arch/arm/mach-omap1/board-perseus2.c
@@ -352,4 +352,5 @@ MACHINE_START(OMAP_PERSEUS2, "OMAP730 Perseus2")
 	.init_irq	= omap1_init_irq,
 	.init_machine	= omap_perseus2_init,
 	.timer		= &omap1_timer,
+	.restart	= omap1_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap1/board-sx1.c b/arch/arm/mach-omap1/board-sx1.c
index 774ae39..7bcd82a 100644
--- a/arch/arm/mach-omap1/board-sx1.c
+++ b/arch/arm/mach-omap1/board-sx1.c
@@ -416,4 +416,5 @@ MACHINE_START(SX1, "OMAP310 based Siemens SX1")
 	.init_irq	= omap1_init_irq,
 	.init_machine	= omap_sx1_init,
 	.timer		= &omap1_timer,
+	.restart	= omap1_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap1/board-voiceblue.c b/arch/arm/mach-omap1/board-voiceblue.c
index 7721c14..fb61434 100644
--- a/arch/arm/mach-omap1/board-voiceblue.c
+++ b/arch/arm/mach-omap1/board-voiceblue.c
@@ -221,7 +221,7 @@ void voiceblue_wdt_ping(void)
 	gpio_set_value(0, wdt_gpio_state);
 }
 
-static void voiceblue_reset(char mode, const char *cmd)
+static void voiceblue_restart(char mode, const char *cmd)
 {
 	/*
 	 * Workaround for 5912/1611b bug mentioned in sprz209d.pdf p. 28
@@ -285,8 +285,6 @@ static void __init voiceblue_init(void)
 	 * (it is connected through invertor) */
 	omap_writeb(0x00, OMAP_LPG1_LCR);
 	omap_writeb(0x00, OMAP_LPG1_PMR);	/* Disable clock */
-
-	arch_reset = voiceblue_reset;
 }
 
 MACHINE_START(VOICEBLUE, "VoiceBlue OMAP5910")
@@ -298,4 +296,5 @@ MACHINE_START(VOICEBLUE, "VoiceBlue OMAP5910")
 	.init_irq	= omap1_init_irq,
 	.init_machine	= voiceblue_init,
 	.timer		= &omap1_timer,
+	.restart	= voiceblue_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap1/common.h b/arch/arm/mach-omap1/common.h
index 52c4eda..a9a5146 100644
--- a/arch/arm/mach-omap1/common.h
+++ b/arch/arm/mach-omap1/common.h
@@ -54,6 +54,7 @@ static inline void omap16xx_map_io(void)
 
 void omap1_init_early(void);
 void omap1_init_irq(void);
+void omap1_restart(char, const char *);
 
 extern struct sys_timer omap1_timer;
 extern bool omap_32k_timer_init(void);
diff --git a/arch/arm/mach-omap1/reset.c b/arch/arm/mach-omap1/reset.c
index ad951ee..8b1cc6e 100644
--- a/arch/arm/mach-omap1/reset.c
+++ b/arch/arm/mach-omap1/reset.c
@@ -8,7 +8,7 @@
 #include <mach/system.h>
 #include <plat/prcm.h>
 
-void omap1_arch_reset(char mode, const char *cmd)
+void omap1_restart(char mode, const char *cmd)
 {
 	/*
 	 * Workaround for 5912/1611b bug mentioned in sprz209d.pdf p. 28
@@ -21,5 +21,3 @@ void omap1_arch_reset(char mode, const char *cmd)
 
 	omap_writew(1, ARM_RSTCT1);
 }
-
-void (*arch_reset)(char, const char *) = omap1_arch_reset;
diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index a17a6c4..2e73024 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -303,4 +303,5 @@ MACHINE_START(OMAP_2430SDP, "OMAP2430 sdp2430 board")
 	.init_irq	= omap2_init_irq,
 	.init_machine	= omap_2430sdp_init,
 	.timer		= &omap2_timer,
+	.restart	= omap_prcm_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 670919c..7111677 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -730,4 +730,5 @@ MACHINE_START(OMAP_3430SDP, "OMAP3430 3430SDP board")
 	.init_irq	= omap3_init_irq,
 	.init_machine	= omap_3430sdp_init,
 	.timer		= &omap3_timer,
+	.restart	= omap_prcm_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-3630sdp.c b/arch/arm/mach-omap2/board-3630sdp.c
index 63f4b4f..a01d081 100644
--- a/arch/arm/mach-omap2/board-3630sdp.c
+++ b/arch/arm/mach-omap2/board-3630sdp.c
@@ -217,4 +217,5 @@ MACHINE_START(OMAP_3630SDP, "OMAP 3630SDP board")
 	.init_irq	= omap3_init_irq,
 	.init_machine	= omap_sdp_init,
 	.timer		= &omap3_timer,
+	.restart	= omap_prcm_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index cff2e32..8a46ad8 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -985,4 +985,5 @@ MACHINE_START(OMAP_4430SDP, "OMAP4430 4430SDP board")
 	.init_irq	= gic_init_irq,
 	.init_machine	= omap_4430sdp_init,
 	.timer		= &omap4_timer,
+	.restart	= omap_prcm_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-am3517crane.c b/arch/arm/mach-omap2/board-am3517crane.c
index 2570475..c1d6b63 100644
--- a/arch/arm/mach-omap2/board-am3517crane.c
+++ b/arch/arm/mach-omap2/board-am3517crane.c
@@ -100,4 +100,5 @@ MACHINE_START(CRANEBOARD, "AM3517/05 CRANEBOARD")
 	.init_irq	= omap3_init_irq,
 	.init_machine	= am3517_crane_init,
 	.timer		= &omap3_timer,
+	.restart	= omap_prcm_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index 56ea011..18c0790 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -493,4 +493,5 @@ MACHINE_START(OMAP3517EVM, "OMAP3517/AM3517 EVM")
 	.init_irq	= omap3_init_irq,
 	.init_machine	= am3517_evm_init,
 	.timer		= &omap3_timer,
+	.restart	= omap_prcm_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-apollon.c b/arch/arm/mach-omap2/board-apollon.c
index 9aea158..75c731c 100644
--- a/arch/arm/mach-omap2/board-apollon.c
+++ b/arch/arm/mach-omap2/board-apollon.c
@@ -356,4 +356,5 @@ MACHINE_START(OMAP_APOLLON, "OMAP24xx Apollon")
 	.init_irq	= omap2_init_irq,
 	.init_machine	= omap_apollon_init,
 	.timer		= &omap2_timer,
+	.restart	= omap_prcm_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index e1de33e..c3402cd 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -636,6 +636,7 @@ MACHINE_START(CM_T35, "Compulab CM-T35")
 	.init_irq	= omap3_init_irq,
 	.init_machine	= cm_t35_init,
 	.timer		= &omap3_timer,
+	.restart	= omap_prcm_restart,
 MACHINE_END
 
 MACHINE_START(CM_T3730, "Compulab CM-T3730")
@@ -646,4 +647,5 @@ MACHINE_START(CM_T3730, "Compulab CM-T3730")
 	.init_irq       = omap3_init_irq,
 	.init_machine   = cm_t3730_init,
 	.timer          = &omap3_timer,
+	.restart	= omap_prcm_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-cm-t3517.c b/arch/arm/mach-omap2/board-cm-t3517.c
index 952df9b..0b06ac3 100644
--- a/arch/arm/mach-omap2/board-cm-t3517.c
+++ b/arch/arm/mach-omap2/board-cm-t3517.c
@@ -301,4 +301,5 @@ MACHINE_START(CM_T3517, "Compulab CM-T3517")
 	.init_irq	= omap3_init_irq,
 	.init_machine	= cm_t3517_init,
 	.timer		= &omap3_timer,
+	.restart	= omap_prcm_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 99e6e7a..519e5f9 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -662,4 +662,5 @@ MACHINE_START(DEVKIT8000, "OMAP3 Devkit8000")
 	.init_irq	= omap3_init_irq,
 	.init_machine	= devkit8000_init,
 	.timer		= &omap3_secure_timer,
+	.restart	= omap_prcm_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index a89d723..f462d8c 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -106,6 +106,7 @@ DT_MACHINE_START(OMAP242X_DT, "Generic OMAP2420 (Flattened Device Tree)")
 	.init_machine	= omap_generic_init,
 	.timer		= &omap2_timer,
 	.dt_compat	= omap242x_boards_compat,
+	.restart	= omap_prcm_restart,
 MACHINE_END
 #endif
 
@@ -124,6 +125,7 @@ DT_MACHINE_START(OMAP243X_DT, "Generic OMAP2430 (Flattened Device Tree)")
 	.init_machine	= omap_generic_init,
 	.timer		= &omap2_timer,
 	.dt_compat	= omap243x_boards_compat,
+	.restart	= omap_prcm_restart,
 MACHINE_END
 #endif
 
@@ -142,6 +144,7 @@ DT_MACHINE_START(OMAP3_DT, "Generic OMAP3 (Flattened Device Tree)")
 	.init_machine	= omap3_init,
 	.timer		= &omap3_timer,
 	.dt_compat	= omap3_boards_compat,
+	.restart	= omap_prcm_restart,
 MACHINE_END
 #endif
 
@@ -160,5 +163,6 @@ DT_MACHINE_START(OMAP4_DT, "Generic OMAP4 (Flattened Device Tree)")
 	.init_machine	= omap4_init,
 	.timer		= &omap4_timer,
 	.dt_compat	= omap4_boards_compat,
+	.restart	= omap_prcm_restart,
 MACHINE_END
 #endif
diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
index 199a174..34ccde4 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -398,4 +398,5 @@ MACHINE_START(OMAP_H4, "OMAP2420 H4 board")
 	.init_irq	= omap2_init_irq,
 	.init_machine	= omap_h4_init,
 	.timer		= &omap2_timer,
+	.restart	= omap_prcm_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index 6434bdc..e1850d5 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -674,6 +674,7 @@ MACHINE_START(IGEP0020, "IGEP v2 board")
 	.init_irq	= omap3_init_irq,
 	.init_machine	= igep_init,
 	.timer		= &omap3_timer,
+	.restart	= omap_prcm_restart,
 MACHINE_END
 
 MACHINE_START(IGEP0030, "IGEP OMAP3 module")
@@ -684,4 +685,5 @@ MACHINE_START(IGEP0030, "IGEP OMAP3 module")
 	.init_irq	= omap3_init_irq,
 	.init_machine	= igep_init,
 	.timer		= &omap3_timer,
+	.restart	= omap_prcm_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index e75102a..84bbdd6 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -436,4 +436,5 @@ MACHINE_START(OMAP_LDP, "OMAP LDP board")
 	.init_irq	= omap3_init_irq,
 	.init_machine	= omap_ldp_init,
 	.timer		= &omap3_timer,
+	.restart	= omap_prcm_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
index 7368614..cc1dd54 100644
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -691,6 +691,7 @@ MACHINE_START(NOKIA_N800, "Nokia N800")
 	.init_irq	= omap2_init_irq,
 	.init_machine	= n8x0_init_machine,
 	.timer		= &omap2_timer,
+	.restart	= omap_prcm_restart,
 MACHINE_END
 
 MACHINE_START(NOKIA_N810, "Nokia N810")
@@ -701,6 +702,7 @@ MACHINE_START(NOKIA_N810, "Nokia N810")
 	.init_irq	= omap2_init_irq,
 	.init_machine	= n8x0_init_machine,
 	.timer		= &omap2_timer,
+	.restart	= omap_prcm_restart,
 MACHINE_END
 
 MACHINE_START(NOKIA_N810_WIMAX, "Nokia N810 WiMAX")
@@ -711,4 +713,5 @@ MACHINE_START(NOKIA_N810_WIMAX, "Nokia N810 WiMAX")
 	.init_irq	= omap2_init_irq,
 	.init_machine	= n8x0_init_machine,
 	.timer		= &omap2_timer,
+	.restart	= omap_prcm_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 1843e14..bb6031f 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -561,4 +561,5 @@ MACHINE_START(OMAP3_BEAGLE, "OMAP3 Beagle Board")
 	.init_irq	= omap3_init_irq,
 	.init_machine	= omap3_beagle_init,
 	.timer		= &omap3_secure_timer,
+	.restart	= omap_prcm_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 1653d18..60912e4 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -683,4 +683,5 @@ MACHINE_START(OMAP3EVM, "OMAP3 EVM")
 	.init_irq	= omap3_init_irq,
 	.init_machine	= omap3_evm_init,
 	.timer		= &omap3_timer,
+	.restart	= omap_prcm_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-omap3logic.c b/arch/arm/mach-omap2/board-omap3logic.c
index 1b2a776..7ecf04a 100644
--- a/arch/arm/mach-omap2/board-omap3logic.c
+++ b/arch/arm/mach-omap2/board-omap3logic.c
@@ -210,6 +210,7 @@ MACHINE_START(OMAP3_TORPEDO, "Logic OMAP3 Torpedo board")
 	.init_irq	= omap3_init_irq,
 	.init_machine	= omap3logic_init,
 	.timer		= &omap3_timer,
+	.restart	= omap_prcm_restart,
 MACHINE_END
 
 MACHINE_START(OMAP3530_LV_SOM, "OMAP Logic 3530 LV SOM board")
@@ -219,4 +220,5 @@ MACHINE_START(OMAP3530_LV_SOM, "OMAP Logic 3530 LV SOM board")
 	.init_irq	= omap3_init_irq,
 	.init_machine	= omap3logic_init,
 	.timer		= &omap3_timer,
+	.restart	= omap_prcm_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index 6297e81..7071a24 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -608,4 +608,5 @@ MACHINE_START(OMAP3_PANDORA, "Pandora Handheld Console")
 	.init_irq	= omap3_init_irq,
 	.init_machine	= omap3pandora_init,
 	.timer		= &omap3_timer,
+	.restart	= omap_prcm_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-omap3stalker.c b/arch/arm/mach-omap2/board-omap3stalker.c
index ab22647..6e47987 100644
--- a/arch/arm/mach-omap2/board-omap3stalker.c
+++ b/arch/arm/mach-omap2/board-omap3stalker.c
@@ -456,4 +456,5 @@ MACHINE_START(SBC3530, "OMAP3 STALKER")
 	.init_irq		= omap3_init_irq,
 	.init_machine		= omap3_stalker_init,
 	.timer			= &omap3_secure_timer,
+	.restart		= omap_prcm_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-omap3touchbook.c b/arch/arm/mach-omap2/board-omap3touchbook.c
index 2741a34..5bb590a 100644
--- a/arch/arm/mach-omap2/board-omap3touchbook.c
+++ b/arch/arm/mach-omap2/board-omap3touchbook.c
@@ -383,4 +383,5 @@ MACHINE_START(TOUCHBOOK, "OMAP3 touchbook Board")
 	.init_irq	= omap3_init_irq,
 	.init_machine	= omap3_touchbook_init,
 	.timer		= &omap3_secure_timer,
+	.restart	= omap_prcm_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index 7722d4d..955cbee 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -578,4 +578,5 @@ MACHINE_START(OMAP4_PANDA, "OMAP4 Panda board")
 	.init_irq	= gic_init_irq,
 	.init_machine	= omap4_panda_init,
 	.timer		= &omap4_timer,
+	.restart	= omap_prcm_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index 26c5cbb..c14d781 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -564,4 +564,5 @@ MACHINE_START(OVERO, "Gumstix Overo")
 	.init_irq	= omap3_init_irq,
 	.init_machine	= overo_init,
 	.timer		= &omap3_timer,
+	.restart	= omap_prcm_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-rm680.c b/arch/arm/mach-omap2/board-rm680.c
index 6ffb640..0c67ecc 100644
--- a/arch/arm/mach-omap2/board-rm680.c
+++ b/arch/arm/mach-omap2/board-rm680.c
@@ -151,4 +151,5 @@ MACHINE_START(NOKIA_RM680, "Nokia RM-680 board")
 	.init_irq	= omap3_init_irq,
 	.init_machine	= rm680_init,
 	.timer		= &omap3_timer,
+	.restart	= omap_prcm_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/board-rx51.c
index 8477313..c3e716a 100644
--- a/arch/arm/mach-omap2/board-rx51.c
+++ b/arch/arm/mach-omap2/board-rx51.c
@@ -129,4 +129,5 @@ MACHINE_START(NOKIA_RX51, "Nokia RX-51 board")
 	.init_irq	= omap3_init_irq,
 	.init_machine	= rx51_init,
 	.timer		= &omap3_timer,
+	.restart	= omap_prcm_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-ti8168evm.c b/arch/arm/mach-omap2/board-ti8168evm.c
index 8402b39..74713e3 100644
--- a/arch/arm/mach-omap2/board-ti8168evm.c
+++ b/arch/arm/mach-omap2/board-ti8168evm.c
@@ -48,4 +48,5 @@ MACHINE_START(TI8168EVM, "ti8168evm")
 	.init_irq	= ti816x_init_irq,
 	.timer		= &omap3_timer,
 	.init_machine	= ti8168_evm_init,
+	.restart	= omap_prcm_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-zoom.c b/arch/arm/mach-omap2/board-zoom.c
index bd58f92..68d6f1c 100644
--- a/arch/arm/mach-omap2/board-zoom.c
+++ b/arch/arm/mach-omap2/board-zoom.c
@@ -137,6 +137,7 @@ MACHINE_START(OMAP_ZOOM2, "OMAP Zoom2 board")
 	.init_irq	= omap3_init_irq,
 	.init_machine	= omap_zoom_init,
 	.timer		= &omap3_timer,
+	.restart	= omap_prcm_restart,
 MACHINE_END
 
 MACHINE_START(OMAP_ZOOM3, "OMAP Zoom3 board")
@@ -147,4 +148,5 @@ MACHINE_START(OMAP_ZOOM3, "OMAP Zoom3 board")
 	.init_irq	= omap3_init_irq,
 	.init_machine	= omap_zoom_init,
 	.timer		= &omap3_timer,
+	.restart	= omap_prcm_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index 950b39d..1df1b39 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -84,6 +84,7 @@ void omap3_init_early(void);	/* Do not use this one */
 void am35xx_init_early(void);
 void ti816x_init_early(void);
 void omap4430_init_early(void);
+void omap_prcm_restart(char, const char *);
 
 /*
  * IO bases for various OMAP processors
diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
index c35e5ce..b6c8cb5 100644
--- a/arch/arm/mach-omap2/prcm.c
+++ b/arch/arm/mach-omap2/prcm.c
@@ -59,7 +59,7 @@ u32 omap_prcm_get_reset_sources(void)
 EXPORT_SYMBOL(omap_prcm_get_reset_sources);
 
 /* Resets clock rates and reboots the system. Only called from system.h */
-static void omap_prcm_arch_reset(char mode, const char *cmd)
+void omap_prcm_restart(char mode, const char *cmd)
 {
 	s16 prcm_offs = 0;
 
@@ -110,8 +110,6 @@ static void omap_prcm_arch_reset(char mode, const char *cmd)
 	omap2_prm_read_mod_reg(prcm_offs, OMAP2_RM_RSTCTRL); /* OCP barrier */
 }
 
-void (*arch_reset)(char, const char *) = omap_prcm_arch_reset;
-
 /**
  * omap2_cm_wait_idlest - wait for IDLEST bit to indicate module readiness
  * @reg: physical address of module IDLEST register
diff --git a/arch/arm/plat-omap/include/plat/system.h b/arch/arm/plat-omap/include/plat/system.h
index c5fa9e9..910f15f 100644
--- a/arch/arm/plat-omap/include/plat/system.h
+++ b/arch/arm/plat-omap/include/plat/system.h
@@ -12,6 +12,8 @@ static inline void arch_idle(void)
 	cpu_do_idle();
 }
 
-extern void (*arch_reset)(char, const char *);
+static inline void arch_reset(char mode, const char *cmd)
+{
+}
 
 #endif
-- 
1.7.4.4
