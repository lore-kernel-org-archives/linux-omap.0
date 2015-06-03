From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v3] clk: change clk_ops' ->determine_rate() prototype
Date: Wed, 3 Jun 2015 16:37:28 -0700
Message-ID: <20150603233728.GA490@codeaurora.org>
References: <1432138345-19044-1-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1432138345-19044-1-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-doc-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Mike Turquette <mturquette@linaro.org>, linux-clk@vger.kernel.org, Mikko Perttunen <mikko.perttunen@kapsi.fi>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Jonathan Corbet <corbet@lwn.net>, Tony Lindgren <tony@atomide.com>, Ralf Baechle <ralf@linux-mips.org>, Emilio L??pez <emilio@elopez.com.ar>, Maxime Ripard <maxime.ripard@free-electrons.com>, Tero Kristo <t-kristo@ti.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mips@linux-mips.org
List-Id: linux-omap@vger.kernel.org

On 05/20, Boris Brezillon wrote:
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
> CC: linux-doc@vger.kernel.org
> CC: linux-kernel@vger.kernel.org
> CC: linux-arm-kernel@lists.infradead.org
> CC: linux-omap@vger.kernel.org
> CC: linux-mips@linux-mips.org
> ---
>=20
> Hi Stephen,
>=20
> This patch is based on clk-next and contains the changes you suggeste=
d
> in your previous review.
>=20
> It was tested on sama5d4 and compile tested on several ARM platforms
> (those enabled in multi_v7_defconfig).
>=20

Thanks. I think we should wait until the next -rc1 drops to apply the
patch for the next merge window. That will make it least likely to conf=
lict
with other trees, and we can provide it on a stable branch should there
be clock providers going through other trees somewhere. Please
remind me if I forget.

> @@ -1186,15 +1191,21 @@ EXPORT_SYMBOL_GPL(__clk_determine_rate);
>   */
>  unsigned long __clk_round_rate(struct clk *clk, unsigned long rate)
>  {
> -	unsigned long min_rate;
> -	unsigned long max_rate;
> +
> +	struct clk_rate_request req;
> +	int ret;
> =20
>  	if (!clk)
>  		return 0;
> =20
> -	clk_core_get_boundaries(clk->core, &min_rate, &max_rate);
> +	clk_core_get_boundaries(clk->core, &req.min_rate, &req.max_rate);
> +	req.rate =3D rate;
> +
> +	ret =3D clk_core_round_rate_nolock(clk->core, &req);
> +	if (ret)
> +		return ret;

This returns a negative int for unsigned long. Is that intentional?

--=20
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
