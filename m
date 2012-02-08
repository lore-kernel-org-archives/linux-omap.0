From: <mythripk@ti.com>
Subject: [PATCH] OMAPDSS: HDMI: Add M2 divider while calculating pll
Date: Wed, 8 Feb 2012 18:43:45 +0530
Message-ID: <1328706825-23555-1-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55783 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757018Ab2BHNVB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Feb 2012 08:21:01 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id q18DKxQ6032071
	for <linux-omap@vger.kernel.org>; Wed, 8 Feb 2012 07:21:00 -0600
Received: from DBDE71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id q18DKxKx000975
	for <linux-omap@vger.kernel.org>; Wed, 8 Feb 2012 18:50:59 +0530 (IST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tomi.valkeinen@ti.com, Mythri P K <mythripk@ti.com>

From: Mythri P K <mythripk@ti.com>

While calculating regm and regmf value add M2 divider in the equation.

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

