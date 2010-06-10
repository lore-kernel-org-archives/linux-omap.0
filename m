From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] suspend blockers & Android integration
Date: Thu, 10 Jun 2010 10:28:46 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1006101003480.1702-100000@iolanthe.rowland.org>
References: <AANLkTil2JhBgJ27qcTARVj2wVgEltxZKPOc9Ddu4c8yY@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AANLkTil2JhBgJ27qcTARVj2wVgEltxZKPOc9Ddu4c8yY@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Cc: tytso@mit.edu, Alan Cox <alan@lxorguk.ukuu.org.uk>, Florian Mickler <florian@mickler.org>, Peter Zijlstra <peterz@infradead.org>, Brian Swetland <swetland@google.com>, "H. Peter Anvin" <hpa@zytor.com>, LKML <linux-kernel@vger.kernel.org>, Neil Brown <neilb@suse.de>, James Bottomley <James.Bottomley@suse.de>, Linux PM <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Felipe Balbi <felipe.balbi@nokia.com>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-omap@vger.kernel.org

On Wed, 9 Jun 2010, Arve Hj=F8nnev=E5g wrote:

> > I think this is where you misunderstood. =A0There is no "report wak=
eup
> > event" as such. =A0All that happens is that data becomes available =
to be
> > read from the input device file. =A0However the power manager proce=
ss
> > isn't polling the device file at this point (because a suspend bloc=
ker
> > is active), so it doesn't realize that the source has become active
> > again.
> >
>=20
> Yes this is not what I though you were suggesting. I thought you were
> trying to make sure the power manager sees all wakeup events. If you
> are only listening for wakeup events while no suspend blockers are
> active, why latch them?

=2E..

> If you only poll the fd after the last user-space suspend blocker is
> released, why do you care when the kernel wakelock could have been
> released? It seem the only thing it saves you is an extra poll call
> when two wakeup events happen at the same time and one of them is
> fully processed and unblocks suspend before the other event handler
> blocks suspend. It seems strange to remove your wakeup event from the
> list when a specific suspend blocker is acquired when any suspend
> blocker will prevent that wakeup event from being added to the list i=
n
> the first place.

=2E..

> I don't think there is a need to tie the fds to anything else. If you
> poll the fds on the last suspend unblock call, you should get the sam=
e
> behaviour.

You are quite right; there is no need to associate suspend blockers
with wakeup sources.  The power manager merely needs to poll all wakeup
sources whenever no suspend blockers are active.  I put those=20
associations in the proposal because of the line of reasoning that led=20
up to it, but they aren't necessary.


> All input events that can wake the system are handled by one
> user-space suspend blocker. Input devices come and go so we would nee=
d
> to add and remove the fds dynamically.

Correct; the power manager would need to know whenever a wakeup-capable=
=20
device file was opened or closed.


> > The power manager would indeed have to know about wakeup devices th=
at
> > don't need to _keep_ the system awake. =A0Here's one way to cope: D=
uring
> > those times when no suspend blockers are active but the PM process
> > thinks a wakeup source is active, the PM process could poll every f=
ew
> > seconds to update its list of active sources. =A0At those points it=
 could
> > remove wakeup sources that have timed out.
> >
>=20
> For that to work the wakeup events would have to be reported to the
> power manager in a reliable way in the first place. Passing the file
> descriptor that the app uses to the power manager does not work for
> this, since the app could read the event while the power manager was
> not in the poll call and the power manager would never see it.

If the app activates a suspend blocker before reading the event, this=20
doesn't matter.  If the app doesn't activate a suspend blocker then it=20
risks being suspended after it has read the event but before it has=20
handled the event.  This is equally true with wakelocks.

> Also,
> existing apps don't pass their file descriptors to the power manager,
> so it has the get the event from somewhere else.

Now you've put your finger on the key.  The main difference between my
scheme and the original wakelock scheme is that programs have to inform
the power manager whenever they open or close a wakeup-capable device
file.  With everything implemented inside the kernel this isn't
necessary, because obviously a kernel driver already knows when its
device file is opened or closed.

As I said before, this additional complication in userspace is the
price paid for keeping stuff out of the kernel.  If you had implemented
wakelocks this way originally, you would not have needed to patch the
vanilla kernel and this entire stormy discussion would never have
occurred.  (But of course you couldn't have used this for the original
implementation of wakelocks, because back then the hardware couldn't
achieve the lowest power states from idle.)

> > Obviously this proposal would complicate your userspace. =A0Not
> > enormously, since most of the work is confined to the power manager=
,
>=20
> No, the main problem it that it is not confined to the power manager.
> The power manager does not have a list of file descriptors to monitor=
,
> so we have to modify all code that handles wakeup events. This
> includes vendor supplied code that we don't have the source for, but,
> on some platforms at least, this code relies on kernel wakelocks with
> a timeout and could at first be handled the same way we would have to
> handle existing apps reading from a socket.

Look, I never said this scheme was _better_ than wakelocks.  I merely=20
said that it could be used without significant modifications to the=20
kernel.

> The suspend blocker approach is more generally useful since it
> supports hardware where suspend is needed. Why this argument is being
> ignored is very puzzling.

Probably because people doesn't envision system suspend being used for
dynamic power management on that kind of hardware.

> Your solution is not immediately useful since depends on removing all
> periodic kernel timers and adding support to stopping the monotonic
> clock for set of processes that are frozen.

The monotonic clock is indeed an issue.

Periodic kernel timers... I don't know about them.  Has anyone tried to
measure them?  There are excellent reasons for trimming them when the
system goes into low-power idle, independent of Android.  This sounds
like the kind of thing Arjan might have worked on.

> Your solution forces the user space interface to be more complicated,
> and it creates a new user space power manager that has to start befor=
e
> any process that handle wakeup events.

That's right.

Alan Stern
