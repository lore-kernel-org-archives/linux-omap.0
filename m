From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 4/4] ASoC: OMAP4: McPDM: Convert to hwmod/omap_device
Date: Tue, 2 Aug 2011 14:34:17 +0300
Message-ID: <1312284857-1774-5-git-send-email-peter.ujfalusi@ti.com>
References: <1312284857-1774-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51875 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753566Ab1HBLef (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 2 Aug 2011 07:34:35 -0400
In-Reply-To: <1312284857-1774-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, Misael Lopez Cruz <misael.lopez@ti.com>, Benoit Cousson <b-cousson@ti.com>, Sebastien Guiriec <s-guiriec@ti.com>

In order to probe, and operate correctly, the OMAP McPDM driver needs to
be converted to use hwmod.
The device name has been changed to probe the driver.
Replace the clk_* with pm_runtime_* calls to manage the clocks correctly.
Missing request_mem_region/release_mem_region added.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/mcpdm.c      |   38 +++++++++++++++++++++-----------------
 sound/soc/omap/mcpdm.h      |    1 -
 sound/soc/omap/omap-mcpdm.c |    2 +-
 sound/soc/omap/sdp4430.c    |    2 +-
 4 files changed, 23 insertions(+), 20 deletions(-)

diff --git a/sound/soc/omap/mcpdm.c b/sound/soc/omap/mcpdm.c
index 928f037..d29cc98 100644
--- a/sound/soc/omap/mcpdm.c
+++ b/sound/soc/omap/mcpdm.c
@@ -28,7 +28,7 @@
 #include <linux/slab.h>
 #include <linux/interrupt.h>
 #include <linux/err.h>
-#include <linux/clk.h>
+#include <linux/pm_runtime.h>
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/irq.h>
@@ -322,11 +322,11 @@ static irqreturn_t omap_mcpdm_irq_handler(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-int omap_mcpdm_request(void)
+			int omap_mcpdm_request(void)
 {
 	int ret;
 
-	clk_enable(mcpdm->clk);
+	pm_runtime_get_sync(mcpdm->dev);
 
 	spin_lock(&mcpdm->lock);
 
@@ -353,7 +353,8 @@ int omap_mcpdm_request(void)
 	return 0;
 
 err:
-	clk_disable(mcpdm->clk);
+	mcpdm->free = 1;
+	pm_runtime_put_sync(mcpdm->dev);
 	return ret;
 }
 
@@ -368,7 +369,7 @@ void omap_mcpdm_free(void)
 	mcpdm->free = 1;
 	spin_unlock(&mcpdm->lock);
 
-	clk_disable(mcpdm->clk);
+	pm_runtime_put_sync(mcpdm->dev);
 
 	free_irq(mcpdm->irq, (void *)mcpdm);
 }
@@ -421,28 +422,29 @@ int __devinit omap_mcpdm_probe(struct platform_device *pdev)
 
 	spin_lock_init(&mcpdm->lock);
 	mcpdm->free = 1;
+
+	if (!request_mem_region(res->start, resource_size(res), "McPDM")) {
+		ret = -EBUSY;
+		goto err_resource;
+	}
+
 	mcpdm->io_base = ioremap(res->start, resource_size(res));
 	if (!mcpdm->io_base) {
 		ret = -ENOMEM;
-		goto err_resource;
+		goto err_remap;
 	}
 
 	mcpdm->irq = platform_get_irq(pdev, 0);
 
-	mcpdm->clk = clk_get(&pdev->dev, "pdm_ck");
-	if (IS_ERR(mcpdm->clk)) {
-		ret = PTR_ERR(mcpdm->clk);
-		dev_err(&pdev->dev, "unable to get pdm_ck: %d\n", ret);
-		goto err_clk;
-	}
-
 	mcpdm->dev = &pdev->dev;
 	platform_set_drvdata(pdev, mcpdm);
 
+	pm_runtime_enable(mcpdm->dev);
+
 	return 0;
 
-err_clk:
-	iounmap(mcpdm->io_base);
+err_remap:
+	release_mem_region(res->start, resource_size(res));
 err_resource:
 	kfree(mcpdm);
 exit:
@@ -452,14 +454,16 @@ exit:
 int __devexit omap_mcpdm_remove(struct platform_device *pdev)
 {
 	struct omap_mcpdm *mcpdm_ptr = platform_get_drvdata(pdev);
+	struct resource *res;
 
 	platform_set_drvdata(pdev, NULL);
 
-	clk_put(mcpdm_ptr->clk);
+	pm_runtime_disable(mcpdm_ptr->dev);
 
 	iounmap(mcpdm_ptr->io_base);
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	release_mem_region(res->start, resource_size(res));
 
-	mcpdm_ptr->clk = NULL;
 	mcpdm_ptr->free = 0;
 	mcpdm_ptr->dev = NULL;
 
diff --git a/sound/soc/omap/mcpdm.h b/sound/soc/omap/mcpdm.h
index df3e16f..b055ad1 100644
--- a/sound/soc/omap/mcpdm.h
+++ b/sound/soc/omap/mcpdm.h
@@ -131,7 +131,6 @@ struct omap_mcpdm {
 
        spinlock_t lock;
        struct omap_mcpdm_platform_data *pdata;
-       struct clk *clk;
        struct omap_mcpdm_link *downlink;
        struct omap_mcpdm_link *uplink;
        struct completion irq_completion;
diff --git a/sound/soc/omap/omap-mcpdm.c b/sound/soc/omap/omap-mcpdm.c
index 7727de0..0820b9e 100644
--- a/sound/soc/omap/omap-mcpdm.c
+++ b/sound/soc/omap/omap-mcpdm.c
@@ -254,7 +254,7 @@ static int __devexit asoc_mcpdm_remove(struct platform_device *pdev)
 
 static struct platform_driver asoc_mcpdm_driver = {
 	.driver = {
-			.name = "omap-mcpdm-dai",
+			.name = "omap-mcpdm",
 			.owner = THIS_MODULE,
 	},
 
diff --git a/sound/soc/omap/sdp4430.c b/sound/soc/omap/sdp4430.c
index 7b18ef8..eec77fe 100644
--- a/sound/soc/omap/sdp4430.c
+++ b/sound/soc/omap/sdp4430.c
@@ -165,7 +165,7 @@ static int sdp4430_twl6040_init(struct snd_soc_pcm_runtime *rtd)
 static struct snd_soc_dai_link sdp4430_dai = {
 	.name = "TWL6040",
 	.stream_name = "TWL6040",
-	.cpu_dai_name ="omap-mcpdm-dai",
+	.cpu_dai_name = "omap-mcpdm",
 	.codec_dai_name = "twl6040-hifi",
 	.platform_name = "omap-pcm-audio",
 	.codec_name = "twl6040-codec",
-- 
1.7.6

