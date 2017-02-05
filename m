From: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v4 0/5] dmaengine: cppi41: Make CPPI 4.1 driver more
 generic
Date: Sun, 5 Feb 2017 08:48:14 -0600
Message-ID: <20170205144814.GA13653@uda0271908>
References: <20170123172453.30224-1-abailon@baylibre.com>
 <20170205121046.GY19244@localhost>
 <20170205121250.GZ19244@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170205121250.GZ19244@localhost>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

+linux-usb list

On Sun, Feb 05, 2017 at 05:42:50PM +0530, Vinod Koul wrote:
> On Sun, Feb 05, 2017 at 05:40:46PM +0530, Vinod Koul wrote:
> > On Mon, Jan 23, 2017 at 06:24:47PM +0100, Alexandre Bailon wrote:
> > > Most of the patch of this series were part of
> > > "[PATCH 00/11] dmaengine: cppi41: Add dma support to da8xx"
> > > 
> > > This series intend to make the CPPI 4.1 more generic in order to
> > > add a new platform (the DA8xx).
> > > To achieve that, all the IRQ code present in CPPI 4.1 driver has been moved
> > > to MUSB DSPS driver.
> > > Other changes mainly update the glue layer and platform code to make the
> > > whole driver more generic.
> > > 
> > > This series is to apply on top of 
> > > "[PATCH v4 0/3] usb: musb: cppi41: Add a way to manage DMA irq".
> > 
> > Somehow I dont have that series in my queue, can you please repost this..
> 
> Oh wait, thats a USB series which should go thru USB tree right..? Or does
> it have dma parts too..?  Wasnt apparent from patch titles though..

Yes, that series are pending in my queue, it requires your ACK on [PATCH
v5 6/6] usb: musb: dsps: Manage CPPI 4.1 DMA interrupt in DSPS, which
moves interrupt handling from CPPI driver to MUSB driver.

Regards,
-Bin.
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
