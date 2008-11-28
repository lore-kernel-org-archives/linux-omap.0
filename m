From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 3/3] musb: Remvoing twl4030 dependency for OMAP3EVM MUSB
Date: Fri, 28 Nov 2008 19:59:02 +0200
Message-ID: <20081128175902.GD6525@frodo>
References: <1227850104-16166-1-git-send-email-mani.pillai@ti.com> <200811272302.43295.david-b@pacbell.net> <19F8576C6E063C45BE387C64729E739403E904EBCD@dbde02.ent.ti.com> <200811280925.26736.david-b@pacbell.net>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:43973 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751491AbYK1R7M (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Nov 2008 12:59:12 -0500
Content-Disposition: inline
In-Reply-To: <200811280925.26736.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>, "Pillai, Manikandan" <mani.pillai@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, Nov 28, 2008 at 09:25:26AM -0800, David Brownell wrote:
> So the answer for you is obviously to have something
> other than the musb driver hold your otg_transceiver
> driver.  Like ... an isp1504.c I2C driver, which will
> eventually move to drivers/usb/otg and which calls
> the otg_set_transceiver() utility.

There's one problem here. If this is similar to isp1704, it doesn't have
a control interface. And the only way to talk to the transceiver is via
ULPI. I have patches that add musb_ulpi_read/write functions using the
musb ulpi wrapper. BUT, isp1x04 is pretty much autonomous, there isn't
much you can/have to do, the problem with them is that they don't have
an interrupt line with omap (afaict) so it's difficult to be sure when
we have to e.g. switch to host mode unless we keep polling the INT_STS
register for changes. That's too bad.

But other than that, I agree with you completely. I won't queue up
patches adding such kind of ifdefs.

-- 
balbi
