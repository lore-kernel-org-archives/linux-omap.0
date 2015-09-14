From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] clk: ti: clk-7xx: Remove hardwired ABE clock
 configuration
Date: Mon, 14 Sep 2015 11:52:17 +0300
Message-ID: <55F68AC1.1040807@ti.com>
References: <1440401702-32420-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1440401702-32420-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Tero,

On 08/24/2015 10:35 AM, Peter Ujfalusi wrote:
> The ABE related clocks should be configured via DT and not have it wi=
red
> inside of the kernel.

can you take a look at this patch? It will not cause any regression sin=
ce we
do not have audio support mainline and the pending series does not need=
 this
part anymore.

> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
> Hi Tero,
>=20
> the ABE PLL configuration can, and will be done for dra7xx in DT with=
 the
> assigned-clocks/rate/parent feature so no need to have this anymore.
>=20
> Regards,
> Peter
>=20
>  drivers/clk/ti/clk-7xx.c | 18 +-----------------
>  1 file changed, 1 insertion(+), 17 deletions(-)
>=20
> diff --git a/drivers/clk/ti/clk-7xx.c b/drivers/clk/ti/clk-7xx.c
> index 9b5b289e6334..a911d7de3377 100644
> --- a/drivers/clk/ti/clk-7xx.c
> +++ b/drivers/clk/ti/clk-7xx.c
> @@ -18,7 +18,6 @@
> =20
>  #include "clock.h"
> =20
> -#define DRA7_DPLL_ABE_DEFFREQ				180633600
>  #define DRA7_DPLL_GMAC_DEFFREQ				1000000000
>  #define DRA7_DPLL_USB_DEFFREQ				960000000
> =20
> @@ -313,27 +312,12 @@ static struct ti_dt_clk dra7xx_clks[] =3D {
>  int __init dra7xx_dt_clk_init(void)
>  {
>  	int rc;
> -	struct clk *abe_dpll_mux, *sys_clkin2, *dpll_ck, *hdcp_ck;
> +	struct clk *dpll_ck, *hdcp_ck;
> =20
>  	ti_dt_clocks_register(dra7xx_clks);
> =20
>  	omap2_clk_disable_autoidle_all();
> =20
> -	abe_dpll_mux =3D clk_get_sys(NULL, "abe_dpll_sys_clk_mux");
> -	sys_clkin2 =3D clk_get_sys(NULL, "sys_clkin2");
> -	dpll_ck =3D clk_get_sys(NULL, "dpll_abe_ck");
> -
> -	rc =3D clk_set_parent(abe_dpll_mux, sys_clkin2);
> -	if (!rc)
> -		rc =3D clk_set_rate(dpll_ck, DRA7_DPLL_ABE_DEFFREQ);
> -	if (rc)
> -		pr_err("%s: failed to configure ABE DPLL!\n", __func__);
> -
> -	dpll_ck =3D clk_get_sys(NULL, "dpll_abe_m2x2_ck");
> -	rc =3D clk_set_rate(dpll_ck, DRA7_DPLL_ABE_DEFFREQ * 2);
> -	if (rc)
> -		pr_err("%s: failed to configure ABE DPLL m2x2!\n", __func__);
> -
>  	dpll_ck =3D clk_get_sys(NULL, "dpll_gmac_ck");
>  	rc =3D clk_set_rate(dpll_ck, DRA7_DPLL_GMAC_DEFFREQ);
>  	if (rc)
>=20


--=20
P=E9ter
