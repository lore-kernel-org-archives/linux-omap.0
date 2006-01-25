From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] i2c: Fix bogus endmenu reference for GPIOEXPANDER_OMAP.
Date: Tue, 24 Jan 2006 20:07:34 -0800
Message-ID: <20060125040734.GF4966@atomide.com>
References: <20060123141600.GC25124@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20060123141600.GC25124@nokia.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Paul Mundt <paul.mundt@nokia.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Paul Mundt <paul.mundt@nokia.com> [060123 06:16]:
> Signed-off-by: Paul Mundt <paul.mundt@nokia.com>
> 
> ---
> 
>  drivers/i2c/chips/Kconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> 180618404fb979f540dc98344b7914747b94ec22
> diff --git a/drivers/i2c/chips/Kconfig b/drivers/i2c/chips/Kconfig
> index abc8d29..946cc21 100644
> --- a/drivers/i2c/chips/Kconfig
> +++ b/drivers/i2c/chips/Kconfig
> @@ -114,7 +114,7 @@ config GPIOEXPANDER_OMAP
>  	depends on I2C && (ARCH_OMAP16XX || ARCH_OMAP24XX)
>  	help
>  	  If you say yes here you get support for I/O expander calls
> -	  to configure IrDA, Camera and audio devices endmenu
> +	  to configure IrDA, Camera and audio devices.
>  
>  config MENELAUS
>  	bool "Menelaus PM chip"

Pushed, thanks.

Tony
