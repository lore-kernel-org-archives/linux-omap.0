From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] calling runtime PM from system PM methods
Date: Sun, 12 Jun 2011 11:59:28 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1106121153510.18475-100000@netrider.rowland.org>
References: <201106120046.36618.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:34094 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754127Ab1FLP73 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 12 Jun 2011 11:59:29 -0400
In-Reply-To: <201106120046.36618.rjw@sisk.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Kevin Hilman <khilman@ti.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Paul Walmsley <paul@pwsan.com>

On Sun, 12 Jun 2011, Rafael J. Wysocki wrote:

> > Basically, I think what Rafael was saying before referred to the 
> > general case, where you don't know anything about the subsystem and 
> > can't afford to make assumptions.  But in the real world you'll be 
> > writing a driver for a particular subsystem and you'll know how that 
> > subsystem works.  If the subsystem permits runtime PM calls to be 
> > nested within the system PM routines, feel free to go ahead and use 
> > them.
> 
> But then we get the problem that user space may echo "on" to the
> device's "control" file in sysfs and the whole clever plan basically goes
> south.

That would indeed be a problem if we used pm_runtime_suspend() in the
system suspend code.  But it doesn't prevent us from calling
pm_runtime_resume() during system suspend.

> Moreover, on some systems devices will belong to PM domains and their
> drivers may potentially be used with different PM domains on different
> platforms.  This means that drivers really should not make any assumptions
> about whether or not they can use runtime PM in their system suspend/resume
> routines.  They can't.

Yes, clearly one mustn't make assumptions about unknown subsystems or
PM domains.

Alan Stern

