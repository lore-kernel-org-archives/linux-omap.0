From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 06/19] DSPBRIDGE: remove unused clock sys_ck
Date: Thu,  8 Apr 2010 18:15:55 -0500
Message-ID: <1270768568-10712-7-git-send-email-omar.ramirez@ti.com>
References: <1270768568-10712-1-git-send-email-omar.ramirez@ti.com>
 <1270768568-10712-2-git-send-email-omar.ramirez@ti.com>
 <1270768568-10712-3-git-send-email-omar.ramirez@ti.com>
 <1270768568-10712-4-git-send-email-omar.ramirez@ti.com>
 <1270768568-10712-5-git-send-email-omar.ramirez@ti.com>
 <1270768568-10712-6-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59838 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933807Ab0DHW7c (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 Apr 2010 18:59:32 -0400
In-Reply-To: <1270768568-10712-6-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@gmail.com>, Ameya Palande <ameya.palande@nokia.com>, Guzman Lugo Fernando <x0095840@ti.com>, Nishanth Menon <nm@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

Remove unused clock sys_ck

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/clk.h |    1 -
 drivers/dsp/bridge/services/clk.c          |    1 -
 2 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/clk.h b/arch/arm/plat-omap/include/dspbridge/clk.h
index 6088647..55f5f29 100644
--- a/arch/arm/plat-omap/include/dspbridge/clk.h
+++ b/arch/arm/plat-omap/include/dspbridge/clk.h
@@ -45,7 +45,6 @@ enum dsp_clk_id {
 	DSP_CLK_SSI_FCK,
 	DSP_CLK_SSI_ICK,
 	DSP_CLK_SYS32K_CK,
-	DSP_CLK_SYS_CK,
 	DSP_CLK_NOT_DEFINED
 };
 
diff --git a/drivers/dsp/bridge/services/clk.c b/drivers/dsp/bridge/services/clk.c
index 6cc1097..33cb23f 100644
--- a/drivers/dsp/bridge/services/clk.c
+++ b/drivers/dsp/bridge/services/clk.c
@@ -78,7 +78,6 @@ static struct dsp_clk_t dsp_clks[] = {
 	{NULL, "ssi_ssr_sst_fck", -1},
 	{NULL, "ssi_ick", -1},
 	{NULL, "omap_32k_fck", -1},
-	{NULL, "sys_ck", -1},
 	{NULL, ""}
 };
 
-- 
1.6.2.4

