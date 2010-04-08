From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 08/19] DSPBRIDGE: remove clk_get_use_cnt
Date: Thu,  8 Apr 2010 18:15:57 -0500
Message-ID: <1270768568-10712-9-git-send-email-omar.ramirez@ti.com>
References: <1270768568-10712-1-git-send-email-omar.ramirez@ti.com>
 <1270768568-10712-2-git-send-email-omar.ramirez@ti.com>
 <1270768568-10712-3-git-send-email-omar.ramirez@ti.com>
 <1270768568-10712-4-git-send-email-omar.ramirez@ti.com>
 <1270768568-10712-5-git-send-email-omar.ramirez@ti.com>
 <1270768568-10712-6-git-send-email-omar.ramirez@ti.com>
 <1270768568-10712-7-git-send-email-omar.ramirez@ti.com>
 <1270768568-10712-8-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59837 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933808Ab0DHW7c (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 Apr 2010 18:59:32 -0400
In-Reply-To: <1270768568-10712-8-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@gmail.com>, Ameya Palande <ameya.palande@nokia.com>, Guzman Lugo Fernando <x0095840@ti.com>, Nishanth Menon <nm@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

Instead of querying the use count, balanced number of
enable/disable should be enforced across the system.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/clk.h |   13 -------------
 drivers/dsp/bridge/services/clk.c          |   23 -----------------------
 2 files changed, 0 insertions(+), 36 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/clk.h b/arch/arm/plat-omap/include/dspbridge/clk.h
index 73d97c7..0c16709 100644
--- a/arch/arm/plat-omap/include/dspbridge/clk.h
+++ b/arch/arm/plat-omap/include/dspbridge/clk.h
@@ -102,19 +102,6 @@ extern dsp_status dsp_clk_disable(IN enum dsp_clk_id clk_id);
 
 extern void ssi_clk_prepare(bool FLAG);
 
-/*
- *  ======== CLK_Get_RefCnt ========
- *  Purpose:
- *      get the reference count for the clock.
- *  Parameters:
- *  Returns:
- *      s32:        Reference Count for the clock.
- *      DSP_EFAIL:  Error occured while getting the reference count of a clock.
- *  Requires:
- *  Ensures:
- */
-extern s32 clk_get_use_cnt(IN enum dsp_clk_id clk_id);
-
 u32 omap_bridge_get_iva2_rate(void);
 
 #endif /* _SYNC_H */
diff --git a/drivers/dsp/bridge/services/clk.c b/drivers/dsp/bridge/services/clk.c
index d675aba..094fe68 100644
--- a/drivers/dsp/bridge/services/clk.c
+++ b/drivers/dsp/bridge/services/clk.c
@@ -181,20 +181,11 @@ dsp_status dsp_clk_disable(IN enum dsp_clk_id clk_id)
 {
 	dsp_status status = DSP_SOK;
 	struct clk *clk_handle;
-	s32 clk_use_cnt;
 
 	DBC_REQUIRE(clk_id < DSP_CLK_NOT_DEFINED);
 
 	clk_handle = dsp_clks[clk_id].clk_handle;
 
-	clk_use_cnt = clk_get_use_cnt(clk_id);
-	if (clk_use_cnt == -1) {
-		pr_err("%s: failed to get CLK Use count for CLK %s, CLK dev id"
-		       " = %d\n", __func__, dsp_clks[clk_id].clk_name,
-		       dsp_clks[clk_id].id);
-	} else if (clk_use_cnt == 0) {
-		return status;
-	}
 	if (clk_id == DSP_CLK_SSI_ICK)
 		ssi_clk_prepare(false);
 
@@ -203,20 +194,6 @@ dsp_status dsp_clk_disable(IN enum dsp_clk_id clk_id)
 	return status;
 }
 
-s32 clk_get_use_cnt(IN enum dsp_clk_id clk_id)
-{
-	struct clk *clk_handle;
-	s32 use_count = -1;
-	DBC_REQUIRE(clk_id < DSP_CLK_NOT_DEFINED);
-
-	clk_handle = dsp_clks[clk_id].clk_handle;
-
-	/* FIXME: usecount shouldn't be used */
-	use_count = clk_handle->usecount;
-
-	return use_count;
-}
-
 void ssi_clk_prepare(bool FLAG)
 {
 	void __iomem *ssi_base;
-- 
1.6.2.4

