From: Bill Gatliff <bgat@billgatliff.com>
Subject: Re: Anyone using an ISP1505?
Date: Mon, 21 Dec 2009 11:06:42 -0600
Message-ID: <4B2FAB22.90000@billgatliff.com>
References: <4B2A7FFB.6090909@billgatliff.com> <5A47E75E594F054BAF48C5E4FC4B92AB031DC20A68@dbde02.ent.ti.com> <4B2BD3B6.20407@billgatliff.com> <FCCFB4CDC6E5564B9182F639FC35608702FFDF312B@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.27]:54257 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756921AbZLURGX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Dec 2009 12:06:23 -0500
Received: by qw-out-2122.google.com with SMTP id 3so1055109qwe.37
        for <linux-omap@vger.kernel.org>; Mon, 21 Dec 2009 09:06:23 -0800 (PST)
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC35608702FFDF312B@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: "Gadiyar, Anand" <gadiyar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "beagleboard@googlegroups.com" <beagleboard@googlegroups.com>

Pandita, Vikram wrote:
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Bill
>> Gatliff
>> Sent: Friday, December 18, 2009 1:11 PM
>> To: Gadiyar, Anand
>> Cc: linux-omap@vger.kernel.org; beagleboard@googlegroups.com
>> Subject: Re: Anyone using an ISP1505?
>>
>>     
> <snip>
>   
>>> If it's with the EHCI controller, you need to take care of a couple of
>>> issues on the board (due to the input clocking mode used in the OMAP3).
>>>
>>>       
>> Can you elaborate?  Thanks!
>>
>>     
> For omap-ehci, the OMAP feeds in the 60Mhz clock to the PHY(1505 in your case).
> This is the input clocking mode of phy.
>
> It looks like the PHY state machine requires sometime to stabilize and lock into this 60Mhz clock input and this is done with a GPIO form omap.
>
> In ehci_hcd_omap_platform_data, Typically boards have
> . phy_reset = true
> . reset_gpio_port[0] = GPIO going to phy reset pin
>
> On your board you need to find, if there is a GPIO hooked from omap to PHY.
> And the GPIO behavior is decided by the PHY pin property ( whether its active high/low and whether its chipselect or reset of phy).
>
> By default the code assumes that the GPIO is connected to RESET pin: going 0 while the 60mhz clock input stabilizes and then once done, make it 1.
>
> So find out what GPIO from omap is connected to phy to control the phy.
>   

Ok, I'll look at that.  I'm not sure if I have such a GPIO pin going to
the PHY.

I do have the XTAL input tied to SYS_CLK1/GPIO_10, and I've verified
that I'm sending out a 19.2MHz clock signal on that pin.  That seems to
be what the ISP1505ABS chip needs.  I start that clock in my board setup
code.

I just re-re-re-read the ISP1505 datasheet, and noticed this remark:

    "Remark: When CLOCK starts toggling after power-up, the USB link
    must issue a reset command over the ULPI bus to ensure correct
    operation of the ISP1505".


I see in drivers/usb/host/ehci-omap.c where the TLL is reset, but I
can't find any code that sends a ULPI reset command out over the link. 
Or am I missing something?

I also see drivers/usb/otg/ulpi.c which claims to support the ISP1504,
which is a very similar chip to the ISP1505.  But it also lacks any
mention of a ULPI reset-type command.


Any additional thoughts?  I'm losing hair fast on this one....  :)


b.g.

-- 
Bill Gatliff
bgat@billgatliff.com

