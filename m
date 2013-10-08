From: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v4 06/10] ASoC: davinci-mcasp: Remove redundant num-serializer DT parameter
Date: Tue, 8 Oct 2013 22:36:37 +0300
Message-ID: <bcfa680b7d3a5833a1ce55d4ec0bf4f9f14286e3.1381259962.git.jsarha@ti.com>
References: <cover.1381259962.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1381259962.git.jsarha-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, joelf-l0cyMroinI0@public.gmane.org, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>

The serial-dir array gives this information so there is no need to have the
num-serializer property in DT description.
Just ignore the property in the driver the DTS files can be updated
separately without regression.
Update the documentation at the same time for davinci-mcasp

Signed-off-by: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Signed-off-by: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
---
 .../bindings/sound/davinci-mcasp-audio.txt         |    1 -
 sound/soc/davinci/davinci-mcasp.c                  |   22 +++++---------------
 2 files changed, 5 insertions(+), 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt b/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
index ab2af66..b350cd9 100644
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
index 2583802..03a1199 100644
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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
