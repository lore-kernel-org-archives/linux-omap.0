From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 14/14] OMAP3: PRM/CM: separate CM context save/restore;
	remove PRM context save/restore
Date: Mon, 06 Dec 2010 18:25:18 -0700
Message-ID: <20101207012517.3708.95448.stgit@twilight.localdomain>
References: <20101207012242.3708.45451.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:41251 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754348Ab0LGBoE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Dec 2010 20:44:04 -0500
In-Reply-To: <20101207012242.3708.45451.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Tero Kristo <tero.kristo@nokia.com>, Rajendra Nayak <rnayak@ti.com>, Kalle Jokiniemi <kalle.jokiniemi@digia.com>

The OMAP3 PRM module is in the WKUP powerdomain, which is always
powered when the chip is powered, so it shouldn't be necessary to save
and restore those PRM registers.  Remove the PRM register save/restore
code, which should save several microseconds during off-mode
entry/exit, since PRM register accesses are relatively slow.

While doing so, move the CM register save/restore code into
CM-specific code.  The CM module has been distinct from the PRM module
since 2430.

This patch includes some minor changes to pm34xx.c.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Rajendra Nayak <rnayak@ti.com>
Cc: Tero Kristo <tero.kristo@nokia.com>
Cc: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
---
 arch/arm/mach-omap2/cm2xxx_3xxx.c      |  296 +++++++++++++++++++++++++
 arch/arm/mach-omap2/cm2xxx_3xxx.h      |    7 +
 arch/arm/mach-omap2/pm34xx.c           |    4 
 arch/arm/mach-omap2/prcm.c             |  375 --------------------------------
 arch/arm/mach-omap2/prm2xxx_3xxx.c     |    1 
 arch/arm/plat-omap/include/plat/prcm.h |    3 
 6 files changed, 304 insertions(+), 382 deletions(-)

diff --git a/arch/arm/mach-omap2/cm2xxx_3xxx.c b/arch/arm/mach-omap2/cm2xxx_3xxx.c
index 5978ce4..1c98dfc 100644
--- a/arch/arm/mach-omap2/cm2xxx_3xxx.c
+++ b/arch/arm/mach-omap2/cm2xxx_3xxx.c
@@ -29,7 +29,6 @@ static const u8 cm_idlest_offs[] = {
 	CM_IDLEST1, CM_IDLEST2, OMAP2430_CM_IDLEST3
 };
 
-
 u32 cm_read_mod_reg(s16 module, u16 idx)
 {
 	return __raw_readl(cm_base + module + idx);
@@ -97,3 +96,298 @@ int omap2_cm_wait_module_ready(s16 prcm_mod, u8 idlest_id, u8 idlest_shift)
 	return (i < MAX_MODULE_READY_TIME) ? 0 : -EBUSY;
 }
 
+/*
+ * Context save/restore code - OMAP3 only
+ */
+#ifdef CONFIG_ARCH_OMAP3
+struct omap3_cm_regs {
+	u32 iva2_cm_clksel1;
+	u32 iva2_cm_clksel2;
+	u32 cm_sysconfig;
+	u32 sgx_cm_clksel;
+	u32 dss_cm_clksel;
+	u32 cam_cm_clksel;
+	u32 per_cm_clksel;
+	u32 emu_cm_clksel;
+	u32 emu_cm_clkstctrl;
+	u32 pll_cm_autoidle2;
+	u32 pll_cm_clksel4;
+	u32 pll_cm_clksel5;
+	u32 pll_cm_clken2;
+	u32 cm_polctrl;
+	u32 iva2_cm_fclken;
+	u32 iva2_cm_clken_pll;
+	u32 core_cm_fclken1;
+	u32 core_cm_fclken3;
+	u32 sgx_cm_fclken;
+	u32 wkup_cm_fclken;
+	u32 dss_cm_fclken;
+	u32 cam_cm_fclken;
+	u32 per_cm_fclken;
+	u32 usbhost_cm_fclken;
+	u32 core_cm_iclken1;
+	u32 core_cm_iclken2;
+	u32 core_cm_iclken3;
+	u32 sgx_cm_iclken;
+	u32 wkup_cm_iclken;
+	u32 dss_cm_iclken;
+	u32 cam_cm_iclken;
+	u32 per_cm_iclken;
+	u32 usbhost_cm_iclken;
+	u32 iva2_cm_autoidle2;
+	u32 mpu_cm_autoidle2;
+	u32 iva2_cm_clkstctrl;
+	u32 mpu_cm_clkstctrl;
+	u32 core_cm_clkstctrl;
+	u32 sgx_cm_clkstctrl;
+	u32 dss_cm_clkstctrl;
+	u32 cam_cm_clkstctrl;
+	u32 per_cm_clkstctrl;
+	u32 neon_cm_clkstctrl;
+	u32 usbhost_cm_clkstctrl;
+	u32 core_cm_autoidle1;
+	u32 core_cm_autoidle2;
+	u32 core_cm_autoidle3;
+	u32 wkup_cm_autoidle;
+	u32 dss_cm_autoidle;
+	u32 cam_cm_autoidle;
+	u32 per_cm_autoidle;
+	u32 usbhost_cm_autoidle;
+	u32 sgx_cm_sleepdep;
+	u32 dss_cm_sleepdep;
+	u32 cam_cm_sleepdep;
+	u32 per_cm_sleepdep;
+	u32 usbhost_cm_sleepdep;
+	u32 cm_clkout_ctrl;
+};
+
+static struct omap3_cm_regs cm_context;
+
+void omap3_cm_save_context(void)
+{
+	cm_context.iva2_cm_clksel1 =
+		cm_read_mod_reg(OMAP3430_IVA2_MOD, CM_CLKSEL1);
+	cm_context.iva2_cm_clksel2 =
+		cm_read_mod_reg(OMAP3430_IVA2_MOD, CM_CLKSEL2);
+	cm_context.cm_sysconfig = __raw_readl(OMAP3430_CM_SYSCONFIG);
+	cm_context.sgx_cm_clksel =
+		cm_read_mod_reg(OMAP3430ES2_SGX_MOD, CM_CLKSEL);
+	cm_context.dss_cm_clksel =
+		cm_read_mod_reg(OMAP3430_DSS_MOD, CM_CLKSEL);
+	cm_context.cam_cm_clksel =
+		cm_read_mod_reg(OMAP3430_CAM_MOD, CM_CLKSEL);
+	cm_context.per_cm_clksel =
+		cm_read_mod_reg(OMAP3430_PER_MOD, CM_CLKSEL);
+	cm_context.emu_cm_clksel =
+		cm_read_mod_reg(OMAP3430_EMU_MOD, CM_CLKSEL1);
+	cm_context.emu_cm_clkstctrl =
+		cm_read_mod_reg(OMAP3430_EMU_MOD, OMAP2_CM_CLKSTCTRL);
+	cm_context.pll_cm_autoidle2 =
+		cm_read_mod_reg(PLL_MOD, CM_AUTOIDLE2);
+	cm_context.pll_cm_clksel4 =
+		cm_read_mod_reg(PLL_MOD, OMAP3430ES2_CM_CLKSEL4);
+	cm_context.pll_cm_clksel5 =
+		cm_read_mod_reg(PLL_MOD, OMAP3430ES2_CM_CLKSEL5);
+	cm_context.pll_cm_clken2 =
+		cm_read_mod_reg(PLL_MOD, OMAP3430ES2_CM_CLKEN2);
+	cm_context.cm_polctrl = __raw_readl(OMAP3430_CM_POLCTRL);
+	cm_context.iva2_cm_fclken =
+		cm_read_mod_reg(OMAP3430_IVA2_MOD, CM_FCLKEN);
+	cm_context.iva2_cm_clken_pll = cm_read_mod_reg(OMAP3430_IVA2_MOD,
+						       OMAP3430_CM_CLKEN_PLL);
+	cm_context.core_cm_fclken1 =
+		cm_read_mod_reg(CORE_MOD, CM_FCLKEN1);
+	cm_context.core_cm_fclken3 =
+		cm_read_mod_reg(CORE_MOD, OMAP3430ES2_CM_FCLKEN3);
+	cm_context.sgx_cm_fclken =
+		cm_read_mod_reg(OMAP3430ES2_SGX_MOD, CM_FCLKEN);
+	cm_context.wkup_cm_fclken =
+		cm_read_mod_reg(WKUP_MOD, CM_FCLKEN);
+	cm_context.dss_cm_fclken =
+		cm_read_mod_reg(OMAP3430_DSS_MOD, CM_FCLKEN);
+	cm_context.cam_cm_fclken =
+		cm_read_mod_reg(OMAP3430_CAM_MOD, CM_FCLKEN);
+	cm_context.per_cm_fclken =
+		cm_read_mod_reg(OMAP3430_PER_MOD, CM_FCLKEN);
+	cm_context.usbhost_cm_fclken =
+		cm_read_mod_reg(OMAP3430ES2_USBHOST_MOD, CM_FCLKEN);
+	cm_context.core_cm_iclken1 =
+		cm_read_mod_reg(CORE_MOD, CM_ICLKEN1);
+	cm_context.core_cm_iclken2 =
+		cm_read_mod_reg(CORE_MOD, CM_ICLKEN2);
+	cm_context.core_cm_iclken3 =
+		cm_read_mod_reg(CORE_MOD, CM_ICLKEN3);
+	cm_context.sgx_cm_iclken =
+		cm_read_mod_reg(OMAP3430ES2_SGX_MOD, CM_ICLKEN);
+	cm_context.wkup_cm_iclken =
+		cm_read_mod_reg(WKUP_MOD, CM_ICLKEN);
+	cm_context.dss_cm_iclken =
+		cm_read_mod_reg(OMAP3430_DSS_MOD, CM_ICLKEN);
+	cm_context.cam_cm_iclken =
+		cm_read_mod_reg(OMAP3430_CAM_MOD, CM_ICLKEN);
+	cm_context.per_cm_iclken =
+		cm_read_mod_reg(OMAP3430_PER_MOD, CM_ICLKEN);
+	cm_context.usbhost_cm_iclken =
+		cm_read_mod_reg(OMAP3430ES2_USBHOST_MOD, CM_ICLKEN);
+	cm_context.iva2_cm_autoidle2 =
+		cm_read_mod_reg(OMAP3430_IVA2_MOD, CM_AUTOIDLE2);
+	cm_context.mpu_cm_autoidle2 =
+		cm_read_mod_reg(MPU_MOD, CM_AUTOIDLE2);
+	cm_context.iva2_cm_clkstctrl =
+		cm_read_mod_reg(OMAP3430_IVA2_MOD, OMAP2_CM_CLKSTCTRL);
+	cm_context.mpu_cm_clkstctrl =
+		cm_read_mod_reg(MPU_MOD, OMAP2_CM_CLKSTCTRL);
+	cm_context.core_cm_clkstctrl =
+		cm_read_mod_reg(CORE_MOD, OMAP2_CM_CLKSTCTRL);
+	cm_context.sgx_cm_clkstctrl =
+		cm_read_mod_reg(OMAP3430ES2_SGX_MOD, OMAP2_CM_CLKSTCTRL);
+	cm_context.dss_cm_clkstctrl =
+		cm_read_mod_reg(OMAP3430_DSS_MOD, OMAP2_CM_CLKSTCTRL);
+	cm_context.cam_cm_clkstctrl =
+		cm_read_mod_reg(OMAP3430_CAM_MOD, OMAP2_CM_CLKSTCTRL);
+	cm_context.per_cm_clkstctrl =
+		cm_read_mod_reg(OMAP3430_PER_MOD, OMAP2_CM_CLKSTCTRL);
+	cm_context.neon_cm_clkstctrl =
+		cm_read_mod_reg(OMAP3430_NEON_MOD, OMAP2_CM_CLKSTCTRL);
+	cm_context.usbhost_cm_clkstctrl =
+		cm_read_mod_reg(OMAP3430ES2_USBHOST_MOD, OMAP2_CM_CLKSTCTRL);
+	cm_context.core_cm_autoidle1 =
+		cm_read_mod_reg(CORE_MOD, CM_AUTOIDLE1);
+	cm_context.core_cm_autoidle2 =
+		cm_read_mod_reg(CORE_MOD, CM_AUTOIDLE2);
+	cm_context.core_cm_autoidle3 =
+		cm_read_mod_reg(CORE_MOD, CM_AUTOIDLE3);
+	cm_context.wkup_cm_autoidle =
+		cm_read_mod_reg(WKUP_MOD, CM_AUTOIDLE);
+	cm_context.dss_cm_autoidle =
+		cm_read_mod_reg(OMAP3430_DSS_MOD, CM_AUTOIDLE);
+	cm_context.cam_cm_autoidle =
+		cm_read_mod_reg(OMAP3430_CAM_MOD, CM_AUTOIDLE);
+	cm_context.per_cm_autoidle =
+		cm_read_mod_reg(OMAP3430_PER_MOD, CM_AUTOIDLE);
+	cm_context.usbhost_cm_autoidle =
+		cm_read_mod_reg(OMAP3430ES2_USBHOST_MOD, CM_AUTOIDLE);
+	cm_context.sgx_cm_sleepdep =
+		cm_read_mod_reg(OMAP3430ES2_SGX_MOD, OMAP3430_CM_SLEEPDEP);
+	cm_context.dss_cm_sleepdep =
+		cm_read_mod_reg(OMAP3430_DSS_MOD, OMAP3430_CM_SLEEPDEP);
+	cm_context.cam_cm_sleepdep =
+		cm_read_mod_reg(OMAP3430_CAM_MOD, OMAP3430_CM_SLEEPDEP);
+	cm_context.per_cm_sleepdep =
+		cm_read_mod_reg(OMAP3430_PER_MOD, OMAP3430_CM_SLEEPDEP);
+	cm_context.usbhost_cm_sleepdep =
+		cm_read_mod_reg(OMAP3430ES2_USBHOST_MOD, OMAP3430_CM_SLEEPDEP);
+	cm_context.cm_clkout_ctrl =
+		cm_read_mod_reg(OMAP3430_CCR_MOD, OMAP3_CM_CLKOUT_CTRL_OFFSET);
+}
+
+void omap3_cm_restore_context(void)
+{
+	cm_write_mod_reg(cm_context.iva2_cm_clksel1, OMAP3430_IVA2_MOD,
+			 CM_CLKSEL1);
+	cm_write_mod_reg(cm_context.iva2_cm_clksel2, OMAP3430_IVA2_MOD,
+			 CM_CLKSEL2);
+	__raw_writel(cm_context.cm_sysconfig, OMAP3430_CM_SYSCONFIG);
+	cm_write_mod_reg(cm_context.sgx_cm_clksel, OMAP3430ES2_SGX_MOD,
+			 CM_CLKSEL);
+	cm_write_mod_reg(cm_context.dss_cm_clksel, OMAP3430_DSS_MOD,
+			 CM_CLKSEL);
+	cm_write_mod_reg(cm_context.cam_cm_clksel, OMAP3430_CAM_MOD,
+			 CM_CLKSEL);
+	cm_write_mod_reg(cm_context.per_cm_clksel, OMAP3430_PER_MOD,
+			 CM_CLKSEL);
+	cm_write_mod_reg(cm_context.emu_cm_clksel, OMAP3430_EMU_MOD,
+			 CM_CLKSEL1);
+	cm_write_mod_reg(cm_context.emu_cm_clkstctrl, OMAP3430_EMU_MOD,
+			 OMAP2_CM_CLKSTCTRL);
+	cm_write_mod_reg(cm_context.pll_cm_autoidle2, PLL_MOD,
+			 CM_AUTOIDLE2);
+	cm_write_mod_reg(cm_context.pll_cm_clksel4, PLL_MOD,
+			 OMAP3430ES2_CM_CLKSEL4);
+	cm_write_mod_reg(cm_context.pll_cm_clksel5, PLL_MOD,
+			 OMAP3430ES2_CM_CLKSEL5);
+	cm_write_mod_reg(cm_context.pll_cm_clken2, PLL_MOD,
+			 OMAP3430ES2_CM_CLKEN2);
+	__raw_writel(cm_context.cm_polctrl, OMAP3430_CM_POLCTRL);
+	cm_write_mod_reg(cm_context.iva2_cm_fclken, OMAP3430_IVA2_MOD,
+			 CM_FCLKEN);
+	cm_write_mod_reg(cm_context.iva2_cm_clken_pll, OMAP3430_IVA2_MOD,
+			 OMAP3430_CM_CLKEN_PLL);
+	cm_write_mod_reg(cm_context.core_cm_fclken1, CORE_MOD, CM_FCLKEN1);
+	cm_write_mod_reg(cm_context.core_cm_fclken3, CORE_MOD,
+			 OMAP3430ES2_CM_FCLKEN3);
+	cm_write_mod_reg(cm_context.sgx_cm_fclken, OMAP3430ES2_SGX_MOD,
+			 CM_FCLKEN);
+	cm_write_mod_reg(cm_context.wkup_cm_fclken, WKUP_MOD, CM_FCLKEN);
+	cm_write_mod_reg(cm_context.dss_cm_fclken, OMAP3430_DSS_MOD,
+			 CM_FCLKEN);
+	cm_write_mod_reg(cm_context.cam_cm_fclken, OMAP3430_CAM_MOD,
+			 CM_FCLKEN);
+	cm_write_mod_reg(cm_context.per_cm_fclken, OMAP3430_PER_MOD,
+			 CM_FCLKEN);
+	cm_write_mod_reg(cm_context.usbhost_cm_fclken,
+			 OMAP3430ES2_USBHOST_MOD, CM_FCLKEN);
+	cm_write_mod_reg(cm_context.core_cm_iclken1, CORE_MOD, CM_ICLKEN1);
+	cm_write_mod_reg(cm_context.core_cm_iclken2, CORE_MOD, CM_ICLKEN2);
+	cm_write_mod_reg(cm_context.core_cm_iclken3, CORE_MOD, CM_ICLKEN3);
+	cm_write_mod_reg(cm_context.sgx_cm_iclken, OMAP3430ES2_SGX_MOD,
+			 CM_ICLKEN);
+	cm_write_mod_reg(cm_context.wkup_cm_iclken, WKUP_MOD, CM_ICLKEN);
+	cm_write_mod_reg(cm_context.dss_cm_iclken, OMAP3430_DSS_MOD,
+			 CM_ICLKEN);
+	cm_write_mod_reg(cm_context.cam_cm_iclken, OMAP3430_CAM_MOD,
+			 CM_ICLKEN);
+	cm_write_mod_reg(cm_context.per_cm_iclken, OMAP3430_PER_MOD,
+			 CM_ICLKEN);
+	cm_write_mod_reg(cm_context.usbhost_cm_iclken,
+			 OMAP3430ES2_USBHOST_MOD, CM_ICLKEN);
+	cm_write_mod_reg(cm_context.iva2_cm_autoidle2, OMAP3430_IVA2_MOD,
+			 CM_AUTOIDLE2);
+	cm_write_mod_reg(cm_context.mpu_cm_autoidle2, MPU_MOD, CM_AUTOIDLE2);
+	cm_write_mod_reg(cm_context.iva2_cm_clkstctrl, OMAP3430_IVA2_MOD,
+			 OMAP2_CM_CLKSTCTRL);
+	cm_write_mod_reg(cm_context.mpu_cm_clkstctrl, MPU_MOD,
+			 OMAP2_CM_CLKSTCTRL);
+	cm_write_mod_reg(cm_context.core_cm_clkstctrl, CORE_MOD,
+			 OMAP2_CM_CLKSTCTRL);
+	cm_write_mod_reg(cm_context.sgx_cm_clkstctrl, OMAP3430ES2_SGX_MOD,
+			 OMAP2_CM_CLKSTCTRL);
+	cm_write_mod_reg(cm_context.dss_cm_clkstctrl, OMAP3430_DSS_MOD,
+			 OMAP2_CM_CLKSTCTRL);
+	cm_write_mod_reg(cm_context.cam_cm_clkstctrl, OMAP3430_CAM_MOD,
+			 OMAP2_CM_CLKSTCTRL);
+	cm_write_mod_reg(cm_context.per_cm_clkstctrl, OMAP3430_PER_MOD,
+			 OMAP2_CM_CLKSTCTRL);
+	cm_write_mod_reg(cm_context.neon_cm_clkstctrl, OMAP3430_NEON_MOD,
+			 OMAP2_CM_CLKSTCTRL);
+	cm_write_mod_reg(cm_context.usbhost_cm_clkstctrl,
+			 OMAP3430ES2_USBHOST_MOD, OMAP2_CM_CLKSTCTRL);
+	cm_write_mod_reg(cm_context.core_cm_autoidle1, CORE_MOD,
+			 CM_AUTOIDLE1);
+	cm_write_mod_reg(cm_context.core_cm_autoidle2, CORE_MOD,
+			 CM_AUTOIDLE2);
+	cm_write_mod_reg(cm_context.core_cm_autoidle3, CORE_MOD,
+			 CM_AUTOIDLE3);
+	cm_write_mod_reg(cm_context.wkup_cm_autoidle, WKUP_MOD, CM_AUTOIDLE);
+	cm_write_mod_reg(cm_context.dss_cm_autoidle, OMAP3430_DSS_MOD,
+			 CM_AUTOIDLE);
+	cm_write_mod_reg(cm_context.cam_cm_autoidle, OMAP3430_CAM_MOD,
+			 CM_AUTOIDLE);
+	cm_write_mod_reg(cm_context.per_cm_autoidle, OMAP3430_PER_MOD,
+			 CM_AUTOIDLE);
+	cm_write_mod_reg(cm_context.usbhost_cm_autoidle,
+			 OMAP3430ES2_USBHOST_MOD, CM_AUTOIDLE);
+	cm_write_mod_reg(cm_context.sgx_cm_sleepdep, OMAP3430ES2_SGX_MOD,
+			 OMAP3430_CM_SLEEPDEP);
+	cm_write_mod_reg(cm_context.dss_cm_sleepdep, OMAP3430_DSS_MOD,
+			 OMAP3430_CM_SLEEPDEP);
+	cm_write_mod_reg(cm_context.cam_cm_sleepdep, OMAP3430_CAM_MOD,
+			 OMAP3430_CM_SLEEPDEP);
+	cm_write_mod_reg(cm_context.per_cm_sleepdep, OMAP3430_PER_MOD,
+			 OMAP3430_CM_SLEEPDEP);
+	cm_write_mod_reg(cm_context.usbhost_cm_sleepdep,
+			 OMAP3430ES2_USBHOST_MOD, OMAP3430_CM_SLEEPDEP);
+	cm_write_mod_reg(cm_context.cm_clkout_ctrl, OMAP3430_CCR_MOD,
+			 OMAP3_CM_CLKOUT_CTRL_OFFSET);
+}
+#endif
diff --git a/arch/arm/mach-omap2/cm2xxx_3xxx.h b/arch/arm/mach-omap2/cm2xxx_3xxx.h
index 5e57211..ce2582c1 100644
--- a/arch/arm/mach-omap2/cm2xxx_3xxx.h
+++ b/arch/arm/mach-omap2/cm2xxx_3xxx.h
@@ -128,4 +128,11 @@ extern u32 cm_clear_mod_reg_bits(u32 bits, s16 module, s16 idx);
 /* CM_IDLEST_GFX */
 #define OMAP_ST_GFX_MASK				(1 << 0)
 
+
+/* Function prototypes */
+# ifndef __ASSEMBLER__
+extern void omap3_cm_save_context(void);
+extern void omap3_cm_restore_context(void);
+# endif
+
 #endif
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 0d73d75..a776241 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -407,7 +407,7 @@ void omap_sram_idle(void)
 		omap_uart_prepare_idle(1);
 		if (core_next_state == PWRDM_POWER_OFF) {
 			omap3_core_save_context();
-			omap3_prcm_save_context();
+			omap3_cm_save_context();
 		}
 	}
 
@@ -447,7 +447,7 @@ void omap_sram_idle(void)
 		core_prev_state = pwrdm_read_prev_pwrst(core_pwrdm);
 		if (core_prev_state == PWRDM_POWER_OFF) {
 			omap3_core_restore_context();
-			omap3_prcm_restore_context();
+			omap3_cm_restore_context();
 			omap3_sram_restore_context();
 			omap2_sms_restore_context();
 		}
diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
index 171c710..dd95cbb 100644
--- a/arch/arm/mach-omap2/prcm.c
+++ b/arch/arm/mach-omap2/prcm.c
@@ -43,85 +43,6 @@ void __iomem *cm2_base;
 
 #define MAX_MODULE_ENABLE_WAIT		100000
 
-struct omap3_prcm_regs {
-	u32 iva2_cm_clksel1;
-	u32 iva2_cm_clksel2;
-	u32 cm_sysconfig;
-	u32 sgx_cm_clksel;
-	u32 dss_cm_clksel;
-	u32 cam_cm_clksel;
-	u32 per_cm_clksel;
-	u32 emu_cm_clksel;
-	u32 emu_cm_clkstctrl;
-	u32 pll_cm_autoidle2;
-	u32 pll_cm_clksel4;
-	u32 pll_cm_clksel5;
-	u32 pll_cm_clken2;
-	u32 cm_polctrl;
-	u32 iva2_cm_fclken;
-	u32 iva2_cm_clken_pll;
-	u32 core_cm_fclken1;
-	u32 core_cm_fclken3;
-	u32 sgx_cm_fclken;
-	u32 wkup_cm_fclken;
-	u32 dss_cm_fclken;
-	u32 cam_cm_fclken;
-	u32 per_cm_fclken;
-	u32 usbhost_cm_fclken;
-	u32 core_cm_iclken1;
-	u32 core_cm_iclken2;
-	u32 core_cm_iclken3;
-	u32 sgx_cm_iclken;
-	u32 wkup_cm_iclken;
-	u32 dss_cm_iclken;
-	u32 cam_cm_iclken;
-	u32 per_cm_iclken;
-	u32 usbhost_cm_iclken;
-	u32 iva2_cm_autiidle2;
-	u32 mpu_cm_autoidle2;
-	u32 iva2_cm_clkstctrl;
-	u32 mpu_cm_clkstctrl;
-	u32 core_cm_clkstctrl;
-	u32 sgx_cm_clkstctrl;
-	u32 dss_cm_clkstctrl;
-	u32 cam_cm_clkstctrl;
-	u32 per_cm_clkstctrl;
-	u32 neon_cm_clkstctrl;
-	u32 usbhost_cm_clkstctrl;
-	u32 core_cm_autoidle1;
-	u32 core_cm_autoidle2;
-	u32 core_cm_autoidle3;
-	u32 wkup_cm_autoidle;
-	u32 dss_cm_autoidle;
-	u32 cam_cm_autoidle;
-	u32 per_cm_autoidle;
-	u32 usbhost_cm_autoidle;
-	u32 sgx_cm_sleepdep;
-	u32 dss_cm_sleepdep;
-	u32 cam_cm_sleepdep;
-	u32 per_cm_sleepdep;
-	u32 usbhost_cm_sleepdep;
-	u32 cm_clkout_ctrl;
-	u32 prm_clkout_ctrl;
-	u32 sgx_pm_wkdep;
-	u32 dss_pm_wkdep;
-	u32 cam_pm_wkdep;
-	u32 per_pm_wkdep;
-	u32 neon_pm_wkdep;
-	u32 usbhost_pm_wkdep;
-	u32 core_pm_mpugrpsel1;
-	u32 iva2_pm_ivagrpsel1;
-	u32 core_pm_mpugrpsel3;
-	u32 core_pm_ivagrpsel3;
-	u32 wkup_pm_mpugrpsel;
-	u32 wkup_pm_ivagrpsel;
-	u32 per_pm_mpugrpsel;
-	u32 per_pm_ivagrpsel;
-	u32 wkup_pm_wken;
-};
-
-static struct omap3_prcm_regs prcm_context;
-
 u32 omap_prcm_get_reset_sources(void)
 {
 	/* XXX This presumably needs modification for 34XX */
@@ -238,299 +159,3 @@ void __init omap2_set_globals_prcm(struct omap_globals *omap2_globals)
 		WARN_ON(!cm2_base);
 	}
 }
-
-#ifdef CONFIG_ARCH_OMAP3
-void omap3_prcm_save_context(void)
-{
-	prcm_context.iva2_cm_clksel1 =
-			 cm_read_mod_reg(OMAP3430_IVA2_MOD, CM_CLKSEL1);
-	prcm_context.iva2_cm_clksel2 =
-			 cm_read_mod_reg(OMAP3430_IVA2_MOD, CM_CLKSEL2);
-	prcm_context.cm_sysconfig = __raw_readl(OMAP3430_CM_SYSCONFIG);
-	prcm_context.sgx_cm_clksel =
-			 cm_read_mod_reg(OMAP3430ES2_SGX_MOD, CM_CLKSEL);
-	prcm_context.dss_cm_clksel =
-			 cm_read_mod_reg(OMAP3430_DSS_MOD, CM_CLKSEL);
-	prcm_context.cam_cm_clksel =
-			 cm_read_mod_reg(OMAP3430_CAM_MOD, CM_CLKSEL);
-	prcm_context.per_cm_clksel =
-			 cm_read_mod_reg(OMAP3430_PER_MOD, CM_CLKSEL);
-	prcm_context.emu_cm_clksel =
-			 cm_read_mod_reg(OMAP3430_EMU_MOD, CM_CLKSEL1);
-	prcm_context.emu_cm_clkstctrl =
-			 cm_read_mod_reg(OMAP3430_EMU_MOD, OMAP2_CM_CLKSTCTRL);
-	prcm_context.pll_cm_autoidle2 =
-			 cm_read_mod_reg(PLL_MOD, CM_AUTOIDLE2);
-	prcm_context.pll_cm_clksel4 =
-			cm_read_mod_reg(PLL_MOD, OMAP3430ES2_CM_CLKSEL4);
-	prcm_context.pll_cm_clksel5 =
-			 cm_read_mod_reg(PLL_MOD, OMAP3430ES2_CM_CLKSEL5);
-	prcm_context.pll_cm_clken2 =
-			cm_read_mod_reg(PLL_MOD, OMAP3430ES2_CM_CLKEN2);
-	prcm_context.cm_polctrl = __raw_readl(OMAP3430_CM_POLCTRL);
-	prcm_context.iva2_cm_fclken =
-			 cm_read_mod_reg(OMAP3430_IVA2_MOD, CM_FCLKEN);
-	prcm_context.iva2_cm_clken_pll = cm_read_mod_reg(OMAP3430_IVA2_MOD,
-			OMAP3430_CM_CLKEN_PLL);
-	prcm_context.core_cm_fclken1 =
-			 cm_read_mod_reg(CORE_MOD, CM_FCLKEN1);
-	prcm_context.core_cm_fclken3 =
-			 cm_read_mod_reg(CORE_MOD, OMAP3430ES2_CM_FCLKEN3);
-	prcm_context.sgx_cm_fclken =
-			 cm_read_mod_reg(OMAP3430ES2_SGX_MOD, CM_FCLKEN);
-	prcm_context.wkup_cm_fclken =
-			 cm_read_mod_reg(WKUP_MOD, CM_FCLKEN);
-	prcm_context.dss_cm_fclken =
-			 cm_read_mod_reg(OMAP3430_DSS_MOD, CM_FCLKEN);
-	prcm_context.cam_cm_fclken =
-			 cm_read_mod_reg(OMAP3430_CAM_MOD, CM_FCLKEN);
-	prcm_context.per_cm_fclken =
-			 cm_read_mod_reg(OMAP3430_PER_MOD, CM_FCLKEN);
-	prcm_context.usbhost_cm_fclken =
-			 cm_read_mod_reg(OMAP3430ES2_USBHOST_MOD, CM_FCLKEN);
-	prcm_context.core_cm_iclken1 =
-			 cm_read_mod_reg(CORE_MOD, CM_ICLKEN1);
-	prcm_context.core_cm_iclken2 =
-			 cm_read_mod_reg(CORE_MOD, CM_ICLKEN2);
-	prcm_context.core_cm_iclken3 =
-			 cm_read_mod_reg(CORE_MOD, CM_ICLKEN3);
-	prcm_context.sgx_cm_iclken =
-			 cm_read_mod_reg(OMAP3430ES2_SGX_MOD, CM_ICLKEN);
-	prcm_context.wkup_cm_iclken =
-			 cm_read_mod_reg(WKUP_MOD, CM_ICLKEN);
-	prcm_context.dss_cm_iclken =
-			 cm_read_mod_reg(OMAP3430_DSS_MOD, CM_ICLKEN);
-	prcm_context.cam_cm_iclken =
-			 cm_read_mod_reg(OMAP3430_CAM_MOD, CM_ICLKEN);
-	prcm_context.per_cm_iclken =
-			 cm_read_mod_reg(OMAP3430_PER_MOD, CM_ICLKEN);
-	prcm_context.usbhost_cm_iclken =
-			 cm_read_mod_reg(OMAP3430ES2_USBHOST_MOD, CM_ICLKEN);
-	prcm_context.iva2_cm_autiidle2 =
-			 cm_read_mod_reg(OMAP3430_IVA2_MOD, CM_AUTOIDLE2);
-	prcm_context.mpu_cm_autoidle2 =
-			 cm_read_mod_reg(MPU_MOD, CM_AUTOIDLE2);
-	prcm_context.iva2_cm_clkstctrl =
-			 cm_read_mod_reg(OMAP3430_IVA2_MOD, OMAP2_CM_CLKSTCTRL);
-	prcm_context.mpu_cm_clkstctrl =
-			 cm_read_mod_reg(MPU_MOD, OMAP2_CM_CLKSTCTRL);
-	prcm_context.core_cm_clkstctrl =
-			 cm_read_mod_reg(CORE_MOD, OMAP2_CM_CLKSTCTRL);
-	prcm_context.sgx_cm_clkstctrl =
-			 cm_read_mod_reg(OMAP3430ES2_SGX_MOD,
-						OMAP2_CM_CLKSTCTRL);
-	prcm_context.dss_cm_clkstctrl =
-			 cm_read_mod_reg(OMAP3430_DSS_MOD, OMAP2_CM_CLKSTCTRL);
-	prcm_context.cam_cm_clkstctrl =
-			 cm_read_mod_reg(OMAP3430_CAM_MOD, OMAP2_CM_CLKSTCTRL);
-	prcm_context.per_cm_clkstctrl =
-			 cm_read_mod_reg(OMAP3430_PER_MOD, OMAP2_CM_CLKSTCTRL);
-	prcm_context.neon_cm_clkstctrl =
-			 cm_read_mod_reg(OMAP3430_NEON_MOD, OMAP2_CM_CLKSTCTRL);
-	prcm_context.usbhost_cm_clkstctrl =
-			 cm_read_mod_reg(OMAP3430ES2_USBHOST_MOD,
-						OMAP2_CM_CLKSTCTRL);
-	prcm_context.core_cm_autoidle1 =
-			 cm_read_mod_reg(CORE_MOD, CM_AUTOIDLE1);
-	prcm_context.core_cm_autoidle2 =
-			 cm_read_mod_reg(CORE_MOD, CM_AUTOIDLE2);
-	prcm_context.core_cm_autoidle3 =
-			 cm_read_mod_reg(CORE_MOD, CM_AUTOIDLE3);
-	prcm_context.wkup_cm_autoidle =
-			 cm_read_mod_reg(WKUP_MOD, CM_AUTOIDLE);
-	prcm_context.dss_cm_autoidle =
-			 cm_read_mod_reg(OMAP3430_DSS_MOD, CM_AUTOIDLE);
-	prcm_context.cam_cm_autoidle =
-			 cm_read_mod_reg(OMAP3430_CAM_MOD, CM_AUTOIDLE);
-	prcm_context.per_cm_autoidle =
-			 cm_read_mod_reg(OMAP3430_PER_MOD, CM_AUTOIDLE);
-	prcm_context.usbhost_cm_autoidle =
-			 cm_read_mod_reg(OMAP3430ES2_USBHOST_MOD, CM_AUTOIDLE);
-	prcm_context.sgx_cm_sleepdep =
-		 cm_read_mod_reg(OMAP3430ES2_SGX_MOD, OMAP3430_CM_SLEEPDEP);
-	prcm_context.dss_cm_sleepdep =
-		 cm_read_mod_reg(OMAP3430_DSS_MOD, OMAP3430_CM_SLEEPDEP);
-	prcm_context.cam_cm_sleepdep =
-		 cm_read_mod_reg(OMAP3430_CAM_MOD, OMAP3430_CM_SLEEPDEP);
-	prcm_context.per_cm_sleepdep =
-		 cm_read_mod_reg(OMAP3430_PER_MOD, OMAP3430_CM_SLEEPDEP);
-	prcm_context.usbhost_cm_sleepdep =
-		 cm_read_mod_reg(OMAP3430ES2_USBHOST_MOD, OMAP3430_CM_SLEEPDEP);
-	prcm_context.cm_clkout_ctrl = cm_read_mod_reg(OMAP3430_CCR_MOD,
-		 OMAP3_CM_CLKOUT_CTRL_OFFSET);
-	prcm_context.prm_clkout_ctrl = prm_read_mod_reg(OMAP3430_CCR_MOD,
-		OMAP3_PRM_CLKOUT_CTRL_OFFSET);
-	prcm_context.sgx_pm_wkdep =
-		 prm_read_mod_reg(OMAP3430ES2_SGX_MOD, PM_WKDEP);
-	prcm_context.dss_pm_wkdep =
-		 prm_read_mod_reg(OMAP3430_DSS_MOD, PM_WKDEP);
-	prcm_context.cam_pm_wkdep =
-		 prm_read_mod_reg(OMAP3430_CAM_MOD, PM_WKDEP);
-	prcm_context.per_pm_wkdep =
-		 prm_read_mod_reg(OMAP3430_PER_MOD, PM_WKDEP);
-	prcm_context.neon_pm_wkdep =
-		 prm_read_mod_reg(OMAP3430_NEON_MOD, PM_WKDEP);
-	prcm_context.usbhost_pm_wkdep =
-		 prm_read_mod_reg(OMAP3430ES2_USBHOST_MOD, PM_WKDEP);
-	prcm_context.core_pm_mpugrpsel1 =
-		 prm_read_mod_reg(CORE_MOD, OMAP3430_PM_MPUGRPSEL1);
-	prcm_context.iva2_pm_ivagrpsel1 =
-		 prm_read_mod_reg(OMAP3430_IVA2_MOD, OMAP3430_PM_IVAGRPSEL1);
-	prcm_context.core_pm_mpugrpsel3 =
-		 prm_read_mod_reg(CORE_MOD, OMAP3430ES2_PM_MPUGRPSEL3);
-	prcm_context.core_pm_ivagrpsel3 =
-		 prm_read_mod_reg(CORE_MOD, OMAP3430ES2_PM_IVAGRPSEL3);
-	prcm_context.wkup_pm_mpugrpsel =
-		 prm_read_mod_reg(WKUP_MOD, OMAP3430_PM_MPUGRPSEL);
-	prcm_context.wkup_pm_ivagrpsel =
-		 prm_read_mod_reg(WKUP_MOD, OMAP3430_PM_IVAGRPSEL);
-	prcm_context.per_pm_mpugrpsel =
-		 prm_read_mod_reg(OMAP3430_PER_MOD, OMAP3430_PM_MPUGRPSEL);
-	prcm_context.per_pm_ivagrpsel =
-		 prm_read_mod_reg(OMAP3430_PER_MOD, OMAP3430_PM_IVAGRPSEL);
-	prcm_context.wkup_pm_wken = prm_read_mod_reg(WKUP_MOD, PM_WKEN);
-	return;
-}
-
-void omap3_prcm_restore_context(void)
-{
-	cm_write_mod_reg(prcm_context.iva2_cm_clksel1, OMAP3430_IVA2_MOD,
-					 CM_CLKSEL1);
-	cm_write_mod_reg(prcm_context.iva2_cm_clksel2, OMAP3430_IVA2_MOD,
-					 CM_CLKSEL2);
-	__raw_writel(prcm_context.cm_sysconfig, OMAP3430_CM_SYSCONFIG);
-	cm_write_mod_reg(prcm_context.sgx_cm_clksel, OMAP3430ES2_SGX_MOD,
-					 CM_CLKSEL);
-	cm_write_mod_reg(prcm_context.dss_cm_clksel, OMAP3430_DSS_MOD,
-					 CM_CLKSEL);
-	cm_write_mod_reg(prcm_context.cam_cm_clksel, OMAP3430_CAM_MOD,
-					 CM_CLKSEL);
-	cm_write_mod_reg(prcm_context.per_cm_clksel, OMAP3430_PER_MOD,
-					 CM_CLKSEL);
-	cm_write_mod_reg(prcm_context.emu_cm_clksel, OMAP3430_EMU_MOD,
-					 CM_CLKSEL1);
-	cm_write_mod_reg(prcm_context.emu_cm_clkstctrl, OMAP3430_EMU_MOD,
-					 OMAP2_CM_CLKSTCTRL);
-	cm_write_mod_reg(prcm_context.pll_cm_autoidle2, PLL_MOD,
-					 CM_AUTOIDLE2);
-	cm_write_mod_reg(prcm_context.pll_cm_clksel4, PLL_MOD,
-					OMAP3430ES2_CM_CLKSEL4);
-	cm_write_mod_reg(prcm_context.pll_cm_clksel5, PLL_MOD,
-					 OMAP3430ES2_CM_CLKSEL5);
-	cm_write_mod_reg(prcm_context.pll_cm_clken2, PLL_MOD,
-					OMAP3430ES2_CM_CLKEN2);
-	__raw_writel(prcm_context.cm_polctrl, OMAP3430_CM_POLCTRL);
-	cm_write_mod_reg(prcm_context.iva2_cm_fclken, OMAP3430_IVA2_MOD,
-					 CM_FCLKEN);
-	cm_write_mod_reg(prcm_context.iva2_cm_clken_pll, OMAP3430_IVA2_MOD,
-					OMAP3430_CM_CLKEN_PLL);
-	cm_write_mod_reg(prcm_context.core_cm_fclken1, CORE_MOD, CM_FCLKEN1);
-	cm_write_mod_reg(prcm_context.core_cm_fclken3, CORE_MOD,
-					 OMAP3430ES2_CM_FCLKEN3);
-	cm_write_mod_reg(prcm_context.sgx_cm_fclken, OMAP3430ES2_SGX_MOD,
-					 CM_FCLKEN);
-	cm_write_mod_reg(prcm_context.wkup_cm_fclken, WKUP_MOD, CM_FCLKEN);
-	cm_write_mod_reg(prcm_context.dss_cm_fclken, OMAP3430_DSS_MOD,
-					 CM_FCLKEN);
-	cm_write_mod_reg(prcm_context.cam_cm_fclken, OMAP3430_CAM_MOD,
-					 CM_FCLKEN);
-	cm_write_mod_reg(prcm_context.per_cm_fclken, OMAP3430_PER_MOD,
-					 CM_FCLKEN);
-	cm_write_mod_reg(prcm_context.usbhost_cm_fclken,
-					 OMAP3430ES2_USBHOST_MOD, CM_FCLKEN);
-	cm_write_mod_reg(prcm_context.core_cm_iclken1, CORE_MOD, CM_ICLKEN1);
-	cm_write_mod_reg(prcm_context.core_cm_iclken2, CORE_MOD, CM_ICLKEN2);
-	cm_write_mod_reg(prcm_context.core_cm_iclken3, CORE_MOD, CM_ICLKEN3);
-	cm_write_mod_reg(prcm_context.sgx_cm_iclken, OMAP3430ES2_SGX_MOD,
-					CM_ICLKEN);
-	cm_write_mod_reg(prcm_context.wkup_cm_iclken, WKUP_MOD, CM_ICLKEN);
-	cm_write_mod_reg(prcm_context.dss_cm_iclken, OMAP3430_DSS_MOD,
-					CM_ICLKEN);
-	cm_write_mod_reg(prcm_context.cam_cm_iclken, OMAP3430_CAM_MOD,
-					CM_ICLKEN);
-	cm_write_mod_reg(prcm_context.per_cm_iclken, OMAP3430_PER_MOD,
-					CM_ICLKEN);
-	cm_write_mod_reg(prcm_context.usbhost_cm_iclken,
-					OMAP3430ES2_USBHOST_MOD, CM_ICLKEN);
-	cm_write_mod_reg(prcm_context.iva2_cm_autiidle2, OMAP3430_IVA2_MOD,
-					CM_AUTOIDLE2);
-	cm_write_mod_reg(prcm_context.mpu_cm_autoidle2, MPU_MOD, CM_AUTOIDLE2);
-	cm_write_mod_reg(prcm_context.iva2_cm_clkstctrl, OMAP3430_IVA2_MOD,
-					OMAP2_CM_CLKSTCTRL);
-	cm_write_mod_reg(prcm_context.mpu_cm_clkstctrl, MPU_MOD,
-					OMAP2_CM_CLKSTCTRL);
-	cm_write_mod_reg(prcm_context.core_cm_clkstctrl, CORE_MOD,
-					OMAP2_CM_CLKSTCTRL);
-	cm_write_mod_reg(prcm_context.sgx_cm_clkstctrl, OMAP3430ES2_SGX_MOD,
-					OMAP2_CM_CLKSTCTRL);
-	cm_write_mod_reg(prcm_context.dss_cm_clkstctrl, OMAP3430_DSS_MOD,
-					OMAP2_CM_CLKSTCTRL);
-	cm_write_mod_reg(prcm_context.cam_cm_clkstctrl, OMAP3430_CAM_MOD,
-					OMAP2_CM_CLKSTCTRL);
-	cm_write_mod_reg(prcm_context.per_cm_clkstctrl, OMAP3430_PER_MOD,
-					OMAP2_CM_CLKSTCTRL);
-	cm_write_mod_reg(prcm_context.neon_cm_clkstctrl, OMAP3430_NEON_MOD,
-					OMAP2_CM_CLKSTCTRL);
-	cm_write_mod_reg(prcm_context.usbhost_cm_clkstctrl,
-				OMAP3430ES2_USBHOST_MOD, OMAP2_CM_CLKSTCTRL);
-	cm_write_mod_reg(prcm_context.core_cm_autoidle1, CORE_MOD,
-					CM_AUTOIDLE1);
-	cm_write_mod_reg(prcm_context.core_cm_autoidle2, CORE_MOD,
-					CM_AUTOIDLE2);
-	cm_write_mod_reg(prcm_context.core_cm_autoidle3, CORE_MOD,
-					CM_AUTOIDLE3);
-	cm_write_mod_reg(prcm_context.wkup_cm_autoidle, WKUP_MOD, CM_AUTOIDLE);
-	cm_write_mod_reg(prcm_context.dss_cm_autoidle, OMAP3430_DSS_MOD,
-					CM_AUTOIDLE);
-	cm_write_mod_reg(prcm_context.cam_cm_autoidle, OMAP3430_CAM_MOD,
-					CM_AUTOIDLE);
-	cm_write_mod_reg(prcm_context.per_cm_autoidle, OMAP3430_PER_MOD,
-					CM_AUTOIDLE);
-	cm_write_mod_reg(prcm_context.usbhost_cm_autoidle,
-					OMAP3430ES2_USBHOST_MOD, CM_AUTOIDLE);
-	cm_write_mod_reg(prcm_context.sgx_cm_sleepdep, OMAP3430ES2_SGX_MOD,
-					OMAP3430_CM_SLEEPDEP);
-	cm_write_mod_reg(prcm_context.dss_cm_sleepdep, OMAP3430_DSS_MOD,
-					OMAP3430_CM_SLEEPDEP);
-	cm_write_mod_reg(prcm_context.cam_cm_sleepdep, OMAP3430_CAM_MOD,
-					OMAP3430_CM_SLEEPDEP);
-	cm_write_mod_reg(prcm_context.per_cm_sleepdep, OMAP3430_PER_MOD,
-					OMAP3430_CM_SLEEPDEP);
-	cm_write_mod_reg(prcm_context.usbhost_cm_sleepdep,
-				OMAP3430ES2_USBHOST_MOD, OMAP3430_CM_SLEEPDEP);
-	cm_write_mod_reg(prcm_context.cm_clkout_ctrl, OMAP3430_CCR_MOD,
-					OMAP3_CM_CLKOUT_CTRL_OFFSET);
-	prm_write_mod_reg(prcm_context.prm_clkout_ctrl, OMAP3430_CCR_MOD,
-					OMAP3_PRM_CLKOUT_CTRL_OFFSET);
-	prm_write_mod_reg(prcm_context.sgx_pm_wkdep, OMAP3430ES2_SGX_MOD,
-					PM_WKDEP);
-	prm_write_mod_reg(prcm_context.dss_pm_wkdep, OMAP3430_DSS_MOD,
-					PM_WKDEP);
-	prm_write_mod_reg(prcm_context.cam_pm_wkdep, OMAP3430_CAM_MOD,
-					PM_WKDEP);
-	prm_write_mod_reg(prcm_context.per_pm_wkdep, OMAP3430_PER_MOD,
-					PM_WKDEP);
-	prm_write_mod_reg(prcm_context.neon_pm_wkdep, OMAP3430_NEON_MOD,
-					PM_WKDEP);
-	prm_write_mod_reg(prcm_context.usbhost_pm_wkdep,
-					OMAP3430ES2_USBHOST_MOD, PM_WKDEP);
-	prm_write_mod_reg(prcm_context.core_pm_mpugrpsel1, CORE_MOD,
-					OMAP3430_PM_MPUGRPSEL1);
-	prm_write_mod_reg(prcm_context.iva2_pm_ivagrpsel1, OMAP3430_IVA2_MOD,
-					OMAP3430_PM_IVAGRPSEL1);
-	prm_write_mod_reg(prcm_context.core_pm_mpugrpsel3, CORE_MOD,
-					OMAP3430ES2_PM_MPUGRPSEL3);
-	prm_write_mod_reg(prcm_context.core_pm_ivagrpsel3, CORE_MOD,
-					OMAP3430ES2_PM_IVAGRPSEL3);
-	prm_write_mod_reg(prcm_context.wkup_pm_mpugrpsel, WKUP_MOD,
-					OMAP3430_PM_MPUGRPSEL);
-	prm_write_mod_reg(prcm_context.wkup_pm_ivagrpsel, WKUP_MOD,
-					OMAP3430_PM_IVAGRPSEL);
-	prm_write_mod_reg(prcm_context.per_pm_mpugrpsel, OMAP3430_PER_MOD,
-					OMAP3430_PM_MPUGRPSEL);
-	prm_write_mod_reg(prcm_context.per_pm_ivagrpsel, OMAP3430_PER_MOD,
-					 OMAP3430_PM_IVAGRPSEL);
-	prm_write_mod_reg(prcm_context.wkup_pm_wken, WKUP_MOD, PM_WKEN);
-	return;
-}
-#endif
diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.c b/arch/arm/mach-omap2/prm2xxx_3xxx.c
index 064b52a..3e1d36c 100644
--- a/arch/arm/mach-omap2/prm2xxx_3xxx.c
+++ b/arch/arm/mach-omap2/prm2xxx_3xxx.c
@@ -154,4 +154,3 @@ int omap2_prm_deassert_hardreset(s16 prm_mod, u8 shift)
 
 	return (c == MAX_MODULE_HARDRESET_WAIT) ? -EBUSY : 0;
 }
-
diff --git a/arch/arm/plat-omap/include/plat/prcm.h b/arch/arm/plat-omap/include/plat/prcm.h
index 3769fc6..d059a05 100644
--- a/arch/arm/plat-omap/include/plat/prcm.h
+++ b/arch/arm/plat-omap/include/plat/prcm.h
@@ -31,9 +31,6 @@ int omap2_cm_wait_idlest(void __iomem *reg, u32 mask, u8 idlest,
 #define START_PADCONF_SAVE 0x2
 #define PADCONF_SAVE_DONE  0x1
 
-void omap3_prcm_save_context(void);
-void omap3_prcm_restore_context(void);
-
 u32 omap4_prm_read_bits_shift(void __iomem *reg, u32 mask);
 u32 omap4_prm_rmw_reg_bits(u32 mask, u32 bits, void __iomem *reg);
 


