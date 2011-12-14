From: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH v4 REPOST 4/5] highbank: Unconditionally require l2x0
 L2 cache controller support
Date: Wed, 14 Dec 2011 07:37:32 -0600
Message-ID: <4EE8A69C.40304@gmail.com>
References: <1323862781-3465-1-git-send-email-dave.martin@linaro.org> <1323862781-3465-5-git-send-email-dave.martin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1323862781-3465-5-git-send-email-dave.martin@linaro.org>
Sender: linux-sh-owner@vger.kernel.org
To: Dave Martin <dave.martin@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, patches@linaro.org, Anton Vorontsov <avorontsov@mvista.com>, Barry Song <baohua.song@csr.com>, Catalin Marinas <catalin.marinas@arm.com>, Colin Cross <ccross@google.com>, Haojian Zhuang <haojian.zhuang@marvell.com>, John Linn <john.linn@xilinx.com>, Kukjin Kim <kgene.kim@samsung.com>, Linus Walleij <linus.walleij@linaro.org>, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-sh@vger.kernel.org, linux-tegra@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Paul Mundt <lethal@linux-sh.org>, Pawel Moll <pawel.moll@arm.com>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, Tony Lindgren <tony@atomide.com>, Will Deacon <will.deacon@arm.com>
List-Id: linux-omap@vger.kernel.org


On 12/14/2011 05:39 AM, Dave Martin wrote:
> If running in the Normal World on a TrustZone-enabled SoC, Linux
> does not have complete control over the L2 cache controller
> configuration.  The kernel cannot work reliably on such platforms
> without the l2x0 cache support code built in.
> 
> This patch unconditionally enables l2x0 support for the Highbank
> SoC.
> 
> Thanks to Rob Herring for this suggestion. [1]
> 
> Signed-off-by: Dave Martin <dave.martin@linaro.org>
> 
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2011-November/074495.html

Doesn't this need to be above the SOB? Otherwise:

Acked-by: Rob Herring <rob.herring@calxeda.com>

> ---
>  arch/arm/Kconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index d33eb39..744296d 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -340,12 +340,12 @@ config ARCH_HIGHBANK
>  	select ARM_AMBA
>  	select ARM_GIC
>  	select ARM_TIMER_SP804
> +	select CACHE_L2X0
>  	select CLKDEV_LOOKUP
>  	select CPU_V7
>  	select GENERIC_CLOCKEVENTS
>  	select HAVE_ARM_SCU
>  	select HAVE_SMP
> -	select MIGHT_HAVE_CACHE_L2X0
>  	select USE_OF
>  	help
>  	  Support for the Calxeda Highbank SoC based boards.
