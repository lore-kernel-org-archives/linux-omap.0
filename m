From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] runtime PM usage_count during driver_probe_device()?
Date: Fri, 1 Jul 2011 23:44:03 +0200
Message-ID: <201107012344.03981.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1107011711370.1624-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:48866 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757702Ab1GAVm5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Jul 2011 17:42:57 -0400
In-Reply-To: <Pine.LNX.4.44L0.1107011711370.1624-100000@iolanthe.rowland.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Kevin Hilman <khilman@ti.com>, linux-pm@lists.linux-foundation.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Friday, July 01, 2011, Alan Stern wrote:
> On Fri, 1 Jul 2011, Rafael J. Wysocki wrote:
> 
> > Hi,
> > 
> > On Friday, July 01, 2011, Kevin Hilman wrote:
> > > Alan Stern <stern@rowland.harvard.edu> writes:
> > > 
> > > > On Fri, 1 Jul 2011, Kevin Hilman wrote:
> > > >
> > > >> OK, so the ->probe() part has been explained and makes sense, but I
> > > >> would expect ->remove() to be similarily protected (as the documentation
> > > >> states.)  But that is not the case.  Is that a bug?  If so, patch below
> > > >> makes the code match the documentation.
> > > >
> > > > I suspect it is a bug, but it's hard to be sure.  It's so _blatantly_ 
> > > > wrong that it looks like it was done deliberately.
> > > 
> > > heh
> > 
> > I seem to remeber having a problem with the pm_runtime_put_sync() after
> > drv->remove(dev) ...
> > 
> > So the code in question was introduced by
> > 
> > commit e1866b33b1e89f077b7132daae3dfd9a594e9a1a
> > Author: Rafael J. Wysocki <rjw@sisk.pl>
> > Date:   Fri Apr 29 00:33:45 2011 +0200
> > 
> >     PM / Runtime: Rework runtime PM handling during driver removal
> > 
> > with a long changelog explaining the reason why.  Which seems to make sense. ;-)
> 
> Okay, that seems fair enough.  Looks like the documentation needs to be 
> updated to match, though.

Yes, it does.

> And we probably still want to make sure that access to the 
> power/control and related attribute files is mutually exclusive with 
> probe and remove.

I agree.

Thanks,
Rafael
