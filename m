From: "Rajendra Nayak" <rnayak@ti.com>
Subject: RE: [PATCH 00/05] OMAP3: CPUidle driver
Date: Fri, 10 Oct 2008 09:17:30 +0530
Message-ID: <00dd01c92a8a$ebd26f20$LocalHost@wipultra1382>
References: <87hc7lu8tc.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59720 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754198AbYJJDrj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 9 Oct 2008 23:47:39 -0400
In-Reply-To: <87hc7lu8tc.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: 'Kevin Hilman' <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Kevin Hilman
> Sent: Thursday, October 09, 2008 8:15 PM
> To: Rajendra Nayak
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH 00/05] OMAP3: CPUidle driver
> 
> Kevin Hilman <khilman@deeprootsystems.com> writes:
> 
> > "Rajendra Nayak" <rnayak@ti.com> writes:
> >
> >> This patch set implements Cpuidle driver for OMAP3 platforms. It is
> >> validated on the 3430SDP (using the omap_3430sdp_min_defconfig) and
> >> applies on the pm-20081006 branch.
> >
> > Excellent.  Thank you.  I'll pull into pm-20081006 today.
> >
> > One question: You have C6 to hit chip-off, but it is never enabled.
> > Has this been tested?  Enabling it allows me to hit chip OFF, but it
> > never comes back from OFF-mode.  I will push some patches 
> to make this
> > work with /sys/power/enable_off_mode.
> 
> I got this to work on custom HW, but not on 3430SDP.  Can you confirm
> whether or not you can use C6 on 3430SDP?  Off-in-idle without CPUidle
> seems to work, but not with CPUidle + C6.

Ok.. I'll try and fix this. I seem to have missed enabling this after all
the comment fixes that I did. Maybe I broke something.

> 
> Kevin
> 
> > Some minor problems that I will fixup when rebasing to the next pm
> > branch:
> >
> >  - You removed C0, but all the comments still refer to it
> >  - /sys/power/enable_off_mode doesn't affect off-mode states
> >    in CPUidle
> >
> > patch 1:
> >  - I still don't like the #ifdefs for the init sequence.
> >
> > patch 2:
> >  - checkpatch warning
> >
> > Kevin
> >
> >> The following C states are defined and used 
> >>
> >>  *      C0 . System executing code (Not an idle state)
> >>  *      C1 . MPU WFI + Core active
> >>  *      C2 . MPU CSWR + Core active
> >>  *      C3 . MPU OFF + Core active
> >>  *      C4 . MPU CSWR + Core CSWR
> >>  *      C5 . MPU OFF + Core CSWR
> >>  *      C6 . MPU OFF + Core OFF
> >>
> >> CPUidle support is not enabled by default in any of the 
> defconfigs and hence has to enabled seperately 
> >> if you plan to test these patches.
> >>
> >> CPUIdle ---> [*] CPU idle PM support
> >>
> >> regards,
> >> Rajendra
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

