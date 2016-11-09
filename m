From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] usb: musb: don't complain on -EPROBE_DEFER when
 initializing controller
Date: Wed, 9 Nov 2016 10:48:10 -0700
Message-ID: <20161109174809.GW2428@atomide.com>
References: <20161109140804.GD20859@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161109140804.GD20859-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
Cc: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org> [161109 07:08]:
> Don't complain on -EPROBE_DEFER when initializing controller,
> the driver probe will be retried later.
> 
> Signed-off-by: Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>

Acked-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>

> ---
>  drivers/usb/musb/musb_core.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
> index 27dadc0..77fd97b 100644
> --- a/drivers/usb/musb/musb_core.c
> +++ b/drivers/usb/musb/musb_core.c
> @@ -2329,8 +2329,9 @@ musb_init_controller(struct device *dev, int nIrq, void __iomem *ctrl)
>  	musb_platform_exit(musb);
>  
>  fail1:
> -	dev_err(musb->controller,
> -		"musb_init_controller failed with status %d\n", status);
> +	if (status != -EPROBE_DEFER)
> +		dev_err(musb->controller,
> +			"%s failed with status %d\n", __func__, status);
>  
>  	musb_free(musb);
>  
> -- 
> 2.1.4
> 
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
