From: Grant Grundler <grundler@google.com>
Subject: Re: [PATCH] usb: ehci: make HC see up-to-date qh/qtd descriptor ASAP
Date: Thu, 1 Sep 2011 23:16:18 +0000 (UTC)
Message-ID: <loom.20110902T011554-272@post.gmane.org>
References: <1314720193-26577-1-git-send-email-ming.lei@canonical.com> <1314722311.2344.64.camel@deneb.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:36789 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932536Ab1IAXUG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 1 Sep 2011 19:20:06 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gplao-linux-omap-open-source-moved1@m.gmane.org>)
	id 1QzGYG-0004Ed-Rb
	for linux-omap@vger.kernel.org; Fri, 02 Sep 2011 01:20:04 +0200
Received: from 216-239-45-4.google.com ([216.239.45.4])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Fri, 02 Sep 2011 01:20:04 +0200
Received: from grundler by 216-239-45-4.google.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Fri, 02 Sep 2011 01:20:04 +0200
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Mark Salter <msalter <at> redhat.com> writes:
> On Wed, 2011-08-31 at 00:03 +0800, ming.lei <at> canonical.com wrote:
...
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
...

Consider moving the #ifdef inside the function. :)

> I'm wondering if this doesn't really belong in the DMA API for any
> future architectures that can't avoid prolonged write buffering to DMA
> coherent memory.

I suspect the semantics needed exist in mmiowb().  Honestly, I'm not an expert
of either ehci USB and ARM platforms but it looks that way to me after reading
the thread.

BTW, ChromiumOS has had a performance bug open for quite a while:
    http://code.google.com/p/chromium-os/issues/detail?id=11503

Vince Palatin said he would try it.


mmiowb() was originally implemented for SGI SN2 (IA64/Altix) machines but
applies to any case where MMIO (any uncached writes really) and "regular" (ie
cached) memory writes need to be ordered.

The "wmb() vs mmiowb()" thread explains this pretty well:
    http://www.mail-archive.com/linux-ia64@vger.kernel.org/msg03379.html


> IIUC, ARM mitigates this for most drivers by including
> an implicit write buffer flush in the mmio write routines.

The write flush is part of the MMIO writel() semantics AFAIK because MMIO writes
have to be strongly ordered (PCI requirement).

> This takes
> care of the drivers which write to a mmio device register after writing
> something to shared DMA memory. IIUC, this doesn't help ehci because the
> host controller is polling to see what the cpu writes to the shared
> memory.

Write flush in writel() does help for the "not RUNNING" -> "RUNNING" state
transition (I'm looking at qh_link_async()). It doesn't help for "already
RUNNING" case.

> Other hardware which polls shared memory like that will likely
> have the same problem and could use buffer drain helpers as well.

Yup - agreed.

cheers,
grant


