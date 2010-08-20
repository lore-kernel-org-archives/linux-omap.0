From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] [PATCH] PM: runtime PM + idle: allow usage when
 interrupts are disabled
Date: Fri, 20 Aug 2010 10:14:01 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1008201006430.1716-100000@iolanthe.rowland.org>
References: <87lj82gujm.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:44185 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752428Ab0HTOOD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Aug 2010 10:14:03 -0400
In-Reply-To: <87lj82gujm.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org

On Thu, 19 Aug 2010, Kevin Hilman wrote:

> > In any case, I don't really like this change.  It seems that we would
> > be better off preventing the runtime PM calls from occurring in the
> > first place while interrupts are disabled.  
> 
> Why? 

Because that's how the Runtime PM framework was designed.  Drivers 
expect interrupts to be enabled when their runtime PM callbacks are 
invoked.  And the framework internally depends on it as well.

> > In fact, it's hard to see what could cause this to happen at all.
> 
> As I mentioned in the changelog, this happens when trying to use runtime
> PM in combination with CPUidle.  As has been suggested elsewhere[1],
> there is a need to do runtime PM on some devices in combination with CPU
> idle transitions managed by CPUidle.  However, late in the idle path,
> at the time we want to manage these IO devices, interrupts are disabled.

Then it isn't really feasible to use the runtime PM framework for those 
devices.  Not unless the framework is extended with new functions meant 
to be used without interrupts enabled (in which case it doesn't seem to 
matter much whether you are in process context or not).

> Currently, on OMAP, we are already managing the power state of certain
> IO devices along with CPUidle transitions using more brute force
> methods.  IMO, using runtime PM for this would be a much cleaner
> approach.  The only obstacle is the assumption that the API must be
> called with interrupts enabled.

That's a big obstacle.  Why can't you manage these devices earlier, 
while interrupts are still enabled?

Alan Stern

