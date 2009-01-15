From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: git-pull request for omap-fixes for 2.6.29-rc1 (Re: [PATCH 00/10] Omap fixes for 2.6.29-rc1)
Date: Thu, 15 Jan 2009 12:40:16 +0000
Message-ID: <20090115124016.GA20409@n2100.arm.linux.org.uk>
References: <20090112143405.24205.52151.stgit@localhost> <20090113143528.GP7344@atomide.com> <20090115103716.GL2162@n2100.arm.linux.org.uk> <20090115112611.GX29324@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:40677 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754510AbZAOMk2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Jan 2009 07:40:28 -0500
Content-Disposition: inline
In-Reply-To: <20090115112611.GX29324@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

On Thu, Jan 15, 2009 at 01:26:12PM +0200, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [090115 12:37]:
> > On Tue, Jan 13, 2009 at 04:35:29PM +0200, Tony Lindgren wrote:
> > > * Tony Lindgren <tony@atomide.com> [090112 16:37]:
> > > > Hi,
> > > > 
> > > > Here are some omap fixes for review. Some of these patches
> > > > were posted earlier.
> > > 
> > > If no other comments, here's the pull request:
> > 
> > Unfortunately, this breaks stuff.  Whereas before pulling this I get:
> > 
> >   CC      drivers/usb/core/hub.o
> > drivers/usb/core/hub.c: In function `usb_configure_device_otg':
> > drivers/usb/core/hub.c:1557: error: too few arguments to function `usb_port_suspend'
> 
> Hmm, I thought I build all the defconfigs before posting the series.
> Will update in just few mins.

Thanks.  It would also be nice if the USB error could be fixed by USB
folk as well - it's been broken since 2.6.28-git12.  (Maybe people
should check kautobuild's errors summary page?)

http://armlinux.simtec.co.uk/kautobuild/<version>/errors.html

where <version> should be replaced by, eg, 2.6.29-rc1-git4
