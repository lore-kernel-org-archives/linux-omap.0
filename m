From: <mythripk@ti.com>
Subject: [PATCH v2] OMAPDSS: HDMI: Add M2 divider while calculating clkout
Date: Wed, 15 Feb 2012 11:20:34 +0530
Message-ID: <1329285034-16121-1-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53194 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752062Ab2BOF5q (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Feb 2012 00:57:46 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id q1F5vjAu022689
	for <linux-omap@vger.kernel.org>; Tue, 14 Feb 2012 23:57:45 -0600
Received: from DBDE70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id q1F5vifG028772
	for <linux-omap@vger.kernel.org>; Wed, 15 Feb 2012 11:27:44 +0530 (IST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tomi.valkeinen@ti.com, Mythri P K <mythripk@ti.com>

From: Mythri P K <mythripk@ti.com>

Add M2 divider in the equation to calculate regm and regmf.
Formula for calculating:
Output clock on digital core domain:
	CLKOUT = (M / (N+1))*CLKINP*(1/M2)
Internal oscillator output clock on internal LDO domain:
	CLKDCOLDO = (M / (N+1))*CLKINP
The current code when allows variable M2 values as input
ignores using M2 divider values in calculation of regm and regmf.
so fix it by using M2 in calculation although the default value for
M2 is 1.

Signed-off-by: Mythri P K <mythripk@ti.com>
---
 drivers/video/omap2/dss/hdmi.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 92a6679..9185630 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -256,24 +256,24 @@ static void hdmi_compute_pll(struct omap_dss_device *dssdev, int phy,
 
 	refclk = clkin / pi->regn;
 
-	/*
-	 * multiplier is pixel_clk/ref_clk
-	 * Multiplying by 100 to avoid fractional part removal
-	 */
-	pi->regm = (phy * 100 / (refclk)) / 100;
-
 	if (dssdev->clocks.hdmi.regm2 == 0)
 		pi->regm2 = HDMI_DEFAULT_REGM2;
 	else
 		pi->regm2 = dssdev->clocks.hdmi.regm2;
 
 	/*
+	 * multiplier is pixel_clk/ref_clk
+	 * Multiplying by 100 to avoid fractional part removal
+	 */
+	pi->regm = (phy * 100 * pi->regm2 / (refclk)) / 100;
+
+	/*
 	 * fractional multiplier is remainder of the difference between
 	 * multiplier and actual phy(required pixel clock thus should be
 	 * multiplied by 2^18(262144) divided by the reference clock
 	 */
-	mf = (phy - pi->regm * refclk) * 262144;
-	pi->regmf = mf / (refclk);
+	mf = (phy - pi->regm / pi->regm2 * refclk) * 262144;
+	pi->regmf = pi->regm2 * mf / refclk;
 
 	/*
 	 * Dcofreq should be set to 1 if required pixel clock
-- 
1.7.5.4

