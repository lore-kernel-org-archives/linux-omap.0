From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: OMAP_GPIO_SWITCH doesn't need OMAP_BOOT_TAG
Date: Fri, 26 May 2006 16:17:18 -0700
Message-ID: <20060526231718.GO4132@atomide.com>
References: <20060517172547.GA3778@earth.li> <20060518091843.GN7570@earth.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20060518091843.GN7570@earth.li>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Jonathan McDowell <noodles@earth.li>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Jonathan McDowell <noodles@earth.li> [060518 02:19]:
> On Wed, May 17, 2006 at 06:25:47PM +0100, Jonathan McDowell wrote:
> > I can't see any reason why OMAP_GPIO_SWITCH depends on OMAP_BOOT_TAG;
> > it compiles fine without it. This patch removes the Kconfig dependency.
> 
> Here's an updated patch that not only removes the dependency but cleans
> up the Kconfig description to talk about sysfs rather than the input
> layer.
> 
> Signed-off-by: Jonathan McDowell <noodles@earth.li>
> 
> -----
> diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
> index 28ca5ad..cc8c793 100644
> --- a/arch/arm/plat-omap/Kconfig
> +++ b/arch/arm/plat-omap/Kconfig
> @@ -57,13 +57,12 @@ config OMAP_COMPONENT_VERSION
>  
>  config OMAP_GPIO_SWITCH
>  	bool "GPIO switch support"
> -        depends on OMAP_BOOT_TAG
>          default n
>          help
> -          Say Y, if you want to have support for input layer reporting
> -          of GPIO switches (e.g. cover switches). Your bootloader has to
> -          provide information about the switches to the kernel via the
> -          ATAG_BOARD mechanism.
> +          Say Y, if you want to have support for reporting of GPIO
> +          switches (e.g. cover switches) via sysfs. Your bootloader has
> +          to provide information about the switches to the kernel via the
> +          ATAG_BOARD mechanism if they're not defined by the board config.
>  
>  config OMAP_MUX
>  	bool "OMAP multiplexing support"

Pushing today. This allows us also to integrate the gpio switch into the
mainline kernel.

Tony
