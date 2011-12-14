From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH v4 REPOST 5/5] imx6q: Remove unconditional dependency on
 l2x0 L2 cache support
Date: Wed, 14 Dec 2011 21:26:24 +0800
Message-ID: <20111214132622.GA1520@S2100-06.ap.freescale.net>
References: <1323862781-3465-1-git-send-email-dave.martin@linaro.org>
 <1323862781-3465-6-git-send-email-dave.martin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from va3ehsobe005.messaging.microsoft.com ([216.32.180.31]:32965
	"EHLO VA3EHSOBE005.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754615Ab1LNNN0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Dec 2011 08:13:26 -0500
Content-Disposition: inline
In-Reply-To: <1323862781-3465-6-git-send-email-dave.martin@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Martin <dave.martin@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, Will Deacon <will.deacon@arm.com>, Kukjin Kim <kgene.kim@samsung.com>, Pawel Moll <pawel.moll@arm.com>, patches@linaro.org, linux-sh@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Anton Vorontsov <avorontsov@mvista.com>, Magnus Damm <magnus.damm@gmail.com>, Haojian Zhuang <haojian.zhuang@marvell.com>, Colin Cross <ccross@google.com>, Shawn Guo <shawn.guo@linaro.org>, Tony Lindgren <tony@atomide.com>, Paul Mundt <lethal@linux-sh.org>, linux-samsung-soc@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, Sascha Hauer <kernel@pengutronix.de>, Barry Song <baohua.song@csr.com>, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, John Linn <john.linn@xilinx.com>

Hi Dave,

Sorry for that I did not look into previous post to point it out.

On Wed, Dec 14, 2011 at 11:39:41AM +0000, Dave Martin wrote:
> The i.MX6 Quad SoC will work without the l2x0 L2 cache controller
> support built into the kernel, so this patch removes the dependency
> on CACHE_L2X0 and selects MIGHT_HAVE_CACHE_L2X0 instead.
> 
> This makes the l2x0 support optional, so that it can be turned off
> when desired for debugging purposes etc.
> 
> Thanks to Shawn Guo for this suggestion. [1]
> 
> Signed-off-by: Dave Martin <dave.martin@linaro.org>
> 
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2011-November/074602.html
> ---
>  arch/arm/mach-imx/Kconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> index 29a3d61..1fb93f2 100644
> --- a/arch/arm/mach-imx/Kconfig
> +++ b/arch/arm/mach-imx/Kconfig
> @@ -609,13 +609,13 @@ comment "i.MX6 family:"
>  config SOC_IMX6Q
>  	bool "i.MX6 Quad support"
>  	select ARM_GIC
> -	select CACHE_L2X0
>  	select CPU_V7
>  	select HAVE_ARM_SCU
>  	select HAVE_IMX_GPC
>  	select HAVE_IMX_MMDC
>  	select HAVE_IMX_SRC
>  	select HAVE_SMP
> +	select MIGHT_HAVE_CACHE_L2X0

The option SOC_IMX6Q is only available when ARCH_IMX_V6_V7 is selected.
Since MIGHT_HAVE_CACHE_L2X0 has been selected by ARCH_IMX_V6_V7 in
patch #1, this line seems redundant here.

Regards,
Shawn

>  	select USE_OF
>  
>  	help
> -- 
> 1.7.4.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

