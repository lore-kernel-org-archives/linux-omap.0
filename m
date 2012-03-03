From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP totally fucked?
Date: Sat, 3 Mar 2012 13:57:02 -0800
Message-ID: <20120303215702.GG10293@atomide.com>
References: <20120303154650.GA16132@n2100.arm.linux.org.uk>
 <20120303180428.GA10293@atomide.com>
 <20120303183225.GA17710@n2100.arm.linux.org.uk>
 <20120303190140.GB19248@atomide.com>
 <20120303192839.GB17710@n2100.arm.linux.org.uk>
 <20120303200123.GB10293@atomide.com>
 <20120303202810.GC10293@atomide.com>
 <20120303203448.GD10293@atomide.com>
 <20120303205200.GC17710@n2100.arm.linux.org.uk>
 <20120303212101.GF10293@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:34819 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751164Ab2CCV5I (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 3 Mar 2012 16:57:08 -0500
Content-Disposition: inline
In-Reply-To: <20120303212101.GF10293@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-omap@vger.kernel.org, Olof Johansson <olof@lixom.net>

Hi Arnd & Olof,

* Tony Lindgren <tony@atomide.com> [120303 12:49]:
> 
> Anyways, we should revert commit 72b026a4 because of the
> breakage it causes.

Correction, we should revert commit c295fb63. The above commit
is wrong and only exists on my machine.

Arnd & Olof, can you please revert commit c295fb63 (ARM: OMAP2+:
Fix multiple randconfig errors with SOC_OMAP and SOC_OMAP_NOOP)
in omap/fixes-non-critical?

This commit by me generates bloated .config files with make
oldconfig on existing .config files.

Further mach-omap2/Kconfig changes can then wait until they're
properly tested..
 
> Below is a second attempt for the Kconfig changes. Now the
> CONFIG_MACH_ needs to be set in your seed .config.

..as this patch needs at least one more change to add a submenu
for MACH_OMAP_GENERIC to select the SoC type. Other boards
should not need that, so it might be best to make it available
only for MACH_OMAP_GENERIC.

Regards,

Tony
