From: Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH] watchdog: another ioremap() fix
Date: Fri, 19 Sep 2008 10:06:55 +0200
Message-ID: <20080919080655.GE22550@infomag.infomag.iguana.be>
References: <1221746146-18252-1-git-send-email-felipe.balbi@nokia.com> <200809181003.16664.david-b@pacbell.net> <20080918172557.GA23716@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailrelay003.isp.belgacom.be ([195.238.6.53]:21026 "EHLO
	mailrelay003.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750914AbYISIHF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 19 Sep 2008 04:07:05 -0400
Content-Disposition: inline
In-Reply-To: <20080918172557.GA23716@frodo>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: David Brownell <david-b@pacbell.net>, Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org, gdavis@mvista.com, Tony Lindgren <tony@atomide.com>, Russel King <rmk@dyn-67.arm.linux.org.uk>

Hi Balbi,

> > > convert to use ioremap() and __raw_{read/write} friends.
> > 
> > Why is this going to the OMAP list, not to LKML and cc'd
> > the watchdog maintainer?  (I added Wim to the cc list...)
> > 
> > If it's worth having, it's worth having in mainline...
> 
> My bad, forgot to Cc lkml. I'll resend when Wim gives his ok on the
> patch.

This is signed-off-by me.

Greetings,
Wim.

