From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH for 4.8] Revert "ASoC: omap-mcpdm: Add support
	for pdmclk clock handling"
Date: Thu, 18 Aug 2016 14:00:59 +0300
Message-ID: <20160818110059.13457-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This reverts commit 65aca64d05b5eaa5ce15e18b458a8d338ddbd478.

The patches for twl6040 MFD and clk missed the merge window and
causing the McPDM driver to never probe since it is put back to
the deferred list because the missing drivers.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
Mark,

OMAP4/5 audio regressed in 4.8 due to the hack that the twl6040 MFD and clk
driver changes were not take in time.
The only clean solution I can think is to revert the pdmclk clock handling
from the McPDM driver for now.

Regards,
Peter

 Documentation/devicetree/bindings/sound/omap-mcpdm.txt | 10 ----------
 sound/soc/omap/omap-mcpdm.c                            | 17 -----------------
 2 files changed, 27 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/omap-mcpdm.txt b/Documentation/devicetree/bindings/sound/omap-mcpdm.txt
index 6f6c2f8e908d..0741dff048dd 100644
--- a/Documentation/devicetree/bindings/sound/omap-mcpdm.txt
+++ b/Documentation/devicetree/bindings/sound/omap-mcpdm.txt
@@ -8,8 +8,6 @@ Required properties:
 - interrupts: Interrupt number for McPDM
 - interrupt-parent: The parent interrupt controller
 - ti,hwmods: Name of the hwmod associated to the McPDM
-- clocks:  phandle for the pdmclk provider, likely <&twl6040>
-- clock-names: Must be "pdmclk"

 Example:

@@ -21,11 +19,3 @@ mcpdm: mcpdm@40132000 {
 	interrupt-parent = <&gic>;
 	ti,hwmods = "mcpdm";
 };
-
-In board DTS file the pdmclk needs to be added:
-
-&mcpdm {
-	clocks = <&twl6040>;
-	clock-names = "pdmclk";
-	status = "okay";
-};
diff --git a/sound/soc/omap/omap-mcpdm.c b/sound/soc/omap/omap-mcpdm.c
index e7cdc51fd806..74d6e6fdcfd0 100644
--- a/sound/soc/omap/omap-mcpdm.c
+++ b/sound/soc/omap/omap-mcpdm.c
@@ -31,7 +31,6 @@
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/irq.h>
-#include <linux/clk.h>
 #include <linux/slab.h>
 #include <linux/pm_runtime.h>
 #include <linux/of_device.h>
@@ -55,7 +54,6 @@ struct omap_mcpdm {
 	unsigned long phys_base;
 	void __iomem *io_base;
 	int irq;
-	struct clk *pdmclk;

 	struct mutex mutex;

@@ -390,7 +388,6 @@ static int omap_mcpdm_probe(struct snd_soc_dai *dai)
 	struct omap_mcpdm *mcpdm = snd_soc_dai_get_drvdata(dai);
 	int ret;

-	clk_prepare_enable(mcpdm->pdmclk);
 	pm_runtime_enable(mcpdm->dev);

 	/* Disable lines while request is ongoing */
@@ -425,7 +422,6 @@ static int omap_mcpdm_remove(struct snd_soc_dai *dai)

 	pm_runtime_disable(mcpdm->dev);

-	clk_disable_unprepare(mcpdm->pdmclk);
 	return 0;
 }

@@ -445,8 +441,6 @@ static int omap_mcpdm_suspend(struct snd_soc_dai *dai)
 		mcpdm->pm_active_count++;
 	}

-	clk_disable_unprepare(mcpdm->pdmclk);
-
 	return 0;
 }

@@ -454,8 +448,6 @@ static int omap_mcpdm_resume(struct snd_soc_dai *dai)
 {
 	struct omap_mcpdm *mcpdm = snd_soc_dai_get_drvdata(dai);

-	clk_prepare_enable(mcpdm->pdmclk);
-
 	if (mcpdm->pm_active_count) {
 		while (mcpdm->pm_active_count--)
 			pm_runtime_get_sync(mcpdm->dev);
@@ -549,15 +541,6 @@ static int asoc_mcpdm_probe(struct platform_device *pdev)

 	mcpdm->dev = &pdev->dev;

-	mcpdm->pdmclk = devm_clk_get(&pdev->dev, "pdmclk");
-	if (IS_ERR(mcpdm->pdmclk)) {
-		if (PTR_ERR(mcpdm->pdmclk) == -EPROBE_DEFER)
-			return -EPROBE_DEFER;
-		dev_warn(&pdev->dev, "Error getting pdmclk (%ld)!\n",
-			 PTR_ERR(mcpdm->pdmclk));
-		mcpdm->pdmclk = NULL;
-	}
-
 	ret =  devm_snd_soc_register_component(&pdev->dev,
 					       &omap_mcpdm_component,
 					       &omap_mcpdm_dai, 1);
--
2.9.2
