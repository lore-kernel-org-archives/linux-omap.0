From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: Anyone using an ISP1505?
Date: Tue, 22 Dec 2009 01:42:15 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB031DC20A80@dbde02.ent.ti.com>
References: <4B2A7FFB.6090909@billgatliff.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB031DC20A68@dbde02.ent.ti.com>
 <4B2BD3B6.20407@billgatliff.com>
 <FCCFB4CDC6E5564B9182F639FC35608702FFDF312B@dbde02.ent.ti.com>
 <4B2FAB22.90000@billgatliff.com>
 <FCCFB4CDC6E5564B9182F639FC35608703001E1949@dbde02.ent.ti.com>,<4B2FD0EB.7030005@billgatliff.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42028 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754606AbZLUUMW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Dec 2009 15:12:22 -0500
In-Reply-To: <4B2FD0EB.7030005@billgatliff.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Bill Gatliff <bgat@billgatliff.com>, "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "beagleboard@googlegroups.com" <beagleboard@googlegroups.com>

Bill Gatliff wrote:
> 
> Pandita, Vikram wrote:
> > Bill
> >  There is a basic confusion whether you are using MUSB OTG core of omap
> > Or are you using EHCI core of omap.
> >
> > Both can be connected to a ULPI PHY and so you need to be very precise?
> >
> 
> I'm on the CUS package, and the D0 pin of the PHY is tied to pad T24 of
> the OMAP3530.  That's the ULPI D0 for EHCI, right?
> 

No confusion for me. I took the liberty of looking this up, and for
this package, T24 is D0 for MUSB, not EHCI.


> If the pad can be multiplexed between both MUSB and EHCI, how can I tell
> which one is connected there now?


No pad in the OMAP3 is multiplexed between both MUSB and EHCI; HSUSB0
is MUSB (this makes sense, since most users of the OMAP3 would like
to use the OMAP3 as a USB peripheral, and there is only one peripheral
controller, so the MUSB lines are usually not switches to other roles.


EHCI on the other hand is on HSUSB1 to HSUSB3 (there are 3 ports).


> For that matter, where in the mountains of OMAP3xxx documentation
> does it say which controller the UH0 pins are tied to?  I haven't
> found it yet...

Well, in the USB chapter of the OMAP3 TRM, the very first figure
(24.1 - USB modules overview) shows this clearly. Port0 is MUSB,
and Ports 1-3 are HSUSB Host.


Hope this helps,
Anand
