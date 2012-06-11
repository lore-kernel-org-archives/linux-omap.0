From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Broken builds
Date: Mon, 11 Jun 2012 17:06:16 +0100
Message-ID: <20120611160616.GA9268@n2100.arm.linux.org.uk>
References: <20120603180122.GA23368@n2100.arm.linux.org.uk> <20120605082218.GL12766@atomide.com> <1338902400.1952.19.camel@lappyti>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:54097 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753955Ab2FKQGb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Jun 2012 12:06:31 -0400
Content-Disposition: inline
In-Reply-To: <1338902400.1952.19.camel@lappyti>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

On Tue, Jun 05, 2012 at 04:20:00PM +0300, Tomi Valkeinen wrote:
> Hi,
> 
> On Tue, 2012-06-05 at 01:22 -0700, Tony Lindgren wrote:
> > * Russell King - ARM Linux <linux@arm.linux.org.uk> [120603 11:05]:
> > > Looks like the DSS stuff has broken OMAP builds again during this
> > > merge window:
> > > 
> > > drivers/video/omap2/dss/core.c:197: error: static declaration of 'dss_debugfs_create_file' follows non-static declaration
> > > drivers/video/omap2/dss/dss.h:166: error: previous declaration of 'dss_debugfs_create_file' was here
> > > 
> > > Both the OMAP3 and OMAP4 builds break with these two errors.
> > 
> > Here's a patch for Tomi to fix this one.
> 
> I have a patch for this in my for-rc branch. It just missed the main
> merge. I'll send this and a few other fixes today for the next rc.
> 
> Btw, it compiles if you have debugfs and DSS_DEBUG_SUPPORT enabled.
> That's why I didn't notice it until too late.

So... where are we with this?  Apparantly not much further forward;
it seems to be in linux-next but still not in mainline, and mainline
continues to be broken.
