From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH v3 1/5] clk: Kconfig: add entry for HAVE_CLK_PREPARE
Date: Sat, 26 Nov 2011 08:51:30 +0800
Message-ID: <20111126005128.GA19025@S2100-06.ap.freescale.net>
References: <1321926047-14211-1-git-send-email-mturquette@linaro.org>
 <1321926047-14211-2-git-send-email-mturquette@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1321926047-14211-2-git-send-email-mturquette@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mike Turquette <mturquette@ti.com>
Cc: linux@arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, jeremy.kerr@canonical.com, broonie@opensource.wolfsonmicro.com, tglx@linutronix.de, linus.walleij@stericsson.com, amit.kucheria@linaro.org, dsaxena@linaro.org, patches@linaro.org, linaro-dev@lists.linaro.org, aul@pwsan.com, grant.likely@secretlab.ca, sboyd@quicinc.com, skannan@quicinc.com, magnus.damm@gmail.com, arnd.bergmann@linaro.org, eric.miao@linaro.org, richard.zhao@linaro.org, Mike Turquette <mturquette@linaro.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Nov 21, 2011 at 05:40:43PM -0800, Mike Turquette wrote:
> The common clk framework provides clk_prepare and clk_unprepare
> implementations.  Create an entry for HAVE_CLK_PREPARE so that
> GENERIC_CLK can select it.
> 
> Signed-off-by: Mike Turquette <mturquette@linaro.org>
> ---

Acked-by: Shawn Guo <shawn.guo@linaro.org>

Regards,
Shawn

>  drivers/clk/Kconfig |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index 3530927..7a9899bd 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -5,3 +5,6 @@ config CLKDEV_LOOKUP
>  
>  config HAVE_MACH_CLKDEV
>  	bool
> +
> +config HAVE_CLK_PREPARE
> +	bool
> -- 
> 1.7.4.1
