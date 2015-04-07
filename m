From: Tony Lindgren <tony@atomide.com>
Subject: Re: ARM errata 430973 on multi platform kernels
Date: Tue, 7 Apr 2015 08:22:08 -0700
Message-ID: <20150407152207.GM18048@atomide.com>
References: <CAALWOA-h5SdnGhbckJ+x0efijmNaQxX-8ULjn_J=mCb-UJMeoQ@mail.gmail.com>
 <5520E2EE.4080302@gmail.com>
 <CAALWOA_-RkkgvrxZ32U6WFAZ4Wo5hkkaeo9VNBq48JwMVvkMvw@mail.gmail.com>
 <5521A438.1070008@gmail.com>
 <CAALWOA_0r1syy4nPBOvf1evhd5_oX=LWjdZAsQGAoGk8OoXTwg@mail.gmail.com>
 <20150406151939.GG18048@atomide.com>
 <20150406154037.GI18048@atomide.com>
 <5522BEEF.2000405@gmail.com>
 <20150406174245.GJ18048@atomide.com>
 <20150407135713.GL4027@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:42617 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754546AbbDGPZw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 7 Apr 2015 11:25:52 -0400
Content-Disposition: inline
In-Reply-To: <20150407135713.GL4027@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Pavel Machek <pavel@ucw.cz>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Matthijs van Duin <matthijsvanduin@gmail.com>

* Russell King - ARM Linux <linux@arm.linux.org.uk> [150407 06:58]:
> On Mon, Apr 06, 2015 at 10:42:45AM -0700, Tony Lindgren wrote:
> > * Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com> [150406 10:15]:
> > > On  6.04.2015 18:40, Tony Lindgren wrote:
> > > >
> > > >Oops sorry, wrong numbers for errata above.. s/458693/430973/, here's
> > > >a better version:
> > > >
> > > >1. For cortex-a8 revisions affected by 430973, we can do a custom
> > > >    cpu_v7_switch_mm function that always does flush BTAC/BTB.
> > > >
> > > 
> > > Why custom function, if IBE bit is zero, BTB invalidate instruction is a
> > > NOP. Do you think that "mcr p15, 0, r2, c7, c5, 6" executed as a NOP will
> > > put so much overhead, that it deserves a custom function?
> > 
> > Hmm but it still seems to do something also on cortex-a8 r3p2 that
> > is supposedly not affected by 430973.. Based on my tests so far, at least
> > armhf running cpuburn-a8 in the background and doing apt-get update
> > segfaults constantly without flush BTAC/BTB. This seems to be the case
> > no matter how the aux ctrl reg bits are set.. This should be reproducable
> > on any pandboard xm BTW.
> >  
> > > >2. For HS cortex-a8 processors other than n900 affected by 430973,
> > > >    we need to implement functions similar to rx51_secure_update_aux_cr,
> > > >    the bootrom on n900 is different from TI HS omaps so the SMC call
> > > >    numbering may be different.
> > > >
> > > >3. For later cortex-a8 processors not affected by 430973, we need
> > > >    to clear IBE bit to avoid erratum 687067.
> > > >
> > > 
> > > Maybe it should be implemented something like:
> > > 
> > > 1. if Cortex-A8, always execute invalidate BTB instruction in
> > >    cpu_v7_switch_mm
> > 
> > This part still seems to need more investigating for why it's still
> > needed also r3p2 as I describe above. Otherwise we may be hiding some
> > other bug.
> >  
> > > 2. For Cortex-A8 revisions affected by 430973, set IBE bit to 1, set it
> > >    to 0 for all others. That should happen as soon as possible,
> > >    otherwise kernel may crash on affected revisions if thumb-
> > >    compiled.
> > 
> > Yes this makes sense.
> 
> Well, one thing we can do is to tweak the proc-v7*.S such that we detect
> Cortex-A8 separately, and only execute the BTB flush for CA8 processors
> if the errata is enabled.  Something like this (untested):
> 
> --- a/arch/arm/mm/proc-v7.S
> +++ b/arch/arm/mm/proc-v7.S
> @@ -527,6 +545,16 @@ __v7_ca9mp_proc_info:
>  	__v7_proc __v7_ca9mp_proc_info, __v7_ca9mp_setup, proc_fns = ca9mp_processor_functions
>  	.size	__v7_ca9mp_proc_info, . - __v7_ca9mp_proc_info
>  
> +	/*
> +	 * ARM Ltd. Cortex A8 processor.
> +	 */
> +	.type	__v7_ca8_proc_info, #object
> +__v7_ca8_proc_info:
> +	.long	0x410fc080
> +	.long	0xff0ffff0
> +	__v7_proc __v7_ca8mp_proc_info, proc_fns = ca8_processor_functions
> +	.size	__v7_ca8_proc_info, . - __v7_ca8_proc_info
> +
>  #endif	/* CONFIG_ARM_LPAE */
>  
>  	/*

Works for me. The above needs the following fix folded in to build:

--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -532,7 +532,7 @@ __v7_ca9mp_proc_info:
 __v7_ca8_proc_info:
 	.long	0x410fc080
 	.long	0xff0ffff0
-	__v7_proc __v7_ca8mp_proc_info, proc_fns = ca8_processor_functions
+	__v7_proc __v7_ca8_proc_info, __v7_setup, proc_fns = ca8_processor_functions
 	.size	__v7_ca8_proc_info, . - __v7_ca8_proc_info
 
 #endif	/* CONFIG_ARM_LPAE */

Regards,

Tony
