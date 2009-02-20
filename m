From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH] usb: musb: adding support for registering nop xceiv
Date: Fri, 20 Feb 2009 18:43:04 +0200
Message-ID: <20090220164303.GL32564@gandalf>
References: <1231412036-7371-1-git-send-email-ajay.gupta@ti.com> <20090112222946.GN25493@frodo> <19F8576C6E063C45BE387C64729E739403ECF7156B@dbde02.ent.ti.com> <20090220164139.GM7414@atomide.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:34294 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751800AbZBTQnM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Feb 2009 11:43:12 -0500
Content-Disposition: inline
In-Reply-To: <20090220164139.GM7414@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>, "me@felipebalbi.com" <me@felipebalbi.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "david-b@pacbell.net" <david-b@pacbell.net>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>

On Fri, Feb 20, 2009 at 08:41:40AM -0800, Tony Lindgren wrote:
> * Gupta, Ajay Kumar <ajay.gupta@ti.com> [090119 02:39]:
> > > -----Original Message-----
> > > From: Felipe Balbi [mailto:me@felipebalbi.com]
> > > Sent: Tuesday, January 13, 2009 4:00 AM
> > > To: Gupta, Ajay Kumar
> > > Cc: linux-omap@vger.kernel.org; david-b@pacbell.net; felipe.balbi@nokia.com
> > > Subject: Re: [PATCH] usb: musb: adding support for registering nop xceiv
> > > 
> > > On Thu, Jan 08, 2009 at 04:23:56PM +0530, Ajay Kumar Gupta wrote:
> > > > Adding support for registering nop usb transceiver for musb
> > > > platforms. Tested with OMAP35xx EVM having OTG phy ISP1504
> > > > which is autonomous and doesn't require any phy programming.
> > > >
> > > > Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
> > > 
> > > Tony, if Dave is ok with the nop-xceiv, we can apply this to l-o and
> > > people who doesn't use twl4030/tlw5030 xceiv will have to select this
> > > driver.
> > 
> > Hi David,
> > 
> > Please review this one too.
> 
> According to Felipe this is in Greg's queue, so I'll apply this to
> linux-omap to wait for it to fall down from mainline.

well, the driver itself, not the usb-musb.c part. Well, this will help
boards with use ispXXXX transceivers to work :-)

-- 
balbi
