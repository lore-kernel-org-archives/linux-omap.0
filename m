From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: omap2: hide omap3_save_secure_ram on non-OMAP3
 builds
Date: Wed, 6 Dec 2017 07:57:14 -0800
Message-ID: <20171206155714.GY28152@atomide.com>
References: <20171206141517.670032-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171206141517.670032-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Arnd Bergmann <arnd@arndb.de> [171206 14:18]:
> In configurations without CONFIG_OMAP3 but with secure RAM support,
> we now run into a link failure:
> 
> arch/arm/mach-omap2/omap-secure.o: In function `omap3_save_secure_ram':
> omap-secure.c:(.text+0x130): undefined reference to `save_secure_ram_context'
> 
> The omap3_save_secure_ram() function is only called from the OMAP34xx
> power management code, so we can simply hide that function in the
> appropriate #ifdef.
> 
> Fixes: d09220a887f7 ("ARM: OMAP2+: Fix SRAM virt to phys translation for save_secure_ram_context")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for fixing it, want to apply directly to ARM SoC fixes
where d09220a887f7 is now? If so:

Acked-by: Tony Lindgren <tony@atomide.com>

Regards,

Tony


> ---
>  arch/arm/mach-omap2/omap-secure.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/mach-omap2/omap-secure.c b/arch/arm/mach-omap2/omap-secure.c
> index f9303dc631e4..7be95cd8136d 100644
> --- a/arch/arm/mach-omap2/omap-secure.c
> +++ b/arch/arm/mach-omap2/omap-secure.c
> @@ -72,6 +72,7 @@ phys_addr_t omap_secure_ram_mempool_base(void)
>  	return omap_secure_memblock_base;
>  }
>  
> +#ifdef CONFIG_ARCH_OMAP3
>  u32 omap3_save_secure_ram(void __iomem *addr, int size)
>  {
>  	u32 ret;
> @@ -90,6 +91,7 @@ u32 omap3_save_secure_ram(void __iomem *addr, int size)
>  
>  	return ret;
>  }
> +#endif
>  
>  /**
>   * rx51_secure_dispatcher: Routine to dispatch secure PPA API calls
> -- 
> 2.9.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
