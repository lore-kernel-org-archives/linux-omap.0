From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: RE: [PATCH] i2c: omap: switch over to autosuspend API
Date: Tue, 7 Aug 2012 12:34:28 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D121433EB3087D@DBDE01.ent.ti.com>
References: <20120807120728.GW8468@arwen.pp.htv.fi>
 <1344341468-8144-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49940 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754152Ab2HGMep convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Aug 2012 08:34:45 -0400
In-Reply-To: <1344341468-8144-1-git-send-email-balbi@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Balbi, Felipe" <balbi@ti.com>, "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, "w.sang@pengutronix.de" <w.sang@pengutronix.de>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

On Tue, Aug 07, 2012 at 17:41:08, Balbi, Felipe wrote:
> this helps us reduce unnecessary pm transitions
> in case we have another i2c message been started
> soon.
>

s/been started/starting ?
 
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>  drivers/i2c/busses/i2c-omap.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 60928f2..c210b45 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -645,7 +645,8 @@ omap_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
>  
>  	omap_i2c_wait_for_bb(dev);
>  out:
> -	pm_runtime_put(dev->dev);
> +	pm_runtime_mark_last_busy(dev->dev);
> +	pm_runtime_put_autosuspend(dev->dev);
>  	return r;
>  }
>  
> @@ -1113,6 +1114,9 @@ omap_i2c_probe(struct platform_device *pdev)
>  		dev->regs = (u8 *)reg_map_ip_v1;
>  
>  	pm_runtime_enable(dev->dev);
> +	pm_runtime_set_autosuspend_delay(dev->dev, 1000);

I guess there will always be a debate around what's the right
delay for autosuspend ;)

You can at least replace the magic number with a macro.

> +	pm_runtime_use_autosuspend(dev->dev);
> +
>  	r = pm_runtime_get_sync(dev->dev);
>  	if (IS_ERR_VALUE(r))
>  		goto err_free_mem;
> @@ -1189,7 +1193,8 @@ omap_i2c_probe(struct platform_device *pdev)
>  
>  	of_i2c_register_devices(adap);
>  
> -	pm_runtime_put(dev->dev);
> +	pm_runtime_mark_last_busy(dev->dev);
> +	pm_runtime_put_autosuspend(dev->dev);
>  
>  	return 0;
>  
> -- 
> 1.7.12.rc0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

