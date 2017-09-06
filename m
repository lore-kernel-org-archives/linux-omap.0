From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH] clk: ti: dra7xx: Reset the mcasp3_ahclkx_mux clock value
Date: Wed, 6 Sep 2017 14:42:31 +0300
Message-ID: <26063901-be4f-dbe3-514b-e9a1a8ab3b10@ti.com>
References: <1504694199-32227-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1504694199-32227-1-git-send-email-j-keerthy@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>, sboyd@codeaurora.org
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

=EF=BB=BF
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Bu=
siness ID: 0615521-4. Kotipaikka/Domicile: Helsinki

On 06/09/17 13:36, Keerthy wrote:
> Reset the mcasp3_ahclkx_mux to abe_24m_fclk. This is needed
> in case of kexec where the reset values might be wiped off.
>=20
> Signed-off-by: Keerthy <j-keerthy@ti.com>

Why not do this in DT with the assigned-clock-xyz properties available?

-Tero

> ---
>   drivers/clk/ti/clk-7xx.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/clk/ti/clk-7xx.c b/drivers/clk/ti/clk-7xx.c
> index 9fd6043..2c3a36c 100644
> --- a/drivers/clk/ti/clk-7xx.c
> +++ b/drivers/clk/ti/clk-7xx.c
> @@ -312,7 +312,7 @@
>   int __init dra7xx_dt_clk_init(void)
>   {
>   	int rc;
> -	struct clk *dpll_ck, *hdcp_ck;
> +	struct clk *dpll_ck, *hdcp_ck, *mcasp3_ahclkx_ck, *abe_ck;
>  =20
>   	ti_dt_clocks_register(dra7xx_clks);
>  =20
> @@ -338,5 +338,12 @@ int __init dra7xx_dt_clk_init(void)
>   	if (rc)
>   		pr_err("%s: failed to set dss_deshdcp_clk\n", __func__);
>  =20
> +	mcasp3_ahclkx_ck =3D clk_get_sys(NULL, "mcasp3_ahclkx_mux");
> +	abe_ck =3D clk_get_sys(NULL, "abe_24m_fclk");
> +	rc =3D clk_set_parent(mcasp3_ahclkx_ck, abe_ck);
> +	if (rc)
> +		pr_err("%s: failed to set parent for mcasp3_ahclkx_mux\n",
> +		       __func__);
> +
>   	return rc;
>   }
>=20
