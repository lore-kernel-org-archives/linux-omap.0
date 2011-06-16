From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] calling runtime PM from system PM methods
Date: Thu, 16 Jun 2011 10:27:58 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1106161017310.2204-100000@iolanthe.rowland.org>
References: <87boxytw05.fsf@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:58652 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1758217Ab1FPO17 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Jun 2011 10:27:59 -0400
In-Reply-To: <87boxytw05.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Paul Walmsley <paul@pwsan.com>

On Wed, 15 Jun 2011, Kevin Hilman wrote:

> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
> 
> > On Wednesday, June 15, 2011, Kevin Hilman wrote:
> 
> [...]
> 
> >>
> >> From a device driver perspective, system PM is just runtime
> >> PM where the "idleness" was forced and only a subset of possible wakeup
> >> sources are enabled.
> >
> > Oh well, I wonder how much of a difference would make you think those things
> > are really different. ;-)
> 
> Seeing a description of the differences would help.  So far the list is
> rather short: wakeups and forcibly quieting the hardware.

Another difference is that the user can forbid runtime power management 
of any device through the power/control attribute, independently of 
system sleeps.

Yet another difference arises because during system PM, the PM
workqueue is frozen.  If a driver relies on asynchronous runtime PM
then nothing will happen.  This may not apply to you, but it applies to
plenty of other drivers.

> I guess I still don't see why system PM cannot be viewed as a special
> case of runtime PM, so how about a specific question: From a device
> driver perspective, how is system PM anything other than
> manually/forcibly creating the right conditions for a runtime PM
> transition to happen?

What you're missing is that runtime PM has two separate aspects: a 
hardware/power aspect and an administrative aspect.  In terms of 
hardware/power it is very similar to system PM, but in administrative 
terms it is quite different.

Another thing you need to realize: Rafael is open to the idea that
subsystems may be designed specifically to allow drivers to use runtime
PM during their ->suspend and ->resume callbacks.  However in the
period between ->suspend returning and ->resume being called, runtime
PM should _not_ be used.  In particular, this includes the times when
->suspend_noirq and ->resume_noirq are called -- and these are the
routines which are often expected to do the real work of setting the
device's power state.

Alan Stern

