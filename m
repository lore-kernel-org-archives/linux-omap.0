From: "Munegowda, Keshava" <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] OMAP: USB : Fix the EHCI enumeration and core retention issue
Date: Fri, 22 Jun 2012 20:13:49 +0530
Message-ID: <CAP05o4+6LxwdwCUQF_0b6dCQ9JQarNeUBzO=qgdUgnreMtDeMg@mail.gmail.com>
References: <1340286132-20634-1-git-send-email-keshava_mgowda@ti.com>
	<CAP05o4KOprVvgJ5aLD2+LLARtspRFkoE0Rob-dtVC7CefO-W2A@mail.gmail.com>
	<87fw9o32v2.fsf@ti.com>
	<CAP05o4KxWFjCCP05KzQgo4vWLdvOCeT=DWGXvEEnyWkomH1tXA@mail.gmail.com>
	<87vcij1loh.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87vcij1loh.fsf-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Fri, Jun 22, 2012 at 7:41 PM, Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org> wrote:
> "Munegowda, Keshava" <keshava_mgowda-l0cyMroinI0@public.gmane.org> writes:
>
> [...]
>
>>>>
>>>> hi kevin
>>>>
>>>> here is pm count log on beagle XM with the above patch:
>>>
>>> What are you meaning to show by this log?
>>>
>>> This dump shows that neither PER or CORE are hitting retention in i=
dle.
>>> Which sounds to me like you have not enabled UART runtime suspend:
>>>
>>> echo 3000 > /sys/devices/platform/omap_uart.0/power/autosuspend_del=
ay_ms
>>> echo 3000 > /sys/devices/platform/omap_uart.1/power/autosuspend_del=
ay_ms
>>> echo 3000 > /sys/devices/platform/omap_uart.2/power/autosuspend_del=
ay_ms
>>> echo 3000 > /sys/devices/platform/omap_uart.3/power/autosuspend_del=
ay_ms
>>>
>>> My test with your patch shows that it fixes the oops during boot, a=
nd
>>> doesn't hang during suspend, but that USB host is still preventing =
CORE
>>> retention during idle (after UART runtime suspend is enabled.)
>>>
>>> This happens on 3530/Overo, 3630/Beagle-xM and 3730/Overo
>>>
>>> Setting CONFIG_MFD_OMAP_USB_HOST=3Dn allows CORE to hit retention a=
gain.
>>>
>>> Kevin
>>
>>
>>
>> Hi kevin
>> =A0 =A0 =A0 =A0It woks. only the log was wrong. I was using no_conso=
le_suspend
>> in boot args.
>> i removed it. now I can see the core retention hits with USB host in=
 Beagle XM.
>> below is the log:
>>
>
> You are not reading what I write.
>
> To repeat: your patch fixes the oops during boot, and the suspend han=
g
> and now I see CORE hit retention in *suspend*.

thanks !

>
> However, =A0CORE does still not hit retention during *idle*.

here is the problem.

usb host retention in idle is not supported till now.
in current code, usb host cuts clock only in driver suspend not in bus
suspend ( auto suspend).
usb host driver need to use the  io daisy chain framework through io wa=
keup.
I will post the patches once ehci remote wakeup features stabilized in
omap3, omap4 and omap5 too.

regards
keshava
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
