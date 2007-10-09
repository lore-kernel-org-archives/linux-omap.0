From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] MMC: OMAP: Add OMAP_GPIO_SWITCH dependency for TUSB6010
Date: Tue, 9 Oct 2007 15:25:18 -0700
Message-ID: <20071009222518.GG4151@atomide.com>
References: <470556AB.6030201@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <470556AB.6030201@indt.org.br>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Anderson Briglia <anderson.briglia@indt.org.br>
Cc: "Linux-omap-open-source@linux.omap.com" <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi,

* Anderson Briglia <anderson.briglia@indt.org.br> [071004 14:13]:
> GPIO switch is needed for TUSB6010 code. It must be
> selected when TUSB6010 is marked.
> 
> Signed-off-by: Anderson Briglia <anderson.briglia@indt.org.br>
> ---
>  arch/arm/mach-omap2/Kconfig |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index 0d9f496..dcb4824 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -41,6 +41,7 @@ config MACH_NOKIA_N800
>  config MACH_OMAP2_TUSB6010
>  	bool
>  	depends on ARCH_OMAP2 && ARCH_OMAP2420
> +	select OMAP_GPIO_SWITCH
>  	default y if MACH_NOKIA_N800
> 
>  config MACH_OMAP_H4

This does not look right to me. Where is gpio_sw used for tusb6010?

AFAIK, it's used for bat_cover, headphone, cam_act and cam_turn.
But not for tusb6010. Can you please check?

Regards,

Tony
