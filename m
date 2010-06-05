From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: suspend blockers & Android integration
Date: Fri, 4 Jun 2010 17:39:17 -0700
Message-ID: <AANLkTikGDSzaENwg_0BAtsYf3ulGd_6sGPR30WsvUxMi@mail.gmail.com>
References: <20100603193045.GA7188@elte.hu>
	<20100603232302.GA16184@elte.hu>
	<1275644619.27810.39462.camel@twins>
	<201006050138.30859.rjw@sisk.pl>
	<alpine.LFD.2.00.1006050148080.2933@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.00.1006050148080.2933@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>, tytso@mit.edu, Brian Swetland <swetland@google.com>, Neil Brown <neilb@suse.de>, Alan Stern <stern@rowland.harvard.edu>, Felipe Balbi <felipe.balbi@nokia.com>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, James Bottomley <James.Bottomley@suse.de>, Linus Torvalds <torvalds@linux-foundation.org>, Kevin Hilman <khilman@deeprootsystems.com>, "H. Peter Anvin" <hpa@zytor.com>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Jun 4, 2010 at 5:05 PM, Thomas Gleixner <tglx@linutronix.de> wr=
ote:
> On Sat, 5 Jun 2010, Rafael J. Wysocki wrote:
>> I kind of agree here, so I'd like to focus a bit on that.
>>
>> Here's my idea in the very general terms:
>>
>> (1) Use the cgroup freezer to "suspend" the "untrusted" apps (ie. th=
e ones
>> =A0 =A0 that don't use suspend blockers aka wakelocks in the Android=
 world) at the
>> =A0 =A0 point Android would normally start opportunistic suspend.
>
> There is an additional benefit to this approach:
>
> =A0 =A0 In the current android world a background task (e.g. download
> =A0 =A0 initiated before the screensaver kicked in) prevents the susp=
end,
> =A0 =A0 but that also means that the crapplications can still suck po=
wer
> =A0 =A0 completely unconfined.
>

Yes this can happen. It is usually only a big problem when you combine
an (trusted) application that has a bug that blocks suspend forever
with an application that wakes up too often for us to enter low power
idle modes.

> =A0 =A0 With the cgroup freezer you can "suspend" them right away and
> =A0 =A0 just keep the trusted background task(s) alive which allows u=
s to
> =A0 =A0 go into deeper idle states instead of letting the crapplicati=
ons
> =A0 =A0 run unconfined until the download finished and the suspend
> =A0 =A0 blocker goes away.
>

Yes this would be better, but I want it in addition to suspend, not
instead of it. It is also unclear if our user-space code could easily
make use of it since our trusted code calls into untrusted code.

>> (2) Allow the cpuidle framework to put CPUs into low-power states af=
ter the
>> =A0 =A0 "trusted" apps (ie. the ones that use suspend blockers in th=
e Android
>> =A0 =A0 world) have gone idle.
>>

As far as I know this is what we already have on hardware that supports=
 it.

>> (3) Teach the cpuidle framework to schedule runtime suspend of I/O d=
evices
>> =A0 =A0 before idling the last CPU (*).
>>

I don't think we need this for android phones. We already put I/O
devices in low power modes when they are not in use.

>> (4) Design a mechanism to resume the I/O devices suspended in (3) so=
 that
>> =A0 =A0 they are not powered up unnecessarily (that's going to be di=
fficult as far
>> =A0 =A0 as I can see).
>>
>> This way, in principle, we should be able to save (at least almost) =
as much
>> energy as the opportunistic suspend currently used by Android, provi=
ded that
>> things will be capable of staying idle for extended periods of time.

The main reason we use suspend is that the system does not stay idle
for extened periods of time. If this gets fixed, and our if user-space
framework can deal with a subset of processes being frozen (this is a
big if) this solution may work, but it does not help us today.

>>
>> (*) That may require per-device PM QoS requirements to be used, in w=
hich case
>> =A0 =A0 devices may even be suspended earlier if the PM QoS requirem=
ents of all
>> =A0 =A0 of their users are met.
>>
>> I wonder what people think. =A0Is this realistic and if so, would it=
 be difficult
>> to implement?
>
> I think it's realistic and not overly complicated to implement.
>

The kernel support can be easily implemented on most arm hardware, I
don't know if it can work on most existing x86 hardware. It does not
give us the same power savings as suspend with existing software, but
it can handle bad apps better (assuming you don't combine
opportunistic suspend and cgroup freezing). The biggest hurdle is how
to handle dependencies between processes that gets frozen and
processes that don't get frozen.

--=20
Arve Hj=F8nnev=E5g
