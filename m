From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: Please help with the OMAP static mapping mess
Date: Mon, 03 Oct 2011 18:39:27 -0400 (EDT)
Message-ID: <alpine.LFD.2.02.1110031827440.9106@xanadu.home>
References: <alpine.LFD.2.02.1110031312480.9106@xanadu.home>
 <20111003205658.GJ6324@atomide.com>
 <alpine.LFD.2.02.1110031744100.9106@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:58600 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752899Ab1JCWj2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Oct 2011 18:39:28 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-VM-MR003.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0LSI0028MHK5HGQ0@VL-VM-MR003.ip.videotron.ca> for
 linux-omap@vger.kernel.org; Mon, 03 Oct 2011 18:38:29 -0400 (EDT)
In-reply-to: <alpine.LFD.2.02.1110031744100.9106@xanadu.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, 3 Oct 2011, Nicolas Pitre wrote:

> On Mon, 3 Oct 2011, Tony Lindgren wrote:
> 
> > * Nicolas Pitre <nico@fluxnic.net> [111003 11:26]:
> > > 
> > > Furthermore... there is also a static mapping for physical address 
> > > 0x4e000000 using virtual address 0xff100000 which is already reserved 
> > > for other purposes i.e. the consistent DMA area.  It is not immediately 
> > > obvious where this comes from without being intimate with the OMAP code. 
> > > Can this be fixed as well i.e. moved elsewhere please?
> > 
> > This sounds like a bug somewhere. Which omap are you seeing this on?
> 
> OMAP4430 on a Panda board.
> 
> Here are the static mappings I'm seeing:
> 
> phys = 0x44000000 virt = 0xf8000000 size = 0x100000
> phys = 0x4a000000 virt = 0xfc000000 size = 0x400000
> phys = 0x50000000 virt = 0xf9000000 size = 0x100000
> phys = 0x4c000000 virt = 0xfd100000 size = 0x100000
> phys = 0x4d000000 virt = 0xfe100000 size = 0x100000
> phys = 0x4e000000 virt = 0xff100000 size = 0x100000 <---
> phys = 0x48000000 virt = 0xfa000000 size = 0x400000
> phys = 0x54000000 virt = 0xfe800000 size = 0x800000

It looks like this comes from OMAP44XX_DMM_VIRT.

#define OMAP44XX_DMM_PHYS       OMAP44XX_DMM_BASE
                                                /* 0x4e000000 --> 0xfd300000 */
#define OMAP44XX_DMM_VIRT       (OMAP44XX_DMM_PHYS + OMAP4_L3_PER_IO_OFFSET)
#define OMAP44XX_DMM_SIZE       SZ_1M

The comment suggesting a mapping correspondance is obviously wrong. We have:

#define OMAP44XX_DMM_BASE       0x4e000000
#define OMAP4_L3_PER_IO_OFFSET  0xb1100000

Hence 0x4e000000 + 0xb1100000 = 0xff100000.


Nicolas








> 
> It is also possible that I might have screwed something up on my side.  
> What is located at 0x4e000000?
> 
> 
> Nicolas
> 
