From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 04/17] phy: omap-usb2: use omap_usb_power_off to power
 off the PHY during probe
Date: Wed, 24 Jun 2015 13:58:09 +0300
Message-ID: <20150624135809.ccf19caf000c0213dd9ff45c@ti.com>
References: <1435060743-5511-1-git-send-email-kishon@ti.com>
	<1435060743-5511-5-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1435060743-5511-5-git-send-email-kishon-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Cc: bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tue, 23 Jun 2015 17:28:49 +0530
Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org> wrote:

> No functional change. Previously omap_control_phy_power() was used to power
> off the PHY during probe. But once phy-omap-usb2 driver is adapted to
> use syscon, omap_control_phy_power() cannot be used. Hence used
> omap_usb_power_off to power off the PHY.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>

Acked-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>

cheers,
-roger

> ---
>  drivers/phy/phy-omap-usb2.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/phy/phy-omap-usb2.c b/drivers/phy/phy-omap-usb2.c
> index c1a4686..b5c266a 100644
> --- a/drivers/phy/phy-omap-usb2.c
> +++ b/drivers/phy/phy-omap-usb2.c
> @@ -241,7 +241,6 @@ static int omap_usb2_probe(struct platform_device *pdev)
>  	}
>  
>  	phy->control_dev = &control_pdev->dev;
> -	omap_control_phy_power(phy->control_dev, 0);
>  
>  	otg->set_host		= omap_usb_set_host;
>  	otg->set_peripheral	= omap_usb_set_peripheral;
> @@ -261,6 +260,7 @@ static int omap_usb2_probe(struct platform_device *pdev)
>  	}
>  
>  	phy_set_drvdata(generic_phy, phy);
> +	omap_usb_power_off(generic_phy);
>  
>  	phy_provider = devm_of_phy_provider_register(phy->dev,
>  			of_phy_simple_xlate);
> -- 
> 1.7.9.5
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
