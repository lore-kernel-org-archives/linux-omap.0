From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/4] Patches to make multi-soc handling in entry-armv.S
 easier
Date: Sat, 4 Dec 2010 19:10:03 -0800
Message-ID: <20101205031002.GP17222@atomide.com>
References: <20101204001435.28853.29616.stgit@baageli.muru.com>
 <alpine.LFD.2.00.1012040040590.10437@xanadu.home>
 <20101204180541.GH17222@atomide.com>
 <alpine.LFD.2.00.1012042126350.10437@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:40387 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751221Ab0LEDKL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 4 Dec 2010 22:10:11 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1012042126350.10437@xanadu.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Nicolas Pitre <nico@fluxnic.net> [101204 18:26]:
> On Sat, 4 Dec 2010, Tony Lindgren wrote:
> 
> My only problem with your approach is the global addition of 
> asm_irq_base and asm_irq_flags in generic code which might not be useful 
> and/or appropriate for all targets.  If you were confining them to some 
> OMAP specific file then I wouldn't mind as much.  Looking at the patch I 
> see that you had omap_irq_base before.  Why wasn't that sufficient?  
> Only omap_irq_flags would be missing.

I guess I was thinking this is something that might help others
to build more machines into one defconfig. If that's not the case,
sure these can be kept omap specific.

After a quick browsing of the entry-macro.S files, looks like
there's some similar ifdeffery for get_irqnr_* macros that just might
be possible to clear out with asm_irq_base and asm_irq_flags:

arch/arm/mach-davinci/include/mach/entry-macro.S
arch/arm/mach-s5p64x0/include/mach/entry-macro.S
arch/arm/mach-ixp4xx/include/mach/entry-macro.S
arch/arm/mach-h720x/include/mach/entry-macro.S
arch/arm/plat-mxc/include/mach/entry-macro.S

Maybe let's wait a while to see if there are other use cases,
if not, I'll make them omap specific.

Regards,

Tony
