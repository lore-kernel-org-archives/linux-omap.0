Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795494870;
	b=wystQpctwNOMYaG6qIYywWSC9/nebE0HMn7f4pyMyxSMj7WWpiHnONwhh9pGXtGPz5zV
	 KwO2iVsY3ku4ka4SICG52ZkjYLFsLvjzEMOCw24IpZYiEpK+Frqh6lrfCRgTBEn7XXuYN
	 BstGh/umzkuQpMoMgalPqgx/QuVPrla2236XQb2Iw7IG6KPBT2Qvdd+QIougTdo7eBo+p
	 wMcStWAwGdEkkrVOe+VmMDDxREJPkeRJGZbTPhT8pflOLJg0KMzx2kDG3y1tA3xGV6BZF
	 +LSa888kRdCMIWY6+cT3QSNIVS4BiUULYXlAt+UfpZUkXh1DUIsI/JmenC1kB3RXtVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795494870;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=HTlmST/xYrIlNhX6Z/+P3yHLslJj73t8e3mXrd54ttc=;
	b=k/r30kqgSrj/T2ZJfxpMmQaVbCI5MmmvI8PG66f2lz0gWh+5qWToQUEDERas3c1cjSmA
	 jvckBmPKVSNfoeXiRVpU6xcXrx8CHHHu7jqjRoLOdOJnBQ3hybI3qK4QAVX4slGUIKS92
	 404TK3nHasOl0EB8Wv2j2h7BRQJey68TGKu2JCIgRT4/RX/arBdY6/MIihgQhQ1CfFhbe
	 9kns6HKPsywe2mNqOBmpm+rwPqd1ma/tBDa6qcnxGaX2OVxRCIgNabDDp6IhX1J04LH0d
	 GWrT29/bXaRiDitoIifjlKUnUwg9GT36Tw8Z8kDxrqf65BK2XezcJGmF6ukKycs7Bnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=telaak.dev;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.128.179
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34914606A333
	for <linux-omap@vger.kernel.org>; Tue, 24 Nov 2026 04:34:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34914606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=telaak.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-8b4b9ba815bso22852007b3.3
        for <linux-omap@vger.kernel.org>; Mon, 23 Nov 2026 20:34:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795494868; x=1796099668;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HTlmST/xYrIlNhX6Z/+P3yHLslJj73t8e3mXrd54ttc=;
        b=p/QydkCyrAvJzu1/kb+Rj9chGA4D19J8Q1c140QExMTMJM8ya230H0z0uvOYdyk8q4
         /AXzVMaYdjIE4rsnDqwlzo2/d5NzpcyXmY/izaQd5WXMzkTrngsddpwBDchiu9gY+Bgp
         QpnMLqFLk4ZCnByE4bjP0K860HtHhcZ/4ISbFYCEo7xwYdtdTDlDiK9Z4rNFoBCVFgNH
         RYDoSNh1v/EAcBUfroBn91rrc7IM9E2845xhxbnuBT3uPdBoJwrB2ybbyY9cHfw5Xqpz
         CEXJTydfkIfO68iOmKGn6JPBEGKYDxxDeei4mvPomxaAWcx4OpWy4uUd63Xxx9QV87Ak
         KwEA==
X-Forwarded-Encrypted: i=1; AL+hErEJgJQ7qXGq16qVlrCBwMnEDwaqEKjrjfRsS1m/n8KFbdb4gY4/e47BuLc6EUj8uNnkx4wJDis7y3yb@vger.kernel.org
X-Gm-Message-State: APuU4Z+PZO7e8kk+30Mw8Y+QKD5tAlDqz0iWZjQo+4GC+KV0CU2YjzRe
	Lter0+I0uP0kG8LcgfQjLGThIjHLClj27Vh1nideZ/G6sgLiNfHGwL9m
X-Gm-Gg: AZFdTZdhm5G0XFHTUSIvl/a4ZcZrB2/T3ROTFAolInpX/3c8IBYLpUEA3WO05r0VLQ3
	VzujFwb2UgOzvSCQC96CPkVffoWotfYiiL+y8KTrH5YNkeFbg2KOTXdnYHL5VLTI3oYdh1kJy7+
	rN25DcCQy+eYUooq8j4lV16/GJnY+2kumRvUFwevEW7w0jh9pTm469jhzGVIvgkr28nfeGJzY5f
	IQRfJJgnjaG9+h8RxTxI4G3SBAu9el7GnOJJEf9AyELnYFt08UO4NHpMHuTagVT6kZftDAbSL3z
	CUbQio+yuG7ErFQnu4wz3gFt7anKIcKIxH6zoqIBSRvMq+cqjL82O0jz/cExeYGzPQRdQlupvhz
	VEfSEHahKdpwe/UC4JxliEtcT2PSGATxYos8ZLC5q2V53s4rP246T3O2Fv/EzqepkYYssUk3sbM
	edUeGf4L4e6t7h8zRHylGRbg6hlXrzxYQVsXcFdy1stVELZ5oCLRSFKwiqA8JTdD3U8+aLbsmFG
	+PTWr7t8ShjBtBBXx1ZBJIZTMdZpNmH8uPo3fMg+GzCxPM1/yXGHR8ZCMW2hrtA6gNME2Jknz7l
	0BfB2VYj0uZzASCkTutGnnePxLlx1MRW0lmJYx+05QC3XU/eVQGs+mWZ/n45uJqNkHStMGsI/Wa
	RenokLotz69onKwb613X6yXF8SSVso6f/ocBuIyL/BF5IEKj8kn9X4Pp0COIxRBc+nxYFlDV9WX
	Rotq9AyWOFvJ/7KV2cltvG4DAC
X-Received: by 2002:a05:690c:b1b:b0:8b4:ccfc:e38a with SMTP id 00721157ae682-8b5204981a4mr64171497b3.25.1795494868132;
        Mon, 23 Nov 2026 20:34:28 -0800 (PST)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([71.68.170.161])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b5202fb0a2sm53106397b3.27.2026.11.23.20.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 20:34:27 -0800 (PST)
From: Joseph Telaak <joseph@telaak.dev>
Date: Mon, 23 Nov 2026 23:34:21 -0500
Subject: [PATCH v2 2/2] ASoC: ti: omap-mcbsp: Implement set_tdm_slot
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-omap-mcbsp-tdm-slot-v2-2-3e3aae215952@telaak.dev>
References: <20261123-omap-mcbsp-tdm-slot-v2-0-3e3aae215952@telaak.dev>
In-Reply-To: <20261123-omap-mcbsp-tdm-slot-v2-0-3e3aae215952@telaak.dev>
To: Jarkko Nikula <jarkko.nikula@bitmer.com>, Sen Wang <sen@ti.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org, linux-omap@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Joseph Telaak <joseph@telaak.dev>
X-Mailer: b4 0.16.0

As bit clock and frame provider, McBSP sizes the frame from the SRG
input, the set_clkdiv() divider and the rate. Only a machine driver can
call set_clkdiv(), so with simple-audio-card or audio-graph-card the
divider stays 1 and the bit clock runs at the full SRG input: 96 MHz on
OMAP3, a 2000-bit frame at 48 kHz.

Implement set_tdm_slot() so these cards can ask for a frame of slots x
slot_width bit clocks with dai-tdm-slot-num and dai-tdm-slot-width.
hw_params() then picks the divider for the rate. McBSP sends a frame's
words back to back, so a sample must fill its slot and the channels fill
the active slots, which must be the low ones. Both directions share the
frame, so non-empty TX and RX masks need the same number of slots, and
I2S or left-justified need two slots.

startup() pins the channels and sample width to the slots. If the sysclk
was set outside a stream, as simple-audio-card does at init, it also
limits the rates to those the sysclk divides to within 0.1%, the IEC
60958 level II clock tolerance. hw_params() checks the stream against
the slots and the sysclk, including one a card sets in hw_params(). A
sysclk from the internal fclk must be that clock's rate. McBSP has no
MCLK output, so simple-card's mclk-fs, which passes rate x fs, is
refused instead of giving a wrong bit clock.

Both directions share the sample rate generator: once one is configured,
until its hw_free(), the other must use the same rate and sysclk, and a
stream on its own reprograms McBSP on each hw_params(). set_tdm_slot()
can't change the slots while McBSP is configured. This applies only when
McBSP provides both clocks, which is why the core's symmetric_rate isn't
used: as clock consumer, the directions can run at different rates.
Without slots nothing changes.

Tested on an OMAP3630 board whose McBSP4 drives the I2S input of an
ADV7513 with no MCLK, with 2 x 32-bit slots and adv7511 taking S32_LE: a
left-only and a right-only 44.1 kHz tone each play on their own side (96
MHz / 34 gives 44117.6 Hz). 48 kHz (0.8% off), S16_LE and mono are
refused, and plughw converts them.

Signed-off-by: Joseph Telaak <joseph@telaak.dev>
---
 sound/soc/ti/omap-mcbsp-priv.h |  13 ++
 sound/soc/ti/omap-mcbsp.c      | 334 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 344 insertions(+), 3 deletions(-)

diff --git a/sound/soc/ti/omap-mcbsp-priv.h b/sound/soc/ti/omap-mcbsp-priv.h
index 324c5d7d431d..cb687b72eb44 100644
--- a/sound/soc/ti/omap-mcbsp-priv.h
+++ b/sound/soc/ti/omap-mcbsp-priv.h
@@ -275,6 +275,19 @@ struct omap_mcbsp {
 	unsigned int latency[2];
 	int clk_div;
 	int wlen;
+	unsigned int slots;
+	unsigned int slot_width;
+	unsigned int tx_slots;
+	unsigned int rx_slots;
+	/* Rate and sysclk the slots were configured for */
+	unsigned int slot_rate;
+	unsigned int slot_sysclk;
+	/* Directions configured with slots, BIT(stream) */
+	unsigned int slot_streams;
+	/* in_freq was set outside a stream */
+	bool sysclk_static;
+	/* The SRG runs from the internal fclk */
+	bool sysclk_fclk;
 
 	struct pm_qos_request pm_qos_req;
 };
diff --git a/sound/soc/ti/omap-mcbsp.c b/sound/soc/ti/omap-mcbsp.c
index 6e0c7d7359f4..354bb86bf4da 100644
--- a/sound/soc/ti/omap-mcbsp.c
+++ b/sound/soc/ti/omap-mcbsp.c
@@ -759,12 +759,235 @@ static int omap_mcbsp_hwrule_min_buffersize(struct snd_pcm_hw_params *params,
 	return snd_interval_refine(buffer_size, &frames);
 }
 
+static const unsigned int omap_mcbsp_slot_rates[] = {
+	8000, 11025, 16000, 22050, 32000, 44100, 48000, 64000, 88200, 96000,
+};
+
+/*
+ * The SRG divider that runs a frame of slots x slot_width bit clocks at
+ * @rate, or 0 if none gets within 0.1% (IEC 60958 level II).
+ */
+static unsigned int omap_mcbsp_slot_div(struct omap_mcbsp *mcbsp,
+					unsigned int rate)
+{
+	unsigned int bclk = rate * mcbsp->slots * mcbsp->slot_width;
+	unsigned int div;
+
+	if (!bclk || !mcbsp->in_freq)
+		return 0;
+
+	div = DIV_ROUND_CLOSEST(mcbsp->in_freq, bclk);
+	if (!div || div > 256)
+		return 0;
+	if (abs_diff(mcbsp->in_freq / div, bclk) > bclk / 1000)
+		return 0;
+
+	return div;
+}
+
+static unsigned int omap_mcbsp_slot_rate_list(struct omap_mcbsp *mcbsp,
+					      unsigned int *list)
+{
+	unsigned int i, n = 0;
+
+	for (i = 0; i < ARRAY_SIZE(omap_mcbsp_slot_rates); i++)
+		if (omap_mcbsp_slot_div(mcbsp, omap_mcbsp_slot_rates[i]))
+			list[n++] = omap_mcbsp_slot_rates[i];
+
+	return n;
+}
+
+/*
+ * The sysclk the SRG divides, or 0 if none is usable. From the internal fclk
+ * it must be that clock's rate: simple-card's mclk-fs passes rate x fs.
+ */
+static unsigned int omap_mcbsp_slot_sysclk(struct omap_mcbsp *mcbsp)
+{
+	if (mcbsp->sysclk_fclk && mcbsp->in_freq != clk_get_rate(mcbsp->fclk))
+		return 0;
+
+	return mcbsp->in_freq;
+}
+
+/* Slots only apply when McBSP provides the bit clock and the frame */
+static bool omap_mcbsp_slots_on(struct omap_mcbsp *mcbsp)
+{
+	return mcbsp->slot_width &&
+	       (mcbsp->fmt & SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK) ==
+	       SND_SOC_DAIFMT_BP_FP;
+}
+
+/* Whether the other direction has a stream configured with slots */
+static bool omap_mcbsp_slot_other(struct omap_mcbsp *mcbsp, int stream)
+{
+	return mcbsp->slot_streams & ~BIT(stream);
+}
+
+static int omap_mcbsp_slot_rate_refine(struct snd_pcm_hw_params *params,
+				       struct omap_mcbsp *mcbsp, int stream)
+{
+	struct snd_interval *rate = hw_param_interval(params,
+						      SNDRV_PCM_HW_PARAM_RATE);
+	unsigned int list[ARRAY_SIZE(omap_mcbsp_slot_rates)];
+	unsigned int n;
+
+	/* Slots cleared since open: no rates to compute */
+	if (!omap_mcbsp_slots_on(mcbsp))
+		return 0;
+	/* Both directions share the sample rate generator */
+	if (omap_mcbsp_slot_other(mcbsp, stream))
+		return snd_interval_list(rate, 1, &mcbsp->slot_rate, 0);
+	/* A sysclk a card sets in hw_params() is checked there */
+	if (!mcbsp->sysclk_static || !omap_mcbsp_slot_sysclk(mcbsp))
+		return 0;
+
+	n = omap_mcbsp_slot_rate_list(mcbsp, list);
+	return snd_interval_list(rate, n, list, 0);
+}
+
+static int omap_mcbsp_hwrule_tx_rate(struct snd_pcm_hw_params *params,
+				     struct snd_pcm_hw_rule *rule)
+{
+	return omap_mcbsp_slot_rate_refine(params, rule->private,
+					   SNDRV_PCM_STREAM_PLAYBACK);
+}
+
+static int omap_mcbsp_hwrule_rx_rate(struct snd_pcm_hw_params *params,
+				     struct snd_pcm_hw_rule *rule)
+{
+	return omap_mcbsp_slot_rate_refine(params, rule->private,
+					   SNDRV_PCM_STREAM_CAPTURE);
+}
+
+static unsigned int omap_mcbsp_slots_active(struct omap_mcbsp *mcbsp,
+					    int stream)
+{
+	if (stream == SNDRV_PCM_STREAM_PLAYBACK)
+		return mcbsp->tx_slots;
+	return mcbsp->rx_slots;
+}
+
+/* Checks that don't depend on the stream's params */
+static int omap_mcbsp_slot_check(struct omap_mcbsp *mcbsp, int stream)
+{
+	unsigned int format = mcbsp->fmt & SND_SOC_DAIFMT_FORMAT_MASK;
+
+	if ((format == SND_SOC_DAIFMT_I2S || format == SND_SOC_DAIFMT_LEFT_J) &&
+	    mcbsp->slots != 2) {
+		dev_err(mcbsp->dev, "I2S/LEFT_J needs 2 slots, not %u\n",
+			mcbsp->slots);
+		return -EINVAL;
+	}
+	if (!omap_mcbsp_slots_active(mcbsp, stream)) {
+		dev_dbg(mcbsp->dev, "no %s slots in the TDM mask\n",
+			stream == SNDRV_PCM_STREAM_PLAYBACK ? "TX" : "RX");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/* The params against the slots, the sysclk and the other direction */
+static int omap_mcbsp_slot_params_check(struct omap_mcbsp *mcbsp, int stream,
+					struct snd_pcm_hw_params *params)
+{
+	unsigned int active = omap_mcbsp_slots_active(mcbsp, stream);
+	unsigned int rate = params_rate(params);
+	int ret;
+
+	ret = omap_mcbsp_slot_check(mcbsp, stream);
+	if (ret)
+		return ret;
+	if (params_channels(params) != active ||
+	    params_physical_width(params) != mcbsp->slot_width) {
+		dev_dbg(mcbsp->dev,
+			"%u x %u-bit samples do not fill %u x %u-bit slots\n",
+			params_channels(params), params_physical_width(params),
+			active, mcbsp->slot_width);
+		return -EINVAL;
+	}
+	if (!mcbsp->in_freq) {
+		dev_err(mcbsp->dev, "no sysclk set\n");
+		return -EINVAL;
+	}
+	if (!omap_mcbsp_slot_sysclk(mcbsp)) {
+		dev_err(mcbsp->dev, "sysclk %u Hz is not the %lu Hz fclk\n",
+			mcbsp->in_freq, clk_get_rate(mcbsp->fclk));
+		return -EINVAL;
+	}
+	if (omap_mcbsp_slot_other(mcbsp, stream) &&
+	    (rate != mcbsp->slot_rate ||
+	     mcbsp->in_freq != mcbsp->slot_sysclk)) {
+		dev_dbg(mcbsp->dev,
+			"%u Hz: other direction at %u Hz from sysclk %u Hz\n",
+			rate, mcbsp->slot_rate, mcbsp->slot_sysclk);
+		return -EINVAL;
+	}
+	if (!omap_mcbsp_slot_div(mcbsp, rate)) {
+		dev_dbg(mcbsp->dev, "no divider for %u Hz from sysclk %u Hz\n",
+			rate, mcbsp->in_freq);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/*
+ * With TDM slots the frame is slots x slot_width bit clocks. McBSP sends its
+ * words back to back, so a sample must fill its slot, the channels fill the
+ * active slots, and I2S/left-justified (one word per phase) need two slots.
+ */
+static int omap_mcbsp_slot_constraints(struct snd_pcm_substream *substream,
+				       struct omap_mcbsp *mcbsp)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	unsigned int active = omap_mcbsp_slots_active(mcbsp, substream->stream);
+	unsigned int list[ARRAY_SIZE(omap_mcbsp_slot_rates)];
+	snd_pcm_hw_rule_func_t rule;
+	int ret;
+
+	ret = omap_mcbsp_slot_check(mcbsp, substream->stream);
+	if (ret)
+		return ret;
+	if (mcbsp->sysclk_static && omap_mcbsp_slot_sysclk(mcbsp) &&
+	    !mcbsp->slot_streams &&
+	    !omap_mcbsp_slot_rate_list(mcbsp, list)) {
+		dev_err(mcbsp->dev, "no rate for %u x %u-bit slots from %u Hz\n",
+			mcbsp->slots, mcbsp->slot_width, mcbsp->in_freq);
+		return -EINVAL;
+	}
+
+	ret = snd_pcm_hw_constraint_single(runtime, SNDRV_PCM_HW_PARAM_CHANNELS,
+					   active);
+	if (ret < 0)
+		return ret;
+	ret = snd_pcm_hw_constraint_single(runtime,
+					   SNDRV_PCM_HW_PARAM_SAMPLE_BITS,
+					   mcbsp->slot_width);
+	if (ret < 0)
+		return ret;
+
+	/* Rates follow the slots, the sysclk and the other direction */
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		rule = omap_mcbsp_hwrule_tx_rate;
+	else
+		rule = omap_mcbsp_hwrule_rx_rate;
+	return snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_RATE, rule,
+				   mcbsp, SNDRV_PCM_HW_PARAM_RATE, -1);
+}
+
 static int omap_mcbsp_dai_startup(struct snd_pcm_substream *substream,
 				  struct snd_soc_dai *cpu_dai)
 {
 	struct omap_mcbsp *mcbsp = snd_soc_dai_get_drvdata(cpu_dai);
 	int err = 0;
 
+	if (omap_mcbsp_slots_on(mcbsp)) {
+		err = omap_mcbsp_slot_constraints(substream, mcbsp);
+		if (err)
+			return err;
+	}
+
 	if (!snd_soc_dai_active(cpu_dai))
 		err = omap_mcbsp_request(mcbsp);
 
@@ -914,6 +1137,7 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
 	int pkt_size = 0;
 	unsigned int format, div, framesize, master;
 	unsigned int buffer_size = mcbsp->pdata->buffer_size;
+	bool slots = omap_mcbsp_slots_on(mcbsp);
 
 	dma_data = snd_soc_dai_get_dma_data(cpu_dai, substream);
 	channels = params_channels(params);
@@ -928,6 +1152,15 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
 	default:
 		return -EINVAL;
 	}
+
+	if (slots) {
+		int ret = omap_mcbsp_slot_params_check(mcbsp, substream->stream,
+						       params);
+
+		if (ret)
+			return ret;
+	}
+
 	if (buffer_size) {
 		int latency;
 
@@ -972,8 +1205,14 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
 
 	dma_data->maxburst = pkt_size;
 
-	if (mcbsp->configured) {
-		/* McBSP already configured by another stream */
+	/*
+	 * McBSP already configured by another stream. With slots, that must be
+	 * the other direction: a stream on its own reprograms for its rate.
+	 */
+	if (mcbsp->configured &&
+	    (!slots || omap_mcbsp_slot_other(mcbsp, substream->stream))) {
+		if (slots)
+			mcbsp->slot_streams |= BIT(substream->stream);
 		return 0;
 	}
 
@@ -1020,7 +1259,15 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
 	/* In McBSP master modes, FRAME (i.e. sample rate) is generated
 	 * by _counting_ BCLKs. Calculate frame size in BCLKs */
 	master = mcbsp->fmt & SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK;
-	if (master == SND_SOC_DAIFMT_BP_FP) {
+	if (slots) {
+		/* Checked against the slots above */
+		div = omap_mcbsp_slot_div(mcbsp, params_rate(params));
+		mcbsp->slot_rate = params_rate(params);
+		mcbsp->slot_sysclk = mcbsp->in_freq;
+		regs->srgr1	&= ~CLKGDV(0xff);
+		regs->srgr1	|= CLKGDV(div - 1);
+		framesize = mcbsp->slots * mcbsp->slot_width;
+	} else if (master == SND_SOC_DAIFMT_BP_FP) {
 		div = mcbsp->clk_div ? mcbsp->clk_div : 1;
 		framesize = (mcbsp->in_freq / div) / params_rate(params);
 
@@ -1051,6 +1298,18 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
 	omap_mcbsp_config(mcbsp, &mcbsp->cfg_regs);
 	mcbsp->wlen = wlen;
 	mcbsp->configured = 1;
+	if (slots)
+		mcbsp->slot_streams |= BIT(substream->stream);
+
+	return 0;
+}
+
+static int omap_mcbsp_dai_hw_free(struct snd_pcm_substream *substream,
+				  struct snd_soc_dai *cpu_dai)
+{
+	struct omap_mcbsp *mcbsp = snd_soc_dai_get_drvdata(cpu_dai);
+
+	mcbsp->slot_streams &= ~BIT(substream->stream);
 
 	return 0;
 }
@@ -1184,6 +1443,67 @@ static int omap_mcbsp_dai_set_clkdiv(struct snd_soc_dai *cpu_dai,
 	return 0;
 }
 
+/*
+ * With slots set, McBSP as bit clock and frame provider runs a frame of
+ * slots x slot_width bit clocks and picks the divider per rate instead of
+ * using set_clkdiv(). It sends a frame's words in order, so only masks of
+ * the low slots work, and both directions use the same number of them.
+ */
+static int omap_mcbsp_dai_set_tdm_slot(struct snd_soc_dai *cpu_dai,
+				       unsigned int tx_mask,
+				       unsigned int rx_mask,
+				       int slots, int slot_width)
+{
+	struct omap_mcbsp *mcbsp = snd_soc_dai_get_drvdata(cpu_dai);
+	unsigned int max_width = mcbsp->pdata->reg_size == 2 ? 16 : 32;
+	unsigned int tx = 0, rx = 0;
+
+	if (slots) {
+		tx = hweight32(tx_mask);
+		rx = hweight32(rx_mask);
+		/*
+		 * Up to channels_max slots, masks contiguous from slot 0 and,
+		 * as both directions share the frame, of the same weight
+		 */
+		if (slots < 0 || slots > 16 ||
+		    (slot_width != 16 && slot_width != max_width) ||
+		    (tx_mask & ~GENMASK(slots - 1, 0)) ||
+		    (tx_mask & (tx_mask + 1)) ||
+		    (rx_mask & ~GENMASK(slots - 1, 0)) ||
+		    (rx_mask & (rx_mask + 1)) ||
+		    (!tx && !rx) || (tx && rx && tx != rx)) {
+			dev_err(mcbsp->dev,
+				"unsupported TDM slots %d x %d, masks %#x/%#x\n",
+				slots, slot_width, tx_mask, rx_mask);
+			return -EINVAL;
+		}
+	} else {
+		slot_width = 0;
+	}
+
+	/* The other direction may already run with the current slots */
+	if (mcbsp->configured) {
+		if (slots == mcbsp->slots && slot_width == mcbsp->slot_width &&
+		    tx == mcbsp->tx_slots && rx == mcbsp->rx_slots)
+			return 0;
+		return -EBUSY;
+	}
+
+	/* Back to the set_clkdiv() divider */
+	if (mcbsp->slot_width && !slot_width) {
+		mcbsp->cfg_regs.srgr1 &= ~CLKGDV(0xff);
+		mcbsp->cfg_regs.srgr1 |=
+			CLKGDV((mcbsp->clk_div ? mcbsp->clk_div : 1) - 1);
+	}
+
+	mcbsp->slots = slots;
+	mcbsp->slot_width = slot_width;
+	mcbsp->tx_slots = tx;
+	mcbsp->rx_slots = rx;
+
+	return 0;
+}
+
 static int omap_mcbsp_dai_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
 					 int clk_id, unsigned int freq,
 					 int dir)
@@ -1199,6 +1519,11 @@ static int omap_mcbsp_dai_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
 			return -EBUSY;
 	}
 
+	/* Set outside a stream, it holds for the next open */
+	if (!snd_soc_dai_active(cpu_dai))
+		mcbsp->sysclk_static = true;
+	else if (freq != mcbsp->in_freq)
+		mcbsp->sysclk_static = false;
 	mcbsp->in_freq = freq;
 	regs->srgr2 &= ~CLKSM;
 	regs->pcr0 &= ~SCLKME;
@@ -1243,6 +1568,7 @@ static int omap_mcbsp_dai_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
 	default:
 		err = -ENODEV;
 	}
+	mcbsp->sysclk_fclk = clk_id == OMAP_MCBSP_SYSCLK_CLKS_FCLK;
 
 	return err;
 }
@@ -1288,9 +1614,11 @@ static const struct snd_soc_dai_ops mcbsp_dai_ops = {
 	.trigger	= omap_mcbsp_dai_trigger,
 	.delay		= omap_mcbsp_dai_delay,
 	.hw_params	= omap_mcbsp_dai_hw_params,
+	.hw_free	= omap_mcbsp_dai_hw_free,
 	.set_fmt	= omap_mcbsp_dai_set_dai_fmt,
 	.set_clkdiv	= omap_mcbsp_dai_set_clkdiv,
 	.set_sysclk	= omap_mcbsp_dai_set_dai_sysclk,
+	.set_tdm_slot	= omap_mcbsp_dai_set_tdm_slot,
 	.auto_selectable_formats	= &mcbsp_mcbsp_selectable_formats,
 	.num_auto_selectable_formats	= 1,
 };

-- 
Git-155)

