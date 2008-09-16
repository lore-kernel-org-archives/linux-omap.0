From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [rfc] [patch] clean up to ehci-omap (Was: Re: [patch] omap:
	usb: ehci: fix use of hcd->regs)
Date: Tue, 16 Sep 2008 11:28:44 +0300
Message-ID: <20080916082844.GB21952@gandalf.research.nokia.com>
References: <20080912121024.GG759@gandalf.research.nokia.com> <FCCFB4CDC6E5564B9182F639FC356087022A25316B@dbde02.ent.ti.com> <20080914185721.GB6943@frodo> <200809152249.34233.david-b@pacbell.net>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:47399 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752416AbYIPI3M (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Sep 2008 04:29:12 -0400
Content-Disposition: inline
In-Reply-To: <200809152249.34233.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext David Brownell <david-b@pacbell.net>
Cc: me@felipebalbi.com, "Pandita, Vikram" <vikram.pandita@ti.com>, Tony Lindgren <tony@atomide.com>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Mon, Sep 15, 2008 at 10:49:33PM -0700, David Brownell wrote:
> > +       dev_dbg(&dev->dev, "failed to initialized host controller\n");
> 
> ... and include the status code, to help identify *WHY* it failed
> (this is re #3 ... should have sent three separate emails, with
> inlined patches)

I didn't really to sent them for review. Was just trying to be sure
Vikram had my patches before he starts working on that driver, but sure;
when they're ready, I'll send them properly. Thanks for reviewing so far
;-)

-- 
balbi
