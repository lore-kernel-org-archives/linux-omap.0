From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 02/14] ARM: OMAP2+: AM43x: Kconfig
Date: Wed, 12 Jun 2013 10:12:00 -0700
Message-ID: <20130612171200.GL8164@atomide.com>
References: <cover.1369658705.git.afzal@ti.com>
 <7642e0c701680ea94a8cc84059ff19e500813bf1.1369658705.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7642e0c701680ea94a8cc84059ff19e500813bf1.1369658705.git.afzal@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Afzal Mohammed <afzal@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Benoit Cousson <benoit.cousson@linaro.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Rob Landley <rob@landley.net>
List-Id: linux-omap@vger.kernel.org

* Afzal Mohammed <afzal@ti.com> [130527 07:41]:
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -149,6 +149,16 @@ config SOC_AM33XX
>  	select MULTI_IRQ_HANDLER
>  	select COMMON_CLK
>  
> +config SOC_AM43XX
> +	bool "TI AM43x"
> +	depends on ARCH_OMAP2PLUS
> +	default y
> +	select CPU_V7
> +	select MULTI_IRQ_HANDLER
> +	select ARM_GIC
> +	select COMMON_CLK
> +	select MACH_OMAP_GENERIC
> +
>  config OMAP_PACKAGE_ZAF
>         bool

I've updated this patch to remove the "default y" and
"depends on ARCH_OMAP2PLUS" entries for the usual reasons
and applied the first ten patches into omap-for-v3.11/soc.

Regards,

Tony
