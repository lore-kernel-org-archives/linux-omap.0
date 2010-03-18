From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] arm: Fix mounting root on omaps with CPU_V6 and CPU_V7
Date: Thu, 18 Mar 2010 10:00:22 -0700
Message-ID: <20100318170021.GN2900@atomide.com>
References: <20100317175731.GE2900@atomide.com>
 <1268849278.19565.28.camel@e102109-lin.cambridge.arm.com>
 <20100317191114.GH2900@atomide.com>
 <1268910826.15334.32.camel@e102109-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:52978 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750945Ab0CRQ6y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Mar 2010 12:58:54 -0400
Content-Disposition: inline
In-Reply-To: <1268910826.15334.32.camel@e102109-lin.cambridge.arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Catalin Marinas <catalin.marinas@arm.com> [100318 04:10]:
> On Wed, 2010-03-17 at 19:11 +0000, Tony Lindgren wrote:
> > * Catalin Marinas <catalin.marinas@arm.com> [100317 11:04]:
> > > On Wed, 2010-03-17 at 17:57 +0000, Tony Lindgren wrote:
> > > > Here's an updated version of this patch with more details.
> > > >
> > > > Looks like VFPv3 is only available on V7:
> > > >
> > > > http://www.arm.com/products/processors/technologies/vector-floating-point.php
> > >
> > > But does it cause any problem if the feature is enabled in the kernel?
> > > The vfp_init() code should check for its presence and set the hwcap
> > > accordingly.
> > 
> > Yeah, it causes the problem posted in the patch description. I took a
> > quick look at it and at least the VFPFMRX in vfpmacros.h for CONFIG_VFPv3
> > is a problem.
> 
> This would indeed need more checking to avoid reading some registers
> which aren't present on ARMv6.
> 
> I think the main problem with just falling back to VFPv2 is the lack of
> NEON support even if the CPU supports it.

Yeah it would be nice to have things also working in a reasonably fast
and usable way for distros etc.
 
> > Also I think we would need to have separate vfp_get_double functions
> > in vfphw.S for VFPv2 and 3 that get used based on the features.
> 
> I don't think that's causing problems (or at least we can identify where
> the function gets called for higher VFP registers). Even with VFPv3, you
> may not have the D16-D31 registers.

OK. There's also an ifdef else define for VFP_REG_ZERO in vfp.h. Sounds
like that test would also need to be done dynamically.
 
> > > > HAS_TLS reg is only on ARM11 starting with r1p0:
> > > >
> > > > http://infocenter.arm.com/help/topic/com.arm.doc.ddi0211k/Babeihid.html
> > > >
> > > > So that explains why it won't work on omap2420 as it's r0p2.
> > >
> > > Same here, would it work with dynamic detection?
> > 
> > Hmm I believe here the problem is __switch_to in entry-armv.S.
> > I don't think we want to dynamically test it every time.. Or
> > at least it would have to be optimized out in most cases.
> 
> But if you disable this, you won't be able to use an SMP build on both
> v6 and v7. Anyway, I don't think that dynamically checking this would
> introduce performance penalties, the __switch_to code is pretty complex
> already with all the notifier calls.

OK. I'll take a look at setting the TLS a HWCAP flag.
 
> We may also have optimised user space that reads the TLS register
> directly rather than going through the kuser helper, in which case we
> would need a kernel built only for ARMv7 (maybe that's acceptable in
> this situation).

Sounds like more of a hassle to me :)

Tony
