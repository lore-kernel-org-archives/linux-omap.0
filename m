From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [linux-pm] calling runtime PM from system PM methods
Date: Sat, 11 Jun 2011 12:42:39 +0100
Message-ID: <20110611114239.GC2738@opensource.wolfsonmicro.com>
References: <20110610155707.GN26436@opensource.wolfsonmicro.com>
 <201106102038.22725.rjw@sisk.pl>
 <20110610184222.GT26436@opensource.wolfsonmicro.com>
 <201106102227.25391.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:56916 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754470Ab1FKLml (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 11 Jun 2011 07:42:41 -0400
Content-Disposition: inline
In-Reply-To: <201106102227.25391.rjw@sisk.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org, Alan Stern <stern@rowland.harvard.edu>, linux-omap@vger.kernel.org

On Fri, Jun 10, 2011 at 10:27:25PM +0200, Rafael J. Wysocki wrote:

> So, there are a few things to consider:

> * Can the device do things like DMA?
> * Does the driver use a workqueue?
> * Does it use timers?

> In all of the above cases your system suspend handling will require extra
> care to make sure those things won't get in the way of the suspend process.

Yes, that's the quiesce operation I think myself or Alan mentioned.

> It's probably fair to say that everithing depends on the subsystem, what it
> does and what it expects from the driver.  In the extreme case, when the
> subsystem is like the platform bus type, the driver unfortunately is on its
> own and has to deal with the whole complexity.

I'm pretty much only working with buses that have no infrastructure and
for which power is essentially orthogonal to the control bus itself -
that's a very large proportion of the embedded space.  It really feels
like we could be doing a better job for drivers using these buses,
there's a lot of similarities in what many of them need but I can never
find the time to get my head round it confidently enough to actually
propose anything.
