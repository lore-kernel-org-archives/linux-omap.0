From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [PATCH v3] usb: ehci-omap: don't complain on -EPROBE_DEFER when
 no PHY found
Date: Thu, 18 Jan 2018 10:18:41 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1801181016540.1733-100000@iolanthe.rowland.org>
References: <20180118080453.GA2205@lenoch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20180118080453.GA2205@lenoch>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Thu, 18 Jan 2018, Ladislav Michl wrote:

> Don't complain on -EPROBE_DEFER when no PHY found, the driver
> probe will be retried later.
> 
> Signed-off-by: Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
> Acked-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> Acked-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
> ---
>  Changes:
>  - v2: None, just added Tony's ack
>  - v3: Fixed commit message typo spotted by Jaejoong Kim, added Roger's ack

Although there's nothing wrong with making this change, people don't 
like to see character strings broken up just to avoid long lines.  Can 
you redo the patch without breaking the error message string?

Alan Stern

>  drivers/usb/host/ehci-omap.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
> index 854b146a457d..fd6170962a1a 100644
> --- a/drivers/usb/host/ehci-omap.c
> +++ b/drivers/usb/host/ehci-omap.c
> @@ -167,8 +167,9 @@ static int ehci_hcd_omap_probe(struct platform_device *pdev)
>  				continue;
>  
>  			ret = PTR_ERR(phy);
> -			dev_err(dev, "Can't get PHY device for port %d: %d\n",
> -					i, ret);
> +			if (ret != -EPROBE_DEFER)
> +				dev_err(dev, "Can't get PHY device for port "
> +					"%d: %d\n", i, ret);
>  			goto err_phy;
>  		}

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
