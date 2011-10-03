From: Tony Lindgren <tony@atomide.com>
Subject: Re: Please help with the OMAP static mapping mess
Date: Mon, 3 Oct 2011 15:59:09 -0700
Message-ID: <20111003225908.GL6324@atomide.com>
References: <alpine.LFD.2.02.1110031312480.9106@xanadu.home>
 <20111003205658.GJ6324@atomide.com>
 <alpine.LFD.2.02.1110031744100.9106@xanadu.home>
 <alpine.LFD.2.02.1110031827440.9106@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:11754 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752185Ab1JCW7M (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Oct 2011 18:59:12 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.02.1110031827440.9106@xanadu.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Nicolas Pitre <nico@fluxnic.net>

* Nicolas Pitre <nico@fluxnic.net> [111003 15:05]:
> On Mon, 3 Oct 2011, Nicolas Pitre wrote:
> 
> > On Mon, 3 Oct 2011, Tony Lindgren wrote:
> > 
> > > * Nicolas Pitre <nico@fluxnic.net> [111003 11:26]:
> > > > 
> > > > Furthermore... there is also a static mapping for physical address 
> > > > 0x4e000000 using virtual address 0xff100000 which is already reserved 
> > > > for other purposes i.e. the consistent DMA area.  It is not immediately 
> > > > obvious where this comes from without being intimate with the OMAP code. 
> > > > Can this be fixed as well i.e. moved elsewhere please?
> > > 
> > > This sounds like a bug somewhere. Which omap are you seeing this on?
> > 
> > OMAP4430 on a Panda board.
> > 
> > Here are the static mappings I'm seeing:
> > 
> > phys = 0x44000000 virt = 0xf8000000 size = 0x100000
> > phys = 0x4a000000 virt = 0xfc000000 size = 0x400000
> > phys = 0x50000000 virt = 0xf9000000 size = 0x100000
> > phys = 0x4c000000 virt = 0xfd100000 size = 0x100000
> > phys = 0x4d000000 virt = 0xfe100000 size = 0x100000
> > phys = 0x4e000000 virt = 0xff100000 size = 0x100000 <---
> > phys = 0x48000000 virt = 0xfa000000 size = 0x400000
> > phys = 0x54000000 virt = 0xfe800000 size = 0x800000
> 
> It looks like this comes from OMAP44XX_DMM_VIRT.
> 
> #define OMAP44XX_DMM_PHYS       OMAP44XX_DMM_BASE
>                                                 /* 0x4e000000 --> 0xfd300000 */
> #define OMAP44XX_DMM_VIRT       (OMAP44XX_DMM_PHYS + OMAP4_L3_PER_IO_OFFSET)
> #define OMAP44XX_DMM_SIZE       SZ_1M
> 
> The comment suggesting a mapping correspondance is obviously wrong. We have:
> 
> #define OMAP44XX_DMM_BASE       0x4e000000
> #define OMAP4_L3_PER_IO_OFFSET  0xb1100000
> 
> Hence 0x4e000000 + 0xb1100000 = 0xff100000.

Seem like it might cause some random patterns in tiler :)
Santosh, can youp please check it?

Regards,

Tony
