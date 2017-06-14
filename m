From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv2] ARM: OMAP: PM: stop early on systems without twl
Date: Tue, 13 Jun 2017 22:47:27 -0700
Message-ID: <20170614054727.GE3730@atomide.com>
References: <20170612102527.GX3730@atomide.com>
 <20170613094617.29166-1-sre@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170613094617.29166-1-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Sebastian Reichel <sebastian.reichel@collabora.co.uk>
List-Id: linux-omap@vger.kernel.org

* Sebastian Reichel <sre@kernel.org> [170613 02:50]:
> From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
> index 63027e60cc20..92e335decc61 100644
> --- a/arch/arm/mach-omap2/pm.c
> +++ b/arch/arm/mach-omap2/pm.c
> @@ -240,6 +240,10 @@ omap_postcore_initcall(omap2_common_pm_init);
>  
>  int __init omap2_common_pm_late_init(void)
>  {
> +#if IS_BUILTIN(CONFIG_TWL6040_CORE) || IS_BUILTIN(CONFIG_TWL4030_CORE)
> +	if (!twl_rev())
> +		goto no_twl;
> +
>  	/* Init the voltage layer */
>  	omap3_twl_init();
>  	omap4_twl_init();
> @@ -253,4 +257,9 @@ int __init omap2_common_pm_late_init(void)
>  	omap_devinit_smartreflex();
>  
>  	return 0;
> +
> +no_twl:
> +#endif
> +	pr_err("OMAP4 PM not supported!\n");
> +	return -ENODEV;

This should probably just say "OMAP4 SmartReflex not supported".
We already have omap4 CPUs hit off mode during idle. What's
missing is save and restore of registers for various domains.

SmartReflex is also doable without twl PMICs, at least ti81xx
are doing SmartReflex over a group of GPIO pins without twl.

So maybe just put the twl specific parts into IS_BUILTIN so
we can optionally add other PM init here if needed?

Regards,

Tony
