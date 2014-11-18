From: Enric Balletbo Serra <eballetbo@gmail.com>
Subject: Re: USB OTG doesn't work in HOST mode on OMAP3 processor on 3.18-rc5
Date: Tue, 18 Nov 2014 10:02:45 +0100
Message-ID: <CAFqH_52LV8k6OyH04dUmhzZChnHrtJR23qu1ewhU49iOVT1Mwg@mail.gmail.com>
References: <CAFqH_53hyYO9DHfhzDhYkTnimKR0FOQuUw4OGCM4myKoOJSQRA@mail.gmail.com>
	<20141117180413.GF7046@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f43.google.com ([74.125.82.43]:62604 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750912AbaKRJCr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Nov 2014 04:02:47 -0500
In-Reply-To: <20141117180413.GF7046@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, linux-omap@vger.kernel.org, balbi@ti.com

Hi Tony,

2014-11-17 19:04 GMT+01:00 Tony Lindgren <tony@atomide.com>:
> * Enric Balletbo Serra <eballetbo@gmail.com> [141117 07:15]:
>>  Hi all,
>>
>> I'm trying to use the USB OTG driver of OMAP3 processor in HOST mode
>> when it's configured in dual role mode (CONFIG_USB_MUSB_DUAL_ROLE=y)
>>
>> The test case that I'm trying to solve is as follows.
>>
>> 1) Boot the board.
>> 2) Put the USB ID pin to ground
>> 3) Connect a pendrive.
>>
>> In such case doesn't work as expected and pendrive is never detected.
>>
>> Enabling debug information, I see that the phyter (twl4030) is
>> constantly polling the STS_HW_CONDITIONS register, who reports:
>>
>>   twl4030_usb 48070000.i2c:twl@48:twl4030-usb: HW_CONDITIONS 0x54/84; link 1
>>
>> The STS_HW_CONDITIONS register reports:
>>
>> Bit 2: STS_USB : 1: USB is plugged in.
>> Bit 4: STS_WAKEUP1: Level status of WAKEUP1 pad (active high) = nSLEEP1
>> Bit 6: STS_WAKEUP3: Level status of WAKEUP3 pad (active high) = CLKREQ
>>
>> I guess that in this case the state machine is waiting for VBUS, and
>> looks for bit 7 STS_VBUS (Level status of VBUS port), but this never
>> occurs. Using an oscilloscope I checked VBUS level and I can confirm
>> that it's a 0 level.
>>
>> My understand is that in this case the driver should enable VBUS but I
>> didn't find where is the best place to do this and why is not doing
>> this already. Any clue on this?
>
> Just tested v3.18-rc5 with beagleboard xm, and the host mode
> enumerates the devices, then may fail with "insufficient bus power"
> at least for the WLAN device I tried with.
>

Is this with following options ?

CONFIG_USB_MUSB_DUAL_ROLE=y
# CONFIG_USB_MUSB_HOST is not set
# CONFIG_USB_MUSB_GADGET is not set

Because with these options doesn't work for me. It only works if I
don't use dual role mode

CONFIG_USB_MUSB_HOST=y
CONFIG_USB_MUSB_DUAL_ROLE is not set

> I noticed that this only works with CONFIG_USB_MUSB_HDRC and
> CONFIG_TWL4030_USB built into the kernel. No luck so far with them
> as loadable modules for some reason. Looks like also USB gadgets
> fail with MUSB as modules.
>

It's weird, for me fails in both cases, built-in and with loadable
modules. Connecting the OTG Cable Adapter with a pendrive reports

[   51.462432] twl4030_usb 48070000.i2c:twl@48:twl4030-usb:
HW_CONDITIONS 0x54/84; link 1
[   51.470916] twl4030_usb 48070000.i2c:twl@48:twl4030-usb:
twl4030_usb_runtime_resume
[   51.487274] musb-hdrc musb-hdrc.0.auto: ID GND
[   52.480712] twl4030_usb 48070000.i2c:twl@48:twl4030-usb:
HW_CONDITIONS 0x54/84; link 1
[   53.489044] twl4030_usb 48070000.i2c:twl@48:twl4030-usb:
HW_CONDITIONS 0x54/84; link 1

And then polls until I disconnect the OTG Cable Adapter with the pendrive.

[   71.488983] twl4030_usb 48070000.i2c:twl@48:twl4030-usb:
HW_CONDITIONS 0x54/84; link 1
[   71.778930] twl4030_usb 48070000.i2c:twl@48:twl4030-usb:
HW_CONDITIONS 0x50/80; link 4
[   71.787536] musb-hdrc musb-hdrc.0.auto: VBUS Disconnect
[   72.489044] twl4030_usb 48070000.i2c:twl@48:twl4030-usb:
HW_CONDITIONS 0x50/80; link 4
[   74.088714] twl4030_usb 48070000.i2c:twl@48:twl4030-usb:
twl4030_usb_runtime_suspend


> And on the 37xx EVM, I've never had any luck getting any twl4030_usb
> interrupts for some reason.
>

Regards,

Enric

> Regards,
>
> Tony
