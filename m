From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [RFC 0/4] OMAP Cpuidle/Suspend Cleanups
Date: Fri, 20 Jul 2012 11:59:33 +0300
Message-ID: <1342774773.4672.187.camel@sokoban>
References: <1342764284-8143-1-git-send-email-rnayak@ti.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45594 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753181Ab2GTJAH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Jul 2012 05:00:07 -0400
In-Reply-To: <1342764284-8143-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, paul@pwsan.com, khilman@ti.com, b-cousson@ti.com, santosh.shilimkar@ti.com

On Fri, 2012-07-20 at 11:34 +0530, Rajendra Nayak wrote:
> Hi,
> 
> Here are some CPUidle/Suspend cleanup patches done by adding
> some more functionality in the OMAP Powerdomain framework.
> They mostly cleanup OMAP3 but the same ideas can be used/
> applied for OMAP4 and beyond.
> 
> The series is based off Teros' series [1] to add usecounting
> support within the OMAP Powerdomain framework.
> 
> The patches are tested with RET/OFF in CPUidle and Suspend
> on 3630 beagle Xm and 3430 SDP.

This set looks good to me, just requires careful testing that you don't
break anything as you are moving lots of stuff around. For debugging
purposes (maybe also permanently?), it might be good to keep some sort
of failsafe mechanism in place that prevents actual core / per off
transitions in case there is a problem with the usecounting, and you
accidentally hit core / per off even though the usecounting doesn't
expect it (some autoidle mechanism is overlooked for example.)

Maybe add some caching for the programmed next state, and only program
the HW register once we get to the callbacks, and restore the next state
to ON after leaving...? This should get rid of any unexpected hangs.

-Tero

> 
> regards,
> Rajendra
> 
> [1] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg72163.html
> 
> Rajendra Nayak (4):
>   ARM: OMAP3: cpuidle: Remove unused MPU OSWR support code
>   ARM: OMAP: PM: Get rid of Powerdomain book-keeping from cpuidle
>   ARM: OMAP: powerdomain: Add .power_on/.power_down hooks for
>     powerdomains
>   ARM: OMAP3: PM: Use .power_on/.power_down to clean omap_sram_idle
> 
>  arch/arm/mach-omap2/omap-mpuss-lowpower.c |    4 +-
>  arch/arm/mach-omap2/pm34xx.c              |  158 ++++++++++++++---------------
>  arch/arm/mach-omap2/powerdomain.c         |   40 ++++----
>  arch/arm/mach-omap2/powerdomain.h         |    8 +-
>  arch/arm/mach-omap2/sleep34xx.S           |    4 +-
>  5 files changed, 104 insertions(+), 110 deletions(-)
> 


