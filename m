From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: suspend blockers & Android integration
Date: Sat, 5 Jun 2010 14:47:26 -0700
Message-ID: <AANLkTinD39rI47innPbGz1Gi8PsXV5HqkmaQuJ70oQ63@mail.gmail.com>
References: <20100603193045.GA7188@elte.hu>
	<20100603232302.GA16184@elte.hu>
	<1275644619.27810.39462.camel@twins>
	<201006050138.30859.rjw@sisk.pl>
	<alpine.LFD.2.00.1006050148080.2933@localhost.localdomain>
	<AANLkTikGDSzaENwg_0BAtsYf3ulGd_6sGPR30WsvUxMi@mail.gmail.com>
	<alpine.LFD.2.00.1006050246350.2933@localhost.localdomain>
	<AANLkTikU21xF49Z-_Lnrq7U7buNmqw_gyEEST8LuN24z@mail.gmail.com>
	<alpine.LFD.2.00.1006051736040.2933@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:59453 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933039Ab0FEVr1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 5 Jun 2010 17:47:27 -0400
In-Reply-To: <alpine.LFD.2.00.1006051736040.2933@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>, tytso@mit.edu, Brian Swetland <swetland@google.com>, Neil Brown <neilb@suse.de>, Alan Stern <stern@rowland.harvard.edu>, Felipe Balbi <felipe.balbi@nokia.com>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, James Bottomley <James.Bottomley@suse.de>, Linus Torvalds <torvalds@linux-foundation.org>, Kevin Hilman <khilman@deeprootsystems.com>, "H. Peter Anvin" <hpa@zytor.com>, Arjan van de Ven <arjan@infradead.org>

2010/6/5 Thomas Gleixner <tglx@linutronix.de>:
> B1;2005;0cOn Fri, 4 Jun 2010, Arve Hj=F8nnev=E5g wrote:
>
>> 2010/6/4 Thomas Gleixner <tglx@linutronix.de>:
>> > Arve,
>> >
>> > On Fri, 4 Jun 2010, Arve Hj=F8nnev=E5g wrote:
>> >
>> >> On Fri, Jun 4, 2010 at 5:05 PM, Thomas Gleixner <tglx@linutronix.=
de> wrote:
>> >> > On Sat, 5 Jun 2010, Rafael J. Wysocki wrote:
>> >> >> I kind of agree here, so I'd like to focus a bit on that.
>> >> >>
>> >> >> Here's my idea in the very general terms:
>> >> >>
>> >> >> (1) Use the cgroup freezer to "suspend" the "untrusted" apps (=
ie. the ones
>> >> >> =A0 =A0 that don't use suspend blockers aka wakelocks in the A=
ndroid world) at the
>> >> >> =A0 =A0 point Android would normally start opportunistic suspe=
nd.
>> >> >
>> >> > There is an additional benefit to this approach:
>> >> >
>> >> > =A0 =A0 In the current android world a background task (e.g. do=
wnload
>> >> > =A0 =A0 initiated before the screensaver kicked in) prevents th=
e suspend,
>> >> > =A0 =A0 but that also means that the crapplications can still s=
uck power
>> >> > =A0 =A0 completely unconfined.
>> >> >
>> >>
>> >> Yes this can happen. It is usually only a big problem when you co=
mbine
>> >> an (trusted) application that has a bug that blocks suspend forev=
er
>> >> with an application that wakes up too often for us to enter low p=
ower
>> >> idle modes.
>> >
>> > Why is it a BUG in the trusted app, when I initiate a download and=
 put
>> > the phone down ?
>> >
>>
>> It is not, but we have had bugs where a trusted app does not unblock
>> suspend after some failure case where it is no longer making any
>> progress.
>
> Well, that's simply an application bug which sucks battery with or
> without suspend blockers. So it's unrelated to the freezing of
> untrusted apps while a trusted app still works in the background
> before allowing the machine to suspend.
>

It is not unrelated if the trusted app has stopped working but still
blocks suspend. The battery drains when you combine them.

>> > That download might take a minute or two, but that's not an
>> > justification for the crapplication to run unconfined and prevent
>> > lower power states.
>> >
>>
>> I agree, but this is not a simple problem to solve.
>
> Not with suspend blockers, but with cgroup confinement of crap, it's
> straight forward.
>

I don't think is is straight forward. If the a process in the frozen
group holds a resource that a process in the unfrozen group needs, how
do deal with that?

>> >> > =A0 =A0 With the cgroup freezer you can "suspend" them right aw=
ay and
>> >> > =A0 =A0 just keep the trusted background task(s) alive which al=
lows us to
>> >> > =A0 =A0 go into deeper idle states instead of letting the crapp=
lications
>> >> > =A0 =A0 run unconfined until the download finished and the susp=
end
>> >> > =A0 =A0 blocker goes away.
>> >> >
>> >>
>> >> Yes this would be better, but I want it in addition to suspend, n=
ot
>> >> instead of it. It is also unclear if our user-space code could ea=
sily
>> >> make use of it since our trusted code calls into untrusted code.
>> >
>> > Sorry, that's really the worst argument I saw in this whole
>> > discussion.
>> >
>> > You're basically saying, that you have no idea what your user spac=
e
>> > stack is doing and you do not care at all as long as your suspend
>> > blocker scheme makes things work somehow.
>> >
>>
>> Yes I don't know everything our user-space stack is doing, but I do
>> know that it makes many calls between processes (and in both
>> directions). As far as I know it uses timeouts when calling into
>> untrusted code, so a misbehaving application will cause an error
>> dialog to pop up asking if the user if it should wait longer or
>> terminate the application.
>
> Sigh, the more I learn about the details of android and it's violatio=
n
> of all sane engineering principles the more I understand why you
> invented a huge nail to push through all layers in order to bring the
> system into idle at all. And yes, you need a sledge hammer to drive
> that big nail through everything, so you are using the right tool.
>
> Seriously, the cross app call goes through your framework, which
> already knows, that the untrusted part is frozen. So it can deal
> nicely with it in any way you want including unfreezing.

Cross app calls do not go through a central process.

>
>> > Up to that point, I really tried hard to step back from my initial
>> > "OMG, promoting crap is a nono" reaction and work with you on a
>> > sensible technical solution to confine crap and make it aligned wi=
th
>> > other efforts in this area.
>> >
>> > So now, after I spent a reasonable amount of time (as you did) to
>> > understand what your requirements are, you come up with another
>> > restriction which is so outside of any level of sanity, that I'm a=
t
>> > the point of giving up and just going into NAK mode.
>> >
>>
>> I don't think this is a new restriction. Both Brian and I have
>> mentioned that we have a lot of dependencies between processes.
>>
>> > Can you please answer the following question:
>> >
>> > =A0 =A0What is the point of having the distinction of "trusted" an=
d
>> > =A0 =A0"untrusted" when you have no way to prevent "trusted" code =
calling
>> > =A0 =A0"into "untrusted" code ?
>> >
>>
>> Trusted code that calls into untrusted code has to deal with the
>> untrusted code not responding, but we only want to pop up a message
>> that the application is not responding if it is misbehaving, not jus=
t
>> because it was frozen though no fault of its own.
>
> See above.
>
>> > That's violating any sense of abstraction and layering and makes i=
t
>> > entirely clear that the only way you can deal with your own design
>> > failure is a big hammer which you need to force into the kernel.
>> >
>>
>> How can it be fixed? The user presses the back button, the framework
>> determines that app A is in the foreground and send the key to app A=
,
>> app A decides that it it does not have anything internal to go back =
to
>> and tells the framework to switch back to the previous app. If the
>> user presses the back key again, the framework does not know which a=
pp
>> this key should go to until app A has finished processing the first
>> key press.
>
> Errm, what has this to do with frozen apps? If your system is
> handling input events then there are no frozen apps and even if they
> are frozen your framework can unfreeze them _before_ talking to them.
>
> So which unfixable problem are you describing with the above example =
?
>

You are claiming that trusted code should not have any dependencies on
untrusted code. I gave you a visible example of such a dependency and
want you to tell me how you can avoid this dependency. Since you are
claiming that our user-space framework is fundamentally broken if it
has to wait for untrusted code, I don't think it is unreasonable for
you to answer this. Or do you think it is valid to communicate with
untrusted code when the screen is on but not when it is off.

--=20
Arve Hj=F8nnev=E5g
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
