From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [linux-pm] calling runtime PM from system PM methods
Date: Fri, 10 Jun 2011 18:31:55 +0100
Message-ID: <20110610173154.GO26436@opensource.wolfsonmicro.com>
References: <20110610155707.GN26436@opensource.wolfsonmicro.com>
 <Pine.LNX.4.44L0.1106101317160.1921-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:50126 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756229Ab1FJRb5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 10 Jun 2011 13:31:57 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1106101317160.1921-100000@iolanthe.rowland.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org

On Fri, Jun 10, 2011 at 01:17:56PM -0400, Alan Stern wrote:
> On Fri, 10 Jun 2011, Mark Brown wrote:

> > ignores that), it's noticably harder to reason about what's going on
> > when I go outside there and when I think about what I'm doing it always
> > feels like it should be possible to factor it out of the drivers.

> What would make the common cases easier?

I think from an interface point of view it's something like
UNIVERSAL_DEV_PM_OPS() and friends, probably with some additional ops
that can do the glue bits like enabling wakeup and quiescing activity.
I'd need to think harder about what exactly that'd look like - for my
cases the fundamental thing I want to say is that there's one suspend
routine and one resume routine and I'd like some framework code to work
out when they're called.
