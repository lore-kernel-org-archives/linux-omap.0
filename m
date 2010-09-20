From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v6 0/7] OMAP: WDT: Implement WDT in hwmod way
Date: Mon, 20 Sep 2010 13:48:51 -0700
Message-ID: <87sk14rvik.fsf@deeprootsystems.com>
References: <1284733136-20952-1-git-send-email-charu@ti.com>
	<20100917172215.GE29610@atomide.com>
	<87mxrguhhf.fsf@deeprootsystems.com>
	<20100920171653.GE4611@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:49820 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754833Ab0ITUsx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Sep 2010 16:48:53 -0400
In-Reply-To: <20100920171653.GE4611@atomide.com> (Tony Lindgren's message of
	"Mon, 20 Sep 2010 10:16:53 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Varadarajan, Charulatha" <charu@ti.com>, wim@iguana.be, linux-watchdog@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com, rnayak@ti.com, p-basak2@ti.com, linux-omap@vger.kernel.org

Tony Lindgren <tony@atomide.com> writes:

> * Kevin Hilman <khilman@deeprootsystems.com> [100917 15:26]:
>> Tony Lindgren <tony@atomide.com> writes:
>> 
>> > * Varadarajan, Charulatha <charu@ti.com> [100917 07:11]:
>> >> Series of patches to port watchdog module to use hwmod APIs
>> >> for OMAP2PLUS chips and use runtime APIs for all OMAP chips.
>> >> For this hwmod database for OMAP2PLUS watchdog instances are
>> >> populated. This patch series also implements watchdog
>> >> module to use PM runtime APIs.
>> >> 
>> >> This patch series is created on "origin/pm-core" and is
>> >> tested on OMAP2430, OMAP44430, OMAP3430 SDP boards and zoom3 board.
>> >> Also verified that this patch series does not break the OMAP1 build.
>> >> 
>> >> This series is tested on OMAP4430 ES2 using the below series
>> >> http://www.spinics.net/lists/linux-omap/msg36023.html
>> >
>> > Can you please list the exact dependencies to other patches
>> > for the mainline kernel? Are they the same as for the
>> > omap serial driver just posted?
>> 
>> Hi Tony,
>> 
>> This series is based on my pm-core branch which is basically the the
>> stuff I have submitted upstream (my pm-next series, the runtime PM core)
>> and a collection of hwmod fixes that Paul/Benoit have lined up
>> for 2.6.37.
>
> OK thanks for the summary.
>
> So let's get all the dependencies out of the way and pull them into linux-omap
> master branch for testing. Sounds like we should base this on Paul's core
> hwmod branch and your pm-next.

Yes, those two branches are required as the bare minimum.

> Then for the runtime PM core, let's just keep merging them from Greg's
> queue into l-o master until they are merged to the mainline tree.
>
> I assume that the runtime PM core patches are the ones at [1] below?

I should've said runtime PM core for OMAP, by which I mean:

   http://marc.info/?l=linux-omap&m=128459521813724&w=2

That series has a dependency on only one of the patches from Greg's
queue you mentioned. Specifically, the one from me:

   driver core: platform_bus: allow runtime override of dev_pm_ops

which I also have in my pm-backports branch.

>> I will gladly queue these hwmod conversion patches in my tree if you
>> prefer since I am already managing all the dependencies.
>
> Yes, once we have dependencies queued up, then let's pull these
> in, at least for testing.
>
> For merging some hwdmod drivers to mainline, do we have all the
> necessary acks from the driver maintainers?

The only one that's currently ready is watchdog, and for that one I have
an Ack from Wim to merge this via linux-omap.

For the others that are close (UART, GPIO, i2c) I've asked that the next
versions of those be posted to LAKML as well as the subsystem lists.
>From there, I will ask the subsystem maintainers for an ack so we can
merge them via linux-omap along with all the platform changes.

Kevin
