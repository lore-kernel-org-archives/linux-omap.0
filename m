From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH 5/7] Serial: OMAP: add runtime pm support for omap-serial driver
Date: Wed, 9 Mar 2011 20:37:11 +0530
Message-ID: <AANLkTim0Xuu8Bs4tzyH1kQp2eS5nUq8stQX4MGzELEE6@mail.gmail.com>
References: <1298903958-6496-1-git-send-email-govindraj.raja@ti.com>
 <1298903958-6496-6-git-send-email-govindraj.raja@ti.com> <87r5am499h.fsf@ti.com>
 <AANLkTim35McK1cFFEXyS49D6b8CT+4pQfmKAswOn3e7_@mail.gmail.com> <87hbbdjc7y.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <87hbbdjc7y.fsf@ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@ti.com>
List-Id: linux-omap@vger.kernel.org

On Wed, Mar 9, 2011 at 7:18 AM, Kevin Hilman <khilman@ti.com> wrote:
> Govindraj <govindraj.ti@gmail.com> writes:
>
> [...]
>
>>> This function should not be needed.
>>>
>>> The timer should be replaced by the auto-suspend feature of runtime=
 PM.
>>
>> If I use autosuspend based on timer runtime framework
>> will disable clocks based on autosuspend timeout.
>>
>> But if I cut clocks outside sram idle path module level wakeup
>> will not work.
>> if I cut func clocks outside prepare for idle
>> wake_up is a problem.
>
> As I mentioned in the other thread, module wakeups are not the proble=
m,
> rather the module generating the interrupt is the problem. =A0So cutt=
ing
> clocks outside prepare_for_idle path is not the problem. =A0It's the
> re-enabling of the clocks that is important.
>
>> So I am going with existing model where we are cutting clocks in
>> prepare idle and enabling the clock back in resume_idle based on
>> wakeup event as any other combination doesn't seem to work.
>>
>> [As stated in other thread to reproduce the issue
>> with module level wakeup]
>>
>> Even with existing framework if I try to experiment
>> by cutting clocks after uart timeout in allow_sleep
>> func, module level wakeup doesn't seem to happen.
>>>
>>> Instead of calling omap_port_disable() callers should call
>>> pm_runtime_put_autosuspend(), and the console_stop() should be part=
 of
>>> the ->runtime_suspend() callback.
>>>
>>> Also, why do you check for pm_runtime_suspended()? =A0Just call it =
for
>>> every time and we get runtime PM use-counting and statistics for fr=
ee
>>> and the ->runtime_suspend() callback will be called when the usecou=
nt
>>> goes to zero.
>>>
>>
>> Yes correct, but I can't balance the put_sync and get_sync
>> as said above. I can call put_sync only once in prepare_idle
>> to cut clocks. But having put_sync outside prepare_idle, if
>> clocks are cut module level wakeup doesn't seem to happen.
>>
>>
>>>> +static void serial_omap_inactivity_timer(unsigned long uart_no)
>>>> +{
>>>> + =A0 =A0 struct uart_omap_port *up =3D ui[uart_no];
>>>> +
>>>> + =A0 =A0 up->can_sleep =3D 1;
>>>> + =A0 =A0 omap_uart_smart_idle(up);
>>>> +}
>>>
>>> This will not be needed if using the autosuspend feature.
>>
>> Using autosuspend, module level wakeup will not happen
>> since autosuspend cuts clocks outside prepare_idle
>> based on autosuspend timeout.
>
> OK, I get the point. =A0You mentioned module level wakeups about 10 t=
imes
> in this message. =A0;)
>
> However, rather than continue to hack around this problem we need to
> understand the root cause. =A0Thanks to Paul, I think I undersand the=
 root
> cause as explained in the other thread, and I think there's a relativ=
ely
> easy way to make them work.
>
> So here's an experiment to try with autosuspend. =A0I suspect this wi=
ll
> work, just hack it up to prove the concept. =A0If it works, we can ma=
ke
> something more generic. =A0Here are a few alternatives to try. =A0I m=
ay
> experiment with some of them tomorrow as well, but please let me know
> what you try:
>
> Using autosuspend, clocks will get cut independently of the idle path=
=2E
> Then, use the PRCM ISR detection of UART module wakeups to call the
> UART's interrupt handler. =A0The interrupt handler will pm_runtime_ge=
t(),
> enable the clocks, and then take care of the interrupt. =A0Done.
>
> Alternatively, you could test it on current code by simply removing t=
he
> resume_from_idle call from the idle path and calling it instead from =
the
> PRCM ISR when UART module wakeups are detected.

I remember doing similar experiment didn't seem to help,

>
> Another option to experiment with: use PRCM ISR to trigger a SW
> interrupt of the UART IRQ (cf. MPU_INTC.INTCPS_ISR_SETn registers.)
> This may be the cleanest approach, and not require calling into the
> driver, but I'm not sure if the normal interrupt clearing process wil=
l
> also clear the SW interrupt.

need to check this.

>
> The best longer-term solution is will be to use the chained PRCM
> interrupt handler[1] (not yet finished.) =A0Using that, drivers could
> directly register for their individual module wakeup interrupts.

Agree.

>
> Kevin
>
> [1] http://marc.info/?l=3Dlinux-omap&m=3D129258489308837&w=3D2
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
