From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: Remove double omap_uwire entry in spi
	Makefile
Date: Tue, 6 Mar 2007 02:44:44 -0800
Message-ID: <20070306104442.GE24639@atomide.com>
References: <45EC6CAA.9050208@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <45EC6CAA.9050208@googlemail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Dirk Behme <dirk.behme@googlemail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Dirk Behme <dirk.behme@googlemail.com> [070305 11:22]:
> 
> [PATCH] ARM: OMAP: Remove double omap_uwire entry in
> drivers/spi/Makefile.
> 
> Signed-off-by: Dirk Behme <dirk.behme@gmail.com>
> 

> Index: linux-osk/drivers/spi/Makefile
> ===================================================================
> --- linux-osk.orig/drivers/spi/Makefile
> +++ linux-osk/drivers/spi/Makefile
> @@ -16,7 +16,6 @@ obj-$(CONFIG_SPI_ATMEL)			+= atmel_spi.o
>  obj-$(CONFIG_SPI_BUTTERFLY)		+= spi_butterfly.o
>  obj-$(CONFIG_SPI_IMX)			+= spi_imx.o
>  obj-$(CONFIG_SPI_PXA2XX)		+= pxa2xx_spi.o
> -obj-$(CONFIG_SPI_OMAP_UWIRE)		+= omap_uwire.o
>  obj-$(CONFIG_SPI_MPC83xx)		+= spi_mpc83xx.o
>  obj-$(CONFIG_SPI_S3C24XX_GPIO)		+= spi_s3c24xx_gpio.o
>  obj-$(CONFIG_SPI_S3C24XX)		+= spi_s3c24xx.o
> 

Pushing today.

Looks like the automerge again while merging from omap-drivers to master
branch :) These problems should disappear eventually once the code
more in sync again with Linus' tree.

Regards,

Tony
