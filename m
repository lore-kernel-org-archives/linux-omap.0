From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 18/19] DSPBRIDGE: move clk to dsp-clock
Date: Thu,  8 Apr 2010 18:16:07 -0500
Message-ID: <1270768568-10712-19-git-send-email-omar.ramirez@ti.com>
References: <1270768568-10712-1-git-send-email-omar.ramirez@ti.com>
 <1270768568-10712-2-git-send-email-omar.ramirez@ti.com>
 <1270768568-10712-3-git-send-email-omar.ramirez@ti.com>
 <1270768568-10712-4-git-send-email-omar.ramirez@ti.com>
 <1270768568-10712-5-git-send-email-omar.ramirez@ti.com>
 <1270768568-10712-6-git-send-email-omar.ramirez@ti.com>
 <1270768568-10712-7-git-send-email-omar.ramirez@ti.com>
 <1270768568-10712-8-git-send-email-omar.ramirez@ti.com>
 <1270768568-10712-9-git-send-email-omar.ramirez@ti.com>
 <1270768568-10712-10-git-send-email-omar.ramirez@ti.com>
 <1270768568-10712-11-git-send-email-omar.ramirez@ti.com>
 <1270768568-10712-12-git-send-email-omar.ramirez@ti.com>
 <1270768568-10712-13-git-send-email-omar.ramirez@ti.com>
 <1270768568-10712-14-git-send-email-omar.ramirez@ti.com>
 <1270768568-10712-15-git-send-email-omar.ramirez@ti.com>
 <1270768568-10712-16-git-send-email-omar.ramirez@ti.com>
 <1270768568-10712-17-git-send-email-omar.ramirez@ti.com>
 <1270768568-10712-18-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48639 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933814Ab0DHW7e (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 Apr 2010 18:59:34 -0400
In-Reply-To: <1270768568-10712-18-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@gmail.com>, Ameya Palande <ameya.palande@nokia.com>, Guzman Lugo Fernando <x0095840@ti.com>, Nishanth Menon <nm@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

Rename file and move it outside services layer.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/dsp/bridge/Makefile        |    4 +-
 drivers/dsp/bridge/services/clk.c  |  289 ------------------------------------
 drivers/dsp/bridge/wmd/dsp-clock.c |  289 ++++++++++++++++++++++++++++++++++++
 3 files changed, 291 insertions(+), 291 deletions(-)
 delete mode 100644 drivers/dsp/bridge/services/clk.c
 create mode 100644 drivers/dsp/bridge/wmd/dsp-clock.c

diff --git a/drivers/dsp/bridge/Makefile b/drivers/dsp/bridge/Makefile
index 2b4f92c..1dde54f 100644
--- a/drivers/dsp/bridge/Makefile
+++ b/drivers/dsp/bridge/Makefile
@@ -2,12 +2,12 @@ obj-$(CONFIG_MPU_BRIDGE)	+= bridgedriver.o
 
 libgen = gen/gb.o gen/gs.o gen/gh.o gen/uuidutil.o
 libservices = services/mem.o services/sync.o \
-		services/clk.o services/cfg.o services/reg.o \
+		services/cfg.o services/reg.o \
                services/regsup.o services/ntfy.o \
 		services/services.o
 libwmd = wmd/chnl_sm.o wmd/msg_sm.o wmd/io_sm.o wmd/tiomap3430.o \
 		wmd/tiomap3430_pwr.o wmd/tiomap_io.o \
-		wmd/mmu_fault.o wmd/ue_deh.o
+		wmd/mmu_fault.o wmd/ue_deh.o wmd/dsp-clock.o
 libpmgr = pmgr/chnl.o pmgr/io.o pmgr/msg.o pmgr/cod.o pmgr/dev.o pmgr/wcd.o \
 		pmgr/dmm.o pmgr/cmm.o pmgr/dbll.o
 librmgr = rmgr/dbdcd.o rmgr/disp.o rmgr/drv.o rmgr/mgr.o rmgr/node.o \
diff --git a/drivers/dsp/bridge/services/clk.c b/drivers/dsp/bridge/services/clk.c
deleted file mode 100644
index 8f539fd..0000000
--- a/drivers/dsp/bridge/services/clk.c
+++ /dev/null
@@ -1,289 +0,0 @@
-/*
- * clk.c
- *
- * DSP-BIOS Bridge driver support functions for TI OMAP processors.
- *
- * Clock and Timer services.
- *
- * Copyright (C) 2005-2006 Texas Instruments, Inc.
- *
- * This package is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * THIS PACKAGE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
- * IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
- * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
- */
-
-/*  ----------------------------------- Host OS */
-#include <dspbridge/host_os.h>
-#include <plat/dmtimer.h>
-#include <plat/mcbsp.h>
-
-/*  ----------------------------------- DSP/BIOS Bridge */
-#include <dspbridge/std.h>
-#include <dspbridge/dbdefs.h>
-#include <dspbridge/errbase.h>
-#include <dspbridge/cfg.h>
-#include <dspbridge/drv.h>
-
-/*  ----------------------------------- Trace & Debug */
-#include <dspbridge/dbc.h>
-
-/*  ----------------------------------- OS Adaptation Layer */
-#include <dspbridge/mem.h>
-
-/*  ----------------------------------- This */
-#include <dspbridge/clk.h>
-
-/*  ----------------------------------- Defines, Data Structures, Typedefs */
-
-#define OMAP_SSI_OFFSET			0x58000
-#define OMAP_SSI_SIZE			0x1000
-#define OMAP_SSI_SYSCONFIG_OFFSET	0x10
-
-#define SSI_AUTOIDLE			(1 << 0)
-#define SSI_SIDLE_SMARTIDLE		(2 << 3)
-#define SSI_MIDLE_NOIDLE		(1 << 12)
-
-/* Clk types requested by the dsp */
-#define GPT_CLK		0
-#define WDT_CLK		1
-#define MCBSP_CLK	2
-#define SSI_CLK		3
-
-/* Bridge GPT id (0 - 3), DM Timer id (5 - 8) */
-#define DMT_ID(id) ((id) + 5)
-
-/* Bridge MCBSP id (5 - 9), OMAP Mcbsp id (0 - 4) */
-#define MCBSP_ID(id) ((id) - 5)
-
-static struct omap_dm_timer *timer[4];
-
-struct dsp_ssi {
-	struct clk *sst_fck;
-	struct clk *ssr_fck;
-	struct clk *ick;
-};
-
-static struct dsp_ssi ssi;
-
-static u32 dsp_clocks;
-
-static inline u32 is_dsp_clk_active(u32 clk, u8 id)
-{
-	return clk & (1 << id);
-}
-
-static inline void set_dsp_clk_active(u32 *clk, u8 id)
-{
-	*clk |= (1 << id);
-}
-
-static inline void set_dsp_clk_inactive(u32 *clk, u8 id)
-{
-	*clk &= ~(1 << id);
-}
-
-static s8 get_clk_type(u8 id)
-{
-	s8 type;
-
-	if (id <= DSP_CLK_GPT8)
-		type = GPT_CLK;
-	else if (id == DSP_CLK_WDT3)
-		type = WDT_CLK;
-	else if (id <= DSP_CLK_MCBSP5)
-		type = MCBSP_CLK;
-	else if (id == DSP_CLK_SSI)
-		type = SSI_CLK;
-	else
-		type = -1;
-
-	return type;
-}
-
-void ssi_clk_exit(void)
-{
-	clk_put(ssi.sst_fck);
-	clk_put(ssi.ssr_fck);
-	clk_put(ssi.ick);
-}
-
-void ssi_clk_init(void)
-{
-	static struct platform_device dspbridge_device;
-
-	dspbridge_device.dev.bus = &platform_bus_type;
-
-	ssi.sst_fck = clk_get(&dspbridge_device.dev, "ssi_sst_fck");
-	ssi.ssr_fck = clk_get(&dspbridge_device.dev, "ssi_ssr_fck");
-	ssi.ick = clk_get(&dspbridge_device.dev, "ssi_ick");
-
-	if (IS_ERR(ssi.sst_fck) || IS_ERR(ssi.ssr_fck) || IS_ERR(ssi.ick))
-		dev_err(bridge, "failed to get ssi: sst %p, ssr %p, ick %p\n",
-					ssi.sst_fck, ssi.ssr_fck, ssi.ick);
-}
-
-static void ssi_clk_prepare(bool FLAG)
-{
-	void __iomem *ssi_base;
-	unsigned int value;
-
-	ssi_base = ioremap(L4_34XX_BASE + OMAP_SSI_OFFSET, OMAP_SSI_SIZE);
-	if (!ssi_base) {
-		pr_err("%s: error, SSI not configured\n", __func__);
-		return;
-	}
-
-	if (FLAG) {
-		/* Set Autoidle, SIDLEMode to smart idle, and MIDLEmode to
-		 * no idle
-		 */
-		value = SSI_AUTOIDLE | SSI_SIDLE_SMARTIDLE | SSI_MIDLE_NOIDLE;
-	} else {
-		/* Set Autoidle, SIDLEMode to forced idle, and MIDLEmode to
-		 * forced idle
-		 */
-		value = SSI_AUTOIDLE;
-	}
-
-	__raw_writel(value, ssi_base + OMAP_SSI_SYSCONFIG_OFFSET);
-	iounmap(ssi_base);
-}
-
-static void mcbsp_clk_prepare(bool flag, u8 id)
-{
-	struct cfg_hostres resources;
-	u32 value;
-
-	cfg_get_host_resources((struct cfg_devnode *)
-			       drv_get_first_dev_extension(), &resources);
-
-	if (flag) {
-		if (id == DSP_CLK_MCBSP1) {
-			/* set MCBSP1_CLKS, on McBSP1 ON */
-			value = __raw_readl(resources.dw_sys_ctrl_base + 0x274);
-			value |= 1 << 2;
-			__raw_writel(value, resources.dw_sys_ctrl_base
-					     + 0x274);
-		} else if (id == DSP_CLK_MCBSP2) {
-			/* set MCBSP2_CLKS, on McBSP2 ON */
-			value = __raw_readl(resources.dw_sys_ctrl_base + 0x274);
-			value |= 1 << 6;
-			__raw_writel(value, resources.dw_sys_ctrl_base + 0x274);
-		}
-	} else {
-		if (id == DSP_CLK_MCBSP1) {
-			/* clear MCBSP1_CLKS, on McBSP1 OFF */
-			value = __raw_readl(resources.dw_sys_ctrl_base + 0x274);
-			value &= ~(1 << 2);
-			__raw_writel(value, resources.dw_sys_ctrl_base + 0x274);
-		} else if (id == DSP_CLK_MCBSP2) {
-			/* clear MCBSP2_CLKS, on McBSP2 OFF */
-			value = __raw_readl(resources.dw_sys_ctrl_base + 0x274);
-			value &= ~(1 << 6);
-			__raw_writel(value, resources.dw_sys_ctrl_base + 0x274);
-		}
-	}
-}
-
-/*
- *  ======== dsp_clk_enable ========
- *  Purpose:
- *      Enable Clock .
- *
- */
-dsp_status dsp_clk_enable(IN enum dsp_clk_id clk_id)
-{
-	dsp_status status = DSP_SOK;
-
-	if (is_dsp_clk_active(dsp_clocks, clk_id)) {
-		dev_err(bridge, "WARN: clock id %d already enabled\n", clk_id);
-		goto out;
-	}
-
-	switch (get_clk_type(clk_id)) {
-	case GPT_CLK:
-		timer[clk_id] = omap_dm_timer_request_specific(DMT_ID(clk_id));
-		break;
-	case MCBSP_CLK:
-		mcbsp_clk_prepare(true, clk_id);
-		omap_mcbsp_set_io_type(MCBSP_ID(clk_id), OMAP_MCBSP_POLL_IO);
-		omap_mcbsp_request(MCBSP_ID(clk_id));
-		break;
-	case WDT_CLK:
-		dev_err(bridge, "ERROR: DSP requested to enable WDT3 clk\n");
-		break;
-	case SSI_CLK:
-		clk_enable(ssi.sst_fck);
-		clk_enable(ssi.ssr_fck);
-		clk_enable(ssi.ick);
-
-		/*
-		 * The SSI module need to configured not to have the Forced
-		 * idle for master interface. If it is set to forced idle,
-		 * the SSI module is transitioning to standby thereby causing
-		 * the client in the DSP hang waiting for the SSI module to
-		 * be active after enabling the clocks
-		 */
-		ssi_clk_prepare(true);
-		break;
-	default:
-		dev_err(bridge, "Invalid clock id for enable\n");
-		status = DSP_EFAIL;
-	}
-
-	if (DSP_SUCCEEDED(status))
-		set_dsp_clk_active(&dsp_clocks, clk_id);
-
-out:
-	return status;
-}
-
-/*
- *  ======== dsp_clk_disable ========
- *  Purpose:
- *      Disable the clock.
- *
- */
-dsp_status dsp_clk_disable(IN enum dsp_clk_id clk_id)
-{
-	dsp_status status = DSP_SOK;
-
-	DBC_REQUIRE(clk_id < DSP_CLK_NOT_DEFINED);
-
-	if (!is_dsp_clk_active(dsp_clocks, clk_id)) {
-		dev_err(bridge, "ERR: clock id %d already disabled\n", clk_id);
-		goto out;
-	}
-
-	switch (get_clk_type(clk_id)) {
-	case GPT_CLK:
-		omap_dm_timer_free(timer[clk_id]);
-		break;
-	case MCBSP_CLK:
-		mcbsp_clk_prepare(false, clk_id);
-		omap_mcbsp_free(MCBSP_ID(clk_id));
-		break;
-	case WDT_CLK:
-		dev_err(bridge, "ERROR: DSP requested to disable WDT3 clk\n");
-		break;
-	case SSI_CLK:
-		ssi_clk_prepare(false);
-		clk_disable(ssi.sst_fck);
-		clk_disable(ssi.ssr_fck);
-		clk_disable(ssi.ick);
-		break;
-	default:
-		dev_err(bridge, "Invalid clock id for disable\n");
-		status = DSP_EFAIL;
-	}
-
-	if (DSP_SUCCEEDED(status))
-		set_dsp_clk_inactive(&dsp_clocks, clk_id);
-
-out:
-	return status;
-}
diff --git a/drivers/dsp/bridge/wmd/dsp-clock.c b/drivers/dsp/bridge/wmd/dsp-clock.c
new file mode 100644
index 0000000..8f539fd
--- /dev/null
+++ b/drivers/dsp/bridge/wmd/dsp-clock.c
@@ -0,0 +1,289 @@
+/*
+ * clk.c
+ *
+ * DSP-BIOS Bridge driver support functions for TI OMAP processors.
+ *
+ * Clock and Timer services.
+ *
+ * Copyright (C) 2005-2006 Texas Instruments, Inc.
+ *
+ * This package is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * THIS PACKAGE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
+ * IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
+ * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
+ */
+
+/*  ----------------------------------- Host OS */
+#include <dspbridge/host_os.h>
+#include <plat/dmtimer.h>
+#include <plat/mcbsp.h>
+
+/*  ----------------------------------- DSP/BIOS Bridge */
+#include <dspbridge/std.h>
+#include <dspbridge/dbdefs.h>
+#include <dspbridge/errbase.h>
+#include <dspbridge/cfg.h>
+#include <dspbridge/drv.h>
+
+/*  ----------------------------------- Trace & Debug */
+#include <dspbridge/dbc.h>
+
+/*  ----------------------------------- OS Adaptation Layer */
+#include <dspbridge/mem.h>
+
+/*  ----------------------------------- This */
+#include <dspbridge/clk.h>
+
+/*  ----------------------------------- Defines, Data Structures, Typedefs */
+
+#define OMAP_SSI_OFFSET			0x58000
+#define OMAP_SSI_SIZE			0x1000
+#define OMAP_SSI_SYSCONFIG_OFFSET	0x10
+
+#define SSI_AUTOIDLE			(1 << 0)
+#define SSI_SIDLE_SMARTIDLE		(2 << 3)
+#define SSI_MIDLE_NOIDLE		(1 << 12)
+
+/* Clk types requested by the dsp */
+#define GPT_CLK		0
+#define WDT_CLK		1
+#define MCBSP_CLK	2
+#define SSI_CLK		3
+
+/* Bridge GPT id (0 - 3), DM Timer id (5 - 8) */
+#define DMT_ID(id) ((id) + 5)
+
+/* Bridge MCBSP id (5 - 9), OMAP Mcbsp id (0 - 4) */
+#define MCBSP_ID(id) ((id) - 5)
+
+static struct omap_dm_timer *timer[4];
+
+struct dsp_ssi {
+	struct clk *sst_fck;
+	struct clk *ssr_fck;
+	struct clk *ick;
+};
+
+static struct dsp_ssi ssi;
+
+static u32 dsp_clocks;
+
+static inline u32 is_dsp_clk_active(u32 clk, u8 id)
+{
+	return clk & (1 << id);
+}
+
+static inline void set_dsp_clk_active(u32 *clk, u8 id)
+{
+	*clk |= (1 << id);
+}
+
+static inline void set_dsp_clk_inactive(u32 *clk, u8 id)
+{
+	*clk &= ~(1 << id);
+}
+
+static s8 get_clk_type(u8 id)
+{
+	s8 type;
+
+	if (id <= DSP_CLK_GPT8)
+		type = GPT_CLK;
+	else if (id == DSP_CLK_WDT3)
+		type = WDT_CLK;
+	else if (id <= DSP_CLK_MCBSP5)
+		type = MCBSP_CLK;
+	else if (id == DSP_CLK_SSI)
+		type = SSI_CLK;
+	else
+		type = -1;
+
+	return type;
+}
+
+void ssi_clk_exit(void)
+{
+	clk_put(ssi.sst_fck);
+	clk_put(ssi.ssr_fck);
+	clk_put(ssi.ick);
+}
+
+void ssi_clk_init(void)
+{
+	static struct platform_device dspbridge_device;
+
+	dspbridge_device.dev.bus = &platform_bus_type;
+
+	ssi.sst_fck = clk_get(&dspbridge_device.dev, "ssi_sst_fck");
+	ssi.ssr_fck = clk_get(&dspbridge_device.dev, "ssi_ssr_fck");
+	ssi.ick = clk_get(&dspbridge_device.dev, "ssi_ick");
+
+	if (IS_ERR(ssi.sst_fck) || IS_ERR(ssi.ssr_fck) || IS_ERR(ssi.ick))
+		dev_err(bridge, "failed to get ssi: sst %p, ssr %p, ick %p\n",
+					ssi.sst_fck, ssi.ssr_fck, ssi.ick);
+}
+
+static void ssi_clk_prepare(bool FLAG)
+{
+	void __iomem *ssi_base;
+	unsigned int value;
+
+	ssi_base = ioremap(L4_34XX_BASE + OMAP_SSI_OFFSET, OMAP_SSI_SIZE);
+	if (!ssi_base) {
+		pr_err("%s: error, SSI not configured\n", __func__);
+		return;
+	}
+
+	if (FLAG) {
+		/* Set Autoidle, SIDLEMode to smart idle, and MIDLEmode to
+		 * no idle
+		 */
+		value = SSI_AUTOIDLE | SSI_SIDLE_SMARTIDLE | SSI_MIDLE_NOIDLE;
+	} else {
+		/* Set Autoidle, SIDLEMode to forced idle, and MIDLEmode to
+		 * forced idle
+		 */
+		value = SSI_AUTOIDLE;
+	}
+
+	__raw_writel(value, ssi_base + OMAP_SSI_SYSCONFIG_OFFSET);
+	iounmap(ssi_base);
+}
+
+static void mcbsp_clk_prepare(bool flag, u8 id)
+{
+	struct cfg_hostres resources;
+	u32 value;
+
+	cfg_get_host_resources((struct cfg_devnode *)
+			       drv_get_first_dev_extension(), &resources);
+
+	if (flag) {
+		if (id == DSP_CLK_MCBSP1) {
+			/* set MCBSP1_CLKS, on McBSP1 ON */
+			value = __raw_readl(resources.dw_sys_ctrl_base + 0x274);
+			value |= 1 << 2;
+			__raw_writel(value, resources.dw_sys_ctrl_base
+					     + 0x274);
+		} else if (id == DSP_CLK_MCBSP2) {
+			/* set MCBSP2_CLKS, on McBSP2 ON */
+			value = __raw_readl(resources.dw_sys_ctrl_base + 0x274);
+			value |= 1 << 6;
+			__raw_writel(value, resources.dw_sys_ctrl_base + 0x274);
+		}
+	} else {
+		if (id == DSP_CLK_MCBSP1) {
+			/* clear MCBSP1_CLKS, on McBSP1 OFF */
+			value = __raw_readl(resources.dw_sys_ctrl_base + 0x274);
+			value &= ~(1 << 2);
+			__raw_writel(value, resources.dw_sys_ctrl_base + 0x274);
+		} else if (id == DSP_CLK_MCBSP2) {
+			/* clear MCBSP2_CLKS, on McBSP2 OFF */
+			value = __raw_readl(resources.dw_sys_ctrl_base + 0x274);
+			value &= ~(1 << 6);
+			__raw_writel(value, resources.dw_sys_ctrl_base + 0x274);
+		}
+	}
+}
+
+/*
+ *  ======== dsp_clk_enable ========
+ *  Purpose:
+ *      Enable Clock .
+ *
+ */
+dsp_status dsp_clk_enable(IN enum dsp_clk_id clk_id)
+{
+	dsp_status status = DSP_SOK;
+
+	if (is_dsp_clk_active(dsp_clocks, clk_id)) {
+		dev_err(bridge, "WARN: clock id %d already enabled\n", clk_id);
+		goto out;
+	}
+
+	switch (get_clk_type(clk_id)) {
+	case GPT_CLK:
+		timer[clk_id] = omap_dm_timer_request_specific(DMT_ID(clk_id));
+		break;
+	case MCBSP_CLK:
+		mcbsp_clk_prepare(true, clk_id);
+		omap_mcbsp_set_io_type(MCBSP_ID(clk_id), OMAP_MCBSP_POLL_IO);
+		omap_mcbsp_request(MCBSP_ID(clk_id));
+		break;
+	case WDT_CLK:
+		dev_err(bridge, "ERROR: DSP requested to enable WDT3 clk\n");
+		break;
+	case SSI_CLK:
+		clk_enable(ssi.sst_fck);
+		clk_enable(ssi.ssr_fck);
+		clk_enable(ssi.ick);
+
+		/*
+		 * The SSI module need to configured not to have the Forced
+		 * idle for master interface. If it is set to forced idle,
+		 * the SSI module is transitioning to standby thereby causing
+		 * the client in the DSP hang waiting for the SSI module to
+		 * be active after enabling the clocks
+		 */
+		ssi_clk_prepare(true);
+		break;
+	default:
+		dev_err(bridge, "Invalid clock id for enable\n");
+		status = DSP_EFAIL;
+	}
+
+	if (DSP_SUCCEEDED(status))
+		set_dsp_clk_active(&dsp_clocks, clk_id);
+
+out:
+	return status;
+}
+
+/*
+ *  ======== dsp_clk_disable ========
+ *  Purpose:
+ *      Disable the clock.
+ *
+ */
+dsp_status dsp_clk_disable(IN enum dsp_clk_id clk_id)
+{
+	dsp_status status = DSP_SOK;
+
+	DBC_REQUIRE(clk_id < DSP_CLK_NOT_DEFINED);
+
+	if (!is_dsp_clk_active(dsp_clocks, clk_id)) {
+		dev_err(bridge, "ERR: clock id %d already disabled\n", clk_id);
+		goto out;
+	}
+
+	switch (get_clk_type(clk_id)) {
+	case GPT_CLK:
+		omap_dm_timer_free(timer[clk_id]);
+		break;
+	case MCBSP_CLK:
+		mcbsp_clk_prepare(false, clk_id);
+		omap_mcbsp_free(MCBSP_ID(clk_id));
+		break;
+	case WDT_CLK:
+		dev_err(bridge, "ERROR: DSP requested to disable WDT3 clk\n");
+		break;
+	case SSI_CLK:
+		ssi_clk_prepare(false);
+		clk_disable(ssi.sst_fck);
+		clk_disable(ssi.ssr_fck);
+		clk_disable(ssi.ick);
+		break;
+	default:
+		dev_err(bridge, "Invalid clock id for disable\n");
+		status = DSP_EFAIL;
+	}
+
+	if (DSP_SUCCEEDED(status))
+		set_dsp_clk_inactive(&dsp_clocks, clk_id);
+
+out:
+	return status;
+}
-- 
1.6.2.4

