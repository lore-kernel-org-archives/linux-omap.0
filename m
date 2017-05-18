From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [PATCH 1/4] usb: host: ohci-platform: Add basic runtime PM
 support
Date: Thu, 18 May 2017 13:21:28 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1705181313320.1619-100000@iolanthe.rowland.org>
References: <20170517225922.17723-2-tony@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170517225922.17723-2-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wed, 17 May 2017, Tony Lindgren wrote:

> This is needed in preparation of adding support for omap3 and
> later OHCI. The runtime PM will only do something on platforms
> that implement it.

> @@ -51,6 +52,10 @@ static int ohci_platform_power_on(struct platform_device *dev)
>  	struct ohci_platform_priv *priv = hcd_to_ohci_priv(hcd);
>  	int clk, ret, phy_num;
>  
> +	ret = pm_runtime_get_sync(&dev->dev);
> +	if (ret < 0)
> +		return ret;
> +

I don't remember how probing for platform device drivers is set up.    
So although this is definitely the wrong place for 
pm_runtime_get_sync(), it may turn out that you need to do a 
pm_runtime_get_noresume() before calling pm_runtime_enable(), and a 
pm_runtime_put() at the end of ohci_platform_probe().  Otherwise 
runtime PM might kick in during the middle of the probe sequence -- not 
what you want.

Similarly, you may need pm_runtime_get_sync() at the start of 
ohci_platform_remove() and pm_runtime_put_noidle() at the end.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
