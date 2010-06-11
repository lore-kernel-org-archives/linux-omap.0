From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [linux-pm] suspend blockers & Android integration
Date: Thu, 10 Jun 2010 20:16:46 -0700
Message-ID: <AANLkTik9xMxx8IdYkUhd-oa_ik_MjGFOff_siUztls-9@mail.gmail.com>
References: <AANLkTiniGxuHLeTyxBe7zZxOdYJEkFcl3akR2E_aLDi3@mail.gmail.com>
	<Pine.LNX.4.44L0.1006102126220.2585-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:40373 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753273Ab0FKDQr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Jun 2010 23:16:47 -0400
In-Reply-To: <Pine.LNX.4.44L0.1006102126220.2585-100000@netrider.rowland.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: tytso@mit.edu, Alan Cox <alan@lxorguk.ukuu.org.uk>, Florian Mickler <florian@mickler.org>, Peter Zijlstra <peterz@infradead.org>, Brian Swetland <swetland@google.com>, "H. Peter Anvin" <hpa@zytor.com>, LKML <linux-kernel@vger.kernel.org>, Neil Brown <neilb@suse.de>, James Bottomley <James.Bottomley@suse.de>, Linux PM <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Felipe Balbi <felipe.balbi@nokia.com>, Arjan van de Ven <arjan@infradead.org>

2010/6/10 Alan Stern <stern@rowland.harvard.edu>:
> On Thu, 10 Jun 2010, Arve Hj=F8nnev=E5g wrote:
>
>> >> For that to work the wakeup events would have to be reported to t=
he
>> >> power manager in a reliable way in the first place. Passing the f=
ile
>> >> descriptor that the app uses to the power manager does not work f=
or
>> >> this, since the app could read the event while the power manager =
was
>> >> not in the poll call and the power manager would never see it.
>> >
>> > If the app activates a suspend blocker before reading the event, t=
his
>> > doesn't matter. =A0If the app doesn't activate a suspend blocker t=
hen it
>> > risks being suspended after it has read the event but before it ha=
s
>> > handled the event. =A0This is equally true with wakelocks.
>> >
>>
>> It is not the same. Using a wakelock with a timeout only has a probl=
em
>> if the app did not get a change to run and block suspend before the
>> timeout expires. With the timeout values we use there is only a
>> problem if the system is already unresponsive. If the driver does no=
t
>> block suspend but instead a power manager calls select or poll on a
>> file descriptor while the app does a blocking read, the power manage=
r
>> can easily miss the event and suspend before the app blocks suspend.
>
> You've lost me. =A0If the power manager is sitting inside a select/po=
ll,
> how can it miss the event (given that the event will make data
> available to be read on one of the descriptors being polled)?
>

It cannot sit inside of select/poll all the time.

> Or put it another way: With wakelocks, if the app doesn't use a suspe=
nd
> blocker then once it reads the event data and the timed wakelock is
> deactivated, there is nothing to prevent the system from immediately
> going into opportunistic suspend. =A0My scheme can fail in the same w=
ay.
> Is that what you meant?
>

No, if an app reads from a file descriptor and block suspend when the
read call returns, then suspend is blocked while processing the data.
If the driver uses a wakelock with a timeout this will fail if the
thread does not get to the suspend block call before the timeout
expires, but unrelated events that don't prevent the app from running
will not cause any problems. In your scheme the user-space power
manager may miss events on this file descriptor since select/poll will
not see an event if the app read that event right before the power
manager called select/poll.

>> >> The suspend blocker approach is more generally useful since it
>> >> supports hardware where suspend is needed. Why this argument is b=
eing
>> >> ignored is very puzzling.
>> >
>> > Probably because people doesn't envision system suspend being used=
 for
>> > dynamic power management on that kind of hardware.
>> >
>>
>> I'm not sure what you mean by dynamic power management here (frequen=
cy
>> of suspends?), but auto suspend is already in use on x86 desktops an=
d
>> laptops. Suspend blockers can fix the race with some wakeup events
>> there.
>
> You should stress this point more strongly when conversing with other=
s.
> I doubt it will be enough to change anybody's mind, but it can't hurt=
=2E
> Indeed, if you propose suspend blockers as a way to fix a lost-wakeup
> bug in existing distributions, rather than as something needed to
> support Android, people might view it more favorably.
>
>
> There's one question that I don't remember ever seeing answered. =A0T=
o
> which kernel drivers do you intend to add suspend blockers?
>

All drivers that generate wakeup events need to either use suspend
blockers directly or call into something else that does. For instance,
with the patch to block suspend while input events are queued to
user-space, an input driver that fully handles its events in its
interrupt handler does not need any additional suspend blockers, but
if the driver needs a work function or a timer to run before it
reports the event it needs to block suspend until it has reported the
event.

--=20
Arve Hj=F8nnev=E5g
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
