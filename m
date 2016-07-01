From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH] usb: host: Allow EHCI_OMAP to be built-in when USB_GADGET
 is 'm'
Date: Fri, 1 Jul 2016 11:10:57 +0300
Message-ID: <57762591.8010703@ti.com>
References: <1467276056-19357-1-git-send-email-rogerq@ti.com>
 <8760srgf00.fsf@linux.intel.com> <577525BF.3060509@ti.com>
 <878txloknc.fsf@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <878txloknc.fsf@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@kernel.org>
Cc: stern@rowland.harvard.edu, sre@kernel.org, peter.chen@nxp.com, tony@atomide.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 01/07/16 10:57, Felipe Balbi wrote:
> 
> Hi,
> 
> Roger Quadros <rogerq@ti.com> writes:
>>>> NOP_USB_XCEIV is used not only by gadget drivers but by
>>>> host drivers as well e.g. EHCI_OMAP.
>>>>
>>>> commit 5a8d651a2bde ("usb: gadget: move gadget API functions to udc-core")
>>>> made it so that NOP_USB_XCEIV can't be built-in if USB_GADGET is 'm'.
>>>> But this prevents EHCI_OMAP to be built-in if USB_GADGET is 'm'.
>>>>
>>>> Fix this undesired behaviour by moving usb_gadget_vbus_connect/disconnect()
>>>> to usb/gadget.h so that NOP_USB_XCEIV has no build dependency
>>>> on USB_GADGET.
>>>>
>>>> Retain the original Kconfig behaviour i.e. NOP_USB_XCEIV is selected
>>>> by drivers that need it.
>>>
>>> no, this is the wrong way to fix this. NOP _has_ a dependency on the
>>> Gadget API if it calls Gadget API functions. Dependencies are proper.
>>>
>>> Maybe the reason for the problem is that we ended up adding far too much
>>> code to phy-generic.c itself. Maybe it shouldn't know about clks and
>>> interrupts. The original idea of that driver was to simply satisfy a
>>> requirement to have a valid transceiver by some platforms. Maybe we
>>> should fix that instead. Moving functions around to workaround a problem
>>> is not the way to go, sorry.
>>>
>> OK but something that was working all these years is broken by your
>> patch.
>> Do you mind fixing it please? Or at least let me know how you want to
>> get it fixed.
> 
> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
> index 2e710a4cca52..89fd095ca33d 100644
> --- a/drivers/usb/host/Kconfig
> +++ b/drivers/usb/host/Kconfig
> @@ -180,7 +180,7 @@ config USB_EHCI_MXC
>  config USB_EHCI_HCD_OMAP
>         tristate "EHCI support for OMAP3 and later chips"
>         depends on ARCH_OMAP
> -       depends on NOP_USB_XCEIV
> +       depends on USB_PHY
>         default y
>         ---help---
>           Enables support for the on-chip EHCI controller on
> 
> 
This doesn't fix the real problem. i.e. we can't have NFS root on pandaboard
and omap5_uevm because network device is on USB EHCI, unless we have
both USB_GADGET and NOP_USB_XCEVI built-in, which is not really that
desirable.

cheers,
-roger
