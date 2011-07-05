From: Alan Stern <stern@rowland.harvard.edu>
Subject: RE: [PATCH 6/6 v2] arm: omap: usb: global Suspend and resume support
 of ehci and ohci
Date: Tue, 5 Jul 2011 10:22:09 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1107051018580.2060-100000@iolanthe.rowland.org>
References: <41049fa81376d2973fa760cf061ee460@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <41049fa81376d2973fa760cf061ee460@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Partha Basak <p-basak2@ti.com>
Cc: Keshava Munegowda <keshava_mgowda@ti.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Anand Gadiyar <gadiyar@ti.com>, sameo@linux.intel.com, parthab@india.ti.com, tony@atomide.com, Kevin Hilman <khilman@ti.com>, Benoit Cousson <b-cousson@ti.com>, paul@pwsan.com, johnstul@us.ibm.com, Vishwanath Sripathy <vishwanath.bs@ti.com>
List-Id: linux-omap@vger.kernel.org

On Tue, 5 Jul 2011, Partha Basak wrote:

> >> Note that the parent per-se does not have any .suspend & .resume
> >hooked
> >> up.
> >
> >Why not?  That sounds like a big bug.
> 
> This was a design decision since the parent needs to be activated only
> when at-least one child is insmoded.
> 
> If the chidren are suspended, automatically the parent is suspended
> via the pm_runtime_putsync calls to the parent.

Now you know that this isn't true, because those calls don't get made 
while a system sleep transition is in progress.

> So, effectively, we do not need an explicit suspend for the parent.

Now you know that effectively you _do_ need an explicit suspend for the 
parent.

> >You have ignored a few very important points:
> >
> >Firstly, system suspend is supposed to work even when runtime PM is not
> >configured.
> >
> >Secondly, the user can disable runtime PM via sysfs at any time.  This
> >shouldn't mess up system suspend.
> >
> >Basically, it's a bad idea to mix up system suspend with runtime PM.
> 
> Your observations are correct but this is a generic limitation and Kevin
> is working
> on this problem in parallel.
> 
> As of now, all OMAP drivers are mandated to use ONLY runtime pm framework
> for enabling/disabling clocks. I will let Kevin comment further.

Okay, let's see what Kevin says.

Alan Stern
