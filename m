From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] runtime_pm_get_sync() from ISR with IRQs disabled?
Date: Mon, 27 Sep 2010 16:39:38 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1009271636170.1751-100000@iolanthe.rowland.org>
References: <201009272200.49330.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:56373 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753328Ab0I0Ujj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 27 Sep 2010 16:39:39 -0400
In-Reply-To: <201009272200.49330.rjw@sisk.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org, Kevin Hilman <khilman@deeprootsystems.com>, Partha Basak <p-basak2@ti.com>, linux-omap@vger.kernel.org

On Mon, 27 Sep 2010, Rafael J. Wysocki wrote:

> > How about adding another flag to the dev_pm_info structure, to indicate 
> > that the runtime callbacks may be called in interrupt context?
> > 
> > Maybe that will lead to problems I haven't thought of.  But if it seems 
> > okay to you, I can code it up easily enough.
> 
> Hmm.  I was thinking about adding a new RPM_ flag for that, like RPM_FASTPATH,
> telling the PM core to assume the callbacks will not sleep and that the call
> might be from interrupt handler.

That might appear more flexible, but is there any advantage to it?  
That is, would there be a situation where the driver knows that the 
next callback won't sleep but in general the callback might sleep 
sometimes?  It doesn't seem very likely.

Kevin, do you have any feelings about this?

Alan Stern

