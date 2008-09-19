From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 5/5] watchdog: introduce platform_data and remove cpu
	conditional code
Date: Fri, 19 Sep 2008 11:15:45 +0300
Message-ID: <20080919081542.GO6617@frodo>
References: <1221776622-22906-1-git-send-email-me@felipebalbi.com> <1221776622-22906-2-git-send-email-me@felipebalbi.com> <1221776622-22906-3-git-send-email-me@felipebalbi.com> <1221776622-22906-4-git-send-email-me@felipebalbi.com> <1221776622-22906-5-git-send-email-me@felipebalbi.com> <1221776622-22906-6-git-send-email-me@felipebalbi.com> <20080918232006.GJ14307@flint.arm.linux.org.uk> <20080918232324.GM6617@frodo> <20080919074633.GA12368@flint.arm.linux.org.uk>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:46050 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750945AbYISIQP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Sep 2008 04:16:15 -0400
Content-Disposition: inline
In-Reply-To: <20080919074633.GA12368@flint.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Felipe Balbi <me@felipebalbi.com>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, David Brownell <david-b@pacbell.net>, "George G. Davis" <gdavis@mvista.com>, Wim Van Sebroeck <wim@iguana.be>, Felipe Balbi <felipe.balbi@nokia.com>

On Fri, Sep 19, 2008 at 08:46:34AM +0100, Russell King - ARM Linux wrote:
> On Fri, Sep 19, 2008 at 02:23:25AM +0300, Felipe Balbi wrote:
> > On Fri, Sep 19, 2008 at 12:20:06AM +0100, Russell King - ARM Linux wrote:
> > > On Fri, Sep 19, 2008 at 01:23:42AM +0300, Felipe Balbi wrote:
> > > > +struct omap_wdt_platform_data {
> > > > +	const char	*ick;
> > > > +	const char	*fck;
> > > 
> > > Grumble.  The clk API is supposed to make this stuff completely
> > > unnecessary - but OMAP doesn't implement the clk API correctly -
> > > by using the 'name' as the sole key.  The 'name' argument is
> > > supposed to be used to disambiguate between multiple clock
> > > inputs on a single device. ;(
> > 
> > Yes, and we have two clocks for the same device_id on the bus. Right ?
> 
> That's not a problem.  I have an solution to solve this, but for the
> time being, let's just keep the logic inside the omap_wdt driver.

Ok, I'll wait on this patch then. The sync with mainline and ioremap()
fix will be going to Wim soon, I just need to test for a while.

-- 
balbi
