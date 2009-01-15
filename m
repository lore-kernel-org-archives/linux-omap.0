From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: git-pull request for omap-fixes for 2.6.29-rc1 (Re: [PATCH 00/10] Omap fixes for 2.6.29-rc1)
Date: Thu, 15 Jan 2009 13:34:17 +0000
Message-ID: <20090115133417.GB20409@n2100.arm.linux.org.uk>
References: <20090112143405.24205.52151.stgit@localhost> <20090113143528.GP7344@atomide.com> <20090115103716.GL2162@n2100.arm.linux.org.uk> <20090115112611.GX29324@atomide.com> <20090115124016.GA20409@n2100.arm.linux.org.uk> <20090115131545.GB6635@scadufax.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:32982 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765663AbZAONe7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Jan 2009 08:34:59 -0500
Content-Disposition: inline
In-Reply-To: <20090115131545.GB6635@scadufax.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@suse.de>
Cc: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

On Thu, Jan 15, 2009 at 03:15:45PM +0200, Felipe Balbi wrote:
> On Thu, Jan 15, 2009 at 12:40:16PM +0000, ext Russell King - ARM Linux wrote:
> > Thanks.  It would also be nice if the USB error could be fixed by USB
> > folk as well - it's been broken since 2.6.28-git12.  (Maybe people
> > should check kautobuild's errors summary page?)
> 
> are you talking about
> 
> drivers/usb/core/hub.c:1557: error: too few arguments to function
> 'usb_port_suspend' ??

That was indeed the one quoted in my message.

> that should be fixed by Greg, no ??

Not sure - looks to be related to OTG... and seems to be caused by Alan
Stern's 65bfd2967c906ca322a4bb69a285fe0de8916ac6 change "USB: Enhance
usage of pm_message_t".  Adding To's.
