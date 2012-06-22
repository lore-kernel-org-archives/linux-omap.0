From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] OMAP: USB : Fix the EHCI enumeration and core retention issue
Date: Fri, 22 Jun 2012 11:49:22 -0700
Message-ID: <87lijfkwr1.fsf@ti.com>
References: <1340286132-20634-1-git-send-email-keshava_mgowda@ti.com>
	<CAP05o4KOprVvgJ5aLD2+LLARtspRFkoE0Rob-dtVC7CefO-W2A@mail.gmail.com>
	<87fw9o32v2.fsf@ti.com>
	<CAP05o4KxWFjCCP05KzQgo4vWLdvOCeT=DWGXvEEnyWkomH1tXA@mail.gmail.com>
	<87vcij1loh.fsf@ti.com>
	<CAP05o4+6LxwdwCUQF_0b6dCQ9JQarNeUBzO=qgdUgnreMtDeMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog135.obsmtp.com ([74.125.149.84]:38235 "EHLO
	na3sys009aog135.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755920Ab2FVSt0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 22 Jun 2012 14:49:26 -0400
Received: by pbcwy7 with SMTP id wy7so5113970pbc.17
        for <linux-omap@vger.kernel.org>; Fri, 22 Jun 2012 11:49:25 -0700 (PDT)
In-Reply-To: <CAP05o4+6LxwdwCUQF_0b6dCQ9JQarNeUBzO=qgdUgnreMtDeMg@mail.gmail.com>
	(Keshava Munegowda's message of "Fri, 22 Jun 2012 20:13:49 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Cc: linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, balbi@ti.com, sameo@linux.intel.com, notasas@gmail.com

"Munegowda, Keshava" <keshava_mgowda@ti.com> writes:

> On Fri, Jun 22, 2012 at 7:41 PM, Kevin Hilman <khilman@ti.com> wrote:
>> "Munegowda, Keshava" <keshava_mgowda@ti.com> writes:
>>
>> [...]
>>
>>>>>
>>>>> hi kevin
>>>>>
>>>>> here is pm count log on beagle XM with the above patch:
>>>>
>>>> What are you meaning to show by this log?
>>>>
>>>> This dump shows that neither PER or CORE are hitting retention in =
idle.
>>>> Which sounds to me like you have not enabled UART runtime suspend:
>>>>
>>>> echo 3000 > /sys/devices/platform/omap_uart.0/power/autosuspend_de=
lay_ms
>>>> echo 3000 > /sys/devices/platform/omap_uart.1/power/autosuspend_de=
lay_ms
>>>> echo 3000 > /sys/devices/platform/omap_uart.2/power/autosuspend_de=
lay_ms
>>>> echo 3000 > /sys/devices/platform/omap_uart.3/power/autosuspend_de=
lay_ms
>>>>
>>>> My test with your patch shows that it fixes the oops during boot, =
and
>>>> doesn't hang during suspend, but that USB host is still preventing=
 CORE
>>>> retention during idle (after UART runtime suspend is enabled.)
>>>>
>>>> This happens on 3530/Overo, 3630/Beagle-xM and 3730/Overo
>>>>
>>>> Setting CONFIG_MFD_OMAP_USB_HOST=3Dn allows CORE to hit retention =
again.
>>>>
>>>> Kevin
>>>
>>>
>>>
>>> Hi kevin
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0It woks. only the log was wrong. I was u=
sing no_console_suspend
>>> in boot args.
>>> i removed it. now I can see the core retention hits with USB host i=
n Beagle XM.
>>> below is the log:
>>>
>>
>> You are not reading what I write.
>>
>> To repeat: your patch fixes the oops during boot, and the suspend ha=
ng
>> and now I see CORE hit retention in *suspend*.
>
> thanks !
>
>>
>> However, =C2=A0CORE does still not hit retention during *idle*.
>
> here is the problem.
>
> usb host retention in idle is not supported till now.
> in current code, usb host cuts clock only in driver suspend not in bu=
s
> suspend ( auto suspend).
>
> usb host driver need to use the  io daisy chain framework through io =
wakeup.
> I will post the patches once ehci remote wakeup features stabilized i=
n
> omap3, omap4 and omap5 too.

Then I suggest you revert the changes that introduced this PM support
until it is fully working. =20

The current form of the code prevents retention for the *whole* SoC
during idle because it prevents CORE retention.

The PM support for this driver was clearly not fully tested and should
be reverted until it can be tested and fully validated.

Please revert the PM changes for v3.5-rc.

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
