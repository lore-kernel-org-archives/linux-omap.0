From: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] usb: ehci: make HC see up-to-date qh/qtd descriptor ASAP
Date: Tue, 30 Aug 2011 10:48:59 -0700
Message-ID: <20110830174859.GA23098@kroah.com>
References: <1314720193-26577-1-git-send-email-ming.lei@canonical.com>
 <1314722311.2344.64.camel@deneb.redhat.com>
 <20110830172642.GE3464@e102144-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20110830172642.GE3464-SGELLbQ0bobZROr8t4l/smS4ubULX0JqMm0uRHvK7Nw@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: Mark Salter <msalter-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "ming.lei-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org" <ming.lei-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org" <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Aug 30, 2011 at 06:26:42PM +0100, Will Deacon wrote:
> On Tue, Aug 30, 2011 at 05:38:30PM +0100, Mark Salter wrote:
> > On Wed, 2011-08-31 at 00:03 +0800, ming.lei-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org wrote:
> > > +/*
> > > + * Writing to dma coherent memory on ARM may be delayed via L2
> > > + * writing buffer, so introduce the helper which can flush L2 writing
> > > + * buffer into memory immediately, especially used to flush ehci
> > > + * descriptor to memory.
> > > + * */
> > > +#ifdef CONFIG_ARM_DMA_MEM_BUFFERABLE
> > > +static inline void ehci_sync_mem()
> > > +{
> > > +       mb();
> > > +}
> > > +#else
> > > +static inline void ehci_sync_mem()
> > > +{
> > > +}
> > > +#endif
> > > +
> > 
> > I'm wondering if this doesn't really belong in the DMA API for any
> > future architectures that can't avoid prolonged write buffering to DMA
> > coherent memory. IIUC, ARM mitigates this for most drivers by including
> > an implicit write buffer flush in the mmio write routines. This takes
> > care of the drivers which write to a mmio device register after writing
> > something to shared DMA memory. IIUC, this doesn't help ehci because the
> > host controller is polling to see what the cpu writes to the shared
> > memory. Other hardware which polls shared memory like that will likely
> > have the same problem and could use buffer drain helpers as well.
> 
> Right. In this case the buffering is happening at L2 which becomes
> noticeable when measuring performance. We also buffer stores at the
> CPU (regardless of memory type) but because these tend to become visible
> fairly quickly, there isn't a comparable performance problem.
> 
> Given that I would expect other architectures to buffer writes at the CPU,
> would it not be worth having an API for flushing to L3 (devices)? It seems
> like this would be a useful addition to the coherent DMA API on platforms
> that handle coherency with non-cacheable memory attributes.

I agree, this seems to be a "new" type of barrier that is needed, as the
code comment above seems to go against what the kernel memory barrier
documentation says about what a memory barrier really does on the
hardware.

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
