Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795505235;
	b=L1VpXmFL5eCP4ua36QcAyJ2x9nZLvgEJGGVRV+4Kt1OdyxbHj1+XwQUXrRTVyOiO5qGO
	 0R5BnrnFzMZAyokLx3eMhGmC8a8tJ++PMx5moYHuTMaLmJrNuAbjq3h5uP/SDYAQoD1+e
	 p2zVOISULKnKWf+Ay+zpug2Ws4dLhxN4MJHxuS5R3eVBZlg/pNEpNnm9AQcUMWaZYY8Rp
	 Rwys4q03cI0dzQiHG3ijrx1qYJ2e7OEZSvaJzU4WM6G6aKIPSDphj+oDERMGGpFpOetni
	 ENOxXToi76VliXjlsGWEqPRFEAwkjf5uReb//KMmRkNxKGRPm3C86jriO/UgT6MEk7Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795505235;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type;
	bh=Dez18a2OqwlBFCCZ9gevwjnLnG2Bo/A/Kvv2BHdB538=;
	b=nUSxRckK5FVyD+sYG7IvlU/EOB5qDo9yjCHgM7SRdmgTaVLFxj2uWD11/apGf6MtELU6
	 3771Lyvz7PG3VMfU3xClaW7tZjMsqTlDE8hnuua/xGaxiZ3i1FzOnhx2S2m+A44UhUXaT
	 pbyZZPuLOKzetfwacTTGuh8JOs97MzC4qrV7k2i2u3FE41Lc1Y60OHqOFom9kITQOAlhS
	 snlniIEmKLZfC3XlW4B1QVRU9WaW7jbI6RiDYN6bdxfaJkU/792HBLLBz2oN1h9rNScEF
	 +VjF2DflcPipB7whssttTp0Iu8aJ+1/bGdA9j6hZUSTpb4KydPaq0qivMgj7rNljM0g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goldelico.com;
	spf=pass smtp.mailfrom=goldelico.com;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=p3C13ci5;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=EzT9oUTg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.176
Received: from mo4-p04-ob.smtp.rzone.de (mo4-p04-ob.smtp.rzone.de [81.169.146.176])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9976260A6F5E;
	Tue, 24 Nov 2026 07:27:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9976260A6F5E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=p3C13ci5;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=EzT9oUTg
ARC-Seal: i=1; a=rsa-sha256; t=1795505173; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=EM7Eh0cgV0pH/XHTMSM774h6ZlPadCeG898hiZMmCjsr12wZC1i4watBdi5PUkWC/A
    pApUI76bqzmz/FqPDbZgMiCyIdiy9tQSpvr2mdzoePMa663ZcwLUvZrZp5dN1Psml6ht
    qkMISfMvLyGymSAYqfbRy/g2rHYEUVMdUhVmSKHCtzGogtwC7H+dCJA/yp4nnkYTDsNP
    y1GJjCdy3lhVUX8zJj8zCdlbT3CGSD2qrlG9QV1ADLHCt2DEdu/bn5o8G5XQ+yEuTXQT
    +6sO+q1orOPUQbWbSFPwHmyUooR+rAfEk1urY5lqbCbEgY0enXVSqryfH8v+4zqDHKDB
    aqSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1795505173;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Dez18a2OqwlBFCCZ9gevwjnLnG2Bo/A/Kvv2BHdB538=;
    b=bs85ekwndRcW9ieY2FFdeQ7aCd2gI4hdSHlk4VxgvibMGzO8IhJt4BfE9DJmlO15uz
    5N9uG6Hv/FibbPTLR4Q8foXc19F/w4mraep5Zm1vDwCphX5QqWqlvQKroR+CNkKukP5b
    vn/PCwsEW4J1QtVLbQ/P0JtMyZBKSSSFMfuNZ+DVakA4Dt95LnQ08S7NGanzgp0q6t/i
    dDTkWwL7nmdaD159gwvBK9Lx8AC5Wpli9wSN1z0gth0qOfGtTdU3Ud8vQwA9iig4b0Se
    zn3fN+TXxX6U0w8dfBHUK29pcWN1xFiJtcLAGVtbtOXLDvxuRg8DkC/kav7UVoPayG/W
    ZQJg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo04
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1795505173;
    s=strato-dkim-0002; d=goldelico.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Dez18a2OqwlBFCCZ9gevwjnLnG2Bo/A/Kvv2BHdB538=;
    b=p3C13ci5DlLV0GDkqeeOmNQUTAu31vDNkt70wZ5qfVm8XRBvyk+2UJLJNQWy2fW4K0
    p7KAOk94iBC8HQ4ZziScCPkLCHYvzaOqgy2CW+n9IXxOyofp3zrAw6ldCarE69LChfSg
    dwENIkj6/wo417egJzA96IIg5jTm1/CVvTlLd5yrCFz/lM/Hkulydpem2yr9Q4yMs43i
    5ram/HbbqLZ6OIOiYtkCl6w73/CtveV5U3bsNOYkTUrGCluv2uzkgFUEoaG87OEVaEw+
    tz2dJ+9qMr7GNHtev0p3rujPZA8IPDw0jhr2tD9nSNpPU7f65IFWHuRFCxs7bGNtayFu
    PIoQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1795505173;
    s=strato-dkim-0003; d=goldelico.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Dez18a2OqwlBFCCZ9gevwjnLnG2Bo/A/Kvv2BHdB538=;
    b=EzT9oUTgfyLhyJDDM28o7VvjiMwdP/kryAjxuORRjyM+fT86rFMerFhEvGxX8RW1Zw
    3OQnJpx07/IHggTzfCBg==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9qVpwcQVkPW4I1HrV3poLlciNVTQoM6kVxzKyrKzkpjcAwdDfiN49"
Received: from iMac.fritz.box
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Qb56a22AO7QC1HJ
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 24 Nov 2026 08:26:12 +0100 (CET)
From: "H. Nikolaus Schaller" <hns@goldelico.com>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Pavel Machek <pavel@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Russell King <linux@armlinux.org.uk>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Helge Deller <deller@gmx.de>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-leds@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pwm@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	letux-kernel@openphoenux.org,
	kernel@pyra-handheld.com,
	Stefan Leichter <sle85276@gmx.de>,
	Grond <grond66@riseup.net>,
	"H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v2 07/20] ASoC: ti: omap3pandora: Convert sound card to DT
Date: Tue, 24 Nov 2026 08:25:47 +0100
Message-ID: <57d9a8b26bd2282deb9188d6913976cfee41aee9.1795505160.git.hns@goldelico.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1795505160.git.hns@goldelico.com>
References: <cover.1795505160.git.hns@goldelico.com>
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

From: Stefan Leichter <sle85276@gmx.de>

Convert the OpenPandora ASoC machine driver to bind through a Device
Tree sound-card node instead of creating a platform device from board-
specific setup code. Describe the CPU and codec DAIs and audio routes
through DT, including the external PCM1773 playback DAC.

Move the audio paths from the machine driver's hard-coded DAPM routes
to the Device Tree, and replace pr_info()/pr_err() diagnostics with
device-scoped dev_info()/dev_err() messages.

Separate playback and capture handling and use the TWL4030 APLL clock
selection interface for the audio clocks. Use device-managed resource
allocation and card registration where possible.

This removes the machine-type-dependent sound-card registration and
allows the card to probe only when described by the Device Tree.

Signed-off-by: Stefan Leichter <sle85276@gmx.de>
Suggested-by: Grond <grond66@riseup.net>
Co-developed-by: H. Nikolaus Schaller <hns@goldelico.com>
Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---

Notes:
    Changes against V1:
    - Review Sashiko's V1 findings about stream rate accounting,
      sample-rate constraints, resource lifetime and DT DAI linking.
    - Rewrite the commit message to describe the DT conversion and
      associated resource management without informal wording.
    - Credit Grond's historical contribution as Suggested-by; no current
      code authorship or DCO sign-off is asserted on Grond's behalf.
    - Original DT conversion: 1532a508d5ab (Stefan Leichter,
      2020-06-29); Grond was credited as co-developer in that commit.
    - Suggested-by preserves historical credit without asserting a
      renewed DCO sign-off from Grond.
    - Preserve existing sample-rate ownership when a repeated hw_params()
      fails; release only reservations acquired by that invocation.
    - Restore the missing int ret context line in the first diff hunk
      against Linux 7.4-rc3. This fixes git am applicability without
      changing the resulting source.
    - Code and commit-message review assisted by ChatGPT.

 sound/soc/ti/omap3pandora.c | 452 +++++++++++++++++++++++++-----------
 1 file changed, 315 insertions(+), 137 deletions(-)

diff --git a/sound/soc/ti/omap3pandora.c b/sound/soc/ti/omap3pandora.c
index 6c9c184cd9d6f..d747c0e6b48cb 100644
--- a/sound/soc/ti/omap3pandora.c
+++ b/sound/soc/ti/omap3pandora.c
@@ -6,138 +6,274 @@
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
+
+	struct mutex sample_rate_lock; // protects all fields after
+	unsigned int sample_rate;
+	int sample_rate_users;
+};
 
-static struct regulator *omap3pandora_dac_reg;
-static struct gpio_desc *dac_power_gpio;
-static struct gpio_desc *amp_power_gpio;
+static struct snd_soc_dai_link omap3pandora_dai[];
 
-static int omap3pandora_hw_params(struct snd_pcm_substream *substream,
-	struct snd_pcm_hw_params *params)
+static int omap3pandora_common_hw_params(struct snd_pcm_substream *substream,
+					 struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
-	struct snd_soc_dai *codec_dai = snd_soc_rtd_to_codec(rtd, 0);
+	__maybe_unused struct snd_soc_dai *codec_dai = snd_soc_rtd_to_codec(rtd, 0);
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
+{
+	return snd_pcm_hw_constraint_single(substream->runtime,
+					    SNDRV_PCM_HW_PARAM_RATE,
+					    sample_rate);
+}
+
+/* The McBSP playback and capture interfaces share the TWL4030 APLL. */
+static int grab_sample_rate(struct omap3pandora_sound *ctx,
+			    struct snd_pcm_substream **owner,
+			    struct snd_pcm_substream *substream,
+			    struct snd_pcm_hw_params *params,
+			    bool *new_owner)
+{
+	unsigned int rate = params_rate(params);
+	int ret = 0;
+
+	*new_owner = false;
+	mutex_lock(&ctx->sample_rate_lock);
+	if (*owner == substream) {
+		if (ctx->sample_rate != rate)
+			ret = -EINVAL;
+	} else if (*owner || (ctx->sample_rate_users &&
+				ctx->sample_rate != rate)) {
+		ret = -EINVAL;
+	} else {
+		ctx->sample_rate = rate;
+		ctx->sample_rate_users++;
+		*owner = substream;
+		*new_owner = true;
+	}
+	mutex_unlock(&ctx->sample_rate_lock);
+
+	return ret;
+}
+
+static void release_sample_rate(struct omap3pandora_sound *ctx,
+				struct snd_pcm_substream **owner,
+				struct snd_pcm_substream *substream)
+{
+	mutex_lock(&ctx->sample_rate_lock);
+	if (*owner == substream) {
+		*owner = NULL;
+		if (WARN_ON_ONCE(!ctx->sample_rate_users))
+			goto out;
+		if (!--ctx->sample_rate_users)
+			ctx->sample_rate = 0;
+	}
+out:
+	mutex_unlock(&ctx->sample_rate_lock);
+}
+
+static int omap3pandora_playback_hw_params(struct snd_pcm_substream *substream,
+					   struct snd_pcm_hw_params *params)
 {
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
+	struct snd_soc_card *card = rtd->card;
+	struct omap3pandora_sound *ctx = snd_soc_card_get_drvdata(card);
+	struct device *dev = rtd->dev;
+	struct snd_soc_pcm_runtime *tmp_rtd;
+	struct snd_soc_pcm_runtime *twl4030_rtd = NULL;
+	bool new_owner;
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
 
+	ret = grab_sample_rate(ctx, &ctx->playback_stream, substream,
+			       params, &new_owner);
+	if (ret)
+		return ret;
+
+	ret = snd_soc_dai_set_sysclk(snd_soc_rtd_to_codec(twl4030_rtd, 0),
+				     TWL4030_CLOCK_APLL, params_rate(params),
+				     SND_SOC_CLOCK_OUT);
+	if (ret) {
+		dev_err(dev, "cannot set TWL4030 APLL rate via set_sysclk interface: %d\n",
+			ret);
+		goto err_release;
+	}
+
+	ret = omap3pandora_common_hw_params(substream, params);
+	if (ret)
+		goto err_release;
 	return 0;
+
+err_release:
+	if (new_owner)
+		release_sample_rate(ctx, &ctx->playback_stream, substream);
+	return ret;
 }
 
-static int omap3pandora_hp_event(struct snd_soc_dapm_widget *w,
-	struct snd_kcontrol *k, int event)
+static int omap3pandora_capture_hw_params(struct snd_pcm_substream *substream,
+					  struct snd_pcm_hw_params *params)
 {
-	if (SND_SOC_DAPM_EVENT_ON(event))
-		gpiod_set_value(amp_power_gpio, 1);
-	else
-		gpiod_set_value(amp_power_gpio, 0);
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
+	struct snd_soc_dai *codec_dai = snd_soc_rtd_to_codec(rtd, 0);
+	struct device *dev = rtd->dev;
+	struct snd_soc_card *card = rtd->card;
+	struct omap3pandora_sound *ctx = snd_soc_card_get_drvdata(card);
+	bool new_owner;
+	int ret;
 
+	/* Set the codec system clock for DAC and ADC */
+	ret = snd_soc_dai_set_sysclk(codec_dai, 0, 26000000,
+				     SND_SOC_CLOCK_IN);
+	if (ret < 0) {
+		dev_err(dev, "cannot set TWL4030 system clock: %d\n", ret);
+		return ret;
+	}
+
+	ret = grab_sample_rate(ctx, &ctx->capture_stream, substream,
+			       params, &new_owner);
+	if (ret)
+		return ret;
+
+	ret = omap3pandora_common_hw_params(substream, params);
+	if (ret)
+		goto err_release;
 	return 0;
+
+err_release:
+	if (new_owner)
+		release_sample_rate(ctx, &ctx->capture_stream, substream);
+	return ret;
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
+static int omap3pandora_playback_hw_free(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
+	struct snd_soc_card *card = rtd->card;
+	struct omap3pandora_sound *ctx = snd_soc_card_get_drvdata(card);
 
-	SND_SOC_DAPM_MIC("Mic (internal)", NULL),
-	SND_SOC_DAPM_MIC("Mic (external)", NULL),
-	SND_SOC_DAPM_LINE("Line In", NULL),
-};
+	release_sample_rate(ctx, &ctx->playback_stream, substream);
 
-static const struct snd_soc_dapm_route omap3pandora_map[] = {
-	{"PCM DAC", NULL, "APLL Enable"},
-	{"Headphone Amplifier", NULL, "PCM DAC"},
-	{"Line Out", NULL, "PCM DAC"},
-	{"Headphone Jack", NULL, "Headphone Amplifier"},
+	return 0;
+}
 
-	{"AUXL", NULL, "Line In"},
-	{"AUXR", NULL, "Line In"},
+static int omap3pandora_common_startup(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
+	struct snd_soc_card *card = rtd->card;
+	struct omap3pandora_sound *ctx = snd_soc_card_get_drvdata(card);
+	unsigned int sample_rate;
 
-	{"MAINMIC", NULL, "Mic (internal)"},
-	{"Mic (internal)", NULL, "Mic Bias 1"},
+	mutex_lock(&ctx->sample_rate_lock);
+	sample_rate = ctx->sample_rate;
+	mutex_unlock(&ctx->sample_rate_lock);
 
-	{"SUBMIC", NULL, "Mic (external)"},
-	{"Mic (external)", NULL, "Mic Bias 2"},
-};
+	if (!sample_rate)
+		return 0;
+
+	return constrain_sample_rate(substream, sample_rate);
+}
+
+static int omap3pandora_capture_hw_free(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
+	struct snd_soc_card *card = rtd->card;
+	struct omap3pandora_sound *ctx = snd_soc_card_get_drvdata(card);
+
+	release_sample_rate(ctx, &ctx->capture_stream, substream);
+
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
@@ -171,20 +307,40 @@ static int omap3pandora_in_init(struct snd_soc_pcm_runtime *rtd)
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
+	DAILINK_COMP_ARRAY(COMP_CODEC("pcm1773-codec", "pcm1773")),
 	DAILINK_COMP_ARRAY(COMP_PLATFORM("omap-mcbsp.2")));
 
 SND_SOC_DAILINK_DEFS(in,
 	DAILINK_COMP_ARRAY(COMP_CPU("omap-mcbsp.4")),
 	DAILINK_COMP_ARRAY(COMP_CODEC("twl4030-codec", "twl4030-hifi")),
 	DAILINK_COMP_ARRAY(COMP_PLATFORM("omap-mcbsp.4")));
+#else /* IS_BUILTIN(CONFIG_SND_SOC_OMAP3_PANDORA) */
+SND_SOC_DAILINK_DEFS(out,
+		     DAILINK_COMP_ARRAY(COMP_CPU("49022000.mcbsp")),
+	DAILINK_COMP_ARRAY(COMP_CODEC("pcm1773-codec", "pcm1773")),
+	DAILINK_COMP_ARRAY(COMP_PLATFORM("49022000.mcbsp")));
+
+SND_SOC_DAILINK_DEFS(in,
+		     DAILINK_COMP_ARRAY(COMP_CPU("49026000.mcbsp")),
+	DAILINK_COMP_ARRAY(COMP_CODEC("twl4030-codec", "twl4030-hifi")),
+	DAILINK_COMP_ARRAY(COMP_PLATFORM("49026000.mcbsp")));
+#endif /* IS_BUILTIN(CONFIG_SND_SOC_OMAP3_PANDORA) */
 
 static struct snd_soc_dai_link omap3pandora_dai[] = {
 	{
@@ -192,100 +348,122 @@ static struct snd_soc_dai_link omap3pandora_dai[] = {
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
+static void omap3pandora_destroy_mutex(void *data)
 {
-	int ret;
+	struct omap3pandora_sound *ctx = data;
 
-	if (!of_machine_is_compatible("openpandora,omap3-pandora-600mhz") &&
-		!of_machine_is_compatible("openpandora,omap3-pandora-1ghz"))
-		return -ENODEV;
+	mutex_destroy(&ctx->sample_rate_lock);
+}
 
-	pr_info("OMAP3 Pandora SoC init\n");
+static int omap3pandora_probe(struct platform_device *pdev)
+{
+	int ret;
+	struct device *dev = &pdev->dev;
+	struct snd_soc_card *card = &snd_soc_card_omap3pandora;
+	struct omap3pandora_sound *ctx;
 
-	omap3pandora_snd_device = platform_device_alloc("soc-audio", -1);
-	if (omap3pandora_snd_device == NULL) {
-		pr_err(PREFIX "Platform device allocation failed\n");
+	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
 		return -ENOMEM;
-	}
 
-	platform_set_drvdata(omap3pandora_snd_device, &snd_soc_card_omap3pandora);
+	mutex_init(&ctx->sample_rate_lock);
+	ret = devm_add_action_or_reset(dev, omap3pandora_destroy_mutex, ctx);
+	if (ret)
+		return ret;
 
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
-	}
+	card->dev = dev;
 
-	omap3pandora_dac_reg = regulator_get(&omap3pandora_snd_device->dev, "vcc");
-	if (IS_ERR(omap3pandora_dac_reg)) {
-		pr_err(PREFIX "Failed to get DAC regulator from %s: %ld\n",
-			dev_name(&omap3pandora_snd_device->dev),
-			PTR_ERR(omap3pandora_dac_reg));
-		ret = PTR_ERR(omap3pandora_dac_reg);
-		goto fail3;
+	if (dev->of_node) {
+		ret = snd_soc_of_parse_card_name(card, "label");
+		if (ret)
+			card->name = "omap3pandora";
+
+		ret = snd_soc_of_parse_audio_simple_widgets(card, "widgets");
+		if (ret) {
+			dev_err(dev, "Failed to parse DAPM widgets: %d\n", ret);
+			return ret;
+		}
+
+		ret = snd_soc_of_parse_audio_routing(card, "routing");
+		if (ret) {
+			dev_err(dev, "Failed to parse audio routing: %d\n", ret);
+			return ret;
+		}
 	}
 
-	return 0;
+	snd_soc_card_set_drvdata(card, ctx);
 
-fail3:
-	platform_device_del(omap3pandora_snd_device);
-fail2:
-	platform_device_put(omap3pandora_snd_device);
+	ret = devm_snd_soc_register_card(dev, card);
+	if (ret) {
+		dev_err(dev, "Failed to register sound card: %d\n", ret);
+		return ret;
+	}
 
-	return ret;
+	return 0;
 }
-module_init(omap3pandora_soc_init);
 
-static void __exit omap3pandora_soc_exit(void)
-{
-	regulator_put(omap3pandora_dac_reg);
-	platform_device_unregister(omap3pandora_snd_device);
-}
-module_exit(omap3pandora_soc_exit);
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
+};
+
+module_platform_driver(omap3pandora_driver);
 
 MODULE_AUTHOR("Grazvydas Ignotas <notasas@gmail.com>");
 MODULE_DESCRIPTION("ALSA SoC OMAP3 Pandora");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:omap3pandora-sound");
-- 
2.56.0

