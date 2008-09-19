From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 5/5] watchdog: introduce platform_data and remove cpu conditional code
Date: Fri, 19 Sep 2008 08:46:34 +0100
Message-ID: <20080919074633.GA12368@flint.arm.linux.org.uk>
References: <1221776622-22906-1-git-send-email-me@felipebalbi.com> <1221776622-22906-2-git-send-email-me@felipebalbi.com> <1221776622-22906-3-git-send-email-me@felipebalbi.com> <1221776622-22906-4-git-send-email-me@felipebalbi.com> <1221776622-22906-5-git-send-email-me@felipebalbi.com> <1221776622-22906-6-git-send-email-me@felipebalbi.com> <20080918232006.GJ14307@flint.arm.linux.org.uk> <20080918232324.GM6617@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:59186 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750800AbYISHqy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Sep 2008 03:46:54 -0400
Content-Disposition: inline
In-Reply-To: <20080918232324.GM6617@frodo>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, David Brownell <david-b@pacbell.net>, "George G. Davis" <gdavis@mvista.com>, Wim Van Sebroeck <wim@iguana.be>, Felipe Balbi <felipe.balbi@nokia.com>

On Fri, Sep 19, 2008 at 02:23:25AM +0300, Felipe Balbi wrote:
> On Fri, Sep 19, 2008 at 12:20:06AM +0100, Russell King - ARM Linux wrote:
> > On Fri, Sep 19, 2008 at 01:23:42AM +0300, Felipe Balbi wrote:
> > > +struct omap_wdt_platform_data {
> > > +	const char	*ick;
> > > +	const char	*fck;
> > 
> > Grumble.  The clk API is supposed to make this stuff completely
> > unnecessary - but OMAP doesn't implement the clk API correctly -
> > by using the 'name' as the sole key.  The 'name' argument is
> > supposed to be used to disambiguate between multiple clock
> > inputs on a single device. ;(
> 
> Yes, and we have two clocks for the same device_id on the bus. Right ?

That's not a problem.  I have an solution to solve this, but for the
time being, let's just keep the logic inside the omap_wdt driver.
