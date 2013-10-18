From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH v5 03/12] ASoC: davinci-mcasp: Add location for data port registers to DT
Date: Fri, 18 Oct 2013 18:37:42 +0300
Message-ID: <2d590a299670bb4f39251a95d7f4898034109bd7.1382110090.git.jsarha@ti.com>
References: <cover.1382110089.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37524 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756113Ab3JRPiI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Oct 2013 11:38:08 -0400
In-Reply-To: <cover.1382110089.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, bcousson@baylibre.com, mark.rutland@arm.com
Cc: linux-omap@vger.kernel.org, broonie@kernel.org, joelf@ti.com, Jyri Sarha <jsarha@ti.com>, "Hebbar, Gururaja" <gururaja.hebbar@ti.com>, Darren Etheridge <detheridge@ti.com>

This patch adds a separate register location for data port registers to
mcasp DT bindings. On am33xx SoCs the McASP registers are mapped
trough L4 interconnect, but data port registers are also mapped trough
L3 bus to a different memory location.

Signed-off-by: Hebbar, Gururaja <gururaja.hebbar@ti.com>
Signed-off-by: Darren Etheridge <detheridge@ti.com>
Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 .../bindings/sound/davinci-mcasp-audio.txt         |    8 ++-
 sound/soc/davinci/davinci-mcasp.c                  |   61 +++++++++++++-------
 2 files changed, 47 insertions(+), 22 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt b/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
index 374e145..c2ab869 100644
--- a/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
+++ b/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
@@ -6,7 +6,11 @@ Required properties:
 	"ti,da830-mcasp-audio"	: for both DA830 & DA850 platforms
 	"ti,omap2-mcasp-audio"	: for OMAP2 platforms (TI81xx, AM33xx)
 
-- reg : Should contain McASP registers offset and length
+- reg : Should contain reg specifiers for the entries in the reg-names property.
+- reg-names : Should contain:
+         * "mpu" for the main registers (required). For compatibility with
+           existing software, it is recommended this is the first entry.
+         * "dat" for separate data port register access (optional).
 - interrupts : Interrupt number for McASP
 - op-mode : I2S/DIT ops mode.
 - tdm-slots : Slots for TDM operation.
@@ -15,7 +19,6 @@ Required properties:
 		to "num-serializer" parameter. Each entry is a number indication
 		serializer pin direction. (0 - INACTIVE, 1 - TX, 2 - RX)
 
-
 Optional properties:
 
 - ti,hwmods : Must be "mcasp<n>", n is controller instance starting 0
@@ -31,6 +34,7 @@ mcasp0: mcasp0@1d00000 {
 	#address-cells = <1>;
 	#size-cells = <0>;
 	reg = <0x100000 0x3000>;
+	reg-names "mpu";
 	interrupts = <82 83>;
 	op-mode = <0>;		/* MCASP_IIS_MODE */
 	tdm-slots = <2>;
diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 32ddb7f..7fd37ff 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -1001,18 +1001,40 @@ static const struct snd_soc_component_driver davinci_mcasp_component = {
 	.name		= "davinci-mcasp",
 };
 
+/* Some HW specific values and defaults. The rest is filled in from DT. */
+static struct snd_platform_data dm646x_mcasp_pdata = {
+	.tx_dma_offset = 0x400,
+	.rx_dma_offset = 0x400,
+	.asp_chan_q = EVENTQ_0,
+	.version = MCASP_VERSION_1,
+};
+
+static struct snd_platform_data da830_mcasp_pdata = {
+	.tx_dma_offset = 0x2000,
+	.rx_dma_offset = 0x2000,
+	.asp_chan_q = EVENTQ_0,
+	.version = MCASP_VERSION_2,
+};
+
+static struct snd_platform_data omap2_mcasp_pdata = {
+	.tx_dma_offset = 0,
+	.rx_dma_offset = 0,
+	.asp_chan_q = EVENTQ_0,
+	.version = MCASP_VERSION_3,
+};
+
 static const struct of_device_id mcasp_dt_ids[] = {
 	{
 		.compatible = "ti,dm646x-mcasp-audio",
-		.data = (void *)MCASP_VERSION_1,
+		.data = &dm646x_mcasp_pdata,
 	},
 	{
 		.compatible = "ti,da830-mcasp-audio",
-		.data = (void *)MCASP_VERSION_2,
+		.data = &da830_mcasp_pdata,
 	},
 	{
 		.compatible = "ti,omap2-mcasp-audio",
-		.data = (void *)MCASP_VERSION_3,
+		.data = &omap2_mcasp_pdata,
 	},
 	{ /* sentinel */ }
 };
@@ -1035,20 +1057,13 @@ static struct snd_platform_data *davinci_mcasp_set_pdata_from_of(
 		pdata = pdev->dev.platform_data;
 		return pdata;
 	} else if (match) {
-		pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
-		if (!pdata) {
-			ret = -ENOMEM;
-			goto nodata;
-		}
+		pdata = (struct snd_platform_data *) match->data;
 	} else {
 		/* control shouldn't reach here. something is wrong */
 		ret = -EINVAL;
 		goto nodata;
 	}
 
-	if (match->data)
-		pdata->version = (u8)((int)match->data);
-
 	ret = of_property_read_u32(np, "op-mode", &val);
 	if (ret >= 0)
 		pdata->op_mode = val;
@@ -1124,7 +1139,7 @@ nodata:
 static int davinci_mcasp_probe(struct platform_device *pdev)
 {
 	struct davinci_pcm_dma_params *dma_data;
-	struct resource *mem, *ioarea, *res;
+	struct resource *mem, *ioarea, *res, *dat;
 	struct snd_platform_data *pdata;
 	struct davinci_audio_dev *dev;
 	int ret;
@@ -1145,10 +1160,15 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	mem = platform_get_resource_byname(pdev, IORESOURCE_MEM, "mpu");
 	if (!mem) {
-		dev_err(&pdev->dev, "no mem resource?\n");
-		return -ENODEV;
+		dev_warn(dev->dev,
+			 "\"mpu\" mem resource not found, using index 0\n");
+		mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+		if (!mem) {
+			dev_err(&pdev->dev, "no mem resource?\n");
+			return -ENODEV;
+		}
 	}
 
 	ioarea = devm_request_mem_region(&pdev->dev, mem->start,
@@ -1182,13 +1202,16 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 	dev->rxnumevt = pdata->rxnumevt;
 	dev->dev = &pdev->dev;
 
+	dat = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dat");
+	if (!dat)
+		dat = mem;
+
 	dma_data = &dev->dma_params[SNDRV_PCM_STREAM_PLAYBACK];
 	dma_data->asp_chan_q = pdata->asp_chan_q;
 	dma_data->ram_chan_q = pdata->ram_chan_q;
 	dma_data->sram_pool = pdata->sram_pool;
 	dma_data->sram_size = pdata->sram_size_playback;
-	dma_data->dma_addr = (dma_addr_t) (pdata->tx_dma_offset +
-							mem->start);
+	dma_data->dma_addr = dat->start + pdata->tx_dma_offset;
 
 	/* first TX, then RX */
 	res = platform_get_resource(pdev, IORESOURCE_DMA, 0);
@@ -1205,8 +1228,7 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 	dma_data->ram_chan_q = pdata->ram_chan_q;
 	dma_data->sram_pool = pdata->sram_pool;
 	dma_data->sram_size = pdata->sram_size_capture;
-	dma_data->dma_addr = (dma_addr_t)(pdata->rx_dma_offset +
-							mem->start);
+	dma_data->dma_addr = dat->start + pdata->rx_dma_offset;
 
 	res = platform_get_resource(pdev, IORESOURCE_DMA, 1);
 	if (!res) {
@@ -1266,4 +1288,3 @@ module_platform_driver(davinci_mcasp_driver);
 MODULE_AUTHOR("Steve Chen");
 MODULE_DESCRIPTION("TI DAVINCI McASP SoC Interface");
 MODULE_LICENSE("GPL");
-
-- 
1.7.9.5

