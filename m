From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 0/4] Patches to make multi-soc handling in entry-armv.S
 easier
Date: Sat, 04 Dec 2010 21:36:12 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1012042126350.10437@xanadu.home>
References: <20101204001435.28853.29616.stgit@baageli.muru.com>
 <alpine.LFD.2.00.1012040040590.10437@xanadu.home>
 <20101204180541.GH17222@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:17970 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752670Ab0LECgN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 4 Dec 2010 21:36:13 -0500
Received: from xanadu.home ([66.130.28.92]) by vl-mo-mrz23.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LCX0029TOJXC260@vl-mo-mrz23.ip.videotron.ca> for
 linux-omap@vger.kernel.org; Sat, 04 Dec 2010 21:35:58 -0500 (EST)
In-reply-to: <20101204180541.GH17222@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Sat, 4 Dec 2010, Tony Lindgren wrote:

> * Nicolas Pitre <nico@fluxnic.net> [101203 21:39]:
> > On Fri, 3 Dec 2010, Tony Lindgren wrote:
> > 
> > > Hi all,
> > > 
> > > I've got some patches almost ready to go to merge the omap1
> > > configs into a single omap1_defconfig. While working on getting
> > > that done, I had to come up with a better solution for entry-armv.S
> > > macros to detect the soc we're running on.
> > > 
> > > I suggest we add asm_irq_base and asm_irq_flags as in the first
> > > patch in this series does. This way we can do the soc based detection
> > > in init_irq or similar place. This might help also the multi-arm
> > > work too.
> > 
> > Did you see Eric Miao's patch series that introduces runtime IRQ demux 
> > handler support?
> > 
> > http://www.spinics.net/linux/lists/arm-kernel/msg92836.html
> > 
> > That is likely to be a better solution.
> 
> Yeah that works too, although is a bit heavier for simple cases.
> 
> In the omap case just the irq base is different between omap2 vs omap3.
> And only level2 interrupt bit is different omap7xx vs omap16xx.
> 
> Handling the difference between omap2/3 and omap4 would be the use
> case for handle_arch_irq. Currently that too can be handled
> without handle_arch_irq, but from multi-arm point of view
> handle_arch_irq is needed in the long run.
> 
> I can do things either way quite easily for sure. But my preference
> would be to have both options available. This is because asm_irq_base
> and asm_irq_flags can be used to reduce 15 omap1 defconfigs into one
> defconfig with quite minimal changes. And for omap2+, these patches
> allow getting rid of the SoC detection code in entry-macro.S. Also,
> after these patches, moving to use handle_arch_irq can be done a bit
> easier later on.

My only problem with your approach is the global addition of 
asm_irq_base and asm_irq_flags in generic code which might not be useful 
and/or appropriate for all targets.  If you were confining them to some 
OMAP specific file then I wouldn't mind as much.  Looking at the patch I 
see that you had omap_irq_base before.  Why wasn't that sufficient?  
Only omap_irq_flags would be missing.


Nicolas
