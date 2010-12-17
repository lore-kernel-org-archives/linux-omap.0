From: Tomasz Mloduchowski <tomasz.mloduchowski@xlogic.pl>
Subject: Re: twl4030_usb porting advice
Date: Fri, 17 Dec 2010 07:23:43 +0000
Message-ID: <4D0B0FFF.6020409@xlogic.pl>
References: <4D08ACAC.8070900@xlogic.pl> <20101215121023.GN2997@legolas.emea.dhcp.ti.com> <4D08B41E.7090400@xlogic.pl> <20101215123912.GC6734@legolas.emea.dhcp.ti.com> <4D08BE16.4020704@xlogic.pl> <20101216090956.GG2601@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from xen-13-178-63-247-83.statnet.pl ([178.63.247.83]:40241 "EHLO
	xlogic.pl" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751969Ab0LQHYn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 17 Dec 2010 02:24:43 -0500
In-Reply-To: <20101216090956.GG2601@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: linux-omap@vger.kernel.org

On 12/16/10 09:09, Felipe Balbi wrote:
> On Wed, Dec 15, 2010 at 01:09:42PM +0000, Tomasz Mloduchowski wrote:
>> On 12/15/10 12:39, Felipe Balbi wrote:
>>> On Wed, Dec 15, 2010 at 12:27:10PM +0000, Tomasz Mloduchowski wrote:
>>>>>> I would gladly welcome any pointers that could help me solve this
>>>>>> issue.
>>>>>
>>>>> you're connecting a FS/LS device to EHCI port, that doesn't work. OMAP
>>>>> can't handle port handoff to companion OHCI controller, then it fails
>>>>> not being able to enumerate the device. Try remuxing your port to OHCI
>>>>> controller and disabling EHCI from Kconfig.
>>>>
>>>> It actually is a HS device (it's a 4-port hub) - when booting the
>>>> vendor supplied kernel (based off 2.6.32, i.e. pre -IR redesign), the
>>>> device identifies as follows:
>> I've also made a mistake describing the pastebins - the working, PSP
>> kernel boot log is here:
>> http://pastie.org/1379102
>>
>> while the non-working git kernel messages are here (with
>> CONFIG_USB_DEBUG):
>> http://pastie.org/1379100
>
> I'm quoting a snippet below for commenting.
>
>> [ 1.639892] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
>> [ 1.646759] ehci_hcd: block sizes: qh 60 qtd 96 itd 160 sitd 96
>> [ 1.646881] ehci-omap ehci-omap.0: failed to get ehci port1 regulator
>
> This is alarming. Please add this patch to get the error code:
 >
> This is also alarming... Let's increase the timeout just for a debugging
> purpose:
I've applied both patches. The new kernel log in its entirety resides here:
http://pastie.org/1384896

And the line of interest is
[    2.085449] ehci-omap ehci-omap.0: failed to get ehci port1 regulator 
--> 0

Unfortunately, I don't understand what an error code of '0' might mean 
here, but it surely does something.

Cheers,
Tomasz

