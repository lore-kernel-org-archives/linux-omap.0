From: Mark Salter <msalter@redhat.com>
Subject: Re: [PATCH] usb: ehci: make HC see up-to-date qh/qtd descriptor ASAP
Date: Tue, 30 Aug 2011 14:45:34 -0400
Message-ID: <1314729936.2344.71.camel@deneb.redhat.com>
References: <Pine.LNX.4.44L0.1108301312020.2109-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:14845 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755824Ab1H3Spt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 30 Aug 2011 14:45:49 -0400
In-Reply-To: <Pine.LNX.4.44L0.1108301312020.2109-100000@iolanthe.rowland.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: ming.lei@canonical.com, greg@kroah.com, linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Russell King <linux@arm.linux.org.uk>

On Tue, 2011-08-30 at 13:15 -0400, Alan Stern wrote:
> On Tue, 30 Aug 2011, Mark Salter wrote:
> 
> > On Wed, 2011-08-31 at 00:03 +0800, ming.lei@canonical.com wrote:
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
> This would be a good thing to define centrally.  Would you like to 
> post an RFC on LKML?

Yes, I can take a stab at that.

> 
> Do you know of any other examples of hardware that polls shared DMA 
> memory?

Not offhand nor after a quick search. I don't think it is a common
way of doing things.

--Mark


