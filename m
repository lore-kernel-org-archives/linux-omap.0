From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/8] PM: Add suspend block api.
Date: Mon, 17 May 2010 21:34:45 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1005172115020.27473@utopia.booyaka.com>
References: <1273810273-3039-1-git-send-email-arve@android.com>
	<1273810273-3039-2-git-send-email-arve@android.com>
	<alpine.DEB.2.00.1005140023220.3348@utopia.booyaka.com>
	<AANLkTimghkjR5PaWdOpJFM7jeq8vFpEAcF9DhgEW0hCK@mail.gmail.com>
	<alpine.DEB.2.00.1005172011310.27473@utopia.booyaka.com>
	<AANLkTikybZSgsmcORpfptOrK__57sl71896JV-01OilQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="155748971-1452536789-1274153461=:27473"
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTikybZSgsmcORpfptOrK__57sl71896JV-01OilQ@mail.gmail.com>
Content-ID: <alpine.DEB.2.00.1005172131120.27473@utopia.booyaka.com>
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

--155748971-1452536789-1274153461=:27473
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <alpine.DEB.2.00.1005172131121.27473@utopia.booyaka.com>

Hello Arve,

On Mon, 17 May 2010, Arve Hj=F8nnev=E5g wrote:

> On Mon, May 17, 2010 at 7:17 PM, Paul Walmsley <paul@pwsan.com> wrote:
> > On Fri, 14 May 2010, Arve Hj=F8nnev=E5g wrote:
> >> On Thu, May 13, 2010 at 11:27 PM, Paul Walmsley <paul@pwsan.com> wrote=
:
> >> > On Thu, 13 May 2010, Arve Hj=F8nnev=E5g wrote:
> >> >
> >> >> Adds /sys/power/policy that selects the behaviour of /sys/power/sta=
te.
> >> >> After setting the policy to opportunistic, writes to /sys/power/sta=
te
> >> >> become non-blocking requests that specify which suspend state to en=
ter
> >> >> when no suspend blockers are active. A special state, "on", stops t=
he
> >> >> process by activating the "main" suspend blocker.
> >> >>
> >> >> Signed-off-by: Arve Hj=F8nnev=E5g <arve@android.com>
> >> >
> >> > Looking at the way that suspend-blocks are used in the current Andro=
id
> >> > 'msm' kernel tree[1], they seem likely to cause layering violations,
> >> > fragile kernel code with userspace dependencies, and code that consu=
mes
> >> > power unnecessarily.
> >> >
> >> > For example, in drivers/mmc/core/core.c:721, in mmc_rescan() [2], we=
 find
> >> > the following code:
> >> >
> >> > =A0 =A0 =A0 =A0/* give userspace some time to react */
> >> > =A0 =A0 =A0 =A0wake_lock_timeout(&mmc_delayed_work_wake_lock, HZ / 2=
);
> >> >
> >> > This is a layering violation. =A0The MMC subsystem should have nothi=
ng to do
> >> > with "giving userspace time to react." =A0That is the responsibility=
 of the
> >> > Linux scheduler.
> >> >
> >> > This code is also intrinsically fragile and use-case dependent. =A0W=
hat if
> >> > userspace occasionally needs more than (HZ / 2) to react? =A0If the
> >> > distributor is lucky enough to catch this before the product ships, =
then
> >> > the distributor can patch in a new magic number. =A0But if the devic=
e makes
> >> > it to the consumer, the result is an unstable device that unpredicta=
bly
> >> > suspends.
> >> >
> >> > The above code will also waste power. =A0Even if userspace takes les=
s than
> >> > (HZ / 2) to react, the system will still be prevented from entering =
a
> >> > system-wide low power state for the duration of the remaining time. =
=A0This
> >> > is in contrast to an approach that uses the idle loop to enter a
> >> > system-wide low power state. =A0The moment that the system has no fu=
rther
> >> > work to do, it can start saving power.
> >> >
> >>
> >> Yes, preventing suspend for 1/2 second wastes some power, but are you
> >> seriously suggesting that it wastes more power then never suspending?
> >> Opportunitic suspend does not prevent entering low power modes from
> >> idle.
> >
> > Sorry, my E-mail was unclear. =A0Here is my intended point:
> >
> > The current Android opportunistic suspend governor does not enter full
> > system suspend until all suspend-blocks are released. =A0If the governo=
r
> > were modified to respect the scheduler, then it could enter suspend the
> > moment that the system had no further work to do.
> >
>=20
> On the hardware that shipped we enter the same power state from idle
> and suspend, so the only power savings we get from suspend that we
> don't get in idle is from not respecting the scheduler and timers.

Other people=20
say that their hardware XXX.  (This is probably likely for anything that=20
supports ACPI.)

> > So during part of the (HZ / 2) time interval in the above code, the sys=
tem
> > is running some kernel or userspace code. =A0But after that work is don=
e, an
> > idle-loop-based opportunistic suspend governor could enter idle during
> > the remaining portion of that (HZ / 2) time interval, while the current
> > governor must keep the system out of suspend.
> >
> Triggering a full suspend (that disregards normal timers) from idle
> does not work, since the system may temporarily enter idle while
> processing the event.

Could you provide an example?

In such a case, how can the kernel guarantee that the system will process=
=20
the event within (HZ / 2) seconds?

> > Of course, to do this, a different method for freezing processes would =
be
> > needed; one possible approach is described here[1]; others have propose=
d
> > similar approaches.
>=20
> If you freeze processes you need something like a suspend blocker to
> prevent processes from being frozen.=20

(It occurs to me that "frozen" is the wrong terminology to use.
 Perhaps "paused" would be a better term, along the lines of [1].)

The full set of processes does not need to be paused.  For example, if=20
"untrusted" processes are run in a cgroup, and only tasks in that cgroup=20
are put into TASK_INTERRUPTIBLE, then "trusted" processes will not be=20
paused.

> By having a process that never gets frozen you could implement this=20
> entirely in user space, but you would have to funnel all wakeup events=20
> though this process.

The proposal[2] does require a kernel change.  No wakeup funnel process=20
would be needed.  The proposal is to put processes into=20
TASK_INTERRUPTIBLE, not TASK_STOPPED (unlike most "freezers").


- Paul


1. Paragraph B4B of Paul Walmsley E-mail to the linux-pm mailing=20
   list, dated Mon May 17 18:39:44 PDT 2010:
   https://lists.linux-foundation.org/pipermail/linux-pm/2010-May/025663.ht=
ml

2. ibid.


--155748971-1452536789-1274153461=:27473
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--155748971-1452536789-1274153461=:27473--
