From: Tony Lindgren <tony@atomide.com>
Subject: Re: ARM errata 430973 on multi platform kernels
Date: Tue, 7 Apr 2015 08:44:05 -0700
Message-ID: <20150407154404.GN18048@atomide.com>
References: <5520E2EE.4080302@gmail.com>
 <CAALWOA_-RkkgvrxZ32U6WFAZ4Wo5hkkaeo9VNBq48JwMVvkMvw@mail.gmail.com>
 <5521A438.1070008@gmail.com>
 <CAALWOA_0r1syy4nPBOvf1evhd5_oX=LWjdZAsQGAoGk8OoXTwg@mail.gmail.com>
 <20150406151939.GG18048@atomide.com>
 <20150406154037.GI18048@atomide.com>
 <5522BEEF.2000405@gmail.com>
 <20150406174245.GJ18048@atomide.com>
 <20150407135713.GL4027@n2100.arm.linux.org.uk>
 <20150407152207.GM18048@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:42625 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753414AbbDGPrs (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 7 Apr 2015 11:47:48 -0400
Content-Disposition: inline
In-Reply-To: <20150407152207.GM18048@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Pavel Machek <pavel@ucw.cz>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Matthijs van Duin <matthijsvanduin@gmail.com>

* Tony Lindgren <tony@atomide.com> [150407 08:27]:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [150407 06:58]:
> > 
> > Well, one thing we can do is to tweak the proc-v7*.S such that we detect
> > Cortex-A8 separately, and only execute the BTB flush for CA8 processors
> > if the errata is enabled.  Something like this (untested):
> > 
> > --- a/arch/arm/mm/proc-v7.S
> > +++ b/arch/arm/mm/proc-v7.S
> > @@ -527,6 +545,16 @@ __v7_ca9mp_proc_info:
> >  	__v7_proc __v7_ca9mp_proc_info, __v7_ca9mp_setup, proc_fns = ca9mp_processor_functions
> >  	.size	__v7_ca9mp_proc_info, . - __v7_ca9mp_proc_info
> >  
> > +	/*
> > +	 * ARM Ltd. Cortex A8 processor.
> > +	 */
> > +	.type	__v7_ca8_proc_info, #object
> > +__v7_ca8_proc_info:
> > +	.long	0x410fc080
> > +	.long	0xff0ffff0
> > +	__v7_proc __v7_ca8mp_proc_info, proc_fns = ca8_processor_functions
> > +	.size	__v7_ca8_proc_info, . - __v7_ca8_proc_info
> > +
> >  #endif	/* CONFIG_ARM_LPAE */
> >  
> >  	/*
> 
> Works for me. The above needs the following fix folded in to build:
> 
> --- a/arch/arm/mm/proc-v7.S
> +++ b/arch/arm/mm/proc-v7.S
> @@ -532,7 +532,7 @@ __v7_ca9mp_proc_info:
>  __v7_ca8_proc_info:
>  	.long	0x410fc080
>  	.long	0xff0ffff0
> -	__v7_proc __v7_ca8mp_proc_info, proc_fns = ca8_processor_functions
> +	__v7_proc __v7_ca8_proc_info, __v7_setup, proc_fns = ca8_processor_functions
>  	.size	__v7_ca8_proc_info, . - __v7_ca8_proc_info
>  
>  #endif	/* CONFIG_ARM_LPAE */

And then on top of that patch, we can fix the sefaulting issues with the
following, what do you guys think?

Regards,

Tony

8< --------------------
From: Tony Lindgren <tony@atomide.com>
Date: Tue, 7 Apr 2015 07:52:39 -0700
Subject: [PATCH] ARM: mm: Fix Cortex-A8 erratum 430973 segfaults for bootloaders and multiarch

Looks like apps can be made to segfault easily on armhf distros
just by running cpuburn-a8 in the background, then starting apt
get update unless erratum 430973 workaround is enabled. This happens
on r3p2 also, which has 430973 fixed in hardware.

Turns out the reason for this is some bootloaders incorrectly
setting the auxilary register IBE bit, which probably causes us
to hit erratum 687067 on Cortex-A8 later than r1p2.

Now that Cortex-A8 has it's own cpu_ca8_switch_mm, we can fix these
issues:

1. If the bootloader incorrectly sets the IBE bit in the auxilary
   control register for Cortex-A8 revisions with 430973 fixed
   in hardware, we need to call flush BTAC/BTB to avoid segfaults
   probably caused by erratum 687067. So let's flush BTAC/BTB
   unconditionally for Cortex-A8. It won't do anything unless the
   IBE bit is set.

2. We can and should now keep 430973 enabled for multiarch builds
   as it no longer causes issues with Cortex-A9 as we have a separate
   cpu_ca8_switch_mm.

Note that SoCs probably should also add checks and print warnings
for the misconfigured IBE bit depending on the Cortex-A8 revision
so the bootloaders can be fixed Cortex-A8 revisions later than
r1p2 to not set the IBE bit.

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/mm/proc-v7-2level.S
+++ b/arch/arm/mm/proc-v7-2level.S
@@ -36,14 +36,16 @@
  *
  *	It is assumed that:
  *	- we are not using split page tables
+ *
+ *	Note that we always need to flush BTAC/BTB if IBE is set
+ *	even on Cortex-A8 revisions not affected by 430973.
+ *	If IBE is not set, the flush BTAC/BTB won't do anything.
  */
 ENTRY(cpu_ca8_switch_mm)
 #ifdef CONFIG_MMU
 	mov	r2, #0
-#ifdef CONFIG_ARM_ERRATA_430973
 	mcr	p15, 0, r2, c7, c5, 6		@ flush BTAC/BTB
 #endif
-#endif
 ENTRY(cpu_v7_switch_mm)
 #ifdef CONFIG_MMU
 	mmid	r1, r1				@ get mm->context.id
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -352,7 +352,7 @@ __v7_setup:
 	ldr	r10, =0x00000c08		@ Cortex-A8 primary part number
 	teq	r0, r10
 	bne	2f
-#if defined(CONFIG_ARM_ERRATA_430973) && !defined(CONFIG_ARCH_MULTIPLATFORM)
+#if defined(CONFIG_ARM_ERRATA_430973)
 
 	teq	r5, #0x00100000			@ only present in r1p*
 	mrceq	p15, 0, r10, c1, c0, 1		@ read aux control register
