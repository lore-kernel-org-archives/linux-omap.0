From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH ver. 2] PM: add synchronous runtime interface for interrupt
 handlers
Date: Mon, 22 Nov 2010 22:19:22 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1011222204440.26293-100000@netrider.rowland.org>
References: <201011230001.20241.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:58723 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751491Ab0KWDTX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Nov 2010 22:19:23 -0500
In-Reply-To: <201011230001.20241.rjw@sisk.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Partha Basak <p-basak2@ti.com>, linux-omap@vger.kernel.org

On Tue, 23 Nov 2010, Rafael J. Wysocki wrote:

> > > Moreover, I'm not sure if we need an "IRQ safe" version of _idle.  Why do
> > > we need it, exactly?
> > 
> > Because pm_runtime_put_sync() calls rpm_idle().  If there were no 
> > irq-safe version of rpm_idle() then drivers wouldn't be able to call 
> > pm_runtime_put_sync() from within an interrupt handler.
> 
> Right.  Which they can't do now, can they?

True.  That was the point of this patch -- to allow interrupt handlers
to do runtime PM, which they can't do now.

> Why do you think we should allow them to do that?

Are you suggesting that interrupt handlers stick to pm_runtime_suspend 
and pm_runtime_resume, and ignore pm_runtime_get_sync and 
pm_runtime_put_sync?

Recall that after probing is finished, the driver core does a
pm_runtime_put_sync.  That might happen while an interrupt handler is
running on another CPU.  If the interrupt handler didn't increment the
usage_count, the driver core could cause the device to suspend while
the interrupt handler was still using it.

Or are you suggesting that interrupt handlers use pm_runtime_get_sync 
and implement a poor-man's version of pm_runtime_put_sync by doing:

	pm_runtime_put_no_idle();
	pm_runtime_suspend();

Is there some particular reason for denying interrupt handlers the
ability to use pm_runtime_put_sync?  It seems odd to disallow that 
while allowing pm_runtime_get_sync.

Or maybe you think that when pm_runtime_put_sync detects the 
usage_count has decremented to 0 and the device is irq-safe, it should 
call rpm_suspend directly instead of calling rpm_idle?

In short, I don't see any reason not to present the same API to
interrupt handlers for irq-safe devices as we present to
process-context drivers for ordinary devices.

> Anyway, though, if the only reason of doing this is to allow interrupt handlers
> to call pm_runtime_put_sync(), then I rather wouldn't do it at all.

Why not?

Alan Stern

