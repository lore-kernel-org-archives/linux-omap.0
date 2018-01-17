From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2] usb: ehci-omap: don't complain on -EPROBE_DEFER when
 no PHY found
Date: Wed, 17 Jan 2018 15:41:57 +0200
Message-ID: <0eb30b03-e748-5727-a8bd-71483e951ee8@ti.com>
References: <20180117100819.GA4017@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20180117100819.GA4017@lenoch>
Content-Language: en-GB
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 17/01/18 12:08, Ladislav Michl wrote:
> Don't complain on -EPROBE_DEFER when when no PHY found, the driver
> probe will be retried later.
> 
> Signed-off-by: Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
> Acked-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>

Acked-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>

> ---
>  Changes:
>  - v2: None, just added Tony's ack
> 
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
>  
> 

-- 
cheers,
-roger

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
