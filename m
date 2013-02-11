From: Tony Lindgren <tony@atomide.com>
Subject: Re: Latest additional build warnings
Date: Mon, 11 Feb 2013 11:05:13 -0800
Message-ID: <20130211190513.GU4801@atomide.com>
References: <20130205142218.GB17833@n2100.arm.linux.org.uk>
 <20130209114918.GJ17852@n2100.arm.linux.org.uk>
 <20130210030032.GC4801@atomide.com>
 <CAOesGMgvEVsB7OWs43EWjgsR8af2_RZS9Dod3PURu6Tvdi4QJw@mail.gmail.com>
 <20130210032234.GE4801@atomide.com>
 <CAOesGMjQEJesfDqSHoV727=pTHjQ4CE+La2QWikG0r4gZ9iSjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:14815 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758075Ab3BKTFQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Feb 2013 14:05:16 -0500
Content-Disposition: inline
In-Reply-To: <CAOesGMjQEJesfDqSHoV727=pTHjQ4CE+La2QWikG0r4gZ9iSjA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: linux-omap@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, arm@kernel.org, linux-arm-kernel@lists.infradead.org

* Olof Johansson <olof@lixom.net> [130209 20:25]:
> On Sat, Feb 9, 2013 at 7:22 PM, Tony Lindgren <tony@atomide.com> wrote:
> > * Olof Johansson <olof@lixom.net> [130209 19:08]:
> >> On Sat, Feb 9, 2013 at 7:00 PM, Tony Lindgren <tony@atomide.com> wrote:
> >> > * Russell King - ARM Linux <linux@arm.linux.org.uk> [130209 03:53]:
> >> >> On Tue, Feb 05, 2013 at 02:22:18PM +0000, Russell King - ARM Linux wrote:
> >> >> > arch/arm/mach-omap2/hwspinlock.c:60:1: warning: data definition has no type or storage class
> >> >> > arch/arm/mach-omap2/hwspinlock.c:60:1: warning: type defaults to 'int' in declaration of 'omap_postcore_initcall'
> >> >> > arch/arm/mach-omap2/hwspinlock.c:60:1: warning: parameter names (without types) in function declaration
> >> >> > arch/arm/mach-omap2/hwspinlock.c:31:122: warning: 'hwspinlocks_init' defined but not used
> >> >>
> >> >> I'm still seeing the above in the build of Friday's merge.  I'm also
> >> >> seeing additional warnings in the randconfig similar to the above for
> >> >> arch/arm/mach-omap2/omap-iommu.c.
> >> >
> >> > Thanks for letting me know about the omap-iommu.c one. Looks like
> >> > there's also one patch for drm.c.
> >> >
> >> > Olof, if you did not yet apply the hwspinlock.c warning fix, I'll
> >> > just do a branch with all three of them for you.
> >>
> >> I haven't (must have missed it), so please just send a branch.
> >
> > OK will do. Probably you started fixing up the bad Reported-by
> > line in my patch and then got disrupted :)
> >
> > Found one more after some grepping, after the following patch they
> > should be all fixed up. Pull request coming shortly.
> 
> Oh wait -- I got confused there for a bit (this came in right as I had
> to step out for a while).
> 
> I definitely picked up the hwspinlock patch, and it's there in my
> local for-next. Looks like I missed pushing it out though. That
> explains why Russell didn't see the fix. :(
> 
> 
> So, the hwspinlock patch is already applied. The soc.h one is not, and
> I'm not sure what the third one is?

Maybe check that you have these in your multiplatform branch:

09cee18dbced86b27c6c7d4501126cf2a287d089 ARM: OMAP2+: Make sure files with omap initcalls include soc.h
b9a30021abeaf9687640c13ef8006346736dc29f ARM: OMAP2+: Include soc.h to drm.c to fix compiling
f3533403b5a8ac970f6159664d145cb88b1aa6bf ARM: OMAP2+: Fix warning for hwspinlock omap_postcore_initcall

You can cherry pick the missing ones from my omap-for-v3.9/multiplatform-fixes
branch.

Regards,

Tony
