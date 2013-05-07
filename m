From: "Hebbar, Gururaja" <gururaja.hebbar-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH] spi/omap2: Let device core handle pinctrl
Date: Tue, 7 May 2013 03:56:09 +0000
Message-ID: <1BAFE6F6C881BF42822005164F1491C33EBE473A@DBDE04.ent.ti.com>
References: <1367868998-12667-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1367868998-12667-1-git-send-email-broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org" <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Tue, May 07, 2013 at 01:06:38, Mark Brown wrote:
> Since commit ab78029 (drivers/pinctrl: grab default handles from device
> core) we can rely on device core for handling pinctrl so remove
> devm_pinctrl_get_select_default() from the driver.

NACK.

There are cases where driver('s) needs to place pin-mux's to sleep on suspend
& default/idle on resume. For such cases Pinctrl needs to be handled inside 
the driver. Example [1].

I will be submitting a patch to enhance the existing pinctrl support for 
spi omap2 shortly which does above work.

Regards
Gururaja


[1]
http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/spi/spi-pl022.c

pl022_suspend_resources() & pl022_resume_resources()


> 
> Signed-off-by: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
> ---
>  drivers/spi/spi-omap2-mcspi.c |    7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
> index 893c3d7..3777bd5 100644
> --- a/drivers/spi/spi-omap2-mcspi.c
> +++ b/drivers/spi/spi-omap2-mcspi.c
> @@ -38,7 +38,6 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> -#include <linux/pinctrl/consumer.h>
>  
>  #include <linux/spi/spi.h>
>  
> @@ -1170,7 +1169,6 @@ static int omap2_mcspi_probe(struct platform_device *pdev)
>  	static int		bus_num = 1;
>  	struct device_node	*node = pdev->dev.of_node;
>  	const struct of_device_id *match;
> -	struct pinctrl *pinctrl;
>  
>  	master = spi_alloc_master(&pdev->dev, sizeof *mcspi);
>  	if (master == NULL) {
> @@ -1268,11 +1266,6 @@ static int omap2_mcspi_probe(struct platform_device *pdev)
>  	if (status < 0)
>  		goto dma_chnl_free;
>  
> -	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
> -	if (IS_ERR(pinctrl))
> -		dev_warn(&pdev->dev,
> -				"pins are not configured from the driver\n");
> -
>  	pm_runtime_use_autosuspend(&pdev->dev);
>  	pm_runtime_set_autosuspend_delay(&pdev->dev, SPI_AUTOSUSPEND_TIMEOUT);
>  	pm_runtime_enable(&pdev->dev);
> -- 
> 1.7.10.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


Regards, 
Gururaja

------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and 
their applications. This 200-page book is written by three acclaimed 
leaders in the field. The early access version is available now. 
Download your free book today! http://p.sf.net/sfu/neotech_d2d_may
