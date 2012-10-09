From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [GIT PULL] ARM: OMAP: warnings/hwmod/clock fixes for
 pre-3.7-rc1
Date: Tue, 9 Oct 2012 19:29:51 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1210091928180.5736@utopia.booyaka.com>
References: <alpine.DEB.2.00.1210091602390.5736@utopia.booyaka.com> <20121009190252.GD12552@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:58376 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753781Ab2JIT3w (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Oct 2012 15:29:52 -0400
In-Reply-To: <20121009190252.GD12552@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, 9 Oct 2012, Tony Lindgren wrote:

> * Paul Walmsley <paul@pwsan.com> [121009 09:05]:
> > 
> > N800 isn't booting; this is a problem present in the base commit and
> > is due to serial driver breakage:
> > 
> >    http://www.spinics.net/lists/arm-kernel/msg196034.html
> 
> This might be related also to the n800 booting in sys mode
> that causes issues with the recent hyp patches. A fix for
> that has been queued, for more info see the thread
> "v2 2/7] ARM: virt: allow the kernel to be entered in HYP mode".

Thanks for the pointer.  That one would break the boot quite early, right? 
This one has the same symptoms as the serial issue, where it bombs out 
after:

[    0.948394] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.974273] omap_uart.0: ttyO0 at MMIO 0x4806a000 (irq = 88) is a OMAP UART0
[    0.986968] omap_uart.1: ttyO1 at MMIO 0x4806c000 (irq = 89) is a OMAP UART1

(hang)

- Paul
