From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 00/11] ARM: OMAP: OMAP5 & AM43x DSS
Date: Mon, 12 May 2014 08:48:51 -0700
Message-ID: <20140512154850.GG31772@atomide.com>
References: <1399636579-8062-1-git-send-email-tomi.valkeinen@ti.com>
 <5370CBD5.3060107@ti.com>
 <20140512143604.GB31772@atomide.com>
 <5370E172.20009@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:12765 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751000AbaELPs6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 May 2014 11:48:58 -0400
Content-Disposition: inline
In-Reply-To: <5370E172.20009@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Paul Walmsley <paul@pwsan.com>, Archit Taneja <archit@ti.com>, Tero Kristo <t-kristo@ti.com>

* Tomi Valkeinen <tomi.valkeinen@ti.com> [140512 07:58]:
> On 12/05/14 17:36, Tony Lindgren wrote:
> > * Tomi Valkeinen <tomi.valkeinen@ti.com> [140512 06:26]:
> >> Hi Tony,
> >>
> >> On 09/05/14 14:56, Tomi Valkeinen wrote:
> >>> Hi,
> >>>
> >>> Here are arch/arm/ patches to add display support for OMAP5 and AM43x.
> >>>
> >>> I have these in my tree, in a branch I will send to Tony for merging. Most of
> >>> these patches have already been around the lists, but I wanted to send them one
> >>> more time to verify that all looks right and everybody is fine with them.
> >>
> >> I have pushed these to:
> >>
> >> git://git.kernel.org/pub/scm/linux/kernel/git/tomba/linux.git 3.16/omap
> >>
> >> If you're fine with these, I think we can consider that branch stable.
> >> There are probably still a few display related .dts changed for the
> >> board coming up, but I'll add those on top of the current commits.
> > 
> > Please coordinate things with Paul and Tero so you at least have proper
> > acks for the hwmod and and clock patches. In general we really want to
> > queue hwmod and clock changes separately as those can easily mess up things
> > in a bad way like we've already seen with overlapping hwmod entries in
> > the .dts files.
> 
> Ok. I'm fine with splitting the series if that's easiest way to manage it.
> 
> Paul, Tero?
> 
> > Also, I'm wondering why we still have .clk and .opt_clks entries in the
> > hwmod data for am43xx and omap5 which are both device tree based with
> > all the clocks coming from .dts files?
> 
> I think they are needed for the omap_device/hwmod stuff to work. Only
> omapdss driver knows about the clocks defined in the .dts files, and the
> omap_device/hwmod code still needs to do the reset and maybe some other
> tasks that require the clocks.

We're already populating the hwmod data from dts entries, that's done by
omap_device_build_from_dt. Why aren't we doing that for dt defined clocks?

I'd rather not start adding new data that will then just be removed, that's
what people call "pointless extra churn".

Regards,

Tony
