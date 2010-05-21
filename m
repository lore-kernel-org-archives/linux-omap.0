From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: [PATCH 3/3 v2] musb: AM35x: Workaround for fifo read issue
Date: Fri, 21 May 2010 12:08:14 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044E535F05@dbde02.ent.ti.com>
References: <1274184586-28843-1-git-send-email-ajay.gupta@ti.com>
 <19F8576C6E063C45BE387C64729E7394044E535C95@dbde02.ent.ti.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB0322EAE899@dbde02.ent.ti.com>
 <20100520100630.GF9992@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43581 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751864Ab0EUGic convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 May 2010 02:38:32 -0400
In-Reply-To: <20100520100630.GF9992@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, "Gadiyar, Anand" <gadiyar@ti.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "andrea.marson@dave.eu" <andrea.marson@dave.eu>, Tony Lindgren <tony@atomide.com>

Hi,
> >It would not scale very well - we already have multi-omap builds
> >that select support for multiple boards. If the AM35x boards are
> >part of such builds, then mutually exclusive config options won't
> >work - already n8x0 MUSB is exclusive with 243x/omap3.
> >
> >If it is possible to detect the AM35x at runtime, then we could
> >handle this well. Also, a similar set of changes will be needed for
> >the DMA code as well (right now we can pick only one of the DMA
> >engines at a time).
> 
> it's time to split out platform code from musb core. I was thinking of
> having omap2430.c blackfin.c tusb6010.c davinci.c be a platform_device
> that instantiates musb_hdrc platform_device. It would also ioremap() the
> area and pass the gotten/enabled clock to musb. Then we can have all of
> the platforms enabled since the board files would pass down the
> platform_device for the platform code. Something like:

This approach would anyway not help the original issue discussed
in this thread. We need to have some config option to differentiate
musb ips between OMAP3 and AM35x.

Another issue: Currently almost 90% of the code is same between
drivers/usb/musb/da8xx.c and drivers/usb/musb/am3517.c. any idea
on how to avoid duplication?  

Can we merge these two files and have compilation flags based on musb
capability alone (like HAS_CPPI41) rather than CONFIG_ARCH_xx? This
approach would also help the original issue of discussed in this thread.

-Ajay
> 
> arch/arm/mach-omap2/usb-musb.c:
> 
[..]
