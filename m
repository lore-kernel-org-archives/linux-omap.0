From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] arm: Fix mounting root on omaps with CPU_V6 and CPU_V7
Date: Wed, 17 Mar 2010 12:11:14 -0700
Message-ID: <20100317191114.GH2900@atomide.com>
References: <20100317175731.GE2900@atomide.com>
 <1268849278.19565.28.camel@e102109-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:59877 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753026Ab0CQTJq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Mar 2010 15:09:46 -0400
Content-Disposition: inline
In-Reply-To: <1268849278.19565.28.camel@e102109-lin.cambridge.arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Catalin Marinas <catalin.marinas@arm.com> [100317 11:04]:
> On Wed, 2010-03-17 at 17:57 +0000, Tony Lindgren wrote:
> > Here's an updated version of this patch with more details.
> > 
> > Looks like VFPv3 is only available on V7:
> > 
> > http://www.arm.com/products/processors/technologies/vector-floating-point.php
> 
> But does it cause any problem if the feature is enabled in the kernel?
> The vfp_init() code should check for its presence and set the hwcap
> accordingly.

Yeah, it causes the problem posted in the patch description. I took a
quick look at it and at least the VFPFMRX in vfpmacros.h for CONFIG_VFPv3
is a problem.

Also I think we would need to have separate vfp_get_double functions
in vfphw.S for VFPv2 and 3 that get used based on the features.
 
> Ideally, we should fix the VFP handling code to cope with dynamic
> detection.

I agree, being able to boot the same kernel and avoiding tens of
recompiles to test something is a major time saver :)
 
> > HAS_TLS reg is only on ARM11 starting with r1p0:
> > 
> > http://infocenter.arm.com/help/topic/com.arm.doc.ddi0211k/Babeihid.html
> > 
> > So that explains why it won't work on omap2420 as it's r0p2.
> 
> Same here, would it work with dynamic detection?

Hmm I believe here the problem is __switch_to in entry-armv.S.
I don't think we want to dynamically test it every time.. Or
at least it would have to be optimized out in most cases.

> I would like to get v6+v7 support working fine together on RealView
> boards as well (though not much spare time) but without disabling the
> features that are present on v7 if they can be detected at run-time.

I totally agree with you there.

Regards,

Tony
