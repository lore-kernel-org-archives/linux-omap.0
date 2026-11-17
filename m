Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794953512;
	b=KaDSbFdOTZmvTq4brjdwFauBuQvW7NSezsYU7LN0aGduZcXLgDeqGdRcQdiVAoAjK/7W
	 tTm3WxujU9n4CAWJDonDcBndoOWardf54xPHjeOKozDHVvZuhuMAToJkGRPmUMDVCIq8H
	 7n1iH7C6VDp6KTB+h+atEF7puauueMSOaQs+RCMYM7yeAmr50DraI4+KwyyPJ0PUQR848
	 N4EIY0IVXUPJAJzdKIAux1YU1/omIIwyCbV01PivgRMmjG1/asM0PKMcjv4UdgczVZ+1T
	 OCT8sYfM1grhblnWqPVwWXRLSFaXz4PZHnxxPhjKo75DT6kpGYMHaA5kBuD7dUxze0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794953512;
	h=Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=PQ1lkb7nCtNnaMBZ9SlFdtw9+jVlK/RLRabaEyTSzJo=;
	b=rUgAk5V7e9dVROnIvZkLfdjb2CNaaF5lttz0pmdwM67yXQagk1jj81xNmznkCvAEQgZB
	 leEDESzz16U4AG6YRo56xI562dIf/+eqmuu8r2n5IRPoJpWnOIelWfefmH+f6ON2HNcjs
	 hUiukdLqBniz04SaGPgnjrhnC7Y6Lr6kJCncnxbPSN52Mvyrq36pFlnyDl8nhuduja1vn
	 AMrmtvhzlz5+RP05nKrgirr/LmorHjM+cDIw0/UYzzYvA0/vs6pBivV2+gPuh3Akz8DKk
	 hDT9WeBK6Z/xbkwue4BraWJQOoz0/0e4Jxdyfk7t7oIfRHHMFbEYnTZVrtHvhc0iFig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b+Udxlpe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A524B606A31C;
	Tue, 17 Nov 2026 22:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b+Udxlpe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A6F51F000C7;
	Tue, 17 Nov 2026 22:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794953512;
	bh=PQ1lkb7nCtNnaMBZ9SlFdtw9+jVlK/RLRabaEyTSzJo=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=b+UdxlpemwPOnSf43MqI4NgEf44TZ3ADYUpSOCmm5PfvQ0twBUB0liPEaHYotkpsO
	 ZupUAg9wVep5QGZDP3HKvA/SQha6PvDI2qzNO+0Gl5RW+p1tP0ix3TvEe2SGc+nase
	 QRSa++ghApI/BS/LMheMmPsDAAaNSd1ctDxQf4EsPrNvIuxlYmrjOWAuK75LuR1dOM
	 u9a4wLL5/Pv1zI4f4SHkU+z2WjltOl+Pw+MD6d/J5L5L5JHkq3cgeJgBPJ/ABOfjTU
	 SBVDOQnAG4WW77dYe4RIKLwJpEcFQNyktgrdtpoMQtbd86bKwtoCl7VjZMqpelR4aN
	 JzR7MnTlIfREQ==
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
Subject: Re: [PATCH 2/2] ASoC: ti: omap-mcbsp: Implement set_tdm_slot
From: Mark Brown <broonie@kernel.org>
To: Joseph Telaak <joseph@telaak.dev>
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>, Sen Wang <sen@ti.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 linux-sound@vger.kernel.org, linux-omap@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261116-omap-mcbsp-tdm-slot-v1-2-6c9f7aa45a29@telaak.dev>
References: <20261116-omap-mcbsp-tdm-slot-v1-0-6c9f7aa45a29@telaak.dev>
 <20261116-omap-mcbsp-tdm-slot-v1-2-6c9f7aa45a29@telaak.dev>
Date: Tue, 17 Nov 2026 22:11:46 +0000
Message-Id: <179495350668.2707353.9603940609466130588.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2203; i=broonie@kernel.org;
 h=from:subject:message-id; bh=cRxcbpa3t4zw11M9tXL4PZCGMhSuhM/BTNbnsk47r/c=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLL+XFSZoZspZTiD+dqm25dzvbfuCEhavKVs8qzv+tbS8
 7MC7paFdpSyMIhxMciKKbLEZXG/rC95vYbv4MI2mDmsTCBDGLg4BWAizAIM/z35Zi56JHH66QrG
 82qpBTPWhF+dGNSz5tzdDXobJ90s9jjMyPD/wAk7BY+7Ow1m3eObw3pVpaf/1Ma5iXsDpJ7zHah
 5fIYfAA==
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

> As bit clock and frame provider, McBSP sizes the frame from the SRG
> input, the set_clkdiv() divider and the rate. Only a machine driver can
> call set_clkdiv(), so with simple-audio-card or audio-graph-card the
> divider stays 1 and the bit clock runs at the full SRG input: 96 MHz on
> OMAP3, a 2000-bit frame at 48 kHz.

> +static int omap_mcbsp_slot_constraints(struct snd_pcm_substream *substream,
> +				       struct omap_mcbsp *mcbsp)
> +{
> +	struct snd_pcm_runtime *runtime = substream->runtime;
> +	unsigned int format = mcbsp->fmt & SND_SOC_DAIFMT_FORMAT_MASK;
> +	bool tx = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
> +	unsigned int list[ARRAY_SIZE(omap_mcbsp_slot_rates)];
> +	unsigned int active = tx ? mcbsp->tx_slots : mcbsp->rx_slots;
> +	int ret;
> +
> +	if ((format == SND_SOC_DAIFMT_I2S || format == SND_SOC_DAIFMT_LEFT_J) &&
> +	    mcbsp->slots != 2) {
> +		dev_err(mcbsp->dev, "I2S/LEFT_J needs 2 slots, not %u\n",
> +			mcbsp->slots);
> +		return -EINVAL;
> +	}
> +	if (!active) {
> +		dev_err(mcbsp->dev, "no %s slots in the TDM mask\n",
> +			tx ? "TX" : "RX");
> +		return -EINVAL;
> +	}
> +	if (!omap_mcbsp_slot_rate_list(mcbsp, list)) {
> +		dev_err(mcbsp->dev, "no rate for %u x %u-bit slots from %u Hz\n",
> +			mcbsp->slots, mcbsp->slot_width, mcbsp->in_freq);
> +		return -EINVAL;

Will this do the right thing with a card like simple card that sets the
sysclk dynamically?  The card might reprogram in hw_params() and should
really set it to 0 on shutdown to tell things not to apply constraints.

> @@ -1020,7 +1125,15 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
>  	/* In McBSP master modes, FRAME (i.e. sample rate) is generated
>  	 * by _counting_ BCLKs. Calculate frame size in BCLKs */
>  	master = mcbsp->fmt & SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK;
> -	if (master == SND_SOC_DAIFMT_BP_FP) {
> +	if (master == SND_SOC_DAIFMT_BP_FP && mcbsp->slot_width) {
> +		/* startup() limited channels, width and rate to the slots */

While we're doing constraints stuff it'd be good to validate the params
against the current slot configurastion.

-- 
Mark Brown <broonie@kernel.org>
