From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH 09/11] ARM: OMAP4: clock data: add clockdomains for clocks
 used as main clocks
Date: Thu, 07 Jun 2012 12:09:09 +0530
Message-ID: <4FD04C8D.50609@ti.com>
References: <20120607060901.25532.68354.stgit@dusk> <20120607061313.25532.84569.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:49600 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758401Ab2FGGjQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jun 2012 02:39:16 -0400
Received: by obhx4 with SMTP id x4so535366obh.20
        for <linux-omap@vger.kernel.org>; Wed, 06 Jun 2012 23:39:15 -0700 (PDT)
In-Reply-To: <20120607061313.25532.84569.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, =?UTF-8?B?QmVub8OudCBDb3Vzc29u?= <b-cousson@ti.com>

On Thursday 07 June 2012 11:43 AM, Paul Walmsley wrote:
> Until the OMAP4 code is converted to disable the use of the clock
> framework-based clockdomain enable/disable sequence, any clock used a=
s
> a hwmod main_clk must have a clockdomain associated with it.  This
> patch populates some clock structure clockdomain names to resolve the
> following warnings during kernel init:

But these associations are useless if the clock is not a 'gate' clock,
except for getting rid of these warnings.
Maybe we should make hwmod understand that not all clocks need to have
a clockdomain associated with it and stop complaining.

>
> omap_hwmod: dpll_mpu_m2_ck: missing clockdomain for dpll_mpu_m2_ck.
> omap_hwmod: trace_clk_div_ck: missing clockdomain for trace_clk_div_c=
k.
> omap_hwmod: l3_div_ck: missing clockdomain for l3_div_ck.
> omap_hwmod: ddrphy_ck: missing clockdomain for ddrphy_ck.
>
> Signed-off-by: Paul Walmsley<paul@pwsan.com>
> Cc: Rajendra Nayak<rnayak@ti.com>
> Cc: Beno=C3=AEt Cousson<b-cousson@ti.com>
> ---
>   arch/arm/mach-omap2/clock44xx_data.c |    5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-oma=
p2/clock44xx_data.c
> index 2172f66..e2b701e 100644
> --- a/arch/arm/mach-omap2/clock44xx_data.c
> +++ b/arch/arm/mach-omap2/clock44xx_data.c
> @@ -84,6 +84,7 @@ static struct clk slimbus_clk =3D {
>
>   static struct clk sys_32k_ck =3D {
>   	.name		=3D "sys_32k_ck",
> +	.clkdm_name	=3D "prm_clkdm",
>   	.rate		=3D 32768,
>   	.ops		=3D&clkops_null,
>   };
> @@ -512,6 +513,7 @@ static struct clk ddrphy_ck =3D {
>   	.name		=3D "ddrphy_ck",
>   	.parent		=3D&dpll_core_m2_ck,
>   	.ops		=3D&clkops_null,
> +	.clkdm_name	=3D "l3_emif_clkdm",
>   	.fixed_div	=3D 2,
>   	.recalc		=3D&omap_fixed_divisor_recalc,
>   };
> @@ -769,6 +771,7 @@ static const struct clksel dpll_mpu_m2_div[] =3D =
{
>   static struct clk dpll_mpu_m2_ck =3D {
>   	.name		=3D "dpll_mpu_m2_ck",
>   	.parent		=3D&dpll_mpu_ck,
> +	.clkdm_name	=3D "cm_clkdm",
>   	.clksel		=3D dpll_mpu_m2_div,
>   	.clksel_reg	=3D OMAP4430_CM_DIV_M2_DPLL_MPU,
>   	.clksel_mask	=3D OMAP4430_DPLL_CLKOUT_DIV_MASK,
> @@ -1149,6 +1152,7 @@ static const struct clksel l3_div_div[] =3D {
>   static struct clk l3_div_ck =3D {
>   	.name		=3D "l3_div_ck",
>   	.parent		=3D&div_core_ck,
> +	.clkdm_name	=3D "cm_clkdm",
>   	.clksel		=3D l3_div_div,
>   	.clksel_reg	=3D OMAP4430_CM_CLKSEL_CORE,
>   	.clksel_mask	=3D OMAP4430_CLKSEL_L3_MASK,
> @@ -2824,6 +2828,7 @@ static const struct clksel trace_clk_div_div[] =
=3D {
>   static struct clk trace_clk_div_ck =3D {
>   	.name		=3D "trace_clk_div_ck",
>   	.parent		=3D&pmd_trace_clk_mux_ck,
> +	.clkdm_name	=3D "emu_sys_clkdm",
>   	.clksel		=3D trace_clk_div_div,
>   	.clksel_reg	=3D OMAP4430_CM_EMU_DEBUGSS_CLKCTRL,
>   	.clksel_mask	=3D OMAP4430_CLKSEL_PMD_TRACE_CLK_MASK,
>
>

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
