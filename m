From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [PATCH 2/4] usb: host: ohci-platform: Add support for omap3 and
 later
Date: Thu, 18 May 2017 11:38:03 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1705181137310.1619-100000@iolanthe.rowland.org>
References: <20170517225922.17723-3-tony@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170517225922.17723-3-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wed, 17 May 2017, Tony Lindgren wrote:

> With the runtime PM implemented for ohci-platform driver, we can
> now support omap3 and later OHCI by adding one device tree
> property.
> 
> Cc: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Cc: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
> Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
> Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/usb/usb-ohci.txt | 1 +
>  drivers/usb/host/ohci-platform.c                   | 5 +++++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/usb-ohci.txt b/Documentation/devicetree/bindings/usb/usb-ohci.txt
> --- a/Documentation/devicetree/bindings/usb/usb-ohci.txt
> +++ b/Documentation/devicetree/bindings/usb/usb-ohci.txt
> @@ -10,6 +10,7 @@ Optional properties:
>  - big-endian-desc : boolean, set this for hcds with big-endian descriptors
>  - big-endian : boolean, for hcds with big-endian-regs + big-endian-desc
>  - no-big-frame-no : boolean, set if frame_no lives in bits [15:0] of HCCA
> +- remote-wakeup-connected: remote wakeup is wired on the platform
>  - num-ports : u32, to override the detected port count
>  - clocks : a list of phandle + clock specifier pairs
>  - phys : phandle + phy specifier pair
> diff --git a/drivers/usb/host/ohci-platform.c b/drivers/usb/host/ohci-platform.c
> --- a/drivers/usb/host/ohci-platform.c
> +++ b/drivers/usb/host/ohci-platform.c
> @@ -170,6 +170,10 @@ static int ohci_platform_probe(struct platform_device *dev)
>  		if (of_property_read_bool(dev->dev.of_node, "no-big-frame-no"))
>  			ohci->flags |= OHCI_QUIRK_FRAME_NO;
>  
> +		if (of_property_read_bool(dev->dev.of_node,
> +					  "remote-wakeup-connected"))
> +			ohci->hc_control = OHCI_CTRL_RWC;
> +
>  		of_property_read_u32(dev->dev.of_node, "num-ports",
>  				     &ohci->num_ports);
>  
> @@ -361,6 +365,7 @@ static int ohci_platform_resume(struct device *dev)
>  static const struct of_device_id ohci_platform_ids[] = {
>  	{ .compatible = "generic-ohci", },
>  	{ .compatible = "cavium,octeon-6335-ohci", },
> +	{ .compatible = "ti,ohci-omap3", },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, ohci_platform_ids);

Acked-by: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
