From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH V3 1/2] ARM: OMAP3+: use cpu0-cpufreq driver in device tree supported boot
Date: Wed, 03 Apr 2013 11:47:03 -0700
Message-ID: <87ppybxxi0.fsf@linaro.org>
References: <1364507576-19345-1-git-send-email-nm@ti.com>
	<1364507576-19345-2-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f48.google.com ([209.85.160.48]:48317 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761006Ab3DCSrH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Apr 2013 14:47:07 -0400
Received: by mail-pb0-f48.google.com with SMTP id xb4so996432pbc.21
        for <linux-omap@vger.kernel.org>; Wed, 03 Apr 2013 11:47:07 -0700 (PDT)
In-Reply-To: <1364507576-19345-2-git-send-email-nm@ti.com> (Nishanth Menon's
	message of "Thu, 28 Mar 2013 16:52:55 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap@vger.kernel.org, Rob Herring <robherring2@gmail.com>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Rajendra Nayak <rnayak@ti.com>, Paul Walmsley <paul@pwsan.com>, =?utf-8?Q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>, Jon Hunter <jon-hunter@ti.com>, Keerthy <j-keerthy@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Shawn Guo <shawn.guo@linaro.org>

Nishanth Menon <nm@ti.com> writes:

> With OMAP3+ and AM33xx supported SoC having defined CPU device tree
> entries with operating-points defined, we can now use the SoC
> generic cpufreq-cpu0 driver by registering appropriate device.
>
> As part of this change, add dummy clock node to use cpufreq-cpu0.
> This is an suggested solution till we have OMAP clock nodes in device
> tree.
> Once the OMAP device tree conversion is complete, we can then do:
> clocks =3D <&dpll_mpu_ck>; or the SoC specific equivalent.
> Inspired by patch: https://patchwork.kernel.org/patch/2067841/
> now made generic.
>
> Cc: Kevin Hilman <khilman@linaro.org>
> Cc: Rajendra Nayak <rnayak@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: "Beno=C3=AEt Cousson" <b-cousson@ti.com>
> Cc: Jon Hunter <jon-hunter@ti.com>
> Cc: Keerthy <j-keerthy@ti.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Signed-off-by: Nishanth Menon <nm@ti.com>

One more thought on this patch...
> ---
> Changes in v3:
> 	- modified CC list.
> 	- no functional change
> V2: https://patchwork.kernel.org/patch/2303471/
> V1: https://patchwork.kernel.org/patch/2273571/
>
>  arch/arm/mach-omap2/board-generic.c   |    5 +++++
>  arch/arm/mach-omap2/cclock33xx_data.c |    2 +-
>  arch/arm/mach-omap2/cclock3xxx_data.c |    3 ++-
>  arch/arm/mach-omap2/cclock44xx_data.c |    3 ++-
>  4 files changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap=
2/board-generic.c
> index afa509a..5b147ef 100644
> --- a/arch/arm/mach-omap2/board-generic.c
> +++ b/arch/arm/mach-omap2/board-generic.c
> @@ -49,6 +49,11 @@ static void __init omap_generic_init(void)
>  		omap4_panda_display_init_of();
>  	else if (of_machine_is_compatible("ti,omap4-sdp"))
>  		omap_4430sdp_display_init_of();
> +
> +	if (IS_ENABLED(CONFIG_GENERIC_CPUFREQ_CPU0)) {
> +		struct platform_device_info devinfo =3D { .name =3D "cpufreq-cpu0"=
, };
> +		platform_device_register_full(&devinfo);
> +	}

Rather than adding new clkdev nodes below, how about using clk add_alia=
s
here?

Kevin

>  }
> =20
>  #ifdef CONFIG_SOC_OMAP2420
> diff --git a/arch/arm/mach-omap2/cclock33xx_data.c b/arch/arm/mach-om=
ap2/cclock33xx_data.c
> index 476b820..cf7e736 100644
> --- a/arch/arm/mach-omap2/cclock33xx_data.c
> +++ b/arch/arm/mach-omap2/cclock33xx_data.c
> @@ -852,7 +852,7 @@ static struct omap_clk am33xx_clks[] =3D {
>  	CLK(NULL,	"dpll_core_m5_ck",	&dpll_core_m5_ck,	CK_AM33XX),
>  	CLK(NULL,	"dpll_core_m6_ck",	&dpll_core_m6_ck,	CK_AM33XX),
>  	CLK(NULL,	"dpll_mpu_ck",		&dpll_mpu_ck,	CK_AM33XX),
> -	CLK("cpu0",	NULL,			&dpll_mpu_ck,	CK_AM33XX),
> +	CLK("cpufreq-cpu0.0",	NULL,			&dpll_mpu_ck,	CK_AM33XX),
>  	CLK(NULL,	"dpll_mpu_m2_ck",	&dpll_mpu_m2_ck,	CK_AM33XX),
>  	CLK(NULL,	"dpll_ddr_ck",		&dpll_ddr_ck,	CK_AM33XX),
>  	CLK(NULL,	"dpll_ddr_m2_ck",	&dpll_ddr_m2_ck,	CK_AM33XX),
> diff --git a/arch/arm/mach-omap2/cclock3xxx_data.c b/arch/arm/mach-om=
ap2/cclock3xxx_data.c
> index 4579c3c..5a5b471 100644
> --- a/arch/arm/mach-omap2/cclock3xxx_data.c
> +++ b/arch/arm/mach-omap2/cclock3xxx_data.c
> @@ -3501,7 +3501,8 @@ static struct omap_clk omap3xxx_clks[] =3D {
>  	CLK(NULL,	"uart4_ick",	&uart4_ick_am35xx,	CK_AM35XX),
>  	CLK(NULL,	"timer_32k_ck",	&omap_32k_fck,  CK_3XXX),
>  	CLK(NULL,	"timer_sys_ck",	&sys_ck,	CK_3XXX),
> -	CLK(NULL,	"cpufreq_ck",	&dpll1_ck,	CK_3XXX),
> +	CLK(NULL,	"cpufreq_ck",	&dpll1_ck,	CK_3XXX), /* used in non-device =
tree boot */
> +	CLK("cpufreq-cpu0.0",	NULL,	&dpll1_ck,	CK_3XXX), /* used in device =
tree boot */
>  };
> =20
>  static const char *enable_init_clks[] =3D {
> diff --git a/arch/arm/mach-omap2/cclock44xx_data.c b/arch/arm/mach-om=
ap2/cclock44xx_data.c
> index 3d58f33..bcea785 100644
> --- a/arch/arm/mach-omap2/cclock44xx_data.c
> +++ b/arch/arm/mach-omap2/cclock44xx_data.c
> @@ -1660,7 +1660,8 @@ static struct omap_clk omap44xx_clks[] =3D {
>  	CLK("4013a000.timer",	"timer_sys_ck",	&syc_clk_div_ck,	CK_443X),
>  	CLK("4013c000.timer",	"timer_sys_ck",	&syc_clk_div_ck,	CK_443X),
>  	CLK("4013e000.timer",	"timer_sys_ck",	&syc_clk_div_ck,	CK_443X),
> -	CLK(NULL,	"cpufreq_ck",	&dpll_mpu_ck,	CK_443X),
> +	CLK(NULL,	"cpufreq_ck",	&dpll_mpu_ck,	CK_443X), /* used in non-devi=
ce tree boot */
> +	CLK("cpufreq-cpu0.0",	NULL,	&dpll_mpu_ck,	CK_443X), /* used in devi=
ce tree boot */
>  };
> =20
>  int __init omap4xxx_clk_init(void)
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
