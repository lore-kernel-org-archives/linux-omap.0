From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] usb: ehci: make HC see up-to-date qh/qtd descriptor ASAP
Date: Tue, 30 Aug 2011 13:15:42 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1108301312020.2109-100000@iolanthe.rowland.org>
References: <1314722311.2344.64.camel@deneb.redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:36095 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754721Ab1H3RPm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Aug 2011 13:15:42 -0400
In-Reply-To: <1314722311.2344.64.camel@deneb.redhat.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Salter <msalter@redhat.com>
Cc: ming.lei@canonical.com, greg@kroah.com, linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Russell King <linux@arm.linux.org.uk>

On Tue, 30 Aug 2011, Mark Salter wrote:

> On Wed, 2011-08-31 at 00:03 +0800, ming.lei@canonical.com wrote:
> > +/*
> > + * Writing to dma coherent memory on ARM may be delayed via L2
> > + * writing buffer, so introduce the helper which can flush L2 writing
> > + * buffer into memory immediately, especially used to flush ehci
> > + * descriptor to memory.
> > + * */
> > +#ifdef CONFIG_ARM_DMA_MEM_BUFFERABLE
> > +static inline void ehci_sync_mem()
> > +{
> > +       mb();
> > +}
> > +#else
> > +static inline void ehci_sync_mem()
> > +{
> > +}
> > +#endif
> > +
> 
> I'm wondering if this doesn't really belong in the DMA API for any
> future architectures that can't avoid prolonged write buffering to DMA
> coherent memory. IIUC, ARM mitigates this for most drivers by including
> an implicit write buffer flush in the mmio write routines. This takes
> care of the drivers which write to a mmio device register after writing
> something to shared DMA memory. IIUC, this doesn't help ehci because the
> host controller is polling to see what the cpu writes to the shared
> memory. Other hardware which polls shared memory like that will likely
> have the same problem and could use buffer drain helpers as well.

This would be a good thing to define centrally.  Would you like to 
post an RFC on LKML?

Do you know of any other examples of hardware that polls shared DMA 
memory?

Alan Stern

