From: Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH v4] clk: change clk_ops' ->determine_rate() prototype
Date: Mon, 6 Jul 2015 14:32:10 -0700
Message-ID: <20150706213210.GB20866@codeaurora.org>
References: <1436202872-26533-1-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1436202872-26533-1-git-send-email-boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Mike Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Emilio =?iso-8859-1?Q?L=F3pez?= <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Peter De Schrijver <pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Prashant Gaikwad <pgaikwad-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 07/06, Boris Brezillon wrote:
> Clock rates are stored in an unsigned long field, but ->determine_rat=
e()
> (which returns a rounded rate from a requested one) returns a long
> value (errors are reported using negative error codes), which can lea=
d
> to long overflow if the clock rate exceed 2Ghz.
>=20
> Change ->determine_rate() prototype to return 0 or an error code, and=
 pass
> a pointer to a clk_rate_request structure containing the expected tar=
get
> rate and the rate constraints imposed by clk users.
>=20
> The clk_rate_request structure might be extended in the future to con=
tain
> other kind of constraints like the rounding policy, the maximum clock
> inaccuracy or other things that are not yet supported by the CCF
> (power consumption constraints ?).
>=20
> Signed-off-by: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>

Which files did you compile?=20

drivers/clk/mmp/clk-mix.c: In function =E2=80=98mmp_clk_mix_determine_r=
ate=E2=80=99:
drivers/clk/mmp/clk-mix.c:221:13: error: =E2=80=98rate=E2=80=99 undecla=
red (first use in this function)

>=20
> diff --git a/arch/arm/mach-omap2/dpll3xxx.c b/arch/arm/mach-omap2/dpl=
l3xxx.c
> index 44e57ec..cd27457 100644
> --- a/arch/arm/mach-omap2/dpll3xxx.c
> +++ b/arch/arm/mach-omap2/dpll3xxx.c
> @@ -462,43 +462,38 @@ void omap3_noncore_dpll_disable(struct clk_hw *=
hw)
>  /**
>   * omap3_noncore_dpll_determine_rate - determine rate for a DPLL
>   * @hw: pointer to the clock to determine rate for
> - * @rate: target rate for the DPLL
> - * @best_parent_rate: pointer for returning best parent rate
> - * @best_parent_clk: pointer for returning best parent clock
> + * @req: target rate request
>   *
>   * Determines which DPLL mode to use for reaching a desired target r=
ate.
>   * Checks whether the DPLL shall be in bypass or locked mode, and if
>   * locked, calculates the M,N values for the DPLL via round-rate.
> - * Returns a positive clock rate with success, negative error value
> - * in failure.
> + * Returns a 0 on success, negative error value in failure.
>   */
> -long omap3_noncore_dpll_determine_rate(struct clk_hw *hw, unsigned l=
ong rate,
> -				       unsigned long min_rate,
> -				       unsigned long max_rate,
> -				       unsigned long *best_parent_rate,
> -				       struct clk_hw **best_parent_clk)
> +int omap3_noncore_dpll_determine_rate(struct clk_hw *hw,
> +				      struct clk_rate_request *req)
>  {
>  	struct clk_hw_omap *clk =3D to_clk_hw_omap(hw);
>  	struct dpll_data *dd;
> =20
> -	if (!hw || !rate)
> +	if (!hw || !req || !req->rate)

Why do we need to check for req? It shouldn't be NULL.

>  		return -EINVAL;
> =20
>  	dd =3D clk->dpll_data;
>  	if (!dd)
>  		return -EINVAL;
> =20
> -	if (__clk_get_rate(dd->clk_bypass) =3D=3D rate &&
> +	if (__clk_get_rate(dd->clk_bypass) =3D=3D req->rate &&
>  	    (dd->modes & (1 << DPLL_LOW_POWER_BYPASS))) {
> -		*best_parent_clk =3D __clk_get_hw(dd->clk_bypass);
> +		req->best_parent_hw =3D __clk_get_hw(dd->clk_bypass);
>  	} else {
> -		rate =3D omap2_dpll_round_rate(hw, rate, best_parent_rate);
> -		*best_parent_clk =3D __clk_get_hw(dd->clk_ref);
> +		req->rate =3D omap2_dpll_round_rate(hw, req->rate,
> +					  &req->best_parent_rate);
> +		req->best_parent_hw =3D __clk_get_hw(dd->clk_ref);
>  	}
> =20
> -	*best_parent_rate =3D rate;
> +	req->best_parent_rate =3D req->rate;
> =20
> -	return rate;
> +	return 0;
>  }
> =20
>  /**
> diff --git a/arch/arm/mach-omap2/dpll44xx.c b/arch/arm/mach-omap2/dpl=
l44xx.c
> index f231be0..d615571 100644
> --- a/arch/arm/mach-omap2/dpll44xx.c
> +++ b/arch/arm/mach-omap2/dpll44xx.c
> @@ -191,42 +191,36 @@ out:
>  /**
>   * omap4_dpll_regm4xen_determine_rate - determine rate for a DPLL
>   * @hw: pointer to the clock to determine rate for
> - * @rate: target rate for the DPLL
> - * @best_parent_rate: pointer for returning best parent rate
> - * @best_parent_clk: pointer for returning best parent clock
> + * @req: target rate request
>   *
>   * Determines which DPLL mode to use for reaching a desired rate.
>   * Checks whether the DPLL shall be in bypass or locked mode, and if
>   * locked, calculates the M,N values for the DPLL via round-rate.
> - * Returns a positive clock rate with success, negative error value
> - * in failure.
> + * Returns 0 on success and a negative error value otherwise.
>   */
> -long omap4_dpll_regm4xen_determine_rate(struct clk_hw *hw, unsigned =
long rate,
> -					unsigned long min_rate,
> -					unsigned long max_rate,
> -					unsigned long *best_parent_rate,
> -					struct clk_hw **best_parent_clk)
> +int omap4_dpll_regm4xen_determine_rate(struct clk_hw *hw,
> +				       struct clk_rate_request *req)
>  {
>  	struct clk_hw_omap *clk =3D to_clk_hw_omap(hw);
>  	struct dpll_data *dd;
> =20
> -	if (!hw || !rate)
> +	if (!hw || !req || !req->rate)

Same comment here. And why would we care about hw being NULL
either for that matter.

>  		return -EINVAL;
> =20
>  	dd =3D clk->dpll_data;
>  	if (!dd)
>  		return -EINVAL;
> =20
> -	if (__clk_get_rate(dd->clk_bypass) =3D=3D rate &&
> +	if (__clk_get_rate(dd->clk_bypass) =3D=3D req->rate &&
>  	    (dd->modes & (1 << DPLL_LOW_POWER_BYPASS))) {
> -		*best_parent_clk =3D __clk_get_hw(dd->clk_bypass);
> +		req->best_parent_hw =3D __clk_get_hw(dd->clk_bypass);
>  	} else {
> -		rate =3D omap4_dpll_regm4xen_round_rate(hw, rate,
> -						      best_parent_rate);
> -		*best_parent_clk =3D __clk_get_hw(dd->clk_ref);
> +		req->rate =3D omap4_dpll_regm4xen_round_rate(hw, req->rate,
> +						&req->best_parent_rate);
> +		req->best_parent_hw =3D __clk_get_hw(dd->clk_ref);
>  	}
> =20
> -	*best_parent_rate =3D rate;
> +	req->best_parent_rate =3D req->rate;
> =20
> -	return rate;
> +	return 0;
>  }
> diff --git a/drivers/clk/hisilicon/clk-hi3620.c b/drivers/clk/hisilic=
on/clk-hi3620.c
> index 715d34a..e1d72e6 100644
> --- a/drivers/clk/hisilicon/clk-hi3620.c
> +++ b/drivers/clk/hisilicon/clk-hi3620.c
> @@ -294,34 +294,31 @@ static unsigned long mmc_clk_recalc_rate(struct=
 clk_hw *hw,
>  	}
>  }
> =20
> -static long mmc_clk_determine_rate(struct clk_hw *hw, unsigned long =
rate,
> -			      unsigned long min_rate,
> -			      unsigned long max_rate,
> -			      unsigned long *best_parent_rate,
> -			      struct clk_hw **best_parent_p)
> +static int mmc_clk_determine_rate(struct clk_hw *hw,
> +				  struct clk_rate_request *req)
>  {
>  	struct clk_mmc *mclk =3D to_mmc(hw);
> -	unsigned long best =3D 0;
> =20
> -	if ((rate <=3D 13000000) && (mclk->id =3D=3D HI3620_MMC_CIUCLK1)) {
> -		rate =3D 13000000;
> -		best =3D 26000000;
> -	} else if (rate <=3D 26000000) {
> -		rate =3D 25000000;
> -		best =3D 180000000;
> -	} else if (rate <=3D 52000000) {
> -		rate =3D 50000000;
> -		best =3D 360000000;
> -	} else if (rate <=3D 100000000) {
> -		rate =3D 100000000;
> -		best =3D 720000000;
> +	req->best_parent_hw =3D __clk_get_hw(__clk_get_parent(hw->clk));
> +

Where did this come from? We weren't setting the best_parent_p
pointer before.

> +	if ((req->rate <=3D 13000000) && (mclk->id =3D=3D HI3620_MMC_CIUCLK=
1)) {
> +		req->rate =3D 13000000;
> +		req->best_parent_rate =3D 26000000;
> +	} else if (req->rate <=3D 26000000) {
> +		req->rate =3D 25000000;
> +		req->best_parent_rate =3D 180000000;
> +	} else if (req->rate <=3D 52000000) {
> +		req->rate =3D 50000000;
> +		req->best_parent_rate =3D 360000000;
> +	} else if (req->rate <=3D 100000000) {
> +		req->rate =3D 100000000;
> +		req->best_parent_rate =3D 720000000;
>  	} else {
>  		/* max is 180M */
> -		rate =3D 180000000;
> -		best =3D 1440000000;
> +		req->rate =3D 180000000;
> +		req->best_parent_rate =3D 1440000000;
>  	}
> -	*best_parent_rate =3D best;
> -	return rate;
> +	return 0;
>  }
> =20
>  static u32 mmc_clk_delay(u32 val, u32 para, u32 off, u32 len)
> diff --git a/drivers/clk/qcom/clk-pll.c b/drivers/clk/qcom/clk-pll.c
> index 245d506..f8f1d44 100644
> --- a/drivers/clk/qcom/clk-pll.c
> +++ b/drivers/clk/qcom/clk-pll.c
> @@ -135,17 +135,21 @@ struct pll_freq_tbl *find_freq(const struct pll=
_freq_tbl *f, unsigned long rate)
>  	return NULL;
>  }
> =20
> -static long
> -clk_pll_determine_rate(struct clk_hw *hw, unsigned long rate,
> -		       unsigned long min_rate, unsigned long max_rate,
> -		       unsigned long *p_rate, struct clk_hw **p)
> +static int
> +clk_pll_determine_rate(struct clk_hw *hw, struct clk_rate_request *r=
eq)
>  {
> +	struct clk *parent =3D __clk_get_parent(hw->clk);
>  	struct clk_pll *pll =3D to_clk_pll(hw);
>  	const struct pll_freq_tbl *f;
> =20
> -	f =3D find_freq(pll->freq_tbl, rate);
> +	req->best_parent_hw =3D __clk_get_hw(parent);
> +	req->best_parent_rate =3D __clk_get_rate(parent);
> +
> +	f =3D find_freq(pll->freq_tbl, req->rate);
>  	if (!f)
> -		return clk_pll_recalc_rate(hw, *p_rate);
> +		req->rate =3D clk_pll_recalc_rate(hw, req->best_parent_rate);
> +	else
> +		req->rate =3D f->freq;
> =20
>  	return f->freq;

return 0?

--=20
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
