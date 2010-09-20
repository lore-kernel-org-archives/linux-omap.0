From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v6 0/7] OMAP: WDT: Implement WDT in hwmod way
Date: Mon, 20 Sep 2010 10:16:53 -0700
Message-ID: <20100920171653.GE4611@atomide.com>
References: <1284733136-20952-1-git-send-email-charu@ti.com>
 <20100917172215.GE29610@atomide.com>
 <87mxrguhhf.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:59372 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753697Ab0ITRQz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Sep 2010 13:16:55 -0400
Content-Disposition: inline
In-Reply-To: <87mxrguhhf.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Varadarajan, Charulatha" <charu@ti.com>, wim@iguana.be, linux-watchdog@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com, rnayak@ti.com, p-basak2@ti.com, linux-omap@vger.kernel.org

* Kevin Hilman <khilman@deeprootsystems.com> [100917 15:26]:
> Tony Lindgren <tony@atomide.com> writes:
> 
> > * Varadarajan, Charulatha <charu@ti.com> [100917 07:11]:
> >> Series of patches to port watchdog module to use hwmod APIs
> >> for OMAP2PLUS chips and use runtime APIs for all OMAP chips.
> >> For this hwmod database for OMAP2PLUS watchdog instances are
> >> populated. This patch series also implements watchdog
> >> module to use PM runtime APIs.
> >> 
> >> This patch series is created on "origin/pm-core" and is
> >> tested on OMAP2430, OMAP44430, OMAP3430 SDP boards and zoom3 board.
> >> Also verified that this patch series does not break the OMAP1 build.
> >> 
> >> This series is tested on OMAP4430 ES2 using the below series
> >> http://www.spinics.net/lists/linux-omap/msg36023.html
> >
> > Can you please list the exact dependencies to other patches
> > for the mainline kernel? Are they the same as for the
> > omap serial driver just posted?
> 
> Hi Tony,
> 
> This series is based on my pm-core branch which is basically the the
> stuff I have submitted upstream (my pm-next series, the runtime PM core)
> and a collection of hwmod fixes that Paul/Benoit have lined up
> for 2.6.37.

OK thanks for the summary.

So let's get all the dependencies out of the way and pull them into linux-omap
master branch for testing. Sounds like we should base this on Paul's core
hwmod branch and your pm-next.

Then for the runtime PM core, let's just keep merging them from Greg's
queue into l-o master until they are merged to the mainline tree.

I assume that the runtime PM core patches are the ones at [1] below?

> I will gladly queue these hwmod conversion patches in my tree if you
> prefer since I am already managing all the dependencies.

Yes, once we have dependencies queued up, then let's pull these
in, at least for testing.

For merging some hwdmod drivers to mainline, do we have all the
necessary acks from the driver maintainers?

Regards,

Tony

[1] http://ftp.litnet.lt/pub/linux/kernel/people/gregkh/gregkh-2.6/gregkh-05-driver-core/
