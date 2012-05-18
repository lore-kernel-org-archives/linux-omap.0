From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH 03/11] ASoC: OMAP: HDMI: Change error values in HDMI CPU DAI
Date: Fri, 18 May 2012 01:42:35 -0500
Message-ID: <1337323363-11449-4-git-send-email-ricardo.neri@ti.com>
References: <1337323363-11449-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47746 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752969Ab2ERGnV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 May 2012 02:43:21 -0400
In-Reply-To: <1337323363-11449-1-git-send-email-ricardo.neri@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: broonie@opensource.wolfsonmicro.com, lrg@ti.com
Cc: x0055901@ti.com, peter.ujfalusi@ti.com, s-guiriec@ti.com, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, Ricardo Neri <ricardo.neri@ti.com>

When getting the needed resources fails, return -ENODEV. This is more
in line with other drivers do and it gives a more descriptive error.

Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
---
 sound/soc/omap/omap-hdmi.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/omap/omap-hdmi.c b/sound/soc/omap/omap-hdmi.c
index 0925a46..b889f76 100644
--- a/sound/soc/omap/omap-hdmi.c
+++ b/sound/soc/omap/omap-hdmi.c
@@ -106,7 +106,7 @@ static __devinit int omap_hdmi_probe(struct platform_device *pdev)
 	hdmi_rsrc = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!hdmi_rsrc) {
 		dev_err(&pdev->dev, "Cannot obtain IORESOURCE_MEM HDMI\n");
-		return -EINVAL;
+		return -ENODEV;
 	}
 
 	omap_hdmi_dai_dma_params.port_addr =  hdmi_rsrc->start
@@ -115,7 +115,7 @@ static __devinit int omap_hdmi_probe(struct platform_device *pdev)
 	hdmi_rsrc = platform_get_resource(pdev, IORESOURCE_DMA, 0);
 	if (!hdmi_rsrc) {
 		dev_err(&pdev->dev, "Cannot obtain IORESOURCE_DMA HDMI\n");
-		return -EINVAL;
+		return -ENODEV;
 	}
 
 	omap_hdmi_dai_dma_params.dma_req =  hdmi_rsrc->start;
-- 
1.7.5.4

