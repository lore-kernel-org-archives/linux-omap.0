From: Tony Lindgren <tony@atomide.com>
Subject: Re: Beagleboard xM crashes when being set to 800MHz with
 smartreflex on linux-omap-3.6-rc6
Date: Fri, 21 Sep 2012 12:16:30 -0700
Message-ID: <20120921191629.GH28835@atomide.com>
References: <5448984682E7954C9BFF27F747A9C6CA56E38E@dolphin.TIGRIS.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:46179 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757644Ab2IUTQc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Sep 2012 15:16:32 -0400
Content-Disposition: inline
In-Reply-To: <5448984682E7954C9BFF27F747A9C6CA56E38E@dolphin.TIGRIS.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Maximilian Schwerin <Maximilian.Schwerin@tigris.de>
Cc: linux-omap@vger.kernel.org

* Maximilian Schwerin <Maximilian.Schwerin@tigris.de> [120920 23:46]:
> Hi,
> 
> I've just built a linux-omap kernel at 3.6-rc6 using omap2plus_defconfig
> as basis for the kernel config.
> 
> When I enable smartreflex and switch to 800MHz via
> 
> echo 1 > /sys/kernel/debug/smartreflex/smartreflex_core/autocomp
> echo 1 > /sys/kernel/debug/smartreflex/smartreflex_mpu_iva/autocomp
> cpufreq-set -f 800MHz
> 
> the board crashes. If I switch to 800MHz and enable smartreflex later
> nothing happens. This used to work in my 3.3 based kernel.

I'm suspecting that this is because of all the missing PM
errata we don't have in the mainline kernel :(

I think we're missing at least the following based on a quick grep
of the Nokia patched PM code:

- 3430 (and 3630?) hs omap cs1 off-idle bug where save/restore needs to be in lowmem

- 3630 retention idle is missing errata handling for 1.85/i581

- 3630 off idle is missing 1.87 handling

- smartreflex missing twl4030 errata?

- Nokia patched PM code mentions also quite a few other missing
  errata such as 1.88, 1.142, i582, i467, i468, 1.164

This may be a bit out of date as it's based on some notes I made
few months ago after I started noticing flakeyness on my 3630 zoom3
board.

Regards,

Tony
