From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: [PATCH 1/3 v3] AM35x: Add musb support
Date: Sat, 29 May 2010 09:59:18 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044E6D2537@dbde02.ent.ti.com>
References: <4BFFCE8C.40909@ru.mvista.com>
 <579055.3526.qm@web180308.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54243 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750858Ab0E2E31 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 29 May 2010 00:29:27 -0400
In-Reply-To: <579055.3526.qm@web180308.mail.gq1.yahoo.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>, Sergei Shtylyov <sshtylyov@mvista.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> > > AM35x has musb interface (version 1.8) and uses CPPI41
> > DMA engine.
> > > It has USB phy built inside the IP itself.
> 
> So it's more like DaVinci (earlier CPPI as well as
> integrated PHY) than OMAP3...

Yes. Actually they removed original musb controller from OMAP3
and replaced it with DaVinci family musb ip.

-Ajay
> 
> > > Also added ARCH_AM35x which is required to
> > differentiate musb ips
> > > between OMAP3x and AM35x.

