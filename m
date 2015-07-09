From: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 3/3] i2c: omap: on ->remove() call pm_runtime_put_sync()
Date: Thu, 9 Jul 2015 12:18:26 +0200
Message-ID: <559E4A72.9070504@nokia.com>
References: <1435260890-32335-1-git-send-email-balbi@ti.com>
 <1435260890-32335-3-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1435260890-32335-3-git-send-email-balbi-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ext Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Linux ARM Kernel Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi!

On 25/06/15 21:34, ext Felipe Balbi wrote:
> we're about to remove the module, so we can't
> really schedule a PM transition in the future,
> we must wait for it to finish.
> 
> Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>

Reviewed-by: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>

> ---
>  drivers/i2c/busses/i2c-omap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 828d5caccfcb..b57d84e01562 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -1395,7 +1395,7 @@ static int omap_i2c_remove(struct platform_device *pdev)
>  		return ret;
>  
>  	omap_i2c_write_reg(omap, OMAP_I2C_CON_REG, 0);
> -	pm_runtime_put(&pdev->dev);
> +	pm_runtime_put_sync(&pdev->dev);
>  	pm_runtime_disable(&pdev->dev);
>  	return 0;
>  }
