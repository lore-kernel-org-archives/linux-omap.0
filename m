From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: ARM: v3.13-rc1: USB regression
Date: Mon, 25 Nov 2013 18:33:02 +0200
Message-ID: <20131125163302.GD24645@blackmetal.musicnaut.iki.fi>
References: <20131124222247.GC24645@blackmetal.musicnaut.iki.fi>
 <20131124224359.GE25039@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri6.pp.htv.fi ([213.243.153.189]:51445 "EHLO
	filtteri6.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756660Ab3KYQdL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 Nov 2013 11:33:11 -0500
Content-Disposition: inline
In-Reply-To: <20131124224359.GE25039@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, linux-omap@vger.kernel.org

Hi,

On Sun, Nov 24, 2013 at 10:43:59PM +0000, Russell King - ARM Linux wrote:
> On Mon, Nov 25, 2013 at 12:22:47AM +0200, Aaro Koskinen wrote:
> > [   33.967324] ohci ohci: Coherent DMA mask 0xffffffff (pfn 0xe0000-0xe0000) covers a smaller range of system memory than the DMA zone pfn 0x0-0x100000
> > 
> > I bisected this to 4dcfa60071b3d23f0181f27d8519f12e37cefbb9 (ARM: DMA-API:
> > better handing of DMA masks for coherent allocations). Reverting that
> > commit makes the USB work again fine.

[...]

> Better would be:
> 
> #define __arch_dma_to_pfn(dev, addr)	\
> 	({ unsigned long pfn = (addr) >> PAGE_SHIFT;		\
> 	   if (is_lbus_device(dev))				\
> 		pfn += PHYS_PFN_OFFSET - 			\
> 			(OMAP1510_LB_OFFSET >> PAGE_SHIFT);	\
> 	   pfn;							\
> 	})
> 
> Can you try that in arch/arm/mach-omap1/include/mach/memory.h please?

Still doesn't work:

[   33.878790] ohci ohci: Coherent DMA mask 0xffffffff (pfn 0xfffe0000-0xe0000) covers a smaller range of system memory than the DMA zone pfn 0x0-0x100000
[   33.894019] ohci ohci: can't setup: -12

A.
