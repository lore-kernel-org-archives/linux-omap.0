From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: Anyone using an ISP1505?
Date: Sat, 19 Dec 2009 15:35:20 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB031DB9AC6F@dbde02.ent.ti.com>
References: <4B2A7FFB.6090909@billgatliff.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB031DC20A68@dbde02.ent.ti.com>
 <4B2BD3B6.20407@billgatliff.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47647 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751189AbZLSKF0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 19 Dec 2009 05:05:26 -0500
In-Reply-To: <4B2BD3B6.20407@billgatliff.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Bill Gatliff <bgat@billgatliff.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "beagleboard@googlegroups.com" <beagleboard@googlegroups.com>

> >
> > Is it with the OTG controller or with the EHCI controller?
> >   
> 
> The pins of the ISP1505 are tied to pins T24, T23, and so on of the
> OMAP3530CUS, which on my schematic are labeled UH0_D0, UH0_D1, etc. 
> That's EHCI, right?  But I have both the EHCI and MUSB drivers enabled,
> and both appear to initialize properly according to the kernel logs.
> 

T23, T24, ... on the CUS package are for MUSB (the signals are hsusb0_*).

EHCI is hsusb[1-3]_*.

NOP XCEIV is what you should be using. I'm not sure why it is not working
for you. One of the OMAP3 EVM boards uses an NXP ISP1504 here, and it
should be very similar to what you're using.

Do you see a clock signal on R21 (UH0_CLK in your schematic I suppose)?

> 
> > If it's with the EHCI controller, you need to take care of a couple of
> > issues on the board (due to the input clocking mode used in the OMAP3).
> >   
> 
> Can you elaborate?  Thanks!

Forget this, since you're using MUSB.

- Anand
