From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH] usb: host: Allow EHCI_OMAP to be built-in when USB_GADGET
 is 'm'
Date: Fri, 1 Jul 2016 11:28:09 +0300
Message-ID: <57762999.8040906@ti.com>
References: <1467276056-19357-1-git-send-email-rogerq@ti.com>
 <8760srgf00.fsf@linux.intel.com> <577525BF.3060509@ti.com>
 <878txloknc.fsf@linux.intel.com> <57762591.8010703@ti.com>
 <8760spojty.fsf@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8760spojty.fsf@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@kernel.org>, tony@atomide.com
Cc: stern@rowland.harvard.edu, sre@kernel.org, peter.chen@nxp.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 01/07/16 11:15, Felipe Balbi wrote:
> 
> Hi,
> 
> Roger Quadros <rogerq@ti.com> writes:
>>>>>> NOP_USB_XCEIV is used not only by gadget drivers but by
>>>>>> host drivers as well e.g. EHCI_OMAP.
>>>>>>
>>>>>> commit 5a8d651a2bde ("usb: gadget: move gadget API functions to udc-core")
>>>>>> made it so that NOP_USB_XCEIV can't be built-in if USB_GADGET is 'm'.
>>>>>> But this prevents EHCI_OMAP to be built-in if USB_GADGET is 'm'.
>>>>>>
>>>>>> Fix this undesired behaviour by moving usb_gadget_vbus_connect/disconnect()
>>>>>> to usb/gadget.h so that NOP_USB_XCEIV has no build dependency
>>>>>> on USB_GADGET.
>>>>>>
>>>>>> Retain the original Kconfig behaviour i.e. NOP_USB_XCEIV is selected
>>>>>> by drivers that need it.
>>>>>
>>>>> no, this is the wrong way to fix this. NOP _has_ a dependency on the
>>>>> Gadget API if it calls Gadget API functions. Dependencies are proper.
>>>>>
>>>>> Maybe the reason for the problem is that we ended up adding far too much
>>>>> code to phy-generic.c itself. Maybe it shouldn't know about clks and
>>>>> interrupts. The original idea of that driver was to simply satisfy a
>>>>> requirement to have a valid transceiver by some platforms. Maybe we
>>>>> should fix that instead. Moving functions around to workaround a problem
>>>>> is not the way to go, sorry.
>>>>>
>>>> OK but something that was working all these years is broken by your
>>>> patch.
>>>> Do you mind fixing it please? Or at least let me know how you want to
>>>> get it fixed.
>>>
>>> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
>>> index 2e710a4cca52..89fd095ca33d 100644
>>> --- a/drivers/usb/host/Kconfig
>>> +++ b/drivers/usb/host/Kconfig
>>> @@ -180,7 +180,7 @@ config USB_EHCI_MXC
>>>  config USB_EHCI_HCD_OMAP
>>>         tristate "EHCI support for OMAP3 and later chips"
>>>         depends on ARCH_OMAP
>>> -       depends on NOP_USB_XCEIV
>>> +       depends on USB_PHY
>>>         default y
>>>         ---help---
>>>           Enables support for the on-chip EHCI controller on
>>>
>>>
>> This doesn't fix the real problem. i.e. we can't have NFS root on pandaboard
>> and omap5_uevm because network device is on USB EHCI, unless we have
>> both USB_GADGET and NOP_USB_XCEVI built-in, which is not really that
>> desirable.
> 
> Well, NOP calls a symbol that belongs to the Gadget API. So NOP cannot
> be built-in if gadget API is a module. Satisfy the dependencies and
> everything will work for you.
> 
> Don't get me wrong, I see what you mean; but you _are_ relying in a
> driver that calls into the Gadget API. Consider if it was the other way
> around: say NOP was calling something from usbcore for whatever reason
> and MUSB depended on NOP. You wouldn't have MUSB built-in unless NOP and
> usbcore were also built-in, right?
> 
I agree with you. As far as EHCI_OMAP is concerned we're only interested
in configuring the PHY clocks and issuing a GPIO reset.
As of now because of dependency issues with GADGET, NOP_USB_XCEIV doesn't
seem to be the right place. I'm OK with using some other driver
that doesn't have such dependency, even if it breaks DT compatibility with
some OMAP boards. Or I'll just let EHCI_OMAP do it all by itself.

Unless Tony has any objections.

cheers,
-roger
