From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH ver. 2] PM: add synchronous runtime interface for interrupt handlers
Date: Wed, 24 Nov 2010 21:33:56 +0100
Message-ID: <201011242133.56304.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1011240950220.1513-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:52473 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751994Ab0KXUek (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Nov 2010 15:34:40 -0500
In-Reply-To: <Pine.LNX.4.44L0.1011240950220.1513-100000@iolanthe.rowland.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Partha Basak <p-basak2@ti.com>, linux-omap@vger.kernel.org

On Wednesday, November 24, 2010, Alan Stern wrote:
> On Tue, 23 Nov 2010, Rafael J. Wysocki wrote:
> 
> > > Or maybe you think that when pm_runtime_put_sync detects the 
> > > usage_count has decremented to 0 and the device is irq-safe, it should 
> > > call rpm_suspend directly instead of calling rpm_idle?
> > 
> > That also would work for me, actually.
> 
> Okay, then consider this proposal.  I'll introduce a new
> pm_runtime_put_sync_suspend() function which decrements the usage_count
> and calls rpm_suspend directly if the count drops to 0.  Then interrupt
> handlers could use this function in place of pm_runtime_put_sync(),
> provided the device was irq-safe.
> 
> Not only that, pm_runtime_put_sync_suspend() would be available for
> anyone to use.  It must be reasonably common for runtime_idle routines
> to do nothing but call pm_runtime_suspend().  The new API call would
> save a little overhead.

Fine by me.

Thanks,
Rafael
