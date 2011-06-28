From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 0/7] OMAP4: Add modulemode support to hwmod framework
 (part 2)
Date: Tue, 28 Jun 2011 11:29:57 +0300
Message-ID: <1309249797.1825.52.camel@deskari>
References: <1309192391-12410-1-git-send-email-b-cousson@ti.com>
	 <1309244182.1825.28.camel@deskari>  <4E098D59.7040108@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:54922 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757139Ab1F1IaC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 28 Jun 2011 04:30:02 -0400
Received: by mail-bw0-f42.google.com with SMTP id 19so2075745bwa.29
        for <linux-omap@vger.kernel.org>; Tue, 28 Jun 2011 01:30:00 -0700 (PDT)
In-Reply-To: <4E098D59.7040108@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "paul@pwsan.com" <paul@pwsan.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, 2011-06-28 at 10:14 +0200, Cousson, Benoit wrote:
> On 6/28/2011 8:56 AM, Valkeinen, Tomi wrote:
> > On Mon, 2011-06-27 at 18:33 +0200, Benoit Cousson wrote:
> >> Hi Paul,
> >>
> >> Here is the second part of the modulemode series.
> >> The goal here is to do the cleanup on the clock nodes and PRCM macros
> >> that are not needed anymore by the hwmod data.
> >> Some macros are still needed because of clock data. It should be removed
> >> once the clock data will be cleaned.
> >>
> >> Moreover, in order to get rid of static clkdev, omap_device is trying to
> >> create dynamically an "fck" alias if a main_clk is defined in hwmod data.
> >>
> >> As usual, because of drivers non-adapted to pm_runtime, some temp hacks
> >> are needed for both MMC and timer1.
> >> If the drivers are fixes before these series, these temp patches could be
> >> dropped.
> >>
> >> The series is based on for_3.0.1/5_hwmod_clkdm_fixes and tested
> >> on OMAP4430 ES2.1 + SDP. It should not affect OMAP2&  3, but some testing
> >> are definitively needed.
> >>
> >> The patches are available here:
> >> git://gitorious.org/omap-pm/linux.git for_3.0.1/6_hwmod_modulemode
> >
> > I tested the branch on Blaze, but DSS doesn't work as the clock aliases
> > have changed, leading to crash. And as only OMAP4 clocks/hwmods were
> > changed, this makes me believe OMAP2/3 DSS would still work.
> 
> Mmm, so what alias are you using today? The one from the opt_clock role?
> In theory, that main_clock should be named "fck" and the secondary or 
> optional clocks will have the name from the role.

You can see the clocks from drivers/video/dss/dss.c:dss_get_clocks(). It
currently gets these via the clkdev aliases:

- ick
- fck
- sys_clk
- tv_clk
- video_clk

> > I think the OMAP2/3/4 changes need to be done in sync, and at the same
> > time keeping the peripherals working.
> 
> Sure, but first we need to figure out what will be the proper clock alias.

My current pm_runtime patch set removes the omapdss clock aliases from
arch/arm/mach-omap2/clock44xx_data.c, as the driver uses the opt-clock
names. Isn't that correct way?

The opt-clocks that my patch set gets are:

- dss_clk
- sys_clk
- hdmi_clk
- rfbi_iclk
- tv_clk
- tv_dac_clk

Additionally these are used to configure the clk rates:
- dpll4_m4_ck
- dpll_per_m5x2_ck

The "dss_clk" opt-clock is a bit of an odd-ball. The same clock is used
as a main-clk and an opt-clock. The driver uses the clock to change the
clock rates. If the driver can get the main-clock with some built-in
alias, like "fck", then this opt-clock is not needed. But I wasn't aware
of such a method.

You can see how the are setup in the following patches:

  OMAP4: HWMOD: Modify DSS opt clocks
  OMAP3: HWMOD: Add DSS opt clocks
  OMAP2420: HWMOD: Add DSS opt clocks
  OMAP2430: HWMOD: Add DSS opt clocks

Then, after the main runtime PM patch, there's a small cleanup:

  OMAP4: HWMOD: Remove unneeded DSS opt clocks
  OMAP4: CLKDEV: Remove omapdss clock aliases

 Tomi


