From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 4/9] OMAP2 SDRC: add SDRAM timing parameter infrastructure
Date: Mon, 07 Jul 2008 20:54:47 -0600
Message-ID: <20080708025445.11646.98112.stgit@localhost.localdomain>
References: <20080708025225.11646.55912.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:40858 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755808AbYGHC4h (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Jul 2008 22:56:37 -0400
In-Reply-To: <20080708025225.11646.55912.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

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

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---

 arch/arm/mach-omap2/board-2430sdp.c     |    2 +-
 arch/arm/mach-omap2/board-3430sdp.c     |    2 +-
 arch/arm/mach-omap2/board-apollon.c     |    2 +-
 arch/arm/mach-omap2/board-generic.c     |    2 +-
 arch/arm/mach-omap2/board-h4.c          |    2 +-
 arch/arm/mach-omap2/board-ldp.c         |    2 +-
 arch/arm/mach-omap2/board-n800.c        |    2 +-
 arch/arm/mach-omap2/board-omap2evm.c    |    2 +-
 arch/arm/mach-omap2/board-omap3beagle.c |    2 +-
 arch/arm/mach-omap2/board-omap3evm.c    |    2 +-
 arch/arm/mach-omap2/io.c                |    4 ++-
 arch/arm/mach-omap2/sdrc.c              |   38 ++++++++++++++++++++++++++++++-
 include/asm-arm/arch-omap/io.h          |    4 ++-
 include/asm-arm/arch-omap/sdrc.h        |   22 ++++++++++++++++++
 14 files changed, 74 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index 780913e..b2f8b9c 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -347,7 +347,7 @@ out:
 
 static void __init omap_2430sdp_init_irq(void)
 {
-	omap2_init_common_hw();
+	omap2_init_common_hw(NULL);
 	omap_init_irq();
 	omap_gpio_init();
 	sdp2430_init_smc91x();
diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 7a216cc..137486b 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -248,7 +248,7 @@ static inline void __init sdp3430_init_smc91x(void)
 
 static void __init omap_3430sdp_init_irq(void)
 {
-	omap2_init_common_hw();
+	omap2_init_common_hw(NULL);
 	omap_init_irq();
 	omap_gpio_init();
 	sdp3430_init_smc91x();
diff --git a/arch/arm/mach-omap2/board-apollon.c b/arch/arm/mach-omap2/board-apollon.c
index a06654a..41542a0 100644
--- a/arch/arm/mach-omap2/board-apollon.c
+++ b/arch/arm/mach-omap2/board-apollon.c
@@ -323,7 +323,7 @@ out:
 
 static void __init omap_apollon_init_irq(void)
 {
-	omap2_init_common_hw();
+	omap2_init_common_hw(NULL);
 	omap_init_irq();
 	omap_gpio_init();
 	apollon_init_smc91x();
diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index 6e7b132..4df4e7b 100644
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
index 101b455..c5a353a 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -376,7 +376,7 @@ static void __init h4_init_flash(void)
 
 static void __init omap_h4_init_irq(void)
 {
-	omap2_init_common_hw();
+	omap2_init_common_hw(NULL);
 	omap_init_irq();
 	omap_gpio_init();
 	h4_init_flash();
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index 2ac4c9b..1998d62 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -191,7 +191,7 @@ static struct platform_device *ldp_devices[] __initdata = {
 
 static void __init omap_ldp_init_irq(void)
 {
-	omap2_init_common_hw();
+	omap2_init_common_hw(NULL);
 	omap_init_irq();
 	omap_gpio_init();
 }
diff --git a/arch/arm/mach-omap2/board-n800.c b/arch/arm/mach-omap2/board-n800.c
index ae85c2c..d4cc47a 100644
--- a/arch/arm/mach-omap2/board-n800.c
+++ b/arch/arm/mach-omap2/board-n800.c
@@ -122,7 +122,7 @@ static struct lm8323_platform_data lm8323_pdata = {
 
 void __init nokia_n800_init_irq(void)
 {
-	omap2_init_common_hw();
+	omap2_init_common_hw(NULL);
 	omap_init_irq();
 	omap_gpio_init();
 
diff --git a/arch/arm/mach-omap2/board-omap2evm.c b/arch/arm/mach-omap2/board-omap2evm.c
index bcdf4a6..0baf704 100644
--- a/arch/arm/mach-omap2/board-omap2evm.c
+++ b/arch/arm/mach-omap2/board-omap2evm.c
@@ -64,7 +64,7 @@ static inline void __init omap2evm_init_smc911x(void)
 
 static void __init omap2_evm_init_irq(void)
 {
-	omap2_init_common_hw();
+	omap2_init_common_hw(NULL);
 	omap_init_irq();
 	omap_gpio_init();
 	omap2evm_init_smc911x();
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index fdce787..3523611 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -47,7 +47,7 @@ static int __init omap3_beagle_i2c_init(void)
 
 static void __init omap3_beagle_init_irq(void)
 {
-	omap2_init_common_hw();
+	omap2_init_common_hw(NULL);
 	omap_init_irq();
 	omap_gpio_init();
 }
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 0061512..1ba8a45 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -188,7 +188,7 @@ static struct platform_device omap3evm_kp_device = {
 
 static void __init omap3_evm_init_irq(void)
 {
-	omap2_init_common_hw();
+	omap2_init_common_hw(NULL);
 	omap_init_irq();
 	omap_gpio_init();
 	omap3evm_init_smc911x();
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index e3dcff9..e0191aa 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -194,12 +194,12 @@ void __init omap2_map_common_io(void)
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
index 0f17716..7c2e36c 100644
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
 #include <asm/arch/sdrc.h>
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
diff --git a/include/asm-arm/arch-omap/io.h b/include/asm-arm/arch-omap/io.h
index 0b13557..1a14b4c 100644
--- a/include/asm-arm/arch-omap/io.h
+++ b/include/asm-arm/arch-omap/io.h
@@ -186,11 +186,13 @@
 #define omap_writew(v,a)	(*(volatile unsigned short *)IO_ADDRESS(a) = (v))
 #define omap_writel(v,a)	(*(volatile unsigned int   *)IO_ADDRESS(a) = (v))
 
+struct omap_sdrc_params;
+
 extern void omap1_map_common_io(void);
 extern void omap1_init_common_hw(void);
 
 extern void omap2_map_common_io(void);
-extern void omap2_init_common_hw(void);
+extern void omap2_init_common_hw(struct omap_sdrc_params *sp);
 
 #endif
 
diff --git a/include/asm-arm/arch-omap/sdrc.h b/include/asm-arm/arch-omap/sdrc.h
index c75caf5..00ba539 100644
--- a/include/asm-arm/arch-omap/sdrc.h
+++ b/include/asm-arm/arch-omap/sdrc.h
@@ -81,7 +81,29 @@
 
 #ifndef __ASSEMBLER__
 
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
 void __init omap2_sdrc_init(void);
+struct omap_sdrc_params *omap2_sdrc_get_params(unsigned long r);
 
 #ifdef CONFIG_ARCH_OMAP2
 


