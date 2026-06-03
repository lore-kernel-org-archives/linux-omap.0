Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60754779A7
	for <linux-omap@vger.kernel.org>; Wed,  3 Jun 2026 12:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780488577; cv=none; b=k3ZWk8n6hl6t7cimKQl/7IGixFWeXerOxUYU6ZSYxaEYTUSZ55qv41m8e2ZSNP1QCBhi+3tif/NbL7YlEZaFkkpQs7sr2Z0hHJfZo9M8fffwCrcrMoRWkdfEIYnoBkvyYwcf4XtbNiOaY6IfSg4NdeOxSYIF2OpyQ6G9RqDDcO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780488577; c=relaxed/simple;
	bh=m0fPmnr7gG/sozJZ1z4H3lm49M3SBP18S7cA2BtCiX8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gKxjaR5ZMKlMmIzlQN/vVPSOhvHGEUVhtkqfYK7NTbmuFg8ZyhZXxhIOypePsQ8vhwjG/KS2Q41PuV6GeOuOz8yPvfuHl7anaX+rHDqBmmaW73K+nVfeSsTl5Ad7uT5A/ru/CvEm0t7IZLU8bHOks0YoRtEt/2wjZTnRnZLHQDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1wUkPV-00082A-CP; Wed, 03 Jun 2026 14:09:25 +0200
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1wUkPU-000uUi-1R;
	Wed, 03 Jun 2026 14:09:24 +0200
Received: from [::1] (helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.98.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1wUkPU-00000007LO8-1MKA;
	Wed, 03 Jun 2026 14:09:24 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Wed, 03 Jun 2026 14:09:23 +0200
Subject: [PATCH 2/4] ASoC: ti: omap3pandora: remove
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260603-asoc-remove-mach-types-h-v1-2-2b9446dff0c1@pengutronix.de>
References: <20260603-asoc-remove-mach-types-h-v1-0-2b9446dff0c1@pengutronix.de>
In-Reply-To: <20260603-asoc-remove-mach-types-h-v1-0-2b9446dff0c1@pengutronix.de>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Sen Wang <sen@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-omap@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780488564; l=10988;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=m0fPmnr7gG/sozJZ1z4H3lm49M3SBP18S7cA2BtCiX8=;
 b=112SkPDXEeq97EryzYJXqy+7mQptTjV70B46SdvzxI9DcjxvgkQhVuKHHUknjmpuefN1I5S2M
 18J6YQw/32pAagJDbq10BCPTmAzTLEfcW4P1IVEskirK6/VFAFmPbZ/
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-omap@vger.kernel.org

The omap3pandora driver entirely depends on machine_is_omap3_pandora().
Pandora has been converted to device tree:

7fcf7e061edd3 ("ARM: OMAP2+: Remove legacy booting support for Pandora")

Since then machine_is_omap3_pandora() always expands to 0. Remove the
long unused driver.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 sound/soc/ti/Kconfig        |   9 --
 sound/soc/ti/Makefile       |   2 -
 sound/soc/ti/omap3pandora.c | 290 --------------------------------------------
 3 files changed, 301 deletions(-)

diff --git a/sound/soc/ti/Kconfig b/sound/soc/ti/Kconfig
index 3323cf96e3095..e5b165e0fc6cc 100644
--- a/sound/soc/ti/Kconfig
+++ b/sound/soc/ti/Kconfig
@@ -83,15 +83,6 @@ config SND_SOC_NOKIA_RX51
 	  Say Y or M if you want to add support for SoC audio on Nokia RX-51
 	  hardware. This is also known as Nokia N900 product.
 
-config SND_SOC_OMAP3_PANDORA
-	tristate "SoC Audio support for OMAP3 Pandora"
-	depends on ARCH_OMAP3
-	depends on TWL4030_CORE
-	select SND_SOC_OMAP_MCBSP
-	select SND_SOC_TWL4030
-	help
-	  Say Y or M if you want to add support for SoC audio on the OMAP3 Pandora.
-
 config SND_SOC_OMAP3_TWL4030
 	tristate "SoC Audio support for OMAP3 based boards with twl4030 codec"
 	depends on ARCH_OMAP3 || COMPILE_TEST && COMMON_CLK
diff --git a/sound/soc/ti/Makefile b/sound/soc/ti/Makefile
index 421e13bc04dbb..a5f5b284c0e28 100644
--- a/sound/soc/ti/Makefile
+++ b/sound/soc/ti/Makefile
@@ -26,7 +26,6 @@ obj-$(CONFIG_SND_SOC_OMAP_MCPDM) += snd-soc-omap-mcpdm.o
 snd-soc-davinci-evm-y := davinci-evm.o
 snd-soc-n810-y := n810.o
 snd-soc-rx51-y := rx51.o
-snd-soc-omap3pandora-y := omap3pandora.o
 snd-soc-omap-twl4030-y := omap-twl4030.o
 snd-soc-omap-abe-twl6040-y := omap-abe-twl6040.o
 snd-soc-ams-delta-y := ams-delta.o
@@ -37,7 +36,6 @@ snd-soc-j721e-evm-y := j721e-evm.o
 obj-$(CONFIG_SND_SOC_DAVINCI_EVM) += snd-soc-davinci-evm.o
 obj-$(CONFIG_SND_SOC_NOKIA_N810) += snd-soc-n810.o
 obj-$(CONFIG_SND_SOC_NOKIA_RX51) += snd-soc-rx51.o
-obj-$(CONFIG_SND_SOC_OMAP3_PANDORA) += snd-soc-omap3pandora.o
 obj-$(CONFIG_SND_SOC_OMAP3_TWL4030) += snd-soc-omap-twl4030.o
 obj-$(CONFIG_SND_SOC_OMAP_ABE_TWL6040) += snd-soc-omap-abe-twl6040.o
 obj-$(CONFIG_SND_SOC_OMAP_AMS_DELTA) += snd-soc-ams-delta.o
diff --git a/sound/soc/ti/omap3pandora.c b/sound/soc/ti/omap3pandora.c
deleted file mode 100644
index f11b1d8a1306c..0000000000000
--- a/sound/soc/ti/omap3pandora.c
+++ /dev/null
@@ -1,290 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * omap3pandora.c  --  SoC audio for Pandora Handheld Console
- *
- * Author: Gražvydas Ignotas <notasas@gmail.com>
- */
-
-#include <linux/clk.h>
-#include <linux/platform_device.h>
-#include <linux/gpio/consumer.h>
-#include <linux/delay.h>
-#include <linux/regulator/consumer.h>
-#include <linux/module.h>
-
-#include <sound/core.h>
-#include <sound/pcm.h>
-#include <sound/soc.h>
-
-#include <asm/mach-types.h>
-#include <linux/platform_data/asoc-ti-mcbsp.h>
-
-#include "omap-mcbsp.h"
-
-#define PREFIX "ASoC omap3pandora: "
-
-static struct regulator *omap3pandora_dac_reg;
-static struct gpio_desc *dac_power_gpio;
-static struct gpio_desc *amp_power_gpio;
-
-static int omap3pandora_hw_params(struct snd_pcm_substream *substream,
-	struct snd_pcm_hw_params *params)
-{
-	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
-	struct snd_soc_dai *codec_dai = snd_soc_rtd_to_codec(rtd, 0);
-	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
-	int ret;
-
-	/* Set the codec system clock for DAC and ADC */
-	ret = snd_soc_dai_set_sysclk(codec_dai, 0, 26000000,
-					    SND_SOC_CLOCK_IN);
-	if (ret < 0) {
-		pr_err(PREFIX "can't set codec system clock\n");
-		return ret;
-	}
-
-	/* Set McBSP clock to external */
-	ret = snd_soc_dai_set_sysclk(cpu_dai, OMAP_MCBSP_SYSCLK_CLKS_EXT,
-				     256 * params_rate(params),
-				     SND_SOC_CLOCK_IN);
-	if (ret < 0) {
-		pr_err(PREFIX "can't set cpu system clock\n");
-		return ret;
-	}
-
-	ret = snd_soc_dai_set_clkdiv(cpu_dai, OMAP_MCBSP_CLKGDV, 8);
-	if (ret < 0) {
-		pr_err(PREFIX "can't set SRG clock divider\n");
-		return ret;
-	}
-
-	return 0;
-}
-
-static int omap3pandora_dac_event(struct snd_soc_dapm_widget *w,
-	struct snd_kcontrol *k, int event)
-{
-	int ret;
-
-	/*
-	 * The PCM1773 DAC datasheet requires 1ms delay between switching
-	 * VCC power on/off and /PD pin high/low
-	 */
-	if (SND_SOC_DAPM_EVENT_ON(event)) {
-		struct device *dev = snd_soc_dapm_to_dev(w->dapm);
-
-		ret = regulator_enable(omap3pandora_dac_reg);
-		if (ret) {
-			dev_err(dev, "Failed to power DAC: %d\n", ret);
-			return ret;
-		}
-		mdelay(1);
-		gpiod_set_value(dac_power_gpio, 1);
-	} else {
-		gpiod_set_value(dac_power_gpio, 0);
-		mdelay(1);
-		regulator_disable(omap3pandora_dac_reg);
-	}
-
-	return 0;
-}
-
-static int omap3pandora_hp_event(struct snd_soc_dapm_widget *w,
-	struct snd_kcontrol *k, int event)
-{
-	if (SND_SOC_DAPM_EVENT_ON(event))
-		gpiod_set_value(amp_power_gpio, 1);
-	else
-		gpiod_set_value(amp_power_gpio, 0);
-
-	return 0;
-}
-
-/*
- * Audio paths on Pandora board:
- *
- *  |O| ---> PCM DAC +-> AMP -> Headphone Jack
- *  |M|         A    +--------> Line Out
- *  |A| <~~clk~~+
- *  |P| <--- TWL4030 <--------- Line In and MICs
- */
-static const struct snd_soc_dapm_widget omap3pandora_dapm_widgets[] = {
-	SND_SOC_DAPM_DAC_E("PCM DAC", "HiFi Playback", SND_SOC_NOPM,
-			   0, 0, omap3pandora_dac_event,
-			   SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
-	SND_SOC_DAPM_PGA_E("Headphone Amplifier", SND_SOC_NOPM,
-			   0, 0, NULL, 0, omap3pandora_hp_event,
-			   SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
-	SND_SOC_DAPM_HP("Headphone Jack", NULL),
-	SND_SOC_DAPM_LINE("Line Out", NULL),
-
-	SND_SOC_DAPM_MIC("Mic (internal)", NULL),
-	SND_SOC_DAPM_MIC("Mic (external)", NULL),
-	SND_SOC_DAPM_LINE("Line In", NULL),
-};
-
-static const struct snd_soc_dapm_route omap3pandora_map[] = {
-	{"PCM DAC", NULL, "APLL Enable"},
-	{"Headphone Amplifier", NULL, "PCM DAC"},
-	{"Line Out", NULL, "PCM DAC"},
-	{"Headphone Jack", NULL, "Headphone Amplifier"},
-
-	{"AUXL", NULL, "Line In"},
-	{"AUXR", NULL, "Line In"},
-
-	{"MAINMIC", NULL, "Mic (internal)"},
-	{"Mic (internal)", NULL, "Mic Bias 1"},
-
-	{"SUBMIC", NULL, "Mic (external)"},
-	{"Mic (external)", NULL, "Mic Bias 2"},
-};
-
-static int omap3pandora_out_init(struct snd_soc_pcm_runtime *rtd)
-{
-	struct snd_soc_dapm_context *dapm = snd_soc_card_to_dapm(rtd->card);
-
-	/* All TWL4030 output pins are floating */
-	snd_soc_dapm_disable_pin(dapm, "EARPIECE");
-	snd_soc_dapm_disable_pin(dapm, "PREDRIVEL");
-	snd_soc_dapm_disable_pin(dapm, "PREDRIVER");
-	snd_soc_dapm_disable_pin(dapm, "HSOL");
-	snd_soc_dapm_disable_pin(dapm, "HSOR");
-	snd_soc_dapm_disable_pin(dapm, "CARKITL");
-	snd_soc_dapm_disable_pin(dapm, "CARKITR");
-	snd_soc_dapm_disable_pin(dapm, "HFL");
-	snd_soc_dapm_disable_pin(dapm, "HFR");
-	snd_soc_dapm_disable_pin(dapm, "VIBRA");
-
-	return 0;
-}
-
-static int omap3pandora_in_init(struct snd_soc_pcm_runtime *rtd)
-{
-	struct snd_soc_dapm_context *dapm = snd_soc_card_to_dapm(rtd->card);
-
-	/* Not comnnected */
-	snd_soc_dapm_disable_pin(dapm, "HSMIC");
-	snd_soc_dapm_disable_pin(dapm, "CARKITMIC");
-	snd_soc_dapm_disable_pin(dapm, "DIGIMIC0");
-	snd_soc_dapm_disable_pin(dapm, "DIGIMIC1");
-
-	return 0;
-}
-
-static const struct snd_soc_ops omap3pandora_ops = {
-	.hw_params = omap3pandora_hw_params,
-};
-
-/* Digital audio interface glue - connects codec <--> CPU */
-SND_SOC_DAILINK_DEFS(out,
-	DAILINK_COMP_ARRAY(COMP_CPU("omap-mcbsp.2")),
-	DAILINK_COMP_ARRAY(COMP_CODEC("twl4030-codec", "twl4030-hifi")),
-	DAILINK_COMP_ARRAY(COMP_PLATFORM("omap-mcbsp.2")));
-
-SND_SOC_DAILINK_DEFS(in,
-	DAILINK_COMP_ARRAY(COMP_CPU("omap-mcbsp.4")),
-	DAILINK_COMP_ARRAY(COMP_CODEC("twl4030-codec", "twl4030-hifi")),
-	DAILINK_COMP_ARRAY(COMP_PLATFORM("omap-mcbsp.4")));
-
-static struct snd_soc_dai_link omap3pandora_dai[] = {
-	{
-		.name = "PCM1773",
-		.stream_name = "HiFi Out",
-		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
-			   SND_SOC_DAIFMT_CBC_CFC,
-		.ops = &omap3pandora_ops,
-		.init = omap3pandora_out_init,
-		SND_SOC_DAILINK_REG(out),
-	}, {
-		.name = "TWL4030",
-		.stream_name = "Line/Mic In",
-		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
-			   SND_SOC_DAIFMT_CBC_CFC,
-		.ops = &omap3pandora_ops,
-		.init = omap3pandora_in_init,
-		SND_SOC_DAILINK_REG(in),
-	}
-};
-
-/* SoC card */
-static struct snd_soc_card snd_soc_card_omap3pandora = {
-	.name = "omap3pandora",
-	.owner = THIS_MODULE,
-	.dai_link = omap3pandora_dai,
-	.num_links = ARRAY_SIZE(omap3pandora_dai),
-
-	.dapm_widgets = omap3pandora_dapm_widgets,
-	.num_dapm_widgets = ARRAY_SIZE(omap3pandora_dapm_widgets),
-	.dapm_routes = omap3pandora_map,
-	.num_dapm_routes = ARRAY_SIZE(omap3pandora_map),
-};
-
-static struct platform_device *omap3pandora_snd_device;
-
-static int __init omap3pandora_soc_init(void)
-{
-	int ret;
-
-	if (!machine_is_omap3_pandora())
-		return -ENODEV;
-
-	pr_info("OMAP3 Pandora SoC init\n");
-
-	omap3pandora_snd_device = platform_device_alloc("soc-audio", -1);
-	if (omap3pandora_snd_device == NULL) {
-		pr_err(PREFIX "Platform device allocation failed\n");
-		return -ENOMEM;
-	}
-
-	platform_set_drvdata(omap3pandora_snd_device, &snd_soc_card_omap3pandora);
-
-	ret = platform_device_add(omap3pandora_snd_device);
-	if (ret) {
-		pr_err(PREFIX "Unable to add platform device\n");
-		goto fail2;
-	}
-
-	dac_power_gpio = devm_gpiod_get(&omap3pandora_snd_device->dev,
-					"dac", GPIOD_OUT_LOW);
-	if (IS_ERR(dac_power_gpio)) {
-		ret = PTR_ERR(dac_power_gpio);
-		goto fail3;
-	}
-
-	amp_power_gpio = devm_gpiod_get(&omap3pandora_snd_device->dev,
-					"amp", GPIOD_OUT_LOW);
-	if (IS_ERR(amp_power_gpio)) {
-		ret = PTR_ERR(amp_power_gpio);
-		goto fail3;
-	}
-
-	omap3pandora_dac_reg = regulator_get(&omap3pandora_snd_device->dev, "vcc");
-	if (IS_ERR(omap3pandora_dac_reg)) {
-		pr_err(PREFIX "Failed to get DAC regulator from %s: %ld\n",
-			dev_name(&omap3pandora_snd_device->dev),
-			PTR_ERR(omap3pandora_dac_reg));
-		ret = PTR_ERR(omap3pandora_dac_reg);
-		goto fail3;
-	}
-
-	return 0;
-
-fail3:
-	platform_device_del(omap3pandora_snd_device);
-fail2:
-	platform_device_put(omap3pandora_snd_device);
-
-	return ret;
-}
-module_init(omap3pandora_soc_init);
-
-static void __exit omap3pandora_soc_exit(void)
-{
-	regulator_put(omap3pandora_dac_reg);
-	platform_device_unregister(omap3pandora_snd_device);
-}
-module_exit(omap3pandora_soc_exit);
-
-MODULE_AUTHOR("Grazvydas Ignotas <notasas@gmail.com>");
-MODULE_DESCRIPTION("ALSA SoC OMAP3 Pandora");
-MODULE_LICENSE("GPL");

-- 
2.47.3

