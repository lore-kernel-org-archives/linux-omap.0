From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH] clk: ti: make clk_ops const
Date: Wed, 23 Aug 2017 12:31:22 +0300
Message-ID: <a7632b61-a3de-e4c5-032d-e91fbb7b5f4e@ti.com>
References: <1503407475-11620-1-git-send-email-bhumirks@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1503407475-11620-1-git-send-email-bhumirks@gmail.com>
Content-Language: en-US
Sender: linux-clk-owner@vger.kernel.org
To: Bhumika Goyal <bhumirks@gmail.com>, julia.lawall@lip6.fr, mturquette@baylibre.com, sboyd@codeaurora.org, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

=EF=BB=BF
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Bu=
siness ID: 0615521-4. Kotipaikka/Domicile: Helsinki

On 22/08/17 16:11, Bhumika Goyal wrote:
> Make these const as they are only stored in the const field of a
> clk_init_data structure.
>=20
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>

Looks fine.

Acked-by: Tero Kristo <t-kristo@ti.com>

> ---
>   drivers/clk/ti/adpll.c | 2 +-
>   drivers/clk/ti/apll.c  | 2 +-
>   drivers/clk/ti/fapll.c | 4 ++--
>   3 files changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/clk/ti/adpll.c b/drivers/clk/ti/adpll.c
> index 255cafb..d5c6db4 100644
> --- a/drivers/clk/ti/adpll.c
> +++ b/drivers/clk/ti/adpll.c
> @@ -486,7 +486,7 @@ static u8 ti_adpll_get_parent(struct clk_hw *hw)
>   	return 0;
>   }
>  =20
> -static struct clk_ops ti_adpll_ops =3D {
> +static const struct clk_ops ti_adpll_ops =3D {
>   	.prepare =3D ti_adpll_prepare,
>   	.unprepare =3D ti_adpll_unprepare,
>   	.is_prepared =3D ti_adpll_is_prepared,
> diff --git a/drivers/clk/ti/apll.c b/drivers/clk/ti/apll.c
> index 06f486b..83b148f 100644
> --- a/drivers/clk/ti/apll.c
> +++ b/drivers/clk/ti/apll.c
> @@ -304,7 +304,7 @@ static void omap2_apll_disable(struct clk_hw *hw)
>   	ti_clk_ll_ops->clk_writel(v, &ad->control_reg);
>   }
>  =20
> -static struct clk_ops omap2_apll_ops =3D {
> +static const struct clk_ops omap2_apll_ops =3D {
>   	.enable		=3D &omap2_apll_enable,
>   	.disable	=3D &omap2_apll_disable,
>   	.is_enabled	=3D &omap2_apll_is_enabled,
> diff --git a/drivers/clk/ti/fapll.c b/drivers/clk/ti/fapll.c
> index 66a0d0e..071af44 100644
> --- a/drivers/clk/ti/fapll.c
> +++ b/drivers/clk/ti/fapll.c
> @@ -268,7 +268,7 @@ static int ti_fapll_set_rate(struct clk_hw *hw, unsig=
ned long rate,
>   	return 0;
>   }
>  =20
> -static struct clk_ops ti_fapll_ops =3D {
> +static const struct clk_ops ti_fapll_ops =3D {
>   	.enable =3D ti_fapll_enable,
>   	.disable =3D ti_fapll_disable,
>   	.is_enabled =3D ti_fapll_is_enabled,
> @@ -478,7 +478,7 @@ static int ti_fapll_synth_set_rate(struct clk_hw *hw,=
 unsigned long rate,
>   	return 0;
>   }
>  =20
> -static struct clk_ops ti_fapll_synt_ops =3D {
> +static const struct clk_ops ti_fapll_synt_ops =3D {
>   	.enable =3D ti_fapll_synth_enable,
>   	.disable =3D ti_fapll_synth_disable,
>   	.is_enabled =3D ti_fapll_synth_is_enabled,
>=20


