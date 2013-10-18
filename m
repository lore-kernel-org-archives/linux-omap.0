From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH v5 07/12] ASoC: davinci-mcasp: Remove redundant num-serializer DT parameter
Date: Fri, 18 Oct 2013 18:37:46 +0300
Message-ID: <1a9937bd0cad470b43e41a7fc537b354e2795535.1382110090.git.jsarha@ti.com>
References: <cover.1382110089.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33704 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756276Ab3JRPiO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 Oct 2013 11:38:14 -0400
In-Reply-To: <cover.1382110089.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, bcousson@baylibre.com, mark.rutland@arm.com
Cc: linux-omap@vger.kernel.org, broonie@kernel.org, joelf@ti.com, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jyri Sarha <jsarha@ti.com>

From: Peter Ujfalusi <peter.ujfalusi@ti.com>

The serial-dir array gives this information so there is no need to have the
num-serializer property in DT description.
Just ignore the property in the driver the DTS files can be updated
separately without regression.
Update the documentation at the same time for davinci-mcasp

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 .../bindings/sound/davinci-mcasp-audio.txt         |    1 -
 sound/soc/davinci/davinci-mcasp.c                  |   22 +++++---------------
 2 files changed, 5 insertions(+), 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt b/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
index b925bf9..0aa416b 100644
--- a/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
+++ b/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
@@ -49,7 +49,6 @@ mcasp0: mcasp0@1d00000 {
 	interrupts-names = "tx", "rx";
 	op-mode = <0>;		/* MCASP_IIS_MODE */
 	tdm-slots = <2>;
-	num-serializer = <16>;
 	serial-dir = <
 			0 0 0 0	/* 0: INACTIVE, 1: TX, 2: RX */
 			0 0 0 0
diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 08cceaf..8869cac 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -1050,7 +1050,6 @@ static struct snd_platform_data *davinci_mcasp_set_pdata_from_of(
 	struct of_phandle_args dma_spec;
 
 	const u32 *of_serial_dir32;
-	u8 *of_serial_dir;
 	u32 val;
 	int i, ret = 0;
 
@@ -1081,32 +1080,21 @@ static struct snd_platform_data *davinci_mcasp_set_pdata_from_of(
 		pdata->tdm_slots = val;
 	}
 
-	ret = of_property_read_u32(np, "num-serializer", &val);
-	if (ret >= 0)
-		pdata->num_serializer = val;
-
 	of_serial_dir32 = of_get_property(np, "serial-dir", &val);
 	val /= sizeof(u32);
-	if (val != pdata->num_serializer) {
-		dev_err(&pdev->dev,
-				"num-serializer(%d) != serial-dir size(%d)\n",
-				pdata->num_serializer, val);
-		ret = -EINVAL;
-		goto nodata;
-	}
-
 	if (of_serial_dir32) {
-		of_serial_dir = devm_kzalloc(&pdev->dev,
-						(sizeof(*of_serial_dir) * val),
-						GFP_KERNEL);
+		u8 *of_serial_dir = devm_kzalloc(&pdev->dev,
+						 (sizeof(*of_serial_dir) * val),
+						 GFP_KERNEL);
 		if (!of_serial_dir) {
 			ret = -ENOMEM;
 			goto nodata;
 		}
 
-		for (i = 0; i < pdata->num_serializer; i++)
+		for (i = 0; i < val; i++)
 			of_serial_dir[i] = be32_to_cpup(&of_serial_dir32[i]);
 
+		pdata->num_serializer = val;
 		pdata->serial_dir = of_serial_dir;
 	}
 
-- 
1.7.9.5

