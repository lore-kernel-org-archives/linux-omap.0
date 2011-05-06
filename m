From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH v2 11/12] OMAP: Serial: Use resume call from prcm to
 enable uart
Date: Fri, 6 May 2011 14:46:48 +0530
Message-ID: <BANLkTinr8n0P31LWPrwL83sWCzVQOqo6=Q@mail.gmail.com>
References: <1304080796-625-1-git-send-email-govindraj.raja@ti.com>
 <1304080796-625-12-git-send-email-govindraj.raja@ti.com> <87pqnym2f2.fsf@ti.com>
 <BANLkTi=32NfMr7exWpOoPHX7_-Jc0i5LqA@mail.gmail.com> <87liylkxdi.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <87liylkxdi.fsf@ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@ti.com>
List-Id: linux-omap@vger.kernel.org

On Thu, May 5, 2011 at 8:28 PM, Kevin Hilman <khilman@ti.com> wrote:
> Govindraj <govindraj.ti@gmail.com> writes:
>
> [...]
>
>>>
>>> ... this is just putting back basically the same thing that was rem=
oved in
>>> patch 1. =A0IOW, this is now being checked for *every* PRCM wakeup,=
 which
>>> is no different than having it in the idle path.
>>>
>>> I thought I understood that you had the SW IRQ triggering working, =
so
>>> this part should not be necessary.
>>
>> Actually I tried few experiments but couldn't get it working.
>
> What exactly is not working? =A0 The interrupt is not firing at all? =
=A0The
> driver's ISR is not being called?
>

It throws a oops as here

http://pastebin.com/5bcPjAA0

Reproduced with below [EXP-1] change + below kernel.

git://gitorious.org/uart_runtime/pm.git
[Has uart runtime patches based on pm-core branch]

>> Tried below but didn't help.
>>
>> ------------------------------------
>> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34=
xx.c
>> index 3960330..2c1dfc2 100644
>> --- a/arch/arm/mach-omap2/pm34xx.c
>> +++ b/arch/arm/mach-omap2/pm34xx.c
>> @@ -288,6 +288,16 @@ static irqreturn_t prcm_interrupt_handler (int
>> irq, void *dev_id)
>> =A0 =A0 =A0 =A0 do {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (irqstatus_mpu & (OMAP3430_WKUP_S=
T_MASK |
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0OMAP3430_IO_ST_MASK)) {
>> +#if 1
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* EXP-1: SET UART1 =
SOFT IRQ BIT
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* 3430 -SDP UART1 c=
onsole.
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* M_IRQ_72, INTCPS_=
ISR_SET
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* 0x4820 0090 + (0x=
20 * n)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* bit-8 n =3D 2
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(0x100 , 0=
x482000D0);
>> +#endif
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 c =3D _prcm_int_hand=
le_wakeup();
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>>
>> -----------------------------------
>>
>> Currently we are planning to integrate irq_chaining patches
>> on top uart_runtime patches which is work-in-progress.
>> Will remove resume_idle once we have irq_chaining patches available.
>
> Well, I'm not OK with $SUBJECT patch as it is since it's just moving =
an
> ugly hack from serial.c to the PRCM ISR. =A0If the hack is going to s=
tay,
> then it should stay where it is until it can be fixed for real.

Now with runtime changes we are cutting clocks independently
whereas prior to this we where cutting clocks only in sram_idle path.

With runtime changes:
1.) Once we cut uart clocks and send a char to uart it directs wakeup_i=
rq to
prcm_irq_handler the one way to wakeup uart from there was to check
uart mod wakeup status bits if wakeup event occurred then wakeup the
particular uart.
2.) Moving this resume back to sram path will break module wakeup after
uart clocks are disabled(using put_sync)

Thats the reason I have moved this to prcm_irq path to ensure
once auto-suspend happens after inactivity period we have resume_call
to wakeup uart port.

--
Thanks,
Govindraj.R

>
> Kevin
>
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
