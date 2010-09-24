From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 1/5] Adding LogicPD OMAP3 board support
Date: Fri, 24 Sep 2010 15:58:19 -0700
Message-ID: <20100924225818.GL4211@atomide.com>
References: <1285358338-3403-1-git-send-email-tim.nordell@logicpd.com>
 <1285358338-3403-2-git-send-email-tim.nordell@logicpd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1285358338-3403-2-git-send-email-tim.nordell@logicpd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tim Nordell <tim.nordell@logicpd.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Tim Nordell <tim.nordell@logicpd.com> [100924 13:06]:
> Adding support for LogicPD's OMAP 3530 LV SOM and
> OMAP 35x Torpedo board.
> 
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -135,6 +135,24 @@ config MACH_OMAP_LDP
>  	default y
>  	select OMAP_PACKAGE_CBB
>  
> +config MACH_OMAP3530_LV_SOM
> +	bool "OMAP3 Logic 3530 LV SOM board"
> +	depends on ARCH_OMAP3
> +	default y
> +	help
> +	 Support for the LogicPD OMAP3530 SOM Development kit
> +	 for full description please see the products webpage at
> +	 http://www.logicpd.com/products/development-kits/texas-instruments-zoom%E2%84%A2-omap35x-development-kit
> +
> +config MACH_OMAP3_TORPEDO
> +	bool "OMAP3 Logic 35x Torpedo board"
> +	depends on ARCH_OMAP3
> +	default y
> +	help
> +	 Support for the LogicPD OMAP35x Torpedo Development kit
> +	 for full description please see the products webpage at
> +	 http://www.logicpd.com/products/development-kits/zoom-omap35x-torpedo-development-kit
> +

Missing select OMAP_PACKAGE_XXX for both boards?

Also, please add the DEBUG_LL entries to
arch/arm/plat-omap/include/plat/uncompress.h. You can test
that by enabling DEBUG_LL and EARLY_PRINTK and have earlyprintk
in your kernel cmdline.

And please repost the whole series so linux-arm-kernel
list is also Cc'd.

Regards,

Tony
