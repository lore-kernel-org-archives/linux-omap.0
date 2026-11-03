Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793736263;
	b=MBw3JkeoGbOK1Osp1njy9T9stCO0mHa3dyxCTCguoa0gZIoMztmZ4HYiQzMPg1V5VTU9
	 6ydsiMmg77vo6YeATI3ukeH23AaP+iC7rehhE6KHRGp6DhZJA+2mduV2a9VEgZxtgzu3D
	 dj+x8LtW6NyR32VKwH6YJ6PfYzWvMbGKrTv1vrjfC5hN/FzNAAxjIOW/gLoGmX/QuRS7O
	 Tf5f67XB8jJ+j0RPyEbRGfAa6SWebGdarNw0NBD9CRakhGwP/4zQuj0u9oS0e8iDGuPZN
	 uW6DxiEpEbsIrek/wy3+hDdgUZ/r1UHN1UhY5mapzWbq16avrjPasK+vd57JEalywug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793736263;
	h=Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=DvyGW+2TDqyDyX09YOv1ylVGzTnFOJnhc9Nr54EPKMQ=;
	b=MuYJCgcLev54I/ckUOnMzwpBkxQCWrJTztEvfSJ/Q5oOL7et6EzBhQkoqY3TsoqefFTe
	 ArM6FBxDnnpKor1sx6cfmMu+9gybZUjrohbDoaVBdDD+JiWPAEaJJ4bZoGEuVai6waoHL
	 XZrxQlMLtEv+/iBNNLW/Hey7nQ6Vo49+XYoLXopHLaC12WDnRvFu7Vx01ABu/asF6Kasu
	 yznDDYKmVqwchKo1zElOUWLy8ot4oiSQNVnkpROqH+XOLWoWAW4ANICr+Zx/1pTpJoAND
	 FSyuViJ49sppJtEKJFLZ+Li2WcRpxNWepQBGP6SBAJtv0+7IGJcPEt/Ndsq+Gw2tAgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gCAK6sRl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A39606A31B;
	Tue,  3 Nov 2026 20:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gCAK6sRl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7737C1F000C1;
	Tue,  3 Nov 2026 20:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793736262;
	bh=DvyGW+2TDqyDyX09YOv1ylVGzTnFOJnhc9Nr54EPKMQ=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=gCAK6sRl5Ke8SR+kHnKTqXpgxjRROYkldUT5elgxuj56kPIO462asNw5yZ/SMoy/j
	 aElldgyjCeYrZRR+TiDaHAd3inIJDDYMVmDi2EP+w37qyQZgeH61xDDZM9NoNNzotr
	 57Hy0QcQHHAbVe1KGzIzZjdccDiOiFXTdVC/ySOgWO0r5m2iLUudm2t3z2fqwchWNN
	 qaT2f0yPiHFC96w4l40cI69lmBLpQORU/HDc9s+O4PsRMOWDoyZrWp9eJLeUOC05S/
	 hDHTsqjA+3/UZ8X4kIk97gvhiSBOM2G06ZFJbJ7Yfa5GdKxeNhBtehokA1IVuObDwE
	 OjISxVGAgD2zg==
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
Subject: Re: [PATCH v3 2/3] clk: ti: dpll: use the generic spread spectrum
 configuration
From: Brian Masney <masneyb@kernel.org>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com, 
 michael@amarulasolutions.com, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
 Tero Kristo <kristo@kernel.org>, linux-clk@vger.kernel.org, 
 linux-omap@vger.kernel.org, Brian Masney <masneyb@kernel.org>
In-Reply-To: <20261028074436.1958132-3-dario.binacchi@amarulasolutions.com>
References: <20261028074436.1958132-1-dario.binacchi@amarulasolutions.com>
 <20261028074436.1958132-3-dario.binacchi@amarulasolutions.com>
Date: Tue, 03 Nov 2026 15:04:08 -0500
Message-Id: <179373624826.588706.2891486591880784812.b4-review@b4>
X-Mailer: b4 0.17-dev-7ca47
X-Developer-Signature: v=1; a=openpgp-sha256; l=8378; i=masneyb@kernel.org;
 s=20250903; h=from:subject:message-id;
 bh=xwc+cnCouL2LKAbzzjfXwcWheG+MRb4Pss0kQBR/O2k=;
 b=owGbwMvMwCW2/dJd9di6A+2Mp9WSGLJe2VlXlOWuaLn778lPkV8MR00K+dtVbA6838caUl3oU
 dnBwZnRUcrCIMbFICumyLIk16ggInWV7b07miwwc1iZQIYwcHEKwET6+Rn+p3tLvvfsOVzg+FSx
 6/y8c19Kz+8/3iL0tvx7t+O6zF+dcYwM+7/t4Z0h8uc3vyLXQyZ972p/kQqJDR/X6Qm/EblUdW0
 ZCwA=
X-Developer-Key: i=masneyb@kernel.org; a=openpgp;
 fpr=A46D32705865AA3DDEDC2904B7D2DD275D7EC087

Hi Dario,

> The clock framework provides a generic API and DT property for spread
> spectrum clocking (SSC) since commit c86814e70390 ("clk: Introduce
> clk_hw_set_spread_spectrum"). Implement the set_spread_spectrum callback
> and convert the deprecated vendor specific properties to the generic
> configuration, so that existing DTs keep working.
> 
> The SSC registers are programmed at the next rate change, as with the
> vendor specific properties. The generic framework expresses the spread
> in permyriad rather than permille, hence the change in the deltaM step
> computation, and also supports up-spread, which is rejected as the
> hardware does not support it.
> 
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> ---
> Changes in v3:
> - Keep parsing the deprecated vendor specific properties
> 
>  drivers/clk/ti/clock.h    |  2 ++
>  drivers/clk/ti/dpll.c     | 20 +++++++++----
>  drivers/clk/ti/dpll3xxx.c | 61 ++++++++++++++++++++++++++++++++-------
>  include/linux/clk/ti.h    |  9 ++----
>  4 files changed, 70 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/clk/ti/clock.h b/drivers/clk/ti/clock.h
> index d5e24fe4ae3a..83225e506314 100644
> --- a/drivers/clk/ti/clock.h
> +++ b/drivers/clk/ti/clock.h
> @@ -271,6 +271,8 @@ int omap3_noncore_dpll_set_rate_and_parent(struct clk_hw *hw,
>  					   unsigned long rate,
>  					   unsigned long parent_rate,
>  					   u8 index);
> +int omap3_noncore_dpll_set_spread_spectrum(struct clk_hw *hw,
> +					   const struct clk_spread_spectrum *ss_conf);
>  int omap3_noncore_dpll_determine_rate(struct clk_hw *hw,
>  				      struct clk_rate_request *req);
>  int omap2_dpll_determine_rate(struct clk_hw *hw, struct clk_rate_request *req);
> diff --git a/drivers/clk/ti/dpll.c b/drivers/clk/ti/dpll.c
> index e01272cd628d..1329b4bc02f0 100644
> --- a/drivers/clk/ti/dpll.c
> +++ b/drivers/clk/ti/dpll.c
> @@ -51,6 +51,7 @@ static const struct clk_ops dpll_ck_ops = {
>  	.set_parent	= &omap3_noncore_dpll_set_parent,
>  	.set_rate_and_parent	= &omap3_noncore_dpll_set_rate_and_parent,
>  	.determine_rate	= &omap3_noncore_dpll_determine_rate,
> +	.set_spread_spectrum	= &omap3_noncore_dpll_set_spread_spectrum,
>  	.get_parent	= &omap2_init_dpll_parent,
>  	.save_context	= &omap3_noncore_dpll_save_context,
>  	.restore_context = &omap3_noncore_dpll_restore_context,
> @@ -63,6 +64,7 @@ static const struct clk_ops dpll_no_gate_ck_ops = {
>  	.set_parent	= &omap3_noncore_dpll_set_parent,
>  	.set_rate_and_parent	= &omap3_noncore_dpll_set_rate_and_parent,
>  	.determine_rate	= &omap3_noncore_dpll_determine_rate,
> +	.set_spread_spectrum	= &omap3_noncore_dpll_set_spread_spectrum,
>  	.save_context	= &omap3_noncore_dpll_save_context,
>  	.restore_context = &omap3_noncore_dpll_restore_context
>  };
> @@ -278,6 +280,7 @@ static void __init of_ti_dpll_setup(struct device_node *node,
>  	struct dpll_data *dd = NULL;
>  	int ssc_clk_index;
>  	u8 dpll_mode = 0;
> +	u32 ssc_modfreq = 0, ssc_deltam = 0;

Please keep the reverse Christmas tree order here.

>  	u32 min_div;
>  
>  	dd = kmemdup(ddt, sizeof(*dd), GFP_KERNEL);
> @@ -349,11 +352,18 @@ static void __init of_ti_dpll_setup(struct device_node *node,
>  					&dd->ssc_modfreq_reg))
>  			goto cleanup;
>  
> -		of_property_read_u32(node, "ti,ssc-modfreq-hz",
> -				     &dd->ssc_modfreq);
> -		of_property_read_u32(node, "ti,ssc-deltam", &dd->ssc_deltam);
> -		dd->ssc_downspread =
> -			of_property_read_bool(node, "ti,ssc-downspread");
> +		/* Deprecated, superseded by assigned-clock-sscs */
> +		of_property_read_u32(node, "ti,ssc-modfreq-hz", &ssc_modfreq);
> +		of_property_read_u32(node, "ti,ssc-deltam", &ssc_deltam);
> +		if (ssc_modfreq && ssc_deltam) {
> +			dd->ssc_conf.modfreq_hz = ssc_modfreq;
> +			/* permille to permyriad */
> +			dd->ssc_conf.spread_bp = ssc_deltam * 10;

Would it be worthwhile to add a maximum range check here so the u32 does
not overflow?

> +			if (of_property_read_bool(node, "ti,ssc-downspread"))
> +				dd->ssc_conf.method = CLK_SPREAD_DOWN;
> +			else
> +				dd->ssc_conf.method = CLK_SPREAD_CENTER;
> +		}
>  	}
>  
>  	if (of_property_read_bool(node, "ti,low-power-stop"))
> diff --git a/drivers/clk/ti/dpll3xxx.c b/drivers/clk/ti/dpll3xxx.c
> index 8c51b988a04f..634fe0a1f9fd 100644
> --- a/drivers/clk/ti/dpll3xxx.c
> +++ b/drivers/clk/ti/dpll3xxx.c
> @@ -295,30 +295,32 @@ static void _lookup_sddiv(struct clk_hw_omap *clk, u8 *sd_div, u16 m, u8 n)
>   * omap3_noncore_dpll_ssc_program - set spread-spectrum clocking registers
>   * @clk:	struct clk * of DPLL to set
>   *
> - * Enable the DPLL spread spectrum clocking if frequency modulation and
> - * frequency spreading have been set, otherwise disable it.
> + * Enable the DPLL spread spectrum clocking according to the configuration
> + * set by omap3_noncore_dpll_set_spread_spectrum(), otherwise disable it.
>   */
>  static void omap3_noncore_dpll_ssc_program(struct clk_hw_omap *clk)
>  {
>  	struct dpll_data *dd = clk->dpll_data;
> +	const struct clk_spread_spectrum *conf = &dd->ssc_conf;
> +	bool downspread = conf->method == CLK_SPREAD_DOWN;
>  	unsigned long ref_rate;
>  	u32 v, ctrl, mod_freq_divider, exponent, mantissa;
>  	u32 deltam_step, deltam_ceil;
>  
>  	ctrl = ti_clk_ll_ops->clk_readl(&dd->control_reg);
>  
> -	if (dd->ssc_modfreq && dd->ssc_deltam) {
> +	if (conf->method != CLK_SPREAD_NO) {
>  		ctrl |= dd->ssc_enable_mask;
>  
> -		if (dd->ssc_downspread)
> +		if (downspread)
>  			ctrl |= dd->ssc_downspread_mask;
>  		else
>  			ctrl &= ~dd->ssc_downspread_mask;
>  
>  		ref_rate = clk_hw_get_rate(dd->clk_ref);
>  		mod_freq_divider =
> -		    (ref_rate / dd->last_rounded_n) / (4 * dd->ssc_modfreq);
> -		if (dd->ssc_modfreq > (ref_rate / 70))
> +		    (ref_rate / dd->last_rounded_n) / (4 * conf->modfreq_hz);
> +		if (conf->modfreq_hz > (ref_rate / 70))
>  			pr_warn("clock: SSC modulation frequency of DPLL %s greater than %ld\n",
>  				__clk_get_name(clk->hw.clk), ref_rate / 70);
>  
> @@ -337,9 +339,10 @@ static void omap3_noncore_dpll_ssc_program(struct clk_hw_omap *clk)
>  		v |= exponent << __ffs(dd->ssc_modfreq_exp_mask);
>  		ti_clk_ll_ops->clk_writel(v, &dd->ssc_modfreq_reg);
>  
> -		deltam_step = dd->last_rounded_m * dd->ssc_deltam;
> -		deltam_step /= 10;
> -		if (dd->ssc_downspread)
> +		/* spread_bp is in permyriad, convert to percent first */
> +		deltam_step = dd->last_rounded_m * conf->spread_bp;
> +		deltam_step /= 100;
> +		if (downspread)
>  			deltam_step /= 2;
>  
>  		deltam_step <<= __ffs(dd->ssc_deltam_int_mask);
> @@ -353,7 +356,7 @@ static void omap3_noncore_dpll_ssc_program(struct clk_hw_omap *clk)
>  		if (deltam_step & dd->ssc_deltam_frac_mask)
>  			deltam_ceil++;
>  
> -		if ((dd->ssc_downspread &&
> +		if ((downspread &&
>  		     ((dd->last_rounded_m - (2 * deltam_ceil)) < 20 ||
>  		      dd->last_rounded_m > 2045)) ||
>  		    ((dd->last_rounded_m - deltam_ceil) < 20 ||
> @@ -682,6 +685,44 @@ int omap3_noncore_dpll_set_rate(struct clk_hw *hw, unsigned long rate,
>  	return ret;
>  }
>  
> +/**
> + * omap3_noncore_dpll_set_spread_spectrum - set the DPLL SSC configuration
> + * @hw: pointer to the clock to set the spread spectrum configuration for
> + * @ss_conf: spread spectrum configuration
> + *
> + * Stores the spread spectrum clocking (SSC) configuration of the DPLL. The
> + * configuration is programmed along with the DPLL multiplier and divider
> + * at the next rate change. The hardware supports center-spread and
> + * down-spread only. Returns 0 on success, or a negative error value on
> + * failure.
> + */
> +int omap3_noncore_dpll_set_spread_spectrum(struct clk_hw *hw,
> +					   const struct clk_spread_spectrum *ss_conf)
> +{
> +	struct clk_hw_omap *clk = to_clk_hw_omap(hw);
> +	struct dpll_data *dd = clk->dpll_data;
> +
> +	if (!dd || !dd->ssc_enable_mask)
> +		return -EOPNOTSUPP;
> +
> +	switch (ss_conf->method) {
> +	case CLK_SPREAD_NO:
> +		break;
> +	case CLK_SPREAD_CENTER:
> +	case CLK_SPREAD_DOWN:
> +		if (!ss_conf->modfreq_hz || !ss_conf->spread_bp)

clk_hw_set_spread_spectrum() already contains this check, and can be
dropped here.

Brian

-- 
Brian Masney <masneyb@kernel.org>
