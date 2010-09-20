From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v6 0/7] OMAP: WDT: Implement WDT in hwmod way
Date: Mon, 20 Sep 2010 13:56:30 -0700
Message-ID: <20100920205630.GJ4611@atomide.com>
References: <1284733136-20952-1-git-send-email-charu@ti.com>
 <20100917172215.GE29610@atomide.com>
 <87mxrguhhf.fsf@deeprootsystems.com>
 <20100920171653.GE4611@atomide.com>
 <87sk14rvik.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:53007 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754839Ab0ITU4d (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Sep 2010 16:56:33 -0400
Content-Disposition: inline
In-Reply-To: <87sk14rvik.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Varadarajan, Charulatha" <charu@ti.com>, wim@iguana.be, linux-watchdog@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com, rnayak@ti.com, p-basak2@ti.com, linux-omap@vger.kernel.org

* Kevin Hilman <khilman@deeprootsystems.com> [100920 13:40]:
> Tony Lindgren <tony@atomide.com> writes:
> 
> > So let's get all the dependencies out of the way and pull them into linux-omap
> > master branch for testing. Sounds like we should base this on Paul's core
> > hwmod branch and your pm-next.
> 
> Yes, those two branches are required as the bare minimum.
> 
> > Then for the runtime PM core, let's just keep merging them from Greg's
> > queue into l-o master until they are merged to the mainline tree.
> >
> > I assume that the runtime PM core patches are the ones at [1] below?
> 
> I should've said runtime PM core for OMAP, by which I mean:
> 
>    http://marc.info/?l=linux-omap&m=128459521813724&w=2

OK
 
> That series has a dependency on only one of the patches from Greg's
> queue you mentioned. Specifically, the one from me:
> 
>    driver core: platform_bus: allow runtime override of dev_pm_ops
> 
> which I also have in my pm-backports branch.

OK, I'll add that to omap-testing as well.
 
> >> I will gladly queue these hwmod conversion patches in my tree if you
> >> prefer since I am already managing all the dependencies.
> >
> > Yes, once we have dependencies queued up, then let's pull these
> > in, at least for testing.
> >
> > For merging some hwdmod drivers to mainline, do we have all the
> > necessary acks from the driver maintainers?
> 
> The only one that's currently ready is watchdog, and for that one I have
> an Ack from Wim to merge this via linux-omap.

OK
 
> For the others that are close (UART, GPIO, i2c) I've asked that the next
> versions of those be posted to LAKML as well as the subsystem lists.
> From there, I will ask the subsystem maintainers for an ack so we can
> merge them via linux-omap along with all the platform changes.

OK, well if you have something ready, we could some of those branches
into linux-omap master branch too for testing.

Regards,

Tony
