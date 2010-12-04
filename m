From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/4] Patches to make multi-soc handling in entry-armv.S
 easier
Date: Sat, 4 Dec 2010 10:05:41 -0800
Message-ID: <20101204180541.GH17222@atomide.com>
References: <20101204001435.28853.29616.stgit@baageli.muru.com>
 <alpine.LFD.2.00.1012040040590.10437@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:30016 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755155Ab0LDSFr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 4 Dec 2010 13:05:47 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1012040040590.10437@xanadu.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Nicolas Pitre <nico@fluxnic.net> [101203 21:39]:
> On Fri, 3 Dec 2010, Tony Lindgren wrote:
> 
> > Hi all,
> > 
> > I've got some patches almost ready to go to merge the omap1
> > configs into a single omap1_defconfig. While working on getting
> > that done, I had to come up with a better solution for entry-armv.S
> > macros to detect the soc we're running on.
> > 
> > I suggest we add asm_irq_base and asm_irq_flags as in the first
> > patch in this series does. This way we can do the soc based detection
> > in init_irq or similar place. This might help also the multi-arm
> > work too.
> 
> Did you see Eric Miao's patch series that introduces runtime IRQ demux 
> handler support?
> 
> http://www.spinics.net/linux/lists/arm-kernel/msg92836.html
> 
> That is likely to be a better solution.

Yeah that works too, although is a bit heavier for simple cases.

In the omap case just the irq base is different between omap2 vs omap3.
And only level2 interrupt bit is different omap7xx vs omap16xx.

Handling the difference between omap2/3 and omap4 would be the use
case for handle_arch_irq. Currently that too can be handled
without handle_arch_irq, but from multi-arm point of view
handle_arch_irq is needed in the long run.

I can do things either way quite easily for sure. But my preference
would be to have both options available. This is because asm_irq_base
and asm_irq_flags can be used to reduce 15 omap1 defconfigs into one
defconfig with quite minimal changes. And for omap2+, these patches
allow getting rid of the SoC detection code in entry-macro.S. Also,
after these patches, moving to use handle_arch_irq can be done a bit
easier later on.

Regards,

Tony
