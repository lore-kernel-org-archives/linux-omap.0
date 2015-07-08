From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v5] clk: change clk_ops' ->determine_rate() prototype
Date: Tue, 7 Jul 2015 17:57:48 -0700
Message-ID: <20150708005748.GG30412@codeaurora.org>
References: <1436294888-25752-1-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1436294888-25752-1-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-doc-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Mike Turquette <mturquette@baylibre.com>, linux-clk@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Tony Lindgren <tony@atomide.com>, Ralf Baechle <ralf@linux-mips.org>, Emilio =?iso-8859-1?Q?L=F3pez?= <emilio@elopez.com.ar>, Maxime Ripard <maxime.ripard@free-electrons.com>, Tero Kristo <t-kristo@ti.com>, Peter De Schrijver <pdeschrijver@nvidia.com>, Prashant Gaikwad <pgaikwad@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mips@linux-mips.org, linux-tegra@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 07/07, Boris Brezillon wrote:
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
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
>=20
> CC: Jonathan Corbet <corbet@lwn.net>
> CC: Tony Lindgren <tony@atomide.com>
> CC: Ralf Baechle <ralf@linux-mips.org>
> CC: "Emilio L=F3pez" <emilio@elopez.com.ar>
> CC: Maxime Ripard <maxime.ripard@free-electrons.com>
> CC: Tero Kristo <t-kristo@ti.com>
> CC: Peter De Schrijver <pdeschrijver@nvidia.com>
> CC: Prashant Gaikwad <pgaikwad@nvidia.com>
> CC: Stephen Warren <swarren@wwwdotorg.org>
> CC: Thierry Reding <thierry.reding@gmail.com>
> CC: Alexandre Courbot <gnurou@gmail.com>
> CC: linux-doc@vger.kernel.org
> CC: linux-kernel@vger.kernel.org
> CC: linux-arm-kernel@lists.infradead.org
> CC: linux-omap@vger.kernel.org
> CC: linux-mips@linux-mips.org
> CC: linux-tegra@vger.kernel.org
>=20
> ---

I'll throw this patch into -next now to see if any other problems
shake out. I'm hoping we get some more acks though, so it'll be
on it's own branch and become immutable in a week or so. One
question below.

> diff --git a/drivers/clk/clk-composite.c b/drivers/clk/clk-composite.=
c
> index 616f5ae..9e69f34 100644
> --- a/drivers/clk/clk-composite.c
> +++ b/drivers/clk/clk-composite.c
> @@ -99,33 +99,33 @@ static long clk_composite_determine_rate(struct c=
lk_hw *hw, unsigned long rate,
> =20
>  			parent_rate =3D __clk_get_rate(parent);
> =20
> -			tmp_rate =3D rate_ops->round_rate(rate_hw, rate,
> +			tmp_rate =3D rate_ops->round_rate(rate_hw, req->rate,
>  							&parent_rate);
>  			if (tmp_rate < 0)
>  				continue;
> =20
> -			rate_diff =3D abs(rate - tmp_rate);
> +			rate_diff =3D abs(req->rate - tmp_rate);
> =20
> -			if (!rate_diff || !*best_parent_p
> +			if (!rate_diff || !req->best_parent_hw
>  				       || best_rate_diff > rate_diff) {
> -				*best_parent_p =3D __clk_get_hw(parent);
> -				*best_parent_rate =3D parent_rate;
> +				req->best_parent_hw =3D __clk_get_hw(parent);
> +				req->best_parent_rate =3D parent_rate;
>  				best_rate_diff =3D rate_diff;
>  				best_rate =3D tmp_rate;
>  			}
> =20
>  			if (!rate_diff)
> -				return rate;
> +				return 0;
>  		}
> =20
> -		return best_rate;
> +		req->rate =3D best_rate;
> +		return 0;
>  	} else if (mux_hw && mux_ops && mux_ops->determine_rate) {
>  		__clk_hw_set_clk(mux_hw, hw);
> -		return mux_ops->determine_rate(mux_hw, rate, min_rate,
> -					       max_rate, best_parent_rate,
> -					       best_parent_p);
> +		return mux_ops->determine_rate(mux_hw, req);
>  	} else {
>  		pr_err("clk: clk_composite_determine_rate function called, but no =
mux or rate callback set!\n");
> +		req->rate =3D 0;
>  		return 0;

Shouldn't this return an error now? And then assigning req->rate
wouldn't be necessary. Sorry I must have missed this last round.

--=20
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
