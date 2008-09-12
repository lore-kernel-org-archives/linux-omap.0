From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [rfc] [patch] clean up to ehci-omap (Was: Re: [patch] omap:
	usb: ehci: fix use of hcd->regs)
Date: Fri, 12 Sep 2008 23:38:34 +0300
Message-ID: <20080912203834.GI7132@frodo>
References: <20080912121024.GG759@gandalf.research.nokia.com> <20080912182255.GD7132@frodo> <20080912183819.GE7132@frodo> <200809121216.27116.david-b@pacbell.net> <5A47E75E594F054BAF48C5E4FC4B92AB02C4007EC4@dbde02.ent.ti.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:52609 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753314AbYILUis (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Sep 2008 16:38:48 -0400
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB02C4007EC4@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: "me@felipebalbi.com" <me@felipebalbi.com>, Tony Lindgren <tony@atomide.com>, David Brownell <david-b@pacbell.net>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Sat, Sep 13, 2008 at 01:31:12AM +0530, Gadiyar, Anand wrote:
> Was planning on cleaning up this driver and sending to linux-omap as Tony
> suggested, but I'm afraid I won't be able to look at it for a while.
> 
> So if you're going to be doing this anyway, then could you please meld in
> Vikram's other patch from [1] as well?

Do you think we should just drop support for the older versions of the
expansion board ?

> By the way, how do you propose to test this driver? Do you have the
> expansion board for the SDP, or some other hardware that can be used?

I have one version of beagle with one ehci port ;-)

-- 
balbi
