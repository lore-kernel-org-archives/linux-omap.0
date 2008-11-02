From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 4/4] DSPBRIDGE: Ensure write posting when acking
	mailbox irq
Date: Sun, 2 Nov 2008 14:10:50 -0800
Message-ID: <20081102221050.GQ28924@atomide.com>
References: <1225480873-30835-1-git-send-email-tony@atomide.com> <1225480873-30835-2-git-send-email-tony@atomide.com> <1225480873-30835-3-git-send-email-tony@atomide.com> <1225480873-30835-4-git-send-email-tony@atomide.com> <1225480873-30835-5-git-send-email-tony@atomide.com> <13B9B4C6EF24D648824FF11BE89671620369885CBD@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:61813 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754304AbYKBWKw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 2 Nov 2008 17:10:52 -0500
Content-Disposition: inline
In-Reply-To: <13B9B4C6EF24D648824FF11BE89671620369885CBD@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Woodruff, Richard <r-woodruff2@ti.com> [081031 20:44]:
> > owner@vger.kernel.org] On Behalf Of Tony Lindgren
> > Sent: Friday, October 31, 2008 2:21 PM
> 
> > The only way to ensure write posting to L4 bus is to do a read back
> > of the same register right after the write.
> >
> > This seems to be mostly needed in interrupt handlers to avoid
> > causing spurious interrupts.
> >
> > The earlier fix has been to mark the L4 bus as strongly ordered
> > memory, which solves the problem, but causes performance penalties.
> 
> What penalties have you observed?  Can you quantify?

Not yet, I guess we can run some benchmarks though.

> From the L4 perspectives DEVICE and SO are similar.  Long back I was told one difference is DEVICE is allowed to do burst transactions of element size where SO was not. This behavior is only really wanted to a FIFO.
> 
> Really performance sensitive devices will be using DMA to FIFOs.  SO/DEVICE only applies to the ARM's view of things.  DMA is not affected by ARM memory types.

You may be right, and if that's the only difference, then SO might be
even faster as it avoids the extra readbacks.

> Some kind of barrier or read back is needed for sure when dealing with the main interrupt controller.

Yeah. I'm worried that these issues could happen with SO too..

Regards,

Tony
