From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC] [PATCH] MMC OMAP: add OMAP_GPIO_SWITCH dependency for N800
Date: Mon, 1 Oct 2007 10:37:06 -0700
Message-ID: <20071001173706.GJ24656@atomide.com>
References: <46F007D9.6060603@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <46F007D9.6060603@indt.org.br>
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

* Anderson Briglia <anderson.briglia@indt.org.br> [070918 10:12]:
> OMAP_GPIO_SWITCH is needed by MMC host on N800. If this option is
> not selected, compilation fails.
> 
> Signed-off-by: Anderson Briglia <anderson.briglia@indt.org.br>
> ---
>  drivers/mmc/host/Kconfig |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index e23082f..671b9a4 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -39,6 +39,7 @@ config MMC_OMAP
>  	tristate "TI OMAP Multimedia Card Interface support"
>  	depends on ARCH_OMAP
>  	select TPS65010 if MACH_OMAP_H2
> +	select OMAP_GPIO_SWITCH if MACH_NOKIA_N800
>  	help
>  	  This selects the TI OMAP Multimedia card Interface.
>  	  If you have an OMAP board with a Multimedia Card slot,

Pushing today.

Tony
