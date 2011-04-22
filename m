From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH] ARM: Fix relocation if image end past uncompressed
 kernel end
Date: Fri, 22 Apr 2011 13:36:01 +0800
Message-ID: <20110422053600.GK4024@S2100-06.ap.freescale.net>
References: <20110420072156.GA28679@atomide.com>
 <alpine.LFD.2.00.1104200850030.24613@xanadu.home>
 <20110420165514.GE10402@atomide.com>
 <alpine.LFD.2.00.1104201318040.24613@xanadu.home>
 <20110421055945.GB13688@atomide.com>
 <20110421104954.GH13688@atomide.com>
 <alpine.LFD.2.00.1104210919070.24613@xanadu.home>
 <alpine.LFD.2.00.1104211711240.24613@xanadu.home>
 <alpine.LFD.2.00.1104212233170.24613@xanadu.home>
 <20110422051914.GJ4024@S2100-06.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ch1ehsobe006.messaging.microsoft.com ([216.32.181.186]:55469
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750870Ab1DVFcB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 22 Apr 2011 01:32:01 -0400
Content-Disposition: inline
In-Reply-To: <20110422051914.GJ4024@S2100-06.ap.freescale.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Aaro Koskinen <aaro.koskinen@nokia.com>, linux-arm-kernel@lists.infradead.org, patches@linaro.org

On Fri, Apr 22, 2011 at 01:19:14PM +0800, Shawn Guo wrote:
> > ----- >8
> > 
> > From: Nicolas Pitre <nicolas.pitre@linaro.org>
> > 
> > ARM: zImage: make sure the stack is 64-bit aligned
> > 
> > With ARMv5+ and EABI, the compiler expects a 64-bit aligned stack so
> > instructions like STRD and LDRD can be used.  Without this, mysterious
> > boot failures were seen semi randomly with the LZMA decompressor.
> > 
> > While at it, let's align .bss as well.
> > 
> > Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
> > 
> > diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
> > index 58ac434..79b5c62 100644
> > --- a/arch/arm/boot/compressed/Makefile
> > +++ b/arch/arm/boot/compressed/Makefile
> > @@ -74,7 +74,7 @@ ZTEXTADDR	:= $(CONFIG_ZBOOT_ROM_TEXT)
> >  ZBSSADDR	:= $(CONFIG_ZBOOT_ROM_BSS)
> >  else
> >  ZTEXTADDR	:= 0
> > -ZBSSADDR	:= ALIGN(4)
> > +ZBSSADDR	:= ALIGN(8)
> >  endif
> >  
> >  SEDFLAGS	= s/TEXT_START/$(ZTEXTADDR)/;s/BSS_START/$(ZBSSADDR)/
> > diff --git a/arch/arm/boot/compressed/vmlinux.lds.in b/arch/arm/boot/compressed/vmlinux.lds.in
> > index 5309909..ea80abe 100644
> > --- a/arch/arm/boot/compressed/vmlinux.lds.in
> > +++ b/arch/arm/boot/compressed/vmlinux.lds.in
> > @@ -54,6 +54,7 @@ SECTIONS
> >    .bss			: { *(.bss) }
> >    _end = .;
> >  
> > +  . = ALIGN(8);		/* the stack must be 64-bit aligned */
> >    .stack		: { *(.stack) }
> >  
> >    .stab 0		: { *(.stab) }
> > 
> So this is the [PATCH 1/3] in the same set with following two?
> 
> [PATCH 2/3] ARM: zImage: don't ignore error returned from decompress()
> [PATCH 3/3] ARM: zImage: the page table memory must be considered before relocation
> 
On mx51 babbage,

Tested-by: Shawn Guo <shawn.guo@linaro.org>

which is only a regression test.

-- 
Regards,
Shawn

