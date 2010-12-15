From: Tomasz Mloduchowski <tomasz.mloduchowski@xlogic.pl>
Subject: Re: twl4030_usb porting advice
Date: Wed, 15 Dec 2010 13:09:42 +0000
Message-ID: <4D08BE16.4020704@xlogic.pl>
References: <4D08ACAC.8070900@xlogic.pl> <20101215121023.GN2997@legolas.emea.dhcp.ti.com> <4D08B41E.7090400@xlogic.pl> <20101215123912.GC6734@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from xen-13-178-63-247-83.statnet.pl ([178.63.247.83]:60809 "EHLO
	xlogic.pl" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1750858Ab0LONKU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Dec 2010 08:10:20 -0500
In-Reply-To: <20101215123912.GC6734@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: linux-omap@vger.kernel.org

On 12/15/10 12:39, Felipe Balbi wrote:
> On Wed, Dec 15, 2010 at 12:27:10PM +0000, Tomasz Mloduchowski wrote:
>>>> I would gladly welcome any pointers that could help me solve this
>>>> issue.
>>>
>>> you're connecting a FS/LS device to EHCI port, that doesn't work. OMAP
>>> can't handle port handoff to companion OHCI controller, then it fails
>>> not being able to enumerate the device. Try remuxing your port to OHCI
>>> controller and disabling EHCI from Kconfig.
>>
>> It actually is a HS device (it's a 4-port hub) - when booting the
>> vendor supplied kernel (based off 2.6.32, i.e. pre -IR redesign), the
>> device identifies as follows:
>>
>> Bus 001 Device 002: ID 05e3:0608 Genesys Logic, Inc. USB-2.0 4-Port HUB
>>
>> with the following boot messages:
>>
>> usb 1-2: new high speed USB device using ehci-omap and address 2
>> usb 1-2: New USB device found, idVendor=05e3, idProduct=0608
>> usb 1-2: New USB device strings: Mfr=0, Product=1, SerialNumber=0
>> usb 1-2: Product: USB2.0 Hub
>> hub 1-2:1.0: USB hub found
>> hub 1-2:1.0: 4 ports detected
>>
>>
>> I've pasted the boot log for my kernel:
>> http://pastie.org/1379102
>>
>> And the boot log for the original kernel:
>> http://pastie.org/1379100
>
> It could be a bug on the reset sequence on ehci-omap.c, do you have
> anything connected to any of the hub ports ?
>
> Please enable CONFIG_USB_DEBUG on your kernel config and grab a bit more
> information.
>
> Also, boot the machine without the device attached and after booting
> run:
>
> # dmesg -c
>
> then attach the device, then grab the output of dmesg.
>

I don't have the ability to disconnect the hub - it's integrated on the 
board :(

I've also made a mistake describing the pastebins - the working, PSP 
kernel boot log is here:
http://pastie.org/1379102

while the non-working git kernel messages are here (with CONFIG_USB_DEBUG):
http://pastie.org/1379100

Cheers,
Tomasz
