From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] usb: musb: omap2430: use dev_err
Date: Wed, 9 Nov 2016 10:48:25 -0700
Message-ID: <20161109174825.GX2428@atomide.com>
References: <20161109140914.GE20859@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161109140914.GE20859-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
Cc: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org> [161109 07:09]:
> Replace pr_err with dev_err to print also device name.
> 
> Signed-off-by: Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>

Acked-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>

> ---
>  drivers/usb/musb/omap2430.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
> index cc12254..451b372 100644
> --- a/drivers/usb/musb/omap2430.c
> +++ b/drivers/usb/musb/omap2430.c
> @@ -277,12 +277,12 @@ static int omap2430_musb_init(struct musb *musb)
>  		if (status == -ENXIO)
>  			return status;
>  
> -		pr_err("HS USB OTG: no transceiver configured\n");
> +		dev_err(dev, "HS USB OTG: no transceiver configured\n");
>  		return -EPROBE_DEFER;
>  	}
>  
>  	if (IS_ERR(musb->phy)) {
> -		pr_err("HS USB OTG: no PHY configured\n");
> +		dev_err(dev, "HS USB OTG: no PHY configured\n");
>  		return PTR_ERR(musb->phy);
>  	}
>  	musb->isr = omap2430_musb_interrupt;
> @@ -301,7 +301,7 @@ static int omap2430_musb_init(struct musb *musb)
>  
>  	musb_writel(musb->mregs, OTG_INTERFSEL, l);
>  
> -	pr_debug("HS USB OTG: revision 0x%x, sysconfig 0x%02x, "
> +	dev_dbg(dev, "HS USB OTG: revision 0x%x, sysconfig 0x%02x, "
>  			"sysstatus 0x%x, intrfsel 0x%x, simenable  0x%x\n",
>  			musb_readl(musb->mregs, OTG_REVISION),
>  			musb_readl(musb->mregs, OTG_SYSCONFIG),
> -- 
> 2.1.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
