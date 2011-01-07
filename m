From: Tony Lindgren <tony@atomide.com>
Subject: Re: 4430SDP boot failure
Date: Thu, 6 Jan 2011 20:11:18 -0800
Message-ID: <20110107041118.GB880@atomide.com>
References: <20110106170805.GE1198@n2100.arm.linux.org.uk>
 <20110106180030.GA8249@n2100.arm.linux.org.uk>
 <20110106182023.GV7771@atomide.com>
 <20110106195225.GX7771@atomide.com>
 <20110106203431.GZ7771@atomide.com>
 <20110106205107.GI1198@n2100.arm.linux.org.uk>
 <20110106235203.GA14425@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:62544 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752957Ab1AGELl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Jan 2011 23:11:41 -0500
Content-Disposition: inline
In-Reply-To: <20110106235203.GA14425@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [110106 15:51]:
> On Thu, Jan 06, 2011 at 08:51:07PM +0000, Russell King - ARM Linux wrote:
> > 
> > OMAP44XX SDP # setenv bootargs 'root=/dev/mmcblk0p2 rw mem=512M vmalloc=1G console=ttyO2,115200n8 rootdelay=2'
> > OMAP44XX SDP # mmcinit 0
> > OMAP44XX SDP # fatload mmc 0 0x80300000 uImage-test
> > 
> > 0 bytes read
> > OMAP44XX SDP #
> > 
> > However, it can still boot the uImage contained on the SD card, so the
> > card must be okay, and the SDP must still be able to successfully read
> > from the card.  I can only assume that uboot's FAT support is buggered
> > in some way.

Sorry no idea about this problem, have not seen it myself.
 
> > We _really_ need a _decent_ boot loader on these boards, one which can
> > do network booting _and_ can be configured to do so from bootup.  SD
> > cards just don't hack it for kernel development.  It's a far too long-
> > winded process for each cycle, and with all the additional problems
> > (such as SD cards not being recognised 50% of the time, FAT filesystem
> > bugs in boot loaders, etc) it's really not funny.

I totally agree. Flipping micro-SD cards for development is no fun.

Regards,

Tony
