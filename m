From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH v2] DSPBRIDGE: remove function clk_set32k_hz
Date: Tue, 27 Apr 2010 20:29:14 -0500
Message-ID: <1272418167-12630-7-git-send-email-omar.ramirez@ti.com>
References: <1272418167-12630-1-git-send-email-omar.ramirez@ti.com>
 <1272418167-12630-2-git-send-email-omar.ramirez@ti.com>
 <1272418167-12630-3-git-send-email-omar.ramirez@ti.com>
 <1272418167-12630-4-git-send-email-omar.ramirez@ti.com>
 <1272418167-12630-5-git-send-email-omar.ramirez@ti.com>
 <1272418167-12630-6-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44928 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752786Ab0D1BYa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Apr 2010 21:24:30 -0400
In-Reply-To: <1272418167-12630-6-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Nishanth Menon <nm@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

This is only used for GPTs and should be addressed once
those clocks are requested using DM timer framework.

This patch might break functionality.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/clk.h |   14 +-------------
 drivers/dsp/bridge/services/clk.c          |   26 --------------------------
 drivers/dsp/bridge/wmd/tiomap3430.c        |   15 ---------------
 3 files changed, 1 insertions(+), 54 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/clk.h b/arch/arm/plat-omap/include/dspbridge/clk.h
index 2a43aab..5f7a925 100644
--- a/arch/arm/plat-omap/include/dspbridge/clk.h
+++ b/arch/arm/plat-omap/include/dspbridge/clk.h
@@ -45,7 +45,6 @@ enum dsp_clk_id {
 	DSP_CLK_MCBSP5_ICK,
 	DSP_CLK_SSI_FCK,
 	DSP_CLK_SSI_ICK,
-	DSP_CLK_SYS32K_CK,
 	DSP_CLK_NOT_DEFINED
 };
 
@@ -115,18 +114,7 @@ extern dsp_status dsp_clk_disable(IN enum dsp_clk_id clk_id);
  */
 extern dsp_status dsp_clk_get_rate(IN enum dsp_clk_id clk_id,
 					u32 *speedMhz);
-/*
- *  ======== clk_set32k_hz ========
- *  Purpose:
- *      Set the requested clock to 32KHz.
- *  Parameters:
- *  Returns:
- *      DSP_SOK:        Success.
- *      -EPERM:      Error occured while setting the clock parent to 32KHz.
- *  Requires:
- *  Ensures:
- */
-extern dsp_status clk_set32k_hz(IN enum dsp_clk_id clk_id);
+
 extern void ssi_clk_prepare(bool FLAG);
 
 /*
diff --git a/drivers/dsp/bridge/services/clk.c b/drivers/dsp/bridge/services/clk.c
index 23d4346..b4f5709 100644
--- a/drivers/dsp/bridge/services/clk.c
+++ b/drivers/dsp/bridge/services/clk.c
@@ -75,7 +75,6 @@ static struct dsp_clk_t dsp_clks[] = {
 	{NULL, "mcbsp_ick", 5},
 	{NULL, "ssi_ssr_sst_fck", -1},
 	{NULL, "ssi_ick", -1},
-	{NULL, "omap_32k_fck", -1},
 	{NULL, ""}
 };
 
@@ -171,31 +170,6 @@ dsp_status dsp_clk_enable(IN enum dsp_clk_id clk_id)
 }
 
 /*
- *  ======== clk_set32k_hz ========
- *  Purpose:
- *      To Set parent of a clock to 32KHz.
- */
-
-dsp_status clk_set32k_hz(IN enum dsp_clk_id clk_id)
-{
-	dsp_status status = DSP_SOK;
-	struct clk *clk_handle;
-	struct clk *clk_parent;
-	clk_parent = dsp_clks[DSP_CLK_SYS32K_CK].clk_handle;
-
-	DBC_REQUIRE(clk_id < DSP_CLK_NOT_DEFINED);
-
-	clk_handle = dsp_clks[clk_id].clk_handle;
-	if (!(clk_set_parent(clk_handle, clk_parent) == 0x0)) {
-		pr_err("%s: failed for %s, dev id = %d\n", __func__,
-		       dsp_clks[clk_id].clk_name,
-		       dsp_clks[clk_id].id);
-		status = -EPERM;
-	}
-	return status;
-}
-
-/*
  *  ======== dsp_clk_disable ========
  *  Purpose:
  *      Disable the clock.
diff --git a/drivers/dsp/bridge/wmd/tiomap3430.c b/drivers/dsp/bridge/wmd/tiomap3430.c
index 896941c..52ec3bc 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430.c
@@ -543,13 +543,6 @@ static dsp_status bridge_brd_start(struct wmd_dev_context *hDevContext,
 				}
 			}
 
-			if (clk_id_index < MBX_PM_MAX_RESOURCES) {
-				status =
-				    clk_set32k_hz(bpwr_clks
-						  [clk_id_index].fun_clk);
-			} else {
-				status = -EPERM;
-			}
 			clk_cmd = (BPWR_ENABLE_CLOCK << MBX_PM_CLK_CMDSHIFT) |
 			    ul_load_monitor_timer;
 
@@ -578,14 +571,6 @@ static dsp_status bridge_brd_start(struct wmd_dev_context *hDevContext,
 				}
 			}
 
-			if (clk_id_index < MBX_PM_MAX_RESOURCES) {
-				status =
-				    clk_set32k_hz(bpwr_clks
-						  [clk_id_index].fun_clk);
-			} else {
-				status = -EPERM;
-			}
-
 			clk_cmd = (BPWR_ENABLE_CLOCK << MBX_PM_CLK_CMDSHIFT) |
 			    ul_bios_gp_timer;
 
-- 
1.6.0.4

