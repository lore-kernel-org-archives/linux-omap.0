From: Tony Lindgren <tony@atomide.com>
Subject: Re: arch/arm/mach-omap* organization
Date: Tue, 4 Aug 2009 10:05:27 +0300
Message-ID: <20090804070526.GD24334@atomide.com>
References: <4A776368.1010503@onid.oregonstate.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:63528 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932462AbZHDHFa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Aug 2009 03:05:30 -0400
Content-Disposition: inline
In-Reply-To: <4A776368.1010503@onid.oregonstate.edu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ben Goska <goskab@onid.oregonstate.edu>
Cc: linux-omap@vger.kernel.org

* Ben Goska <goskab@onid.oregonstate.edu> [090804 01:53]:
> Is there a reason why omap2, omap3, and now omap4 files are all packed  
> into the mach-omap2 directory?
>
> It seems like it would make more sense for each omap version to have  
> it's own directory.

Majority of the mach-omap2 code is shared across them.

For example, the initial patch to add minimal omap3 support on top of
the omap2 code was about 500 lines of diff. The situation was pretty
much the same to add minimal omap4 support on top of omap3.

If we wanted to, in the long run we could move more of the shared
code to plat-omap, and just keep board-*.c files under each mach-*
directory.

But before we start doing rearranging like that we should first
concentrate on more important things, such as getting all the
PM code into the mainline, getting clock framework up and running
for omap4, get rid of IO_ADDRESS macros and omap_read/write and so
on.

Regards,

Tony
