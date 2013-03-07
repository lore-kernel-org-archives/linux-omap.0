From: Sebastien Guiriec <s-guiriec@ti.com>
Subject: [PATCH 3/5] ASoC: omap-mcpdm: Update driver for DMA DT binding.
Date: Thu, 7 Mar 2013 13:43:22 +0100
Message-ID: <1362660204-27074-4-git-send-email-s-guiriec@ti.com>
References: <1362660204-27074-1-git-send-email-s-guiriec@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51413 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754030Ab3CGMoP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 7 Mar 2013 07:44:15 -0500
In-Reply-To: <1362660204-27074-1-git-send-email-s-guiriec@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastien Guiriec <s-guiriec@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <b-cousson@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, alsa-devel@alsa-project.org

Update the driver in order to use OMAP DMA DT binding instead of
hwmod data for DT boot.

Signed-off-by: Sebastien Guiriec <s-guiriec@ti.com>
---
 sound/soc/omap/omap-mcpdm.c |   22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/sound/soc/omap/omap-mcpdm.c b/sound/soc/omap/omap-mcpdm.c
index 5ca11bd..f41bac8 100644
--- a/sound/soc/omap/omap-mcpdm.c
+++ b/sound/soc/omap/omap-mcpdm.c
@@ -71,9 +71,11 @@ struct omap_mcpdm {
 static struct omap_pcm_dma_data omap_mcpdm_dai_dma_params[] = {
 	{
 		.name = "Audio playback",
+		.dma_name = "dn_link",
 	},
 	{
 		.name = "Audio capture",
+		.dma_name = "up_link",
 	},
 };
 
@@ -449,17 +451,21 @@ static int asoc_mcpdm_probe(struct platform_device *pdev)
 	omap_mcpdm_dai_dma_params[0].port_addr = res->start + MCPDM_REG_DN_DATA;
 	omap_mcpdm_dai_dma_params[1].port_addr = res->start + MCPDM_REG_UP_DATA;
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "dn_link");
-	if (!res)
-		return -ENODEV;
+	if (!pdev->dev.of_node) {
+		res = platform_get_resource_byname(pdev, IORESOURCE_DMA,
+						   "dn_link");
+		if (!res)
+			return -ENODEV;
 
-	omap_mcpdm_dai_dma_params[0].dma_req = res->start;
+		omap_mcpdm_dai_dma_params[0].dma_req = res->start;
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "up_link");
-	if (!res)
-		return -ENODEV;
+		res = platform_get_resource_byname(pdev, IORESOURCE_DMA,
+						   "up_link");
+		if (!res)
+			return -ENODEV;
 
-	omap_mcpdm_dai_dma_params[1].dma_req = res->start;
+		omap_mcpdm_dai_dma_params[1].dma_req = res->start;
+	}
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "mpu");
 	if (res == NULL)
-- 
1.7.10.4

