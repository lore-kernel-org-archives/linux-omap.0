From: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/2] Two cpp41 pm runtime found when testing with usb
Date: Tue, 15 Nov 2016 08:59:29 +0530
Message-ID: <20161115032929.GK3000@localhost>
References: <20161109164759.24913-1-tony@atomide.com>
 <20161114052830.GA3000@localhost>
 <20161114144912.GR7138@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161114144912.GR7138-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Mon, Nov 14, 2016 at 06:49:12AM -0800, Tony Lindgren wrote:
> * Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> [161113 21:19]:
> > On Wed, Nov 09, 2016 at 09:47:57AM -0700, Tony Lindgren wrote:
> > > Hi,
> > > 
> > > I found two pm runtime issues when testing with usb on beaglebone.
> > > 
> > > In the am335x case cppi41 and two instances of musb controller share
> > > the same interconnect wrapper module, so any pm issues with musb or
> > > cppi41 will keep the interconnect wrapper module busy.
> > 
> > Applied both. And as I have told you previously please use the correct
> > subsystem tag. I have fixed them again!
> 
> Sorry about that. What do you prefer for future reference? We are using
> both "dma: cppi41" and "dmaengine: cppi41" currently..

"dmaengine: cppi41: xxx" would be better

-- 
~Vinod
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
