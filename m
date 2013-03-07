From: Sebastien Guiriec <s-guiriec@ti.com>
Subject: [PATCH 4/5] ASoC: omap-mcbsp:Update driver for DMA DT binding.
Date: Thu, 7 Mar 2013 13:43:23 +0100
Message-ID: <1362660204-27074-5-git-send-email-s-guiriec@ti.com>
References: <1362660204-27074-1-git-send-email-s-guiriec@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52384 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754827Ab3CGMoS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 7 Mar 2013 07:44:18 -0500
In-Reply-To: <1362660204-27074-1-git-send-email-s-guiriec@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastien Guiriec <s-guiriec@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <b-cousson@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, alsa-devel@alsa-project.org

Update the driver in order to use OMAP DMA DT binding instead of
hwmod data for DT boot.

Signed-off-by: Sebastien Guiriec <s-guiriec@ti.com>
---
 sound/soc/omap/mcbsp.c |   26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/sound/soc/omap/mcbsp.c b/sound/soc/omap/mcbsp.c
index 285c836..16936493 100644
--- a/sound/soc/omap/mcbsp.c
+++ b/sound/soc/omap/mcbsp.c
@@ -1012,24 +1012,30 @@ int omap_mcbsp_init(struct platform_device *pdev)
 		}
 	}
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "rx");
-	if (!res) {
-		dev_err(&pdev->dev, "invalid rx DMA channel\n");
-		return -ENODEV;
+	if (!pdev->dev.of_node) {
+		res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "rx");
+		if (!res) {
+			dev_err(&pdev->dev, "invalid rx DMA channel\n");
+			return -ENODEV;
+		}
+		mcbsp->dma_data[1].dma_req = res->start;
 	}
 	/* RX DMA request number, and port address configuration */
 	mcbsp->dma_data[1].name = "Audio Capture";
-	mcbsp->dma_data[1].dma_req = res->start;
+	mcbsp->dma_data[1].dma_name = "rx";
 	mcbsp->dma_data[1].port_addr = omap_mcbsp_dma_reg_params(mcbsp, 1);
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "tx");
-	if (!res) {
-		dev_err(&pdev->dev, "invalid tx DMA channel\n");
-		return -ENODEV;
+	if (!pdev->dev.of_node) {
+		res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "tx");
+		if (!res) {
+			dev_err(&pdev->dev, "invalid tx DMA channel\n");
+			return -ENODEV;
+		}
+		mcbsp->dma_data[0].dma_req = res->start;
 	}
 	/* TX DMA request number, and port address configuration */
 	mcbsp->dma_data[0].name = "Audio Playback";
-	mcbsp->dma_data[0].dma_req = res->start;
+	mcbsp->dma_data[0].dma_name = "tx";
 	mcbsp->dma_data[0].port_addr = omap_mcbsp_dma_reg_params(mcbsp, 0);
 
 	mcbsp->fclk = clk_get(&pdev->dev, "fck");
-- 
1.7.10.4

