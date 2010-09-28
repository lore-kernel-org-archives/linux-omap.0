From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] runtime_pm_get_sync() from ISR with IRQs disabled?
Date: Tue, 28 Sep 2010 20:19:07 +0200
Message-ID: <201009282019.07598.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1009281033230.17050-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:50416 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757607Ab0I1SUA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 28 Sep 2010 14:20:00 -0400
In-Reply-To: <Pine.LNX.4.44L0.1009281033230.17050-100000@iolanthe.rowland.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pm@lists.linux-foundation.org, Kevin Hilman <khilman@deeprootsystems.com>, Partha Basak <p-basak2@ti.com>, linux-omap@vger.kernel.org

On Tuesday, September 28, 2010, Alan Stern wrote:
> On Mon, 27 Sep 2010, Rafael J. Wysocki wrote:
> 
> > On Monday, September 27, 2010, Alan Stern wrote:
> > > On Mon, 27 Sep 2010, Rafael J. Wysocki wrote:
...
> Given this, I see no point in adding a special per-call flag.
> 
> There's another advantage to using a per-device flag.  Not all resume
> calls are initiated by the driver; the PM core has to start a resume on
> its own when rpm_resume sees that the device's parent is suspended.  
> When this happens, the nested resume can be carried out with interrupts
> disabled if the parent's driver supports it -- and the PM core won't
> know that unless there's a flag for it in dev_pm_info.

OK, go for it, then.

Thanks,
Rafael
