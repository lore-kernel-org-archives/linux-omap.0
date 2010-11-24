From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH ver. 2] PM: add synchronous runtime interface for interrupt
 handlers
Date: Wed, 24 Nov 2010 09:56:54 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1011240950220.1513-100000@iolanthe.rowland.org>
References: <201011232351.11340.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:43425 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752268Ab0KXO4z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Nov 2010 09:56:55 -0500
In-Reply-To: <201011232351.11340.rjw@sisk.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Partha Basak <p-basak2@ti.com>, linux-omap@vger.kernel.org

On Tue, 23 Nov 2010, Rafael J. Wysocki wrote:

> > Or maybe you think that when pm_runtime_put_sync detects the 
> > usage_count has decremented to 0 and the device is irq-safe, it should 
> > call rpm_suspend directly instead of calling rpm_idle?
> 
> That also would work for me, actually.

Okay, then consider this proposal.  I'll introduce a new
pm_runtime_put_sync_suspend() function which decrements the usage_count
and calls rpm_suspend directly if the count drops to 0.  Then interrupt
handlers could use this function in place of pm_runtime_put_sync(),
provided the device was irq-safe.

Not only that, pm_runtime_put_sync_suspend() would be available for
anyone to use.  It must be reasonably common for runtime_idle routines
to do nothing but call pm_runtime_suspend().  The new API call would
save a little overhead.

Alan Stern

