From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH v2 05/19] DSPBRIDGE: remove unused clock sys_ck
Date: Wed, 28 Apr 2010 10:29:43 -0500
Message-ID: <1272468597-6748-6-git-send-email-omar.ramirez@ti.com>
References: <1272468597-6748-1-git-send-email-omar.ramirez@ti.com>
 <1272468597-6748-2-git-send-email-omar.ramirez@ti.com>
 <1272468597-6748-3-git-send-email-omar.ramirez@ti.com>
 <1272468597-6748-4-git-send-email-omar.ramirez@ti.com>
 <1272468597-6748-5-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60000 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754986Ab0D1PY6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 28 Apr 2010 11:24:58 -0400
In-Reply-To: <1272468597-6748-5-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Nishanth Menon <nm@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

Remove unused clock sys_ck

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/clk.h |    1 -
 drivers/dsp/bridge/services/clk.c          |    1 -
 2 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/clk.h b/arch/arm/plat-omap/include/dspbridge/clk.h
index a547225..2a43aab 100644
--- a/arch/arm/plat-omap/include/dspbridge/clk.h
+++ b/arch/arm/plat-omap/include/dspbridge/clk.h
@@ -46,7 +46,6 @@ enum dsp_clk_id {
 	DSP_CLK_SSI_FCK,
 	DSP_CLK_SSI_ICK,
 	DSP_CLK_SYS32K_CK,
-	DSP_CLK_SYS_CK,
 	DSP_CLK_NOT_DEFINED
 };
 
diff --git a/drivers/dsp/bridge/services/clk.c b/drivers/dsp/bridge/services/clk.c
index 4101c38..23d4346 100644
--- a/drivers/dsp/bridge/services/clk.c
+++ b/drivers/dsp/bridge/services/clk.c
@@ -76,7 +76,6 @@ static struct dsp_clk_t dsp_clks[] = {
 	{NULL, "ssi_ssr_sst_fck", -1},
 	{NULL, "ssi_ick", -1},
 	{NULL, "omap_32k_fck", -1},
-	{NULL, "sys_ck", -1},
 	{NULL, ""}
 };
 
-- 
1.6.2.4

