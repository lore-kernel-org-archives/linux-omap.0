Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794866627;
	b=qja4L31IlNFQYJ30R4T4sIYMxtDtPyPDnFLX5+3PED3AgPYBkKy2Bxr2+giIGlScbbPx
	 WWHQSVLMqXGX7ZN/aXnM7mFPZTs9pw/DsZLZCPD2mAN5Zc/0/3ZZF01yvAGCB0FUv/xaI
	 pBeXpH8SL5+aqsEUSt5uKLK/liHjDXHt1gc1XnFuXSS4Oc+LmZqQwH1WuyiqsO3CuFk7V
	 Z/1BkJ68AmwiLb+/dZeHLKmf27jd4y4JJaYvbYM0Bxtnu29Gw9Ycr12FSN8IkcxZjsRGy
	 dkMd78YPUGa/EJFnjqgA+AYRJn1N+7KG2asJCN6kc0XE7HI/RoW5aGWx/vZf8qGZi7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794866627;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=PizgZNC5pZ1OdAP1T1MlqaKvfqVNkGdpygwkEwMjJh8=;
	b=okAU06NwUvbjwT8q2xjy2Y2Q+F9iVQdvZv08f2SaLTRMeN/iErTgs5j60kxbnyC9+bEq
	 o0VxQ/7ALQd9rrsAMKN11x9qyTJG9RMkERizbzKcxjS30eiL5ZRAy/5vLQC4Jx7XgwJ20
	 8Cig7YJFoWbMYA03i1UyKz0JTHyLR/f64zloLGQmHtswiwFNE6XjgwdPxueZq0uUC412A
	 Qr7Q/cYVLfT2njKPsc2RTuBSC10hNUSzokHbwOcYEExFouvq37GImvJEgWT3xGi8v3Ldp
	 jnd/U2J1Emu1NMrALzgsBcpYfafzO+MI0hc6dV0HLtnRy/k1ylSImBAynjrqqGJkeow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=telaak.dev;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=74.125.224.43
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2C3606A88E
	for <linux-omap@vger.kernel.org>; Mon, 16 Nov 2026 22:03:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA2C3606A88E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=telaak.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-67dae7d3f7dso2256836d50.2
        for <linux-omap@vger.kernel.org>; Mon, 16 Nov 2026 14:03:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794866626; x=1795471426;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PizgZNC5pZ1OdAP1T1MlqaKvfqVNkGdpygwkEwMjJh8=;
        b=tLlAwdnG4q/3bBZeCHmNeFBbOibk8/3cX0EhIYHwIRCdPjlI/nNAiIFFGXSzQABovA
         lWCNgJmOSYYNnvDxQveJa80IJMLs94VyPSfHVGjtA1pYtpGHZKGyQ4/JXE30I09p+jj7
         BtMeE29Vc26rXddmS+U8ZRM1XXIeQLAjwXYud6HMTuCxOd9w62+pT7mTNFjFvRy1oi60
         JtFZzof6/zoOWkhXIjPyMlrPqMTXMANcOeRDqDyqNVYG3FSfvD+oUnXDv9v6z6LMNzIi
         hvYf0lsbjG3JmclkqmFVr2oT+OuXzt9rXZGi7y04nIdj8g/nVf7m5Oc3iXrryZO3Y/AZ
         sYtQ==
X-Forwarded-Encrypted: i=1; AL+hErGhsBZlYWzAEqvJ338YP5RyNPNWm5xaD1bi0EKXe6VmhlhG0HGTJ9j+wLvLixUr8hodhOE0i19FmcZU@vger.kernel.org
X-Gm-Message-State: APuU4Z/15hcbJ6RymuSN2PuCQuhbA7Y1HG/sVGt+LVel/Bp9+GejXznV
	5KWxDjauSToOYxhVR3hM/p3AzVN1+AwG1EywrfmQd5Y1nY4BZwpxca9Y
X-Gm-Gg: AZFdTZewt+efp4BcEjyRvFHme0l3HxWcxkRd6xCMMd1Oh+ta92ZwIcFQoJaRB9NAstD
	fCz5jgRO4nxKlnNEtmwc1xvowSbL0HlJqDCKWC8qt4sciDE048GRnO/9K0ZzoHNRpiRdUagbJ5H
	3DlOZPcbyEtsqDALzM9ti+OQARYo3VzokLmt0WsqZ1ojDPCMaaajmIOV2STKVUTg4vBAD7Vud9l
	7jkTrAxrP8OpYU7YlSUivjuotytANDpBE5cVlD/UmRbSOX2cZerTEnqyxcfFU+b9MtZaAAN/wNl
	xFerNN+JGcpfhYdmBj2BzoS+0puJqK+Q2c32A0kMwpJRAWIw3YUc+7M+X2UcwC+1LDT3cHz23AP
	PmxgphlLQaGbJlLcsn0x53l2/Qv20oYdkjvcOqOwqzisKre49PRYOWjA2fzZ4VVa5VitNkHNi9Q
	kdCTckNcCYEXRg7hZlybcWiBVYPT/TxtHiZmQPvqRAtD739z2uN0+WSFR1jCO0GliHn9biIrd3m
	DS+RsFNoLL+QxD/DAHXrBlnDjnBW9i9q7T2bgmDx0vAmAj4QDXw+keafU3gRTAK5lmHV/DADrIX
	gPVYqKwzwJpm3Uh8xRCsOeaBH6f+FkVzSjGfRT8q1EICwzF+znVkALP8PeYaH3xFkt/XI7AXCy0
	08aYrjoJx6/pbQZvnaUFthC+JzePCedEfc0w=
X-Received: by 2002:a05:690e:1385:b0:67c:2462:b3c6 with SMTP id 956f58d0204a3-67d8972ec50mr6498893d50.101.1794866625778;
        Mon, 16 Nov 2026 14:03:45 -0800 (PST)
Received: from josephs-mac-mini.local ([71.68.170.161])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67d8a629a2dsm11133078d50.21.2026.11.16.14.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 14:03:45 -0800 (PST)
From: Joseph Telaak <joseph@telaak.dev>
Date: Mon, 16 Nov 2026 17:03:22 -0500
Subject: [PATCH 2/2] ASoC: ti: omap-mcbsp: Implement set_tdm_slot
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
Message-Id: <20261116-omap-mcbsp-tdm-slot-v1-2-6c9f7aa45a29@telaak.dev>
References: <20261116-omap-mcbsp-tdm-slot-v1-0-6c9f7aa45a29@telaak.dev>
In-Reply-To: <20261116-omap-mcbsp-tdm-slot-v1-0-6c9f7aa45a29@telaak.dev>
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
hw_params() then picks the divider for the rate, and startup() offers
only the rates the SRG input divides to within 0.1%, the IEC 60958 level
II clock tolerance. McBSP sends a frame's words back to back, so
startup() also limits the sample width to the slot width and the
channels to the active slots, which must be the low ones, and refuses
I2S or left-justified with other than two slots. This applies only when
McBSP provides both clocks; without slots nothing changes.

Tested on an OMAP3630 board whose McBSP4 drives the I2S input of an
ADV7513 with no MCLK, with 2 x 32-bit slots and adv7511 taking S32_LE:
a left-only and a right-only 44.1 kHz tone each play at full level
(96 MHz / 34 gives 44117.6 Hz), 48 kHz (0.8% off) and S16_LE are
refused.

Signed-off-by: Joseph Telaak <joseph@telaak.dev>
---
 sound/soc/ti/omap-mcbsp-priv.h |   4 ++
 sound/soc/ti/omap-mcbsp.c      | 155 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 158 insertions(+), 1 deletion(-)

diff --git a/sound/soc/ti/omap-mcbsp-priv.h b/sound/soc/ti/omap-mcbsp-priv.h
index 324c5d7d431d..7bd5a3f13a37 100644
--- a/sound/soc/ti/omap-mcbsp-priv.h
+++ b/sound/soc/ti/omap-mcbsp-priv.h
@@ -275,6 +275,10 @@ struct omap_mcbsp {
 	unsigned int latency[2];
 	int clk_div;
 	int wlen;
+	unsigned int slots;
+	unsigned int slot_width;
+	unsigned int tx_slots;
+	unsigned int rx_slots;
 
 	struct pm_qos_request pm_qos_req;
 };
diff --git a/sound/soc/ti/omap-mcbsp.c b/sound/soc/ti/omap-mcbsp.c
index 6e0c7d7359f4..64d034f139a8 100644
--- a/sound/soc/ti/omap-mcbsp.c
+++ b/sound/soc/ti/omap-mcbsp.c
@@ -759,12 +759,117 @@ static int omap_mcbsp_hwrule_min_buffersize(struct snd_pcm_hw_params *params,
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
+/* Computed on each refine, so nothing is shared between the streams */
+static int omap_mcbsp_hwrule_slot_rate(struct snd_pcm_hw_params *params,
+				       struct snd_pcm_hw_rule *rule)
+{
+	unsigned int list[ARRAY_SIZE(omap_mcbsp_slot_rates)];
+	unsigned int n = omap_mcbsp_slot_rate_list(rule->private, list);
+
+	return snd_interval_list(hw_param_interval(params, rule->var), n,
+				 list, 0);
+}
+
+/*
+ * With TDM slots the frame is slots x slot_width bit clocks. McBSP sends its
+ * words back to back, so a sample must fill its slot, channels go to the
+ * first slots, and I2S/left-justified (one word per phase) need two slots.
+ */
+static int omap_mcbsp_slot_constraints(struct snd_pcm_substream *substream,
+				       struct omap_mcbsp *mcbsp)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	unsigned int format = mcbsp->fmt & SND_SOC_DAIFMT_FORMAT_MASK;
+	bool tx = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
+	unsigned int list[ARRAY_SIZE(omap_mcbsp_slot_rates)];
+	unsigned int active = tx ? mcbsp->tx_slots : mcbsp->rx_slots;
+	int ret;
+
+	if ((format == SND_SOC_DAIFMT_I2S || format == SND_SOC_DAIFMT_LEFT_J) &&
+	    mcbsp->slots != 2) {
+		dev_err(mcbsp->dev, "I2S/LEFT_J needs 2 slots, not %u\n",
+			mcbsp->slots);
+		return -EINVAL;
+	}
+	if (!active) {
+		dev_err(mcbsp->dev, "no %s slots in the TDM mask\n",
+			tx ? "TX" : "RX");
+		return -EINVAL;
+	}
+	if (!omap_mcbsp_slot_rate_list(mcbsp, list)) {
+		dev_err(mcbsp->dev, "no rate for %u x %u-bit slots from %u Hz\n",
+			mcbsp->slots, mcbsp->slot_width, mcbsp->in_freq);
+		return -EINVAL;
+	}
+
+	ret = snd_pcm_hw_constraint_minmax(runtime, SNDRV_PCM_HW_PARAM_CHANNELS,
+					   1, active);
+	if (ret < 0)
+		return ret;
+	ret = snd_pcm_hw_constraint_single(runtime,
+					   SNDRV_PCM_HW_PARAM_SAMPLE_BITS,
+					   mcbsp->slot_width);
+	if (ret < 0)
+		return ret;
+
+	/* Rates follow the current in_freq and slots */
+	return snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
+				   omap_mcbsp_hwrule_slot_rate, mcbsp,
+				   SNDRV_PCM_HW_PARAM_RATE, -1);
+}
+
 static int omap_mcbsp_dai_startup(struct snd_pcm_substream *substream,
 				  struct snd_soc_dai *cpu_dai)
 {
 	struct omap_mcbsp *mcbsp = snd_soc_dai_get_drvdata(cpu_dai);
 	int err = 0;
 
+	if (mcbsp->slot_width &&
+	    (mcbsp->fmt & SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK) ==
+	    SND_SOC_DAIFMT_BP_FP) {
+		err = omap_mcbsp_slot_constraints(substream, mcbsp);
+		if (err)
+			return err;
+	}
+
 	if (!snd_soc_dai_active(cpu_dai))
 		err = omap_mcbsp_request(mcbsp);
 
@@ -1020,7 +1125,15 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
 	/* In McBSP master modes, FRAME (i.e. sample rate) is generated
 	 * by _counting_ BCLKs. Calculate frame size in BCLKs */
 	master = mcbsp->fmt & SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK;
-	if (master == SND_SOC_DAIFMT_BP_FP) {
+	if (master == SND_SOC_DAIFMT_BP_FP && mcbsp->slot_width) {
+		/* startup() limited channels, width and rate to the slots */
+		div = omap_mcbsp_slot_div(mcbsp, params_rate(params));
+		if (!div)
+			return -EINVAL;
+		regs->srgr1	&= ~CLKGDV(0xff);
+		regs->srgr1	|= CLKGDV(div - 1);
+		framesize = mcbsp->slots * mcbsp->slot_width;
+	} else if (master == SND_SOC_DAIFMT_BP_FP) {
 		div = mcbsp->clk_div ? mcbsp->clk_div : 1;
 		framesize = (mcbsp->in_freq / div) / params_rate(params);
 
@@ -1184,6 +1297,45 @@ static int omap_mcbsp_dai_set_clkdiv(struct snd_soc_dai *cpu_dai,
 	return 0;
 }
 
+/*
+ * With slots set, McBSP as bit clock and frame provider runs a frame of
+ * slots x slot_width bit clocks and picks the divider per rate instead of
+ * using set_clkdiv(). It sends a frame's words in order, so only masks of
+ * the low slots work.
+ */
+static int omap_mcbsp_dai_set_tdm_slot(struct snd_soc_dai *cpu_dai,
+				       unsigned int tx_mask,
+				       unsigned int rx_mask,
+				       int slots, int slot_width)
+{
+	struct omap_mcbsp *mcbsp = snd_soc_dai_get_drvdata(cpu_dai);
+	unsigned int max_width = mcbsp->pdata->reg_size == 2 ? 16 : 32;
+
+	if (mcbsp->active)
+		return -EBUSY;
+
+	if (!slots) {
+		mcbsp->slots = 0;
+		mcbsp->slot_width = 0;
+		return 0;
+	}
+
+	if (slots < 0 || slots > 16 ||
+	    (slot_width != 16 && slot_width != max_width))
+		return -EINVAL;
+	/* Masks must be contiguous from slot 0 */
+	if ((tx_mask & ~GENMASK(slots - 1, 0)) || (tx_mask & (tx_mask + 1)) ||
+	    (rx_mask & ~GENMASK(slots - 1, 0)) || (rx_mask & (rx_mask + 1)))
+		return -EINVAL;
+
+	mcbsp->slots = slots;
+	mcbsp->slot_width = slot_width;
+	mcbsp->tx_slots = hweight32(tx_mask);
+	mcbsp->rx_slots = hweight32(rx_mask);
+
+	return 0;
+}
+
 static int omap_mcbsp_dai_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
 					 int clk_id, unsigned int freq,
 					 int dir)
@@ -1291,6 +1443,7 @@ static const struct snd_soc_dai_ops mcbsp_dai_ops = {
 	.set_fmt	= omap_mcbsp_dai_set_dai_fmt,
 	.set_clkdiv	= omap_mcbsp_dai_set_clkdiv,
 	.set_sysclk	= omap_mcbsp_dai_set_dai_sysclk,
+	.set_tdm_slot	= omap_mcbsp_dai_set_tdm_slot,
 	.auto_selectable_formats	= &mcbsp_mcbsp_selectable_formats,
 	.num_auto_selectable_formats	= 1,
 };

-- 
Git-155)

