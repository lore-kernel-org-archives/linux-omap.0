From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: suspend blockers & Android integration
Date: Fri, 4 Jun 2010 00:37:48 -0700
Message-ID: <AANLkTimH4ihf3QqtKFpfGXRKtO55PrUuff9JYtaEBG44@mail.gmail.com>
References: <20100603193045.GA7188@elte.hu>
	<20100603231153.GA11302@elte.hu>
	<20100603232302.GA16184@elte.hu>
	<AANLkTikZP3bmckpfb_jUdG7qZO5W9DgpZ79ugtSZaEpt@mail.gmail.com>
	<20100604071354.GA14451@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100604071354.GA14451@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: tytso@mit.edu, Brian Swetland <swetland@google.com>, Neil Brown <neilb@suse.de>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@sisk.pl>, Alan Stern <stern@rowland.harvard.edu>, Felipe Balbi <felipe.balbi@nokia.com>, Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, James Bottomley <James.Bottomley@suse.de>, Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Kevin Hilman <khilman@deeprootsystems.com>, "H. Peter Anvin" <hpa@zytor.com>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Jun 4, 2010 at 12:13 AM, Ingo Molnar <mingo@elte.hu> wrote:
>
> * Arve Hj?nnev?g <arve@android.com> wrote:
>
>> On Thu, Jun 3, 2010 at 4:23 PM, Ingo Molnar <mingo@elte.hu> wrote:
>> ...
>> > ?- Controlled auto-suspend: drivers (such as input) could on wakeu=
p
>> > ? automatically set the 'minimum wakeup latency' value of wakee ta=
sks to a
>> > ? lower value. This automatically prevents another auto-suspend in=
 the near
>> > ? future: up to the point the wakee task increases its latency (vi=
a the
>> > ? scheduler syscall) again and allows suspend again.
>> >
>>
>> How do you clear the latency value in a safe way? If another wakeup =
event
>> happens right after your wakee task is done processing the last even=
t and
>> decides to increase its latency, auto suspend will be allowed even t=
hough
>> you have an unprocessed wakeup event. Also how do you know which tas=
k will
>> read the event if it is not already waiting for it?
>
> The easiest solution would be to not do any of that initially. (If it=
's ever a
> concern we could subtract/add without destroying the nesting property=
)
>
> Why do you need to track input wakeups? It's rather fragile and rathe=
r

Because we have keys that should always turn the screen on, but the
problem is not specific to input events. If we enabled a wakeup event
it usually means we need this event to always work, not just when the
system is fully awake or fully suspended.

> unnecessary - the idle drivers know it very well how to not go into t=
he
> deepest idle mode already today. We wont hit C8 on laptops when you a=
re using
> the desktop.
>

The whole point allow the use of suspend.

>> > ? This means there will be no surprise suspends for a task that ma=
y take a
>> > ? bit longer than usual to finish its work. [ Detail: this would o=
nly be done
>> > ? for tasks that have a non-default (non-infinity) task->latency v=
alue - to
>> > ? prevent the input driver from lowering latency values (and preve=
nting
>> > ? future suspends) just because some unaware apps are running and =
using input
>> > ? drivers. ]
>>
>> Don't you need two inifinity values for this?
>
> Yes - any value above the max idle latency in the system will do.
>
> Thanks,
>
> =A0 =A0 =A0 =A0Ingo
>



--=20
Arve Hj=F8nnev=E5g
