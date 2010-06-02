From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH] - race-free suspend. Was: Re: [linux-pm] [PATCH 0/8]
	Suspend block api (version 8)
Date: Wed, 2 Jun 2010 00:05:14 -0700
Message-ID: <AANLkTikVjAf5nHdMx2bcHRAUSkq99s-b5YZCECXIJJLy@mail.gmail.com>
References: <Pine.LNX.4.44L0.1005271303190.3239-100000@iolanthe.rowland.org>
	<201006010005.19554.rjw@sisk.pl>
	<20100601090023.788cabf4@notabene.brown>
	<201006010232.20263.rjw@sisk.pl>
	<20100601113309.609349fd@notabene.brown>
	<alpine.LFD.2.00.1006010340160.2933@localhost.localdomain>
	<20100601122012.1edeaf48@notabene.brown>
	<alpine.LFD.2.00.1006011243350.2933@localhost.localdomain>
	<20100602153235.340a7852@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:61361 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756172Ab0FBHFQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Jun 2010 03:05:16 -0400
In-Reply-To: <20100602153235.340a7852@notabene.brown>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Neil Brown <neilb@suse.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@sisk.pl>, Alan Stern <stern@rowland.harvard.edu>, Felipe Balbi <felipe.balbi@nokia.com>, Peter Zijlstra <peterz@infradead.org>, "Paul@smtp1.linux-foundation.org" <Paul@smtp1.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, James Bottomley <James.Bottomley@suse.de>

On Tue, Jun 1, 2010 at 10:32 PM, Neil Brown <neilb@suse.de> wrote:
> On Tue, 1 Jun 2010 12:50:01 +0200 (CEST)
> Thomas Gleixner <tglx@linutronix.de> wrote:
>
>> On Tue, 1 Jun 2010, Neil Brown wrote:
>> >
>> > I think you have acknowledged that there is a race with suspend - =
thanks.
>> > Next step was "can it be closed".
>> > You seem to suggest that it can, but you describe it as a "work ar=
ound"
>> > rather than a "bug fix"...
>> >
>> > Do you agree that the race is a "bug", and therefore it is appropr=
iate to
>> > "fix" it assuming an acceptable fix can be found (which I think it=
 can)?
>>
>> If we can fix it, yes we definitely should do and not work around it=
=2E
>>
>> Thanks,
>>
>> =A0 =A0 =A0 tglx
>
> OK.
> Here is my suggestion.
>
> While I think this patch would actually work, and hope the ugly aspec=
ts are
> reasonably balanced by the simplicity, I present it primarily as a ba=
se for
> improvement.
> The important part is to present how drivers and user-space can co-op=
erate
> to avoid losing wake-events. =A0The details of what happens in the ke=
rnel are
> certainly up for discussion (as is everything else really of course).
>
> The user-space suspend daemon avoids losing wake-events by using
> fcntl(F_OWNER) to ensure it gets a signal whenever any important wake=
-event
> is ready to be read by user-space. =A0This may involve:
> =A0- the one daemon processing all wake events

Wake up events are not all processed by one daemon.

> =A0- Both the suspend daemon and the main event handling daemon openi=
ng any
> =A0 =A0given device that delivers wake events (this should work with =
input
> =A0 =A0events ... unless grabbing is needed)

Not all wakeup events are broadcast like input events so they cannot
be read by both daemons. Not that this really matters, since reading
the event from the suspend daemon does not mean that it has been
delivered to and processed by the other daemon.

> =A0- The event handling daemon giving the suspend-daemon's pid as F_O=
WNER, and
> =A0 =A0using poll/select to get the events itself.

I don't like the idea of using signals for this. Without the hack Alan
Stern suggested, you will temporarily block suspend if the wakeup
event happened before the suspend daemon thread made it to the kernel,
but abort suspend if it happened right after.

>
> When 'mem' is written to /sys/power/state, suspend_prepare waits in a=
n
> interruptible wait until any wake-event that might have been initiate=
d before
> the suspend was request, has had a chance to be queued for user-space=
 and
> trigger kill_fasync.

And what happens if you are not waiting when this happens?

> Currently this wait is a configurable time after the last wake-event =
was
> initiated. =A0This is hackish, but simple and probably adequate.

Waiting after a wake event is the same as suspend_block_timeout. This
is useful when passing events through layers of code that does no
block suspend, but we should strive to avoid it. Other people had much
stronger objections to this, which is why it is not included in the
last suspend blocker patchset.

It also does not work for drivers that need to block suspend for more
than a few seconds. For instance the gpio keypad matrix driver needs
to block suspend while keys are pressed so it can scan the keypad.

> If more precise timing is needed and achievable, that can be added la=
ter. =A0It
> would be an entirely internal change and would not affect the API fur=
ther.
> Some of the code developed for suspend-blockers might be a starting p=
oint for
> this.
>
> Drivers should call pm_suspend_delay() whenever a wake-event occurs. =
=A0This
> simply records the time so that the suspend process knows if there is=
 in fact
> any need to wait at all.
>
> The delay to wait after the last pm_suspend_delay() is limited to 10 =
seconds
> and can be set by kernel parameter suspend_block_delay=3Dnumber-of-mi=
lliseconds
> It defaults to 2 jiffies (which is possibly too short).
>
> - Would this fix the "bug"??
> - and address the issues that suspend-blockers was created to address=
?
> - or are the requirements on user-space too onerous?
>
>
> Thanks,
> NeilBrown
>
> Signed-off-by: NeilBrown <neilb@suse.de>
>
> diff --git a/include/linux/suspend.h b/include/linux/suspend.h
> index 5e781d8..ccbadd0 100644
> --- a/include/linux/suspend.h
> +++ b/include/linux/suspend.h
> @@ -142,11 +142,13 @@ extern void arch_suspend_disable_irqs(void);
> =A0extern void arch_suspend_enable_irqs(void);
>
> =A0extern int pm_suspend(suspend_state_t state);
> +extern void pm_suspend_delay(void);
> =A0#else /* !CONFIG_SUSPEND */
> =A0#define suspend_valid_only_mem NULL
>
> =A0static inline void suspend_set_ops(struct platform_suspend_ops *op=
s) {}
> =A0static inline int pm_suspend(suspend_state_t state) { return -ENOS=
YS; }
> +static inlint void pm_suspend_delay(void) {}
> =A0#endif /* !CONFIG_SUSPEND */
>
> =A0/* struct pbe is used for creating lists of pages that should be r=
estored
> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> index 56e7dbb..07897b9 100644
> --- a/kernel/power/suspend.c
> +++ b/kernel/power/suspend.c
> @@ -46,6 +46,69 @@ bool valid_state(suspend_state_t state)
> =A0 =A0 =A0 =A0return suspend_ops && suspend_ops->valid && suspend_op=
s->valid(state);
> =A0}
>
> +/*
> + * Devices that process potential wake-up events report each
> + * wake-up events by pm_suspend_delay();
> + * This ensures that suspend won't happen for a "little while"
> + * so the event has a chance to get to user-space.
> + * pm_suspend calls wait_for_blockers to wait the required
> + * "little while" and to check for signals.
> + * A process that requests a suspend should arrange (via
> + * fcntl(F_GETOWN)) to get signalled whenever a wake-up event
> + * is queued for user-space. =A0This will ensure that if a suspend
> + * is requested at much the same time as a wakeup event arrives, eit=
her
> + * the suspend will be interrupted, or it will complete quickly.
> + *
> + * The "little while" is a heuristic to avoid having to explicitly
> + * track every event through the kernel with associated locking and =
unlocking.
> + * It should be more than the longest time it can take between an in=
terrupt
> + * occurring and the corresponding event being queued to userspace
> + * (and the accompanying kill_fasync call).
> + * This duration is configurable at boot time, has a lower limit of =
2
> + * jiffies and an upper limit of 10 seconds. =A0It defaults to the m=
inimum.
> + */
> +static unsigned long little_while_jiffies =3D 2;
> +static int __init setup_suspend_block_delay(char *str)
> +{
> + =A0 =A0 =A0 unsigned long msec;
> + =A0 =A0 =A0 if (sscanf(str, "%lu", &msec) !=3D 1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;
> + =A0 =A0 =A0 if (msec > 10000)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 msec =3D 10000;
> + =A0 =A0 =A0 little_while_jiffies =3D msecs_to_jiffies(msec);
> + =A0 =A0 =A0 if (little_while_jiffies < 2)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 little_while_jiffies =3D 2;
> + =A0 =A0 =A0 return 1;
> +}
> +__setup("suspend_block_delay=3D", setup_suspend_block_delay);
> +
> +static unsigned long next_little_while;
> +void pm_suspend_delay()
> +{
> + =A0 =A0 =A0 unsigned long then =3D jiffies + little_while_jiffies;
> +
> + =A0 =A0 =A0 if (then !=3D next_little_while)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 next_little_while =3D then;
> +}
> +EXPORT_SYMBOL_GPL(pm_suspend_delay);
> +
> +static int wait_for_blockers(void)
> +{
> + =A0 =A0 =A0 unsigned long timeout;
> +
> + =A0 =A0 =A0 if (time_after(jiffies, next_little_while))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 timeout =3D next_little_while - jiffies;
> + =A0 =A0 =A0 if (timeout > msecs_to_jiffies(10000))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* jiffy wrap */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> + =A0 =A0 =A0 while (timeout && !signal_pending(current))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 timeout =3D schedule_timeout_interrupti=
ble(timeout);
> + =A0 =A0 =A0 if (signal_pending(current))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINTR;
> + =A0 =A0 =A0 return 0;
> +}
> =A0/**
> =A0* suspend_valid_only_mem - generic memory-only valid callback
> =A0*
> @@ -89,6 +152,10 @@ static int suspend_prepare(void)
> =A0 =A0 =A0 =A0if (error)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto Finish;
>
> + =A0 =A0 =A0 error =3D wait_for_blockers();
> + =A0 =A0 =A0 if (error)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto Finish;
> +
> =A0 =A0 =A0 =A0error =3D usermodehelper_disable();
> =A0 =A0 =A0 =A0if (error)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto Finish;
>
>



--=20
Arve Hj=F8nnev=E5g
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
