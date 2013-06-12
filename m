From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 07/14] ARM: OMAP2+: AM43x: early init
Date: Wed, 12 Jun 2013 10:14:24 -0700
Message-ID: <20130612171424.GN8164@atomide.com>
References: <cover.1369658705.git.afzal@ti.com>
 <82f3b2b672a45b971fd0bb34366a6af368015db0.1369658705.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <82f3b2b672a45b971fd0bb34366a6af368015db0.1369658705.git.afzal@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Afzal Mohammed <afzal@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Benoit Cousson <benoit.cousson@linaro.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Rob Landley <rob@landley.net>
List-Id: linux-omap@vger.kernel.org

* Afzal Mohammed <afzal@ti.com> [130527 07:42]:
> --- a/arch/arm/mach-omap2/io.c
> +++ b/arch/arm/mach-omap2/io.c
> @@ -586,6 +586,20 @@ void __init am33xx_init_early(void)
>  }
>  #endif
>  
> +#ifdef CONFIG_SOC_AM43XX
> +void __init am43xx_init_early(void)
> +{
> +	omap2_set_globals_tap(AM335X_CLASS,
> +			      AM33XX_L4_WK_IO_ADDRESS(AM33XX_TAP_BASE));
> +	omap2_set_globals_control(AM33XX_L4_WK_IO_ADDRESS(AM33XX_CTRL_BASE),
> +				  NULL);
> +	omap2_set_globals_prm(AM33XX_L4_WK_IO_ADDRESS(AM43XX_PRCM_BASE));
> +	omap2_set_globals_cm(AM33XX_L4_WK_IO_ADDRESS(AM43XX_PRCM_BASE), NULL);
> +	omap3xxx_check_revision();
> +	am33xx_check_features();
> +}
> +#endif
> +
>  #ifdef CONFIG_ARCH_OMAP4
>  void __init omap4430_init_early(void)
>  {

I've updated this to remove am33xx_check_features() that we don't
seem to have in the mainline yet.

Tony
