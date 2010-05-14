From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH 1/8] PM: Add suspend block api.
Date: Fri, 14 May 2010 00:14:47 -0700
Message-ID: <AANLkTimghkjR5PaWdOpJFM7jeq8vFpEAcF9DhgEW0hCK@mail.gmail.com>
References: <1273810273-3039-1-git-send-email-arve@android.com>
	<1273810273-3039-2-git-send-email-arve@android.com>
	<alpine.DEB.2.00.1005140023220.3348@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.DEB.2.00.1005140023220.3348@utopia.booyaka.com>
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

On Thu, May 13, 2010 at 11:27 PM, Paul Walmsley <paul@pwsan.com> wrote:
>
> Hello,
>
> Another comment on the kernel suspend-blocker API.
>
> On Thu, 13 May 2010, Arve Hj=F8nnev=E5g wrote:
>
>> Adds /sys/power/policy that selects the behaviour of /sys/power/state.
>> After setting the policy to opportunistic, writes to /sys/power/state
>> become non-blocking requests that specify which suspend state to enter
>> when no suspend blockers are active. A special state, "on", stops the
>> process by activating the "main" suspend blocker.
>>
>> Signed-off-by: Arve Hj=F8nnev=E5g <arve@android.com>
>
> Looking at the way that suspend-blocks are used in the current Android
> 'msm' kernel tree[1], they seem likely to cause layering violations,
> fragile kernel code with userspace dependencies, and code that consumes
> power unnecessarily.
>
> For example, in drivers/mmc/core/core.c:721, in mmc_rescan() [2], we find
> the following code:
>
> =A0 =A0 =A0 =A0/* give userspace some time to react */
> =A0 =A0 =A0 =A0wake_lock_timeout(&mmc_delayed_work_wake_lock, HZ / 2);
>
> This is a layering violation. =A0The MMC subsystem should have nothing to=
 do
> with "giving userspace time to react." =A0That is the responsibility of t=
he
> Linux scheduler.
>
> This code is also intrinsically fragile and use-case dependent. =A0What if
> userspace occasionally needs more than (HZ / 2) to react? =A0If the
> distributor is lucky enough to catch this before the product ships, then
> the distributor can patch in a new magic number. =A0But if the device mak=
es
> it to the consumer, the result is an unstable device that unpredictably
> suspends.
>
> The above code will also waste power. =A0Even if userspace takes less than
> (HZ / 2) to react, the system will still be prevented from entering a
> system-wide low power state for the duration of the remaining time. =A0Th=
is
> is in contrast to an approach that uses the idle loop to enter a
> system-wide low power state. =A0The moment that the system has no further
> work to do, it can start saving power.
>

Yes, preventing suspend for 1/2 second wastes some power, but are you
seriously suggesting that it wastes more power then never suspending?
Opportunitic suspend does not prevent entering low power modes from
idle.

-- =

Arve Hj=F8nnev=E5g
