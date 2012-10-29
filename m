From: Mohan V <mohanvforum-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Problem with OHCI on OMAP4430
Date: Mon, 29 Oct 2012 16:09:22 +0530
Message-ID: <CANP3njys-W+JXdkH3Vj-90VgMENwtcDMZ6y-oEift3fC89yYwg@mail.gmail.com>
References: <CANP3njw4=efheeOq9TsusNBwHASSfF7tG_1jYc4aHdW6+sX2zQ@mail.gmail.com>
	<Pine.LNX.4.44L0.1210261057580.6007-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44L0.1210261057580.6007-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, keshava_mgowda-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Alan,

On Fri, Oct 26, 2012 at 8:49 PM, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org> wrote:
> On Fri, 26 Oct 2012, Mohan V wrote:
>
>> >> When the USB bus is in suspend, a device connected to OHCI port does
>> >> not get detected, whereas the device connected to EHCI port is getting detected.
>> >
>> > Can you provide a dmesg log showing the OHCI problem with
>> > CONFIG_USB_DEBUG enabled?
>> >
>> Please find the attached log (ohci-detect.log), where the device is
>> disconnected from the
>> OHCI port and then does not get detected when connected again.
>> We are using android 3.0 kernel.
>
> I'm not going to be able to help very much with an Android kernel.
> Does the same problem occur with a vanilla non-Android 3.6 kernel?  If
> it doesn't, that indicates the problem was caused by some
> Android-specific changes.
>
With the vanilla 3.6 kernel, the device connected to OHCI port is not even
detected. The below messages are seen:

[    5.343780] usb 2-2: new low-speed USB device number 5 using ohci-omap3
[    5.351776] ohci-omap3 ohci-omap3.0: urb ee7f83c0 path 2 ep0out
5ec20000 cc 5 --> status -62
[    5.570770] ohci-omap3 ohci-omap3.0: urb ee7f83c0 path 2 ep0out
5ec20000 cc 5 --> status -62
[    5.789062] usb 2-2: device not accepting address 5, error -62
[    5.795288] hub 2-0:1.0: unable to enumerate USB device on port 2
-----------------------------------------------------------------------------------------------------------------

We think it may not be hardware issue, since the device gets detected on
android-3.0 kernel. The support for OHCI on OMAP4430 SDP board
seems to be missing in Linux mainline (3.6).

We ported some OMAP specific patches from android kernel, with this the
device gets detected only if it is connected at boot.
If the system is booted and then device is connected, it doesn't get detected.

> Are you referring to this part of the log?
>
>> ------------------------Device not getting detected when connected---------------------------
>>
>> / # [  135.621002] usbhs_wakeup: Enabling clocks
>> [  135.625762] usbhs_runtime_resume:++++++
>> [  135.630371] usbhs_runtime_resume:------
>> [  135.638183] USB IO PAD Wakeup event triggered##################
>> [  135.644958] usbhs_runtime_suspend:++++++
>> [  135.649749] usbhs_runtime_suspend:-----
>
> It appears that ohci_irq() didn't run.  Did
> ohci_finish_controller_resume() get called?
>
This function is not used in ohci-omap3.c and is used only in ohci-omap.c.
Is it necessary to call this function?

> My guess is your usbhs_runtime_resume() routine has a bug.  Maybe the
> usbhs_runtime_suspend() routine does too.
>
>> We sometime see the crash in "ohci_hub_status_data" function. So, when
>> we add the
>> below check at the entry of the function, there is no crash. Please
>> find attached crash log.
>> (ohci-crash.log)
>
> I don't understand the crash log.  What is the cause of the crash?  Is
> there some error involving spin_lock_irqrestore() in
> ohci_hub_status_data()
>
>>         if (!HC_IS_RUNNING(hcd->state)) {
>>               return 0;
>>       }
>>
>> But the device does not get detected subsequently with this change. There is
>> a similar check in ehci-hub.c.
>
> No, there isn't.  Not since the 3.1 kernel.  In any case, ehci-hcd is
> different from ohci-hcd; you shouldn't expect their hub_status_data
> routines to be the same.
>
Ok, I understand.

Thanks,
Mohan
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
