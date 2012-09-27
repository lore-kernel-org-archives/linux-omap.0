From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH] omap3isp: Replace cpu_is_omap3630() with ISP revision check
Date: Thu, 27 Sep 2012 16:38:18 +0200
Message-ID: <1348756698-23128-1-git-send-email-laurent.pinchart@ideasonboard.com>
References: <20120926220018.GJ4840@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:51711 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753888Ab2I0Ohm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 Sep 2012 10:37:42 -0400
In-Reply-To: <20120926220018.GJ4840@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-media@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Sakari Ailus <sakari.ailus@iki.fi>, Tony Lindgren <tony@atomide.com>, paul@pwsan.com

Drivers must not rely on cpu_is_omap* macros (they will soon become
private). Use the ISP revision instead to identify the hardware.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/media/platform/omap3isp/isp.c |   25 ++++++++++++++++---------
 1 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/media/platform/omap3isp/isp.c b/drivers/media/platform/omap3isp/isp.c
index d7aa513..6034dca 100644
--- a/drivers/media/platform/omap3isp/isp.c
+++ b/drivers/media/platform/omap3isp/isp.c
@@ -1345,10 +1345,7 @@ static int isp_enable_clocks(struct isp_device *isp)
 	 * has to be twice of what is set on OMAP3430 to get
 	 * the required value for cam_mclk
 	 */
-	if (cpu_is_omap3630())
-		divisor = 1;
-	else
-		divisor = 2;
+	divisor = isp->revision == ISP_REVISION_15_0 ? 1 : 2;
 
 	r = clk_enable(isp->clock[ISP_CLK_CAM_ICK]);
 	if (r) {
@@ -2093,7 +2090,11 @@ static int __devinit isp_probe(struct platform_device *pdev)
 	isp->isp_csiphy1.vdd = regulator_get(&pdev->dev, "VDD_CSIPHY1");
 	isp->isp_csiphy2.vdd = regulator_get(&pdev->dev, "VDD_CSIPHY2");
 
-	/* Clocks */
+	/* Clocks
+	 *
+	 * The ISP clock tree is revision-dependent. We thus need to enable ICLK
+	 * manually to read the revision before calling __omap3isp_get().
+	 */
 	ret = isp_map_mem_resource(pdev, isp, OMAP3_ISP_IOMEM_MAIN);
 	if (ret < 0)
 		goto error;
@@ -2102,6 +2103,16 @@ static int __devinit isp_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto error;
 
+	ret = clk_enable(isp->clock[ISP_CLK_CAM_ICK]);
+	if (ret < 0)
+		goto error;
+
+	isp->revision = isp_reg_readl(isp, OMAP3_ISP_IOMEM_MAIN, ISP_REVISION);
+	dev_info(isp->dev, "Revision %d.%d found\n",
+		 (isp->revision & 0xf0) >> 4, isp->revision & 0x0f);
+
+	clk_disable(isp->clock[ISP_CLK_CAM_ICK]);
+
 	if (__omap3isp_get(isp, false) == NULL) {
 		ret = -ENODEV;
 		goto error;
@@ -2112,10 +2123,6 @@ static int __devinit isp_probe(struct platform_device *pdev)
 		goto error_isp;
 
 	/* Memory resources */
-	isp->revision = isp_reg_readl(isp, OMAP3_ISP_IOMEM_MAIN, ISP_REVISION);
-	dev_info(isp->dev, "Revision %d.%d found\n",
-		 (isp->revision & 0xf0) >> 4, isp->revision & 0x0f);
-
 	for (m = 0; m < ARRAY_SIZE(isp_res_maps); m++)
 		if (isp->revision == isp_res_maps[m].isp_rev)
 			break;
-- 
Regards,

Laurent Pinchart

