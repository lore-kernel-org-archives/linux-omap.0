From: Mohan V <mohanvforum@gmail.com>
Subject: Re: Problem with OHCI on OMAP4430
Date: Tue, 30 Oct 2012 18:03:56 +0530
Message-ID: <CANP3njwd94MQMW2JjB8e73-25YJu-14tz+QOybi8aP=uOPaSZg@mail.gmail.com>
References: <CANP3njys-W+JXdkH3Vj-90VgMENwtcDMZ6y-oEift3fC89yYwg@mail.gmail.com>
	<Pine.LNX.4.44L0.1210291111260.22882-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:62006 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932126Ab2J3Md4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Oct 2012 08:33:56 -0400
In-Reply-To: <Pine.LNX.4.44L0.1210291111260.22882-100000@netrider.rowland.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, keshava_mgowda@ti.com

Alan,

On Mon, Oct 29, 2012 at 8:54 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Mon, 29 Oct 2012, Mohan V wrote:
>
>> > I'm not going to be able to help very much with an Android kernel.
>> > Does the same problem occur with a vanilla non-Android 3.6 kernel?  If
>> > it doesn't, that indicates the problem was caused by some
>> > Android-specific changes.
>> >
>> With the vanilla 3.6 kernel, the device connected to OHCI port is not even
>> detected. The below messages are seen:
>>
>> [    5.343780] usb 2-2: new low-speed USB device number 5 using ohci-omap3
>> [    5.351776] ohci-omap3 ohci-omap3.0: urb ee7f83c0 path 2 ep0out
>> 5ec20000 cc 5 --> status -62
>> [    5.570770] ohci-omap3 ohci-omap3.0: urb ee7f83c0 path 2 ep0out
>> 5ec20000 cc 5 --> status -62
>> [    5.789062] usb 2-2: device not accepting address 5, error -62
>> [    5.795288] hub 2-0:1.0: unable to enumerate USB device on port 2
>
> It looks like the device was detected just fine but the host was
> unable to communicate with it.  I don't know why; maybe a clock or
> power line wasn't turned on properly or a PHY wasn't enabled.
>
>> We think it may not be hardware issue, since the device gets detected on
>> android-3.0 kernel. The support for OHCI on OMAP4430 SDP board
>> seems to be missing in Linux mainline (3.6).
>>
>> We ported some OMAP specific patches from android kernel, with this the
>> device gets detected only if it is connected at boot.
>> If the system is booted and then device is connected, it doesn't get detected.
>
> Doesn't get detected, or does get detected but then doesn't
> communicate?
>
The device does not get detected.

> Perhaps you should send some questions to the maintainers of the
> various ohci-omap drivers or the Android maintainers.
>
Keshava, can you please comment?

>> > Are you referring to this part of the log?
>> >
>> >> ------------------------Device not getting detected when connected---------------------------
>> >>
>> >> / # [  135.621002] usbhs_wakeup: Enabling clocks
>> >> [  135.625762] usbhs_runtime_resume:++++++
>> >> [  135.630371] usbhs_runtime_resume:------
>> >> [  135.638183] USB IO PAD Wakeup event triggered##################
>> >> [  135.644958] usbhs_runtime_suspend:++++++
>> >> [  135.649749] usbhs_runtime_suspend:-----
>> >
>> > It appears that ohci_irq() didn't run.  Did
>> > ohci_finish_controller_resume() get called?
>> >
>> This function is not used in ohci-omap3.c and is used only in ohci-omap.c.
>> Is it necessary to call this function?
>
> It is necessary if the driver supports suspend/resume.  As far as I can
> tell, the ohci-omap3 driver does not have this support (at least, not
> in the 3.6 kernel) whereas the ohci-omap driver does.
>
> What driver produced the "usbhs_runtime_suspend" and
> "usbhs_runtime_resume" messages above?  (No such messages are present
> in ohci-omap3.c.)  Apparently that driver _does_ support
> suspend/resume.
>
This driver is USBHS core driver for OMAP EHCI and OHCI
(drivers/mfd/omap-usb-host.c)

Thanks,
Mohan
