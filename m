From: Fengguang Wu <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [balbi-usb:merge-result-for-greg 66/99]
 drivers/usb/core/hub.c:2654 usb_get_hub_port_power_state() error: doing dma
 on the stack ((null))
Date: Wed, 12 Sep 2012 20:09:57 +0800
Message-ID: <20120912120957.GA8495@localhost>
References: <20120912082622.GB27847@localhost>
 <20120912085057.GC19396@mwanda>
 <20120912120211.GC5732@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120912120211.GC5732-S8G//mZuvNWo5Im9Ml3/Zg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wed, Sep 12, 2012 at 03:02:13PM +0300, Felipe Balbi wrote:
> Hi,
> 
> On Wed, Sep 12, 2012 at 11:50:57AM +0300, Dan Carpenter wrote:
> > On Wed, Sep 12, 2012 at 04:26:22PM +0800, Fengguang Wu wrote:
> > > Hi Felipe,
> > > 
> > > FYI, there are new smatch warnings show up in
> > > 
> > > tree:   git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git merge-result-for-greg
> > > head:   23953bde3e4d6aa8780dc054f6ad9882ac63f4f4
> > > commit: e918fa161f510136fce45a524e934fe20e62c8b1 [66/99] Merge tag 'gadget-for-v3.7' into merge-result-for-greg
> > > 
> > > drivers/usb/core/hub.c:2654 usb_get_hub_port_power_state() error: doing dma on the stack ((null))
> 
> that's not part of what I handle :-(
> 
> And merge-result-for-greg was really a temporary branch, btw :-)

No problem. I'll stop testing this branch :)

Thanks,
Fengguang
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
