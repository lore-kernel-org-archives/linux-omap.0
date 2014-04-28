From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCHv2 8/9] ASoC: omap: rx51: Add DT support
Date: Mon, 28 Apr 2014 16:07:26 +0200
Message-ID: <1398694047-28596-9-git-send-email-sre@kernel.org>
References: <1398694047-28596-1-git-send-email-sre@kernel.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1398694047-28596-1-git-send-email-sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-GFxCN5SEZAc@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Cc: Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jarkko Nikula <jarkko.nikula-FVTvWyuFUl3QT0dZR+AlfA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

This patch adds device tree support to the Nokia N900 audio driver and
adds documentation for the DT binding.

Signed-off-by: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 .../devicetree/bindings/sound/nokia,rx51.txt       | 27 +++++++++++
 sound/soc/omap/rx51.c                              | 53 ++++++++++++++++++++++
 2 files changed, 80 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/nokia,rx51.txt

diff --git a/Documentation/devicetree/bindings/sound/nokia,rx51.txt b/Documentation/devicetree/bindings/sound/nokia,rx51.txt
new file mode 100644
index 0000000..72f93d9
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/nokia,rx51.txt
@@ -0,0 +1,27 @@
+* Nokia N900 audio setup
+
+Required properties:
+- compatible: Should contain "nokia,n900-audio"
+- nokia,cpu-dai: phandle for the McBSP node
+- nokia,audio-codec: phandles for the main TLV320AIC3X node and the
+                     auxiliary TLV320AIC3X node (in this order)
+- nokia,headphone-amplifier: phandle for the TPA6130A2 node
+- tvout-selection-gpios: GPIO for tvout selection
+- jack-detection-gpios: GPIO for jack detection
+- eci-switch-gpios: GPIO for ECI (Enhancement Control Interface) switch
+- speaker-amplifier-gpios: GPIO for speaker amplifier
+
+Example:
+
+sound {
+	compatible = "nokia,n900-audio";
+
+	nokia,cpu-dai = <&mcbsp2>;
+	nokia,audio-codec = <&tlv320aic3x>, <&tlv320aic3x_aux>;
+	nokia,headphone-amplifier = <&tpa6130a2>;
+
+	tvout-selection-gpios = <&gpio2 8 GPIO_ACTIVE_HIGH>; /* 40 */
+	jack-detection-gpios = <&gpio6 17 GPIO_ACTIVE_HIGH>; /* 177 */
+	eci-switch-gpios = <&gpio6 22 GPIO_ACTIVE_HIGH>; /* 182 */
+	speaker-amplifier-gpios = <&twl_gpio 7 GPIO_ACTIVE_HIGH>;
+};
diff --git a/sound/soc/omap/rx51.c b/sound/soc/omap/rx51.c
index 110deca..866578b 100644
--- a/sound/soc/omap/rx51.c
+++ b/sound/soc/omap/rx51.c
@@ -386,6 +386,7 @@ static struct snd_soc_card rx51_sound_card = {
 static int rx51_soc_probe(struct platform_device *pdev)
 {
 	struct rx51_audio_pdata *pdata;
+	struct device_node *np = pdev->dev.of_node;
 	struct snd_soc_card *card = &rx51_sound_card;
 	int err;
 
@@ -394,6 +395,49 @@ static int rx51_soc_probe(struct platform_device *pdev)
 
 	card->dev = &pdev->dev;
 
+	if (np) {
+		struct device_node *dai_node;
+
+		dai_node = of_parse_phandle(np, "nokia,cpu-dai", 0);
+		if (!dai_node) {
+			dev_err(&pdev->dev, "McBSP node is not provided\n");
+			return -EINVAL;
+		}
+		rx51_dai[0].cpu_dai_name = NULL;
+		rx51_dai[0].platform_name = NULL;
+		rx51_dai[0].cpu_of_node = dai_node;
+		rx51_dai[0].platform_of_node = dai_node;
+
+		dai_node = of_parse_phandle(np, "nokia,audio-codec", 0);
+		if (!dai_node) {
+			dev_err(&pdev->dev, "Codec node is not provided\n");
+			return -EINVAL;
+		}
+		rx51_dai[0].codec_name = NULL;
+		rx51_dai[0].codec_of_node = dai_node;
+
+		dai_node = of_parse_phandle(np, "nokia,audio-codec", 1);
+		if (!dai_node) {
+			dev_err(&pdev->dev, "Auxiliary Codec node is not provided\n");
+			return -EINVAL;
+		}
+		rx51_aux_dev[0].codec_name = NULL;
+		rx51_aux_dev[0].codec_of_node = dai_node;
+		rx51_codec_conf[0].dev_name = NULL;
+		rx51_codec_conf[0].of_node = dai_node;
+
+		dai_node = of_parse_phandle(np, "nokia,headphone-amplifier", 0);
+		if (!dai_node) {
+			dev_err(&pdev->dev, "Headphone amplifier node is not provided\n");
+			return -EINVAL;
+		}
+
+		/* TODO: tpa6130a2a driver supports only a single instance, so
+		 * this driver ignores the headphone-amplifier node for now.
+		 * It's already mandatory in the DT binding to be future proof.
+		 */
+	}
+
 	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
 	if (pdata == NULL) {
 		dev_err(card->dev, "failed to create private data\n");
@@ -463,10 +507,19 @@ static int rx51_soc_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#if defined(CONFIG_OF)
+static const struct of_device_id rx51_audio_of_match[] = {
+	{ .compatible = "nokia,n900-audio", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, rx51_audio_of_match);
+#endif
+
 static struct platform_driver rx51_soc_driver = {
 	.driver = {
 		.name = "rx51-audio",
 		.owner = THIS_MODULE,
+		.of_match_table = of_match_ptr(rx51_audio_of_match),
 	},
 	.probe = rx51_soc_probe,
 	.remove = rx51_soc_remove,
-- 
1.9.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
