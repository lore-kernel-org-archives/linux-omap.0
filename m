From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH] watchdog: another ioremap() fix
Date: Thu, 18 Sep 2008 20:26:00 +0300
Message-ID: <20080918172557.GA23716@frodo>
References: <1221746146-18252-1-git-send-email-felipe.balbi@nokia.com> <200809181003.16664.david-b@pacbell.net>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:53250 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754751AbYIRR0r (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Sep 2008 13:26:47 -0400
Content-Disposition: inline
In-Reply-To: <200809181003.16664.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org, gdavis@mvista.com, Tony Lindgren <tony@atomide.com>, Russel King <rmk@dyn-67.arm.linux.org.uk>, wim@iguana.be

On Thu, Sep 18, 2008 at 10:03:16AM -0700, David Brownell wrote:
> On Thursday 18 September 2008, Felipe Balbi wrote:
> > convert to use ioremap() and __raw_{read/write} friends.
> 
> Why is this going to the OMAP list, not to LKML and cc'd
> the watchdog maintainer?  (I added Wim to the cc list...)
> 
> If it's worth having, it's worth having in mainline...

My bad, forgot to Cc lkml. I'll resend when Wim gives his ok on the
patch.

-- 
balbi
