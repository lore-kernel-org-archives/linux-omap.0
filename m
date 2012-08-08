From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 11/11] ASoC: omap-mcbsp: Add device tree bindings
Date: Wed,  8 Aug 2012 12:11:41 +0300
Message-ID: <1344417101-5015-12-git-send-email-peter.ujfalusi@ti.com>
References: <1344417101-5015-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:49389 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932502Ab2HHJMd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Aug 2012 05:12:33 -0400
Received: by ghbg2 with SMTP id g2so462920ghb.10
        for <linux-omap@vger.kernel.org>; Wed, 08 Aug 2012 02:12:32 -0700 (PDT)
In-Reply-To: <1344417101-5015-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, Benoit Cousson <b-cousson@ti.com>

Device tree support for McBSP modules on OMAP2+ SoC.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 .../devicetree/bindings/sound/omap-mcbsp.txt       |   45 +++++++++++++
 sound/soc/omap/omap-mcbsp.c                        |   66 +++++++++++++++++++-
 2 files changed, 110 insertions(+), 1 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/omap-mcbsp.txt

diff --git a/Documentation/devicetree/bindings/sound/omap-mcbsp.txt b/Documentation/devicetree/bindings/sound/omap-mcbsp.txt
new file mode 100644
index 0000000..447cb13
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/omap-mcbsp.txt
@@ -0,0 +1,45 @@
+* Texas Instruments OMAP2+ McBSP module
+
+Required properties:
+- compatible: "ti,omap2420-mcbsp" for McBSP on OMAP2420
+	      "ti,omap2430-mcbsp" for McBSP on OMAP2430
+	      "ti,omap3-mcbsp" for McBSP on OMAP3
+	      "ti,omap4-mcbsp" for McBSP on OMAP4 and newer SoC
+- reg: Register location and size, for OMAP4+ as an array:
+       <MPU access base address, size>,
+       <L3 interconnect address, size>;
+- interrupts: Interrupt numbers for the McBSP port, as an array in case the
+	      McBSP IP have more interrupt lines:
+	<OCP compliant irq>,
+	<TX irq>,
+	<RX irq>;
+- interrupt-parent: The parent interrupt controller
+- ti,buffer-size: Size of the FIFO on the port (OMAP2430 and newer SoC)
+- ti,hwmods: Name of the hwmod associated to the McBSP port
+
+Sidetone support for OMAP3 McBSP2 and 3 ports:
+- sidetone { }: Within this section the following parameters are required:
+- reg: Register location and size for the ST block
+- interrupts: The interrupt number for the ST block
+- interrupt-parent: The parent interrupt controller for the ST block
+
+Example:
+
+mcbsp2: mcbsp@49022000 {
+	compatible = "ti,omap3-mcbsp";
+	#address-cells = <1>;
+	#size-cells = <1>;
+	reg = <0x49022000 0xff>;
+	interrupts = <0 17 0x4>, /* OCP compliant interrup */
+		     <0 62 0x4>, /* TX interrup */
+		     <0 63 0x4>; /* RX interrup */
+	interrupt-parent = <&intc>;
+	ti,buffer-size = <1280>;
+	ti,hwmods = "mcbsp2";
+
+	sidetone {
+		reg = <0x49028000 0xff>;
+		interrupts = <0 4 0x4>;
+		interrupt-parent = <&intc>;
+	};
+};
diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index b9770ee..2e1750e 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -26,6 +26,8 @@
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/pm_runtime.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -737,13 +739,74 @@ int omap_mcbsp_st_add_controls(struct snd_soc_pcm_runtime *rtd)
 }
 EXPORT_SYMBOL_GPL(omap_mcbsp_st_add_controls);
 
+static struct omap_mcbsp_platform_data omap2420_pdata = {
+	.reg_step = 4,
+	.reg_size = 2,
+};
+
+static struct omap_mcbsp_platform_data omap2430_pdata = {
+	.reg_step = 4,
+	.reg_size = 4,
+	.has_ccr = true,
+};
+
+static struct omap_mcbsp_platform_data omap3_pdata = {
+	.reg_step = 4,
+	.reg_size = 4,
+	.has_ccr = true,
+	.has_wakeup = true,
+};
+
+static struct omap_mcbsp_platform_data omap4_pdata = {
+	.reg_step = 4,
+	.reg_size = 4,
+	.has_ccr = true,
+	.has_wakeup = true,
+};
+
+static const struct of_device_id omap_mcbsp_of_match[] = {
+	{
+		.compatible = "ti,omap2420-mcbsp",
+		.data = &omap2420_pdata,
+	},
+	{
+		.compatible = "ti,omap2430-mcbsp",
+		.data = &omap2430_pdata,
+	},
+	{
+		.compatible = "ti,omap3-mcbsp",
+		.data = &omap3_pdata,
+	},
+	{
+		.compatible = "ti,omap4-mcbsp",
+		.data = &omap4_pdata,
+	},
+	{ },
+};
+MODULE_DEVICE_TABLE(of, omap_mcbsp_of_match);
+
 static __devinit int asoc_mcbsp_probe(struct platform_device *pdev)
 {
 	struct omap_mcbsp_platform_data *pdata = dev_get_platdata(&pdev->dev);
 	struct omap_mcbsp *mcbsp;
+	const struct of_device_id *match;
 	int ret;
 
-	if (!pdata) {
+	match = of_match_device(omap_mcbsp_of_match, &pdev->dev);
+	if (match) {
+		struct device_node *node = pdev->dev.of_node;
+		int buffer_size;
+
+		pdata = devm_kzalloc(&pdev->dev,
+				     sizeof(struct omap_mcbsp_platform_data),
+				     GFP_KERNEL);
+		if (!pdata)
+			return -ENOMEM;
+
+		memcpy(pdata, match->data, sizeof(*pdata));
+		if (!of_property_read_u32(node, "ti,buffer-size", &buffer_size))
+			pdata->buffer_size = buffer_size;
+	} else if (!pdata) {
 		dev_err(&pdev->dev, "missing platform data.\n");
 		return -EINVAL;
 	}
@@ -785,6 +848,7 @@ static struct platform_driver asoc_mcbsp_driver = {
 	.driver = {
 			.name = "omap-mcbsp",
 			.owner = THIS_MODULE,
+			.of_match_table = omap_mcbsp_of_match,
 	},
 
 	.probe = asoc_mcbsp_probe,
-- 
1.7.8.6

