From: Tony Lindgren <tony@atomide.com>
Subject: Re: 24xx/n8x0 booting again, linux-omap updated to -rc5
Date: Tue, 20 Oct 2009 11:56:27 -0700
Message-ID: <20091020185627.GJ12576@atomide.com>
References: <20091016012747.GA12576@atomide.com> <20091020163102.GB22912@swansys>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:49684 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751733AbZJTS4Z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Oct 2009 14:56:25 -0400
Received: from muru.com ([72.249.23.125] helo=localhost.localdomain)
	by mho-02-ewr.mailhop.org with esmtpa (Exim 4.68)
	(envelope-from <tony@atomide.com>)
	id 1N0Jsj-0009QN-GU
	for linux-omap@vger.kernel.org; Tue, 20 Oct 2009 18:56:29 +0000
Content-Disposition: inline
In-Reply-To: <20091020163102.GB22912@swansys>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

* green <greenfreedom10@gmail.com> [091020 09:31]:
> Tony Lindgren wrote at 2009-10-15 20:27 -0500:
> > Thanks to Paul's "OMAP2xxx clock: set up clockdomain pointer in struct clk"
> > patch, we got 24xx booting again both in mainline and in linux-omap.
> 
> That's excellent news!
> 
> That is commit f856f168bcbc5f49253dd12a4d8452857a785f1c ?

Yeah, that's it.
 
> But I must be missing something somewhere... I have not yet been able to get 
> the N810 to boot.  I see only the Nokia splash.  Note that I just want to see 
> the framebuffer console at this point: I expect a panic due to no root fs.
> 
> Attached is the config I'm using, which is based on n8x0_defconfig.

Looks like your config ends up waiting for root on the mmc. But we're missing
what was board-n800-mmc.c, so that needs to be updated for mainline.
You can find the old code in the omap-2.6.30 branch under arch/arm/mach-omap2
if you have the cycles to update it.

Also, the drivers/cbus needs to be updated to get the GPIO pins from
board-*.c files, otherwise the retu watchdog will power down the system
in 30 seconds.
 
> I am using the arm-linux-gnueabi cross-compiler from emdebian, v4.2.  What 
> version is recommended, preferably available from emdebian (4.1, 4.2, 4.3, 
> 4.4)?

Those should be just fine.
 
> > The following patch is also needed to change the n8x0 serial console CMDLINE
> > from ttyS0 to ttyS2 as the port numbering now matches the physical ports.
> > The patch is already in linux-omap, but not yet in mainline.
> 
> If that is only for the serial console, I should need no console= option, 
> right?  I've tried it both ways...

Yeah, that's needed only for the serial console.

Regards,

Tony
