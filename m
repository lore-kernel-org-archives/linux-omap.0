From: "Rajendra Nayak" <rnayak@ti.com>
Subject: [PATCH 09/16] OMAP3: SCM context save/restore
Date: Fri, 26 Sep 2008 17:49:02 +0530
Message-ID: <01fa01c91fd2$0fd48930$LocalHost@wipultra1382>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34335 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751916AbYIZMTM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Sep 2008 08:19:12 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: 'Kevin Hilman' <khilman@deeprootsystems.com>

This patch adds the System control module context save/restore

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/control.c             |  151 ++++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/mach/control.h |   23 ++++
 2 files changed, 173 insertions(+), 1 deletion(-)

Index: linux-omap-2.6/arch/arm/mach-omap2/control.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/control.c	2008-09-26 14:12:38.000000000 +0530
+++ linux-omap-2.6/arch/arm/mach-omap2/control.c	2008-09-26 14:16:00.000000000 +0530
@@ -93,6 +93,46 @@ struct omap3_scratchpad_sdrc_block {
  */
 u32 omap3_arm_context[128];
 
+struct omap3_control_regs {
+	u32 sysconfig;
+	u32 devconf0;
+	u32 mem_dftrw0;
+	u32 mem_dftrw1;
+	u32 msuspendmux_0;
+	u32 msuspendmux_1;
+	u32 msuspendmux_2;
+	u32 msuspendmux_3;
+	u32 msuspendmux_4;
+	u32 msuspendmux_5;
+	u32 sec_ctrl;
+	u32 devconf1;
+	u32 csirxfe;
+	u32 iva2_bootaddr;
+	u32 iva2_bootmod;
+	u32 debobs_0;
+	u32 debobs_1;
+	u32 debobs_2;
+	u32 debobs_3;
+	u32 debobs_4;
+	u32 debobs_5;
+	u32 debobs_6;
+	u32 debobs_7;
+	u32 debobs_8;
+	u32 prog_io0;
+	u32 prog_io1;
+	u32 dss_dpll_spreading;
+	u32 core_dpll_spreading;
+	u32 per_dpll_spreading;
+	u32 usbhost_dpll_spreading;
+	u32 pbias_lite;
+	u32 temp_sensor;
+	u32 sramldo4;
+	u32 sramldo5;
+	u32 csi;
+};
+
+static struct omap3_control_regs control_context;
+
 #define OMAP_CTRL_REGADDR(reg)		(omap2_ctrl_base + (reg))
 
 void __init omap2_set_globals_control(struct omap_globals *omap2_globals)
@@ -265,4 +305,115 @@ void omap3_save_scratchpad_contents(void
 		sizeof(sdrc_block_contents), &arm_context_addr, 4);
 }
 
+void omap3_control_save_context(void)
+{
+	control_context.sysconfig = omap_ctrl_readl(OMAP2_CONTROL_SYSCONFIG);
+	control_context.devconf0 = omap_ctrl_readl(OMAP2_CONTROL_DEVCONF0);
+	control_context.mem_dftrw0 =
+			omap_ctrl_readl(OMAP343X_CONTROL_MEM_DFTRW0);
+	control_context.mem_dftrw1 =
+			omap_ctrl_readl(OMAP343X_CONTROL_MEM_DFTRW1);
+	control_context.msuspendmux_0 =
+			omap_ctrl_readl(OMAP2_CONTROL_MSUSPENDMUX_0);
+	control_context.msuspendmux_1 =
+			omap_ctrl_readl(OMAP2_CONTROL_MSUSPENDMUX_1);
+	control_context.msuspendmux_2 =
+			omap_ctrl_readl(OMAP2_CONTROL_MSUSPENDMUX_2);
+	control_context.msuspendmux_3 =
+			omap_ctrl_readl(OMAP2_CONTROL_MSUSPENDMUX_3);
+	control_context.msuspendmux_4 =
+			omap_ctrl_readl(OMAP2_CONTROL_MSUSPENDMUX_4);
+	control_context.msuspendmux_5 =
+			omap_ctrl_readl(OMAP2_CONTROL_MSUSPENDMUX_5);
+	control_context.sec_ctrl = omap_ctrl_readl(OMAP2_CONTROL_SEC_CTRL);
+	control_context.devconf1 = omap_ctrl_readl(OMAP343X_CONTROL_DEVCONF1);
+	control_context.csirxfe = omap_ctrl_readl(OMAP343X_CONTROL_CSIRXFE);
+	control_context.iva2_bootaddr =
+			omap_ctrl_readl(OMAP343X_CONTROL_IVA2_BOOTADDR);
+	control_context.iva2_bootmod =
+			omap_ctrl_readl(OMAP343X_CONTROL_IVA2_BOOTMOD);
+	control_context.debobs_0 = omap_ctrl_readl(OMAP343X_CONTROL_DEBOBS_0);
+	control_context.debobs_1 = omap_ctrl_readl(OMAP343X_CONTROL_DEBOBS_1);
+	control_context.debobs_2 = omap_ctrl_readl(OMAP343X_CONTROL_DEBOBS_2);
+	control_context.debobs_3 = omap_ctrl_readl(OMAP343X_CONTROL_DEBOBS_3);
+	control_context.debobs_4 = omap_ctrl_readl(OMAP343X_CONTROL_DEBOBS_4);
+	control_context.debobs_5 = omap_ctrl_readl(OMAP343X_CONTROL_DEBOBS_5);
+	control_context.debobs_6 = omap_ctrl_readl(OMAP343X_CONTROL_DEBOBS_6);
+	control_context.debobs_7 = omap_ctrl_readl(OMAP343X_CONTROL_DEBOBS_7);
+	control_context.debobs_8 = omap_ctrl_readl(OMAP343X_CONTROL_DEBOBS_8);
+	control_context.prog_io0 = omap_ctrl_readl(OMAP343X_CONTROL_PROG_IO0);
+	control_context.prog_io1 = omap_ctrl_readl(OMAP343X_CONTROL_PROG_IO1);
+	control_context.dss_dpll_spreading =
+			omap_ctrl_readl(OMAP343X_CONTROL_DSS_DPLL_SPREADING);
+	control_context.core_dpll_spreading =
+			omap_ctrl_readl(OMAP343X_CONTROL_CORE_DPLL_SPREADING);
+	control_context.per_dpll_spreading =
+			omap_ctrl_readl(OMAP343X_CONTROL_PER_DPLL_SPREADING);
+	control_context.usbhost_dpll_spreading =
+		omap_ctrl_readl(OMAP343X_CONTROL_USBHOST_DPLL_SPREADING);
+	control_context.pbias_lite =
+			omap_ctrl_readl(OMAP343X_CONTROL_PBIAS_LITE);
+	control_context.temp_sensor =
+			omap_ctrl_readl(OMAP343X_CONTROL_TEMP_SENSOR);
+	control_context.sramldo4 = omap_ctrl_readl(OMAP343X_CONTROL_SRAMLDO4);
+	control_context.sramldo5 = omap_ctrl_readl(OMAP343X_CONTROL_SRAMLDO5);
+	control_context.csi = omap_ctrl_readl(OMAP343X_CONTROL_CSI);
+	return;
+}
+
+void omap3_control_restore_context(void)
+{
+	omap_ctrl_writel(control_context.sysconfig, OMAP2_CONTROL_SYSCONFIG);
+	omap_ctrl_writel(control_context.devconf0, OMAP2_CONTROL_DEVCONF0);
+	omap_ctrl_writel(control_context.mem_dftrw0,
+					OMAP343X_CONTROL_MEM_DFTRW0);
+	omap_ctrl_writel(control_context.mem_dftrw1,
+					OMAP343X_CONTROL_MEM_DFTRW1);
+	omap_ctrl_writel(control_context.msuspendmux_0,
+					OMAP2_CONTROL_MSUSPENDMUX_0);
+	omap_ctrl_writel(control_context.msuspendmux_1,
+					OMAP2_CONTROL_MSUSPENDMUX_1);
+	omap_ctrl_writel(control_context.msuspendmux_2,
+					OMAP2_CONTROL_MSUSPENDMUX_2);
+	omap_ctrl_writel(control_context.msuspendmux_3,
+					OMAP2_CONTROL_MSUSPENDMUX_3);
+	omap_ctrl_writel(control_context.msuspendmux_4,
+					OMAP2_CONTROL_MSUSPENDMUX_4);
+	omap_ctrl_writel(control_context.msuspendmux_5,
+					OMAP2_CONTROL_MSUSPENDMUX_5);
+	omap_ctrl_writel(control_context.sec_ctrl, OMAP2_CONTROL_SEC_CTRL);
+	omap_ctrl_writel(control_context.devconf1, OMAP343X_CONTROL_DEVCONF1);
+	omap_ctrl_writel(control_context.csirxfe, OMAP343X_CONTROL_CSIRXFE);
+	omap_ctrl_writel(control_context.iva2_bootaddr,
+					OMAP343X_CONTROL_IVA2_BOOTADDR);
+	omap_ctrl_writel(control_context.iva2_bootmod,
+					OMAP343X_CONTROL_IVA2_BOOTMOD);
+	omap_ctrl_writel(control_context.debobs_0, OMAP343X_CONTROL_DEBOBS_0);
+	omap_ctrl_writel(control_context.debobs_1, OMAP343X_CONTROL_DEBOBS_1);
+	omap_ctrl_writel(control_context.debobs_2, OMAP343X_CONTROL_DEBOBS_2);
+	omap_ctrl_writel(control_context.debobs_3, OMAP343X_CONTROL_DEBOBS_3);
+	omap_ctrl_writel(control_context.debobs_4, OMAP343X_CONTROL_DEBOBS_4);
+	omap_ctrl_writel(control_context.debobs_5, OMAP343X_CONTROL_DEBOBS_5);
+	omap_ctrl_writel(control_context.debobs_6, OMAP343X_CONTROL_DEBOBS_6);
+	omap_ctrl_writel(control_context.debobs_7, OMAP343X_CONTROL_DEBOBS_7);
+	omap_ctrl_writel(control_context.debobs_8, OMAP343X_CONTROL_DEBOBS_8);
+	omap_ctrl_writel(control_context.prog_io0, OMAP343X_CONTROL_PROG_IO0);
+	omap_ctrl_writel(control_context.prog_io1, OMAP343X_CONTROL_PROG_IO1);
+	omap_ctrl_writel(control_context.dss_dpll_spreading,
+					OMAP343X_CONTROL_DSS_DPLL_SPREADING);
+	omap_ctrl_writel(control_context.core_dpll_spreading,
+					OMAP343X_CONTROL_CORE_DPLL_SPREADING);
+	omap_ctrl_writel(control_context.per_dpll_spreading,
+					OMAP343X_CONTROL_PER_DPLL_SPREADING);
+	omap_ctrl_writel(control_context.usbhost_dpll_spreading,
+				OMAP343X_CONTROL_USBHOST_DPLL_SPREADING);
+	omap_ctrl_writel(control_context.pbias_lite,
+					OMAP343X_CONTROL_PBIAS_LITE);
+	omap_ctrl_writel(control_context.temp_sensor,
+					OMAP343X_CONTROL_TEMP_SENSOR);
+	omap_ctrl_writel(control_context.sramldo4, OMAP343X_CONTROL_SRAMLDO4);
+	omap_ctrl_writel(control_context.sramldo5, OMAP343X_CONTROL_SRAMLDO5);
+	omap_ctrl_writel(control_context.csi, OMAP343X_CONTROL_CSI);
+	return;
+}
 #endif /* CONFIG_ARCH_OMAP3 */
Index: linux-omap-2.6/arch/arm/plat-omap/include/mach/control.h
===================================================================
--- linux-omap-2.6.orig/arch/arm/plat-omap/include/mach/control.h	2008-09-26 14:12:38.000000000 +0530
+++ linux-omap-2.6/arch/arm/plat-omap/include/mach/control.h	2008-09-26 14:14:39.000000000 +0530
@@ -151,7 +151,26 @@
 #define OMAP343X_CONTROL_FUSE_SR	(OMAP2_CONTROL_GENERAL + 0x0130)
 #define OMAP343X_CONTROL_IVA2_BOOTADDR	(OMAP2_CONTROL_GENERAL + 0x0190)
 #define OMAP343X_CONTROL_IVA2_BOOTMOD	(OMAP2_CONTROL_GENERAL + 0x0194)
-#define OMAP343X_CONTROL_TEMP_SENSOR	(OMAP2_CONTROL_GENERAL + 0x02b4)
+#define OMAP343X_CONTROL_DEBOBS_0	(OMAP2_CONTROL_GENERAL + 0x01B0)
+#define OMAP343X_CONTROL_DEBOBS_1	(OMAP2_CONTROL_GENERAL + 0x01B4)
+#define OMAP343X_CONTROL_DEBOBS_2	(OMAP2_CONTROL_GENERAL + 0x01B8)
+#define OMAP343X_CONTROL_DEBOBS_3	(OMAP2_CONTROL_GENERAL + 0x01BC)
+#define OMAP343X_CONTROL_DEBOBS_4	(OMAP2_CONTROL_GENERAL + 0x01C0)
+#define OMAP343X_CONTROL_DEBOBS_5	(OMAP2_CONTROL_GENERAL + 0x01C4)
+#define OMAP343X_CONTROL_DEBOBS_6	(OMAP2_CONTROL_GENERAL + 0x01C8)
+#define OMAP343X_CONTROL_DEBOBS_7	(OMAP2_CONTROL_GENERAL + 0x01CC)
+#define OMAP343X_CONTROL_DEBOBS_8	(OMAP2_CONTROL_GENERAL + 0x01D0)
+#define OMAP343X_CONTROL_PROG_IO0	(OMAP2_CONTROL_GENERAL + 0x01D4)
+#define OMAP343X_CONTROL_PROG_IO1	(OMAP2_CONTROL_GENERAL + 0x01D8)
+#define OMAP343X_CONTROL_DSS_DPLL_SPREADING	(OMAP2_CONTROL_GENERAL + 0x01E0)
+#define OMAP343X_CONTROL_CORE_DPLL_SPREADING	(OMAP2_CONTROL_GENERAL + 0x01E4)
+#define OMAP343X_CONTROL_PER_DPLL_SPREADING	(OMAP2_CONTROL_GENERAL + 0x01E8)
+#define OMAP343X_CONTROL_USBHOST_DPLL_SPREADING	(OMAP2_CONTROL_GENERAL + 0x01EC)
+#define OMAP343X_CONTROL_PBIAS_LITE	(OMAP2_CONTROL_GENERAL + 0x02B0)
+#define OMAP343X_CONTROL_TEMP_SENSOR	(OMAP2_CONTROL_GENERAL + 0x02B4)
+#define OMAP343X_CONTROL_SRAMLDO4	(OMAP2_CONTROL_GENERAL + 0x02B8)
+#define OMAP343X_CONTROL_SRAMLDO5	(OMAP2_CONTROL_GENERAL + 0x02C0)
+#define OMAP343X_CONTROL_CSI		(OMAP2_CONTROL_GENERAL + 0x02C4)
 
 /*
  * REVISIT: This list of registers is not comprehensive - there are more
@@ -211,6 +230,8 @@ extern void omap3_save_scratchpad_conten
 extern void omap3_clear_scratchpad_contents(void);
 extern u32 *get_restore_pointer(void);
 extern u32 omap3_arm_context[128];
+extern void omap3_control_save_context(void);
+extern void omap3_control_restore_context(void);
 
 #else
 #define omap_ctrl_base_get()		0

