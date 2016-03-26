From: Ruslan Bilovol <ruslan.bilovol@gmail.com>
Subject: Re: usb: gadget breakage on N900: bind UDC by name passed via
 usb_gadget_driver structure
Date: Sat, 26 Mar 2016 23:32:46 +0200
Message-ID: <CAB=otbQ1J7FZm9vWLwor93+uD3Fv38ykduWMXG3qByNh4mV9=g@mail.gmail.com>
References: <20160317212603.GA16651@amd>
	<CAB=otbSfj24nSUe1DyfVBDKD=trCp2-X-S-AcA1D+PTHZuP1Bg@mail.gmail.com>
	<20160318202041.GA20196@amd>
	<56EFE057.7070106@samsung.com>
	<20160323122143.GB32031@amd>
	<CAB=otbT2VsZ8Rhc-jbKwtRAssn01ecVFyTyAp+5hS=d40AsGKA@mail.gmail.com>
	<CAB=otbQdpEtsXg2etX+3YYjrTfPYGtdKJo_V_rtfNb+VNV7g-w@mail.gmail.com>
	<20160325210944.GA26394@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160325210944.GA26394@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, Patrik Bachan <patrikbachan@gmail.com>, serge@hallyn.com, Maxime Ripard <maxime.ripard@free-electrons.com>, Peter Chen <peter.chen@freescale.com>, Felipe Balbi <balbi@kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi

On Fri, Mar 25, 2016 at 11:09 PM, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
>> OK, so at last I finished charging of my N900; found 1.8V USB
>> to UART adapter and soldered it to the phone.
>>
>> I managed to boot N900 with working USB gadget (builtin g_ether)
>> in boardfile mode, can ping it from PC and transfer data. I don't
>> see any issue (except of musb name issue in twl phy driver, I've
>> already sent a fix for that: https://lkml.org/lkml/2016/3/24/670 )
>>
>> Pavel, I still don't see how you've got your issue, please share
>> more detials
>
> Ok, let me try. I undid all the changes in drivers/phy drivers/usb and
> include/linux/usb . I have all the gadget stuff built-in, so that I
> could use nfsroot, but this is boot from mmcblk.

So do you mean you use original rootfs that was shipeed with N900?

>
> gzipped config is attached.

Thanks, I'll try that

>
> PC is unable to work with the gadget:
>
> [256526.716099] usb 2-1: new full-speed USB device number 52 using
> uhci_hcd
> [256526.832091] usb 2-1: device descriptor read/64, error -32
> [256527.052095] usb 2-1: device descriptor read/64, error -32
> [256527.268160] usb 2-1: new full-speed USB device number 53 using
> uhci_hcd
> [256527.388121] usb 2-1: device descriptor read/64, error -32
> [256527.608116] usb 2-1: device descriptor read/64, error -32
> [256527.824170] usb 2-1: new full-speed USB device number 54 using
> uhci_hcd
> [256527.851175] usb 2-1: device descriptor read/8, error -32
> [256527.975175] usb 2-1: device descriptor read/8, error -32
> [256528.188133] usb 2-1: new full-speed USB device number 55 using
> uhci_hcd
> [256528.218184] usb 2-1: device descriptor read/8, error -32
> [256528.343183] usb 2-1: device descriptor read/8, error -32
> [256528.444314] usb usb2-port1: unable to enumerate USB device
>
> Dmesg from the n900 is attached as /tmp/delme.gz. I did _not_ apply
> the patch from https://lkml.org/lkml/2016/3/24/670 , yet, as I'm using
> devicetree boot.

Hmm.. don't see anything strange in the boot log related to USB,
I'll try your config

Best regards
Ruslan

>
> Best regards,
>
>                                                                         Pavel
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
