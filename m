From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2 3/7] dmaengine: Add driver for TI DMA crossbar on DRA7x
Date: Thu, 26 Mar 2015 08:22:04 -0700
Message-ID: <20150326152204.GF31346@atomide.com>
References: <1426080210-841-1-git-send-email-peter.ujfalusi@ti.com>
 <1426080210-841-4-git-send-email-peter.ujfalusi@ti.com>
 <20150326105603.GK32683@intel.com>
 <5513FC22.2030304@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5513FC22.2030304-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Cc: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, nm-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org> [150326 05:32]:
> On 03/26/2015 12:56 PM, Vinod Koul wrote:
> >> +
> >> +static void ti_dma_xbar_free(struct device *dev, void *route_data)
> >> +{
> >> +	struct ti_dma_xbar_data *xbar = dev_get_drvdata(dev);
> >> +	struct ti_dma_xbar_map *map = route_data;
> >> +
> >> +	dev_dbg(dev, "Unmapping XBAR%d (was routed to %d)\n",
> >> +		map->xbar_in, map->xbar_out);
> >> +
> >> +	regmap_write(xbar->regmap, map->xbar_out * 2, 0);
> > just out of curiosity how much do you save using regmap :)
> 
> good point, not much I guess. I had it implemented w/o regmap as well, but
> thought why not use regmap if it is available.

Regmap is nice for slow devices and devices in a shared register
range like the omap syscon general area. For normal use, there's
quite a bit of overhead with regmap compared to just read/write :)

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
