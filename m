From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 02/20] OMAPDSS: HDMI: remove HDMI clk divisors from dssdev
Date: Fri, 8 Mar 2013 13:51:37 +0200
Message-ID: <1362743515-10152-3-git-send-email-tomi.valkeinen@ti.com>
References: <1362743515-10152-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44103 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752809Ab3CHLwJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Mar 2013 06:52:09 -0500
In-Reply-To: <1362743515-10152-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

struct omap_dss_device contains HDMI clock divisors. The idea is that the
board file can pass precalculated divisors to the display driver.
However, these divsors are no longer needed, as the omapdss driver can
calculate the divisors during runtime.

This patch removes the divisors from omap_dss_device, and their uses
from the hdmi driver.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/hdmi.c |   11 +++--------
 include/video/omapdss.h        |    8 --------
 2 files changed, 3 insertions(+), 16 deletions(-)

diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 769d082..e5682ae 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -472,17 +472,12 @@ static void hdmi_compute_pll(struct omap_dss_device *dssdev, int phy,
 	 * Input clock is predivided by N + 1
 	 * out put of which is reference clk
 	 */
-	if (dssdev->clocks.hdmi.regn == 0)
-		pi->regn = HDMI_DEFAULT_REGN;
-	else
-		pi->regn = dssdev->clocks.hdmi.regn;
+
+	pi->regn = HDMI_DEFAULT_REGN;
 
 	refclk = clkin / pi->regn;
 
-	if (dssdev->clocks.hdmi.regm2 == 0)
-		pi->regm2 = HDMI_DEFAULT_REGM2;
-	else
-		pi->regm2 = dssdev->clocks.hdmi.regm2;
+	pi->regm2 = HDMI_DEFAULT_REGM2;
 
 	/*
 	 * multiplier is pixel_clk/ref_clk
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 255bcf5..2cb2b0e 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -591,14 +591,6 @@ struct omap_dss_device {
 	} phy;
 
 	struct {
-		struct {
-			/* regn is one greater than TRM's REGN value */
-			u16 regn;
-			u16 regm2;
-		} hdmi;
-	} clocks;
-
-	struct {
 		struct omap_video_timings timings;
 
 		enum omap_dss_dsi_pixel_format dsi_pix_fmt;
-- 
1.7.10.4

