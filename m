From: "Rajendra Nayak" <rnayak@ti.com>
Subject: RE: [PATCH 00/05] OMAP3: CPUidle driver
Date: Fri, 10 Oct 2008 09:14:12 +0530
Message-ID: <00dc01c92a8a$778b96a0$LocalHost@wipultra1382>
References: <87prm9ucei.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47235 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751539AbYJJDoY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Oct 2008 23:44:24 -0400
In-Reply-To: <87prm9ucei.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: 'Kevin Hilman' <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com] 
> Sent: Thursday, October 09, 2008 6:57 PM
> To: Rajendra Nayak
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH 00/05] OMAP3: CPUidle driver
> 
> "Rajendra Nayak" <rnayak@ti.com> writes:
> 
> > This patch set implements Cpuidle driver for OMAP3 platforms. It is
> > validated on the 3430SDP (using the omap_3430sdp_min_defconfig) and
> > applies on the pm-20081006 branch.
> 
> Excellent.  Thank you.  I'll pull into pm-20081006 today.
> 
> One question: You have C6 to hit chip-off, but it is never enabled.
> Has this been tested?  Enabling it allows me to hit chip OFF, but it
> never comes back from OFF-mode.  I will push some patches to make this
> work with /sys/power/enable_off_mode.

Yes, that was something I missed out in those patches. I will send in a patch
to do that if you have'nt done it already.

> 
> Some minor problems that I will fixup when rebasing to the next pm
> branch:
> 
>  - You removed C0, but all the comments still refer to it
>  - /sys/power/enable_off_mode doesn't affect off-mode states
>    in CPUidle
> 
> patch 1:
>  - I still don't like the #ifdefs for the init sequence.
> 
> patch 2:
>  - checkpatch warning

That was for an extern in a C file (cpuidle34xx.c) and I was'nt sure which 
header was the right place for it (since now we don't have a cpuidle34xx.h).
So I kind of left it there.

> 
> Kevin
> 
> > The following C states are defined and used 
> >
> >  *      C0 . System executing code (Not an idle state)
> >  *      C1 . MPU WFI + Core active
> >  *      C2 . MPU CSWR + Core active
> >  *      C3 . MPU OFF + Core active
> >  *      C4 . MPU CSWR + Core CSWR
> >  *      C5 . MPU OFF + Core CSWR
> >  *      C6 . MPU OFF + Core OFF
> >
> > CPUidle support is not enabled by default in any of the 
> defconfigs and hence has to enabled seperately 
> > if you plan to test these patches.
> >
> > CPUIdle ---> [*] CPU idle PM support
> >
> > regards,
> > Rajendra
> 
> 

