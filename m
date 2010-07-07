From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH resend 1/3] AM35x: Add musb support
Date: Wed, 7 Jul 2010 10:53:04 +0300
Message-ID: <20100707075303.GD1874@gandalf>
References: <20100705102322.GR15951@atomide.com>
 <4C31B54F.6040109@ru.mvista.com>
 <20100705104841.GS15951@atomide.com>
 <19F8576C6E063C45BE387C64729E7394044EAAD8F6@dbde02.ent.ti.com>
 <20100705134552.GD15951@atomide.com>
 <4C31F135.5060108@ru.mvista.com>
 <19F8576C6E063C45BE387C64729E7394044EAADA64@dbde02.ent.ti.com>
 <20100706075707.GC3192@atomide.com>
 <20100706084603.GA3035@nokia.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB03238308B1@dbde02.ent.ti.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:38713 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752301Ab0GGHxC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Jul 2010 03:53:02 -0400
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB03238308B1@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, ext Tony Lindgren <tony@atomide.com>, "Gupta, Ajay Kumar" <ajay.gupta@ti.com>, Sergei Shtylyov <sshtylyov@mvista.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Wed, Jul 07, 2010 at 04:16:04AM +0530, Gadiyar, Anand wrote:
> Like it is done in ehci-hcd.c/ohci-hcd.c?

That's different, they export the platform_driver which gets probed by
ehci-hcd.c, here we would have a parent platform_driver instianting
correct dma device and musb device.

> This looks much easier to maintain.
> 
> Do you already have a patch doing this, or would you like me to spin one
> for RFC/RFT?

I started this yesterday before leaving the office, so not much done. If
you beat me to it, go for it :-)

-- 
balbi
