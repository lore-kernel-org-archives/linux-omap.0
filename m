From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: USB on OMAP3530
Date: Wed, 18 Feb 2009 23:18:41 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02F51543C1@dbde02.ent.ti.com>
References: <E1LZpYv-0003FK-Ae@amazonia.comcast.net>,<20090218172055.GD32125@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34591 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752459AbZBRRup convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Feb 2009 12:50:45 -0500
In-Reply-To: <20090218172055.GD32125@frodo>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "me@felipebalbi.com" <me@felipebalbi.com>, Rick Bronson <rick@efn.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> From: linux-omap-owner@vger.kernel.org [linux-omap-owner@vger.kernel.org] On Behalf Of Felipe Balbi [me@felipebalbi.com]
> On Wed, Feb 18, 2009 at 08:46:17AM -0800, Rick Bronson wrote:
> > Hello,
> >
> >   I've got a new board with a OMAP3530 that's wired to a "ULPI Hi-Speed
> > USB host and peripheral transceiver" (NXP ISP1505) on UH0-D0-7,
> > UH0-CLK, UH0-STP, UH0-DIR, UH0-NXT.  There is also a mux to switch
> > from host to device on GPIO_140.
> >
> >   What set of kernel configs should I enable?  Here's what I have:
> 
> you need to enable CONFIG_USB_EHCI_HCD

Confused. Why?

Isn't this the MUSB port?

- Anand
