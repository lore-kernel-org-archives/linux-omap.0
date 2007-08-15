From: Tony Lindgren <tony@atomide.com>
Subject: Re: [patch 2.6.23-rc2-omap1] mcspi can be modular...
Date: Wed, 15 Aug 2007 03:55:15 -0700
Message-ID: <20070815105515.GK19754@atomide.com>
References: <200708132249.12045.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <200708132249.12045.david-b@pacbell.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [070813 23:12]:
> Don't assume only non-modular builds.  Just in case someone's crazy.
> 
> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> 
> --- h4.orig/arch/arm/mach-omap2/devices.c	2007-08-13 12:31:32.000000000 -0700
> +++ h4/arch/arm/mach-omap2/devices.c	2007-08-13 12:32:12.000000000 -0700
> @@ -146,7 +146,7 @@ static inline void omap_init_sti(void)
>  static inline void omap_init_sti(void) {}
>  #endif
>  
> -#if defined(CONFIG_SPI_OMAP24XX)
> +#if defined(CONFIG_SPI_OMAP24XX) || defined(CONFIG_SPI_OMAP24XX_MODULE)
>  
>  #include <asm/arch/mcspi.h>

Pushing today.

Tony
