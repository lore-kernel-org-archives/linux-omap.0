From: Archit Taneja <archit@ti.com>
Subject: [RFC v2 6/6] CLK: TI: Enable dss_deshdcp clock in dra7xx_clk_init
Date: Wed, 28 May 2014 16:20:55 +0530
Message-ID: <1401274255-16845-7-git-send-email-archit@ti.com>
References: <1397654063-8055-1-git-send-email-archit@ti.com>
 <1401274255-16845-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34483 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752387AbaE1Kwi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 May 2014 06:52:38 -0400
In-Reply-To: <1401274255-16845-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, t-kristo@ti.com, rnayak@ti.com
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

The DESHDCP clock is required only by the DES-HDCP block within HDMI in DSS.
However, if the clock isn't set before DSS clock domian is enabled, the clock
domain never comes out of idle state.

This is because the DSS IP is designed in such a way that if DES-HDCP block
can't transition from idle state, the entire DSS clock domain also cannot
transition from idle to enabled. DES-HDCP block needs the DESHDCP clock
enabled to transition from idle successfully.

We enable the deshdcp clock in dra7xx_clk_init() which happens before omap
hwmods are setup. This clock is effectively a gate clock with the parent as
DSS_L3_GICLK. The parent is an automatically controlled clock by DSS clock
domain and hence doesn't have a clock node associated to it. Since
DSS_L3_GICLK is derived from the OCP clock, we set the dss_deshdcp_clk's
parent as l3_iclk_div.

Leaving this bit enabled doesn't prevent DSS or the system to suspend, and only
a very few flops get this clock all the time. So there is negligible impact.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/clk/ti/clk-7xx.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/ti/clk-7xx.c b/drivers/clk/ti/clk-7xx.c
index f7e4073..3f73a02 100644
--- a/drivers/clk/ti/clk-7xx.c
+++ b/drivers/clk/ti/clk-7xx.c
@@ -179,6 +179,7 @@ static struct ti_dt_clk dra7xx_clks[] = {
 	DT_CLK(NULL, "dss_hdmi_clk", "dss_hdmi_clk"),
 	DT_CLK(NULL, "dss_video1_clk", "dss_video1_clk"),
 	DT_CLK(NULL, "dss_video2_clk", "dss_video2_clk"),
+	DT_CLK(NULL, "dss_deshdcp_clk", "dss_deshdcp_clk"),
 	DT_CLK(NULL, "gpio1_dbclk", "gpio1_dbclk"),
 	DT_CLK(NULL, "gpio2_dbclk", "gpio2_dbclk"),
 	DT_CLK(NULL, "gpio3_dbclk", "gpio3_dbclk"),
@@ -306,7 +307,7 @@ static struct ti_dt_clk dra7xx_clks[] = {
 int __init dra7xx_dt_clk_init(void)
 {
 	int rc;
-	struct clk *abe_dpll_mux, *sys_clkin2, *dpll_ck;
+	struct clk *abe_dpll_mux, *sys_clkin2, *dpll_ck, *dss_deshdcp_ck;
 
 	ti_dt_clocks_register(dra7xx_clks);
 
@@ -327,5 +328,10 @@ int __init dra7xx_dt_clk_init(void)
 	if (rc)
 		pr_err("%s: failed to configure GMAC DPLL!\n", __func__);
 
+	dss_deshdcp_ck = clk_get_sys(NULL, "dss_deshdcp_clk");
+	rc = clk_prepare_enable(dss_deshdcp_ck);
+	if (rc)
+		pr_err("%s: failed to enable DESHDCP clock\n", __func__);
+
 	return rc;
 }
-- 
1.8.3.2

