From: Mohan V <mohanvforum@gmail.com>
Subject: Re: Problem with OHCI on OMAP4430
Date: Mon, 26 Nov 2012 16:49:02 +0530
Message-ID: <CANP3njxGYTRfJVs1OC9+79ZKkh1zbkrwEErjMHteB1z0dJYBxA@mail.gmail.com>
References: <CANP3njwd94MQMW2JjB8e73-25YJu-14tz+QOybi8aP=uOPaSZg@mail.gmail.com>
	<Pine.LNX.4.44L0.1210301151270.1363-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:46365 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754662Ab2KZLTD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Nov 2012 06:19:03 -0500
In-Reply-To: <Pine.LNX.4.44L0.1210301151270.1363-100000@iolanthe.rowland.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, keshava_mgowda@ti.com

Alan,

On Tue, Oct 30, 2012 at 9:34 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Tue, 30 Oct 2012, Mohan V wrote:
>
>> >> >> ------------------------Device not getting detected when connected---------------------------
>> >> >>
>> >> >> / # [  135.621002] usbhs_wakeup: Enabling clocks
>> >> >> [  135.625762] usbhs_runtime_resume:++++++
>> >> >> [  135.630371] usbhs_runtime_resume:------
>> >> >> [  135.638183] USB IO PAD Wakeup event triggered##################
>> >> >> [  135.644958] usbhs_runtime_suspend:++++++
>> >> >> [  135.649749] usbhs_runtime_suspend:-----
>> >> >
>> >> > It appears that ohci_irq() didn't run.  Did
>> >> > ohci_finish_controller_resume() get called?
>> >> >
>> >> This function is not used in ohci-omap3.c and is used only in ohci-omap.c.
>> >> Is it necessary to call this function?
>> >
>> > It is necessary if the driver supports suspend/resume.  As far as I can
>> > tell, the ohci-omap3 driver does not have this support (at least, not
>> > in the 3.6 kernel) whereas the ohci-omap driver does.
>> >
>> > What driver produced the "usbhs_runtime_suspend" and
>> > "usbhs_runtime_resume" messages above?  (No such messages are present
>> > in ohci-omap3.c.)  Apparently that driver _does_ support
>> > suspend/resume.
>> >
>> This driver is USBHS core driver for OMAP EHCI and OHCI
>> (drivers/mfd/omap-usb-host.c)
>
> Okay.  I don't understand why the usbhs_runtime_suspend routine ever
> got called.  Since ohci-omap3 never allows the OHCI controller to be
> suspended, the parent platform device should never get suspended
> either.
>
Sorry for the delay in confirmation. In the android kernel, it seems
that somehow the OHCI interrupts are not
propagated to ARM interrupt controller.
So, reading one of the OHCI registers in usbhs_runtime_resume() seems
to resolve the issue.

Thanks,
Mohan

> What do the various files in the /sys/devices/.../ohci-omap3.0/power
> directory show?  What about the corresponding files in the power
> subdirectory of the parent device?
>
> Alan Stern
>
