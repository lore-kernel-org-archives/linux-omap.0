From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH v2 06/32] OMAP3: PM: SCM context save/restore
Date: Thu, 22 Oct 2009 16:09:27 -0700
Message-ID: <1256252993-24328-7-git-send-email-khilman@deeprootsystems.com>
References: <1256252993-24328-1-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-2-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-3-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-4-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-5-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-6-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f194.google.com ([209.85.221.194]:37878 "EHLO
	mail-qy0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754275AbZJVXKP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Oct 2009 19:10:15 -0400
Received: by mail-qy0-f194.google.com with SMTP id 32so5544712qyk.4
        for <linux-omap@vger.kernel.org>; Thu, 22 Oct 2009 16:10:20 -0700 (PDT)
In-Reply-To: <1256252993-24328-6-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>, Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>

From: Rajendra Nayak <rnayak@ti.com>

Add context save and restore for the System Control Module to suport
off-mode.

ETK and debobs definitions added by Peter De Schrijver.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/control.c             |  157 ++++++++++++++++++++++++++++-
 arch/arm/plat-omap/include/plat/control.h |   49 +++++++++-
 2 files changed, 202 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index 03e1bce..3ea417d 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -26,6 +26,7 @@
 
 static void __iomem *omap2_ctrl_base;
 
+#if defined(CONFIG_ARCH_OMAP3) && defined(CONFIG_PM)
 struct omap3_scratchpad {
 	u32 boot_config_ptr;
 	u32 public_restore_ptr;
@@ -92,6 +93,47 @@ struct omap3_scratchpad_sdrc_block {
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
+#endif /* CONFIG_ARCH_OMAP3 && CONFIG_PM */
+
 #define OMAP_CTRL_REGADDR(reg)		(omap2_ctrl_base + (reg))
 
 void __init omap2_set_globals_control(struct omap_globals *omap2_globals)
@@ -134,7 +176,7 @@ void omap_ctrl_writel(u32 val, u16 offset)
 	__raw_writel(val, OMAP_CTRL_REGADDR(offset));
 }
 
-#ifdef CONFIG_ARCH_OMAP3
+#if defined(CONFIG_ARCH_OMAP3) && defined(CONFIG_PM)
 /*
  * Clears the scratchpad contents in case of cold boot-
  * called during bootup
@@ -264,4 +306,115 @@ void omap3_save_scratchpad_contents(void)
 		sizeof(sdrc_block_contents), &arm_context_addr, 4);
 }
 
-#endif /* CONFIG_ARCH_OMAP3 */
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
+	control_context.debobs_0 = omap_ctrl_readl(OMAP343X_CONTROL_DEBOBS(0));
+	control_context.debobs_1 = omap_ctrl_readl(OMAP343X_CONTROL_DEBOBS(1));
+	control_context.debobs_2 = omap_ctrl_readl(OMAP343X_CONTROL_DEBOBS(2));
+	control_context.debobs_3 = omap_ctrl_readl(OMAP343X_CONTROL_DEBOBS(3));
+	control_context.debobs_4 = omap_ctrl_readl(OMAP343X_CONTROL_DEBOBS(4));
+	control_context.debobs_5 = omap_ctrl_readl(OMAP343X_CONTROL_DEBOBS(5));
+	control_context.debobs_6 = omap_ctrl_readl(OMAP343X_CONTROL_DEBOBS(6));
+	control_context.debobs_7 = omap_ctrl_readl(OMAP343X_CONTROL_DEBOBS(7));
+	control_context.debobs_8 = omap_ctrl_readl(OMAP343X_CONTROL_DEBOBS(8));
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
+	omap_ctrl_writel(control_context.debobs_0, OMAP343X_CONTROL_DEBOBS(0));
+	omap_ctrl_writel(control_context.debobs_1, OMAP343X_CONTROL_DEBOBS(1));
+	omap_ctrl_writel(control_context.debobs_2, OMAP343X_CONTROL_DEBOBS(2));
+	omap_ctrl_writel(control_context.debobs_3, OMAP343X_CONTROL_DEBOBS(3));
+	omap_ctrl_writel(control_context.debobs_4, OMAP343X_CONTROL_DEBOBS(4));
+	omap_ctrl_writel(control_context.debobs_5, OMAP343X_CONTROL_DEBOBS(5));
+	omap_ctrl_writel(control_context.debobs_6, OMAP343X_CONTROL_DEBOBS(6));
+	omap_ctrl_writel(control_context.debobs_7, OMAP343X_CONTROL_DEBOBS(7));
+	omap_ctrl_writel(control_context.debobs_8, OMAP343X_CONTROL_DEBOBS(8));
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
+#endif /* CONFIG_ARCH_OMAP3 && CONFIG_PM */
diff --git a/arch/arm/plat-omap/include/plat/control.h b/arch/arm/plat-omap/include/plat/control.h
index 7297829..0308e3f 100644
--- a/arch/arm/plat-omap/include/plat/control.h
+++ b/arch/arm/plat-omap/include/plat/control.h
@@ -146,8 +146,51 @@
 #define OMAP343X_CONTROL_TEST_KEY_13	(OMAP2_CONTROL_GENERAL + 0x00fc)
 #define OMAP343X_CONTROL_IVA2_BOOTADDR	(OMAP2_CONTROL_GENERAL + 0x0190)
 #define OMAP343X_CONTROL_IVA2_BOOTMOD	(OMAP2_CONTROL_GENERAL + 0x0194)
-#define OMAP343X_CONTROL_PBIAS_LITE	(OMAP2_CONTROL_GENERAL + 0x02b0)
-#define OMAP343X_CONTROL_TEMP_SENSOR	(OMAP2_CONTROL_GENERAL + 0x02b4)
+#define OMAP343X_CONTROL_DEBOBS(i)	(OMAP2_CONTROL_GENERAL + 0x01B0 \
+					+ ((i) >> 1) * 4 + (!(i) & 1) * 2)
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
+
+
+/* 34xx PADCONF register offsets */
+#define OMAP343X_PADCONF_ETK(i)		(OMAP2_CONTROL_PADCONFS + 0x5a8 + \
+						(i)*2)
+#define OMAP343X_PADCONF_ETK_CLK	OMAP343X_PADCONF_ETK(0)
+#define OMAP343X_PADCONF_ETK_CTL	OMAP343X_PADCONF_ETK(1)
+#define OMAP343X_PADCONF_ETK_D0		OMAP343X_PADCONF_ETK(2)
+#define OMAP343X_PADCONF_ETK_D1		OMAP343X_PADCONF_ETK(3)
+#define OMAP343X_PADCONF_ETK_D2		OMAP343X_PADCONF_ETK(4)
+#define OMAP343X_PADCONF_ETK_D3		OMAP343X_PADCONF_ETK(5)
+#define OMAP343X_PADCONF_ETK_D4		OMAP343X_PADCONF_ETK(6)
+#define OMAP343X_PADCONF_ETK_D5		OMAP343X_PADCONF_ETK(7)
+#define OMAP343X_PADCONF_ETK_D6		OMAP343X_PADCONF_ETK(8)
+#define OMAP343X_PADCONF_ETK_D7		OMAP343X_PADCONF_ETK(9)
+#define OMAP343X_PADCONF_ETK_D8		OMAP343X_PADCONF_ETK(10)
+#define OMAP343X_PADCONF_ETK_D9		OMAP343X_PADCONF_ETK(11)
+#define OMAP343X_PADCONF_ETK_D10	OMAP343X_PADCONF_ETK(12)
+#define OMAP343X_PADCONF_ETK_D11	OMAP343X_PADCONF_ETK(13)
+#define OMAP343X_PADCONF_ETK_D12	OMAP343X_PADCONF_ETK(14)
+#define OMAP343X_PADCONF_ETK_D13	OMAP343X_PADCONF_ETK(15)
+#define OMAP343X_PADCONF_ETK_D14	OMAP343X_PADCONF_ETK(16)
+#define OMAP343X_PADCONF_ETK_D15	OMAP343X_PADCONF_ETK(17)
+
+/* 34xx GENERAL_WKUP regist offsets */
+#define OMAP343X_CONTROL_WKUP_DEBOBSMUX(i) (OMAP343X_CONTROL_GENERAL_WKUP + \
+						0x008 + (i))
+#define OMAP343X_CONTROL_WKUP_DEBOBS0 (OMAP343X_CONTROL_GENERAL_WKUP + 0x008)
+#define OMAP343X_CONTROL_WKUP_DEBOBS1 (OMAP343X_CONTROL_GENERAL_WKUP + 0x00C)
+#define OMAP343X_CONTROL_WKUP_DEBOBS2 (OMAP343X_CONTROL_GENERAL_WKUP + 0x010)
+#define OMAP343X_CONTROL_WKUP_DEBOBS3 (OMAP343X_CONTROL_GENERAL_WKUP + 0x014)
+#define OMAP343X_CONTROL_WKUP_DEBOBS4 (OMAP343X_CONTROL_GENERAL_WKUP + 0x018)
 
 /* 34xx D2D idle-related pins, handled by PM core */
 #define OMAP3_PADCONF_SAD2D_MSTANDBY   0x250
@@ -259,6 +302,8 @@ extern void omap3_save_scratchpad_contents(void);
 extern void omap3_clear_scratchpad_contents(void);
 extern u32 *get_restore_pointer(void);
 extern u32 omap3_arm_context[128];
+extern void omap3_control_save_context(void);
+extern void omap3_control_restore_context(void);
 
 #else
 #define omap_ctrl_base_get()		0
-- 
1.6.4.3

