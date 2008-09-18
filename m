From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 3/5] watchdog: move omap_wdt.h to include/linux/watchdog
Date: Fri, 19 Sep 2008 02:14:54 +0300
Message-ID: <20080918231453.GK6617@frodo>
References: <1221776622-22906-1-git-send-email-me@felipebalbi.com> <1221776622-22906-2-git-send-email-me@felipebalbi.com> <1221776622-22906-3-git-send-email-me@felipebalbi.com> <1221776622-22906-4-git-send-email-me@felipebalbi.com> <20080918231034.GI14307@flint.arm.linux.org.uk>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:40031 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755271AbYIRXPF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Sep 2008 19:15:05 -0400
Content-Disposition: inline
In-Reply-To: <20080918231034.GI14307@flint.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Felipe Balbi <me@felipebalbi.com>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, David Brownell <david-b@pacbell.net>, "George G. Davis" <gdavis@mvista.com>, Wim Van Sebroeck <wim@iguana.be>, Felipe Balbi <felipe.balbi@nokia.com>

On Fri, Sep 19, 2008 at 12:10:34AM +0100, Russell King - ARM Linux wrote:
> On Fri, Sep 19, 2008 at 01:23:40AM +0300, Felipe Balbi wrote:
> > From: Felipe Balbi <felipe.balbi@nokia.com>
> > 
> > Create a new include/linux/watchdog directory
> > for holding watchdog chips headers, move omap_wdt.h
> > to the new location and update the include patch in
> > the driver source.
> 
> What's the reasoning for this change?  As far as I can see, omap_wdt.h
> is private to omap_wdt.c, and shouldn't be exposed to anyone else.
> In which case, leaving it along side omap_wdt.c is the right thing to
> do.
> 
> We don't have any rules which say all header files must be in the
> include/ sub-tree.

It's gonna be needed on patch 5/5. Maybe I should meld it in the same
patch ?

-- 
balbi
