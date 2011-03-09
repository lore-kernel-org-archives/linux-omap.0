From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 5/7] Serial: OMAP: add runtime pm support for omap-serial driver
Date: Tue, 08 Mar 2011 17:48:17 -0800
Message-ID: <87hbbdjc7y.fsf@ti.com>
References: <1298903958-6496-1-git-send-email-govindraj.raja@ti.com>
	<1298903958-6496-6-git-send-email-govindraj.raja@ti.com>
	<87r5am499h.fsf@ti.com>
	<AANLkTim35McK1cFFEXyS49D6b8CT+4pQfmKAswOn3e7_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <AANLkTim35McK1cFFEXyS49D6b8CT+4pQfmKAswOn3e7_@mail.gmail.com>
	(Govindraj's message of "Tue, 8 Mar 2011 19:34:01 +0530")
Sender: linux-serial-owner@vger.kernel.org
To: Govindraj <govindraj.ti@gmail.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@ti.com>
List-Id: linux-omap@vger.kernel.org

Govindraj <govindraj.ti@gmail.com> writes:

[...]

>> This function should not be needed.
>>
>> The timer should be replaced by the auto-suspend feature of runtime =
PM.
>
> If I use autosuspend based on timer runtime framework
> will disable clocks based on autosuspend timeout.
>
> But if I cut clocks outside sram idle path module level wakeup
> will not work.=20
> if I cut func clocks outside prepare for idle
> wake_up is a problem.=20

As I mentioned in the other thread, module wakeups are not the problem,
rather the module generating the interrupt is the problem.  So cutting
clocks outside prepare_for_idle path is not the problem.  It's the
re-enabling of the clocks that is important.

> So I am going with existing model where we are cutting clocks in
> prepare idle and enabling the clock back in resume_idle based on
> wakeup event as any other combination doesn't seem to work.
>
> [As stated in other thread to reproduce the issue
> with module level wakeup]
>
> Even with existing framework if I try to experiment
> by cutting clocks after uart timeout in allow_sleep
> func, module level wakeup doesn't seem to happen.
>>
>> Instead of calling omap_port_disable() callers should call
>> pm_runtime_put_autosuspend(), and the console_stop() should be part =
of
>> the ->runtime_suspend() callback.
>>
>> Also, why do you check for pm_runtime_suspended()? =C2=A0Just call i=
t for
>> every time and we get runtime PM use-counting and statistics for fre=
e
>> and the ->runtime_suspend() callback will be called when the usecoun=
t
>> goes to zero.
>>
>
> Yes correct, but I can't balance the put_sync and get_sync
> as said above. I can call put_sync only once in prepare_idle
> to cut clocks. But having put_sync outside prepare_idle, if
> clocks are cut module level wakeup doesn't seem to happen.
>
>
>>> +static void serial_omap_inactivity_timer(unsigned long uart_no)
>>> +{
>>> + =C2=A0 =C2=A0 struct uart_omap_port *up =3D ui[uart_no];
>>> +
>>> + =C2=A0 =C2=A0 up->can_sleep =3D 1;
>>> + =C2=A0 =C2=A0 omap_uart_smart_idle(up);
>>> +}
>>
>> This will not be needed if using the autosuspend feature.
>
> Using autosuspend, module level wakeup will not happen
> since autosuspend cuts clocks outside prepare_idle
> based on autosuspend timeout.

OK, I get the point.  You mentioned module level wakeups about 10 times
in this message.  ;)

However, rather than continue to hack around this problem we need to
understand the root cause.  Thanks to Paul, I think I undersand the roo=
t
cause as explained in the other thread, and I think there's a relativel=
y
easy way to make them work.

So here's an experiment to try with autosuspend.  I suspect this will
work, just hack it up to prove the concept.  If it works, we can make
something more generic.  Here are a few alternatives to try.  I may
experiment with some of them tomorrow as well, but please let me know
what you try:

Using autosuspend, clocks will get cut independently of the idle path.
Then, use the PRCM ISR detection of UART module wakeups to call the
UART's interrupt handler.  The interrupt handler will pm_runtime_get(),
enable the clocks, and then take care of the interrupt.  Done.

Alternatively, you could test it on current code by simply removing the
resume_from_idle call from the idle path and calling it instead from th=
e
PRCM ISR when UART module wakeups are detected.

Another option to experiment with: use PRCM ISR to trigger a SW
interrupt of the UART IRQ (cf. MPU_INTC.INTCPS_ISR_SETn registers.)
This may be the cleanest approach, and not require calling into the
driver, but I'm not sure if the normal interrupt clearing process will
also clear the SW interrupt.

The best longer-term solution is will be to use the chained PRCM
interrupt handler[1] (not yet finished.)  Using that, drivers could
directly register for their individual module wakeup interrupts.

Kevin

[1] http://marc.info/?l=3Dlinux-omap&m=3D129258489308837&w=3D2

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
