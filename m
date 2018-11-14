From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 2/2] ASoC: omap-mcpdm: Add support for pdmclk
	clock handling
Date: Wed, 14 Nov 2018 14:46:31 +0200
Message-ID: <20181114124631.4586-3-peter.ujfalusi@ti.com>
References: <20181114124631.4586-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20181114124631.4586-1-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, jarkko.nikula@bitmer.com
Cc: tony@atomide.com, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

McPDM module receives it's functional clock from external source. This
clock is the pdmclk provided by the twl6040 audio IC. If the clock is not
available all register accesses to McPDM fails and the module is not
operational.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/omap-mcpdm.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/sound/soc/omap/omap-mcpdm.c b/sound/soc/omap/omap-mcpdm.c
index 7d5bdc5a2890..ee9101ab4343 100644
--- a/sound/soc/omap/omap-mcpdm.c
+++ b/sound/soc/omap/omap-mcpdm.c
@@ -31,6 +31,7 @@
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/irq.h>
+#include <linux/clk.h>
 #include <linux/slab.h>
 #include <linux/pm_runtime.h>
 #include <linux/of_device.h>
@@ -56,6 +57,7 @@ struct omap_mcpdm {
 	int irq;
 	struct pm_qos_request pm_qos_req;
 	int latency[2];
+	struct clk *pdmclk;
 
 	struct mutex mutex;
 
@@ -430,6 +432,10 @@ static int omap_mcpdm_probe(struct snd_soc_dai *dai)
 	struct omap_mcpdm *mcpdm = snd_soc_dai_get_drvdata(dai);
 	int ret;
 
+	ret = clk_prepare_enable(mcpdm->pdmclk);
+	if (ret)
+		return ret;
+
 	pm_runtime_enable(mcpdm->dev);
 
 	/* Disable lines while request is ongoing */
@@ -468,6 +474,7 @@ static int omap_mcpdm_remove(struct snd_soc_dai *dai)
 	if (pm_qos_request_active(&mcpdm->pm_qos_req))
 		pm_qos_remove_request(&mcpdm->pm_qos_req);
 
+	clk_disable_unprepare(mcpdm->pdmclk);
 	return 0;
 }
 
@@ -487,12 +494,19 @@ static int omap_mcpdm_suspend(struct snd_soc_dai *dai)
 		mcpdm->pm_active_count++;
 	}
 
+	clk_disable_unprepare(mcpdm->pdmclk);
+
 	return 0;
 }
 
 static int omap_mcpdm_resume(struct snd_soc_dai *dai)
 {
 	struct omap_mcpdm *mcpdm = snd_soc_dai_get_drvdata(dai);
+	int ret;
+
+	ret = clk_prepare_enable(mcpdm->pdmclk);
+	if (ret)
+		return ret;
 
 	if (mcpdm->pm_active_count) {
 		while (mcpdm->pm_active_count--)
@@ -587,6 +601,15 @@ static int asoc_mcpdm_probe(struct platform_device *pdev)
 
 	mcpdm->dev = &pdev->dev;
 
+	mcpdm->pdmclk = devm_clk_get(&pdev->dev, "pdmclk");
+	if (IS_ERR(mcpdm->pdmclk)) {
+		if (PTR_ERR(mcpdm->pdmclk) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+		dev_warn(&pdev->dev, "Error getting pdmclk (%ld)!\n",
+			 PTR_ERR(mcpdm->pdmclk));
+		mcpdm->pdmclk = NULL;
+	}
+
 	ret =  devm_snd_soc_register_component(&pdev->dev,
 					       &omap_mcpdm_component,
 					       &omap_mcpdm_dai, 1);
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
