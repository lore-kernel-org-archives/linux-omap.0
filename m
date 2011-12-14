From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v4 REPOST 3/5] omap4: Unconditionally require l2x0 L2
 cache controller support
Date: Wed, 14 Dec 2011 10:14:25 -0800
Message-ID: <20111214181425.GB32251@atomide.com>
References: <1323862781-3465-1-git-send-email-dave.martin@linaro.org>
 <1323862781-3465-4-git-send-email-dave.martin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1323862781-3465-4-git-send-email-dave.martin@linaro.org>
Sender: linux-sh-owner@vger.kernel.org
To: Dave Martin <dave.martin@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, patches@linaro.org, Anton Vorontsov <avorontsov@mvista.com>, Barry Song <baohua.song@csr.com>, Catalin Marinas <catalin.marinas@arm.com>, Colin Cross <ccross@google.com>, Haojian Zhuang <haojian.zhuang@marvell.com>, John Linn <john.linn@xilinx.com>, Kukjin Kim <kgene.kim@samsung.com>, Linus Walleij <linus.walleij@linaro.org>, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-sh@vger.kernel.org, linux-tegra@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Paul Mundt <lethal@linux-sh.org>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <rob.herring@calxeda.com>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, Will Deacon <will.deacon@arm.com>
List-Id: linux-omap@vger.kernel.org

* Dave Martin <dave.martin@linaro.org> [111214 03:08]:
> If running in the Normal World on a TrustZone-enabled SoC, Linux
> does not have complete control over the L2 cache controller
> configuration.  The kernel cannot work reliably on such platforms
> without the l2x0 cache support code built in.

There are HS and GP omaps (High Security and General Purpose).
GP omaps do have full control of the L2. Also HS omaps most likely
provide control over enabling and disabling L2 depending how the
secure code is implemented.

BTW, the real problem is that because the secure code is implemented
in various ways, we don't really have any handling for it in Linux.

The SMI instruction numbers don't seem to be standardized at all,
and can mean different things on different boards, even different
board versions :(

Sounds like devicetree is the only safe way to deal with the L2
control options.

Regards,

Tony

 
> This patch unconditionally enables l2x0 support for the OMAP4 SoCs.
> 
> Thanks to Rob Herring for this suggestion. [1]
> 
> Signed-off-by: Dave Martin <dave.martin@linaro.org>
> 
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2011-November/074495.html
> ---
>  arch/arm/mach-omap2/Kconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index bb1b670..94e568a 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -41,11 +41,11 @@ config ARCH_OMAP4
>  	bool "TI OMAP4"
>  	default y
>  	depends on ARCH_OMAP2PLUS
> +	select CACHE_L2X0
>  	select CPU_V7
>  	select ARM_GIC
>  	select HAVE_SMP
>  	select LOCAL_TIMERS if SMP
> -	select MIGHT_HAVE_CACHE_L2X0
>  	select PL310_ERRATA_588369
>  	select PL310_ERRATA_727915
>  	select ARM_ERRATA_720789
> -- 
> 1.7.4.1
> 
