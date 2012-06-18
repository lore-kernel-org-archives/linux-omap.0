From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: [PATCH] ARM: OMAP2+: hwmod data: Fix wrong McBSP clock alias on OMAP4
Date: Mon, 18 Jun 2012 11:42:22 +0200
Message-ID: <4FDEF7FE.9040202@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49565 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751765Ab2FRJm2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Jun 2012 05:42:28 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Ujfalusi, Peter" <peter.ujfalusi@ti.com>, "Guiriec, Sebastien" <s-guiriec@ti.com>, "Lopez Cruz, Misael" <misael.lopez@ti.com>

The commit 503d0ea24d1d3dd3db95e5e0edd693da7a2a23eb
  ARM: OMAP4: hwmod data: Add aliases for McBSP fclk clocks

added a wrong "prcm_clk" alias for PRCM clock whereas the McBSP
driver and previous OMAPs are using "prcm_fck".

It thus lead to the following warning.

[   47.409729] omap-mcbsp: clks: could not clk_get() prcm_fck

Fix that by changing the opt_clk role to prcm_fck.

Reported-by: Misael Lopez Cruz <misael.lopez@ti.com>
Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Tested-by: Sebastien Guiriec <s-guiriec@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 950454a..1527541 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -1924,7 +1924,7 @@ static struct omap_hwmod_dma_info omap44xx_mcbsp1_sdma_reqs[] = {
 
 static struct omap_hwmod_opt_clk mcbsp1_opt_clks[] = {
 	{ .role = "pad_fck", .clk = "pad_clks_ck" },
-	{ .role = "prcm_clk", .clk = "mcbsp1_sync_mux_ck" },
+	{ .role = "prcm_fck", .clk = "mcbsp1_sync_mux_ck" },
 };
 
 static struct omap_hwmod omap44xx_mcbsp1_hwmod = {
@@ -1959,7 +1959,7 @@ static struct omap_hwmod_dma_info omap44xx_mcbsp2_sdma_reqs[] = {
 
 static struct omap_hwmod_opt_clk mcbsp2_opt_clks[] = {
 	{ .role = "pad_fck", .clk = "pad_clks_ck" },
-	{ .role = "prcm_clk", .clk = "mcbsp2_sync_mux_ck" },
+	{ .role = "prcm_fck", .clk = "mcbsp2_sync_mux_ck" },
 };
 
 static struct omap_hwmod omap44xx_mcbsp2_hwmod = {
@@ -1994,7 +1994,7 @@ static struct omap_hwmod_dma_info omap44xx_mcbsp3_sdma_reqs[] = {
 
 static struct omap_hwmod_opt_clk mcbsp3_opt_clks[] = {
 	{ .role = "pad_fck", .clk = "pad_clks_ck" },
-	{ .role = "prcm_clk", .clk = "mcbsp3_sync_mux_ck" },
+	{ .role = "prcm_fck", .clk = "mcbsp3_sync_mux_ck" },
 };
 
 static struct omap_hwmod omap44xx_mcbsp3_hwmod = {
@@ -2029,7 +2029,7 @@ static struct omap_hwmod_dma_info omap44xx_mcbsp4_sdma_reqs[] = {
 
 static struct omap_hwmod_opt_clk mcbsp4_opt_clks[] = {
 	{ .role = "pad_fck", .clk = "pad_clks_ck" },
-	{ .role = "prcm_clk", .clk = "mcbsp4_sync_mux_ck" },
+	{ .role = "prcm_fck", .clk = "mcbsp4_sync_mux_ck" },
 };
 
 static struct omap_hwmod omap44xx_mcbsp4_hwmod = {
-- 
1.7.0.4


