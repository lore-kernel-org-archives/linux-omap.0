From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: [PATCH 5/6] dmaengine: omap-dma: Remove mapping between virtual
 channels and requests
Date: Tue, 24 Feb 2015 14:28:33 +0000
Message-ID: <20150224142833.GI8670@n2100.arm.linux.org.uk>
References: <1424787683-19151-1-git-send-email-peter.ujfalusi@ti.com>
 <1424787683-19151-6-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1424787683-19151-6-git-send-email-peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Cc: vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, nm-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tue, Feb 24, 2015 at 04:21:22PM +0200, Peter Ujfalusi wrote:
> Do not direct map the virtual channels to sDMA request number. When the
> sDMA is behind of a crossbar this direct mapping can cause situations when
> certain channel can not be requested since the crossbar request number
> will no longer match with the sDMA request line.
> The direct mapping for virtual channels with HW request lines will make it
> harder to implement MEM_TO_MEM mode for the driver.

I assume when you talk about MEM_TO_MEM, you're referring to a DMA_MEMCPY
driver.

mem2mem should not be handled by the slave driver.  This should be a
separate DMA engine driver structure which does not have DMA_SLAVE set.

See how amba-pl08x handles this.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
