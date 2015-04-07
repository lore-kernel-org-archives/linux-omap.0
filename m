From: Tony Lindgren <tony@atomide.com>
Subject: Re: ARM errata 430973 on multi platform kernels
Date: Mon, 6 Apr 2015 19:23:13 -0700
Message-ID: <20150407022312.GK18048@atomide.com>
References: <CAALWOA-h5SdnGhbckJ+x0efijmNaQxX-8ULjn_J=mCb-UJMeoQ@mail.gmail.com>
 <5520E2EE.4080302@gmail.com>
 <CAALWOA_-RkkgvrxZ32U6WFAZ4Wo5hkkaeo9VNBq48JwMVvkMvw@mail.gmail.com>
 <5521A438.1070008@gmail.com>
 <CAALWOA_0r1syy4nPBOvf1evhd5_oX=LWjdZAsQGAoGk8OoXTwg@mail.gmail.com>
 <20150406151939.GG18048@atomide.com>
 <20150406154037.GI18048@atomide.com>
 <5522BEEF.2000405@gmail.com>
 <20150406174245.GJ18048@atomide.com>
 <CAALWOA93+ohYJ7Q06H4gVMywzP5=RC3uBkUVXjWMriRBoHzXKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:42500 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752988AbbDGC07 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 6 Apr 2015 22:26:59 -0400
Content-Disposition: inline
In-Reply-To: <CAALWOA93+ohYJ7Q06H4gVMywzP5=RC3uBkUVXjWMriRBoHzXKQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Matthijs van Duin <matthijsvanduin@gmail.com>
Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Sebastian Reichel <sre@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>

* Matthijs van Duin <matthijsvanduin@gmail.com> [150406 11:15]:
> * Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com> [150406 10:15]:
> > Why custom function, if IBE bit is zero, BTB invalidate instruction is a
> > NOP. Do you think that "mcr p15, 0, r2, c7, c5, 6" executed as a NOP will
> > put so much overhead, that it deserves a custom function?
> 
> Executing them as nop is Cortex-A8 specific. On other ARMv7 CPUs, BTB
> invalidation on context switch may be unnecessary yet expensive.
> 
> In general I think you'll want a version with and one without BTB
> flushing, and select depending on CPUID (ID_MMFR1, bits 28-31), with
> overrides for known processor issues (i.e. the cortex-a8 has a wrong
> value there in all cases: it reports value 2, while it should be
> treated as 1 or 4 depending on cpu revision).
> 
> 
> On 6 April 2015 at 19:42, Tony Lindgren <tony@atomide.com> wrote:
> > Hmm but it still seems to do something also on cortex-a8 r3p2 that
> > is supposedly not affected by 430973.. Based on my tests so far, at least
> > armhf running cpuburn-a8 in the background and doing apt-get update
> > segfaults constantly without flush BTAC/BTB. This seems to be the case
> > no matter how the aux ctrl reg bits are set..
> 
> That sounds.... really odd.  The TRM is fairly explicit about BTB
> flush executing as nop when IBE is not set. Of course the TRM is not
> exactly flawless, but still...

Oops, sorry user error.. I was trying to clear IBE as a banked register
like L2 enable bit and of course it did not get cleared.. Clearing it
with a smc call really clears it. And in that case my test case seems to
work reliably on r3p2 without erratum 430973 enabled. 

Anyways, if the bootloader enables IBE bit, then the kernel must also
always enable the erratum 430973 flush BTAC/BTB parts on all cortex-a8.

Or else the kernel must clear the IBE bit based on the version, which
may be trickier with all the SoC and vendor specific smc calls.
 
> >> 2. For Cortex-A8 revisions affected by 430973, set IBE bit to 1, set it
> >>    to 0 for all others.
> 
> Note btw that erratum 687067 affects *all* Cortex-A8 revisions, so
> there's a bit of a catch-22 there. The proper workaround for it
> (zeroing some particular debug register) can only be done in secure
> privileged mode, and there's no straightforward way to check whether
> this has been done.
> 
> However, it only affects BTB invalidate by MVA, afaik BTB invalidate
> all is safe.

I'm now thinking the kernel should just always set the 430973 specific
cpu_v7_switch_mm for all cortex-a8 if IBE bit is set. That avoids
the whole mess of early SoC detection and smc calls. And if IBE bit
is not set, then we jsut use the rgular cpu_v7_switch_mm.

This will work as long as we can read the aux ctrl register IBE
bit using mrc, which I believe is the case for all cortex-a8 based
omap variants.
 
> >>  That should happen as soon as possible,
> >>  otherwise kernel may crash on affected revisions if thumb-compiled.
> 
> The right place to do this to be honest would be in the bootloader,
> but I guess that's not always convenient to arrange...

Yeah I agree.

Regards,

Tony
