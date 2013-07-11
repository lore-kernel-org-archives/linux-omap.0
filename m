From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: twl-common: Remove code for twl6030 and
 twl6040 setup for legacy boot
Date: Thu, 11 Jul 2013 11:35:03 -0500
Message-ID: <20130711163503.GA6611@kahuna>
References: <1373552638-13930-1-git-send-email-peter.ujfalusi@ti.com>
 <20130711145916.GA6138@kahuna>
 <51DED333.9080609@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50241 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751999Ab3GKQfa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 11 Jul 2013 12:35:30 -0400
Content-Disposition: inline
In-Reply-To: <51DED333.9080609@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 17:45-20130711, Peter Ujfalusi wrote:
> On 07/11/2013 04:59 PM, Nishanth Menon wrote:
> > On 16:23-20130711, Peter Ujfalusi wrote:
> >> OMAP4 no longer boots in legacy mode so the code here is no longer used.
> >>
> >> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> >> ---
> >>  arch/arm/mach-omap2/twl-common.c | 332 ++-------------------------------------
> >>  arch/arm/mach-omap2/twl-common.h |   8 -
> >>  2 files changed, 12 insertions(+), 328 deletions(-)
> > Could we modify the Makefile and build twl-common.o only for
> > CONFIG_ARCH_OMAP3?
> > 
> > We could get rid of all the #ifdef from the code that way. OMAP3 is the
> > only platform that still depends on this - Further, with this change,
> 
> Yep, I can do that. I'll send a separate patch to do this.
> 
> > commit 34a38440689b06a515104d668494e0ff8a4e1537
> > (regulator: twl6030: add support for vdd1, vdd2 and vdd3 regulators)
> > will need a relook as well. currently part of the discussion with Mark
> > in [1]
> > 
> > [1] http://marc.info/?t=137185016300003&r=1&w=2
> 
> I don't see anything touching twl-common.c/h in the series.
> But at the end we should get rid of the legacy support in all of the drivers
> aimed for OMAP4+ gradually since it is pointless to keep dead code. Emphasis
> on gradually ;)
right - now that we removed the set_voltage/get_voltage custom code,
there are no longer any way the code introduced in the commit can be
exercised.

-- 
Regards,
Nishanth Menon
