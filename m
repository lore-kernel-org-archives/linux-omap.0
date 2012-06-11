From: Dong Aisheng <aisheng.dong@freescale.com>
Subject: Re: RFC: changing DMA slave configuration API
Date: Mon, 11 Jun 2012 17:33:33 +0800
Message-ID: <20120611093332.GC26681@shlinux2.ap.freescale.net>
References: <20120610102023.GC11404@n2100.arm.linux.org.uk>
 <CAGsJ_4xHNdEcfsmtypDHcJ0uyhtFz43xBojgHw2RSvrH8ohRcA@mail.gmail.com>
 <20120610112217.GD11404@n2100.arm.linux.org.uk>
 <1339390249.1927.1623.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from am1ehsobe002.messaging.microsoft.com ([213.199.154.205]:19411
	"EHLO am1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751011Ab2FKJfJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jun 2012 05:35:09 -0400
Content-Disposition: inline
In-Reply-To: <1339390249.1927.1623.camel@vkoul-udesk3>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vinod Koul <vinod.koul@linux.intel.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Dan Williams <dan.j.williams@intel.com>, linux-omap@vger.kernel.org, Barry Song <21cnbao@gmail.com>, linux-arm-kernel@lists.infradead.org

On Mon, Jun 11, 2012 at 10:20:49AM +0530, Vinod Koul wrote:
> On Sun, 2012-06-10 at 12:22 +0100, Russell King - ARM Linux wrote:
> > On Sun, Jun 10, 2012 at 07:19:47PM +0800, Barry Song wrote:
> > > 2012/6/10 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> > > > Dan, Vinod,
> > > >
> > > > There's a change I would like to do to the DMA slave configuration.
> > > > It's currently a pain to have the source and destination parameters in
> > > > the dma_slave_config structure as separate elements; it means when you
> > > > want to extract them, you end up with code in DMA engine drivers like:
> > > >
> > > > +       if (dir == DMA_DEV_TO_MEM) {
> > > > +               dev_addr = c->src_addr;
> > > > +               dev_width = c->src_addr_width;
> > > > +               burst = c->src_maxburst;
> > > > +       } else if (dir == DMA_MEM_TO_DEV) {
> > > > +               dev_addr = c->dst_addr;
> > > > +               dev_width = c->dst_addr_width;
> > > > +               burst = c->dst_maxburst;
> > > > +       }
> > > >
> > > > If we redefine the structure as below, this all becomes more simple:
> > > >
> > > > +       if (dir == DMA_DEV_TO_MEM)
> > > > +               cfg = &c->dev_src;
> > > > +       else if (dir == DMA_MEM_TO_DEV)
> > > > +               cfg = &c->dev_dst;
> > > 
> > > it seems that might mean an union in your dma_slave_cfg, but not
> > > co-exitense of both?
> > 
> > No, I want both so it's possible to select between the two when preparing
> > a DMA slave transfer.
> > 
> > > struct dma_slave_cfg {
> > > +       union {
> > >               struct dma_dev_cfg dev_src;
> > >               struct dma_dev_cfg dev_dst;
> > >        }
> > >        bool device_fc;
> > > };
> > 
> > If you do that, the union becomes pointless, and you might as well have:
> > 
> > struct dma_slave_cfg {
> > 	struct dma_dev_cfg dev;
> > 	bool device_fc;
> > };
> > 
> > instead.
> Hi Russell,
> 
> I think it is a good idea. And I would like to extend it even a little
> bit. Do we have any users of peripheral to peripheral slave dma?
Yes, IMX sdma does support such kind of transfer.
The driver still does not support it currently.

> IIRC  that is not the case, or does anyone know of existence or plans
> for such a h/w?
> 
i.MX5 and i.MX6.

> If not, lets junk the src/dst fields and keep burst, length, addr fields
> which point to the peripheral values.
> 
> Alternatively if we need both, then we can't have union and Russell's
> idea seems good one :)
> 
Russell's idea seems reasonable and we may want to support peripheral to
peripheral in the future.

Regards
Dong Aisheng

