From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: git-pull request for omap-fixes for 2.6.29-rc1 (Re: [PATCH 00/10]
 Omap fixes for 2.6.29-rc1)
Date: Thu, 15 Jan 2009 09:49:46 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0901150948150.2490-100000@iolanthe.rowland.org>
References: <20090115133417.GB20409@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:37066 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1761004AbZAOOtt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Jan 2009 09:49:49 -0500
In-Reply-To: <20090115133417.GB20409@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, Greg Kroah-Hartman <gregkh@suse.de>, Tony Lindgren <tony@atomide.com>, David Brownell <david-b@pacbell.net>, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

On Thu, 15 Jan 2009, Russell King - ARM Linux wrote:

> On Thu, Jan 15, 2009 at 03:15:45PM +0200, Felipe Balbi wrote:
> > On Thu, Jan 15, 2009 at 12:40:16PM +0000, ext Russell King - ARM Linux wrote:
> > > Thanks.  It would also be nice if the USB error could be fixed by USB
> > > folk as well - it's been broken since 2.6.28-git12.  (Maybe people
> > > should check kautobuild's errors summary page?)
> > 
> > are you talking about
> > 
> > drivers/usb/core/hub.c:1557: error: too few arguments to function
> > 'usb_port_suspend' ??
> 
> That was indeed the one quoted in my message.
> 
> > that should be fixed by Greg, no ??
> 
> Not sure - looks to be related to OTG... and seems to be caused by Alan
> Stern's 65bfd2967c906ca322a4bb69a285fe0de8916ac6 change "USB: Enhance
> usage of pm_message_t".  Adding To's.

Apparently the patch to fix this is still in Greg's queue.  If you want
to test the patch for yourself, it's here:

	http://marc.info/?l=linux-usb&m=123032171110450&w=2

Alan Stern


