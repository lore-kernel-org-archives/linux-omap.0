Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793736264;
	b=SkOJdXIUxANLqqjDLp/RP534PpsA0enUKxD+NIvFLGaHY2KaoowhsM309IFW0AlameNp
	 rLexFTZnCeMgrd0ud2HJ1444YTNWtV39C3N+wE2b1Eplpjkd7zwaSMGKlPmObFf3td0vB
	 5xVQdo1/MA1AKX2xfvWOZ1skrAicXF4I9EmHnuBYL1+Iv0q0eiZLP6Sg0aqso5CXgSiNb
	 FaFqAJai1a0zJsbun69ZMUWyaz5L+od28QwsfVi6WyOzdw5RJlopoZeKtav7pt6rCBZFO
	 vF8JMl/mb5M6bT6kZq8Zs57L2XH1wiS/jqPHMR/ZxCtawD9l2R2csBCXOroE6cMGCcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793736264;
	h=Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=ca0hHsmpG3HQsvFcbsyFyNCCoxGaBnFVGg/6zIoTkvE=;
	b=FdIicgG2KlFcLhLHvI/A2eIWgc0Y9KLkFKrO38Tlsk8cvPQPcsbNPBnFHmweb/Cp0acK
	 mv3vTUnYlkoS+GF/6UyMqmBxHl9xXsSdUGdcuc67JO2PlFtrCURwuuyKt/7HvOzu6nyC/
	 m76uM8Y1BLhjbcahEUD+SkQMlOPOQ7B+qg/EY16ZYFi/Dx5dUmwTz4LEKSiXnya0ePhRG
	 yDs7DTU3FKNyaqdF4LDAd3Jw/gs9a1S0XnIBPSrPhcJUXfQouVUIJ7K39Hcac7WVSARR/
	 veULIDGufuLf4QTCNVz/+kob26r7QLt70KR1KfNwwLx9TVB2pSTfF5mdl97l7ksaXgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g5tU5JkE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B45606A330;
	Tue,  3 Nov 2026 20:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g5tU5JkE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B45061F0093A;
	Tue,  3 Nov 2026 20:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793736263;
	bh=ca0hHsmpG3HQsvFcbsyFyNCCoxGaBnFVGg/6zIoTkvE=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=g5tU5JkEwn4tu1d8S5HnYL+8vdGgzXem4oU05Ivtpp159At1KIxVA4QVqH9Z7tR1g
	 x6DX0LiJbmP6icDXAz89InBZEoka7gRC/Q8Hnbluy8bqEoDKhkws0eRj0aiuQLkCBB
	 HtwrcWANcgQ5Kk3sYUWepJzr363Uw4J74pa4OfPMQmrZIqC383w/D/VFOHZoTogQNp
	 8M6wd08AdJWZ2Y2Z2koLg4LbvquOZ1oC7QwOacEKlBa5T+nLSBdVpwTsymBcHz6ago
	 bbBdg7PM1hSa38IJY4dIKBUni/0OW+aRTBYYQsfpUX53IMuHxfJT4bkrjgbgvgnG/e
	 Bu2SU3Mt6HVkQ==
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
Subject: Re: [PATCH v3 3/3] clk: ti: dpll: apply the spread spectrum
 configuration right away
From: Brian Masney <masneyb@kernel.org>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com, 
 michael@amarulasolutions.com, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
 Tero Kristo <kristo@kernel.org>, linux-clk@vger.kernel.org, 
 linux-omap@vger.kernel.org, Brian Masney <masneyb@kernel.org>
In-Reply-To: <20261028074436.1958132-4-dario.binacchi@amarulasolutions.com>
References: <20261028074436.1958132-1-dario.binacchi@amarulasolutions.com>
 <20261028074436.1958132-4-dario.binacchi@amarulasolutions.com>
Date: Tue, 03 Nov 2026 15:04:08 -0500
Message-Id: <179373624826.588706.3689544002135897133.b4-review@b4>
X-Mailer: b4 0.17-dev-7ca47
X-Developer-Signature: v=1; a=openpgp-sha256; l=2898; i=masneyb@kernel.org;
 s=20250903; h=from:subject:message-id;
 bh=jln7AT7QOPgP6kL9K0P39uOf2tdCbb81WRPJdPJZLVg=;
 b=owGbwMvMwCW2/dJd9di6A+2Mp9WSGLJe2TnValn07XX5sLVj5/1uZe5IwTnLVOL4WPgFHR3Sd
 q84tTato5SFQYyLQVZMkWVJrlFBROoq23t3NFlg5rAygQxh4OIUgImY8TIyLJT+Jzv1vfPj26sn
 PJ11fOtGY/+n678v447V2DkjTqJ5+yJGhmnT/+QrtTbtaDJOOXnpxFlVpy2fGjaIh3zjO/Qvm3n
 pYR4A
X-Developer-Key: i=masneyb@kernel.org; a=openpgp;
 fpr=A46D32705865AA3DDEDC2904B7D2DD275D7EC087

Hi Dario,

> The spread spectrum clocking (SSC) registers are only programmed by
> set_rate(), which the clock core skips when the requested rate is
> already the current one, e.g. when the bootloader has set it up.
> As a result, the SSC configuration is not applied, as it was with the
> vendor specific properties.
> 
> Apply it from set_spread_spectrum() instead, reprogramming the DPLL
> at its current rate.
> 
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> ---
> Changes in v3:
> - Skip reprogramming only if the configuration is already applied
>   to the hardware
> 
> Changes in v2:
> - Check the DPLL lock state instead of its parent, as the reference
>   and bypass clocks can be the same clock
> 
>  drivers/clk/ti/dpll3xxx.c | 49 ++++++++++++++++++++++++++++++++++-----
>  1 file changed, 43 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/clk/ti/dpll3xxx.c b/drivers/clk/ti/dpll3xxx.c
> index 634fe0a1f9fd..d32d81a27bfe 100644
> --- a/drivers/clk/ti/dpll3xxx.c
> +++ b/drivers/clk/ti/dpll3xxx.c
> @@ -690,17 +690,22 @@ int omap3_noncore_dpll_set_rate(struct clk_hw *hw, unsigned long rate,
>   * @hw: pointer to the clock to set the spread spectrum configuration for
>   * @ss_conf: spread spectrum configuration
>   *
> - * Stores the spread spectrum clocking (SSC) configuration of the DPLL. The
> - * configuration is programmed along with the DPLL multiplier and divider
> - * at the next rate change. The hardware supports center-spread and
> - * down-spread only. Returns 0 on success, or a negative error value on
> - * failure.
> + * Stores the spread spectrum clocking (SSC) configuration of the DPLL and,
> + * if the DPLL is locked, reprograms it at its current rate to apply it.
> + * Otherwise the configuration is applied at the next rate change. The
> + * hardware supports center-spread and down-spread only. Returns 0 on
> + * success, negative error value otherwise.
>   */
>  int omap3_noncore_dpll_set_spread_spectrum(struct clk_hw *hw,
>  					   const struct clk_spread_spectrum *ss_conf)
>  {
>  	struct clk_hw_omap *clk = to_clk_hw_omap(hw);
>  	struct dpll_data *dd = clk->dpll_data;
> +	struct clk_spread_spectrum old_conf;
> +	struct clk_rate_request req;
> +	unsigned long rate;
> +	int ret;
> +	u32 ctrl;
>  
>  	if (!dd || !dd->ssc_enable_mask)
>  		return -EOPNOTSUPP;
> @@ -718,9 +723,41 @@ int omap3_noncore_dpll_set_spread_spectrum(struct clk_hw *hw,
>  		return -EINVAL;
>  	}
>  
> +	ctrl = ti_clk_ll_ops->clk_readl(&dd->control_reg);
> +
> +	/* Already applied */
> +	if (!memcmp(ss_conf, &dd->ssc_conf, sizeof(*ss_conf)) &&
> +	    !!(ctrl & dd->ssc_enable_mask) == (ss_conf->method != CLK_SPREAD_NO))

The == on this last line has me a little confused right now. Should this
be an && instead?

Brian

-- 
Brian Masney <masneyb@kernel.org>
