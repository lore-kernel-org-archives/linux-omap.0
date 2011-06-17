From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] calling runtime PM from system PM methods
Date: Fri, 17 Jun 2011 23:29:36 +0200
Message-ID: <201106172329.37087.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1106171554510.2143-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:37918 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755629Ab1FQV3D (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 17 Jun 2011 17:29:03 -0400
In-Reply-To: <Pine.LNX.4.44L0.1106171554510.2143-100000@iolanthe.rowland.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, Kevin Hilman <khilman@ti.com>, Magnus Damm <magnus.damm@gmail.com>, Paul Walmsley <paul@pwsan.com>

On Friday, June 17, 2011, Alan Stern wrote:
> On Fri, 17 Jun 2011, Rafael J. Wysocki wrote:
> 
> > Having considered that a bit more I see that, in fact, commit
> > e8665002477f0278f84f898145b1f141ba26ee26 (PM: Allow pm_runtime_suspend() to
> > succeed during system suspend) has introduced at least one regression.
> > Namely, the PCI bus type runs pm_runtime_resume() in its .prepare()
> > callback to guarantee that devices will be in a well known state before
> > the PCI .suspend() and .suspend_noirq() callbacks are executed.
> > Unfortunately, after commit e8665002477f0278f84f898145b1f141ba26ee26 this
> > isn't valid any more, because devices can be runtime-suspend after the
> > pm_runtime_resume() in .prepare() has run.
> > 
> > USB seems to do something similar in choose_wakeup().
> > 
> > So, either the both of these subsystems should be modified to use
> > pm_runtime_get_sync() and then pm_runtime_put_<something>() some time
> > during resume, or we should revert commit e8665002477f0278f84f898145b1f141ba26ee26.
> 
> pm_runtime_put_noidle would be appropriate.
> 
> > Quite frankly, which shouldn't be a surprise to anyone at this point, I'd
> > prefer to revert that commit for 3.0.
> 
> Maybe we can compromise.  Instead of reverting that commit outright,
> put the get_noresume just before the suspend callback and put the
> put_sync just after the resume callback.

That wouldn't fix the PCI problem, though, because it would leave a small
window in which the device could be suspended after the pm_runtime_resume()
in pci_pm_prepare() had run.

Thanks,
Rafael
