From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH 4/4] DSPBRIDGE: Ensure write posting when acking mailbox
 irq
Date: Fri, 31 Oct 2008 22:43:47 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE89671620369885CBD@dlee02.ent.ti.com>
References: <1225480873-30835-1-git-send-email-tony@atomide.com>
 <1225480873-30835-2-git-send-email-tony@atomide.com>
 <1225480873-30835-3-git-send-email-tony@atomide.com>
 <1225480873-30835-4-git-send-email-tony@atomide.com>
 <1225480873-30835-5-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40063 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750822AbYKADn4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 31 Oct 2008 23:43:56 -0400
In-Reply-To: <1225480873-30835-5-git-send-email-tony@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> owner@vger.kernel.org] On Behalf Of Tony Lindgren
> Sent: Friday, October 31, 2008 2:21 PM

> The only way to ensure write posting to L4 bus is to do a read back
> of the same register right after the write.
>
> This seems to be mostly needed in interrupt handlers to avoid
> causing spurious interrupts.
>
> The earlier fix has been to mark the L4 bus as strongly ordered
> memory, which solves the problem, but causes performance penalties.

What penalties have you observed?  Can you quantify?

>From the L4 perspectives DEVICE and SO are similar.  Long back I was told one difference is DEVICE is allowed to do burst transactions of element size where SO was not. This behavior is only really wanted to a FIFO.

Really performance sensitive devices will be using DMA to FIFOs.  SO/DEVICE only applies to the ARM's view of things.  DMA is not affected by ARM memory types.

Some kind of barrier or read back is needed for sure when dealing with the main interrupt controller.

Regards,
Richard W.

