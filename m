From: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] clk: ti: omap5: Add missing AESS clock
Date: Wed, 15 Jan 2020 10:56:08 +0200
Message-ID: <23f9723b-cb9e-8737-92c5-4c20bed55cf5@ti.com>
References: <20200114150607.18092-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200114150607.18092-1-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Michael Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "H . Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, Matthijs van Duin <matthijsvanduin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org



On 14/01/2020 17.06, Tony Lindgren wrote:
> Looks like we're missing AESS clock for omap5. This is similar to what
> omap4 has.

Reviewed-by: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>

> Cc: H. Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
> Cc: Matthijs van Duin <matthijsvanduin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> ---
>  drivers/clk/ti/clk-54xx.c         | 15 +++++++++++++++
>  include/dt-bindings/clock/omap5.h |  1 +
>  2 files changed, 16 insertions(+)
> 
> diff --git a/drivers/clk/ti/clk-54xx.c b/drivers/clk/ti/clk-54xx.c
> --- a/drivers/clk/ti/clk-54xx.c
> +++ b/drivers/clk/ti/clk-54xx.c
> @@ -35,6 +35,20 @@ static const struct omap_clkctrl_reg_data omap5_dsp_clkctrl_regs[] __initconst =
>  	{ 0 },
>  };
>  
> +static const char * const omap5_aess_fclk_parents[] __initconst = {
> +	"abe_clk",
> +	NULL,
> +};
> +
> +static const struct omap_clkctrl_div_data omap5_aess_fclk_data __initconst = {
> +	.max_div = 2,
> +};
> +
> +static const struct omap_clkctrl_bit_data omap5_aess_bit_data[] __initconst = {
> +	{ 24, TI_CLK_DIVIDER, omap5_aess_fclk_parents, &omap5_aess_fclk_data },
> +	{ 0 },
> +};
> +
>  static const char * const omap5_dmic_gfclk_parents[] __initconst = {
>  	"abe_cm:clk:0018:26",
>  	"pad_clks_ck",
> @@ -122,6 +136,7 @@ static const struct omap_clkctrl_bit_data omap5_timer8_bit_data[] __initconst =
>  
>  static const struct omap_clkctrl_reg_data omap5_abe_clkctrl_regs[] __initconst = {
>  	{ OMAP5_L4_ABE_CLKCTRL, NULL, 0, "abe_iclk" },
> +	{ OMAP5_AESS_CLKCTRL, omap5_aess_bit_data, CLKF_SW_SUP, "abe_cm:clk:0008:24" },
>  	{ OMAP5_MCPDM_CLKCTRL, NULL, CLKF_SW_SUP, "pad_clks_ck" },
>  	{ OMAP5_DMIC_CLKCTRL, omap5_dmic_bit_data, CLKF_SW_SUP, "abe_cm:clk:0018:24" },
>  	{ OMAP5_MCBSP1_CLKCTRL, omap5_mcbsp1_bit_data, CLKF_SW_SUP, "abe_cm:clk:0028:24" },
> diff --git a/include/dt-bindings/clock/omap5.h b/include/dt-bindings/clock/omap5.h
> --- a/include/dt-bindings/clock/omap5.h
> +++ b/include/dt-bindings/clock/omap5.h
> @@ -16,6 +16,7 @@
>  
>  /* abe clocks */
>  #define OMAP5_L4_ABE_CLKCTRL	OMAP5_CLKCTRL_INDEX(0x20)
> +#define OMAP5_AESS_CLKCTRL	OMAP5_CLKCTRL_INDEX(0x28)
>  #define OMAP5_MCPDM_CLKCTRL	OMAP5_CLKCTRL_INDEX(0x30)
>  #define OMAP5_DMIC_CLKCTRL	OMAP5_CLKCTRL_INDEX(0x38)
>  #define OMAP5_MCBSP1_CLKCTRL	OMAP5_CLKCTRL_INDEX(0x48)
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
