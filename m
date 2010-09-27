From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] runtime_pm_get_sync() from ISR with IRQs disabled?
Date: Mon, 27 Sep 2010 23:09:22 +0200
Message-ID: <201009272309.22530.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1009271636170.1751-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:47324 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751930Ab0I0VKY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 27 Sep 2010 17:10:24 -0400
In-Reply-To: <Pine.LNX.4.44L0.1009271636170.1751-100000@iolanthe.rowland.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pm@lists.linux-foundation.org, Kevin Hilman <khilman@deeprootsystems.com>, Partha Basak <p-basak2@ti.com>, linux-omap@vger.kernel.org

On Monday, September 27, 2010, Alan Stern wrote:
> On Mon, 27 Sep 2010, Rafael J. Wysocki wrote:
> 
> > > How about adding another flag to the dev_pm_info structure, to indicate 
> > > that the runtime callbacks may be called in interrupt context?
> > > 
> > > Maybe that will lead to problems I haven't thought of.  But if it seems 
> > > okay to you, I can code it up easily enough.
> > 
> > Hmm.  I was thinking about adding a new RPM_ flag for that, like RPM_FASTPATH,
> > telling the PM core to assume the callbacks will not sleep and that the call
> > might be from interrupt handler.
> 
> That might appear more flexible, but is there any advantage to it?  
> That is, would there be a situation where the driver knows that the 
> next callback won't sleep but in general the callback might sleep 
> sometimes?  It doesn't seem very likely.

A flag in dev_pm_info, when set, would always make the PM core behave as
though the call was made from interrupt context, even if it really wasn't,
while the RPM_ flag would allow the driver to tell it to do that when it's
really necessary.  The driver always knows which calls are made from an
interrupt handler. :-)

Thanks,
Rafael
