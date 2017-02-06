From: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v5 6/6] usb: musb: dsps: Manage CPPI 4.1 DMA interrupt in
 DSPS
Date: Mon, 6 Feb 2017 09:27:05 +0530
Message-ID: <20170206035704.GB19244@localhost>
References: <20170125101709.15696-1-abailon@baylibre.com>
 <20170125101709.15696-7-abailon@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170125101709.15696-7-abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Cc: b-liu-l0cyMroinI0@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wed, Jan 25, 2017 at 11:17:09AM +0100, Alexandre Bailon wrote:
> Despite the CPPI 4.1 is a generic DMA, it is tied to USB.
> On the DSPS, CPPI 4.1 interrupt's registers are in USBSS (the MUSB glue).
> Currently, to enable / disable and clear interrupts, the CPPI 4.1 driver
> maps and accesses to USBSS's register, which making CPPI 4.1 driver not
> really generic.
> Move the interrupt management to DSPS driver.
> 
> Signed-off-by: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
> ---
>  drivers/dma/cppi41.c         | 28 ++++-----------

Acked-by: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

-- 
~Vinod
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
