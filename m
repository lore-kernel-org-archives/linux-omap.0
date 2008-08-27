From: "Ashwin Bihari" <abihari@gmail.com>
Subject: Re: Enabling MUSB support
Date: Wed, 27 Aug 2008 09:51:40 -0400
Message-ID: <1f11a5490808270651o549d5868i189367f3a099a12d@mail.gmail.com>
References: <1f11a5490808270626t5b4aa599i18b730d12a6c4667@mail.gmail.com>
	 <20080827133825.GC7354@gandalf.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.30]:53994 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757878AbYH0Nvm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Aug 2008 09:51:42 -0400
Received: by yx-out-2324.google.com with SMTP id 8so1341931yxm.1
        for <linux-omap@vger.kernel.org>; Wed, 27 Aug 2008 06:51:41 -0700 (PDT)
In-Reply-To: <20080827133825.GC7354@gandalf.research.nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.balbi@nokia.com
Cc: linux-omap@vger.kernel.org

On Wed, Aug 27, 2008 at 9:38 AM, Felipe Balbi <felipe.balbi@nokia.com> wrote:
> On Wed, Aug 27, 2008 at 09:26:34AM -0400, ext Ashwin Bihari wrote:
>> Greetings,
>>
>> I'm trying to test out the MUSB support on my OMAP-3530 based device
>> with the TWL4030 Phy. I'm using 2.6.22.18 and have tried to enable all
>
> I'll probably start the same discussion again, that's a rather old
> kernel. It would be nice to try out current git tree from [1] and report
> again if it works or not.
>
> I tried musb on omap2420 (with tusb), omap3430 and omap3530 (beagle
> board) and all of them are working.

I'm working on a custom board namely the LogicPD Zoom OMAP3530 LV SOM
and we have support for our devkit in the 2.6.22.18 Kernel. Bringing
all of our changes to the latest tree would take me a bit of time and
I just want to validate the hardware to ensure that things are working
in their current state.

I suppose, like I did previously for the EHCI USB controller, I could
back-port the changes specific to the MUSB back from the latest Kernel
to my version.

Could you send me your configuration for the beagle board? My hardware
configuration resembles that particular board.

>
>> different settings related to MUSB and nothing seems to happen. The
>> TWL4030_USB driver builds and loads and claims that a cable is plugged
>> in even when nothing is plugged in.
>
> Sounds like a bug in twl4030-usb.c

I agree..

>
>> The "musb_hdrc" driver loads up and registers with IRQs 92 and 93. The
>> TWL4030_USB driver registers with IRQ 373. As I plug-in and remove the
>> cable from the USB port, no interrupts are generated and the driver is
>> completely oblivious to what's happening..
>
> Do you have id pin grounded ?
>
>> I'm trying to configure the MUSB driver as a Host-only to start with,
>> I've also tried to set it as OTG with no change.
>
> Use it as otg and put a gadget driver as well, it's better.
>
>> My current ".config" is as follows, could someone point me to any
>> configuration option or anything that I'm missing..
>
> I'd just suggest you to use as otg and put a gadget driver.

Would use OTG Host not make things significantly easy as far as
software goes without having to determine the roles based on which end
of the USB cable is plugged in?

>
> Which board are you using ? Is it some development board or a custom
> board ?
>
> Development boards have a defconfig that might help you.

Unfortuatenly, this is a custom board for which we are creating the
defconfig..so isn't easy to jump to the latest Kernel and use another
defconfig..

~ Ashwin
