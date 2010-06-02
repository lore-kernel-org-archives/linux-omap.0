From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH] - race-free suspend. Was: Re: [linux-pm] [PATCH 0/8]
	Suspend block api (version 8)
Date: Wed, 2 Jun 2010 02:12:10 -0700
Message-ID: <AANLkTimISbs4X2YR_Pal9A80mpkNyCy8laWBcOgR2Cl7@mail.gmail.com>
References: <Pine.LNX.4.44L0.1005271303190.3239-100000@iolanthe.rowland.org>
	<201006010005.19554.rjw@sisk.pl>
	<20100601090023.788cabf4@notabene.brown>
	<201006010232.20263.rjw@sisk.pl>
	<20100601113309.609349fd@notabene.brown>
	<alpine.LFD.2.00.1006010340160.2933@localhost.localdomain>
	<20100601122012.1edeaf48@notabene.brown>
	<alpine.LFD.2.00.1006011243350.2933@localhost.localdomain>
	<20100602153235.340a7852@notabene.brown>
	<AANLkTikVjAf5nHdMx2bcHRAUSkq99s-b5YZCECXIJJLy@mail.gmail.com>
	<20100602180614.729246ea@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:51507 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754322Ab0FBJML convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Jun 2010 05:12:11 -0400
In-Reply-To: <20100602180614.729246ea@notabene.brown>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Neil Brown <neilb@suse.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@sisk.pl>, Alan Stern <stern@rowland.harvard.edu>, Felipe Balbi <felipe.balbi@nokia.com>, Peter Zijlstra <peterz@infradead.org>, "Paul@smtp1.linux-foundation.org" <Paul@smtp1.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, James Bottomley <James.Bottomley@suse.de>

2010/6/2 Neil Brown <neilb@suse.de>:
> On Wed, 2 Jun 2010 00:05:14 -0700
> Arve Hj=F8nnev=E5g <arve@android.com> wrote:
>
>> On Tue, Jun 1, 2010 at 10:32 PM, Neil Brown <neilb@suse.de> wrote:
>> > On Tue, 1 Jun 2010 12:50:01 +0200 (CEST)
>> > Thomas Gleixner <tglx@linutronix.de> wrote:
>> >
>> >> On Tue, 1 Jun 2010, Neil Brown wrote:
>> >> >
>> >> > I think you have acknowledged that there is a race with suspend=
 - thanks.
>> >> > Next step was "can it be closed".
>> >> > You seem to suggest that it can, but you describe it as a "work=
 around"
>> >> > rather than a "bug fix"...
>> >> >
>> >> > Do you agree that the race is a "bug", and therefore it is appr=
opriate to
>> >> > "fix" it assuming an acceptable fix can be found (which I think=
 it can)?
>> >>
>> >> If we can fix it, yes we definitely should do and not work around=
 it.
>> >>
>> >> Thanks,
>> >>
>> >> =A0 =A0 =A0 tglx
>> >
>> > OK.
>> > Here is my suggestion.
>> >
>> > While I think this patch would actually work, and hope the ugly as=
pects are
>> > reasonably balanced by the simplicity, I present it primarily as a=
 base for
>> > improvement.
>> > The important part is to present how drivers and user-space can co=
-operate
>> > to avoid losing wake-events. =A0The details of what happens in the=
 kernel are
>> > certainly up for discussion (as is everything else really of cours=
e).
>> >
>> > The user-space suspend daemon avoids losing wake-events by using
>> > fcntl(F_OWNER) to ensure it gets a signal whenever any important w=
ake-event
>> > is ready to be read by user-space. =A0This may involve:
>> > =A0- the one daemon processing all wake events
>>
>> Wake up events are not all processed by one daemon.
>
> Not with your current user-space code, no. =A0Are you saying that you=
 are not
> open to any significant change in the Android user-space code? =A0Tha=
t would
> make the situation a lot harder to resolve.
>

Some wakeup events like the an incoming phone may be handled by a
vendor supplied daemon that I do not have the source code for. And, no
I'm not open to a change that would require all wakeup events to go to
a single process.

>>
>> > =A0- Both the suspend daemon and the main event handling daemon op=
ening any
>> > =A0 =A0given device that delivers wake events (this should work wi=
th input
>> > =A0 =A0events ... unless grabbing is needed)
>>
>> Not all wakeup events are broadcast like input events so they cannot
>> be read by both daemons. Not that this really matters, since reading
>> the event from the suspend daemon does not mean that it has been
>> delivered to and processed by the other daemon.
>
> There would still need to be some sort of communication between the t=
he
> suspend daemon on any event daemon to ensure that the events had been
> processed. =A0This could be very light weight interaction. =A0The poi=
nt though is
> that with this patch it becomes possible to avoid races. =A0Possible =
is better
> than impossible.
>

We already have a solution. I don't think rejecting our solution but
merging a worse solution should be the goal.

>>
>> > =A0- The event handling daemon giving the suspend-daemon's pid as =
=46_OWNER, and
>> > =A0 =A0using poll/select to get the events itself.
>>
>> I don't like the idea of using signals for this. Without the hack Al=
an
>> Stern suggested, you will temporarily block suspend if the wakeup
>> event happened before the suspend daemon thread made it to the kerne=
l,
>> but abort suspend if it happened right after.
>
> I'm not sure why that difference matters. =A0But I'm also not sure th=
at it is
> true.
> When any wakeup event happen, a signal will be delivered to the suspe=
nd
> daemon.
> This will interrupt a pending suspend request, or a sleep, or whateve=
r else
> the daemon is doing.
> It can then go back to waiting for a good time to suspend, and then t=
ry to
> suspend again.
>

This is inferior to the solution that is in the android kernel and the
suspend blocker patchset. Both suspend as soon as possible and do not
require signal handlers that modify the argument to your kernel call.

>
>>
>> >
>> > When 'mem' is written to /sys/power/state, suspend_prepare waits i=
n an
>> > interruptible wait until any wake-event that might have been initi=
ated before
>> > the suspend was request, has had a chance to be queued for user-sp=
ace and
>> > trigger kill_fasync.
>>
>> And what happens if you are not waiting when this happens?
>
> I'm not sure I understand the question. =A0Could you explain it pleas=
e?
>

If the thread is not already in the kernel how does your signal
handler abort suspend.

> Either the initial event happens late enough to abort/resume the susp=
end, or
> the signal happens early enough to abort the suspend, or alert the da=
emon not
> to do a suspend. =A0Either way we don't get stuck in suspend.
>
>
>>
>> > Currently this wait is a configurable time after the last wake-eve=
nt was
>> > initiated. =A0This is hackish, but simple and probably adequate.
>>
>> Waiting after a wake event is the same as suspend_block_timeout. Thi=
s
>> is useful when passing events through layers of code that does no
>> block suspend, but we should strive to avoid it. Other people had mu=
ch
>> stronger objections to this, which is why it is not included in the
>> last suspend blocker patchset.
>
> Absolutely agree. =A0The idea of of waiting was just a simple way to =
present
> code that actually could work. =A0There are doubtlessly better ways a=
nd I
> assume they have been implemented in the suspend-blocker code.
> We just need some way to wait for the suspend-block count to reach ze=
ro, with
> some confidence that this amount of time is limited.
>
> (though to be honest ... the incredible simplicity of waiting a littl=
e while
> is very compelling.... :-))
>

Sure, but forcing that as the only way to prevent suspend is taking to =
too far.

>>
>> It also does not work for drivers that need to block suspend for mor=
e
>> than a few seconds. For instance the gpio keypad matrix driver needs
>> to block suspend while keys are pressed so it can scan the keypad.
>
> I cannot imagine why it would take multiple seconds to scan a keypad.
> Can you explain that?
>
> Do you mean while keys are held pressed?

Yes.

> =A0Maybe you don't get a wake-up event
> on key-release?

We should.

> =A0In that case your user-space daemon could block suspend
> while there are any pressed keys.... =A0confused.
>

The user-space daemon should not need to know which keys are in a
matrix. We also have other drivers that need to block suspend. For
instance, some devices need to block suspend while connected to a USB
host.

>
> Thanks for the review,
>
> NeilBrown
>
>



--=20
Arve Hj=F8nnev=E5g
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
