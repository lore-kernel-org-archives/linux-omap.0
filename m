From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH 05/20] mfd: atmel-hlcdc: Use devm_mfd_add_devices() for
 mfd_device registration
Date: Tue, 5 Apr 2016 19:09:42 +0200
Message-ID: <20160405190942.66cbb368@bbrezillon>
References: <1459856912-17859-1-git-send-email-ldewangan@nvidia.com>
	<1459856912-17859-6-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1459856912-17859-6-git-send-email-ldewangan@nvidia.com>
Sender: linux-doc-owner@vger.kernel.org
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: lee.jones@linaro.org, corbet@lwn.net, andreas.werner@men.de, tony@atomide.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, patches@opensource.wolfsonmicro.com
List-Id: linux-omap@vger.kernel.org

On Tue, 5 Apr 2016 17:18:17 +0530
Laxman Dewangan <ldewangan@nvidia.com> wrote:

> Use devm_mfd_add_devices() for mfd devices registration and get
> rid of .remove callback to remove mfd devices. This is done
> by managed device framework.
> 
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> CC: Boris Brezillon <boris.brezillon@free-electrons.com>

Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>

> ---
>  drivers/mfd/atmel-hlcdc.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/drivers/mfd/atmel-hlcdc.c b/drivers/mfd/atmel-hlcdc.c
> index 06c2058..653bf261 100644
> --- a/drivers/mfd/atmel-hlcdc.c
> +++ b/drivers/mfd/atmel-hlcdc.c
> @@ -128,18 +128,11 @@ static int atmel_hlcdc_probe(struct platform_device *pdev)
>  
>  	dev_set_drvdata(dev, hlcdc);
>  
> -	return mfd_add_devices(dev, -1, atmel_hlcdc_cells,
> +	return devm_mfd_add_devices(dev, -1, atmel_hlcdc_cells,
>  			       ARRAY_SIZE(atmel_hlcdc_cells),
>  			       NULL, 0, NULL);
>  }
>  
> -static int atmel_hlcdc_remove(struct platform_device *pdev)
> -{
> -	mfd_remove_devices(&pdev->dev);
> -
> -	return 0;
> -}
> -
>  static const struct of_device_id atmel_hlcdc_match[] = {
>  	{ .compatible = "atmel,at91sam9n12-hlcdc" },
>  	{ .compatible = "atmel,at91sam9x5-hlcdc" },
> @@ -152,7 +145,6 @@ MODULE_DEVICE_TABLE(of, atmel_hlcdc_match);
>  
>  static struct platform_driver atmel_hlcdc_driver = {
>  	.probe = atmel_hlcdc_probe,
> -	.remove = atmel_hlcdc_remove,
>  	.driver = {
>  		.name = "atmel-hlcdc",
>  		.of_match_table = atmel_hlcdc_match,



-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
