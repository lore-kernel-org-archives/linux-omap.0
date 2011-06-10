From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [linux-pm] calling runtime PM from system PM methods
Date: Fri, 10 Jun 2011 19:42:22 +0100
Message-ID: <20110610184222.GT26436@opensource.wolfsonmicro.com>
References: <20110610155707.GN26436@opensource.wolfsonmicro.com>
 <Pine.LNX.4.44L0.1106101317160.1921-100000@iolanthe.rowland.org>
 <20110610173154.GO26436@opensource.wolfsonmicro.com>
 <201106102038.22725.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:60034 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757622Ab1FJSmY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 10 Jun 2011 14:42:24 -0400
Content-Disposition: inline
In-Reply-To: <201106102038.22725.rjw@sisk.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org, Alan Stern <stern@rowland.harvard.edu>, linux-omap@vger.kernel.org

On Fri, Jun 10, 2011 at 08:38:22PM +0200, Rafael J. Wysocki wrote:
> On Friday, June 10, 2011, Mark Brown wrote:

> > I think from an interface point of view it's something like
> > UNIVERSAL_DEV_PM_OPS() and friends, probably with some additional ops
> > that can do the glue bits like enabling wakeup and quiescing activity.
> > I'd need to think harder about what exactly that'd look like - for my
> > cases the fundamental thing I want to say is that there's one suspend
> > routine and one resume routine and I'd like some framework code to work
> > out when they're called.

> Can your device generate wakeup signals?

I am interested in a fairly large selection of devices but broadly
speaking any off-SoC device can generate wakeups if it can generate
interrupts.
