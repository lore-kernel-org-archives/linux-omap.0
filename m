From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [rfc] [patch] clean up to ehci-omap (Was: Re: [patch] omap:
	usb: ehci: fix use of hcd->regs)
Date: Fri, 12 Sep 2008 22:35:35 +0300
Message-ID: <20080912193534.GH7132@frodo>
References: <20080912121024.GG759@gandalf.research.nokia.com> <20080912182255.GD7132@frodo> <20080912183819.GE7132@frodo> <200809121216.27116.david-b@pacbell.net> <20080912192158.GG10675@atomide.com> <20080912192809.GF7132@frodo>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:36633 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752615AbYILTfr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Sep 2008 15:35:47 -0400
Content-Disposition: inline
In-Reply-To: <20080912192809.GF7132@frodo>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: Tony Lindgren <tony@atomide.com>, David Brownell <david-b@pacbell.net>, felipe.balbi@nokia.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Vikram Pandita <vikram.pandita@ti.com>

Hi Vikram,

Those "issues" mentioned on the ehci-omap driver, are them silicon
version related ? I mean, does it happen on all omap3 silicons or
doesn't it happen with only versions of them ?

Case the second, we can make the workarounds be applied based on runtime
checks instead of #ifdefs. That would look nice.

Also, it looks like PHY and TLL mode will be board specific, which means
we can use a platform_data to pass the correct mode to the driver and
get rid of those #ifdefs and Kconfig choices as well.

Any comments ?

-- 
balbi
