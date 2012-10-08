From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] ARM: OMAP: Fix dependency for OMAP_DEBUG_LEDS
Date: Mon, 8 Oct 2012 14:59:51 -0700
Message-ID: <20121008215950.GV13011@atomide.com>
References: <1349604805.6017.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1349604805.6017.1.camel@phoenix>
Sender: linux-kernel-owner@vger.kernel.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Bryan Wu <bryan.wu@canonical.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Axel Lin <axel.lin@ingics.com> [121007 03:14]:
> This fixes below build error when CONFIG_LEDS_CLASS is not set.
> 
>   LD      init/built-in.o
> arch/arm/plat-omap/built-in.o: In function `fpga_probe':
> arch/arm/plat-omap/debug-leds.c:113: undefined reference to `led_classdev_register'
> arch/arm/plat-omap/debug-leds.c:113: undefined reference to `led_classdev_register'
> arch/arm/plat-omap/debug-leds.c:113: undefined reference to `led_classdev_register'
> arch/arm/plat-omap/debug-leds.c:113: undefined reference to `led_classdev_register'
> arch/arm/plat-omap/debug-leds.c:113: undefined reference to `led_classdev_register'
> arch/arm/plat-omap/built-in.o:arch/arm/plat-omap/debug-leds.c:113: more undefined references to `led_classdev_register' follow
> make: *** [vmlinux] Error 1
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

Thanks looks like I have already an earlier version of the same
patch from you already queued.

Regards,

Tony

> ---
>  arch/arm/plat-omap/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
> index ca83a76..c262781 100644
> --- a/arch/arm/plat-omap/Kconfig
> +++ b/arch/arm/plat-omap/Kconfig
> @@ -43,6 +43,7 @@ config OMAP_DEBUG_DEVICES
>  
>  config OMAP_DEBUG_LEDS
>  	def_bool y if NEW_LEDS
> +	select LEDS_CLASS
>  	depends on OMAP_DEBUG_DEVICES
>  
>  config POWER_AVS_OMAP
> -- 
> 1.7.9.5
> 
> 
> 
