From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] PM: add synchronous runtime interface for interrupt
 handlers
Date: Fri, 1 Oct 2010 10:12:39 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1010011011380.1813-100000@iolanthe.rowland.org>
References: <201010010002.19204.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:48414 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932268Ab0JAOMl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Oct 2010 10:12:41 -0400
In-Reply-To: <201010010002.19204.rjw@sisk.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Kevin Hilman <khilman@deeprootsystems.com>, Partha Basak <p-basak2@ti.com>, linux-omap@vger.kernel.org

On Fri, 1 Oct 2010, Rafael J. Wysocki wrote:

> On Thursday, September 30, 2010, Alan Stern wrote:
> > This patch (as1431) adds a synchronous runtime-PM interface suitable
> > for use in interrupt handlers.  Four new helper functions are defined:
> > 
> > 	pm_runtime_suspend_irq(), pm_runtime_resume_irq(),
> > 	pm_runtime_get_sync_irq(), pm_runtime_put_sync_irq(),
> > 
> > together with pm_runtime_callbacks_in_irq(), which subsystems use to
> > tell the PM core that the runtime callbacks should be invoked with
> > interrupts disabled.
> 
> BTW, I like some changes made by your patch that aren't really related to
> the issue at hand, so I think the patch below can be applied regardless of
> the other changes, unless I made a mistake I can see now.

It looks like a good change, but you forgot to preserve the assignments 
to dev->power.runtime_error.

Alan Stern


