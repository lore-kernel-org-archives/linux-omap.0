From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 68/86] [ARM] OMAP2 SDRC: add SDRAM timing parameter infrastructure
Date: Thu, 12 Mar 2009 11:28:18 -0700
Message-ID: <1236882516-29403-69-git-send-email-khilman@deeprootsystems.com>
References: <1236882516-29403-1-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-2-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-3-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-4-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-5-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-6-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-7-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-8-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-9-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-10-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-11-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-12-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-13-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-14-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-15-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-16-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-17-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-18-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-19-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-20-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-21-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-22-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-23-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-24-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-25-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-26-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-27-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-28-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-29-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-30-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-31-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-32-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-33-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-34-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-35-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-36-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-37-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-38-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-39-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-40-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-41-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-42-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-43-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-44-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-45-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-46-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-47-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-48-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-49-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-50-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-51-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-52-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-53-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-54-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-55-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-56-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-57-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-58-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-59-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-60-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-61-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-62-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-63-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-64-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-65-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-66-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-67-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-68-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f163.google.com ([209.85.217.163]:60567 "EHLO
	mail-gx0-f163.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757176AbZCLSdh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Mar 2009 14:33:37 -0400
Received: by mail-gx0-f163.google.com with SMTP id 7so458514gxk.13
        for <linux-omap@vger.kernel.org>; Thu, 12 Mar 2009 11:33:36 -0700 (PDT)
In-Reply-To: <1236882516-29403-68-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Paul Walmsley <paul@pwsan.com>

For a given SDRAM clock rate, SDRAM chips require memory controllers
to use a specific set of timing minimums and maximums to transfer data
reliably.  These parameters can be different for different memory chips
and can also potentially vary by board.

This patch adds the infrastructure for board-*.c files to pass this
timing data to the SDRAM controller init function.  The timing data is
specified in an 'omap_sdrc_params' structure, in terms of SDRC
controller register values.  An array of these structs, one per SDRC
target clock rate, is passed by the board-*.c file to
omap2_init_common_hw().

This patch does not define the values for different memory chips, nor
does it use the values for anything; those will come in subsequent patches.

linux-omap source commit is bc84ecfc795c2d1c5cda8da4127cf972f488a696.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap2/board-2430sdp.c     |    2 +-
 arch/arm/mach-omap2/board-apollon.c     |    2 +-
 arch/arm/mach-omap2/board-generic.c     |    2 +-
 arch/arm/mach-omap2/board-h4.c          |    2 +-
 arch/arm/mach-omap2/board-ldp.c         |    2 +-
 arch/arm/mach-omap2/board-omap3beagle.c |    2 +-
 arch/arm/mach-omap2/io.c                |    4 +-
 arch/arm/mach-omap2/sdrc.c              |   38 ++++++++++++++++++++++++++++++-
 arch/arm/plat-omap/include/mach/io.h    |    4 ++-
 arch/arm/plat-omap/include/mach/sdrc.h  |   24 ++++++++++++++++++-
 10 files changed, 71 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index 83fa372..7b29e1d 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -185,7 +185,7 @@ out:
 
 static void __init omap_2430sdp_init_irq(void)
 {
-	omap2_init_common_hw();
+	omap2_init_common_hw(NULL);
 	omap_init_irq();
 	omap_gpio_init();
 	sdp2430_init_smc91x();
diff --git a/arch/arm/mach-omap2/board-apollon.c b/arch/arm/mach-omap2/board-apollon.c
index 0a7b24b..0c911f4 100644
--- a/arch/arm/mach-omap2/board-apollon.c
+++ b/arch/arm/mach-omap2/board-apollon.c
@@ -249,7 +249,7 @@ out:
 
 static void __init omap_apollon_init_irq(void)
 {
-	omap2_init_common_hw();
+	omap2_init_common_hw(NULL);
 	omap_init_irq();
 	omap_gpio_init();
 	apollon_init_smc91x();
diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index 3b34c20..3492162 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -33,7 +33,7 @@
 
 static void __init omap_generic_init_irq(void)
 {
-	omap2_init_common_hw();
+	omap2_init_common_hw(NULL);
 	omap_init_irq();
 }
 
diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
index 5e9b146..ef55b45 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -363,7 +363,7 @@ static void __init h4_init_flash(void)
 
 static void __init omap_h4_init_irq(void)
 {
-	omap2_init_common_hw();
+	omap2_init_common_hw(NULL);
 	omap_init_irq();
 	omap_gpio_init();
 	h4_init_flash();
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index f6a1345..61f7c36 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -98,7 +98,7 @@ static inline void __init ldp_init_smc911x(void)
 
 static void __init omap_ldp_init_irq(void)
 {
-	omap2_init_common_hw();
+	omap2_init_common_hw(NULL);
 	omap_init_irq();
 	omap_gpio_init();
 	ldp_init_smc911x();
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 38c88fb..ad312cc 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -184,7 +184,7 @@ static int __init omap3_beagle_i2c_init(void)
 
 static void __init omap3_beagle_init_irq(void)
 {
-	omap2_init_common_hw();
+	omap2_init_common_hw(NULL);
 	omap_init_irq();
 	omap_gpio_init();
 }
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 3c1de36..916fcd3 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -195,12 +195,12 @@ void __init omap2_map_common_io(void)
 	omapfb_reserve_sdram();
 }
 
-void __init omap2_init_common_hw(void)
+void __init omap2_init_common_hw(struct omap_sdrc_params *sp)
 {
 	omap2_mux_init();
 	pwrdm_init(powerdomains_omap);
 	clkdm_init(clockdomains_omap, clkdm_pwrdm_autodeps);
 	omap2_clk_init();
-	omap2_sdrc_init();
+	omap2_sdrc_init(sp);
 	gpmc_init();
 }
diff --git a/arch/arm/mach-omap2/sdrc.c b/arch/arm/mach-omap2/sdrc.c
index 24b54d5..2a30060 100644
--- a/arch/arm/mach-omap2/sdrc.c
+++ b/arch/arm/mach-omap2/sdrc.c
@@ -12,6 +12,7 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
+#undef DEBUG
 
 #include <linux/module.h>
 #include <linux/kernel.h>
@@ -31,9 +32,42 @@
 #include <mach/sdrc.h>
 #include "sdrc.h"
 
+static struct omap_sdrc_params *sdrc_init_params;
+
 void __iomem *omap2_sdrc_base;
 void __iomem *omap2_sms_base;
 
+
+/**
+ * omap2_sdrc_get_params - return SDRC register values for a given clock rate
+ * @r: SDRC clock rate (in Hz)
+ *
+ * Return pre-calculated values for the SDRC_ACTIM_CTRLA,
+ * SDRC_ACTIM_CTRLB, SDRC_RFR_CTRL, and SDRC_MR registers, for a given
+ * SDRC clock rate 'r'.  These parameters control various timing
+ * delays in the SDRAM controller that are expressed in terms of the
+ * number of SDRC clock cycles to wait; hence the clock rate
+ * dependency. Note that sdrc_init_params must be sorted rate
+ * descending.  Also assumes that both chip-selects use the same
+ * timing parameters.  Returns a struct omap_sdrc_params * upon
+ * success, or NULL upon failure.
+ */
+struct omap_sdrc_params *omap2_sdrc_get_params(unsigned long r)
+{
+	struct omap_sdrc_params *sp;
+
+	sp = sdrc_init_params;
+
+	while (sp->rate != r)
+		sp++;
+
+	if (!sp->rate)
+		return NULL;
+
+	return sp;
+}
+
+
 void __init omap2_set_globals_sdrc(struct omap_globals *omap2_globals)
 {
 	omap2_sdrc_base = omap2_globals->sdrc;
@@ -41,7 +75,7 @@ void __init omap2_set_globals_sdrc(struct omap_globals *omap2_globals)
 }
 
 /* turn on smart idle modes for SDRAM scheduler and controller */
-void __init omap2_sdrc_init(void)
+void __init omap2_sdrc_init(struct omap_sdrc_params *sp)
 {
 	u32 l;
 
@@ -54,4 +88,6 @@ void __init omap2_sdrc_init(void)
 	l &= ~(0x3 << 3);
 	l |= (0x2 << 3);
 	sdrc_write_reg(l, SDRC_SYSCONFIG);
+
+	sdrc_init_params = sp;
 }
diff --git a/arch/arm/plat-omap/include/mach/io.h b/arch/arm/plat-omap/include/mach/io.h
index d92bf79..0610d7e 100644
--- a/arch/arm/plat-omap/include/mach/io.h
+++ b/arch/arm/plat-omap/include/mach/io.h
@@ -185,11 +185,13 @@
 #define omap_writew(v,a)	__raw_writew(v, IO_ADDRESS(a))
 #define omap_writel(v,a)	__raw_writel(v, IO_ADDRESS(a))
 
+struct omap_sdrc_params;
+
 extern void omap1_map_common_io(void);
 extern void omap1_init_common_hw(void);
 
 extern void omap2_map_common_io(void);
-extern void omap2_init_common_hw(void);
+extern void omap2_init_common_hw(struct omap_sdrc_params *sp);
 
 #define __arch_ioremap(p,s,t)	omap_ioremap(p,s,t)
 #define __arch_iounmap(v)	omap_iounmap(v)
diff --git a/arch/arm/plat-omap/include/mach/sdrc.h b/arch/arm/plat-omap/include/mach/sdrc.h
index 8e0740e..adc7352 100644
--- a/arch/arm/plat-omap/include/mach/sdrc.h
+++ b/arch/arm/plat-omap/include/mach/sdrc.h
@@ -81,7 +81,29 @@
 
 #ifndef __ASSEMBLER__
 
-void __init omap2_sdrc_init(void);
+/**
+ * struct omap_sdrc_params - SDRC parameters for a given SDRC clock rate
+ * @rate: SDRC clock rate (in Hz)
+ * @actim_ctrla: Value to program to SDRC_ACTIM_CTRLA for this rate
+ * @actim_ctrlb: Value to program to SDRC_ACTIM_CTRLB for this rate
+ * @rfr_ctrl: Value to program to SDRC_RFR_CTRL for this rate
+ * @mr: Value to program to SDRC_MR for this rate
+ *
+ * This structure holds a pre-computed set of register values for the
+ * SDRC for a given SDRC clock rate and SDRAM chip.  These are
+ * intended to be pre-computed and specified in an array in the board-*.c
+ * files.  The structure is keyed off the 'rate' field.
+ */
+struct omap_sdrc_params {
+	unsigned long rate;
+	u32 actim_ctrla;
+	u32 actim_ctrlb;
+	u32 rfr_ctrl;
+	u32 mr;
+};
+
+void __init omap2_sdrc_init(struct omap_sdrc_params *sp);
+struct omap_sdrc_params *omap2_sdrc_get_params(unsigned long r);
 
 #ifdef CONFIG_ARCH_OMAP2
 
-- 
1.6.1.2

