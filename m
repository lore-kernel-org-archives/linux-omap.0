From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 07/11] ASoC: omap-mcpdm: Use platform_get_resource_* to get resources
Date: Wed, 12 Sep 2012 14:47:03 +0300
Message-ID: <1347450427-27627-8-git-send-email-peter.ujfalusi@ti.com>
References: <1347450427-27627-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:42663 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756101Ab2ILLrE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 12 Sep 2012 07:47:04 -0400
Received: by obbuo13 with SMTP id uo13so2442477obb.19
        for <linux-omap@vger.kernel.org>; Wed, 12 Sep 2012 04:47:02 -0700 (PDT)
In-Reply-To: <1347450427-27627-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <djbw@fb.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Ricardo Neri <ricardo.neri@ti.com>

Get the needed resources in a correct way and avoid using defines for them.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/omap-mcpdm.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/sound/soc/omap/omap-mcpdm.c b/sound/soc/omap/omap-mcpdm.c
index baf92da..36648e0 100644
--- a/sound/soc/omap/omap-mcpdm.c
+++ b/sound/soc/omap/omap-mcpdm.c
@@ -41,7 +41,6 @@
 #include <sound/soc.h>
 
 #include <plat/dma.h>
-#include <plat/omap_hwmod.h>
 #include "omap-mcpdm.h"
 #include "omap-pcm.h"
 
@@ -71,15 +70,11 @@ struct omap_mcpdm {
 static struct omap_pcm_dma_data omap_mcpdm_dai_dma_params[] = {
 	{
 		.name = "Audio playback",
-		.dma_req = OMAP44XX_DMA_MCPDM_DL,
 		.data_type = OMAP_DMA_DATA_TYPE_S32,
-		.port_addr = OMAP44XX_MCPDM_L3_BASE + MCPDM_REG_DN_DATA,
 	},
 	{
 		.name = "Audio capture",
-		.dma_req = OMAP44XX_DMA_MCPDM_UP,
 		.data_type = OMAP_DMA_DATA_TYPE_S32,
-		.port_addr = OMAP44XX_MCPDM_L3_BASE + MCPDM_REG_UP_DATA,
 	},
 };
 
@@ -452,10 +447,33 @@ static __devinit int asoc_mcpdm_probe(struct platform_device *pdev)
 
 	mutex_init(&mcpdm->mutex);
 
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dma");
+	if (res == NULL)
+		return -ENOMEM;
+
+	omap_mcpdm_dai_dma_params[0].port_addr = res->start + MCPDM_REG_DN_DATA;
+	omap_mcpdm_dai_dma_params[1].port_addr = res->start + MCPDM_REG_UP_DATA;
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (res == NULL)
 		return -ENOMEM;
 
+	res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "dn_link");
+	if (!res)
+		return -ENODEV;
+
+	omap_mcpdm_dai_dma_params[0].dma_req = res->start;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "up_link");
+	if (!res)
+		return -ENODEV;
+
+	omap_mcpdm_dai_dma_params[1].dma_req = res->start;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "mpu");
+	if (res == NULL)
+		return -ENOMEM;
+
 	if (!devm_request_mem_region(&pdev->dev, res->start,
 				     resource_size(res), "McPDM"))
 		return -EBUSY;
-- 
1.7.12

