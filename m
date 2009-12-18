From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: Anyone using an ISP1505?
Date: Sat, 19 Dec 2009 00:50:05 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702FFDF312B@dbde02.ent.ti.com>
References: <4B2A7FFB.6090909@billgatliff.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB031DC20A68@dbde02.ent.ti.com>
 <4B2BD3B6.20407@billgatliff.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57132 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932571AbZLRTUP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Dec 2009 14:20:15 -0500
In-Reply-To: <4B2BD3B6.20407@billgatliff.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Bill Gatliff <bgat@billgatliff.com>, "Gadiyar, Anand" <gadiyar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "beagleboard@googlegroups.com" <beagleboard@googlegroups.com>


>-----Original Message-----
>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Bill
>Gatliff
>Sent: Friday, December 18, 2009 1:11 PM
>To: Gadiyar, Anand
>Cc: linux-omap@vger.kernel.org; beagleboard@googlegroups.com
>Subject: Re: Anyone using an ISP1505?
>
<snip>
>
>> If it's with the EHCI controller, you need to take care of a couple of
>> issues on the board (due to the input clocking mode used in the OMAP3).
>>
>
>Can you elaborate?  Thanks!
>
For omap-ehci, the OMAP feeds in the 60Mhz clock to the PHY(1505 in your case).
This is the input clocking mode of phy.

It looks like the PHY state machine requires sometime to stabilize and lock into this 60Mhz clock input and this is done with a GPIO form omap.

In ehci_hcd_omap_platform_data, Typically boards have
. phy_reset = true
. reset_gpio_port[0] = GPIO going to phy reset pin

On your board you need to find, if there is a GPIO hooked from omap to PHY.
And the GPIO behavior is decided by the PHY pin property ( whether its active high/low and whether its chipselect or reset of phy).

By default the code assumes that the GPIO is connected to RESET pin: going 0 while the 60mhz clock input stabilizes and then once done, make it 1.

So find out what GPIO from omap is connected to phy to control the phy.


