From: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] OMAP: USB : Fix the EHCI enumeration and core retention issue
Date: Fri, 22 Jun 2012 07:11:10 -0700
Message-ID: <87vcij1loh.fsf@ti.com>
References: <1340286132-20634-1-git-send-email-keshava_mgowda@ti.com>
	<CAP05o4KOprVvgJ5aLD2+LLARtspRFkoE0Rob-dtVC7CefO-W2A@mail.gmail.com>
	<87fw9o32v2.fsf@ti.com>
	<CAP05o4KxWFjCCP05KzQgo4vWLdvOCeT=DWGXvEEnyWkomH1tXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAP05o4KxWFjCCP05KzQgo4vWLdvOCeT=DWGXvEEnyWkomH1tXA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
	(Keshava Munegowda's message of "Fri, 22 Jun 2012 13:00:39 +0530")
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Munegowda, Keshava" <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

"Munegowda, Keshava" <keshava_mgowda-l0cyMroinI0@public.gmane.org> writes:

[...]

>>>
>>> hi kevin
>>>
>>> here is pm count log on beagle XM with the above patch:
>>
>> What are you meaning to show by this log?
>>
>> This dump shows that neither PER or CORE are hitting retention in idle.
>> Which sounds to me like you have not enabled UART runtime suspend:
>>
>> echo 3000 > /sys/devices/platform/omap_uart.0/power/autosuspend_delay_ms
>> echo 3000 > /sys/devices/platform/omap_uart.1/power/autosuspend_delay_ms
>> echo 3000 > /sys/devices/platform/omap_uart.2/power/autosuspend_delay_ms
>> echo 3000 > /sys/devices/platform/omap_uart.3/power/autosuspend_delay_ms
>>
>> My test with your patch shows that it fixes the oops during boot, and
>> doesn't hang during suspend, but that USB host is still preventing CORE
>> retention during idle (after UART runtime suspend is enabled.)
>>
>> This happens on 3530/Overo, 3630/Beagle-xM and 3730/Overo
>>
>> Setting CONFIG_MFD_OMAP_USB_HOST=n allows CORE to hit retention again.
>>
>> Kevin
>
>
>
> Hi kevin
>        It woks. only the log was wrong. I was using no_console_suspend
> in boot args.
> i removed it. now I can see the core retention hits with USB host in Beagle XM.
> below is the log:
>

You are not reading what I write.

To repeat: your patch fixes the oops during boot, and the suspend hang
and now I see CORE hit retention in *suspend*.

However,  CORE does still not hit retention during *idle*.

Setting CONFIG_MFD_OMAP_USB_HOST=n allows CORE to hit retention again.

Please investgate the *idle* problems caused by this driver.  

As I said way back in the beginning this thread.  The runtime PM of this
driver is leaving the device enabled.

To test idle retention, ensure the UART auto-suspend is enable for all
UARTS:

echo 3000 > /sys/devices/platform/omap_uart.0/power/autosuspend_delay_ms
echo 3000 > /sys/devices/platform/omap_uart.1/power/autosuspend_delay_ms
echo 3000 > /sys/devices/platform/omap_uart.2/power/autosuspend_delay_ms
echo 3000 > /sys/devices/platform/omap_uart.3/power/autosuspend_delay_ms

Then wait > 3 seconds and 'cat /debug/pm_debug/count'.  

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
