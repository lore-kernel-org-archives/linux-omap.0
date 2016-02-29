From: Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCH] clk: ti: Allow COMPILE_TEST to build selected drivers
Date: Mon, 29 Feb 2016 14:20:27 -0800
Message-ID: <20160229222027.3140.90691@quark.deferred.io>
References: <1456508703-17390-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1456508703-17390-1-git-send-email-tony@atomide.com>
Sender: linux-clk-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Stephen Boyd <sboyd@codeaurora.org>, Tero Kristo <t-kristo@ti.com>
Cc: linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Quoting Tony Lindgren (2016-02-26 09:45:03)
> The arch independent drivers can be build testeed with
> COMPILE_TEST. Let's allow that for drivers/clk/ti.
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Applied.

Regards,
Mike

> ---
>  drivers/clk/Makefile    | 2 +-
>  drivers/clk/ti/Makefile | 4 ++++
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> ---
> 
> This allows the appll driver to be built with COMPILE_TEST,
> and this is not currently needed without the adpll driver.
> 
> diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> index b038e36..45939a1 100644
> --- a/drivers/clk/Makefile
> +++ b/drivers/clk/Makefile
> @@ -78,7 +78,7 @@ obj-$(CONFIG_PLAT_SPEAR)              += spear/
>  obj-$(CONFIG_ARCH_STI)                 += st/
>  obj-$(CONFIG_ARCH_SUNXI)               += sunxi/
>  obj-$(CONFIG_ARCH_TEGRA)               += tegra/
> -obj-$(CONFIG_ARCH_OMAP2PLUS)           += ti/
> +obj-y                                  += ti/
>  obj-$(CONFIG_ARCH_U8500)               += ux500/
>  obj-$(CONFIG_COMMON_CLK_VERSATILE)     += versatile/
>  obj-$(CONFIG_X86)                      += x86/
> diff --git a/drivers/clk/ti/Makefile b/drivers/clk/ti/Makefile
> index dfe91d7..0deac98 100644
> --- a/drivers/clk/ti/Makefile
> +++ b/drivers/clk/ti/Makefile
> @@ -1,3 +1,5 @@
> +ifeq ($(CONFIG_ARCH_OMAP2PLUS), y)
> +
>  obj-y                                  += clk.o autoidle.o clockdomain.o
>  clk-common                             = dpll.o composite.o divider.o gate.o \
>                                           fixed-factor.o mux.o apll.o \
> @@ -19,4 +21,6 @@ ifdef CONFIG_ATAGS
>  obj-$(CONFIG_ARCH_OMAP3)                += clk-3xxx-legacy.o
>  endif
>  
> +endif  # CONFIG_ARCH_OMAP2PLUS
> +
>  obj-$(CONFIG_COMMON_CLK_TI_ADPLL)      += adpll.o
> -- 
> 2.7.0
> 
