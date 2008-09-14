From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: [rfc] [patch] clean up to ehci-omap (Was: Re: [patch] omap:
	usb: ehci: fix use of hcd->regs)
Date: Mon, 15 Sep 2008 00:11:46 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC356087022A25316B@dbde02.ent.ti.com>
References: <20080912121024.GG759@gandalf.research.nokia.com>
 <20080912182255.GD7132@frodo> <20080912183819.GE7132@frodo>
 <200809121216.27116.david-b@pacbell.net>
 <20080912192158.GG10675@atomide.com> <20080912192809.GF7132@frodo>
 <20080912193534.GH7132@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43113 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753551AbYINSnd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 14 Sep 2008 14:43:33 -0400
In-Reply-To: <20080912193534.GH7132@frodo>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "me@felipebalbi.com" <me@felipebalbi.com>
Cc: Tony Lindgren <tony@atomide.com>, David Brownell <david-b@pacbell.net>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>



> -----Original Message-----
> From: Felipe Balbi [mailto:me@felipebalbi.com]
> Sent: Saturday, September 13, 2008 1:06 AM
> To: Felipe Balbi
> Cc: Tony Lindgren; David Brownell; felipe.balbi@nokia.com; Linux OMAP Mailing List; Pandita, Vikram
> Subject: Re: [rfc] [patch] clean up to ehci-omap (Was: Re: [patch] omap: usb: ehci: fix use of hcd-
> >regs)
> 
> Hi Vikram,
> 
> Those "issues" mentioned on the ehci-omap driver, are them silicon
> version related ? I mean, does it happen on all omap3 silicons or
> doesn't it happen with only versions of them ?

The issues mentioned are _not_ of omap34xx silicon, but of the PHY (ISP1504 in SDP-USB expansion board).

> 
> Case the second, we can make the workarounds be applied based on runtime
> checks instead of #ifdefs. That would look nice.

Better still is to move the PHY issues to platform/board specific function.
Will try to submit a patch on that.

> 
> Also, it looks like PHY and TLL mode will be board specific, which means
> we can use a platform_data to pass the correct mode to the driver and
> get rid of those #ifdefs and Kconfig choices as well.

Yes that can be done.

> 
> Any comments ?
> 
> --
> balbi

