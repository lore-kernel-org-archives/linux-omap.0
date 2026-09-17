Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90814411F9F
	for <linux-omap@vger.kernel.org>; Thu, 17 Sep 2026 05:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789622653; cv=none; b=gzNEkNTQqXT1L4rAMroGl1KI5CbhTvXW7KhnOzB0RTDgMHIf5SoOVhzQ/CuOgY3cajxIoc2J4cMpeP3RuSIfkYzqVl7GAP3ErChAM9P45Q4VcXxv3m7VVXudW9V3matAjh+7zc/+hfFhxs6wqrd1Nnc+1RMxB2UYkEbCyCAOk10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789622653; c=relaxed/simple;
	bh=LOz+kG+J3+tYYVP6ckl971epwkiDBjgPiJtinKZ63gE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X+iNjcYsP+sWiJRzyQ4XaviLQMc824v1Q+I5uwvD/nxmvgsMwt4BFdSsyUOyooN/9bf/WmTXTrZHJ5PmLErFq0eodt/Jwp+kXJUgShA8gDV9Q++xE4hvVW71MLQPTRaE7veDqGxLLlvqMa0Ft4Icu7Rc+nP5Ep4S6NSI2x47XI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Stpzpt03; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Stpzpt03"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396ccd4f99dso387941a91.2
        for <linux-omap@vger.kernel.org>; Wed, 16 Sep 2026 22:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789622649; x=1790227449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MgfC2YDA5MlWY7aPX9LW2hTwGflIkNfx7ki9cO3eyQ4=;
        b=Stpzpt03yrykJqpYBHuBoVFyquFrttbc97YNG2jrHbrxttH23gU1qI4VVaDallvP94
         BHBGVsB/om4NYf9hYnbjDPeX8TQW+WTWn3dlK9esN0r6i4INkaWPJilt6u62/YGHiyhb
         ZRdrSQXtx+eflqYwxRaI/N7D5kCi/FELg+PbitAGwMIGtSitEuaD7pEGwztT3dlOMU/6
         B4PtiqVz0gPc3igx84Q0C13T28qrheY+bOArSHCS3aNfCF1U9oebNu2nXKoeIJ5eonsJ
         tztcAE9M9xSxc+DYzzGUuzjJ57dM+oJ29scNQsQIykfLuqY4xisXhRf0ERVyGMhrdUII
         Ugig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789622649; x=1790227449;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MgfC2YDA5MlWY7aPX9LW2hTwGflIkNfx7ki9cO3eyQ4=;
        b=JDUzLkwHDqkWil3vTer8Dku/XDGJ3WW55+3s6p2L1G8GJ66DEXWlJWlzmNzflBrHOf
         TmEz4y8uho81GR/i2AtdjHf7CXeZhY1ugxDeShh1HpiARuFYUqP74ewSjni6bijxOcf8
         1mZARtR8c7PE04Pv2XNkLaqtmt2WAIKvJTz9qdNJfoesEYbNPROW6q/boWA2VnNDwlg7
         e4Mo6rH1euQleTEJpU0WHSQeJHaUl5E6i8F9zYkf95CtmHIAtqz8e6z8DJjdONCcHURT
         WUe6LfRegCabCqAvC5Yn6HmyNjoMZywu4ivdxQi64YbtWkw1qV05SCFLF0e7qs9z+sAF
         nD1A==
X-Forwarded-Encrypted: i=1; AKwUvByRNmf5//eX2vUu9r3e8E13Hx9I/RhWsEQGV5TmIEjqHYETusCQzZ6v0pISMVH0LSBAWM5KnFWvbjr2@vger.kernel.org
X-Gm-Message-State: AFuF++n1vb28BE51L+qyeJTKvinULxI/91JiXSDZSxNV1kqnAiM7u0A5
	1eAClnbCdlCvjsjRHx1DLFp5avVsXcoyVGu+xdPxv0xjwiD1YuwBW/Hq
X-Gm-Gg: AYBFou1zcJ2zwiuOGPjmIRTuZOzqnsWIjjn2UqpA2ZObpKj3HtgUIfMmOlkjVizqrR+
	gIoY2pUg01FiWnWnz7fkrrS95rVT+n2EWm0u5xglclJb92PUzkRuh/rc3QZjIJ5kbeSG0rgp3M6
	L4c1yPaA3yU8x978PBDvAMDNvgztBr4up51ws49PZ36dS4SUpS9aGNHO/zNPFdrGXAjh13mPC5W
	yfCb6GPXZNUEdN0TjyzHieOojsbEr7xpw/7Wz8eBD4eAcK8bQoaZ0rzjHguO/tBdSeiBdIED+kD
	AYy0VHnkRXtoO7QmZNLQ4CUXPiIFeFUG+wRjozlOT9coJOyY2Tk9jQQeRdLTo9Z5DZf/dMXPp2m
	BcHLw+wBfsPx0e8o1/4gsHWzrj+UoMr1RVGCXZruMur1IAlDosY1BH84VN/C5wf0j6ZkPYt+GZt
	EA8OLLcW3W/wnJ+3wj4xRGRd87odfsKtG4foPhxXii6XP7YgcrBFSqn5Gsh41QOK2PfdCbW6Ud1
	/4U/3iWQ2Lv89SE17MvYPYZuQ==
X-Received: by 2002:a17:90b:1fce:b0:39e:2faa:2e83 with SMTP id 98e67ed59e1d1-39e2faa31f1mr7696392a91.10.1789622648492;
        Wed, 16 Sep 2026 22:24:08 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bf5a93f1fsm12482915eec.11.2026.09.16.22.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 22:24:08 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>
Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrei Simion <andrei.simion@microchip.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	David Rhodes <david.rhodes@cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Support Opensource <support.opensource@diasemi.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Oder Chiou <oder_chiou@realtek.com>,
	Shenghao Ding <shenghao-ding@ti.com>,
	Kevin Lu <kevin-lu@ti.com>,
	Baojun Xu <baojun.xu@ti.com>,
	Sen Wang <sen@ti.com>,
	Cezary Rojewski <cezary.rojewski@intel.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Srinivas Kandagatla <srini@kernel.org>,
	Jarkko Nikula <jarkko.nikula@bitmer.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-sound@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	patches@opensource.cirrus.com,
	linux-mediatek@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	linux-omap@vger.kernel.org
Subject: [PATCH v3] ASoC: fix typos in comments
Date: Thu, 17 Sep 2026 10:53:55 +0530
Message-ID: <20260917052355.13344-1-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typos in comments, reported by scripts/checkpatch.pl using the
misspelling list in scripts/spelling.txt.  Only touches comments, no code
changes.

v3 is v2 regenerated on top of broonie/sound.git for-next, with a
base-commit trailer so the base is unambiguous.  v2 was reported as not
applying; I could not reproduce that against for-next, for-7.4 or
for-linus, so please let me know which branch you are applying to if this
one still fails.

Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 sound/soc/atmel/atmel-pcm-dma.c            |  2 +-
 sound/soc/bcm/cygnus-ssp.h                 |  2 +-
 sound/soc/codecs/adau1701.c                |  4 ++--
 sound/soc/codecs/cs35l33.c                 |  2 +-
 sound/soc/codecs/cs35l34.c                 |  2 +-
 sound/soc/codecs/cs42l42.c                 |  2 +-
 sound/soc/codecs/cs42l73.c                 |  4 ++--
 sound/soc/codecs/cx20442.c                 |  2 +-
 sound/soc/codecs/da7210.c                  |  2 +-
 sound/soc/codecs/hdac_hda.c                |  2 +-
 sound/soc/codecs/hdac_hdmi.c               |  2 +-
 sound/soc/codecs/max98927.c                |  4 ++--
 sound/soc/codecs/mt6359.c                  |  8 ++++----
 sound/soc/codecs/nau8825.c                 | 10 +++++-----
 sound/soc/codecs/rt1320-sdw.c              |  2 +-
 sound/soc/codecs/rt5631.h                  |  8 ++++----
 sound/soc/codecs/rt5640.c                  |  2 +-
 sound/soc/codecs/rt5645.c                  |  2 +-
 sound/soc/codecs/rt5651.c                  |  2 +-
 sound/soc/codecs/rt5670.c                  |  2 +-
 sound/soc/codecs/tlv320dac33.c             |  2 +-
 sound/soc/intel/atom/sst-mfld-dsp.h        |  2 +-
 sound/soc/intel/atom/sst/sst.h             |  2 +-
 sound/soc/intel/boards/sof_cirrus_common.c |  2 +-
 sound/soc/qcom/qdsp6/q6asm-dai.c           |  2 +-
 sound/soc/ti/davinci-i2s.c                 |  2 +-
 sound/soc/ti/davinci-mcasp.c               |  2 +-
 sound/soc/ti/omap-mcbsp.c                  |  2 +-
 sound/soc/uniphier/aio.h                   |  2 +-
 sound/soc/ux500/ux500_msp_i2s.c            |  2 +-
 30 files changed, 43 insertions(+), 43 deletions(-)

diff --git a/sound/soc/atmel/atmel-pcm-dma.c b/sound/soc/atmel/atmel-pcm-dma.c
index 7306e04da513..e4b73ae3df4f 100644
--- a/sound/soc/atmel/atmel-pcm-dma.c
+++ b/sound/soc/atmel/atmel-pcm-dma.c
@@ -47,7 +47,7 @@ static const struct snd_pcm_hardware atmel_pcm_dma_hardware = {
  * atmel_pcm_dma_irq: SSC interrupt handler for DMAENGINE enabled SSC
  *
  * We use DMAENGINE to send/receive data to/from SSC so this ISR is only to
- * check if any overrun occured.
+ * check if any overrun occurred.
  */
 static void atmel_pcm_dma_irq(u32 ssc_sr,
 	struct snd_pcm_substream *substream)
diff --git a/sound/soc/bcm/cygnus-ssp.h b/sound/soc/bcm/cygnus-ssp.h
index 4925e03c3c30..7848e15efbe1 100644
--- a/sound/soc/bcm/cygnus-ssp.h
+++ b/sound/soc/bcm/cygnus-ssp.h
@@ -27,7 +27,7 @@ struct ringbuf_regs {
 	unsigned wraddr;
 	unsigned baseaddr;
 	unsigned endaddr;
-	unsigned fmark;   /* freemark for play, fullmark for caputure */
+	unsigned fmark;   /* freemark for play, fullmark for capture */
 	unsigned period_bytes;
 	unsigned buf_size;
 };
diff --git a/sound/soc/codecs/adau1701.c b/sound/soc/codecs/adau1701.c
index a1311c7b56b1..d55cdc5d4413 100644
--- a/sound/soc/codecs/adau1701.c
+++ b/sound/soc/codecs/adau1701.c
@@ -4,7 +4,7 @@
  *
  * Copyright 2011 Analog Devices Inc.
  * Author: Lars-Peter Clausen <lars@metafoo.de>
- *	based on an inital version by Cliff Cai <cliff.cai@analog.com>
+ *	based on an initial version by Cliff Cai <cliff.cai@analog.com>
  */
 
 #include <linux/module.h>
@@ -701,7 +701,7 @@ static int adau1701_probe(struct snd_soc_component *component)
 	 */
 	adau1701->pll_clkdiv = ADAU1707_CLKDIV_UNSET;
 
-	/* initalize with pre-configured pll mode settings */
+	/* initialize with pre-configured pll mode settings */
 	ret = adau1701_reset(component, adau1701->pll_clkdiv, 0);
 	if (ret < 0)
 		goto exit_regulators_disable;
diff --git a/sound/soc/codecs/cs35l33.c b/sound/soc/codecs/cs35l33.c
index d0f9231f5e44..b8c19f175701 100644
--- a/sound/soc/codecs/cs35l33.c
+++ b/sound/soc/codecs/cs35l33.c
@@ -578,7 +578,7 @@ static int cs35l33_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
 			| CS35L33_X_LOC);
 	}
 
-	/* disconnect {vp,vbst}_mon routes: eanble later if set in tx_mask*/
+	/* disconnect {vp,vbst}_mon routes: enable later if set in tx_mask*/
 	snd_soc_dapm_del_routes(dapm, cs35l33_vp_vbst_mon_route,
 		ARRAY_SIZE(cs35l33_vp_vbst_mon_route));
 
diff --git a/sound/soc/codecs/cs35l34.c b/sound/soc/codecs/cs35l34.c
index 3f265bd760f7..a72be629a31e 100644
--- a/sound/soc/codecs/cs35l34.c
+++ b/sound/soc/codecs/cs35l34.c
@@ -297,7 +297,7 @@ static int cs35l34_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
 				CS35L34_X_STATE | CS35L34_X_LOC,
 				CS35L34_X_STATE | CS35L34_X_LOC);
 
-	/* disconnect {vp,vbst}_mon routes: eanble later if set in tx_mask*/
+	/* disconnect {vp,vbst}_mon routes: enable later if set in tx_mask*/
 	while (slot >= 0) {
 		/* configure VMON_TX_LOC */
 		if (slot_num == 0)
diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index 866c21944729..84065d153ebf 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -1682,7 +1682,7 @@ irqreturn_t cs42l42_irq_thread(int irq, void *data)
 	if (cs42l42->suspended || !cs42l42->init_done)
 		return IRQ_NONE;
 
-	/* Read sticky registers to clear interurpt */
+	/* Read sticky registers to clear interrupt */
 	for (i = 0; i < ARRAY_SIZE(stickies); i++) {
 		regmap_read(cs42l42->regmap, irq_params_table[i].status_addr,
 				&(stickies[i]));
diff --git a/sound/soc/codecs/cs42l73.c b/sound/soc/codecs/cs42l73.c
index 72076ccf4570..72c4213ed74b 100644
--- a/sound/soc/codecs/cs42l73.c
+++ b/sound/soc/codecs/cs42l73.c
@@ -761,7 +761,7 @@ static const struct snd_soc_dapm_route cs42l73_audio_map[] = {
 	{"ASPOUTL", "ASP-IP Volume", "ASPL Output Mixer"},
 	{"ASPOUTR", "ASP-IP Volume", "ASPR Output Mixer"},
 
-	/* Auxillary Capture */
+	/* Auxiliary Capture */
 	{"XSPL Output Mixer", NULL, "Input Left Capture"},
 	{"XSPR Output Mixer", NULL, "Input Right Capture"},
 
@@ -1126,7 +1126,7 @@ static int cs42l73_set_bias_level(struct snd_soc_component *component,
 			mdelay(cs42l73->shutdwn_delay);
 			cs42l73->shutdwn_delay = 0;
 		} else {
-			mdelay(15); /* Min amount of time requred to power
+			mdelay(15); /* Min amount of time required to power
 				     * down.
 				     */
 		}
diff --git a/sound/soc/codecs/cx20442.c b/sound/soc/codecs/cx20442.c
index 0dea84cd8ef2..d3c7a9370220 100644
--- a/sound/soc/codecs/cx20442.c
+++ b/sound/soc/codecs/cx20442.c
@@ -200,7 +200,7 @@ static int cx20442_write(struct snd_soc_component *component, unsigned int reg,
  * Line discpline related code
  *
  * Any of the callback functions below can be used in two ways:
- * 1) registerd by a machine driver as one of line discipline operations,
+ * 1) registered by a machine driver as one of line discipline operations,
  * 2) called from a machine's provided line discipline callback function
  *    in case when extra machine specific code must be run as well.
  */
diff --git a/sound/soc/codecs/da7210.c b/sound/soc/codecs/da7210.c
index 597510de561a..40d759938edc 100644
--- a/sound/soc/codecs/da7210.c
+++ b/sound/soc/codecs/da7210.c
@@ -1158,7 +1158,7 @@ static int da7210_probe(struct snd_soc_component *component)
 	snd_soc_component_write(component, DA7210_PLL_DIV3, DA7210_MCLK_RANGE_10_20_MHZ |
 					      DA7210_PLL_BYP);
 
-	/* Diable PLL and bypass it */
+	/* Disable PLL and bypass it */
 	snd_soc_component_write(component, DA7210_PLL, DA7210_PLL_FS_48000);
 
 	/* Activate all enabled subsystem */
diff --git a/sound/soc/codecs/hdac_hda.c b/sound/soc/codecs/hdac_hda.c
index 1c06fdbf0e71..7414be08d3d5 100644
--- a/sound/soc/codecs/hdac_hda.c
+++ b/sound/soc/codecs/hdac_hda.c
@@ -520,7 +520,7 @@ static int hdac_hda_codec_probe(struct snd_soc_component *component)
 	/*
 	 * hdac_device core already sets the state to active and calls
 	 * get_noresume. So enable runtime and set the device to suspend.
-	 * pm_runtime_enable is also called during codec registeration
+	 * pm_runtime_enable is also called during codec registration
 	 */
 	pm_runtime_put(&hdev->dev);
 	pm_runtime_suspend(&hdev->dev);
diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index d9e6fa6d3e99..b3f677e7ddc9 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -1753,7 +1753,7 @@ static int hdmi_codec_resume(struct device *dev)
 	/*
 	 * As the ELD notify callback request is not entertained while the
 	 * device is in suspend state. Need to manually check detection of
-	 * all pins here. pin capablity change is not support, so use the
+	 * all pins here. pin capability change is not support, so use the
 	 * already set pin caps.
 	 *
 	 * NOTE: this is safe to call even if the codec doesn't actually resume.
diff --git a/sound/soc/codecs/max98927.c b/sound/soc/codecs/max98927.c
index d8dfaefdca7e..285c9d1ea721 100644
--- a/sound/soc/codecs/max98927.c
+++ b/sound/soc/codecs/max98927.c
@@ -672,7 +672,7 @@ static int max98927_probe(struct snd_soc_component *component)
 		     0x80);
 	regmap_write(max98927->regmap, MAX98927_R0026_PCM_TO_SPK_MONOMIX_B,
 		     0x1);
-	/* Set inital volume (+13dB) */
+	/* Set initial volume (+13dB) */
 	regmap_write(max98927->regmap, MAX98927_R0036_AMP_VOL_CTRL, 0x38);
 	regmap_write(max98927->regmap, MAX98927_R003C_SPK_GAIN, 0x05);
 	/* Enable DC blocker */
@@ -870,7 +870,7 @@ static int max98927_i2c_probe(struct i2c_client *i2c)
 	/* voltage/current slot configuration */
 	max98927_slot_config(i2c, max98927);
 
-	/* codec registeration */
+	/* codec registration */
 	ret = devm_snd_soc_register_component(&i2c->dev,
 		&soc_component_dev_max98927,
 		max98927_dai, ARRAY_SIZE(max98927_dai));
diff --git a/sound/soc/codecs/mt6359.c b/sound/soc/codecs/mt6359.c
index b15bdb15dbb0..c51eae602ca0 100644
--- a/sound/soc/codecs/mt6359.c
+++ b/sound/soc/codecs/mt6359.c
@@ -82,7 +82,7 @@ static void mt6359_reset_capture_gpio(struct mt6359_priv *priv)
 			   0x3 << 0, 0x0);
 }
 
-/* use only when doing mtkaif calibraiton at the boot time */
+/* use only when doing mtkaif calibration at the boot time */
 static void mt6359_set_dcxo(struct mt6359_priv *priv, bool enable)
 {
 	regmap_update_bits(priv->regmap, MT6359_DCXO_CW12,
@@ -90,7 +90,7 @@ static void mt6359_set_dcxo(struct mt6359_priv *priv, bool enable)
 			   (enable ? 1 : 0) << RG_XO_AUDIO_EN_M_SFT);
 }
 
-/* use only when doing mtkaif calibraiton at the boot time */
+/* use only when doing mtkaif calibration at the boot time */
 static void mt6359_set_clksq(struct mt6359_priv *priv, bool enable)
 {
 	/* Enable/disable CLKSQ 26MHz */
@@ -99,7 +99,7 @@ static void mt6359_set_clksq(struct mt6359_priv *priv, bool enable)
 			   (enable ? 1 : 0) << RG_CLKSQ_EN_SFT);
 }
 
-/* use only when doing mtkaif calibraiton at the boot time */
+/* use only when doing mtkaif calibration at the boot time */
 static void mt6359_set_aud_global_bias(struct mt6359_priv *priv, bool enable)
 {
 	regmap_update_bits(priv->regmap, MT6359_AUDDEC_ANA_CON13,
@@ -107,7 +107,7 @@ static void mt6359_set_aud_global_bias(struct mt6359_priv *priv, bool enable)
 			   (enable ? 0 : 1) << RG_AUDGLB_PWRDN_VA32_SFT);
 }
 
-/* use only when doing mtkaif calibraiton at the boot time */
+/* use only when doing mtkaif calibration at the boot time */
 static void mt6359_set_topck(struct mt6359_priv *priv, bool enable)
 {
 	regmap_update_bits(priv->regmap, MT6359_AUD_TOP_CKPDN_CON0,
diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
index 5165aeba4b67..2eb0efc983a0 100644
--- a/sound/soc/codecs/nau8825.c
+++ b/sound/soc/codecs/nau8825.c
@@ -345,10 +345,10 @@ static u32 nau8825_intlog10_dec3(u32 value)
 /**
  * nau8825_xtalk_sidetone - computes cross talk suppression sidetone gain.
  *
- * @sig_org: orignal signal level
+ * @sig_org: original signal level
  * @sig_cros: cross talk signal level
  *
- * The orignal and cross talk signal vlues need to be characterized.
+ * The original and cross talk signal vlues need to be characterized.
  * Once these values have been characterized, this sidetone value
  * can be converted to decibel with the equation below.
  * sidetone = 20 * log (original signal level / crosstalk signal level)
@@ -671,11 +671,11 @@ static void nau8825_xtalk_imm_stop(struct nau8825 *nau8825)
  * Thus, the measurement function has four states to complete whole sequence.
  * 1. Prepare state : Prepare the resource for detection and transfer to HPR
  *     IMM stat to make JKR1(HPR) impedance measure.
- * 2. HPR IMM state : Read out orignal signal level of JKR1(HPR) and transfer
+ * 2. HPR IMM state : Read out original signal level of JKR1(HPR) and transfer
  *     to HPL IMM state to make JKTIP(HPL) impedance measure.
  * 3. HPL IMM state : Read out cross talk signal level of JKTIP(HPL) and
  *     transfer to IMM state to determine suppression sidetone gain.
- * 4. IMM state : Computes cross talk suppression sidetone gain with orignal
+ * 4. IMM state : Computes cross talk suppression sidetone gain with original
  *     and cross talk signal level. Apply this gain and then restore codec
  *     configuration. Then transfer to Done state for ending.
  */
@@ -724,7 +724,7 @@ static void nau8825_xtalk_measure(struct nau8825 *nau8825)
 		nau8825->xtalk_state = NAU8825_XTALK_IMM;
 		break;
 	case NAU8825_XTALK_IMM:
-		/* In impedance measure state, the orignal and cross talk
+		/* In impedance measure state, the original and cross talk
 		 * signal level vlues are ready. The side tone gain is deter-
 		 * mined with these signal level. After all, restore codec
 		 * configuration.
diff --git a/sound/soc/codecs/rt1320-sdw.c b/sound/soc/codecs/rt1320-sdw.c
index 444a91755be9..b13622e54ae0 100644
--- a/sound/soc/codecs/rt1320-sdw.c
+++ b/sound/soc/codecs/rt1320-sdw.c
@@ -2084,7 +2084,7 @@ static int rt1320_rae_load(struct rt1320_sdw_priv *rt1320)
 		regmap_update_bits(rt1320->regmap, 0x20005818, 0x80, 0x80);
 		/* RAE run */
 		regmap_update_bits(rt1320->regmap, 0x2000301c, 0x01, 0x01);
-		/* Phase sync eanble */
+		/* Phase sync enable */
 		regmap_update_bits(rt1320->regmap, 0xc047, 0x80, 0x80);
 		break;
 	}
diff --git a/sound/soc/codecs/rt5631.h b/sound/soc/codecs/rt5631.h
index 8a6b99a48c7c..00734207ac9f 100644
--- a/sound/soc/codecs/rt5631.h
+++ b/sound/soc/codecs/rt5631.h
@@ -415,7 +415,7 @@
 #define RT5631_ADDA_FILTER_CLK_SEL_256FS		(0 << 7) /* 256FS */
 #define RT5631_ADDA_FILTER_CLK_SEL_384FS		(1 << 7) /* 384FS */
 
-/* Power managment addition 1 (0x3A) */
+/* Power management addition 1 (0x3A) */
 #define RT5631_PWR_MAIN_I2S_EN			(0x1 << 15)
 #define RT5631_PWR_MAIN_I2S_BIT			15
 #define RT5631_PWR_CLASS_D				(0x1 << 12)
@@ -435,7 +435,7 @@
 #define RT5631_PWR_DAC_R_TO_MIXER			(0x1 << 5)
 #define RT5631_PWR_DAC_R_TO_MIXER_BIT		5
 
-/* Power managment addition 2 (0x3B) */
+/* Power management addition 2 (0x3B) */
 #define RT5631_PWR_OUTMIXER_L				(0x1 << 15)
 #define RT5631_PWR_OUTMIXER_L_BIT			15
 #define RT5631_PWR_OUTMIXER_R				(0x1 << 14)
@@ -461,7 +461,7 @@
 #define RT5631_PWR_PLL2				(0x1 << 0)
 #define RT5631_PWR_PLL2_BIT				0
 
-/* Power managment addition 3(0x3C) */
+/* Power management addition 3(0x3C) */
 #define RT5631_PWR_VREF				(0x1 << 15)
 #define RT5631_PWR_VREF_BIT				15
 #define RT5631_PWR_FAST_VREF_CTRL			(0x1 << 14)
@@ -489,7 +489,7 @@
 #define RT5631_PWR_HP_AMP_DRIVING			(0x1 << 0)
 #define RT5631_PWR_HP_AMP_DRIVING_BIT		0
 
-/* Power managment addition 4(0x3E) */
+/* Power management addition 4(0x3E) */
 #define RT5631_PWR_SPK_L_VOL				(0x1 << 15)
 #define RT5631_PWR_SPK_L_VOL_BIT			15
 #define RT5631_PWR_SPK_R_VOL				(0x1 << 14)
diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index 4fa1eee8e87f..03d0ac3359f5 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -1216,7 +1216,7 @@ static const struct snd_soc_dapm_widget rt5640_dapm_widgets[] = {
 		0, rt5640_spk_l_mix, ARRAY_SIZE(rt5640_spk_l_mix)),
 	SND_SOC_DAPM_MIXER("SPK MIXR", RT5640_PWR_MIXER, RT5640_PWR_SM_R_BIT,
 		0, rt5640_spk_r_mix, ARRAY_SIZE(rt5640_spk_r_mix)),
-	/* Ouput Volume */
+	/* Output Volume */
 	SND_SOC_DAPM_PGA("SPKVOL L", RT5640_PWR_VOL,
 		RT5640_PWR_SV_L_BIT, 0, NULL, 0),
 	SND_SOC_DAPM_PGA("SPKVOL R", RT5640_PWR_VOL,
diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index bf9f278c3de9..bb448254275f 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -2209,7 +2209,7 @@ static const struct snd_soc_dapm_widget rt5645_dapm_widgets[] = {
 		0, rt5645_out_l_mix, ARRAY_SIZE(rt5645_out_l_mix)),
 	SND_SOC_DAPM_MIXER("OUT MIXR", RT5645_PWR_MIXER, RT5645_PWR_OM_R_BIT,
 		0, rt5645_out_r_mix, ARRAY_SIZE(rt5645_out_r_mix)),
-	/* Ouput Volume */
+	/* Output Volume */
 	SND_SOC_DAPM_SWITCH("SPKVOL L", RT5645_PWR_VOL, RT5645_PWR_SV_L_BIT, 0,
 		&spk_l_vol_control),
 	SND_SOC_DAPM_SWITCH("SPKVOL R", RT5645_PWR_VOL, RT5645_PWR_SV_R_BIT, 0,
diff --git a/sound/soc/codecs/rt5651.c b/sound/soc/codecs/rt5651.c
index 9723b4c7540c..b911757376f5 100644
--- a/sound/soc/codecs/rt5651.c
+++ b/sound/soc/codecs/rt5651.c
@@ -1024,7 +1024,7 @@ static const struct snd_soc_dapm_widget rt5651_dapm_widgets[] = {
 			   0, rt5651_out_l_mix, ARRAY_SIZE(rt5651_out_l_mix)),
 	SND_SOC_DAPM_MIXER("OUT MIXR", RT5651_PWR_MIXER, RT5651_PWR_OM_R_BIT,
 			   0, rt5651_out_r_mix, ARRAY_SIZE(rt5651_out_r_mix)),
-	/* Ouput Volume */
+	/* Output Volume */
 	SND_SOC_DAPM_SWITCH("OUTVOL L", RT5651_PWR_VOL,
 			    RT5651_PWR_OV_L_BIT, 0, &outvol_l_control),
 	SND_SOC_DAPM_SWITCH("OUTVOL R", RT5651_PWR_VOL,
diff --git a/sound/soc/codecs/rt5670.c b/sound/soc/codecs/rt5670.c
index f772f093479a..62d4e7cea5af 100644
--- a/sound/soc/codecs/rt5670.c
+++ b/sound/soc/codecs/rt5670.c
@@ -1901,7 +1901,7 @@ static const struct snd_soc_dapm_widget rt5670_dapm_widgets[] = {
 			   0, rt5670_out_l_mix, ARRAY_SIZE(rt5670_out_l_mix)),
 	SND_SOC_DAPM_MIXER("OUT MIXR", RT5670_PWR_MIXER, RT5670_PWR_OM_R_BIT,
 			   0, rt5670_out_r_mix, ARRAY_SIZE(rt5670_out_r_mix)),
-	/* Ouput Volume */
+	/* Output Volume */
 	SND_SOC_DAPM_MIXER("HPOVOL MIXL", RT5670_PWR_VOL,
 			   RT5670_PWR_HV_L_BIT, 0,
 			   rt5670_hpvoll_mix, ARRAY_SIZE(rt5670_hpvoll_mix)),
diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
index 55a95b62a650..b91ab42882d1 100644
--- a/sound/soc/codecs/tlv320dac33.c
+++ b/sound/soc/codecs/tlv320dac33.c
@@ -914,7 +914,7 @@ static int dac33_prepare_chip(struct snd_pcm_substream *substream,
 	/* OSC calibration time */
 	dac33_write(component, DAC33_CALIB_TIME, 96);
 
-	/* adjustment treshold & step */
+	/* adjustment threshold & step */
 	dac33_write(component, DAC33_INT_OSC_CTRL_B, DAC33_ADJTHRSHLD(2) |
 						 DAC33_ADJSTEP(1));
 
diff --git a/sound/soc/intel/atom/sst-mfld-dsp.h b/sound/soc/intel/atom/sst-mfld-dsp.h
index c8f0816edb53..59606259a06e 100644
--- a/sound/soc/intel/atom/sst-mfld-dsp.h
+++ b/sound/soc/intel/atom/sst-mfld-dsp.h
@@ -189,7 +189,7 @@ struct ipc_dsp_hdr {
 union ipc_header_high {
 	struct {
 		u32  msg_id:8;	    /* Message ID - Max 256 Message Types */
-		u32  task_id:4;	    /* Task ID associated with this comand */
+		u32  task_id:4;	    /* Task ID associated with this command */
 		u32  drv_id:4;    /* Identifier for the driver to track*/
 		u32  rsvd1:8;	    /* Reserved */
 		u32  result:4;	    /* Reserved */
diff --git a/sound/soc/intel/atom/sst/sst.h b/sound/soc/intel/atom/sst/sst.h
index c43946c5ecee..e24d9dad7ef6 100644
--- a/sound/soc/intel/atom/sst/sst.h
+++ b/sound/soc/intel/atom/sst/sst.h
@@ -182,7 +182,7 @@ struct sst_block {
  * @pcm_substream : PCM substream
  * @period_elapsed : PCM period elapsed callback
  * @sfreq : stream sampling freq
- * @cumm_bytes : cummulative bytes decoded
+ * @cumm_bytes : cumulative bytes decoded
  */
 struct stream_info {
 	unsigned int		status;
diff --git a/sound/soc/intel/boards/sof_cirrus_common.c b/sound/soc/intel/boards/sof_cirrus_common.c
index 88fc6cb2bfd4..ec4bda40ae00 100644
--- a/sound/soc/intel/boards/sof_cirrus_common.c
+++ b/sound/soc/intel/boards/sof_cirrus_common.c
@@ -151,7 +151,7 @@ static const char * const cs35l41_name_prefixes[] = { "WL", "WR", "TL", "TR" };
  * UID 0x2 -> TL
  * UID 0x3 -> TR
  * Note: If there are less than 4 Amps, UIDs still map to WL/WR/TL/TR. Dynamic code will only create
- * dai links for UIDs which exist, and ignore non-existant ones. Only 2 or 4 amps are expected.
+ * dai links for UIDs which exist, and ignore non-existent ones. Only 2 or 4 amps are expected.
  * Return number of codecs found.
  */
 static int cs35l41_compute_codec_conf(void)
diff --git a/sound/soc/qcom/qdsp6/q6asm-dai.c b/sound/soc/qcom/qdsp6/q6asm-dai.c
index 4f09fdd40905..cd4f82bb8cc7 100644
--- a/sound/soc/qcom/qdsp6/q6asm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6asm-dai.c
@@ -551,7 +551,7 @@ static void compress_event_handler(uint32_t opcode, uint32_t token,
 						 prtd->stream_id,
 						 CMD_CLOSE);
 				/*
-				 * vaild stream ids start from 1, So we are
+				 * valid stream ids start from 1, So we are
 				 * toggling this between 1 and 2.
 				 */
 				prtd->stream_id = (prtd->stream_id == 1 ? 2 : 1);
diff --git a/sound/soc/ti/davinci-i2s.c b/sound/soc/ti/davinci-i2s.c
index ec7eb2f19b6f..3614f614117d 100644
--- a/sound/soc/ti/davinci-i2s.c
+++ b/sound/soc/ti/davinci-i2s.c
@@ -49,7 +49,7 @@
  *    incompatible with ASP and with either McBSP.
  *
  * In short:  this uses ASP to implement I2S, not McBSP.
- * And it won't be the only DaVinci implemention of I2S.
+ * And it won't be the only DaVinci implementation of I2S.
  */
 #define DAVINCI_MCBSP_DRR_REG	0x00
 #define DAVINCI_MCBSP_DXR_REG	0x04
diff --git a/sound/soc/ti/davinci-mcasp.c b/sound/soc/ti/davinci-mcasp.c
index ad9e194a3d0d..d461ab419655 100644
--- a/sound/soc/ti/davinci-mcasp.c
+++ b/sound/soc/ti/davinci-mcasp.c
@@ -1818,7 +1818,7 @@ static int davinci_mcasp_startup(struct snd_pcm_substream *substream,
 	    !mcasp->async_mode)
 		max_channels = mcasp->channels;
 	/*
-	 * But we can always allow channels upto the amount of
+	 * But we can always allow channels up to the amount of
 	 * the available tdm_slots.
 	 */
 	if (max_channels < tdm_slots)
diff --git a/sound/soc/ti/omap-mcbsp.c b/sound/soc/ti/omap-mcbsp.c
index 5734388a4e4b..889e357b64d0 100644
--- a/sound/soc/ti/omap-mcbsp.c
+++ b/sound/soc/ti/omap-mcbsp.c
@@ -1237,7 +1237,7 @@ static int omap_mcbsp_dai_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
 		break;
 	case OMAP_MCBSP_SYSCLK_CLKR_EXT:
 		regs->pcr0	|= SCLKME;
-		/* Disable ouput on CLKR pin in master mode */
+		/* Disable output on CLKR pin in master mode */
 		regs->pcr0	&= ~CLKRM;
 		break;
 	default:
diff --git a/sound/soc/uniphier/aio.h b/sound/soc/uniphier/aio.h
index 1900ea01ce3d..87b27256cf80 100644
--- a/sound/soc/uniphier/aio.h
+++ b/sound/soc/uniphier/aio.h
@@ -183,7 +183,7 @@ struct uniphier_aio_selector {
  *
  * These are examples for sound data paths:
  *
- * For caputure device:
+ * For capture device:
  *   (outer of AIO) -> iport -> iif -> ch -> rb -> (CPU)
  * For playback device:
  *   (CPU) -> rb -> ch -> oif -> oport -> (outer of AIO)
diff --git a/sound/soc/ux500/ux500_msp_i2s.c b/sound/soc/ux500/ux500_msp_i2s.c
index 683b485fb570..bd2cfc618290 100644
--- a/sound/soc/ux500/ux500_msp_i2s.c
+++ b/sound/soc/ux500/ux500_msp_i2s.c
@@ -19,7 +19,7 @@
 
 #include "ux500_msp_i2s.h"
 
- /* Protocol desciptors */
+ /* Protocol descriptors */
 static const struct msp_protdesc prot_descs[] = {
 	{ /* I2S */
 		MSP_SINGLE_PHASE,

base-commit: 260a144af70c8babbf2f15d1a56bacfa83f8aef6
-- 
2.48.1

