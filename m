From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP: Add OMAP_GPIO_SWITCH dependency for N800
Date: Mon, 22 Oct 2007 17:39:34 -0700
Message-ID: <20071023003934.GH17318@atomide.com>
References: <471CCB92.3040801@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <471CCB92.3040801@indt.org.br>
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

* Anderson Briglia <anderson.briglia@indt.org.br> [071022 09:13]:
> GPIO switch is needed for N800 initialization. It must be
> selected when compiling for this device.
> 
> Signed-off-by: Anderson Briglia <anderson.briglia@indt.org.br>
> ---
>  arch/arm/mach-omap2/Kconfig |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index 51fc13a..9323bd0 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -37,6 +37,7 @@ config MACH_NOKIA_N800
>  	select CBUS if VIDEO_TCM825X
>  	select CBUS_RETU if VIDEO_TCM825X
>  	select MENELAUS if VIDEO_TCM825X
> +	select OMAP_GPIO_SWITCH
> 
>  config MACH_OMAP2_TUSB6010
>  	bool

Pushing today.

Tony
