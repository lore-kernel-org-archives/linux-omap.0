From: Mike Turquette <mturquette@linaro.org>
Subject: Re: [PATCH 1/2] ARM: OMAP4: clock data: div_iva_hs_clk is a
 power-of-two divider
Date: Fri, 14 Dec 2012 08:46:27 -0800
Message-ID: <CAPtuhTgvNw+Pzggi7OybygY0JJ+r-_HeYHQ0j5t8vdd6jPuhqQ@mail.gmail.com>
References: <20121214072028.24383.41000.stgit@dusk.lan> <20121214073248.24383.76201.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:50050 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756706Ab2LNQqs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Dec 2012 11:46:48 -0500
Received: by mail-gg0-f174.google.com with SMTP id k2so744123ggd.19
        for <linux-omap@vger.kernel.org>; Fri, 14 Dec 2012 08:46:47 -0800 (PST)
In-Reply-To: <20121214073248.24383.76201.stgit@dusk.lan>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Dec 13, 2012 at 11:32 PM, Paul Walmsley <paul@pwsan.com> wrote:
> The OMAP4 clock divider "div_iva_hs_clk" is listed in the clock data
> as an OMAP HSDIVIDER, but it's actually a power-of-two divider.  This
> causes a warning during boot on an OMAP4460 Pandaboard-ES with a
> recent u-boot:
>
> WARNING: at arch/arm/mach-omap2/clkt_clksel.c:143 omap2_clksel_recalc+0xf4/0x12c()
> clock: div_iva_hs_clk: could not find fieldval 0 for parent dpll_core_m5x2_ck
>
> Fix by converting the data for this clock to a power-of-two divider.
>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Mike Turquette <mturquette@linaro.org>
> ---
>  arch/arm/mach-omap2/cclock44xx_data.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/cclock44xx_data.c b/arch/arm/mach-omap2/cclock44xx_data.c
> index aa56c3e..a3c54b2 100644
> --- a/arch/arm/mach-omap2/cclock44xx_data.c
> +++ b/arch/arm/mach-omap2/cclock44xx_data.c
> @@ -286,9 +286,9 @@ DEFINE_CLK_DIVIDER(div_core_ck, "dpll_core_m5x2_ck", &dpll_core_m5x2_ck, 0x0,
>                    OMAP4430_CM_CLKSEL_CORE, OMAP4430_CLKSEL_CORE_SHIFT,
>                    OMAP4430_CLKSEL_CORE_WIDTH, 0x0, NULL);
>
> -DEFINE_CLK_OMAP_HSDIVIDER(div_iva_hs_clk, "dpll_core_m5x2_ck",
> -                         &dpll_core_m5x2_ck, 0x0, OMAP4430_CM_BYPCLK_DPLL_IVA,
> -                         OMAP4430_CLKSEL_0_1_MASK);
> +DEFINE_CLK_DIVIDER(div_iva_hs_clk, "dpll_core_m5x2_ck", &dpll_core_m5x2_ck,
> +                  0x0, OMAP4430_CM_BYPCLK_DPLL_IVA, OMAP4430_CLKSEL_0_1_SHIFT,
> +                  OMAP4430_CLKSEL_0_1_WIDTH, CLK_DIVIDER_POWER_OF_TWO, NULL);
>

Hi Paul,

Looks good to me.

Regards,
Mike

>  DEFINE_CLK_DIVIDER(div_mpu_hs_clk, "dpll_core_m5x2_ck", &dpll_core_m5x2_ck,
>                    0x0, OMAP4430_CM_BYPCLK_DPLL_MPU, OMAP4430_CLKSEL_0_1_SHIFT,
>
>
