From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH] ARM: Fix relocation if image end past uncompressed kernel
 end
Date: Thu, 21 Apr 2011 23:23:22 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1104212233170.24613@xanadu.home>
References: <1303272904-31392-1-git-send-email-nicolas.pitre@linaro.org> <20110420072156.GA28679@atomide.com> <alpine.LFD.2.00.1104200850030.24613@xanadu.home> <20110420165514.GE10402@atomide.com> <alpine.LFD.2.00.1104201318040.24613@xanadu.home>
 <20110421055945.GB13688@atomide.com> <20110421104954.GH13688@atomide.com> <alpine.LFD.2.00.1104210919070.24613@xanadu.home> <alpine.LFD.2.00.1104211711240.24613@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:40725 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753998Ab1DVDXZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Apr 2011 23:23:25 -0400
Received: by qwk3 with SMTP id 3so136630qwk.19
        for <linux-omap@vger.kernel.org>; Thu, 21 Apr 2011 20:23:25 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1104211711240.24613@xanadu.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Shawn Guo <shawn.guo@freescale.com>, linux-arm-kernel@lists.infradead.org, patches@linaro.org, Aaro Koskinen <aaro.koskinen@nokia.com>, linux-omap@vger.kernel.org

On Thu, 21 Apr 2011, Nicolas Pitre wrote:

> On Thu, 21 Apr 2011, Nicolas Pitre wrote:
> 
> > On Thu, 21 Apr 2011, Tony Lindgren wrote:
> > 
> > > Otherwise we end up overwriting ourselves. This fixes booting
> > > on n900 after commit 6d7d0ae51574943bf571d269da3243257a2d15db
> > > (ARM: 6750/1: improvements to compressed/head.S).
> > > 
> > > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > 
> > I don't understand why this is needed.  The copy loop is explicitly 
> > copying from the end going backward exactly to cope with this 
> > possibility.
> 
> I think your patch is 1) unneeded (see the copy loop code and the 
> comment before it), and 2) simply hiding the real bug.
> 
> I just need to modify the code in compressed/misc.c slightly for the 
> lzma decompressor to start or stop working randomly.  It seems that this 
> code might be sensitive to slight displacement in memory caused by 
> modifications to totally unrelated code.  I'm still trying to track this 
> down.

I found the bugger.  The problem was a bad stack alignment.

----- >8

From: Nicolas Pitre <nicolas.pitre@linaro.org>

ARM: zImage: make sure the stack is 64-bit aligned

With ARMv5+ and EABI, the compiler expects a 64-bit aligned stack so
instructions like STRD and LDRD can be used.  Without this, mysterious
boot failures were seen semi randomly with the LZMA decompressor.

While at it, let's align .bss as well.

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>

diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index 58ac434..79b5c62 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -74,7 +74,7 @@ ZTEXTADDR	:= $(CONFIG_ZBOOT_ROM_TEXT)
 ZBSSADDR	:= $(CONFIG_ZBOOT_ROM_BSS)
 else
 ZTEXTADDR	:= 0
-ZBSSADDR	:= ALIGN(4)
+ZBSSADDR	:= ALIGN(8)
 endif
 
 SEDFLAGS	= s/TEXT_START/$(ZTEXTADDR)/;s/BSS_START/$(ZBSSADDR)/
diff --git a/arch/arm/boot/compressed/vmlinux.lds.in b/arch/arm/boot/compressed/vmlinux.lds.in
index 5309909..ea80abe 100644
--- a/arch/arm/boot/compressed/vmlinux.lds.in
+++ b/arch/arm/boot/compressed/vmlinux.lds.in
@@ -54,6 +54,7 @@ SECTIONS
   .bss			: { *(.bss) }
   _end = .;
 
+  . = ALIGN(8);		/* the stack must be 64-bit aligned */
   .stack		: { *(.stack) }
 
   .stab 0		: { *(.stab) }
