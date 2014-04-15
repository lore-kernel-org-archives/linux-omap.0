From: Taras Kondratiuk <taras.kondratiuk@linaro.org>
Subject: [RESEND PATCH 1/4] ARM: OMAP2+: raw read and write endian fix
Date: Tue, 15 Apr 2014 20:37:46 +0300
Message-ID: <1397583469-14457-2-git-send-email-taras.kondratiuk@linaro.org>
References: <1397583469-14457-1-git-send-email-taras.kondratiuk@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ee0-f49.google.com ([74.125.83.49]:54686 "EHLO
	mail-ee0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751054AbaDORiD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Apr 2014 13:38:03 -0400
Received: by mail-ee0-f49.google.com with SMTP id c41so7910787eek.8
        for <linux-omap@vger.kernel.org>; Tue, 15 Apr 2014 10:38:02 -0700 (PDT)
In-Reply-To: <1397583469-14457-1-git-send-email-taras.kondratiuk@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Victor Kamensky <victor.kamensky@linaro.org>, Taras Kondratiuk <taras.kondratiuk@linaro.org>

From: Victor Kamensky <victor.kamensky@linaro.org>

All OMAP IP blocks expect LE data, but CPU may operate in BE mode.
Need to use endian neutral functions to read/write h/w registers.
I.e instead of __raw_read[lw] and __raw_write[lw] functions code
need to use read[lw]_relaxed and write[lw]_relaxed functions.
If the first simply reads/writes register, the second will byteswap
it if host operates in BE mode.

Changes are trivial sed like replacement of __raw_xxx functions
with xxx_relaxed variant.

Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
Signed-off-by: Taras Kondratiuk <taras.kondratiuk@linaro.org>
---
 arch/arm/mach-omap2/board-flash.c         |    4 +--
 arch/arm/mach-omap2/clkt2xxx_dpllcore.c   |    2 +-
 arch/arm/mach-omap2/clkt2xxx_osc.c        |    8 +++---
 arch/arm/mach-omap2/clkt2xxx_sys.c        |    2 +-
 arch/arm/mach-omap2/cm2xxx_3xxx.h         |    4 +--
 arch/arm/mach-omap2/cm33xx.c              |    4 +--
 arch/arm/mach-omap2/cm3xxx.c              |    8 +++---
 arch/arm/mach-omap2/cm44xx.c              |    8 +++---
 arch/arm/mach-omap2/cminst44xx.c          |    4 +--
 arch/arm/mach-omap2/control.c             |   20 +++++++-------
 arch/arm/mach-omap2/dma.c                 |    4 +--
 arch/arm/mach-omap2/gpmc.c                |    8 +++---
 arch/arm/mach-omap2/id.c                  |    2 +-
 arch/arm/mach-omap2/irq.c                 |    4 +--
 arch/arm/mach-omap2/mux.c                 |    8 +++---
 arch/arm/mach-omap2/omap-hotplug.c        |    4 +--
 arch/arm/mach-omap2/omap-mpuss-lowpower.c |   18 ++++++-------
 arch/arm/mach-omap2/omap-smp.c            |    6 ++---
 arch/arm/mach-omap2/omap-wakeupgen.c      |   42 ++++++++++++++---------------
 arch/arm/mach-omap2/omap4-common.c        |   18 ++++++-------
 arch/arm/mach-omap2/omap_hwmod.c          |   10 +++----
 arch/arm/mach-omap2/omap_phy_internal.c   |    6 ++---
 arch/arm/mach-omap2/prcm_mpu44xx.c        |    4 +--
 arch/arm/mach-omap2/prm2xxx.h             |    2 +-
 arch/arm/mach-omap2/prm2xxx_3xxx.h        |    4 +--
 arch/arm/mach-omap2/prm33xx.c             |    4 +--
 arch/arm/mach-omap2/prm3xxx.h             |    2 +-
 arch/arm/mach-omap2/prm44xx.c             |    4 +--
 arch/arm/mach-omap2/prminst44xx.c         |    4 +--
 arch/arm/mach-omap2/sdrc.h                |    8 +++---
 arch/arm/mach-omap2/sdrc2xxx.c            |    4 +--
 arch/arm/mach-omap2/sr_device.c           |    2 +-
 arch/arm/mach-omap2/sram.c                |   16 +++++------
 arch/arm/mach-omap2/timer.c               |    8 +++---
 arch/arm/mach-omap2/vc.c                  |    4 +--
 arch/arm/mach-omap2/wd_timer.c            |    8 +++---
 36 files changed, 134 insertions(+), 134 deletions(-)

diff --git a/arch/arm/mach-omap2/board-flash.c b/arch/arm/mach-omap2/board-flash.c
index ac82512..84cc148 100644
--- a/arch/arm/mach-omap2/board-flash.c
+++ b/arch/arm/mach-omap2/board-flash.c
@@ -160,13 +160,13 @@ static u8 get_gpmc0_type(void)
 	if (!fpga_map_addr)
 		return -ENOMEM;
 
-	if (!(__raw_readw(fpga_map_addr + REG_FPGA_REV)))
+	if (!(readw_relaxed(fpga_map_addr + REG_FPGA_REV)))
 		/* we dont have an DEBUG FPGA??? */
 		/* Depend on #defines!! default to strata boot return param */
 		goto unmap;
 
 	/* S8-DIP-OFF = 1, S8-DIP-ON = 0 */
-	cs = __raw_readw(fpga_map_addr + REG_FPGA_DIP_SWITCH_INPUT2) & 0xf;
+	cs = readw_relaxed(fpga_map_addr + REG_FPGA_DIP_SWITCH_INPUT2) & 0xf;
 
 	/* ES2.0 SDP's onwards 4 dip switches are provided for CS */
 	if (omap_rev() >= OMAP3430_REV_ES1_0)
diff --git a/arch/arm/mach-omap2/clkt2xxx_dpllcore.c b/arch/arm/mach-omap2/clkt2xxx_dpllcore.c
index 3ff3254..59cf310 100644
--- a/arch/arm/mach-omap2/clkt2xxx_dpllcore.c
+++ b/arch/arm/mach-omap2/clkt2xxx_dpllcore.c
@@ -138,7 +138,7 @@ int omap2_reprogram_dpllcore(struct clk_hw *hw, unsigned long rate,
 		if (!dd)
 			return -EINVAL;
 
-		tmpset.cm_clksel1_pll = __raw_readl(dd->mult_div1_reg);
+		tmpset.cm_clksel1_pll = readl_relaxed(dd->mult_div1_reg);
 		tmpset.cm_clksel1_pll &= ~(dd->mult_mask |
 					   dd->div1_mask);
 		div = ((curr_prcm_set->xtal_speed / 1000000) - 1);
diff --git a/arch/arm/mach-omap2/clkt2xxx_osc.c b/arch/arm/mach-omap2/clkt2xxx_osc.c
index 19f54d4..0717dff 100644
--- a/arch/arm/mach-omap2/clkt2xxx_osc.c
+++ b/arch/arm/mach-omap2/clkt2xxx_osc.c
@@ -39,9 +39,9 @@ int omap2_enable_osc_ck(struct clk_hw *clk)
 {
 	u32 pcc;
 
-	pcc = __raw_readl(prcm_clksrc_ctrl);
+	pcc = readl_relaxed(prcm_clksrc_ctrl);
 
-	__raw_writel(pcc & ~OMAP_AUTOEXTCLKMODE_MASK, prcm_clksrc_ctrl);
+	writel_relaxed(pcc & ~OMAP_AUTOEXTCLKMODE_MASK, prcm_clksrc_ctrl);
 
 	return 0;
 }
@@ -57,9 +57,9 @@ void omap2_disable_osc_ck(struct clk_hw *clk)
 {
 	u32 pcc;
 
-	pcc = __raw_readl(prcm_clksrc_ctrl);
+	pcc = readl_relaxed(prcm_clksrc_ctrl);
 
-	__raw_writel(pcc | OMAP_AUTOEXTCLKMODE_MASK, prcm_clksrc_ctrl);
+	writel_relaxed(pcc | OMAP_AUTOEXTCLKMODE_MASK, prcm_clksrc_ctrl);
 }
 
 unsigned long omap2_osc_clk_recalc(struct clk_hw *clk,
diff --git a/arch/arm/mach-omap2/clkt2xxx_sys.c b/arch/arm/mach-omap2/clkt2xxx_sys.c
index f467d07..58dd3a9 100644
--- a/arch/arm/mach-omap2/clkt2xxx_sys.c
+++ b/arch/arm/mach-omap2/clkt2xxx_sys.c
@@ -33,7 +33,7 @@ u32 omap2xxx_get_sysclkdiv(void)
 {
 	u32 div;
 
-	div = __raw_readl(prcm_clksrc_ctrl);
+	div = readl_relaxed(prcm_clksrc_ctrl);
 	div &= OMAP_SYSCLKDIV_MASK;
 	div >>= OMAP_SYSCLKDIV_SHIFT;
 
diff --git a/arch/arm/mach-omap2/cm2xxx_3xxx.h b/arch/arm/mach-omap2/cm2xxx_3xxx.h
index bfbd16f..72928a3 100644
--- a/arch/arm/mach-omap2/cm2xxx_3xxx.h
+++ b/arch/arm/mach-omap2/cm2xxx_3xxx.h
@@ -52,12 +52,12 @@
 
 static inline u32 omap2_cm_read_mod_reg(s16 module, u16 idx)
 {
-	return __raw_readl(cm_base + module + idx);
+	return readl_relaxed(cm_base + module + idx);
 }
 
 static inline void omap2_cm_write_mod_reg(u32 val, s16 module, u16 idx)
 {
-	__raw_writel(val, cm_base + module + idx);
+	writel_relaxed(val, cm_base + module + idx);
 }
 
 /* Read-modify-write a register in a CM module. Caller must lock */
diff --git a/arch/arm/mach-omap2/cm33xx.c b/arch/arm/mach-omap2/cm33xx.c
index 40a22e5..b3f99e9 100644
--- a/arch/arm/mach-omap2/cm33xx.c
+++ b/arch/arm/mach-omap2/cm33xx.c
@@ -50,13 +50,13 @@
 /* Read a register in a CM instance */
 static inline u32 am33xx_cm_read_reg(u16 inst, u16 idx)
 {
-	return __raw_readl(cm_base + inst + idx);
+	return readl_relaxed(cm_base + inst + idx);
 }
 
 /* Write into a register in a CM */
 static inline void am33xx_cm_write_reg(u32 val, u16 inst, u16 idx)
 {
-	__raw_writel(val, cm_base + inst + idx);
+	writel_relaxed(val, cm_base + inst + idx);
 }
 
 /* Read-modify-write a register in CM */
diff --git a/arch/arm/mach-omap2/cm3xxx.c b/arch/arm/mach-omap2/cm3xxx.c
index f6f0288..9079f25 100644
--- a/arch/arm/mach-omap2/cm3xxx.c
+++ b/arch/arm/mach-omap2/cm3xxx.c
@@ -388,7 +388,7 @@ void omap3_cm_save_context(void)
 		omap2_cm_read_mod_reg(OMAP3430_IVA2_MOD, CM_CLKSEL1);
 	cm_context.iva2_cm_clksel2 =
 		omap2_cm_read_mod_reg(OMAP3430_IVA2_MOD, CM_CLKSEL2);
-	cm_context.cm_sysconfig = __raw_readl(OMAP3430_CM_SYSCONFIG);
+	cm_context.cm_sysconfig = readl_relaxed(OMAP3430_CM_SYSCONFIG);
 	cm_context.sgx_cm_clksel =
 		omap2_cm_read_mod_reg(OMAP3430ES2_SGX_MOD, CM_CLKSEL);
 	cm_context.dss_cm_clksel =
@@ -418,7 +418,7 @@ void omap3_cm_save_context(void)
 		omap2_cm_read_mod_reg(PLL_MOD, OMAP3430ES2_CM_CLKSEL5);
 	cm_context.pll_cm_clken2 =
 		omap2_cm_read_mod_reg(PLL_MOD, OMAP3430ES2_CM_CLKEN2);
-	cm_context.cm_polctrl = __raw_readl(OMAP3430_CM_POLCTRL);
+	cm_context.cm_polctrl = readl_relaxed(OMAP3430_CM_POLCTRL);
 	cm_context.iva2_cm_fclken =
 		omap2_cm_read_mod_reg(OMAP3430_IVA2_MOD, CM_FCLKEN);
 	cm_context.iva2_cm_clken_pll =
@@ -519,7 +519,7 @@ void omap3_cm_restore_context(void)
 			       CM_CLKSEL1);
 	omap2_cm_write_mod_reg(cm_context.iva2_cm_clksel2, OMAP3430_IVA2_MOD,
 			       CM_CLKSEL2);
-	__raw_writel(cm_context.cm_sysconfig, OMAP3430_CM_SYSCONFIG);
+	writel_relaxed(cm_context.cm_sysconfig, OMAP3430_CM_SYSCONFIG);
 	omap2_cm_write_mod_reg(cm_context.sgx_cm_clksel, OMAP3430ES2_SGX_MOD,
 			       CM_CLKSEL);
 	omap2_cm_write_mod_reg(cm_context.dss_cm_clksel, OMAP3430_DSS_MOD,
@@ -547,7 +547,7 @@ void omap3_cm_restore_context(void)
 			       OMAP3430ES2_CM_CLKSEL5);
 	omap2_cm_write_mod_reg(cm_context.pll_cm_clken2, PLL_MOD,
 			       OMAP3430ES2_CM_CLKEN2);
-	__raw_writel(cm_context.cm_polctrl, OMAP3430_CM_POLCTRL);
+	writel_relaxed(cm_context.cm_polctrl, OMAP3430_CM_POLCTRL);
 	omap2_cm_write_mod_reg(cm_context.iva2_cm_fclken, OMAP3430_IVA2_MOD,
 			       CM_FCLKEN);
 	omap2_cm_write_mod_reg(cm_context.iva2_cm_clken_pll, OMAP3430_IVA2_MOD,
diff --git a/arch/arm/mach-omap2/cm44xx.c b/arch/arm/mach-omap2/cm44xx.c
index 535d66e..30b6d97 100644
--- a/arch/arm/mach-omap2/cm44xx.c
+++ b/arch/arm/mach-omap2/cm44xx.c
@@ -30,23 +30,23 @@
 /* Read a register in CM1 */
 u32 omap4_cm1_read_inst_reg(s16 inst, u16 reg)
 {
-	return __raw_readl(OMAP44XX_CM1_REGADDR(inst, reg));
+	return readl_relaxed(OMAP44XX_CM1_REGADDR(inst, reg));
 }
 
 /* Write into a register in CM1 */
 void omap4_cm1_write_inst_reg(u32 val, s16 inst, u16 reg)
 {
-	__raw_writel(val, OMAP44XX_CM1_REGADDR(inst, reg));
+	writel_relaxed(val, OMAP44XX_CM1_REGADDR(inst, reg));
 }
 
 /* Read a register in CM2 */
 u32 omap4_cm2_read_inst_reg(s16 inst, u16 reg)
 {
-	return __raw_readl(OMAP44XX_CM2_REGADDR(inst, reg));
+	return readl_relaxed(OMAP44XX_CM2_REGADDR(inst, reg));
 }
 
 /* Write into a register in CM2 */
 void omap4_cm2_write_inst_reg(u32 val, s16 inst, u16 reg)
 {
-	__raw_writel(val, OMAP44XX_CM2_REGADDR(inst, reg));
+	writel_relaxed(val, OMAP44XX_CM2_REGADDR(inst, reg));
 }
diff --git a/arch/arm/mach-omap2/cminst44xx.c b/arch/arm/mach-omap2/cminst44xx.c
index f5c4731..2f44257 100644
--- a/arch/arm/mach-omap2/cminst44xx.c
+++ b/arch/arm/mach-omap2/cminst44xx.c
@@ -116,7 +116,7 @@ u32 omap4_cminst_read_inst_reg(u8 part, u16 inst, u16 idx)
 	BUG_ON(part >= OMAP4_MAX_PRCM_PARTITIONS ||
 	       part == OMAP4430_INVALID_PRCM_PARTITION ||
 	       !_cm_bases[part]);
-	return __raw_readl(_cm_bases[part] + inst + idx);
+	return readl_relaxed(_cm_bases[part] + inst + idx);
 }
 
 /* Write into a register in a CM instance */
@@ -125,7 +125,7 @@ void omap4_cminst_write_inst_reg(u32 val, u8 part, u16 inst, u16 idx)
 	BUG_ON(part >= OMAP4_MAX_PRCM_PARTITIONS ||
 	       part == OMAP4430_INVALID_PRCM_PARTITION ||
 	       !_cm_bases[part]);
-	__raw_writel(val, _cm_bases[part] + inst + idx);
+	writel_relaxed(val, _cm_bases[part] + inst + idx);
 }
 
 /* Read-modify-write a register in CM1. Caller must lock */
diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index 44bb4d5..751f354 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -151,32 +151,32 @@ void __iomem *omap_ctrl_base_get(void)
 
 u8 omap_ctrl_readb(u16 offset)
 {
-	return __raw_readb(OMAP_CTRL_REGADDR(offset));
+	return readb_relaxed(OMAP_CTRL_REGADDR(offset));
 }
 
 u16 omap_ctrl_readw(u16 offset)
 {
-	return __raw_readw(OMAP_CTRL_REGADDR(offset));
+	return readw_relaxed(OMAP_CTRL_REGADDR(offset));
 }
 
 u32 omap_ctrl_readl(u16 offset)
 {
-	return __raw_readl(OMAP_CTRL_REGADDR(offset));
+	return readl_relaxed(OMAP_CTRL_REGADDR(offset));
 }
 
 void omap_ctrl_writeb(u8 val, u16 offset)
 {
-	__raw_writeb(val, OMAP_CTRL_REGADDR(offset));
+	writeb_relaxed(val, OMAP_CTRL_REGADDR(offset));
 }
 
 void omap_ctrl_writew(u16 val, u16 offset)
 {
-	__raw_writew(val, OMAP_CTRL_REGADDR(offset));
+	writew_relaxed(val, OMAP_CTRL_REGADDR(offset));
 }
 
 void omap_ctrl_writel(u32 val, u16 offset)
 {
-	__raw_writel(val, OMAP_CTRL_REGADDR(offset));
+	writel_relaxed(val, OMAP_CTRL_REGADDR(offset));
 }
 
 /*
@@ -188,12 +188,12 @@ void omap_ctrl_writel(u32 val, u16 offset)
 
 u32 omap4_ctrl_pad_readl(u16 offset)
 {
-	return __raw_readl(OMAP4_CTRL_PAD_REGADDR(offset));
+	return readl_relaxed(OMAP4_CTRL_PAD_REGADDR(offset));
 }
 
 void omap4_ctrl_pad_writel(u32 val, u16 offset)
 {
-	__raw_writel(val, OMAP4_CTRL_PAD_REGADDR(offset));
+	writel_relaxed(val, OMAP4_CTRL_PAD_REGADDR(offset));
 }
 
 #ifdef CONFIG_ARCH_OMAP3
@@ -222,7 +222,7 @@ void omap3_ctrl_write_boot_mode(u8 bootmode)
 	 *
 	 * XXX This should use some omap_ctrl_writel()-type function
 	 */
-	__raw_writel(l, OMAP2_L4_IO_ADDRESS(OMAP343X_SCRATCHPAD + 4));
+	writel_relaxed(l, OMAP2_L4_IO_ADDRESS(OMAP343X_SCRATCHPAD + 4));
 }
 
 #endif
@@ -285,7 +285,7 @@ void omap3_clear_scratchpad_contents(void)
 	if (omap2_prm_read_mod_reg(OMAP3430_GR_MOD, OMAP3_PRM_RSTST_OFFSET) &
 	    OMAP3430_GLOBAL_COLD_RST_MASK) {
 		for ( ; offset <= max_offset; offset += 0x4)
-			__raw_writel(0x0, (v_addr + offset));
+			writel_relaxed(0x0, (v_addr + offset));
 		omap2_prm_set_mod_reg_bits(OMAP3430_GLOBAL_COLD_RST_MASK,
 					   OMAP3430_GR_MOD,
 					   OMAP3_PRM_RSTST_OFFSET);
diff --git a/arch/arm/mach-omap2/dma.c b/arch/arm/mach-omap2/dma.c
index 5689c88..a6d2cf1 100644
--- a/arch/arm/mach-omap2/dma.c
+++ b/arch/arm/mach-omap2/dma.c
@@ -91,7 +91,7 @@ static inline void dma_write(u32 val, int reg, int lch)
 	addr += reg_map[reg].offset;
 	addr += reg_map[reg].stride * lch;
 
-	__raw_writel(val, addr);
+	writel_relaxed(val, addr);
 }
 
 static inline u32 dma_read(int reg, int lch)
@@ -101,7 +101,7 @@ static inline u32 dma_read(int reg, int lch)
 	addr += reg_map[reg].offset;
 	addr += reg_map[reg].stride * lch;
 
-	return __raw_readl(addr);
+	return readl_relaxed(addr);
 }
 
 static void omap2_clear_dma(int lch)
diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index ab43755..c99a6d7 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -170,12 +170,12 @@ static irqreturn_t gpmc_handle_irq(int irq, void *dev);
 
 static void gpmc_write_reg(int idx, u32 val)
 {
-	__raw_writel(val, gpmc_base + idx);
+	writel_relaxed(val, gpmc_base + idx);
 }
 
 static u32 gpmc_read_reg(int idx)
 {
-	return __raw_readl(gpmc_base + idx);
+	return readl_relaxed(gpmc_base + idx);
 }
 
 void gpmc_cs_write_reg(int cs, int idx, u32 val)
@@ -183,7 +183,7 @@ void gpmc_cs_write_reg(int cs, int idx, u32 val)
 	void __iomem *reg_addr;
 
 	reg_addr = gpmc_base + GPMC_CS0_OFFSET + (cs * GPMC_CS_SIZE) + idx;
-	__raw_writel(val, reg_addr);
+	writel_relaxed(val, reg_addr);
 }
 
 static u32 gpmc_cs_read_reg(int cs, int idx)
@@ -191,7 +191,7 @@ static u32 gpmc_cs_read_reg(int cs, int idx)
 	void __iomem *reg_addr;
 
 	reg_addr = gpmc_base + GPMC_CS0_OFFSET + (cs * GPMC_CS_SIZE) + idx;
-	return __raw_readl(reg_addr);
+	return readl_relaxed(reg_addr);
 }
 
 /* TODO: Add support for gpmc_fck to clock framework and use it */
diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 157412e..f61f1bf 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -94,7 +94,7 @@ EXPORT_SYMBOL(omap_type);
 #define OMAP_TAP_DIE_ID_44XX_2	0x020c
 #define OMAP_TAP_DIE_ID_44XX_3	0x0210
 
-#define read_tap_reg(reg)	__raw_readl(tap_base  + (reg))
+#define read_tap_reg(reg)	readl_relaxed(tap_base  + (reg))
 
 struct omap_id {
 	u16	hawkeye;	/* Silicon type (Hawkeye id) */
diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index 6037a9a..35b8590 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -83,12 +83,12 @@ struct omap3_intc_regs {
 
 static void intc_bank_write_reg(u32 val, struct omap_irq_bank *bank, u16 reg)
 {
-	__raw_writel(val, bank->base_reg + reg);
+	writel_relaxed(val, bank->base_reg + reg);
 }
 
 static u32 intc_bank_read_reg(struct omap_irq_bank *bank, u16 reg)
 {
-	return __raw_readl(bank->base_reg + reg);
+	return readl_relaxed(bank->base_reg + reg);
 }
 
 /* XXX: FIQ and additional INTC support (only MPU at the moment) */
diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index 48094b5..fd88ede 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -70,18 +70,18 @@ struct omap_mux_partition *omap_mux_get(const char *name)
 u16 omap_mux_read(struct omap_mux_partition *partition, u16 reg)
 {
 	if (partition->flags & OMAP_MUX_REG_8BIT)
-		return __raw_readb(partition->base + reg);
+		return readb_relaxed(partition->base + reg);
 	else
-		return __raw_readw(partition->base + reg);
+		return readw_relaxed(partition->base + reg);
 }
 
 void omap_mux_write(struct omap_mux_partition *partition, u16 val,
 			   u16 reg)
 {
 	if (partition->flags & OMAP_MUX_REG_8BIT)
-		__raw_writeb(val, partition->base + reg);
+		writeb_relaxed(val, partition->base + reg);
 	else
-		__raw_writew(val, partition->base + reg);
+		writew_relaxed(val, partition->base + reg);
 }
 
 void omap_mux_write_array(struct omap_mux_partition *partition,
diff --git a/arch/arm/mach-omap2/omap-hotplug.c b/arch/arm/mach-omap2/omap-hotplug.c
index 458f72f..971791f 100644
--- a/arch/arm/mach-omap2/omap-hotplug.c
+++ b/arch/arm/mach-omap2/omap-hotplug.c
@@ -39,7 +39,7 @@ void __ref omap4_cpu_die(unsigned int cpu)
 		if (omap_modify_auxcoreboot0(0x0, 0x200) != 0x0)
 			pr_err("Secure clear status failed\n");
 	} else {
-		__raw_writel(0, base + OMAP_AUX_CORE_BOOT_0);
+		writel_relaxed(0, base + OMAP_AUX_CORE_BOOT_0);
 	}
 
 
@@ -53,7 +53,7 @@ void __ref omap4_cpu_die(unsigned int cpu)
 			boot_cpu = omap_read_auxcoreboot0();
 		else
 			boot_cpu =
-				__raw_readl(base + OMAP_AUX_CORE_BOOT_0) >> 5;
+				readl_relaxed(base + OMAP_AUX_CORE_BOOT_0) >> 5;
 
 		if (boot_cpu == smp_processor_id()) {
 			/*
diff --git a/arch/arm/mach-omap2/omap-mpuss-lowpower.c b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
index 667915d..eb76e47 100644
--- a/arch/arm/mach-omap2/omap-mpuss-lowpower.c
+++ b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
@@ -116,7 +116,7 @@ static inline void set_cpu_wakeup_addr(unsigned int cpu_id, u32 addr)
 {
 	struct omap4_cpu_pm_info *pm_info = &per_cpu(omap4_pm_info, cpu_id);
 
-	__raw_writel(addr, pm_info->wkup_sar_addr);
+	writel_relaxed(addr, pm_info->wkup_sar_addr);
 }
 
 /*
@@ -141,7 +141,7 @@ static void scu_pwrst_prepare(unsigned int cpu_id, unsigned int cpu_state)
 		break;
 	}
 
-	__raw_writel(scu_pwr_st, pm_info->scu_sar_addr);
+	writel_relaxed(scu_pwr_st, pm_info->scu_sar_addr);
 }
 
 /* Helper functions for MPUSS OSWR */
@@ -179,7 +179,7 @@ static void l2x0_pwrst_prepare(unsigned int cpu_id, unsigned int save_state)
 {
 	struct omap4_cpu_pm_info *pm_info = &per_cpu(omap4_pm_info, cpu_id);
 
-	__raw_writel(save_state, pm_info->l2x0_sar_addr);
+	writel_relaxed(save_state, pm_info->l2x0_sar_addr);
 }
 
 /*
@@ -192,10 +192,10 @@ static void save_l2x0_context(void)
 	u32 val;
 	void __iomem *l2x0_base = omap4_get_l2cache_base();
 	if (l2x0_base) {
-		val = __raw_readl(l2x0_base + L2X0_AUX_CTRL);
-		__raw_writel(val, sar_base + L2X0_AUXCTRL_OFFSET);
-		val = __raw_readl(l2x0_base + L2X0_PREFETCH_CTRL);
-		__raw_writel(val, sar_base + L2X0_PREFETCH_CTRL_OFFSET);
+		val = readl_relaxed(l2x0_base + L2X0_AUX_CTRL);
+		writel_relaxed(val, sar_base + L2X0_AUXCTRL_OFFSET);
+		val = readl_relaxed(l2x0_base + L2X0_PREFETCH_CTRL);
+		writel_relaxed(val, sar_base + L2X0_PREFETCH_CTRL_OFFSET);
 	}
 }
 #else
@@ -386,9 +386,9 @@ int __init omap4_mpuss_init(void)
 
 	/* Save device type on scratchpad for low level code to use */
 	if (omap_type() != OMAP2_DEVICE_TYPE_GP)
-		__raw_writel(1, sar_base + OMAP_TYPE_OFFSET);
+		writel_relaxed(1, sar_base + OMAP_TYPE_OFFSET);
 	else
-		__raw_writel(0, sar_base + OMAP_TYPE_OFFSET);
+		writel_relaxed(0, sar_base + OMAP_TYPE_OFFSET);
 
 	save_l2x0_context();
 
diff --git a/arch/arm/mach-omap2/omap-smp.c b/arch/arm/mach-omap2/omap-smp.c
index 17550aa..256e84e 100644
--- a/arch/arm/mach-omap2/omap-smp.c
+++ b/arch/arm/mach-omap2/omap-smp.c
@@ -99,7 +99,7 @@ static int omap4_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	if (omap_secure_apis_support())
 		omap_modify_auxcoreboot0(0x200, 0xfffffdff);
 	else
-		__raw_writel(0x20, base + OMAP_AUX_CORE_BOOT_0);
+		writel_relaxed(0x20, base + OMAP_AUX_CORE_BOOT_0);
 
 	if (!cpu1_clkdm && !cpu1_pwrdm) {
 		cpu1_clkdm = clkdm_lookup("mpu1_clkdm");
@@ -227,8 +227,8 @@ static void __init omap4_smp_prepare_cpus(unsigned int max_cpus)
 	if (omap_secure_apis_support())
 		omap_auxcoreboot_addr(virt_to_phys(startup_addr));
 	else
-		__raw_writel(virt_to_phys(omap5_secondary_startup),
-						base + OMAP_AUX_CORE_BOOT_1);
+		writel_relaxed(virt_to_phys(omap5_secondary_startup),
+			       base + OMAP_AUX_CORE_BOOT_1);
 
 }
 
diff --git a/arch/arm/mach-omap2/omap-wakeupgen.c b/arch/arm/mach-omap2/omap-wakeupgen.c
index 693fe48..37843a7 100644
--- a/arch/arm/mach-omap2/omap-wakeupgen.c
+++ b/arch/arm/mach-omap2/omap-wakeupgen.c
@@ -60,19 +60,19 @@ static unsigned int omap_secure_apis;
  */
 static inline u32 wakeupgen_readl(u8 idx, u32 cpu)
 {
-	return __raw_readl(wakeupgen_base + OMAP_WKG_ENB_A_0 +
+	return readl_relaxed(wakeupgen_base + OMAP_WKG_ENB_A_0 +
 				(cpu * CPU_ENA_OFFSET) + (idx * 4));
 }
 
 static inline void wakeupgen_writel(u32 val, u8 idx, u32 cpu)
 {
-	__raw_writel(val, wakeupgen_base + OMAP_WKG_ENB_A_0 +
+	writel_relaxed(val, wakeupgen_base + OMAP_WKG_ENB_A_0 +
 				(cpu * CPU_ENA_OFFSET) + (idx * 4));
 }
 
 static inline void sar_writel(u32 val, u32 offset, u8 idx)
 {
-	__raw_writel(val, sar_base + offset + (idx * 4));
+	writel_relaxed(val, sar_base + offset + (idx * 4));
 }
 
 static inline int _wakeupgen_get_irq_info(u32 irq, u32 *bit_posn, u8 *reg_index)
@@ -231,21 +231,21 @@ static inline void omap4_irq_save_context(void)
 	}
 
 	/* Save AuxBoot* registers */
-	val = __raw_readl(wakeupgen_base + OMAP_AUX_CORE_BOOT_0);
-	__raw_writel(val, sar_base + AUXCOREBOOT0_OFFSET);
-	val = __raw_readl(wakeupgen_base + OMAP_AUX_CORE_BOOT_1);
-	__raw_writel(val, sar_base + AUXCOREBOOT1_OFFSET);
+	val = readl_relaxed(wakeupgen_base + OMAP_AUX_CORE_BOOT_0);
+	writel_relaxed(val, sar_base + AUXCOREBOOT0_OFFSET);
+	val = readl_relaxed(wakeupgen_base + OMAP_AUX_CORE_BOOT_1);
+	writel_relaxed(val, sar_base + AUXCOREBOOT1_OFFSET);
 
 	/* Save SyncReq generation logic */
-	val = __raw_readl(wakeupgen_base + OMAP_PTMSYNCREQ_MASK);
-	__raw_writel(val, sar_base + PTMSYNCREQ_MASK_OFFSET);
-	val = __raw_readl(wakeupgen_base + OMAP_PTMSYNCREQ_EN);
-	__raw_writel(val, sar_base + PTMSYNCREQ_EN_OFFSET);
+	val = readl_relaxed(wakeupgen_base + OMAP_PTMSYNCREQ_MASK);
+	writel_relaxed(val, sar_base + PTMSYNCREQ_MASK_OFFSET);
+	val = readl_relaxed(wakeupgen_base + OMAP_PTMSYNCREQ_EN);
+	writel_relaxed(val, sar_base + PTMSYNCREQ_EN_OFFSET);
 
 	/* Set the Backup Bit Mask status */
-	val = __raw_readl(sar_base + SAR_BACKUP_STATUS_OFFSET);
+	val = readl_relaxed(sar_base + SAR_BACKUP_STATUS_OFFSET);
 	val |= SAR_BACKUP_STATUS_WAKEUPGEN;
-	__raw_writel(val, sar_base + SAR_BACKUP_STATUS_OFFSET);
+	writel_relaxed(val, sar_base + SAR_BACKUP_STATUS_OFFSET);
 
 }
 
@@ -264,15 +264,15 @@ static inline void omap5_irq_save_context(void)
 	}
 
 	/* Save AuxBoot* registers */
-	val = __raw_readl(wakeupgen_base + OMAP_AUX_CORE_BOOT_0);
-	__raw_writel(val, sar_base + OMAP5_AUXCOREBOOT0_OFFSET);
-	val = __raw_readl(wakeupgen_base + OMAP_AUX_CORE_BOOT_0);
-	__raw_writel(val, sar_base + OMAP5_AUXCOREBOOT1_OFFSET);
+	val = readl_relaxed(wakeupgen_base + OMAP_AUX_CORE_BOOT_0);
+	writel_relaxed(val, sar_base + OMAP5_AUXCOREBOOT0_OFFSET);
+	val = readl_relaxed(wakeupgen_base + OMAP_AUX_CORE_BOOT_0);
+	writel_relaxed(val, sar_base + OMAP5_AUXCOREBOOT1_OFFSET);
 
 	/* Set the Backup Bit Mask status */
-	val = __raw_readl(sar_base + OMAP5_SAR_BACKUP_STATUS_OFFSET);
+	val = readl_relaxed(sar_base + OMAP5_SAR_BACKUP_STATUS_OFFSET);
 	val |= SAR_BACKUP_STATUS_WAKEUPGEN;
-	__raw_writel(val, sar_base + OMAP5_SAR_BACKUP_STATUS_OFFSET);
+	writel_relaxed(val, sar_base + OMAP5_SAR_BACKUP_STATUS_OFFSET);
 
 }
 
@@ -306,9 +306,9 @@ static void irq_sar_clear(void)
 	if (soc_is_omap54xx())
 		offset = OMAP5_SAR_BACKUP_STATUS_OFFSET;
 
-	val = __raw_readl(sar_base + offset);
+	val = readl_relaxed(sar_base + offset);
 	val &= ~SAR_BACKUP_STATUS_WAKEUPGEN;
-	__raw_writel(val, sar_base + offset);
+	writel_relaxed(val, sar_base + offset);
 }
 
 /*
diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
index 95e171a..99b0154 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -125,25 +125,25 @@ void __init gic_init_irq(void)
 void gic_dist_disable(void)
 {
 	if (gic_dist_base_addr)
-		__raw_writel(0x0, gic_dist_base_addr + GIC_DIST_CTRL);
+		writel_relaxed(0x0, gic_dist_base_addr + GIC_DIST_CTRL);
 }
 
 void gic_dist_enable(void)
 {
 	if (gic_dist_base_addr)
-		__raw_writel(0x1, gic_dist_base_addr + GIC_DIST_CTRL);
+		writel_relaxed(0x1, gic_dist_base_addr + GIC_DIST_CTRL);
 }
 
 bool gic_dist_disabled(void)
 {
-	return !(__raw_readl(gic_dist_base_addr + GIC_DIST_CTRL) & 0x1);
+	return !(readl_relaxed(gic_dist_base_addr + GIC_DIST_CTRL) & 0x1);
 }
 
 void gic_timer_retrigger(void)
 {
-	u32 twd_int = __raw_readl(twd_base + TWD_TIMER_INTSTAT);
-	u32 gic_int = __raw_readl(gic_dist_base_addr + GIC_DIST_PENDING_SET);
-	u32 twd_ctrl = __raw_readl(twd_base + TWD_TIMER_CONTROL);
+	u32 twd_int = readl_relaxed(twd_base + TWD_TIMER_INTSTAT);
+	u32 gic_int = readl_relaxed(gic_dist_base_addr + GIC_DIST_PENDING_SET);
+	u32 twd_ctrl = readl_relaxed(twd_base + TWD_TIMER_CONTROL);
 
 	if (twd_int && !(gic_int & BIT(IRQ_LOCALTIMER))) {
 		/*
@@ -151,11 +151,11 @@ void gic_timer_retrigger(void)
 		 * disabled.  Ack the pending interrupt, and retrigger it.
 		 */
 		pr_warn("%s: lost localtimer interrupt\n", __func__);
-		__raw_writel(1, twd_base + TWD_TIMER_INTSTAT);
+		writel_relaxed(1, twd_base + TWD_TIMER_INTSTAT);
 		if (!(twd_ctrl & TWD_TIMER_CONTROL_PERIODIC)) {
-			__raw_writel(1, twd_base + TWD_TIMER_COUNTER);
+			writel_relaxed(1, twd_base + TWD_TIMER_COUNTER);
 			twd_ctrl |= TWD_TIMER_CONTROL_ENABLE;
-			__raw_writel(twd_ctrl, twd_base + TWD_TIMER_CONTROL);
+			writel_relaxed(twd_ctrl, twd_base + TWD_TIMER_CONTROL);
 		}
 	}
 }
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 1f33f5d..262ba8c 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -72,7 +72,7 @@
  *            | (../mach-omap2/omap_hwmod*)   |
  *            +-------------------------------+
  *            | OMAP clock/PRCM/register fns  |
- *            | (__raw_{read,write}l, clk*)   |
+ *            | ({read,write}l_relaxed, clk*) |
  *            +-------------------------------+
  *
  * Device drivers should not contain any OMAP-specific code or data in
@@ -3229,17 +3229,17 @@ static int _am33xx_is_hardreset_asserted(struct omap_hwmod *oh,
 u32 omap_hwmod_read(struct omap_hwmod *oh, u16 reg_offs)
 {
 	if (oh->flags & HWMOD_16BIT_REG)
-		return __raw_readw(oh->_mpu_rt_va + reg_offs);
+		return readw_relaxed(oh->_mpu_rt_va + reg_offs);
 	else
-		return __raw_readl(oh->_mpu_rt_va + reg_offs);
+		return readl_relaxed(oh->_mpu_rt_va + reg_offs);
 }
 
 void omap_hwmod_write(u32 v, struct omap_hwmod *oh, u16 reg_offs)
 {
 	if (oh->flags & HWMOD_16BIT_REG)
-		__raw_writew(v, oh->_mpu_rt_va + reg_offs);
+		writew_relaxed(v, oh->_mpu_rt_va + reg_offs);
 	else
-		__raw_writel(v, oh->_mpu_rt_va + reg_offs);
+		writel_relaxed(v, oh->_mpu_rt_va + reg_offs);
 }
 
 /**
diff --git a/arch/arm/mach-omap2/omap_phy_internal.c b/arch/arm/mach-omap2/omap_phy_internal.c
index eb8a25d..50640b3 100644
--- a/arch/arm/mach-omap2/omap_phy_internal.c
+++ b/arch/arm/mach-omap2/omap_phy_internal.c
@@ -57,7 +57,7 @@ static int __init omap4430_phy_power_down(void)
 	}
 
 	/* Power down the phy */
-	__raw_writel(PHY_PD, ctrl_base + CONTROL_DEV_CONF);
+	writel_relaxed(PHY_PD, ctrl_base + CONTROL_DEV_CONF);
 
 	iounmap(ctrl_base);
 
@@ -162,7 +162,7 @@ void ti81xx_musb_phy_power(u8 on)
 		return;
 	}
 
-	usbphycfg = __raw_readl(scm_base + USBCTRL0);
+	usbphycfg = readl_relaxed(scm_base + USBCTRL0);
 
 	if (on) {
 		if (cpu_is_ti816x()) {
@@ -181,7 +181,7 @@ void ti81xx_musb_phy_power(u8 on)
 			usbphycfg |= USBPHY_CM_PWRDN | USBPHY_OTG_PWRDN;
 
 	}
-	__raw_writel(usbphycfg, scm_base + USBCTRL0);
+	writel_relaxed(usbphycfg, scm_base + USBCTRL0);
 
 	iounmap(scm_base);
 }
diff --git a/arch/arm/mach-omap2/prcm_mpu44xx.c b/arch/arm/mach-omap2/prcm_mpu44xx.c
index c30e44a..cdbee63 100644
--- a/arch/arm/mach-omap2/prcm_mpu44xx.c
+++ b/arch/arm/mach-omap2/prcm_mpu44xx.c
@@ -30,12 +30,12 @@ void __iomem *prcm_mpu_base;
 
 u32 omap4_prcm_mpu_read_inst_reg(s16 inst, u16 reg)
 {
-	return __raw_readl(OMAP44XX_PRCM_MPU_REGADDR(inst, reg));
+	return readl_relaxed(OMAP44XX_PRCM_MPU_REGADDR(inst, reg));
 }
 
 void omap4_prcm_mpu_write_inst_reg(u32 val, s16 inst, u16 reg)
 {
-	__raw_writel(val, OMAP44XX_PRCM_MPU_REGADDR(inst, reg));
+	writel_relaxed(val, OMAP44XX_PRCM_MPU_REGADDR(inst, reg));
 }
 
 u32 omap4_prcm_mpu_rmw_inst_reg_bits(u32 mask, u32 bits, s16 inst, s16 reg)
diff --git a/arch/arm/mach-omap2/prm2xxx.h b/arch/arm/mach-omap2/prm2xxx.h
index 3194dd8..d2cb636 100644
--- a/arch/arm/mach-omap2/prm2xxx.h
+++ b/arch/arm/mach-omap2/prm2xxx.h
@@ -27,7 +27,7 @@
 
 /*
  * OMAP2-specific global PRM registers
- * Use __raw_{read,write}l() with these registers.
+ * Use {read,write}l_relaxed() with these registers.
  *
  * With a few exceptions, these are the register names beginning with
  * PRCM_* on 24xx.  (The exceptions are the IRQSTATUS and IRQENABLE
diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.h b/arch/arm/mach-omap2/prm2xxx_3xxx.h
index 9624b40..1a3a963 100644
--- a/arch/arm/mach-omap2/prm2xxx_3xxx.h
+++ b/arch/arm/mach-omap2/prm2xxx_3xxx.h
@@ -55,12 +55,12 @@
 /* Power/reset management domain register get/set */
 static inline u32 omap2_prm_read_mod_reg(s16 module, u16 idx)
 {
-	return __raw_readl(prm_base + module + idx);
+	return readl_relaxed(prm_base + module + idx);
 }
 
 static inline void omap2_prm_write_mod_reg(u32 val, s16 module, u16 idx)
 {
-	__raw_writel(val, prm_base + module + idx);
+	writel_relaxed(val, prm_base + module + idx);
 }
 
 /* Read-modify-write a register in a PRM module. Caller must lock */
diff --git a/arch/arm/mach-omap2/prm33xx.c b/arch/arm/mach-omap2/prm33xx.c
index 7204407..93ba48a 100644
--- a/arch/arm/mach-omap2/prm33xx.c
+++ b/arch/arm/mach-omap2/prm33xx.c
@@ -27,13 +27,13 @@
 /* Read a register in a PRM instance */
 u32 am33xx_prm_read_reg(s16 inst, u16 idx)
 {
-	return __raw_readl(prm_base + inst + idx);
+	return readl_relaxed(prm_base + inst + idx);
 }
 
 /* Write into a register in a PRM instance */
 void am33xx_prm_write_reg(u32 val, s16 inst, u16 idx)
 {
-	__raw_writel(val, prm_base + inst + idx);
+	writel_relaxed(val, prm_base + inst + idx);
 }
 
 /* Read-modify-write a register in PRM. Caller must lock */
diff --git a/arch/arm/mach-omap2/prm3xxx.h b/arch/arm/mach-omap2/prm3xxx.h
index f8eb833..1dacfc5 100644
--- a/arch/arm/mach-omap2/prm3xxx.h
+++ b/arch/arm/mach-omap2/prm3xxx.h
@@ -26,7 +26,7 @@
 
 /*
  * OMAP3-specific global PRM registers
- * Use __raw_{read,write}l() with these registers.
+ * Use {read,write}l_relaxed() with these registers.
  *
  * With a few exceptions, these are the register names beginning with
  * PRM_* on 34xx.  (The exceptions are the IRQSTATUS and IRQENABLE
diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
index 03a6034..94a43b3 100644
--- a/arch/arm/mach-omap2/prm44xx.c
+++ b/arch/arm/mach-omap2/prm44xx.c
@@ -81,13 +81,13 @@ static struct prm_reset_src_map omap44xx_prm_reset_src_map[] = {
 /* Read a register in a CM/PRM instance in the PRM module */
 u32 omap4_prm_read_inst_reg(s16 inst, u16 reg)
 {
-	return __raw_readl(prm_base + inst + reg);
+	return readl_relaxed(prm_base + inst + reg);
 }
 
 /* Write into a register in a CM/PRM instance in the PRM module */
 void omap4_prm_write_inst_reg(u32 val, s16 inst, u16 reg)
 {
-	__raw_writel(val, prm_base + inst + reg);
+	writel_relaxed(val, prm_base + inst + reg);
 }
 
 /* Read-modify-write a register in a PRM module. Caller must lock */
diff --git a/arch/arm/mach-omap2/prminst44xx.c b/arch/arm/mach-omap2/prminst44xx.c
index 05fcf6d..69f0dd0 100644
--- a/arch/arm/mach-omap2/prminst44xx.c
+++ b/arch/arm/mach-omap2/prminst44xx.c
@@ -49,7 +49,7 @@ u32 omap4_prminst_read_inst_reg(u8 part, s16 inst, u16 idx)
 	BUG_ON(part >= OMAP4_MAX_PRCM_PARTITIONS ||
 	       part == OMAP4430_INVALID_PRCM_PARTITION ||
 	       !_prm_bases[part]);
-	return __raw_readl(_prm_bases[part] + inst + idx);
+	return readl_relaxed(_prm_bases[part] + inst + idx);
 }
 
 /* Write into a register in a PRM instance */
@@ -58,7 +58,7 @@ void omap4_prminst_write_inst_reg(u32 val, u8 part, s16 inst, u16 idx)
 	BUG_ON(part >= OMAP4_MAX_PRCM_PARTITIONS ||
 	       part == OMAP4430_INVALID_PRCM_PARTITION ||
 	       !_prm_bases[part]);
-	__raw_writel(val, _prm_bases[part] + inst + idx);
+	writel_relaxed(val, _prm_bases[part] + inst + idx);
 }
 
 /* Read-modify-write a register in PRM. Caller must lock */
diff --git a/arch/arm/mach-omap2/sdrc.h b/arch/arm/mach-omap2/sdrc.h
index 446aa13..645a2a4 100644
--- a/arch/arm/mach-omap2/sdrc.h
+++ b/arch/arm/mach-omap2/sdrc.h
@@ -31,24 +31,24 @@ extern void __iomem *omap2_sms_base;
 
 static inline void sdrc_write_reg(u32 val, u16 reg)
 {
-	__raw_writel(val, OMAP_SDRC_REGADDR(reg));
+	writel_relaxed(val, OMAP_SDRC_REGADDR(reg));
 }
 
 static inline u32 sdrc_read_reg(u16 reg)
 {
-	return __raw_readl(OMAP_SDRC_REGADDR(reg));
+	return readl_relaxed(OMAP_SDRC_REGADDR(reg));
 }
 
 /* SMS global register get/set */
 
 static inline void sms_write_reg(u32 val, u16 reg)
 {
-	__raw_writel(val, OMAP_SMS_REGADDR(reg));
+	writel_relaxed(val, OMAP_SMS_REGADDR(reg));
 }
 
 static inline u32 sms_read_reg(u16 reg)
 {
-	return __raw_readl(OMAP_SMS_REGADDR(reg));
+	return readl_relaxed(OMAP_SMS_REGADDR(reg));
 }
 
 extern void omap2_set_globals_sdrc(void __iomem *sdrc, void __iomem *sms);
diff --git a/arch/arm/mach-omap2/sdrc2xxx.c b/arch/arm/mach-omap2/sdrc2xxx.c
index 9072917..ae3f155 100644
--- a/arch/arm/mach-omap2/sdrc2xxx.c
+++ b/arch/arm/mach-omap2/sdrc2xxx.c
@@ -103,9 +103,9 @@ u32 omap2xxx_sdrc_reprogram(u32 level, u32 force)
 	 * prm2xxx.c function
 	 */
 	if (cpu_is_omap2420())
-		__raw_writel(0xffff, OMAP2420_PRCM_VOLTSETUP);
+		writel_relaxed(0xffff, OMAP2420_PRCM_VOLTSETUP);
 	else
-		__raw_writel(0xffff, OMAP2430_PRCM_VOLTSETUP);
+		writel_relaxed(0xffff, OMAP2430_PRCM_VOLTSETUP);
 	omap2_sram_reprogram_sdrc(level, dll_ctrl, m_type);
 	curr_perf_level = level;
 	local_irq_restore(flags);
diff --git a/arch/arm/mach-omap2/sr_device.c b/arch/arm/mach-omap2/sr_device.c
index d7bc33f..1b91ef0 100644
--- a/arch/arm/mach-omap2/sr_device.c
+++ b/arch/arm/mach-omap2/sr_device.c
@@ -57,7 +57,7 @@ static void __init sr_set_nvalues(struct omap_volt_data *volt_data,
 
 		/*
 		 * In OMAP4 the efuse registers are 24 bit aligned.
-		 * A __raw_readl will fail for non-32 bit aligned address
+		 * A readl_relaxed will fail for non-32 bit aligned address
 		 * and hence the 8-bit read and shift.
 		 */
 		if (cpu_is_omap44xx()) {
diff --git a/arch/arm/mach-omap2/sram.c b/arch/arm/mach-omap2/sram.c
index 4bd0968..ddf1818 100644
--- a/arch/arm/mach-omap2/sram.c
+++ b/arch/arm/mach-omap2/sram.c
@@ -70,16 +70,16 @@ static int is_sram_locked(void)
 	if (OMAP2_DEVICE_TYPE_GP == omap_type()) {
 		/* RAMFW: R/W access to all initiators for all qualifier sets */
 		if (cpu_is_omap242x()) {
-			__raw_writel(0xFF, OMAP24XX_VA_REQINFOPERM0); /* all q-vects */
-			__raw_writel(0xCFDE, OMAP24XX_VA_READPERM0);  /* all i-read */
-			__raw_writel(0xCFDE, OMAP24XX_VA_WRITEPERM0); /* all i-write */
+			writel_relaxed(0xFF, OMAP24XX_VA_REQINFOPERM0); /* all q-vects */
+			writel_relaxed(0xCFDE, OMAP24XX_VA_READPERM0);  /* all i-read */
+			writel_relaxed(0xCFDE, OMAP24XX_VA_WRITEPERM0); /* all i-write */
 		}
 		if (cpu_is_omap34xx()) {
-			__raw_writel(0xFFFF, OMAP34XX_VA_REQINFOPERM0); /* all q-vects */
-			__raw_writel(0xFFFF, OMAP34XX_VA_READPERM0);  /* all i-read */
-			__raw_writel(0xFFFF, OMAP34XX_VA_WRITEPERM0); /* all i-write */
-			__raw_writel(0x0, OMAP34XX_VA_ADDR_MATCH2);
-			__raw_writel(0xFFFFFFFF, OMAP34XX_VA_SMS_RG_ATT0);
+			writel_relaxed(0xFFFF, OMAP34XX_VA_REQINFOPERM0); /* all q-vects */
+			writel_relaxed(0xFFFF, OMAP34XX_VA_READPERM0);  /* all i-read */
+			writel_relaxed(0xFFFF, OMAP34XX_VA_WRITEPERM0); /* all i-write */
+			writel_relaxed(0x0, OMAP34XX_VA_ADDR_MATCH2);
+			writel_relaxed(0xFFFFFFFF, OMAP34XX_VA_SMS_RG_ATT0);
 		}
 		return 0;
 	} else
diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index b62de9f..a8ec167 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -546,15 +546,15 @@ static void __init realtime_counter_init(void)
 	}
 
 	/* Program numerator and denumerator registers */
-	reg = __raw_readl(base + INCREMENTER_NUMERATOR_OFFSET) &
+	reg = readl_relaxed(base + INCREMENTER_NUMERATOR_OFFSET) &
 			NUMERATOR_DENUMERATOR_MASK;
 	reg |= num;
-	__raw_writel(reg, base + INCREMENTER_NUMERATOR_OFFSET);
+	writel_relaxed(reg, base + INCREMENTER_NUMERATOR_OFFSET);
 
-	reg = __raw_readl(base + INCREMENTER_DENUMERATOR_RELOAD_OFFSET) &
+	reg = readl_relaxed(base + INCREMENTER_DENUMERATOR_RELOAD_OFFSET) &
 			NUMERATOR_DENUMERATOR_MASK;
 	reg |= den;
-	__raw_writel(reg, base + INCREMENTER_DENUMERATOR_RELOAD_OFFSET);
+	writel_relaxed(reg, base + INCREMENTER_DENUMERATOR_RELOAD_OFFSET);
 
 	arch_timer_freq = (rate / den) * num;
 	set_cntfreq();
diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
index 49ac797..267f204 100644
--- a/arch/arm/mach-omap2/vc.c
+++ b/arch/arm/mach-omap2/vc.c
@@ -462,7 +462,7 @@ static void omap4_set_timings(struct voltagedomain *voltdm, bool off_mode)
 	val |= omap4_usec_to_val_scrm(tshut, OMAP4_DOWNTIME_SHIFT,
 		OMAP4_DOWNTIME_MASK);
 
-	__raw_writel(val, OMAP4_SCRM_CLKSETUPTIME);
+	writel_relaxed(val, OMAP4_SCRM_CLKSETUPTIME);
 }
 
 /* OMAP4 specific voltage init functions */
@@ -584,7 +584,7 @@ static void __init omap4_vc_i2c_timing_init(struct voltagedomain *voltdm)
 	val = i2c_data->loadbits << 25 | i2c_data->loadbits << 29;
 
 	/* Write to SYSCTRL_PADCONF_WKUP_CTRL_I2C_2 to setup I2C pull */
-	__raw_writel(val, OMAP2_L4_IO_ADDRESS(OMAP4_CTRL_MODULE_PAD_WKUP +
+	writel_relaxed(val, OMAP2_L4_IO_ADDRESS(OMAP4_CTRL_MODULE_PAD_WKUP +
 				OMAP4_CTRL_MODULE_PAD_WKUP_CONTROL_I2C_2));
 
 	/* HSSCLH can always be zero */
diff --git a/arch/arm/mach-omap2/wd_timer.c b/arch/arm/mach-omap2/wd_timer.c
index d15c7bb..97d6607 100644
--- a/arch/arm/mach-omap2/wd_timer.c
+++ b/arch/arm/mach-omap2/wd_timer.c
@@ -49,12 +49,12 @@ int omap2_wd_timer_disable(struct omap_hwmod *oh)
 	}
 
 	/* sequence required to disable watchdog */
-	__raw_writel(0xAAAA, base + OMAP_WDT_SPR);
-	while (__raw_readl(base + OMAP_WDT_WPS) & 0x10)
+	writel_relaxed(0xAAAA, base + OMAP_WDT_SPR);
+	while (readl_relaxed(base + OMAP_WDT_WPS) & 0x10)
 		cpu_relax();
 
-	__raw_writel(0x5555, base + OMAP_WDT_SPR);
-	while (__raw_readl(base + OMAP_WDT_WPS) & 0x10)
+	writel_relaxed(0x5555, base + OMAP_WDT_SPR);
+	while (readl_relaxed(base + OMAP_WDT_WPS) & 0x10)
 		cpu_relax();
 
 	return 0;
-- 
1.7.9.5

