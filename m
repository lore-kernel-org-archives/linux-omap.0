From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/8] PM: Add suspend block api.
Date: Wed, 19 May 2010 09:55:58 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1005190936560.27473@utopia.booyaka.com>
References: <1273810273-3039-1-git-send-email-arve@android.com>
	<1273810273-3039-2-git-send-email-arve@android.com>
	<alpine.DEB.2.00.1005140023220.3348@utopia.booyaka.com>
	<AANLkTimghkjR5PaWdOpJFM7jeq8vFpEAcF9DhgEW0hCK@mail.gmail.com>
	<alpine.DEB.2.00.1005172011310.27473@utopia.booyaka.com>
	<AANLkTikybZSgsmcORpfptOrK__57sl71896JV-01OilQ@mail.gmail.com>
	<alpine.DEB.2.00.1005172115020.27473@utopia.booyaka.com>
	<AANLkTikKfyvHQVoY93u6-yK5V9RHzWdVcX73bpiD6Vdp@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-290829453-1274284558=:27473"
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTikKfyvHQVoY93u6-yK5V9RHzWdVcX73bpiD6Vdp@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: =?ISO-8859-15?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, Liam Girdwood <lrg@slimlogic.co.uk>, Matthew Garrett <mjg@redhat.com>, Len Brown <len.brown@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Oleg Nesterov <oleg@redhat.com>, linux-omap@vger.kernel.org, Linus Walleij <linus.walleij@stericsson.com>, Daniel Walker <dwalker@codeaurora.org>, Theodore Ts'o <tytso@mit.edu>, Brian Swetland <swetland@google.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Geoff Smith <geoffx.smith@intel.com>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-omap@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-290829453-1274284558=:27473
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Arve,

On Mon, 17 May 2010, Arve Hj=F8nnev=E5g wrote:

> On Mon, May 17, 2010 at 8:34 PM, Paul Walmsley <paul@pwsan.com> wrote:
> > On Mon, 17 May 2010, Arve Hj=F8nnev=E5g wrote:
> >> On Mon, May 17, 2010 at 7:17 PM, Paul Walmsley <paul@pwsan.com> wrote:
> >> > On Fri, 14 May 2010, Arve Hj=F8nnev=E5g wrote:
> >> >> On Thu, May 13, 2010 at 11:27 PM, Paul Walmsley <paul@pwsan.com> wr=
ote:
> >> >> > On Thu, 13 May 2010, Arve Hj=F8nnev=E5g wrote:
> >> >> >
> >> >> >> Adds /sys/power/policy that selects the behaviour of /sys/power/=
state.
> >> >> >> After setting the policy to opportunistic, writes to /sys/power/=
state
> >> >> >> become non-blocking requests that specify which suspend state to=
 enter
> >> >> >> when no suspend blockers are active. A special state, "on", stop=
s the
> >> >> >> process by activating the "main" suspend blocker.
> >> >> >>
> >> >> >> Signed-off-by: Arve Hj=F8nnev=E5g <arve@android.com>
> >> >> >
> >> >> > Looking at the way that suspend-blocks are used in the current An=
droid
> >> >> > 'msm' kernel tree[1], they seem likely to cause layering violatio=
ns,
> >> >> > fragile kernel code with userspace dependencies, and code that co=
nsumes
> >> >> > power unnecessarily.
> >> >> >
> >> >> > For example, in drivers/mmc/core/core.c:721, in mmc_rescan() [2],=
 we find
> >> >> > the following code:
> >> >> >
> >> >> > =A0 =A0 =A0 =A0/* give userspace some time to react */
> >> >> > =A0 =A0 =A0 =A0wake_lock_timeout(&mmc_delayed_work_wake_lock, HZ =
/ 2);
> >> >> >
> >> >> > This is a layering violation. =A0The MMC subsystem should have no=
thing to do
> >> >> > with "giving userspace time to react." =A0That is the responsibil=
ity of the
> >> >> > Linux scheduler.
> >> >> >
> >> >> > This code is also intrinsically fragile and use-case dependent. =
=A0What if
> >> >> > userspace occasionally needs more than (HZ / 2) to react? =A0If t=
he
> >> >> > distributor is lucky enough to catch this before the product ship=
s, then
> >> >> > the distributor can patch in a new magic number. =A0But if the de=
vice makes
> >> >> > it to the consumer, the result is an unstable device that unpredi=
ctably
> >> >> > suspends.
> >> >> >
> >> >> > The above code will also waste power. =A0Even if userspace takes =
less than
> >> >> > (HZ / 2) to react, the system will still be prevented from enteri=
ng a
> >> >> > system-wide low power state for the duration of the remaining tim=
e. =A0This
> >> >> > is in contrast to an approach that uses the idle loop to enter a
> >> >> > system-wide low power state. =A0The moment that the system has no=
 further
> >> >> > work to do, it can start saving power.
> >> >> >
> >> >>
> >> >> Yes, preventing suspend for 1/2 second wastes some power, but are y=
ou
> >> >> seriously suggesting that it wastes more power then never suspendin=
g?
> >> >> Opportunitic suspend does not prevent entering low power modes from
> >> >> idle.
> >> >
> >> > Sorry, my E-mail was unclear. =A0Here is my intended point:
> >> >
> >> > The current Android opportunistic suspend governor does not enter fu=
ll
> >> > system suspend until all suspend-blocks are released. =A0If the gove=
rnor
> >> > were modified to respect the scheduler, then it could enter suspend =
the
> >> > moment that the system had no further work to do.
> >> >
> >>
> >> On the hardware that shipped we enter the same power state from idle
> >> and suspend, so the only power savings we get from suspend that we
> >> don't get in idle is from not respecting the scheduler and timers.
> >
> > Other people
> > say that their hardware XXX. =A0(This is probably likely for anything t=
hat
> > supports ACPI.)

Heh, looks like this part of my E-mail escaped a little too early.

> >> > So during part of the (HZ / 2) time interval in the above code, the =
system
> >> > is running some kernel or userspace code. =A0But after that work is =
done, an
> >> > idle-loop-based opportunistic suspend governor could enter idle duri=
ng
> >> > the remaining portion of that (HZ / 2) time interval, while the curr=
ent
> >> > governor must keep the system out of suspend.
> >> >
> >> Triggering a full suspend (that disregards normal timers) from idle
> >> does not work, since the system may temporarily enter idle while
> >> processing the event.
> >
> > Could you provide an example?
>=20
> The code takes a pagefault. The system is idle while waiting for the
> dma to finish.

OK.

> > In such a case, how can the kernel guarantee that the system will proce=
ss
> > the event within (HZ / 2) seconds?
>
> It can't, but in my opinion if the event did not start processing in
> 1/2 second it was probably not time critical.

Thanks for the correction regarding the unit of the time interval.

To use the pagefault example, wouldn't that be partially dependent on=20
factors outside the control of the task that handles the input event? =20
(e.g., the time needed to page back in, or other code running on the=20
system.)

> >> > Of course, to do this, a different method for freezing processes wou=
ld be
> >> > needed; one possible approach is described here[1]; others have prop=
osed
> >> > similar approaches.
> >>
> >> If you freeze processes you need something like a suspend blocker to
> >> prevent processes from being frozen.
> >
> > (It occurs to me that "frozen" is the wrong terminology to use.
> > =A0Perhaps "paused" would be a better term, along the lines of [1].)
> >
> > The full set of processes does not need to be paused. =A0For example, i=
f
> > "untrusted" processes are run in a cgroup, and only tasks in that cgrou=
p
> > are put into TASK_INTERRUPTIBLE, then "trusted" processes will not be
> > paused.
>=20
> We want to freeze trusted processes.

By "trusted," I mean processes that are run with a suspend block, as in=20
your example to Tony[1].  Isn't it so that Android has processes that=20
either run entirely under suspend-blocks, or which take suspend-blocks at=
=20
some point in time during their execution?  Wouldn't those processes need=
=20
to be prevented from a force-pause or force-freeze?

> >> By having a process that never gets frozen you could implement this
> >> entirely in user space, but you would have to funnel all wakeup events
> >> though this process.
> >
> > The proposal[2] does require a kernel change. =A0No wakeup funnel proce=
ss
> > would be needed. =A0The proposal is to put processes into
> > TASK_INTERRUPTIBLE, not TASK_STOPPED (unlike most "freezers").
> >
>=20
> Why is the method used for pausing the processes relevant? If the
> process is paused it cannot process the wakeup event.

Tasks in TASK_INTERRUPTIBLE are woken back up when an event arrives,=20
unlike tasks in TASK_STOPPED, which are stopped until a SIGCONT arrives.

> The only way to get the wake event to the process is to funnel it though=
=20
> a process that never is paused.


- Paul

1. http://lkml.org/lkml/2010/5/7/420


--155748971-290829453-1274284558=:27473
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--155748971-290829453-1274284558=:27473--
