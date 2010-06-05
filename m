From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: suspend blockers & Android integration
Date: Sat, 5 Jun 2010 16:21:06 -0700
Message-ID: <AANLkTikmWDHYJ8wWF2cZapbkHHjV09R39I37yvQXFmor@mail.gmail.com>
References: <20100603193045.GA7188@elte.hu>
	<20100603232302.GA16184@elte.hu>
	<1275644619.27810.39462.camel@twins>
	<201006050138.30859.rjw@sisk.pl>
	<alpine.LFD.2.00.1006050148080.2933@localhost.localdomain>
	<AANLkTikGDSzaENwg_0BAtsYf3ulGd_6sGPR30WsvUxMi@mail.gmail.com>
	<alpine.LFD.2.00.1006050246350.2933@localhost.localdomain>
	<AANLkTikU21xF49Z-_Lnrq7U7buNmqw_gyEEST8LuN24z@mail.gmail.com>
	<alpine.LFD.2.00.1006051736040.2933@localhost.localdomain>
	<AANLkTinD39rI47innPbGz1Gi8PsXV5HqkmaQuJ70oQ63@mail.gmail.com>
	<alpine.LFD.2.00.1006052348200.2933@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f185.google.com ([209.85.222.185]:55522 "EHLO
	mail-pz0-f185.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933600Ab0FEXVI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 5 Jun 2010 19:21:08 -0400
In-Reply-To: <alpine.LFD.2.00.1006052348200.2933@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>, tytso@mit.edu, Brian Swetland <swetland@google.com>, Neil Brown <neilb@suse.de>, Alan Stern <stern@rowland.harvard.edu>, Felipe Balbi <felipe.balbi@nokia.com>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, James Bottomley <James.Bottomley@suse.de>, Linus Torvalds <torvalds@linux-foundation.org>, Kevin Hilman <khilman@deeprootsystems.com>, "H. Peter Anvin" <hpa@zytor.com>, Arjan van de Ven <arjan@infradead.org>

2010/6/5 Thomas Gleixner <tglx@linutronix.de>:
> On Sat, 5 Jun 2010, Arve Hj=F8nnev=E5g wrote:
>> 2010/6/5 Thomas Gleixner <tglx@linutronix.de>:
>> > B1;2005;0cOn Fri, 4 Jun 2010, Arve Hj=F8nnev=E5g wrote:
>> >> > Why is it a BUG in the trusted app, when I initiate a download =
and put
>> >> > the phone down ?
>> >> >
>> >>
>> >> It is not, but we have had bugs where a trusted app does not unbl=
ock
>> >> suspend after some failure case where it is no longer making any
>> >> progress.
>> >
>> > Well, that's simply an application bug which sucks battery with or
>> > without suspend blockers. So it's unrelated to the freezing of
>> > untrusted apps while a trusted app still works in the background
>> > before allowing the machine to suspend.
>> >
>>
>> It is not unrelated if the trusted app has stopped working but still
>> blocks suspend. The battery drains when you combine them.
>
> What you are describing is a problem which is not solvable either way=
=2E
> If you take the lock and do not release it you're not going to
> suspend. I never claimed that any other mechanism resolves this.
>
Whether you claimed it or not, this is the only case where using
cgroups would have a significant power saving over what we get with
suspend. The trusted app is idle and the untrusted app is frozen, so
we enter a low power mode from idle.

> But this is not related to the fact that freezing crap while running =
a
> sane background task is going to save you power vs. an approach where
> running a sane background task allows crap to consume power unconfine=
d
> until it is done.
>
If the task that is blocking suspend is using the cpu anyway, then the
bad app does not increase the power consumption nearly as much as if
the task that blocked suspend is idle.

>> >> > That download might take a minute or two, but that's not an
>> >> > justification for the crapplication to run unconfined and preve=
nt
>> >> > lower power states.
>> >> >
>> >>
>> >> I agree, but this is not a simple problem to solve.
>> >
>> > Not with suspend blockers, but with cgroup confinement of crap, it=
's
>> > straight forward.
>> >
>>
>> I don't think is is straight forward. If the a process in the frozen
>> group holds a resource that a process in the unfrozen group needs, h=
ow
>> do deal with that?
>
> I'm going to fix the framework which puts the group into freeze state
> w/o making sure that there is no held shared resource. Come on it's
> not rocket science.
>

I'm not sure which framework you are talking about here, but I don't
think there is a single framework that knows about all shared
resources.

>> >> Yes I don't know everything our user-space stack is doing, but I =
do
>> >> know that it makes many calls between processes (and in both
>> >> directions). As far as I know it uses timeouts when calling into
>> >> untrusted code, so a misbehaving application will cause an error
>> >> dialog to pop up asking if the user if it should wait longer or
>> >> terminate the application.
>> >
>> > Sigh, the more I learn about the details of android and it's viola=
tion
>> > of all sane engineering principles the more I understand why you
>> > invented a huge nail to push through all layers in order to bring =
the
>> > system into idle at all. And yes, you need a sledge hammer to driv=
e
>> > that big nail through everything, so you are using the right tool.
>> >
>> > Seriously, the cross app call goes through your framework, which
>> > already knows, that the untrusted part is frozen. So it can deal
>> > nicely with it in any way you want including unfreezing.
>>
>> Cross app calls do not go through a central process.
>
> It's not about a central process, it goes through your framework,
> which should be able to deal with it. If not, it's a design failure
> which needs to be fixed at the place where the failure happened.
>
>> >>
>> >> How can it be fixed? The user presses the back button, the framew=
ork
>> >> determines that app A is in the foreground and send the key to ap=
p A,
>> >> app A decides that it it does not have anything internal to go ba=
ck to
>> >> and tells the framework to switch back to the previous app. If th=
e
>> >> user presses the back key again, the framework does not know whic=
h app
>> >> this key should go to until app A has finished processing the fir=
st
>> >> key press.
>> >
>> > Errm, what has this to do with frozen apps? If your system is
>> > handling input events then there are no frozen apps and even if th=
ey
>> > are frozen your framework can unfreeze them _before_ talking to th=
em.
>> >
>> > So which unfixable problem are you describing with the above examp=
le ?
>> >
>>
>> You are claiming that trusted code should not have any dependencies =
on
>> untrusted code. I gave you a visible example of such a dependency an=
d
>> want you to tell me how you can avoid this dependency. Since you are
>> claiming that our user-space framework is fundamentally broken if it
>> has to wait for untrusted code, I don't think it is unreasonable for
>> you to answer this. Or do you think it is valid to communicate with
>> untrusted code when the screen is on but not when it is off.
>
> It does not matter whether the screen is off or not. If you need to
> call into that untrusted app from your trusted app and you know about
> the might be frozen state then you can deal with it.
>
> So taking your example:
>
> Event happens and gets delivered to the framework
>
> =A0 =A0 =A0framework selects A because it is in the foreground
>
> =A0 =A0 =A0if (A is frozen)
> =A0 =A0 =A0 =A0 unfreeze(A)
>
> =A0 =A0 =A0deliver_event_to(A)
>
> It's that simple.
>

That is too simple. You also have to prevent A from being frozen while
it is processing the event or the result would be the same as if it
was frozen beforehand.

> If your framework cannot deal with that simple problem then you have =
a
> much more serious problem already.
>
> Thanks,
>
> =A0 =A0 =A0 =A0tglx
>



--=20
Arve Hj=F8nnev=E5g
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
