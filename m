From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [linux-pm] suspend blockers & Android integration
Date: Thu, 10 Jun 2010 16:02:34 -0700
Message-ID: <AANLkTiniGxuHLeTyxBe7zZxOdYJEkFcl3akR2E_aLDi3@mail.gmail.com>
References: <AANLkTil2JhBgJ27qcTARVj2wVgEltxZKPOc9Ddu4c8yY@mail.gmail.com>
	<Pine.LNX.4.44L0.1006101003480.1702-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.1006101003480.1702-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: tytso@mit.edu, Alan Cox <alan@lxorguk.ukuu.org.uk>, Florian Mickler <florian@mickler.org>, Peter Zijlstra <peterz@infradead.org>, Brian Swetland <swetland@google.com>, "H. Peter Anvin" <hpa@zytor.com>, LKML <linux-kernel@vger.kernel.org>, Neil Brown <neilb@suse.de>, James Bottomley <James.Bottomley@suse.de>, Linux PM <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Felipe Balbi <felipe.balbi@nokia.com>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-omap@vger.kernel.org

2010/6/10 Alan Stern <stern@rowland.harvard.edu>:
> On Wed, 9 Jun 2010, Arve Hj=F8nnev=E5g wrote:
>
>> > I think this is where you misunderstood. =A0There is no "report wa=
keup
>> > event" as such. =A0All that happens is that data becomes available=
 to be
>> > read from the input device file. =A0However the power manager proc=
ess
>> > isn't polling the device file at this point (because a suspend blo=
cker
>> > is active), so it doesn't realize that the source has become activ=
e
>> > again.
>> >
>>
>> Yes this is not what I though you were suggesting. I thought you wer=
e
>> trying to make sure the power manager sees all wakeup events. If you
>> are only listening for wakeup events while no suspend blockers are
>> active, why latch them?
>
> ...
>
>> If you only poll the fd after the last user-space suspend blocker is
>> released, why do you care when the kernel wakelock could have been
>> released? It seem the only thing it saves you is an extra poll call
>> when two wakeup events happen at the same time and one of them is
>> fully processed and unblocks suspend before the other event handler
>> blocks suspend. It seems strange to remove your wakeup event from th=
e
>> list when a specific suspend blocker is acquired when any suspend
>> blocker will prevent that wakeup event from being added to the list =
in
>> the first place.
>
> ...
>
>> I don't think there is a need to tie the fds to anything else. If yo=
u
>> poll the fds on the last suspend unblock call, you should get the sa=
me
>> behaviour.
>
> You are quite right; there is no need to associate suspend blockers
> with wakeup sources. =A0The power manager merely needs to poll all wa=
keup
> sources whenever no suspend blockers are active. =A0I put those
> associations in the proposal because of the line of reasoning that le=
d
> up to it, but they aren't necessary.
>
>
>> All input events that can wake the system are handled by one
>> user-space suspend blocker. Input devices come and go so we would ne=
ed
>> to add and remove the fds dynamically.
>
> Correct; the power manager would need to know whenever a wakeup-capab=
le
> device file was opened or closed.
>
>
>> > The power manager would indeed have to know about wakeup devices t=
hat
>> > don't need to _keep_ the system awake. =A0Here's one way to cope: =
During
>> > those times when no suspend blockers are active but the PM process
>> > thinks a wakeup source is active, the PM process could poll every =
few
>> > seconds to update its list of active sources. =A0At those points i=
t could
>> > remove wakeup sources that have timed out.
>> >
>>
>> For that to work the wakeup events would have to be reported to the
>> power manager in a reliable way in the first place. Passing the file
>> descriptor that the app uses to the power manager does not work for
>> this, since the app could read the event while the power manager was
>> not in the poll call and the power manager would never see it.
>
> If the app activates a suspend blocker before reading the event, this
> doesn't matter. =A0If the app doesn't activate a suspend blocker then=
 it
> risks being suspended after it has read the event but before it has
> handled the event. =A0This is equally true with wakelocks.
>

It is not the same. Using a wakelock with a timeout only has a problem
if the app did not get a change to run and block suspend before the
timeout expires. With the timeout values we use there is only a
problem if the system is already unresponsive. If the driver does not
block suspend but instead a power manager calls select or poll on a
file descriptor while the app does a blocking read, the power manager
can easily miss the event and suspend before the app blocks suspend.

>> Also,
>> existing apps don't pass their file descriptors to the power manager=
,
>> so it has the get the event from somewhere else.
>
> Now you've put your finger on the key. =A0The main difference between=
 my
> scheme and the original wakelock scheme is that programs have to info=
rm
> the power manager whenever they open or close a wakeup-capable device
> file. =A0With everything implemented inside the kernel this isn't
> necessary, because obviously a kernel driver already knows when its
> device file is opened or closed.
>
> As I said before, this additional complication in userspace is the
> price paid for keeping stuff out of the kernel. =A0If you had impleme=
nted
> wakelocks this way originally, you would not have needed to patch the
> vanilla kernel and this entire stormy discussion would never have
> occurred. =A0(But of course you couldn't have used this for the origi=
nal
> implementation of wakelocks, because back then the hardware couldn't
> achieve the lowest power states from idle.)
>
>> > Obviously this proposal would complicate your userspace. =A0Not
>> > enormously, since most of the work is confined to the power manage=
r,
>>
>> No, the main problem it that it is not confined to the power manager=
=2E
>> The power manager does not have a list of file descriptors to monito=
r,
>> so we have to modify all code that handles wakeup events. This
>> includes vendor supplied code that we don't have the source for, but=
,
>> on some platforms at least, this code relies on kernel wakelocks wit=
h
>> a timeout and could at first be handled the same way we would have t=
o
>> handle existing apps reading from a socket.
>
> Look, I never said this scheme was _better_ than wakelocks. =A0I mere=
ly
> said that it could be used without significant modifications to the
> kernel.
>
>> The suspend blocker approach is more generally useful since it
>> supports hardware where suspend is needed. Why this argument is bein=
g
>> ignored is very puzzling.
>
> Probably because people doesn't envision system suspend being used fo=
r
> dynamic power management on that kind of hardware.
>

I'm not sure what you mean by dynamic power management here (frequency
of suspends?), but auto suspend is already in use on x86 desktops and
laptops. Suspend blockers can fix the race with some wakeup events
there.

>> Your solution is not immediately useful since depends on removing al=
l
>> periodic kernel timers and adding support to stopping the monotonic
>> clock for set of processes that are frozen.
>
> The monotonic clock is indeed an issue.
>
> Periodic kernel timers... I don't know about them. =A0Has anyone trie=
d to
> measure them? =A0There are excellent reasons for trimming them when t=
he
> system goes into low-power idle, independent of Android. =A0This soun=
ds
> like the kind of thing Arjan might have worked on.
>
>> Your solution forces the user space interface to be more complicated=
,
>> and it creates a new user space power manager that has to start befo=
re
>> any process that handle wakeup events.
>
> That's right.
>
> Alan Stern
>
>



--=20
Arve Hj=F8nnev=E5g
