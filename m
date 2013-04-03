From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [GIT PULL] ARM: OMAP5: hwmod, prm/cm data files and updates for
 3.10
Date: Wed, 3 Apr 2013 19:42:22 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1304031146230.2616@utopia.booyaka.com>
References: <1363768852-18125-1-git-send-email-santosh.shilimkar@ti.com> <20130401170539.GK10155@atomide.com> <515BA76D.3000302@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:59048 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761638Ab3DCTmX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Apr 2013 15:42:23 -0400
In-Reply-To: <515BA76D.3000302@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Santosh

On Wed, 3 Apr 2013, Santosh Shilimkar wrote:

> Thes patchset has already missed last couple of merge windows and its the
> biggest bottleneck in getting OMAP5 booting from mainline. So I request
> you to please have a look it quickly so that Tony can line that up for
> 3.10.

Looks like there are a few minor issues with the patches based on a quick 
look.  I'll post those to the list shortly; they should be easy to fix.  
But those issues aren't my real concern with this series.

What's harder to fix are the underlying process issues.  My main concern 
is that these patches add almost 9,000 lines of code and data.  We've 
received clear guidance from the upstream ARM SoC maintainers that any 
significant new additions need to be balanced with moving a similar number 
of lines of code and data out of arch/arm/{plat-,mach-}* into drivers/.  
(Or the new patches should be accompanied with patches that show obvious 
progress towards the goal of moving code and data out of 
arch/arm/{plat-,mach-}*.)  We need to see more help from TI on the 
prerequisites for this cleanup process.

For example, as discussed last year with the TI upstream PM team, an 
important first step in this process in my view is to get rid of the 
direct PRM/CM register accesses in the OMAP PM code.  See commit 
c4ceedcb18cf7a06059482a3a1828b9aad9f78cf ("ARM: OMAP2+: CM/clock: convert 
_omap2_module_wait_ready() to use SoC-independent CM functions") as an 
example of this process.  This should make it easier to get the PRM/CM 
functionality into drivers/.  That in turn make it possible to move the 
clockdomain, clock, powerdomain, and hwmod code to drivers/.ARM: OMAP2+: 
CM/clock: convert _omap2_module_wait_ready() to use SoC-independent CM 
functions.  So far as I can tell, there hasn't been any forward progress 
on this.

It's also necessary to see more TI contributions in finding and fixing 
regressions.  Detecting and fixing regressions from the previous kernel 
release should be done first, before working on cleanup series or new 
feature/SoC additions.  Looking at the list of v3.9-rc regressions that 
I've found, we've gotten very little organized help from TI on dealing 
with them.  

This in turn robs the maintainers of time that could be spent doing patch 
review or further cleanup work, which benefits no one in the end.  
Ideally each regression would be assigned to a member of the TI upstream 
team, and the whole process could be completed within one or two weeks.

...

So from my point of view, I'd like to see the following changes before we 
accept any new patchsets that add a significant number of lines:

1. Organized help from TI in finding and fixing regressions in the -rc 
cycle, with the regressions dealt with before any new feature 
pull-requests are sent

2. Help from TI on some of the cleanup work that we've mentioned in the 
past, starting with the PRM/CM register access cleanup inside mach-omap2/

3. Pairing any large feature or SoC additions with at least an equal 
removal of lines of code


regards,

- Paul
