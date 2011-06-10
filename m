From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] calling runtime PM from system PM methods
Date: Fri, 10 Jun 2011 13:17:56 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1106101317160.1921-100000@iolanthe.rowland.org>
References: <20110610155707.GN26436@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:51339 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755020Ab1FJRR5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Jun 2011 13:17:57 -0400
In-Reply-To: <20110610155707.GN26436@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org

On Fri, 10 Jun 2011, Mark Brown wrote:

> > Well, this is a SHOULD, not a MUST.  If you want your driver to leave a
> > device in a low-power state, it can do so.  Just bear in mind that the
> > PM core's idea of the device's runtime power state may end up not
> > matching reality unless you're careful.
> 
> This is part of the trouble, it all feels like a lot more work than it
> should be for relatively common cases.  In the audio case we're fine as
> the subsystem implements a completely independent PM infrastructure
> which ignores the PM core except for system suspend (and sometimes
> ignores that), it's noticably harder to reason about what's going on
> when I go outside there and when I think about what I'm doing it always
> feels like it should be possible to factor it out of the drivers.

What would make the common cases easier?

Alan Stern

