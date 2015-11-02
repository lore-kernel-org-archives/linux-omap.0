From: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] spi: ti-qspi: improve ->remove() callback
Date: Mon, 2 Nov 2015 16:52:40 +0200
Message-ID: <563778B8.9060109@ti.com>
References: <1446127050-5957-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1446127050-5957-1-git-send-email-balbi-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 10/29/2015 03:57 PM, Felipe Balbi wrote:
> there's no need to call pm_runtime_get_sync()
> followed by pm_runtime_put(). We should, instead,
> just call pm_runtime_put_sync() and pm_runtime_disable().

Sry, but why do we need to call pm_runtime_put[_sync]() here?

My be just pm_runtime_disable() will be ok?


>
> Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
> ---
>   drivers/spi/spi-ti-qspi.c | 11 +----------
>   1 file changed, 1 insertion(+), 10 deletions(-)
>
> diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
> index 69c1a95b0615..64318fcfacf2 100644
> --- a/drivers/spi/spi-ti-qspi.c
> +++ b/drivers/spi/spi-ti-qspi.c
> @@ -554,16 +554,7 @@ free_master:
>
>   static int ti_qspi_remove(struct platform_device *pdev)
>   {
> -	struct ti_qspi *qspi = platform_get_drvdata(pdev);
> -	int ret;
> -
> -	ret = pm_runtime_get_sync(qspi->dev);
> -	if (ret < 0) {
> -		dev_err(qspi->dev, "pm_runtime_get_sync() failed\n");
> -		return ret;
> -	}
> -
> -	pm_runtime_put(qspi->dev);
> +	pm_runtime_put_sync(&pdev->dev);
>   	pm_runtime_disable(&pdev->dev);
>
>   	return 0;
>


-- 
regards,
-grygorii
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
