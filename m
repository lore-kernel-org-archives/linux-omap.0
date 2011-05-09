From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH v2 11/12] OMAP: Serial: Use resume call from prcm to
 enable uart
Date: Mon, 9 May 2011 17:53:34 +0530
Message-ID: <BANLkTimruC2dWUCEUyiABQ-M5PABtL32SA@mail.gmail.com>
References: <1304080796-625-1-git-send-email-govindraj.raja@ti.com>
 <1304080796-625-12-git-send-email-govindraj.raja@ti.com> <87pqnym2f2.fsf@ti.com>
 <BANLkTi=32NfMr7exWpOoPHX7_-Jc0i5LqA@mail.gmail.com> <87liylkxdi.fsf@ti.com>
 <BANLkTinr8n0P31LWPrwL83sWCzVQOqo6=Q@mail.gmail.com> <87bozf962e.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:54428 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750747Ab1EIMXz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 May 2011 08:23:55 -0400
In-Reply-To: <87bozf962e.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@ti.com>, "Mahadeva, Avinash" <avinashhm@ti.com>

On Fri, May 6, 2011 at 9:25 PM, Kevin Hilman <khilman@ti.com> wrote:
> Govindraj <govindraj.ti@gmail.com> writes:
>
>> On Thu, May 5, 2011 at 8:28 PM, Kevin Hilman <khilman@ti.com> wrote:
>>> Govindraj <govindraj.ti@gmail.com> writes:
>>>
>>> [...]
>>>
>>>>>
>>>>> ... this is just putting back basically the same thing that was r=
emoved in
>>>>> patch 1. =A0IOW, this is now being checked for *every* PRCM wakeu=
p, which
>>>>> is no different than having it in the idle path.
>>>>>
>>>>> I thought I understood that you had the SW IRQ triggering working=
, so
>>>>> this part should not be necessary.
>>>>
>>>> Actually I tried few experiments but couldn't get it working.
>>>
>>> What exactly is not working? =A0 The interrupt is not firing at all=
? =A0The
>>> driver's ISR is not being called?
>>>
>>
>> It throws a oops as here
>>
>> http://pastebin.com/5bcPjAA0
>
> This doesn't help understand what exactly is not working. =A0This nee=
ds
> to be debugged further to understand the root cause.
>
> A quick glance at the oops shows a fault when accessing a *physical*
> address within the INTC. =A0The MMU is enabled here, and HW accesss s=
hould
> be using a virtual address.

Today we could get console_uart booted with irq_patches + uart_runtime
shared by Avinash [Irq_chaining + some local hacks, still not clean pat=
ches]

But AFAIK looks like still soft irq method is not generic as we dont
have any similar mechanism for omap4 so how to keep it consistent.

So Shall we retain resume method until we have a generic approach ?

--
Thanks,
Govindraj.R


>
> Also, early in the boot there are a pile of other errors coming from =
the
> clock framework suggesting that this kernel has some other basic
> problems as well.
>
>> Reproduced with below [EXP-1] change + below kernel.
>>
>> git://gitorious.org/uart_runtime/pm.git
>> [Has uart runtime patches based on pm-core branch]
>>
>>>> Tried below but didn't help.
>>>>
>>>> ------------------------------------
>>>> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm=
34xx.c
>>>> index 3960330..2c1dfc2 100644
>>>> --- a/arch/arm/mach-omap2/pm34xx.c
>>>> +++ b/arch/arm/mach-omap2/pm34xx.c
>>>> @@ -288,6 +288,16 @@ static irqreturn_t prcm_interrupt_handler (in=
t
>>>> irq, void *dev_id)
>>>> =A0 =A0 =A0 =A0 do {
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (irqstatus_mpu & (OMAP3430_WKUP=
_ST_MASK |
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0OMAP3430_IO_ST_MASK)) {
>>>> +#if 1
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* EXP-1: SET UART=
1 SOFT IRQ BIT
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* 3430 -SDP UART1=
 console.
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* M_IRQ_72, INTCP=
S_ISR_SET
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* 0x4820 0090 + (=
0x20 * n)
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* bit-8 n =3D 2
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(0x100 ,=
 0x482000D0);
>>>> +#endif
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 c =3D _prcm_int_ha=
ndle_wakeup();
>>>>
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>>>>
>>>> -----------------------------------
>>>>
>>>> Currently we are planning to integrate irq_chaining patches
>>>> on top uart_runtime patches which is work-in-progress.
>>>> Will remove resume_idle once we have irq_chaining patches availabl=
e.
>>>
>>> Well, I'm not OK with $SUBJECT patch as it is since it's just movin=
g an
>>> ugly hack from serial.c to the PRCM ISR. =A0If the hack is going to=
 stay,
>>> then it should stay where it is until it can be fixed for real.
>>
>> Now with runtime changes we are cutting clocks independently
>> whereas prior to this we where cutting clocks only in sram_idle path=
=2E
>>
>> With runtime changes:
>> 1.) Once we cut uart clocks and send a char to uart it directs wakeu=
p_irq to
>> prcm_irq_handler the one way to wakeup uart from there was to check
>> uart mod wakeup status bits if wakeup event occurred then wakeup the
>> particular uart.
>> 2.) Moving this resume back to sram path will break module wakeup af=
ter
>> uart clocks are disabled(using put_sync)
>>
>> Thats the reason I have moved this to prcm_irq path to ensure
>> once auto-suspend happens after inactivity period we have resume_cal=
l
>> to wakeup uart port.
>
> I understand, but the point is that this approach is still the same a=
s
> the previous hack (check for UART wakeup on *every* wakeup event.)
>
> What is needed is to further investigate using SW triggered IRQs can =
be
> done for these wakeup events so we can get away from the above approa=
ch
> all together.
>
> Kevin
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
