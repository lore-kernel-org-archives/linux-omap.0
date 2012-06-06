From: Tony Lindgren <tony@atomide.com>
Subject: Re: Broken builds
Date: Wed, 6 Jun 2012 00:58:00 -0700
Message-ID: <20120606075758.GS12766@atomide.com>
References: <20120603180122.GA23368@n2100.arm.linux.org.uk>
 <20120605082218.GL12766@atomide.com>
 <1338902400.1952.19.camel@lappyti>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:36924 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750888Ab2FFH6E (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Jun 2012 03:58:04 -0400
Content-Disposition: inline
In-Reply-To: <1338902400.1952.19.camel@lappyti>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [120605 06:24]:
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

Tomi, please have your patches sitting in linux next for at least a
week before they get merged. That usually shakes down bugs like these
before the merge window.

Regards,

Tony
