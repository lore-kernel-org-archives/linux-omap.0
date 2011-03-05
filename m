From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: pm-core: recursive dependency on config
Date: Sat, 5 Mar 2011 09:57:47 +0000
Message-ID: <20110305095747.GA2400@n2100.arm.linux.org.uk>
References: <AANLkTi=wNSOmZ8TcWGUoPmdaC5ga9NrzsXhULnUxLMGk@mail.gmail.com> <ea74188f9e010d45c0c8ba15ab6b2617@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:57877 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751140Ab1CEJ56 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 5 Mar 2011 04:57:58 -0500
Content-Disposition: inline
In-Reply-To: <ea74188f9e010d45c0c8ba15ab6b2617@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Nishanth Menon <nm@ti.com>, linux-omap <linux-omap@vger.kernel.org>

On Sat, Mar 05, 2011 at 02:11:29PM +0530, Santosh Shilimkar wrote:
> + Russell,
> 
> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > owner@vger.kernel.org] On Behalf Of Menon, Nishanth
> > Sent: Saturday, March 05, 2011 1:51 PM
> > To: linux-omap
> > Subject: pm-core: recursive dependency on config
> >
> > Folks,
> > Dumb question:
> > Some one seen this one? is there a patch in the pipe for the fix?
> >
> > scripts/kconfig/conf --silentoldconfig Kconfig
> > arch/arm/Kconfig:1277:error: recursive dependency detected!
> > arch/arm/Kconfig:1277:	symbol SMP depends on CPU_V6K
> > arch/arm/mm/Kconfig:407:	symbol CPU_V6K depends on SMP
> >
> I saw this one too. This is because of resent changes to
> ensure that CPU_32v6K is always enabled with SMP builds.
> 
> This is tricky dependency. May be RMK has better way to deal
> with this.
> 
> Two relevant commit on this are '85a11f52' and  '15490ef8'

What is 85a11f52 ?

15490ef8 (in mainline) is:

 config CPU_32v6K
        bool "Support ARM V6K processor extensions" if !SMP
        depends on CPU_V6 || CPU_V7
-       default y if SMP && !(ARCH_MX3 || ARCH_OMAP2)
+       default y if SMP

fbb4ddac (ARM: v6k: only allow SMP if we have v6k or v7 CPU) does this:

 config SMP
        bool "Symmetric Multi-Processing (EXPERIMENTAL)"
        depends on EXPERIMENTAL
+       depends on CPU_V6K || CPU_V7

which I assume is 85a11f52 in Tony's tree.
However, e399b1a4e (ARM: v6k: introduce CPU_V6K option) does this:

-config CPU_32v6K
-       bool "Support ARM V6K processor extensions" if !SMP
-       depends on CPU_V6 || CPU_V7
-       default y if SMP && !(ARCH_MX3 || ARCH_OMAP2)
-       help
-         Say Y here if your ARMv6 processor supports the 'K' extension.
-         This enables the kernel to use some instructions not present
-         on previous processors, and as such a kernel build with this
-         enabled will not boot on processors with do not support these
-         instructions.
+config CPU_V6K
+       bool "Support ARM V6K processor" if ARCH_INTEGRATOR || MACH_REALVIEW_EB
+       select CPU_32v6
+       select CPU_32v6K if !ARCH_OMAP2
+       select CPU_ABRT_EV6
+       select CPU_PABRT_V6
+       select CPU_CACHE_V6
+       select CPU_CACHE_VIPT
+       select CPU_CP15_MMU
+       select CPU_HAS_ASID if MMU
+       select CPU_COPY_V6 if MMU
+       select CPU_TLB_V6 if MMU

which conflicts with 15490ef8.

So I suspect that a merge conflict hasn't been resolved correctly.  I'm
not going to worry about that because I have the merge conflict resolution
here already as part of my tree.
