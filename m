From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: OMAP: warnings/hwmod/clock fixes for
 pre-3.7-rc1
Date: Tue, 9 Oct 2012 14:43:10 -0700
Message-ID: <20121009214310.GG12552@atomide.com>
References: <alpine.DEB.2.00.1210091602390.5736@utopia.booyaka.com>
 <20121009190252.GD12552@atomide.com>
 <alpine.DEB.2.00.1210091928180.5736@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:50146 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756985Ab2JIVnP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Oct 2012 17:43:15 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1210091928180.5736@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [121009 12:31]:
> On Tue, 9 Oct 2012, Tony Lindgren wrote:
> 
> > * Paul Walmsley <paul@pwsan.com> [121009 09:05]:
> > > 
> > > N800 isn't booting; this is a problem present in the base commit and
> > > is due to serial driver breakage:
> > > 
> > >    http://www.spinics.net/lists/arm-kernel/msg196034.html
> > 
> > This might be related also to the n800 booting in sys mode
> > that causes issues with the recent hyp patches. A fix for
> > that has been queued, for more info see the thread
> > "v2 2/7] ARM: virt: allow the kernel to be entered in HYP mode".
> 
> Thanks for the pointer.  That one would break the boot quite early, right? 
> This one has the same symptoms as the serial issue, where it bombs out 
> after:
> 
> [    0.948394] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
> [    0.974273] omap_uart.0: ttyO0 at MMIO 0x4806a000 (irq = 88) is a OMAP UART0
> [    0.986968] omap_uart.1: ttyO1 at MMIO 0x4806c000 (irq = 89) is a OMAP UART1
> 
> (hang)

Yes the sys mode hangs right away and only prints a few lines
with earlyprintk.

Regards,

Tony
