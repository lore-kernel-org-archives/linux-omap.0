From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v2 11/12] OMAP: Serial: Use resume call from prcm to enable uart
Date: Fri, 06 May 2011 08:55:53 -0700
Message-ID: <87bozf962e.fsf@ti.com>
References: <1304080796-625-1-git-send-email-govindraj.raja@ti.com>
	<1304080796-625-12-git-send-email-govindraj.raja@ti.com>
	<87pqnym2f2.fsf@ti.com>
	<BANLkTi=32NfMr7exWpOoPHX7_-Jc0i5LqA@mail.gmail.com>
	<87liylkxdi.fsf@ti.com>
	<BANLkTinr8n0P31LWPrwL83sWCzVQOqo6=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:44137 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756537Ab1EFPz7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 6 May 2011 11:55:59 -0400
In-Reply-To: <BANLkTinr8n0P31LWPrwL83sWCzVQOqo6=Q@mail.gmail.com> (Govindraj's
	message of "Fri, 6 May 2011 14:46:48 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Govindraj <govindraj.ti@gmail.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@ti.com>

Govindraj <govindraj.ti@gmail.com> writes:

> On Thu, May 5, 2011 at 8:28 PM, Kevin Hilman <khilman@ti.com> wrote:
>> Govindraj <govindraj.ti@gmail.com> writes:
>>
>> [...]
>>
>>>>
>>>> ... this is just putting back basically the same thing that was re=
moved in
>>>> patch 1. =C2=A0IOW, this is now being checked for *every* PRCM wak=
eup, which
>>>> is no different than having it in the idle path.
>>>>
>>>> I thought I understood that you had the SW IRQ triggering working,=
 so
>>>> this part should not be necessary.
>>>
>>> Actually I tried few experiments but couldn't get it working.
>>
>> What exactly is not working? =C2=A0 The interrupt is not firing at a=
ll? =C2=A0The
>> driver's ISR is not being called?
>>
>
> It throws a oops as here
>
> http://pastebin.com/5bcPjAA0

This doesn't help understand what exactly is not working.  This needs
to be debugged further to understand the root cause.

A quick glance at the oops shows a fault when accessing a *physical*
address within the INTC.  The MMU is enabled here, and HW accesss shoul=
d
be using a virtual address. =20

Also, early in the boot there are a pile of other errors coming from th=
e
clock framework suggesting that this kernel has some other basic
problems as well.

> Reproduced with below [EXP-1] change + below kernel.
>
> git://gitorious.org/uart_runtime/pm.git
> [Has uart runtime patches based on pm-core branch]
>
>>> Tried below but didn't help.
>>>
>>> ------------------------------------
>>> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm3=
4xx.c
>>> index 3960330..2c1dfc2 100644
>>> --- a/arch/arm/mach-omap2/pm34xx.c
>>> +++ b/arch/arm/mach-omap2/pm34xx.c
>>> @@ -288,6 +288,16 @@ static irqreturn_t prcm_interrupt_handler (int
>>> irq, void *dev_id)
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 do {
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (irqstat=
us_mpu & (OMAP3430_WKUP_ST_MASK |
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OMAP3430=
_IO_ST_MASK)) {
>>> +#if 1
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 /*
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0* EXP-1: SET UART1 SOFT IRQ BIT
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0* 3430 -SDP UART1 console.
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0* M_IRQ_72, INTCPS_ISR_SET
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0* 0x4820 0090 + (0x20 * n)
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0* bit-8 n =3D 2
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0*/
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 __raw_writel(0x100 , 0x482000D0);
>>> +#endif
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 c =3D _prcm_int_handle_wakeup();
>>>
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 /*
>>>
>>> -----------------------------------
>>>
>>> Currently we are planning to integrate irq_chaining patches
>>> on top uart_runtime patches which is work-in-progress.
>>> Will remove resume_idle once we have irq_chaining patches available=
=2E
>>
>> Well, I'm not OK with $SUBJECT patch as it is since it's just moving=
 an
>> ugly hack from serial.c to the PRCM ISR. =C2=A0If the hack is going =
to stay,
>> then it should stay where it is until it can be fixed for real.
>
> Now with runtime changes we are cutting clocks independently
> whereas prior to this we where cutting clocks only in sram_idle path.
>
> With runtime changes:
> 1.) Once we cut uart clocks and send a char to uart it directs wakeup=
_irq to
> prcm_irq_handler the one way to wakeup uart from there was to check
> uart mod wakeup status bits if wakeup event occurred then wakeup the
> particular uart.
> 2.) Moving this resume back to sram path will break module wakeup aft=
er
> uart clocks are disabled(using put_sync)
>
> Thats the reason I have moved this to prcm_irq path to ensure
> once auto-suspend happens after inactivity period we have resume_call
> to wakeup uart port.

I understand, but the point is that this approach is still the same as
the previous hack (check for UART wakeup on *every* wakeup event.)

What is needed is to further investigate using SW triggered IRQs can be
done for these wakeup events so we can get away from the above approach
all together.

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
