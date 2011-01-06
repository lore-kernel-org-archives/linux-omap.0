From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: 4430SDP boot failure
Date: Thu, 6 Jan 2011 21:11:19 +0000
Message-ID: <20110106211119.GA12500@n2100.arm.linux.org.uk>
References: <20110106170805.GE1198@n2100.arm.linux.org.uk> <20110106180030.GA8249@n2100.arm.linux.org.uk> <20110106182023.GV7771@atomide.com> <20110106195225.GX7771@atomide.com> <20110106203431.GZ7771@atomide.com> <20110106205107.GI1198@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:41140 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751906Ab1AFVL1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Jan 2011 16:11:27 -0500
Content-Disposition: inline
In-Reply-To: <20110106205107.GI1198@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

On Thu, Jan 06, 2011 at 08:51:07PM +0000, Russell King - ARM Linux wrote:
> We _really_ need a _decent_ boot loader on these boards, one which can
> do network booting _and_ can be configured to do so from bootup.  SD
> cards just don't hack it for kernel development.  It's a far too long-
> winded process for each cycle, and with all the additional problems
> (such as SD cards not being recognised 50% of the time, FAT filesystem
> bugs in boot loaders, etc) it's really not funny.
> 
> So, I give up at this point with the OMAP4430SDP board.  It's not worth
> spending the time with this kind of unreliability.

To top it off, the crappy 3rd party ftdi_sio driver I have to use for the
SDP board just oopsed my x86 kernel.  Do you get the impression that if
something can go wrong, it will go wrong...

I think I'll leave the 4430SDP alone until I have more patience for it.
I might see about setting up the ARM Realview platform as a remote
terminal for the 4430SDP so at least these kinds of crashes don't take
out my work machine.
