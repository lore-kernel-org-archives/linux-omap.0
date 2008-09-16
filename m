From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [rfc] [patch] clean up to ehci-omap (Was: Re: [patch] omap:
	usb: ehci: fix use of hcd->regs)
Date: Tue, 16 Sep 2008 10:26:42 +0300
Message-ID: <20080916072638.GA2125@frodo>
References: <20080912121024.GG759@gandalf.research.nokia.com> <FCCFB4CDC6E5564B9182F639FC356087022A25316B@dbde02.ent.ti.com> <20080914185721.GB6943@frodo> <200809152247.15412.david-b@pacbell.net>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:47349 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751467AbYIPH1H (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Sep 2008 03:27:07 -0400
Content-Disposition: inline
In-Reply-To: <200809152247.15412.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: me@felipebalbi.com, "Pandita, Vikram" <vikram.pandita@ti.com>, Tony Lindgren <tony@atomide.com>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Mon, Sep 15, 2008 at 10:47:14PM -0700, David Brownell wrote:
> On Sunday 14 September 2008, Felipe Balbi wrote:
> 
> > +MODULE_ALIAS("plaform:omap-ehci");
> 
> "platform" ...

thanks. Missed it. It's fixed now.

-- 
balbi
