From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM: add synchronous runtime interface for interrupt handlers
Date: Fri, 1 Oct 2010 23:14:37 +0200
Message-ID: <201010012314.38089.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1010011011380.1813-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:36404 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752126Ab0JAVPZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Oct 2010 17:15:25 -0400
In-Reply-To: <Pine.LNX.4.44L0.1010011011380.1813-100000@iolanthe.rowland.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Kevin Hilman <khilman@deeprootsystems.com>, Partha Basak <p-basak2@ti.com>, linux-omap@vger.kernel.org

On Friday, October 01, 2010, Alan Stern wrote:
> On Fri, 1 Oct 2010, Rafael J. Wysocki wrote:
> 
> > On Thursday, September 30, 2010, Alan Stern wrote:
> > > This patch (as1431) adds a synchronous runtime-PM interface suitable
> > > for use in interrupt handlers.  Four new helper functions are defined:
> > > 
> > > 	pm_runtime_suspend_irq(), pm_runtime_resume_irq(),
> > > 	pm_runtime_get_sync_irq(), pm_runtime_put_sync_irq(),
> > > 
> > > together with pm_runtime_callbacks_in_irq(), which subsystems use to
> > > tell the PM core that the runtime callbacks should be invoked with
> > > interrupts disabled.
> > 
> > BTW, I like some changes made by your patch that aren't really related to
> > the issue at hand, so I think the patch below can be applied regardless of
> > the other changes, unless I made a mistake I can see now.
> 
> It looks like a good change, but you forgot to preserve the assignments 
> to dev->power.runtime_error.

That's correct and there's a difference betwee _idle and the other cases
because of that.  I'll send updated patch with a changelog shortly.

Thanks,
Rafael
