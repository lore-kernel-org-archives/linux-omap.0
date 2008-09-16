From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [rfc] [patch] clean up to ehci-omap (Was: Re: [patch] omap:
	usb: ehci: fix use of hcd->regs)
Date: Tue, 16 Sep 2008 10:28:49 +0300
Message-ID: <20080916072847.GB2125@frodo>
References: <20080912121024.GG759@gandalf.research.nokia.com> <FCCFB4CDC6E5564B9182F639FC356087022A25316B@dbde02.ent.ti.com> <20080914185721.GB6943@frodo> <200809152248.19959.david-b@pacbell.net>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:47612 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750770AbYIPH3N (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Sep 2008 03:29:13 -0400
Content-Disposition: inline
In-Reply-To: <200809152248.19959.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: me@felipebalbi.com, "Pandita, Vikram" <vikram.pandita@ti.com>, Tony Lindgren <tony@atomide.com>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Mon, Sep 15, 2008 at 10:48:19PM -0700, David Brownell wrote:
> > Subject: [PATCH 2/4] omap: usb: ehci: switch to use gpiolib
> >
> > Quit using omap-specific gpio handling and start using
> > gpiolib for ehci-omap.c
> >
> > Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> 
> ... yes, but also move all the pinmuxing to arch/arm/plat-omap/something

usb_ehci_init() also needs to be changed. For now I'm only dealing with
the driver itself, board init code will be dealt with on later patches.

-- 
balbi
