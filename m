From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 04/14] ARM: v6k: introduce CPU_V6K option
Date: Tue, 18 Jan 2011 11:09:22 +0000
Message-ID: <20110118110922.GB10997@n2100.arm.linux.org.uk>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk> <E1Peuej-0003SV-Dn@rmk-PC.arm.linux.org.uk> <000601cbb6fb$8465c620$8d315260$@deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:45812 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750914Ab1ARLKe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Jan 2011 06:10:34 -0500
Content-Disposition: inline
In-Reply-To: <000601cbb6fb$8465c620$8d315260$@deacon@arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Tue, Jan 18, 2011 at 10:36:08AM -0000, Will Deacon wrote:
> > diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> > index c22c1ad..9c43052 100644
> > --- a/arch/arm/Makefile
> > +++ b/arch/arm/Makefile
> > @@ -89,6 +89,7 @@ tune-$(CONFIG_CPU_XSCALE)	:=$(call cc-option,-mtune=xscale,-mtune=strongarm110)
> >  tune-$(CONFIG_CPU_XSC3)		:=$(call cc-option,-mtune=xscale,-mtune=strongarm110) -Wa,-
> > mcpu=xscale
> >  tune-$(CONFIG_CPU_FEROCEON)	:=$(call cc-option,-mtune=marvell-f,-mtune=xscale)
> >  tune-$(CONFIG_CPU_V6)		:=$(call cc-option,-mtune=arm1136j-s,-mtune=strongarm)
> > +tune-$(CONFIG_CPU_V6K)		:=$(call cc-option,-mtune=arm1136j-s,-mtune=strongarm)
> 
> Can we change the tune target to 1176 for v6k?

At first glance, GCC doesn't seem to do anything different for 1136 vs
1176:

ARM_CORE("arm1136j-s",    arm1136js,    6J,                              FL_LDSCHED, 9e)
ARM_CORE("arm1176jz-s",   arm1176jzs,   6ZK,                             FL_LDSCHED, 9e)
ARM_CORE("mpcore",        mpcore,       6K,                              FL_LDSCHED | FL_VFPV2, 9e)

The 6J/6K are used to set the __ARM_ARCH_xx__ definition.  Everything else
between 1136 and 1176 is the same.  In fact, looking at the .md files,
switching to 1176 may make things worse:

arm1020e.md: (and (eq_attr "tune" "arm1020e,arm1022e")
arm1020e.md:  (const (if_then_else (and (eq_attr "tune" "arm1020e,arm1022e")
arm1026ejs.md: (and (eq_attr "tune" "arm1026ejs")
arm1136jfs.md: (and (eq_attr "tune" "arm1136js,arm1136jfs")
arm926ejs.md: (and (eq_attr "tune" "arm926ejs")
arm-cores.def:   If you update this table, you must update the "tune" attribute
in
arm.h:  {"tune", "%{!mcpu=*:%{!mtune=*:-mtune=%(VALUE)}}" }, \
arm.md:          (eq_attr "tune" "arm926ejs,arm1020e,arm1026ejs,arm1136js,arm1136jfs,cortexa8")
arm.md:        (eq_attr "tune" "!arm1020e,arm1022e,cortexa8"))
arm-tune.md:(define_attr "tune"
cortex-a8.md:  (and (eq_attr "tune" "cortexa8")
cortex-a8-neon.md:  (and (eq_attr "tune" "cortexa8")

Nothing seems to tune for arm1176, but it looks like quite a bit of work
has been put into providing gcc with a pipeline description for arm1136.

The above is from gcc 4.3.5 sources.

> >  config DMA_CACHE_RWFO
> >  	bool "Enable read/write for ownership DMA cache maintenance"
> > -	depends on CPU_V6 && SMP
> > +	depends on (CPU_V6 || CPU_V6K) && SMP
> >  	default y
> >  	help
> >  	  The Snoop Control Unit on ARM11MPCore does not detect the
> 
> Can we lose the CPU_V6 check here? RWFO is only required for 11MPCore
> so I think we just need to check CPU_V6K && SMP.

I'd rather not in this patch - this patch adds CPU_V6K as an alias for
CPU_V6 - so eveywhere which referenced CPU_V6 becomes (CPU_V6 || CPU_V6K).
We could remove it in a later patch though.
