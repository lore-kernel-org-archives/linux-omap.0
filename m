From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] watchdog: another ioremap() fix
Date: Thu, 18 Sep 2008 21:34:01 +0100
Message-ID: <20080918203401.GC14307@flint.arm.linux.org.uk>
References: <1221746146-18252-1-git-send-email-felipe.balbi@nokia.com> <200809181003.16664.david-b@pacbell.net> <20080918195007.GA14307@flint.arm.linux.org.uk> <20080918200245.GA6617@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:49674 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754110AbYIRUeZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Sep 2008 16:34:25 -0400
Content-Disposition: inline
In-Reply-To: <20080918200245.GA6617@frodo>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: David Brownell <david-b@pacbell.net>, Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org, gdavis@mvista.com, Tony Lindgren <tony@atomide.com>, wim@iguana.be

On Thu, Sep 18, 2008 at 11:02:58PM +0300, Felipe Balbi wrote:
> Well, what can I say. I'll try to get rid of those cpu conditional code
> in the driver and sync omap_wdt.c with mainline. Send all the patches
> via Wim, so Tony can get them later.

BTW, I'd also suggest copying Andrew Morton as well - I think Wim doesn't
have very much time to spend doing kernel stuff, so you may not receive
a reply for a while.  If Andrew takes the patches, then you have to
worry less about Wim forgetting about them (or if Andrew times out
pinging Wim, akpm may decide to send them up to Linus himself, or akpm
might re-route them via someone else like me.)
