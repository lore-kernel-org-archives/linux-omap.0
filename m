From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: Remove obsolete Makefile line
Date: Thu, 4 Jul 2013 04:47:45 -0700
Message-ID: <20130704114744.GD5523@atomide.com>
References: <1369912823.23034.46.camel@x61.thuisdomein>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1369912823.23034.46.camel@x61.thuisdomein>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Bolle <pebolle@tiscali.nl>
Cc: Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Paul Bolle <pebolle@tiscali.nl> [130530 04:26]:
> The OMAP runtime PM implementation was removed in v3.0. But one Makefile
> line, which was used to tweak CFLAGS, was overlooked. Remove it too.
> 
> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
> ---
> Untested. This cleans up after commit 638080c37a ("OMAP2+ / PM: move
> runtime PM implementation to use device power domains").

Thanks, applying into omap-for-v3.11/fixes.

Tony
 
>  arch/arm/mach-omap2/Makefile | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index 55a9d67..7279fa8 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -93,10 +93,6 @@ obj-$(CONFIG_POWER_AVS_OMAP_CLASS3)    += smartreflex-class3.o
>  AFLAGS_sleep24xx.o			:=-Wa,-march=armv6
>  AFLAGS_sleep34xx.o			:=-Wa,-march=armv7-a$(plus_sec)
>  
> -ifeq ($(CONFIG_PM_VERBOSE),y)
> -CFLAGS_pm_bus.o				+= -DDEBUG
> -endif
> -
>  endif
>  
>  ifeq ($(CONFIG_CPU_IDLE),y)
> -- 
> 1.7.11.7
> 
