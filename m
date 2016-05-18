From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 14/14] ASoC: omap-mcpdm: Add support for pdmclk clock handling
Date: Wed, 18 May 2016 16:46:36 +0300
Message-ID: <1463579196-5484-15-git-send-email-peter.ujfalusi@ti.com>
References: <1463579196-5484-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1463579196-5484-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: mturquette@baylibre.com, sboyd@codeaurora.org, tony@atomide.com, lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com, broonie@kernel.org
Cc: t-kristo@ti.com, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org
List-Id: linux-omap@vger.kernel.org

McPDM module receives it's functional clock from external source. This
clock is the pdmclk provided by the twl6040 audio IC. If the clock is not
available all register accesses to McPDM fails and the module is not
operational.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 Documentation/devicetree/bindings/sound/omap-mcpdm.txt | 10 ++++++++++
 sound/soc/omap/omap-mcpdm.c                            | 17 +++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/omap-mcpdm.txt b/Documentation/devicetree/bindings/sound/omap-mcpdm.txt
index 0741dff048dd..6f6c2f8e908d 100644
--- a/Documentation/devicetree/bindings/sound/omap-mcpdm.txt
+++ b/Documentation/devicetree/bindings/sound/omap-mcpdm.txt
@@ -8,6 +8,8 @@ Required properties:
 - interrupts: Interrupt number for McPDM
 - interrupt-parent: The parent interrupt controller
 - ti,hwmods: Name of the hwmod associated to the McPDM
+- clocks:  phandle for the pdmclk provider, likely <&twl6040>
+- clock-names: Must be "pdmclk"
 
 Example:
 
@@ -19,3 +21,11 @@ mcpdm: mcpdm@40132000 {
 	interrupt-parent = <&gic>;
 	ti,hwmods = "mcpdm";
 };
+
+In board DTS file the pdmclk needs to be added:
+
+&mcpdm {
+	clocks = <&twl6040>;
+	clock-names = "pdmclk";
+	status = "okay";
+};
diff --git a/sound/soc/omap/omap-mcpdm.c b/sound/soc/omap/omap-mcpdm.c
index 74d6e6fdcfd0..e7cdc51fd806 100644
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
@@ -54,6 +55,7 @@ struct omap_mcpdm {
 	unsigned long phys_base;
 	void __iomem *io_base;
 	int irq;
+	struct clk *pdmclk;
 
 	struct mutex mutex;
 
@@ -388,6 +390,7 @@ static int omap_mcpdm_probe(struct snd_soc_dai *dai)
 	struct omap_mcpdm *mcpdm = snd_soc_dai_get_drvdata(dai);
 	int ret;
 
+	clk_prepare_enable(mcpdm->pdmclk);
 	pm_runtime_enable(mcpdm->dev);
 
 	/* Disable lines while request is ongoing */
@@ -422,6 +425,7 @@ static int omap_mcpdm_remove(struct snd_soc_dai *dai)
 
 	pm_runtime_disable(mcpdm->dev);
 
+	clk_disable_unprepare(mcpdm->pdmclk);
 	return 0;
 }
 
@@ -441,6 +445,8 @@ static int omap_mcpdm_suspend(struct snd_soc_dai *dai)
 		mcpdm->pm_active_count++;
 	}
 
+	clk_disable_unprepare(mcpdm->pdmclk);
+
 	return 0;
 }
 
@@ -448,6 +454,8 @@ static int omap_mcpdm_resume(struct snd_soc_dai *dai)
 {
 	struct omap_mcpdm *mcpdm = snd_soc_dai_get_drvdata(dai);
 
+	clk_prepare_enable(mcpdm->pdmclk);
+
 	if (mcpdm->pm_active_count) {
 		while (mcpdm->pm_active_count--)
 			pm_runtime_get_sync(mcpdm->dev);
@@ -541,6 +549,15 @@ static int asoc_mcpdm_probe(struct platform_device *pdev)
 
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
2.8.2
