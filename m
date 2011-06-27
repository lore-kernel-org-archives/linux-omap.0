From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Use MMIO clocksource for 32kHz counter
Date: Mon, 27 Jun 2011 05:37:55 -0700
Message-ID: <20110627123754.GQ23145@atomide.com>
References: <20110627123315.GB1777@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20110627123315.GB1777@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Kevin Hilman <khilman@ti.com>, Thomas Gleixner <tglx@linutronix.de>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [110627 05:28]:
> --- a/arch/arm/plat-omap/counter_32k.c
> +++ b/arch/arm/plat-omap/counter_32k.c
> +#ifdef CONFIG_ARCH_OMAP16XX
> +		else if (cpu_is_omap16xx())
> +			base = OMAP2_L4_IO_ADDRESS(OMAP16XX_TIMER_32K_SYNCHRONIZED);
> +#endif
> +#ifdef CONFIG_SOC_OMAP2420
>  		else if (cpu_is_omap2420())
> -			clocksource_32k.read = omap2420_32k_read;
> +			base = OMAP2_L4_IO_ADDRESS(OMAP2420_32KSYNCT_BASE + 0x10);
> +#endif
> +#ifdef CONFIG_SOC_OMAP2430
>  		else if (cpu_is_omap2430())
> -			clocksource_32k.read = omap2430_32k_read;
> +			base = OMAP2_L4_IO_ADDRESS(OMAP2430_32KSYNCT_BASE + 0x10);
> +#endif
> +#ifdef CONFIG_ARCH_OMAP3
>  		else if (cpu_is_omap34xx())
> -			clocksource_32k.read = omap34xx_32k_read;
> +			base = OMAP2_L4_IO_ADDRESS(OMAP3430_32KSYNCT_BASE + 0x10);
> +#endif
> +#ifdef CONFIG_ARCH_OMAP4
>  		else if (cpu_is_omap44xx())
> -			clocksource_32k.read = omap44xx_32k_read;
> +			base = OMAP2_L4_IO_ADDRESS(OMAP4430_32KSYNCT_BASE + 0x10);
> +#endif
>  		else
>  			return -ENODEV;
>  

You should be able to replace the above with just ioremap as we now
have the static mappings.

Tony
