From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: Anyone using an ISP1505?
Date: Mon, 21 Dec 2009 22:42:12 +0200
Message-ID: <20091221204212.GA18907@nokia.com>
References: <4B2A7FFB.6090909@billgatliff.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB031DC20A68@dbde02.ent.ti.com>
 <4B2BD3B6.20407@billgatliff.com>
 <FCCFB4CDC6E5564B9182F639FC35608702FFDF312B@dbde02.ent.ti.com>
 <4B2FAB22.90000@billgatliff.com>
 <FCCFB4CDC6E5564B9182F639FC35608703001E1949@dbde02.ent.ti.com>
 <4B2FD0EB.7030005@billgatliff.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB031DC20A80@dbde02.ent.ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:57010 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757118AbZLUUqQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Dec 2009 15:46:16 -0500
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB031DC20A80@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Gadiyar, Anand" <gadiyar@ti.com>
Cc: Bill Gatliff <bgat@billgatliff.com>, "Pandita, Vikram" <vikram.pandita@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "beagleboard@googlegroups.com" <beagleboard@googlegroups.com>

Hi,

On Mon, Dec 21, 2009 at 09:12:15PM +0100, ext Gadiyar, Anand wrote:
>Bill Gatliff wrote:
>>
>> Pandita, Vikram wrote:
>> > Bill
>> >  There is a basic confusion whether you are using MUSB OTG core of omap
>> > Or are you using EHCI core of omap.
>> >
>> > Both can be connected to a ULPI PHY and so you need to be very precise?
>> >
>>
>> I'm on the CUS package, and the D0 pin of the PHY is tied to pad T24 of
>> the OMAP3530.  That's the ULPI D0 for EHCI, right?
>>
>
>No confusion for me. I took the liberty of looking this up, and for
>this package, T24 is D0 for MUSB, not EHCI.
>
>
>> If the pad can be multiplexed between both MUSB and EHCI, how can I tell
>> which one is connected there now?
>
>
>No pad in the OMAP3 is multiplexed between both MUSB and EHCI; HSUSB0
>is MUSB (this makes sense, since most users of the OMAP3 would like
>to use the OMAP3 as a USB peripheral, and there is only one peripheral
>controller, so the MUSB lines are usually not switches to other roles.
>
>
>EHCI on the other hand is on HSUSB1 to HSUSB3 (there are 3 ports).
>
>
>> For that matter, where in the mountains of OMAP3xxx documentation
>> does it say which controller the UH0 pins are tied to?  I haven't
>> found it yet...
>
>Well, in the USB chapter of the OMAP3 TRM, the very first figure
>(24.1 - USB modules overview) shows this clearly. Port0 is MUSB,
>and Ports 1-3 are HSUSB Host.

Are you just missing to call usb_nop_xceiv_register() ??

can you attach your .config file to the mail ??

-- 
balbi
