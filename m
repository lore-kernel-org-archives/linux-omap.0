From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] runtime PM usage_count during driver_probe_device()?
Date: Fri, 1 Jul 2011 22:53:19 +0200
Message-ID: <201107012253.19988.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1107011123590.1988-100000@iolanthe.rowland.org> <87pqlu3sy3.fsf@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:48726 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756130Ab1GAUwt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Jul 2011 16:52:49 -0400
In-Reply-To: <87pqlu3sy3.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-pm@lists.linux-foundation.org, Alan Stern <stern@rowland.harvard.edu>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Friday, July 01, 2011, Kevin Hilman wrote:
> Alan Stern <stern@rowland.harvard.edu> writes:
> 
> > On Fri, 1 Jul 2011, Kevin Hilman wrote:
> >
> >> OK, so the ->probe() part has been explained and makes sense, but I
> >> would expect ->remove() to be similarily protected (as the documentation
> >> states.)  But that is not the case.  Is that a bug?  If so, patch below
> >> makes the code match the documentation.
> >
> > I suspect it is a bug, but it's hard to be sure.  It's so _blatantly_ 
> > wrong that it looks like it was done deliberately.
> 
> heh

I seem to remeber having a problem with the pm_runtime_put_sync() after
drv->remove(dev) ...

So the code in question was introduced by

commit e1866b33b1e89f077b7132daae3dfd9a594e9a1a
Author: Rafael J. Wysocki <rjw@sisk.pl>
Date:   Fri Apr 29 00:33:45 2011 +0200

    PM / Runtime: Rework runtime PM handling during driver removal

with a long changelog explaining the reason why.  Which seems to make sense. ;-)

So I'm not sure.

Thanks,
Rafael
