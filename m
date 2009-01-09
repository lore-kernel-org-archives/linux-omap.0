From: Tony Lindgren <tony@atomide.com>
Subject: Re: About to tag v2.6.28-omap1 on Friday
Date: Fri, 9 Jan 2009 14:30:43 +0200
Message-ID: <20090109123041.GO2536@atomide.com>
References: <20090107190427.GV27566@atomide.com> <20090108100600.GX27566@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:65129 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752846AbZAIMam (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Jan 2009 07:30:42 -0500
Content-Disposition: inline
In-Reply-To: <20090108100600.GX27566@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Felipe Balbi <felipe.balbi@nokia.com>

* Tony Lindgren <tony@atomide.com> [090108 12:07]:
> * Tony Lindgren <tony@atomide.com> [090107 21:04]:
> > Hi all,
> > 
> > I'm planning to tag v2.6.28-omap1 on Friday. I'll be going through
> > my omap inbox and applying some obvious fixes, but if anybody has
> > new fixes that should go in, please post them ASAP.
> 
> I've also pushed the recent 23 patch clock series from Paul,
> and merged in Kevin's omap-pm-upstream branch. So please give
> the current l-o head some testing on your favorite boards.

OK, I think this is pretty much it for applying patches for now,
or at least I don't seem to have any more fixes in my omap inbox.

Let's give it few days of testing and tag v2.6.28-omap1 on Sunday
if no issues pop up.

I'm wondering if we should apply "[PATCH 3/3] usb: musb: fix null
pointer check in musb_platform_init" as otherwise the system may not
boot.. Felipe, any comments on that?

Regards,

Tony
