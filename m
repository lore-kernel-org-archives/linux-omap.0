From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] runtime PM usage_count during driver_probe_device()?
Date: Fri, 1 Jul 2011 17:12:58 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1107011711370.1624-100000@iolanthe.rowland.org>
References: <201107012253.19988.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:36731 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751870Ab1GAVM7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Jul 2011 17:12:59 -0400
In-Reply-To: <201107012253.19988.rjw@sisk.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Kevin Hilman <khilman@ti.com>, linux-pm@lists.linux-foundation.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, 1 Jul 2011, Rafael J. Wysocki wrote:

> Hi,
> 
> On Friday, July 01, 2011, Kevin Hilman wrote:
> > Alan Stern <stern@rowland.harvard.edu> writes:
> > 
> > > On Fri, 1 Jul 2011, Kevin Hilman wrote:
> > >
> > >> OK, so the ->probe() part has been explained and makes sense, but I
> > >> would expect ->remove() to be similarily protected (as the documentation
> > >> states.)  But that is not the case.  Is that a bug?  If so, patch below
> > >> makes the code match the documentation.
> > >
> > > I suspect it is a bug, but it's hard to be sure.  It's so _blatantly_ 
> > > wrong that it looks like it was done deliberately.
> > 
> > heh
> 
> I seem to remeber having a problem with the pm_runtime_put_sync() after
> drv->remove(dev) ...
> 
> So the code in question was introduced by
> 
> commit e1866b33b1e89f077b7132daae3dfd9a594e9a1a
> Author: Rafael J. Wysocki <rjw@sisk.pl>
> Date:   Fri Apr 29 00:33:45 2011 +0200
> 
>     PM / Runtime: Rework runtime PM handling during driver removal
> 
> with a long changelog explaining the reason why.  Which seems to make sense. ;-)

Okay, that seems fair enough.  Looks like the documentation needs to be 
updated to match, though.

And we probably still want to make sure that access to the 
power/control and related attribute files is mutually exclusive with 
probe and remove.

Alan Stern

