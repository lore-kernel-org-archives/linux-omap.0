From: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH][linux-next] dmaengine: cppi41: Fix an Oops happening in
 cppi41_dma_probe()
Date: Thu, 6 Apr 2017 12:42:18 +0530
Message-ID: <20170406071218.GH4094@localhost>
References: <20170405163516.13627-1-abailon@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170405163516.13627-1-abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Cc: dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wed, Apr 05, 2017 at 06:35:16PM +0200, Alexandre Bailon wrote:
> This fix an Oops happening on all platforms using the old dt bindings
> (all platforms but da8xx).
> This update cppi41_dma_probe() to use the index variable which is
> required to keep compatibility between old and new dt bindings.

Applied, thanks

-- 
~Vinod
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
