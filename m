From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] OMAPDSS: Check if RPM enabled before trying to change
 state
Date: Tue, 26 Jun 2012 10:34:37 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1206261031450.1636-100000@iolanthe.rowland.org>
References: <CANOLnOP_z47QCB234y-BOWyRGHeO8u-pJct=Kq6+2XCig-tX=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:34178 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756863Ab2FZOei (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Jun 2012 10:34:38 -0400
In-Reply-To: <CANOLnOP_z47QCB234y-BOWyRGHeO8u-pJct=Kq6+2XCig-tX=w@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: Rajendra Nayak <rnayak@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, jaswinder.singh@linaro.org, mythripk@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, andy.green@linaro.org, n-dechesne@ti.com, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org

On Tue, 26 Jun 2012, Grazvydas Ignotas wrote:

> CCing some PM people, maybe they can comment?
> 
> On Tue, Jun 26, 2012 at 7:51 AM, Rajendra Nayak <rnayak@ti.com> wrote:
> > On Monday 25 June 2012 06:20 PM, Tomi Valkeinen wrote:
> >>
> >> Do you know how the drivers should handle CONFIG_PM_RUNTIME=n?
> >> Are they supposed to handle the error values returned by runtime PM
> >> functions somehow, or should they use #ifdef CONFIG_PM_RUNTIME?
> >
> > hmm, I always though with CONFIG_RUNTIME_PM=n, the functions would
> > be stubbed to return success and not failure.

Not exactly.  They are stubbed to indicate that the device cannot be 
suspended, that it is always active.

Failure to suspend a device should not be regarded as particularly bad, 
because it doesn't affect the device's functionality.  That's true even 
when CONFIG_RUNTIME_PM is enabled.

> And the _pm_runtime_resume
> > function indeed seems to return 1, which is not failure but just saying
> > that your device is already active/enabled.
> > The _pm_runtime_suspend and _pm_runtime_idle do return a -ENOSYS, which
> > is something only returned when CONFIG_RUNTIME_PM=n, so if you really
> > want to handle failing pm_runtime_put_sync cases, maybe you still can.
> > But then, I don't know if there is anything you can do to recover from
> > a failing pm_runtime_put_sync, except for warning the user maybe.

I don't see much point in warning the user that a device was unable to 
go to low power.

Alan Stern

