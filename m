Received: from mo4-p04-ob.smtp.rzone.de (mo4-p04-ob.smtp.rzone.de [81.169.146.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E923203B6;
	Sat, 11 Jul 2026 06:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783749771; cv=pass; b=aFR+MxcXwiLVUqIzSrzia310ihqaBCsQq0EdVBSH50bsEir6MJxoGQhS51jpLQLghxSD1nXR9c+JA+6BpNACBFmtbYNwIHPiay79cPegdTQsTYm4Y7Ns9tfSqOFFsX5/mzsHk2bLTq5XO17BZ0Df7WTl4N1iMBB4JPtJhvS2WRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783749771; c=relaxed/simple;
	bh=AMRNOlxokmPgeKY+DfNe7od/LCFnky3zdAVEvMGPAIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QP4dGFtnFa8bYcKV4z4E5nzxn0Q58b3N5j74x6HSDyzTvmD6h992FIux+h09GgLrBCL8YCZKoGD2hy3k3Yx2y381Y67IUtQ8AJv7ii1DvI80rz+2tyfLywatKM7yxSKNWWP1XtkJdt91IwrGyv7NkWBTPtTGSetbJSq0s9YHy7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com; spf=pass smtp.mailfrom=goldelico.com; dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=q4rTPSDE; dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=f7BzaV5f; arc=pass smtp.client-ip=81.169.146.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="q4rTPSDE";
	dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="f7BzaV5f"
ARC-Seal: i=1; a=rsa-sha256; t=1783749740; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=GavbCTFZBG1aUMVo87JLKjuFV22hdUqfP4Ju8C198sTw03lZx+FZnD3jBZ1fnoVA8e
    8cHkEPvkxgTuBSpZCc5WcOtSH2I6/BQ/qs3PO0jvP3ax60aABmELVjF8tTvJEcDXiVYm
    0iQP9IdjFs6TTc/BUhRpcBLeYyGGibpbrtHQ0xxPuSjkE6NFluWd9v6EluaR+fmjEYRg
    vaPlL3v5wXXH7zDo8dPv4CiOkDW5YpnRJEY311xKF3wpRsdR3ztHwH32I7GkywLl2Hkz
    9N1cphnBENDhfJVptbN2/1SuG9jgcqDG7FMM2eeLmy5p+eF39qvl8zqQpkL2B8oG3d9G
    rKtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1783749740;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=igw5DRk6EVt837l8O2TTUHhMf9m3D5qGydPU0Gad1u0=;
    b=RcMZwFyBvozghkwObHtgiCz959R900n0dVDg50BJu31kYTrBrkiKNJoWCaTSqgAFW4
    iAO3UfLQsDIKC9stuUX4Sho3hUbv1bZu1co9TtHfOQf98bcnjByZLe+Fqo6zaAeExbaL
    NoJUjMtp5VoaPanPmSAZwA2B4SMSd8s60TNb+Ne54DTmhQDtUe5K9pO0W4VKBpfb35D2
    TaeHhvJTwabIXKJMUZyXlUSothtTsA85YcqZdF7m6dfVuaNVGBdhiu48+0GAzFMjJ7wy
    Jj2+AzdVPs0AB6gK5q45C7jMFvkCMRSR8HbUOxTSdOxCegPCxG7LYoDk+Fs+c4zk0iJP
    WWzA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo04
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1783749740;
    s=strato-dkim-0002; d=goldelico.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=igw5DRk6EVt837l8O2TTUHhMf9m3D5qGydPU0Gad1u0=;
    b=q4rTPSDEmy1bqza+Z1yq/O+CxRCbaEhdMn/OnVXhJEZl4NvY6TByyMbUNtb+Hjt3ZF
    8m8YE6zLbl+NJ4sUY33X35YWsn5lg6M0uVNXPXAKOWp3Z8aEwXfCS9VL95Q8hSaAEi37
    YsIQezP20j5I38dheK5jKKEuYUP4UXIlGM5CBgM1Q40cN28CTOXNbe3AcMgsFa0OozRC
    VIjZMMZVekVv8OeO06OnDol6PvHC7FeJ9ZKBGWP5SlX61IKEZg+NX0su7zAqdS5B5Sel
    Jhr7cTh1JSLGBn3t6ZKWX2i1qHBVU+oovDQkvmHKzVGxt8czauYSLO6C5njp8v9AiOVV
    KSuQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1783749740;
    s=strato-dkim-0003; d=goldelico.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=igw5DRk6EVt837l8O2TTUHhMf9m3D5qGydPU0Gad1u0=;
    b=f7BzaV5fpcSx+hXIQHGf9w7G+7464WA3p1nmYPRi4iqK8MDwMr00glmmOmGWTm9+Di
    SnN2pK41zDAMYx/KZGCA==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9qVpwcQVkPW4I1HrT35oLmciNszeF4HOToVDOd6S1gdjuILE2MKVd"
Received: from iMac.fritz.box
    by smtp.strato.de (RZmta 55.5.6 AUTH)
    with ESMTPSA id Q4b76426B62IGhv
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 11 Jul 2026 08:02:18 +0200 (CEST)
From: "H. Nikolaus Schaller" <hns@goldelico.com>
To: Grond <grond66@riseup.net>,
	Stefan Leichter <sle85276@gmx.de>,
	"H . Nikolaus Schaller" <hns@goldelico.com>,
	Grazvydas Ignotas <notasas@gmail.com>,
	Tony Lindgren <tony@atomide.com>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Jarkko Nikula <jarkko.nikula@bitmer.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Andreas Kemnade <andreas@kemnade.info>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Sen Wang <sen@ti.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Niranjan H Y <niranjan.hy@ti.com>
Cc: letux-kernel@openphoenux.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	kernel@pyra-handheld.com,
	mfd@lists.linux.dev
Subject: [PATCH 10/16] ASoC: omap3pandora: Rewrite sound card driver as a platform driver with DT
Date: Sat, 11 Jul 2026 08:01:57 +0200
Message-ID: <9274200e1ef2bc0e8df267a4b093b99f563c9c90.1783749722.git.hns@goldelico.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1783749722.git.hns@goldelico.com>
References: <cover.1783749722.git.hns@goldelico.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

From: Stefan Leichter <sle85276@gmx.de>

This change takes advantage of numerous prior changes and moves a
significant amount of code into the new PCM1773 codec driver (and removes
a hardcoded GPIO and regulator in the process). By using this new driver we
can remove the prior fiction that playback audio goes through the TWL4030.

Previously, the sound card driver worked by checking (through various means)
if it was running on the Pandora, and if so, it would create a new platform
device from nothing to function as the sound card, and rely on some weirdness
to get registered as an ASoC card driver. This has not been the way to do ASoC
card drivers for a while now, so instead we register a platform driver which
matches a device in the Pandora's DT and registers the appropriate ASoC card
driver when found. This also means that the driver will only load when the DT
says that we need it, and we can stop manually loading this thing.

Other significant changes:
- as a side-effect this patch retires the last call to machine_is_omap3_pandora()
- conversion to devm
- separate capture and playback ops
- conversion to dev_err
- use new code for twl4030 to set apll clock
- move widgets and routing to device tree definitions

Signed-off-by: Stefan Leichter <sle85276@gmx.de>
Co-developed-by: Grond <grond66@riseup.net>
Signed-off-by: Grond <grond66@riseup.net>
Co-developed-by: H. Nikolaus Schaller <hns@goldelico.com>
Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 sound/soc/ti/omap3pandora.c | 454 +++++++++++++++++++++++++-----------
 1 file changed, 320 insertions(+), 134 deletions(-)

diff --git a/sound/soc/ti/omap3pandora.c b/sound/soc/ti/omap3pandora.c
index 6c9c184cd9d6f..d3509473f5df0 100644
--- a/sound/soc/ti/omap3pandora.c
+++ b/sound/soc/ti/omap3pandora.c
@@ -6,138 +6,279 @@
  */
 
 #include <linux/clk.h>
-#include <linux/platform_device.h>
-#include <linux/gpio/consumer.h>
 #include <linux/delay.h>
-#include <linux/regulator/consumer.h>
+#include <linux/gpio/consumer.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
 
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/soc.h>
 
+#include <asm/mach-types.h>
+#include <linux/mfd/twl4030-audio.h>
 #include <linux/platform_data/asoc-ti-mcbsp.h>
 
 #include "omap-mcbsp.h"
 
-#define PREFIX "ASoC omap3pandora: "
+struct omap3pandora_sound {
+	struct gpio_desc *amp_gpio;
+	struct regulator *amp_regulator;
+
+	struct snd_pcm_substream *playback_stream;
+	struct snd_pcm_substream *capture_stream;
 
-static struct regulator *omap3pandora_dac_reg;
-static struct gpio_desc *dac_power_gpio;
-static struct gpio_desc *amp_power_gpio;
+	struct mutex sample_rate_lock; // protects all fields after
+	unsigned int sample_rate;
+	int sample_rate_users;
+};
 
-static int omap3pandora_hw_params(struct snd_pcm_substream *substream,
-	struct snd_pcm_hw_params *params)
+static struct snd_soc_dai_link omap3pandora_dai[];
+
+static int omap3pandora_common_hw_params(struct snd_pcm_substream *substream,
+					 struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct snd_soc_dai *codec_dai = snd_soc_rtd_to_codec(rtd, 0);
 	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
+	struct device *dev = rtd->dev;
 	int ret;
 
-	/* Set the codec system clock for DAC and ADC */
-	ret = snd_soc_dai_set_sysclk(codec_dai, 0, 26000000,
-					    SND_SOC_CLOCK_IN);
-	if (ret < 0) {
-		pr_err(PREFIX "can't set codec system clock\n");
-		return ret;
-	}
-
 	/* Set McBSP clock to external */
 	ret = snd_soc_dai_set_sysclk(cpu_dai, OMAP_MCBSP_SYSCLK_CLKS_EXT,
 				     256 * params_rate(params),
 				     SND_SOC_CLOCK_IN);
 	if (ret < 0) {
-		pr_err(PREFIX "can't set cpu system clock\n");
+		dev_err(dev, "cannot set McBSP clock to external: %d\n", ret);
 		return ret;
 	}
 
 	ret = snd_soc_dai_set_clkdiv(cpu_dai, OMAP_MCBSP_CLKGDV, 8);
 	if (ret < 0) {
-		pr_err(PREFIX "can't set SRG clock divider\n");
+		dev_err(dev, "cannot set McBSP clock divider: %d\n", ret);
 		return ret;
 	}
 
 	return 0;
 }
 
-static int omap3pandora_dac_event(struct snd_soc_dapm_widget *w,
-	struct snd_kcontrol *k, int event)
+static inline int constrain_sample_rate(struct snd_pcm_substream *substream,
+					unsigned int sample_rate)
 {
+	return snd_pcm_hw_constraint_single(substream->runtime,
+					    SNDRV_PCM_HW_PARAM_RATE,
+					    sample_rate);
+}
+
+static inline void relax_sample_rate(struct snd_pcm_substream *substream)
+{
+	const struct snd_interval default_sample_rate_range = {
+		.min = substream->runtime->hw.rate_min,
+		.max = substream->runtime->hw.rate_max,
+		.openmin = 1,
+		.openmax = 1,
+	};
+
+	*constrs_interval(&substream->runtime->hw_constraints,
+			  SNDRV_PCM_HW_PARAM_RATE) =
+		default_sample_rate_range;
+}
+
+static void release_sample_rate(struct omap3pandora_sound *ctx,
+				struct snd_pcm_substream *substream)
+{
+	mutex_lock(&ctx->sample_rate_lock);
+
+	if (ctx->sample_rate_users > 0)
+		--ctx->sample_rate_users;
+	if (ctx->sample_rate_users == 0)
+		ctx->sample_rate = 0;
+
+	relax_sample_rate(substream);
+
+	mutex_unlock(&ctx->sample_rate_lock);
+}
+
+static int grab_sample_rate(struct omap3pandora_sound *ctx,
+			    struct snd_pcm_substream *substream,
+			    struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
+	struct device *dev = rtd->dev;
+	int ret;
+
+	ret = mutex_lock_interruptible(&ctx->sample_rate_lock);
+	if (ret)
+		return ret;
+
+	if (++ctx->sample_rate_users == 1)
+		ctx->sample_rate = params_rate(params);
+
+	mutex_unlock(&ctx->sample_rate_lock);
+
+	ret = constrain_sample_rate(substream, ctx->sample_rate);
+	if (ret < 0)
+		goto err;
+
+	ret = constrain_sample_rate(substream, params_rate(params));
+	if (ret < 0) {
+		dev_dbg(dev, "sample rate mismatch; playback/capture share same clock");
+		goto err;
+	}
+
+	return 0;
+
+err:
+	release_sample_rate(ctx, substream);
+
+	return ret;
+}
+
+static int omap3pandora_playback_hw_params(struct snd_pcm_substream *substream,
+					   struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
+	struct snd_soc_card *card = rtd->card;
+	struct omap3pandora_sound *ctx = snd_soc_card_get_drvdata(card);
+	struct device *dev = rtd->dev;
+	struct snd_soc_pcm_runtime *tmp_rtd;
+	struct snd_soc_pcm_runtime *twl4030_rtd = NULL;
 	int ret;
 
 	/*
-	 * The PCM1773 DAC datasheet requires 1ms delay between switching
-	 * VCC power on/off and /PD pin high/low
+	 * We need to set the APLL clock rate on the TWL4030 because it feeds
+	 * both the DAI of the PCM1773. So find the appropriate RTD and call
+	 * the TWL's .set_sysclk callback through there. Ugly, but it must be
+	 * done.
 	 */
-	if (SND_SOC_DAPM_EVENT_ON(event)) {
-		struct device *dev = snd_soc_dapm_to_dev(w->dapm);
 
-		ret = regulator_enable(omap3pandora_dac_reg);
-		if (ret) {
-			dev_err(dev, "Failed to power DAC: %d\n", ret);
-			return ret;
+	for_each_card_rtds(card, tmp_rtd)
+		if (tmp_rtd->dai_link == &omap3pandora_dai[1]) {
+			twl4030_rtd = tmp_rtd;
+			break;
 		}
-		mdelay(1);
-		gpiod_set_value(dac_power_gpio, 1);
-	} else {
-		gpiod_set_value(dac_power_gpio, 0);
-		mdelay(1);
-		regulator_disable(omap3pandora_dac_reg);
+	if (!twl4030_rtd) {
+		dev_err(dev, "cannot find TWL4030 runtime data to set APLL rate\n");
+		return -EINVAL;
 	}
 
-	return 0;
+	ret = snd_soc_dai_set_sysclk(snd_soc_rtd_to_codec(twl4030_rtd, 0),
+				     TWL4030_CLOCK_APLL, params_rate(params),
+				     SND_SOC_CLOCK_OUT);
+	if (ret) {
+		dev_err(dev, "cannot set TWL4030 APLL rate via set_sysclk interface: %d\n",
+			ret);
+		return ret;
+	}
+
+	if (!ctx->playback_stream) {
+		ctx->playback_stream = substream;
+		ret = grab_sample_rate(ctx, substream, params);
+		if (ret)
+			return ret;
+	}
+
+	return omap3pandora_common_hw_params(substream, params);
 }
 
-static int omap3pandora_hp_event(struct snd_soc_dapm_widget *w,
-	struct snd_kcontrol *k, int event)
+static int omap3pandora_capture_hw_params(struct snd_pcm_substream *substream,
+					  struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
+	struct snd_soc_dai *codec_dai = snd_soc_rtd_to_codec(rtd, 0);
+	struct device *dev = rtd->dev;
+	struct snd_soc_card *card = rtd->card;
+	struct omap3pandora_sound *ctx = snd_soc_card_get_drvdata(card);
+	int ret;
+
+	/* Set the codec system clock for DAC and ADC */
+	ret = snd_soc_dai_set_sysclk(codec_dai, 0, 26000000,
+				     SND_SOC_CLOCK_IN);
+	if (ret < 0) {
+		dev_err(dev, "cannot set TWL4030 system clock: %d\n", ret);
+		return ret;
+	}
+
+	if (!ctx->capture_stream) {
+		ctx->capture_stream = substream;
+		ret = grab_sample_rate(ctx, substream, params);
+		if (ret)
+			return ret;
+	}
+
+	return omap3pandora_common_hw_params(substream, params);
+}
+
+static int omap3pandora_playback_hw_free(struct snd_pcm_substream *substream)
 {
-	if (SND_SOC_DAPM_EVENT_ON(event))
-		gpiod_set_value(amp_power_gpio, 1);
-	else
-		gpiod_set_value(amp_power_gpio, 0);
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
+	struct snd_soc_card *card = rtd->card;
+	struct omap3pandora_sound *ctx = snd_soc_card_get_drvdata(card);
+
+	if (ctx->playback_stream)
+		release_sample_rate(ctx, substream);
+	ctx->playback_stream = NULL;
 
 	return 0;
 }
 
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
+static int omap3pandora_common_startup(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
+	struct snd_soc_card *card = rtd->card;
+	struct omap3pandora_sound *ctx = snd_soc_card_get_drvdata(card);
+	unsigned int sample_rate = ctx->sample_rate;
 
-	SND_SOC_DAPM_MIC("Mic (internal)", NULL),
-	SND_SOC_DAPM_MIC("Mic (external)", NULL),
-	SND_SOC_DAPM_LINE("Line In", NULL),
-};
+	if (!sample_rate)
+		return 0;
 
-static const struct snd_soc_dapm_route omap3pandora_map[] = {
-	{"PCM DAC", NULL, "APLL Enable"},
-	{"Headphone Amplifier", NULL, "PCM DAC"},
-	{"Line Out", NULL, "PCM DAC"},
-	{"Headphone Jack", NULL, "Headphone Amplifier"},
+	return constrain_sample_rate(substream, sample_rate);
+}
 
-	{"AUXL", NULL, "Line In"},
-	{"AUXR", NULL, "Line In"},
+static int omap3pandora_capture_hw_free(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
+	struct snd_soc_card *card = rtd->card;
+	struct omap3pandora_sound *ctx = snd_soc_card_get_drvdata(card);
 
-	{"MAINMIC", NULL, "Mic (internal)"},
-	{"Mic (internal)", NULL, "Mic Bias 1"},
+	if (ctx->capture_stream)
+		release_sample_rate(ctx, substream);
+	ctx->capture_stream = NULL;
 
-	{"SUBMIC", NULL, "Mic (external)"},
-	{"Mic (external)", NULL, "Mic Bias 2"},
-};
+	return 0;
+}
+
+static int omap3pandora_hp_event(struct snd_soc_dapm_widget *w,
+				 struct snd_kcontrol *k, int event)
+{
+	struct snd_soc_card *card = snd_soc_dapm_to_card(w->dapm);
+	struct device *dev = card->dev;
+	struct omap3pandora_sound *ctx =
+		snd_soc_card_get_drvdata(card);
+	int ret;
+
+	if (SND_SOC_DAPM_EVENT_ON(event)) {
+		ret = regulator_enable(ctx->amp_regulator);
+		if (ret) {
+			dev_err(dev, "error enabling amplifier regulator: %d\n", ret);
+			return ret;
+		}
+
+		gpiod_set_value(ctx->amp_gpio, 1);
+	} else {
+		gpiod_set_value(ctx->amp_gpio, 0);
+
+		ret = regulator_disable(ctx->amp_regulator);
+		if (ret) {
+			dev_err(dev, "error disabling amplifier regulator: %d\n", ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
 
 static int omap3pandora_out_init(struct snd_soc_pcm_runtime *rtd)
 {
@@ -171,20 +312,40 @@ static int omap3pandora_in_init(struct snd_soc_pcm_runtime *rtd)
 	return 0;
 }
 
-static const struct snd_soc_ops omap3pandora_ops = {
-	.hw_params = omap3pandora_hw_params,
+static const struct snd_soc_ops omap3pandora_playback_ops = {
+	.startup = omap3pandora_common_startup,
+	.hw_params = omap3pandora_playback_hw_params,
+	.hw_free = omap3pandora_playback_hw_free,
+};
+
+static const struct snd_soc_ops omap3pandora_capture_ops = {
+	.startup = omap3pandora_common_startup,
+	.hw_params = omap3pandora_capture_hw_params,
+	.hw_free = omap3pandora_capture_hw_free,
 };
 
 /* Digital audio interface glue - connects codec <--> CPU */
+#if IS_BUILTIN(CONFIG_SND_SOC_OMAP3_PANDORA)
 SND_SOC_DAILINK_DEFS(out,
 	DAILINK_COMP_ARRAY(COMP_CPU("omap-mcbsp.2")),
-	DAILINK_COMP_ARRAY(COMP_CODEC("twl4030-codec", "twl4030-hifi")),
+	DAILINK_COMP_ARRAY(COMP_CODEC("pcm1773-codec", "pcm1773-hifi")),
 	DAILINK_COMP_ARRAY(COMP_PLATFORM("omap-mcbsp.2")));
 
 SND_SOC_DAILINK_DEFS(in,
 	DAILINK_COMP_ARRAY(COMP_CPU("omap-mcbsp.4")),
 	DAILINK_COMP_ARRAY(COMP_CODEC("twl4030-codec", "twl4030-hifi")),
 	DAILINK_COMP_ARRAY(COMP_PLATFORM("omap-mcbsp.4")));
+#else /* IS_BUILTIN(CONFIG_SND_SOC_OMAP3_PANDORA) */
+SND_SOC_DAILINK_DEFS(out,
+	DAILINK_COMP_ARRAY(COMP_CPU("49022000.mcbsp")),
+	DAILINK_COMP_ARRAY(COMP_CODEC("pcm1773-codec", "pcm1773-hifi")),
+	DAILINK_COMP_ARRAY(COMP_PLATFORM("49022000.mcbsp")));
+
+SND_SOC_DAILINK_DEFS(in,
+	DAILINK_COMP_ARRAY(COMP_CPU("49026000.mcbsp")),
+	DAILINK_COMP_ARRAY(COMP_CODEC("twl4030-codec", "twl4030-hifi")),
+	DAILINK_COMP_ARRAY(COMP_PLATFORM("49026000.mcbsp")));
+#endif /* IS_BUILTIN(CONFIG_SND_SOC_OMAP3_PANDORA) */
 
 static struct snd_soc_dai_link omap3pandora_dai[] = {
 	{
@@ -192,100 +353,125 @@ static struct snd_soc_dai_link omap3pandora_dai[] = {
 		.stream_name = "HiFi Out",
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
 			   SND_SOC_DAIFMT_CBC_CFC,
-		.ops = &omap3pandora_ops,
+		.ops = &omap3pandora_playback_ops,
 		.init = omap3pandora_out_init,
+		.playback_only = 1,
 		SND_SOC_DAILINK_REG(out),
 	}, {
 		.name = "TWL4030",
 		.stream_name = "Line/Mic In",
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
 			   SND_SOC_DAIFMT_CBC_CFC,
-		.ops = &omap3pandora_ops,
+		.ops = &omap3pandora_capture_ops,
 		.init = omap3pandora_in_init,
+		.capture_only = 1,
 		SND_SOC_DAILINK_REG(in),
 	}
 };
 
+static const struct snd_soc_dapm_widget omap3pandora_local_widgets[] = {
+	SND_SOC_DAPM_PGA_E("Headphone Amplifier", SND_SOC_NOPM,
+			   0, 0, NULL, 0, omap3pandora_hp_event,
+			   SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
+};
+
 /* SoC card */
 static struct snd_soc_card snd_soc_card_omap3pandora = {
-	.name = "omap3pandora",
-	.owner = THIS_MODULE,
-	.dai_link = omap3pandora_dai,
-	.num_links = ARRAY_SIZE(omap3pandora_dai),
-
-	.dapm_widgets = omap3pandora_dapm_widgets,
-	.num_dapm_widgets = ARRAY_SIZE(omap3pandora_dapm_widgets),
-	.dapm_routes = omap3pandora_map,
-	.num_dapm_routes = ARRAY_SIZE(omap3pandora_map),
+	.name        = "omap3pandora",
+	.owner       = THIS_MODULE,
+	.dai_link    = omap3pandora_dai,
+	.num_links   = ARRAY_SIZE(omap3pandora_dai),
+	.dapm_widgets     = omap3pandora_local_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(omap3pandora_local_widgets),
 };
 
-static struct platform_device *omap3pandora_snd_device;
-
-static int __init omap3pandora_soc_init(void)
+static int omap3pandora_probe(struct platform_device *pdev)
 {
 	int ret;
+	struct device *dev = &pdev->dev;
+	struct snd_soc_card *card = &snd_soc_card_omap3pandora;
+	struct omap3pandora_sound *ctx;
 
-	if (!of_machine_is_compatible("openpandora,omap3-pandora-600mhz") &&
-		!of_machine_is_compatible("openpandora,omap3-pandora-1ghz"))
-		return -ENODEV;
-
-	pr_info("OMAP3 Pandora SoC init\n");
-
-	omap3pandora_snd_device = platform_device_alloc("soc-audio", -1);
-	if (omap3pandora_snd_device == NULL) {
-		pr_err(PREFIX "Platform device allocation failed\n");
+	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
 		return -ENOMEM;
-	}
 
-	platform_set_drvdata(omap3pandora_snd_device, &snd_soc_card_omap3pandora);
+	mutex_init(&ctx->sample_rate_lock);
 
-	ret = platform_device_add(omap3pandora_snd_device);
-	if (ret) {
-		pr_err(PREFIX "Unable to add platform device\n");
-		goto fail2;
+	ctx->amp_gpio = devm_gpiod_get(dev, "amp", GPIOD_OUT_LOW);
+	if (IS_ERR(ctx->amp_gpio)) {
+		dev_err(dev, "cannot find amplifier gpio\n");
+		return PTR_ERR(ctx->amp_gpio);
 	}
 
-	dac_power_gpio = devm_gpiod_get(&omap3pandora_snd_device->dev,
-					"dac", GPIOD_OUT_LOW);
-	if (IS_ERR(dac_power_gpio)) {
-		ret = PTR_ERR(dac_power_gpio);
-		goto fail3;
+	ctx->amp_regulator = devm_regulator_get(dev, "amp");
+	if (IS_ERR(ctx->amp_regulator)) {
+		ret = PTR_ERR(ctx->amp_regulator);
+		dev_err(dev, "Failed to request regulator for amplifier power: %d\n", ret);
+		return ret;
 	}
 
-	amp_power_gpio = devm_gpiod_get(&omap3pandora_snd_device->dev,
-					"amp", GPIOD_OUT_LOW);
-	if (IS_ERR(amp_power_gpio)) {
-		ret = PTR_ERR(amp_power_gpio);
-		goto fail3;
+	card->dev = dev;
+
+	if (dev->of_node) {
+		ret = snd_soc_of_parse_card_name(card, "label");
+		if (ret)
+			card->name = "omap3pandora";
+
+		ret = snd_soc_of_parse_audio_simple_widgets(card, "widgets");
+		if (ret) {
+			dev_err(dev, "Failed to parse DAPM widgets: %d\n", ret);
+			goto err_mutex;
+		}
+
+		ret = snd_soc_of_parse_audio_routing(card, "routing");
+		if (ret) {
+			dev_err(dev, "Failed to parse audio routing: %d\n", ret);
+			goto err_mutex;
+		}
 	}
 
-	omap3pandora_dac_reg = regulator_get(&omap3pandora_snd_device->dev, "vcc");
-	if (IS_ERR(omap3pandora_dac_reg)) {
-		pr_err(PREFIX "Failed to get DAC regulator from %s: %ld\n",
-			dev_name(&omap3pandora_snd_device->dev),
-			PTR_ERR(omap3pandora_dac_reg));
-		ret = PTR_ERR(omap3pandora_dac_reg);
-		goto fail3;
+	snd_soc_card_set_drvdata(card, ctx);
+
+	ret = devm_snd_soc_register_card(dev, card);
+	if (ret) {
+		dev_err(dev, "Failed to register sound card: %d\n", ret);
+		goto err_mutex;
 	}
 
 	return 0;
 
-fail3:
-	platform_device_del(omap3pandora_snd_device);
-fail2:
-	platform_device_put(omap3pandora_snd_device);
-
+err_mutex:
+	mutex_destroy(&ctx->sample_rate_lock);
 	return ret;
 }
-module_init(omap3pandora_soc_init);
 
-static void __exit omap3pandora_soc_exit(void)
+static void omap3pandora_remove(struct platform_device *pdev)
 {
-	regulator_put(omap3pandora_dac_reg);
-	platform_device_unregister(omap3pandora_snd_device);
+	struct snd_soc_card *card = platform_get_drvdata(pdev);
+	struct omap3pandora_sound *ctx = snd_soc_card_get_drvdata(card);
+
+	mutex_destroy(&ctx->sample_rate_lock);
 }
-module_exit(omap3pandora_soc_exit);
+
+static const struct of_device_id omap3pandora_of_match[] = {
+	{ .compatible = "openpandora,omap3pandora-sound", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, omap3pandora_of_match);
+
+static struct platform_driver omap3pandora_driver = {
+	.driver = {
+		.name = "omap3pandora-sound",
+		.of_match_table = omap3pandora_of_match,
+	},
+	.probe = omap3pandora_probe,
+	.remove = omap3pandora_remove,
+};
+
+module_platform_driver(omap3pandora_driver);
 
 MODULE_AUTHOR("Grazvydas Ignotas <notasas@gmail.com>");
 MODULE_DESCRIPTION("ALSA SoC OMAP3 Pandora");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:omap3pandora-sound");
-- 
2.50.1 (Apple Git-155)

