From: Enric Balletbo Serra <eballetbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: USB OTG doesn't work in HOST mode on OMAP3 processor on 3.18-rc5
Date: Tue, 18 Nov 2014 11:42:39 +0100
Message-ID: <CAFqH_53eQ05Dy4W2EE_OtCA72w-MQNugLiOLJdj=n-yCnZHwSg@mail.gmail.com>
References: <CAFqH_53hyYO9DHfhzDhYkTnimKR0FOQuUw4OGCM4myKoOJSQRA@mail.gmail.com>
	<20141117180413.GF7046@atomide.com>
	<CAFqH_52LV8k6OyH04dUmhzZChnHrtJR23qu1ewhU49iOVT1Mwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAFqH_52LV8k6OyH04dUmhzZChnHrtJR23qu1ewhU49iOVT1Mwg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

2014-11-18 10:02 GMT+01:00 Enric Balletbo Serra <eballetbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
> Hi Tony,
>
> 2014-11-17 19:04 GMT+01:00 Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>:
>> * Enric Balletbo Serra <eballetbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> [141117 07:15]:
>>>  Hi all,
>>>
>>> I'm trying to use the USB OTG driver of OMAP3 processor in HOST mode
>>> when it's configured in dual role mode (CONFIG_USB_MUSB_DUAL_ROLE=y)
>>>
>>> The test case that I'm trying to solve is as follows.
>>>
>>> 1) Boot the board.
>>> 2) Put the USB ID pin to ground
>>> 3) Connect a pendrive.
>>>
>>> In such case doesn't work as expected and pendrive is never detected.
>>>
>>> Enabling debug information, I see that the phyter (twl4030) is
>>> constantly polling the STS_HW_CONDITIONS register, who reports:
>>>
>>>   twl4030_usb 48070000.i2c:twl@48:twl4030-usb: HW_CONDITIONS 0x54/84; link 1
>>>
>>> The STS_HW_CONDITIONS register reports:
>>>
>>> Bit 2: STS_USB : 1: USB is plugged in.
>>> Bit 4: STS_WAKEUP1: Level status of WAKEUP1 pad (active high) = nSLEEP1
>>> Bit 6: STS_WAKEUP3: Level status of WAKEUP3 pad (active high) = CLKREQ
>>>
>>> I guess that in this case the state machine is waiting for VBUS, and
>>> looks for bit 7 STS_VBUS (Level status of VBUS port), but this never
>>> occurs. Using an oscilloscope I checked VBUS level and I can confirm
>>> that it's a 0 level.
>>>
>>> My understand is that in this case the driver should enable VBUS but I
>>> didn't find where is the best place to do this and why is not doing
>>> this already. Any clue on this?
>>
>> Just tested v3.18-rc5 with beagleboard xm, and the host mode
>> enumerates the devices, then may fail with "insufficient bus power"
>> at least for the WLAN device I tried with.
>>
>
> Is this with following options ?
>
> CONFIG_USB_MUSB_DUAL_ROLE=y
> # CONFIG_USB_MUSB_HOST is not set
> # CONFIG_USB_MUSB_GADGET is not set
>
> Because with these options doesn't work for me. It only works if I
> don't use dual role mode
>
> CONFIG_USB_MUSB_HOST=y
> CONFIG_USB_MUSB_DUAL_ROLE is not set
>

Sorry this is not true, it only works if I set  mode = <1> in my
device tree, either it's CONFIG_USB_MUSB_DUAL_ROLE=y or
CONFIG_USB_MUSB_HOST=y configured.

>> I noticed that this only works with CONFIG_USB_MUSB_HDRC and
>> CONFIG_TWL4030_USB built into the kernel. No luck so far with them
>> as loadable modules for some reason. Looks like also USB gadgets
>> fail with MUSB as modules.
>>
>
> It's weird, for me fails in both cases, built-in and with loadable
> modules. Connecting the OTG Cable Adapter with a pendrive reports
>
> [   51.462432] twl4030_usb 48070000.i2c:twl@48:twl4030-usb:
> HW_CONDITIONS 0x54/84; link 1
> [   51.470916] twl4030_usb 48070000.i2c:twl@48:twl4030-usb:
> twl4030_usb_runtime_resume
> [   51.487274] musb-hdrc musb-hdrc.0.auto: ID GND
> [   52.480712] twl4030_usb 48070000.i2c:twl@48:twl4030-usb:
> HW_CONDITIONS 0x54/84; link 1
> [   53.489044] twl4030_usb 48070000.i2c:twl@48:twl4030-usb:
> HW_CONDITIONS 0x54/84; link 1
>
> And then polls until I disconnect the OTG Cable Adapter with the pendrive.
>
> [   71.488983] twl4030_usb 48070000.i2c:twl@48:twl4030-usb:
> HW_CONDITIONS 0x54/84; link 1
> [   71.778930] twl4030_usb 48070000.i2c:twl@48:twl4030-usb:
> HW_CONDITIONS 0x50/80; link 4
> [   71.787536] musb-hdrc musb-hdrc.0.auto: VBUS Disconnect
> [   72.489044] twl4030_usb 48070000.i2c:twl@48:twl4030-usb:
> HW_CONDITIONS 0x50/80; link 4
> [   74.088714] twl4030_usb 48070000.i2c:twl@48:twl4030-usb:
> twl4030_usb_runtime_suspend
>
>
>> And on the 37xx EVM, I've never had any luck getting any twl4030_usb
>> interrupts for some reason.
>>
>
> Regards,
>
> Enric
>
>> Regards,
>>
>> Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
