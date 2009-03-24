From: Peter Barada <peterb@logicpd.com>
Subject: Re: PM branch rebased to 2.6.29
Date: Tue, 24 Mar 2009 16:37:55 -0400
Message-ID: <1237927075.23022.136.camel@blackhole>
References: <87bprz9zju.fsf@deeprootsystems.com>
	 <1237914611.23022.124.camel@blackhole> <87zlfaztcd.fsf@deeprootsystems.com>
	 <1237925484.23022.133.camel@blackhole>
	 <49C940CA.9070805@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.logicpd.com ([66.162.60.3]:38757 "EHLO smtp.logicpd.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1761072AbZCXUiB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Mar 2009 16:38:01 -0400
In-Reply-To: <49C940CA.9070805@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

On Tue, 2009-03-24 at 13:21 -0700, Kevin Hilman wrote:
> Peter Barada wrote:
> > On Tue, 2009-03-24 at 11:08 -0700, Kevin Hilman wrote:
> >> Peter Barada <peterb@logicpd.com> writes:
> >>
> >>> On Tue, 2009-03-17 at 22:21 -0700, Kevin Hilman wrote:
> >>>> FYI... 
> >>>>
> >>>> The PM branch has now been rebased to today's linux-omap HEAD which is
> >>>> based on v2.6.29-rc8.  The previous PM branch has been renamed to
> >>>> pm-2.6.28.  Depending on when you look, Tony's linux-omap tree may not
> >>>> (yet) have the latest PM branch.  If not, you can use my PM tree[1]
> >>>> directly.  Also, pm-2.6.28 will only be available on my tree.
> >>>>
> >>>> Tested on OMAP3 Beagle and RX51 and was able to hit RET and OFF in
> >>>> suspend and in PM idle with minimal kernel.  No testing yet done for
> >>>> CPUidle or DVFS.  Please test on your hardware and submit results to
> >>>> the list.  Thanks.
> >>> Kevin,  did you build/test with
> >>> the /arc/arm/config/omap3_beagle_defconfig, and
> >>> arc/arm/configs/rx51_defconfig or some other config(could you send it to
> >>> me if it isn't in the PM tree)?  
> >> I started with the ones in the tree, but I disable most of the drivers
> >> and turn on some debugging features.  Attached is the one I used for
> >> beagle.
> >> [...]
> > 
> > Hmm, I modified your config to add smc911x support so I can have an
> > nfsroot, added selector/code for my board(based on omap3beagle.c) and
> > brought it up on my hardware, but I'm not sure if its working correctly.
> > It does look to pause in the suspend sate, and comes out when I hit a
> > key on the console, but the messages don't look quite right as
> > core_pwrdm and per_pwrdm state they didn't go into state 1 (full log
> > attached):
> > 
> > omap3530# echo mem > /sys/power/state
> > PM: Syncing filesystems ... done.
> > PM: Preparing system for mem sleep
> > Freezing user space processes ... (elapsed 0.00 seconds) done.
> > Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done.
> > PM: Entering mem sleep
> > Powerdomain (core_pwrdm) didn't enter target state 1
> > Powerdomain (per_pwrdm) didn't enter target state 1
> > Could not enter target state in pm_suspend
> > eth0: smc911x_reset timeout waiting for PM restore
> > 
> > eth0: link down
> > PM: Finishing wakeup.
> > Restarting tasks ... done.
> > omap3530# 
> > omap3530# eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
> > 
> > 
> > Is this expected?
> > 
> 
> Yes, you haven't allowed the UART clocks to go off during idle/suspend 
> and there are UARTs in both CORE and PER.
> 
> Try this before going into suspend:
> 
>    echo 1 > /sys/power/clocks_off_while_idle
> 
> This will allow UART clocks to be disabled on suspend, and also allow 
> them to be disabled after 5 seconds of UART inactivity allowing 
> retention in idle as well.

that Fixed PER, but CORE still says it couldn't go into state 1:

omap3530# echo 1 > /sys/power/clocks_off_while_idle
omap3530# echo mem > /sys/power/state
PM: Syncing filesystems ... done.
PM: Preparing system for mem sleep
Freezing user space processes ... (elapsed 0.00 seconds) done.
Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done.
PM: Entering mem sleep
Powerdomain (core_pwrdm) didn't enter target state 1
Could not enter target state in pm_suspend
eth0: smc911x_reset timeout waiting for PM restore
eth0: link down
PM: Finishing wakeup.
Restarting tasks ... done.
omap3530# eth0: link up, 100Mbps, full-duplex, lpa 0x45E1


> 
> Kevin
-- 
Peter Barada <peterb@logicpd.com>
