From: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 10/13] dmaengine: ti-dma-crossbar: Add support for
 crossbar on AM33xx/AM43xx
Date: Wed, 14 Oct 2015 20:18:14 +0530
Message-ID: <20151014144814.GW27370@localhost>
References: <1444828344-21378-1-git-send-email-peter.ujfalusi@ti.com>
 <1444828344-21378-11-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1444828344-21378-11-git-send-email-peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Cc: nsekhar-l0cyMroinI0@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, r.schwebel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wed, Oct 14, 2015 at 04:12:21PM +0300, Peter Ujfalusi wrote:
> The DMA event crossbar on AM33xx/AM43xx is different from the one found in
> DRA7x family.
> Instead of a single event crossbar it has 64 identical mux attached to each
> eDMA event line. When the 0 event mux is selected, the default mapped event
> is going to be routed to the corresponding eDMA event line. If different
> mux is selected, then the selected event is going to be routed to the given
> eDMA event.

Why is crossbar patch in edma series?

> +static void ti_am335x_xbar_free(struct device *dev, void *route_data)
> +{
> +	struct ti_am335x_xbar_data *xbar = dev_get_drvdata(dev);
> +	struct ti_am335x_xbar_map *map = route_data;
> +
> +	dev_err(dev, "Unmapping XBAR event %u on channel %u\n",
> +		map->mux_val, map->dma_line);

Err ?

-- 
~Vinod
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
