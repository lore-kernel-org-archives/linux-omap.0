From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Broken builds
Date: Mon, 11 Jun 2012 17:09:25 +0100
Message-ID: <20120611160925.GB9268@n2100.arm.linux.org.uk>
References: <20120603180122.GA23368@n2100.arm.linux.org.uk> <20120605082218.GL12766@atomide.com> <1338902400.1952.19.camel@lappyti> <20120606075758.GS12766@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:54102 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755868Ab2FKQJd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Jun 2012 12:09:33 -0400
Content-Disposition: inline
In-Reply-To: <20120606075758.GS12766@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org

On Wed, Jun 06, 2012 at 12:58:00AM -0700, Tony Lindgren wrote:
> * Tomi Valkeinen <tomi.valkeinen@ti.com> [120605 06:24]:
> > Hi,
> > 
> > On Tue, 2012-06-05 at 01:22 -0700, Tony Lindgren wrote:
> > > * Russell King - ARM Linux <linux@arm.linux.org.uk> [120603 11:05]:
> > > > Looks like the DSS stuff has broken OMAP builds again during this
> > > > merge window:
> > > > 
> > > > drivers/video/omap2/dss/core.c:197: error: static declaration of 'dss_debugfs_create_file' follows non-static declaration
> > > > drivers/video/omap2/dss/dss.h:166: error: previous declaration of 'dss_debugfs_create_file' was here
> > > > 
> > > > Both the OMAP3 and OMAP4 builds break with these two errors.
> > > 
> > > Here's a patch for Tomi to fix this one.
> > 
> > I have a patch for this in my for-rc branch. It just missed the main
> > merge. I'll send this and a few other fixes today for the next rc.
> > 
> > Btw, it compiles if you have debugfs and DSS_DEBUG_SUPPORT enabled.
> > That's why I didn't notice it until too late.
> 
> Tomi, please have your patches sitting in linux next for at least a
> week before they get merged. That usually shakes down bugs like these
> before the merge window.

Note that tested simple bug fixes _should_ be upstreamed faster than
that where possible - such as this one.

I'm waiting for this to hit mainline before doing any further work on
OMAP.  That basically means I've been totally ignoring OMAP because of
this issue for the last week.
