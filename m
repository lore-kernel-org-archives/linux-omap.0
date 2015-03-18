From: Michael Turquette <mturquette@linaro.org>
Subject: Re: [PATCH 32/35 linux-next] clk: constify of_device_id array
Date: Wed, 18 Mar 2015 07:15:09 -0700
Message-ID: <20150318141509.7930.28419@quantum>
References: <1426533469-25458-1-git-send-email-fabf@skynet.be>
 <1426535949-26107-1-git-send-email-fabf@skynet.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426535949-26107-1-git-send-email-fabf@skynet.be>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Fabian Frederick <fabf@skynet.be>, Stephen Boyd <sboyd@codeaurora.org>, Tero Kristo <t-kristo@ti.com>, Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Quoting Fabian Frederick (2015-03-16 12:59:06)
> of_device_id is always used as const.
> (See driver.of_match_table and open firmware functions)
> 
> Signed-off-by: Fabian Frederick <fabf@skynet.be>

Acked-by: Michael Turquette <mturquette@linaro.org>

> ---
>  drivers/clk/clk-palmas.c                 | 2 +-
>  drivers/clk/st/clkgen-fsyn.c             | 2 +-
>  drivers/clk/st/clkgen-mux.c              | 8 ++++----
>  drivers/clk/st/clkgen-pll.c              | 4 ++--
>  drivers/clk/ti/clk-dra7-atl.c            | 2 +-
>  drivers/clk/ti/clockdomain.c             | 2 +-
>  drivers/clk/versatile/clk-vexpress-osc.c | 2 +-
>  7 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/clk/clk-palmas.c b/drivers/clk/clk-palmas.c
> index 8d45992..45a535a 100644
> --- a/drivers/clk/clk-palmas.c
> +++ b/drivers/clk/clk-palmas.c
> @@ -161,7 +161,7 @@ static struct palmas_clks_of_match_data palmas_of_clk32kgaudio = {
>         },
>  };
>  
> -static struct of_device_id palmas_clks_of_match[] = {
> +static const struct of_device_id palmas_clks_of_match[] = {
>         {
>                 .compatible = "ti,palmas-clk32kg",
>                 .data = &palmas_of_clk32kg,
> diff --git a/drivers/clk/st/clkgen-fsyn.c b/drivers/clk/st/clkgen-fsyn.c
> index af94ed8..a917c4c 100644
> --- a/drivers/clk/st/clkgen-fsyn.c
> +++ b/drivers/clk/st/clkgen-fsyn.c
> @@ -1057,7 +1057,7 @@ static struct clk * __init st_clk_register_quadfs_fsynth(
>         return clk;
>  }
>  
> -static struct of_device_id quadfs_of_match[] = {
> +static const struct of_device_id quadfs_of_match[] = {
>         {
>                 .compatible = "st,stih416-quadfs216",
>                 .data = &st_fs216c65_416
> diff --git a/drivers/clk/st/clkgen-mux.c b/drivers/clk/st/clkgen-mux.c
> index 9a15ec3..fdcff10 100644
> --- a/drivers/clk/st/clkgen-mux.c
> +++ b/drivers/clk/st/clkgen-mux.c
> @@ -341,7 +341,7 @@ static struct clkgena_divmux_data st_divmux_c32odf3 = {
>         .fb_start_bit_idx = 24,
>  };
>  
> -static struct of_device_id clkgena_divmux_of_match[] = {
> +static const struct of_device_id clkgena_divmux_of_match[] = {
>         {
>                 .compatible = "st,clkgena-divmux-c65-hs",
>                 .data = &st_divmux_c65hs,
> @@ -479,7 +479,7 @@ static struct clkgena_prediv_data prediv_c32_data = {
>         .table = prediv_table16,
>  };
>  
> -static struct of_device_id clkgena_prediv_of_match[] = {
> +static const struct of_device_id clkgena_prediv_of_match[] = {
>         { .compatible = "st,clkgena-prediv-c65", .data = &prediv_c65_data },
>         { .compatible = "st,clkgena-prediv-c32", .data = &prediv_c32_data },
>         {}
> @@ -586,7 +586,7 @@ static struct clkgen_mux_data stih407_a9_mux_data = {
>         .width = 2,
>  };
>  
> -static struct of_device_id mux_of_match[] = {
> +static const struct of_device_id mux_of_match[] = {
>         {
>                 .compatible = "st,stih416-clkgenc-vcc-hd",
>                 .data = &clkgen_mux_c_vcc_hd_416,
> @@ -693,7 +693,7 @@ static struct clkgen_vcc_data st_clkgenf_vcc_416 = {
>         .lock = &clkgenf_lock,
>  };
>  
> -static struct of_device_id vcc_of_match[] = {
> +static const struct of_device_id vcc_of_match[] = {
>         { .compatible = "st,stih416-clkgenc", .data = &st_clkgenc_vcc_416 },
>         { .compatible = "st,stih416-clkgenf", .data = &st_clkgenf_vcc_416 },
>         {}
> diff --git a/drivers/clk/st/clkgen-pll.c b/drivers/clk/st/clkgen-pll.c
> index 29769d7..d204ba8 100644
> --- a/drivers/clk/st/clkgen-pll.c
> +++ b/drivers/clk/st/clkgen-pll.c
> @@ -593,7 +593,7 @@ static struct clk * __init clkgen_odf_register(const char *parent_name,
>         return clk;
>  }
>  
> -static struct of_device_id c32_pll_of_match[] = {
> +static const struct of_device_id c32_pll_of_match[] = {
>         {
>                 .compatible = "st,plls-c32-a1x-0",
>                 .data = &st_pll3200c32_a1x_0,
> @@ -708,7 +708,7 @@ err:
>  }
>  CLK_OF_DECLARE(clkgen_c32_pll, "st,clkgen-plls-c32", clkgen_c32_pll_setup);
>  
> -static struct of_device_id c32_gpu_pll_of_match[] = {
> +static const struct of_device_id c32_gpu_pll_of_match[] = {
>         {
>                 .compatible = "st,stih415-gpu-pll-c32",
>                 .data = &st_pll1200c32_gpu_415,
> diff --git a/drivers/clk/ti/clk-dra7-atl.c b/drivers/clk/ti/clk-dra7-atl.c
> index 59bb4b3..d86bc46 100644
> --- a/drivers/clk/ti/clk-dra7-atl.c
> +++ b/drivers/clk/ti/clk-dra7-atl.c
> @@ -294,7 +294,7 @@ static int of_dra7_atl_clk_remove(struct platform_device *pdev)
>         return 0;
>  }
>  
> -static struct of_device_id of_dra7_atl_clk_match_tbl[] = {
> +static const struct of_device_id of_dra7_atl_clk_match_tbl[] = {
>         { .compatible = "ti,dra7-atl", },
>         {},
>  };
> diff --git a/drivers/clk/ti/clockdomain.c b/drivers/clk/ti/clockdomain.c
> index b4c5fac..35fe108 100644
> --- a/drivers/clk/ti/clockdomain.c
> +++ b/drivers/clk/ti/clockdomain.c
> @@ -52,7 +52,7 @@ static void __init of_ti_clockdomain_setup(struct device_node *node)
>         }
>  }
>  
> -static struct of_device_id ti_clkdm_match_table[] __initdata = {
> +static const struct of_device_id ti_clkdm_match_table[] __initconst = {
>         { .compatible = "ti,clockdomain" },
>         { }
>  };
> diff --git a/drivers/clk/versatile/clk-vexpress-osc.c b/drivers/clk/versatile/clk-vexpress-osc.c
> index 765f1e0..89c0609 100644
> --- a/drivers/clk/versatile/clk-vexpress-osc.c
> +++ b/drivers/clk/versatile/clk-vexpress-osc.c
> @@ -110,7 +110,7 @@ static int vexpress_osc_probe(struct platform_device *pdev)
>         return 0;
>  }
>  
> -static struct of_device_id vexpress_osc_of_match[] = {
> +static const struct of_device_id vexpress_osc_of_match[] = {
>         { .compatible = "arm,vexpress-osc", },
>         {}
>  };
> -- 
> 2.1.0
> 
