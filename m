From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 5/6] ARM: OMAP4: CLKDM: Update supported transition modes
Date: Tue, 15 May 2012 20:15:29 +0530
Message-ID: <CAMQu2gwLr+c5S6pqvJg+F1=_DpGovnt=psEVT1KSHL-fFS48kg@mail.gmail.com>
References: <1336599364-11024-1-git-send-email-jon-hunter@ti.com>
 <4FAB6623.9090005@ti.com> <4FB2693E.7090303@ti.com> <4FB26ADE.1060206@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog138.obsmtp.com ([74.125.149.19]:48623 "EHLO
	na3sys009aog138.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757448Ab2EOOpv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 May 2012 10:45:51 -0400
Received: by qabg1 with SMTP id g1so4181091qab.13
        for <linux-omap@vger.kernel.org>; Tue, 15 May 2012 07:45:50 -0700 (PDT)
In-Reply-To: <4FB26ADE.1060206@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Jon Hunter <jon-hunter@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Ming Lei <ming.lei@canonical.com>, Will Deacon <will.deacon@arm.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>

On Tue, May 15, 2012 at 8:10 PM, Cousson, Benoit <b-cousson@ti.com> wro=
te:
> Hi Jon,
>
>
> On 5/15/2012 4:33 PM, Jon Hunter wrote:
>>
>> Hi Santosh, Benoit,
>>
>> On 05/10/2012 01:54 AM, Santosh Shilimkar wrote:
>>>
>>> On Thursday 10 May 2012 03:06 AM, Jon Hunter wrote:
>>>>
>>>> From: Jon Hunter<jon-hunter@ti.com>
>>>>
>>>> For OMAP3+ devices, the clock domains (CLKDMs) support one or more=
 of
>>>> the
>>>> following transition modes ...
>>>>
>>>> NO_SLEEP (0x0) - A clock domain sleep transition is never initiate=
d,
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 irrespective of the hardware condi=
tions.
>>>> SW_SLEEP (0x1) - A software-forced sleep transition. The transitio=
n is
>>>> initiated
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 when the associated hardware condi=
tions are satisfied
>>>> SW_WKUP =A0(0x2) - A software-forced clock domain wake-up transiti=
on is
>>>> initiated,
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 irrespective of the hardware condi=
tions.
>>>> HW_AUTO =A0(0x3) - Hardware-controlled automatic sleep and wake-up
>>>> transition is
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 initiated by the PRCM module when =
the associated
>>>> hardware
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 conditions are satisfied.
>>>>
>>>> For OMAP4 devices, SW_SLEEP is equivalent to HW_AUTO and NO_SLEEP =
is
>>>> equivalent
>>>> to SW_WKUP. For OMAP4 devices, all CLKDMs support HW_AUTO and ther=
efore
>>>> we can
>>>> place the CLKDMs in the HW_AUTO state instead of the SW_SLEEP mode=
=2E
>>>> Hence, we
>>>> do not need to use the SW_SLEEP mode. With regard to NO_SLEEP and
>>>> SW_WKUP it is
>>>> preferred to use SW_WKUP mode if the CLKDM supports it and so use =
this
>>>> mode
>>>> instead of NO_SLEEP where possible.
>>>>
>>>> For a software perspective the above 4 modes are represented by th=
e
>>>> following
>>>> flags to indicate what modes are supported by each of the CLKDMs.
>>>>
>>>> CLKDM_CAN_DISABLE_AUTO =A0--> =A0NO_SLEEP
>>>> CLKDM_CAN_ENABLE_AUTO =A0 --> =A0HW_AUTO
>>>> CLKDM_CAN_FORCE_SLEEP =A0 --> =A0SW_SLEEP
>>>> CLKDM_CAN_FORCE_WAKEUP =A0--> =A0SW_WKUP
>>>>
>>>> By eliminating the SW_SLEEP mode the the mapping of the flags for =
OMAP4
>>>> devices
>>>> can becomes ...
>>>>
>>>> CLKDM_CAN_DISABLE_AUTO =A0--> =A0NO_SLEEP
>>>> CLKDM_CAN_ENABLE_AUTO =A0 --> =A0HW_AUTO
>>>> CLKDM_CAN_FORCE_SLEEP =A0 --> =A0HW_AUTO
>>>
>>> Not sure if this can be entirely correct for OMAP4.
>>> Because HW_AUTO =3D "Sleep and wakeup transition are
>>> based upon hardware conditions"
>>> Where as SW_SLEEP =3D "Start a software forced sleep
>>> transition on the domain."
>>>
>>> I will reply on the the thread where this is being discussed.
>>
>>
>> Given that feedback we received that the only difference between HW_=
AUTO
>> and SW_SLEEP is "that the PRM_IRQSTATUS_MPU.TRANSITION_ST interrupt
>> status is set in case of SW_SLEEP transition, and not set in case of
>> HW_AUTO transition". Are you ok with this change? If so can you sign=
-off
>> on this?
>
>
> Yep I'm OK with that, but Paul is the only one who can sign-off this =
patch.
>
> Reviewed-by: Benoit Cousson <b-cousson@ti.com>
>
Am OK as well.
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
