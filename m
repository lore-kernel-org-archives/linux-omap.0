From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: USB on OMAP3530
Date: Wed, 18 Feb 2009 19:55:08 +0200
Message-ID: <20090218175507.GF32125@frodo>
References: <20090218172055.GD32125@frodo> <5A47E75E594F054BAF48C5E4FC4B92AB02F51543C1@dbde02.ent.ti.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:59137 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751380AbZBRRzO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Feb 2009 12:55:14 -0500
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB02F51543C1@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: "me@felipebalbi.com" <me@felipebalbi.com>, Rick Bronson <rick@efn.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, Feb 18, 2009 at 11:18:41PM +0530, Gadiyar, Anand wrote:
> > From: linux-omap-owner@vger.kernel.org [linux-omap-owner@vger.kernel.org] On Behalf Of Felipe Balbi [me@felipebalbi.com]
> > On Wed, Feb 18, 2009 at 08:46:17AM -0800, Rick Bronson wrote:
> > > Hello,
> > >
> > >   I've got a new board with a OMAP3530 that's wired to a "ULPI Hi-Speed
> > > USB host and peripheral transceiver" (NXP ISP1505) on UH0-D0-7,
> > > UH0-CLK, UH0-STP, UH0-DIR, UH0-NXT.  There is also a mux to switch
> > > from host to device on GPIO_140.
> > >
> > >   What set of kernel configs should I enable?  Here's what I have:
> > 
> > you need to enable CONFIG_USB_EHCI_HCD
> 
> Confused. Why?
> 
> Isn't this the MUSB port?

ugh, my mistake... didn't see the "and peripheral" there :-p

so Rick, you need to load a gadget driver for musb to work, g_ether or
g_zero are the simplest ones.

-- 
balbi
