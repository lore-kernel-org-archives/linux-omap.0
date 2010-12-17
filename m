From: Tomasz Mloduchowski <tomasz.mloduchowski@xlogic.pl>
Subject: Re: twl4030_usb porting advice
Date: Fri, 17 Dec 2010 11:14:50 +0000
Message-ID: <4D0B462A.9070208@xlogic.pl>
References: <4D08ACAC.8070900@xlogic.pl> <20101215121023.GN2997@legolas.emea.dhcp.ti.com> <4D08B41E.7090400@xlogic.pl> <20101215123912.GC6734@legolas.emea.dhcp.ti.com> <4D08BE16.4020704@xlogic.pl> <20101216090956.GG2601@legolas.emea.dhcp.ti.com> <4D0B0FFF.6020409@xlogic.pl> <20101217101156.GC2653@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from xen-13-178-63-247-83.statnet.pl ([178.63.247.83]:46088 "EHLO
	xlogic.pl" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751714Ab0LQLPt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 17 Dec 2010 06:15:49 -0500
In-Reply-To: <20101217101156.GC2653@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: linux-omap@vger.kernel.org

On 12/17/10 10:11, Felipe Balbi wrote:
> Hi,
>
> On Fri, Dec 17, 2010 at 07:23:43AM +0000, Tomasz Mloduchowski wrote:
>>> I'm quoting a snippet below for commenting.
>>>
>>>> [ 1.639892] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
>>>> [ 1.646759] ehci_hcd: block sizes: qh 60 qtd 96 itd 160 sitd 96
>>>> [ 1.646881] ehci-omap ehci-omap.0: failed to get ehci port1 regulator
>>>
>>> This is alarming. Please add this patch to get the error code:
>>>
>>> This is also alarming... Let's increase the timeout just for a debugging
>>> purpose:
>> I've applied both patches. The new kernel log in its entirety resides
>> here:
>> http://pastie.org/1384896
>
> Unfortunately seems like pastie.org is down:
>
> 503 Service Unavailable
> No server is available to handle this request.
>
>> And the line of interest is
>> [ 2.085449] ehci-omap ehci-omap.0: failed to get ehci port1 regulator
>> --> 0
>>
>> Unfortunately, I don't understand what an error code of '0' might mean
>> here, but it surely does something.
>
> That's funny, 0 means "success", not sure why that branch is being
> called.
>
> I'll wait a bit until pastie is back, but if you could append to your
> reply the output of dmesg | grep -i ehci I'd be glad.
>
I really appreciate your help, this sort of a bug that really stunned me.

I've noticed that the variable storing the error code is set to NULL 
right before printing it out :(, so I corrected this mistake.

[    2.065216] ehci-omap ehci-omap.0: failed to get ehci port1 regulator 
--> -19

I also switched to pastebin, with the new, more meaningful dmesg:
http://pastebin.com/86kfLT2G

Cheers,
Tomasz
