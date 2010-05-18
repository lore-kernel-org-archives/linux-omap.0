From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH 1/8] PM: Add suspend block api.
Date: Mon, 17 May 2010 20:06:33 -0700
Message-ID: <AANLkTikybZSgsmcORpfptOrK__57sl71896JV-01OilQ@mail.gmail.com>
References: <1273810273-3039-1-git-send-email-arve@android.com>
	<1273810273-3039-2-git-send-email-arve@android.com>
	<alpine.DEB.2.00.1005140023220.3348@utopia.booyaka.com>
	<AANLkTimghkjR5PaWdOpJFM7jeq8vFpEAcF9DhgEW0hCK@mail.gmail.com>
	<alpine.DEB.2.00.1005172011310.27473@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.DEB.2.00.1005172011310.27473@utopia.booyaka.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, Liam Girdwood <lrg@slimlogic.co.uk>, Matthew Garrett <mjg@redhat.com>, Len Brown <len.brown@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Oleg Nesterov <oleg@redhat.com>, linux-omap@vger.kernel.org, Linus Walleij <linus.walleij@stericsson.com>, Daniel Walker <dwalker@codeaurora.org>, Theodore Ts'o <tytso@mit.edu>, Brian Swetland <swetland@google.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Geoff Smith <geoffx.smith@intel.com>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-omap@vger.kernel.org

On Mon, May 17, 2010 at 7:17 PM, Paul Walmsley <paul@pwsan.com> wrote:
> Hello Arve,
>
> On Fri, 14 May 2010, Arve Hj=F8nnev=E5g wrote:
>
>> On Thu, May 13, 2010 at 11:27 PM, Paul Walmsley <paul@pwsan.com> wrote:
>> >
>> > On Thu, 13 May 2010, Arve Hj=F8nnev=E5g wrote:
>> >
>> >> Adds /sys/power/policy that selects the behaviour of /sys/power/state.
>> >> After setting the policy to opportunistic, writes to /sys/power/state
>> >> become non-blocking requests that specify which suspend state to enter
>> >> when no suspend blockers are active. A special state, "on", stops the
>> >> process by activating the "main" suspend blocker.
>> >>
>> >> Signed-off-by: Arve Hj=F8nnev=E5g <arve@android.com>
>> >
>> > Looking at the way that suspend-blocks are used in the current Android
>> > 'msm' kernel tree[1], they seem likely to cause layering violations,
>> > fragile kernel code with userspace dependencies, and code that consumes
>> > power unnecessarily.
>> >
>> > For example, in drivers/mmc/core/core.c:721, in mmc_rescan() [2], we f=
ind
>> > the following code:
>> >
>> > =A0 =A0 =A0 =A0/* give userspace some time to react */
>> > =A0 =A0 =A0 =A0wake_lock_timeout(&mmc_delayed_work_wake_lock, HZ / 2);
>> >
>> > This is a layering violation. =A0The MMC subsystem should have nothing=
 to do
>> > with "giving userspace time to react." =A0That is the responsibility o=
f the
>> > Linux scheduler.
>> >
>> > This code is also intrinsically fragile and use-case dependent. =A0Wha=
t if
>> > userspace occasionally needs more than (HZ / 2) to react? =A0If the
>> > distributor is lucky enough to catch this before the product ships, th=
en
>> > the distributor can patch in a new magic number. =A0But if the device =
makes
>> > it to the consumer, the result is an unstable device that unpredictably
>> > suspends.
>> >
>> > The above code will also waste power. =A0Even if userspace takes less =
than
>> > (HZ / 2) to react, the system will still be prevented from entering a
>> > system-wide low power state for the duration of the remaining time. =
=A0This
>> > is in contrast to an approach that uses the idle loop to enter a
>> > system-wide low power state. =A0The moment that the system has no furt=
her
>> > work to do, it can start saving power.
>> >
>>
>> Yes, preventing suspend for 1/2 second wastes some power, but are you
>> seriously suggesting that it wastes more power then never suspending?
>> Opportunitic suspend does not prevent entering low power modes from
>> idle.
>
> Sorry, my E-mail was unclear. =A0Here is my intended point:
>
> The current Android opportunistic suspend governor does not enter full
> system suspend until all suspend-blocks are released. =A0If the governor
> were modified to respect the scheduler, then it could enter suspend the
> moment that the system had no further work to do.
>

On the hardware that shipped we enter the same power state from idle
and suspend, so the only power savings we get from suspend that we
don't get in idle is from not respecting the scheduler and timers.

> So during part of the (HZ / 2) time interval in the above code, the system
> is running some kernel or userspace code. =A0But after that work is done,=
 an
> idle-loop-based opportunistic suspend governor could enter idle during
> the remaining portion of that (HZ / 2) time interval, while the current
> governor must keep the system out of suspend.
>
Triggering a full suspend (that disregards normal timers) from idle
does not work, since the system may temporarily enter idle while
processing the event.

> Of course, to do this, a different method for freezing processes would be
> needed; one possible approach is described here[1]; others have proposed
> similar approaches.
>

If you freeze processes you need something like a suspend blocker to
prevent processes from being frozen. By having a process that never
gets frozen you could implement this entirely in user space, but you
would have to funnel all wakeup events though this process.

>
> regards,
>
> - Paul
>
>
> 1. Paragraphs B4A and B4B of Paul Walmsley E-mail to the linux-pm mailing
> =A0 list, dated Mon May 17 18:39:44 PDT 2010:
> =A0 https://lists.linux-foundation.org/pipermail/linux-pm/2010-May/025663=
.html

-- =

Arve Hj=F8nnev=E5g
