From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v7 17/21] OMAP2+: UART: Remove omap_uart_can_sleep and add pm_qos
Date: Thu, 10 Nov 2011 11:02:03 -0800
Message-ID: <87aa83er84.fsf@ti.com>
References: <1318952110-10659-1-git-send-email-govindraj.raja@ti.com>
	<1318952110-10659-3-git-send-email-govindraj.raja@ti.com>
	<87vcqz33y8.fsf@ti.com> <4EB8F368.5070603@ti.com>
	<87r51i1kva.fsf@ti.com>
	<CAAL8m4zLEnQE+BkK4xmLUBkREYOuqjmbBweKS0_qcEYUMo71nQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <CAAL8m4zLEnQE+BkK4xmLUBkREYOuqjmbBweKS0_qcEYUMo71nQ@mail.gmail.com>
	(Govindraj's message of "Thu, 10 Nov 2011 17:30:05 +0530")
Sender: linux-serial-owner@vger.kernel.org
To: Govindraj <govindraj.ti@gmail.com>
Cc: Rajendra Nayak <rnayak@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Partha Basak <p-basak2@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-serial@vger.kernel.org, Vishwanath Sripathy <vishwanath.bs@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Govindraj <govindraj.ti@gmail.com> writes:

> Hi Kevin,
>
> On Wed, Nov 9, 2011 at 12:50 AM, Kevin Hilman <khilman@ti.com> wrote:
>> Rajendra Nayak <rnayak@ti.com> writes:
>>
>>> Hi Kevin,
>>>
>>> On Saturday 05 November 2011 04:12 AM, Kevin Hilman wrote:
>>>> However, as mentioned previously[1], due to a HW sleepdep between =
MPU
>>>> and CORE, this constraint isn't actually needed for CORE UARTs, so=
 it's
>>>> a bit wasteful to go through all the constraint setting for no rea=
son.
>>>
>>> I had a short chat with Govind on this and was trying to understand
>>> this better.
>>> Are you referring to the 'autodeps' for omap3 here, because they wo=
uld
>>> prevent any clock domain from idling as long as MPU or IVA are acti=
ve,
>>
>> No, I was thinking of HW sleepdeps. =C2=A0However, I looked back at =
the
>> OMAP3430 TRM and see that MPU does not have a HW sleepdep on CORE li=
ke I
>> thought.
>>
>>> but not the other way round. Which means MPU can still idle, while =
CORE
>>> does not.
>>>
>>> My guess was, its probably the CORE domain idling itself thats caus=
ing
>>> the UART sluggishness, (and not MPU idling), due to higher latency,
>>> which is prevented with an active UART module in CORE, but not in P=
ER.
>>
>> OK, that indeed makes sense. =C2=A0Thanks for correcting me.
>>
>>> So Govind did a small experiment to prevent just CORE idling and le=
t MPU
>>> idle alone and that did not show any sluggishness.
>>
>> OK, good.
>>
>>> Now, putting a pm-qos constraint for a UART in CORE still looks
>>> redundant because the latency requirement that UART has is in
>>> some way *indirectly* met (because the active UART in CORE prevents
>>> CORE transitions in idle).
>>> But don't you think the UART driver should express its
>>> latency constraints regardless, without thinking of any indirect wa=
ys
>>> in which the same requirements would have already been met?
>>
>> Yes, you're right. =C2=A0The driver should not need to know which po=
werdomain
>> a given UART is in. =C2=A0It's probably best (and most portable) to =
have UART
>> always express its requirements all the time.
>>
>> Thanks for digging into this,
>>
>
> I have fixed this and other uart_v7 comments and have re-based the
> patch series on top
> of 3.2-rc1 along with Tero's v9 irq chaining patches and tested the s=
ame.
> Available here [1].

Please repost your updated series.

> Can this patches series be added to a test branch for upstreaming or =
do you
> think there are still some outstanding comments that needs to be disc=
ussed?

The PRCM IRQ chaining series is not yet finalized.

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
