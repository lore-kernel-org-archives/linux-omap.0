From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: git-pull request for omap-fixes for 2.6.29-rc1 (Re: [PATCH 00/10] Omap fixes for 2.6.29-rc1)
Date: Thu, 15 Jan 2009 15:16:27 +0000
Message-ID: <20090115151627.GE20409@n2100.arm.linux.org.uk>
References: <20090115133417.GB20409@n2100.arm.linux.org.uk> <Pine.LNX.4.44L0.0901150948150.2490-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:34910 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751753AbZAOPSs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Jan 2009 10:18:48 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0901150948150.2490-100000@iolanthe.rowland.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, Greg Kroah-Hartman <gregkh@suse.de>, Tony Lindgren <tony@atomide.com>, David Brownell <david-b@pacbell.net>, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

On Thu, Jan 15, 2009 at 09:49:46AM -0500, Alan Stern wrote:
> On Thu, 15 Jan 2009, Russell King - ARM Linux wrote:
> 
> > On Thu, Jan 15, 2009 at 03:15:45PM +0200, Felipe Balbi wrote:
> > > On Thu, Jan 15, 2009 at 12:40:16PM +0000, ext Russell King - ARM Linux wrote:
> > > > Thanks.  It would also be nice if the USB error could be fixed by USB
> > > > folk as well - it's been broken since 2.6.28-git12.  (Maybe people
> > > > should check kautobuild's errors summary page?)
> > > 
> > > are you talking about
> > > 
> > > drivers/usb/core/hub.c:1557: error: too few arguments to function
> > > 'usb_port_suspend' ??
> > 
> > That was indeed the one quoted in my message.
> > 
> > > that should be fixed by Greg, no ??
> > 
> > Not sure - looks to be related to OTG... and seems to be caused by Alan
> > Stern's 65bfd2967c906ca322a4bb69a285fe0de8916ac6 change "USB: Enhance
> > usage of pm_message_t".  Adding To's.
> 
> Apparently the patch to fix this is still in Greg's queue.  If you want
> to test the patch for yourself, it's here:
> 
> 	http://marc.info/?l=linux-usb&m=123032171110450&w=2

Sigh.  Trivial build error.  Trivial fix.  Almost three weeks to get it
into mainline and still waiting...  Frustrated and annoyed.

(Isn't this the kind of slow bug fixing that akpm complains about at
kernel summits?)
