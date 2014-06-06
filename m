From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] PM / OPP: Remove ARCH_HAS_OPP
Date: Fri, 6 Jun 2014 09:33:19 -0500
Message-ID: <5391D12F.4020501@ti.com>
References: <1402051016-28853-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1402051016-28853-1-git-send-email-broonie@kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Russell King <linux@arm.linux.org.uk>, Kukjin Kim <kgene.kim@samsung.com>, Rob Herring <robh@kernel.org>, Shawn Guo <shawn.guo@freescale.com>, Sascha Hauer <kernel@pengutronix.de>, Tony Lindgren <tony@atomide.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Michal Simek <michal.simek@xilinx.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org, linux-sh@vger.kernel.org, Mark Brown <broonie@linaro.org>
List-Id: linux-omap@vger.kernel.org

On 06/06/2014 05:36 AM, Mark Brown wrote:
[...]
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index 0ba4826..524b027 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -12,7 +12,6 @@ config ARCH_OMAP3
>  	bool "TI OMAP3"
>  	depends on ARCH_MULTI_V7
>  	select ARCH_OMAP2PLUS
> -	select ARCH_HAS_OPP
>  	select ARM_CPU_SUSPEND if PM
>  	select OMAP_INTERCONNECT
>  	select PM_OPP if PM

For OMAP portion:
Acked-by: Nishanth Menon <nm@ti.com>

-- 
Regards,
Nishanth Menon
