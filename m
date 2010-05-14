From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/8] PM: Add suspend block api.
Date: Fri, 14 May 2010 00:27:56 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1005140023220.3348@utopia.booyaka.com>
References: <1273810273-3039-1-git-send-email-arve@android.com>
	<1273810273-3039-2-git-send-email-arve@android.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-2000346974-1273818476=:3348"
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1273810273-3039-2-git-send-email-arve@android.com>
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

--155748971-2000346974-1273818476=:3348
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE


Hello,

Another comment on the kernel suspend-blocker API.

On Thu, 13 May 2010, Arve Hj=C3=B8nnev=C3=A5g wrote:

> Adds /sys/power/policy that selects the behaviour of /sys/power/state.
> After setting the policy to opportunistic, writes to /sys/power/state
> become non-blocking requests that specify which suspend state to enter
> when no suspend blockers are active. A special state, "on", stops the
> process by activating the "main" suspend blocker.
>=20
> Signed-off-by: Arve Hj=C3=B8nnev=C3=A5g <arve@android.com>

Looking at the way that suspend-blocks are used in the current Android=20
'msm' kernel tree[1], they seem likely to cause layering violations,=20
fragile kernel code with userspace dependencies, and code that consumes=20
power unnecessarily.

For example, in drivers/mmc/core/core.c:721, in mmc_rescan() [2], we find=
=20
the following code:

=09/* give userspace some time to react */
=09wake_lock_timeout(&mmc_delayed_work_wake_lock, HZ / 2);

This is a layering violation.  The MMC subsystem should have nothing to do=
=20
with "giving userspace time to react."  That is the responsibility of the=
=20
Linux scheduler.

This code is also intrinsically fragile and use-case dependent.  What if=20
userspace occasionally needs more than (HZ / 2) to react?  If the=20
distributor is lucky enough to catch this before the product ships, then=20
the distributor can patch in a new magic number.  But if the device makes=
=20
it to the consumer, the result is an unstable device that unpredictably=20
suspends.

The above code will also waste power.  Even if userspace takes less than=20
(HZ / 2) to react, the system will still be prevented from entering a=20
system-wide low power state for the duration of the remaining time.  This=
=20
is in contrast to an approach that uses the idle loop to enter a=20
system-wide low power state.  The moment that the system has no further=20
work to do, it can start saving power.

The problems with the above example are not isolated:

[paul@twilight msm]$ fgrep -r wake_lock_timeout . | egrep '(^./drivers|^./a=
rch)'
=2E/arch/arm/mach-msm/htc_battery.c:=09=09wake_lock_timeout(&vbus_wake_lock=
, HZ / 2);
=2E/arch/arm/mach-msm/smd_tty.c:=09=09wake_lock_timeout(&info->wake_lock, H=
Z / 2);
=2E/arch/arm/mach-msm/smd_qmi.c:=09=09wake_lock_timeout(&ctxt->wake_lock, H=
Z / 2);
=2E/drivers/rtc/alarm.c:=09=09wake_lock_timeout(&alarm_wake_lock, 5 * HZ);
=2E/drivers/rtc/alarm.c:=09wake_lock_timeout(&alarm_rtc_wake_lock, 1 * HZ);
=2E/drivers/rtc/alarm.c:=09=09=09wake_lock_timeout(&alarm_rtc_wake_lock, 2 =
* HZ);
=2E/drivers/mmc/core/core.c:=09wake_lock_timeout(&mmc_delayed_work_wake_loc=
k, HZ / 2);
=2E/drivers/net/msm_rmnet.c:=09wake_lock_timeout(&p->wake_lock, HZ / 2);
=2E/drivers/video/msm/msm_fb.c:=09wake_lock_timeout(&msmfb->idle_lock, HZ/4=
);
=2E/drivers/video/msm/msm_fb.c:=09=09wake_lock_timeout(&msmfb->idle_lock, H=
Z/4);
=2E/drivers/video/msm/msm_fb.c:=09=09wake_lock_timeout(&msmfb->idle_lock, H=
Z);
=2E/drivers/input/evdev.c:=09wake_lock_timeout(&client->wake_lock, 5 * HZ);
=2E/drivers/serial/msm_serial_hs.c:=09wake_lock_timeout(&msm_uport->rx.wake=
_lock, HZ / 2);

It is true that the current patch series does not propose the *_timeout()=
=20
interface.  But that raises the question of what it will be replaced with,=
=20
in situations where the problem can't simply be pushed to userspace, as it=
=20
is in Arve's evdev patch 7.  Some of these cases seem difficult to handle=
=20
without some sort of timer-based approach.  Timer-based approaches are=20
intrinsically problematic for the reasons mentioned above.


- Paul


1. git://android.git.kernel.org/kernel/msm.git - as of commit
   c7f8bcecb06b937c45dd0e342450a3218b286b8d, "[ARM] msm: defconfig:
   Set mmap_min_addr to 32k"

2. http://android.git.kernel.org/?p=3Dkernel/msm.git;a=3Dblob;f=3Ddrivers/m=
mc/core/core.c;h=3D22f6ddad85c92f34c55035982049bb03b5abfc74;hb=3Dc7f8bcecb0=
6b937c45dd0e342450a3218b286b8d#l721



--155748971-2000346974-1273818476=:3348
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--155748971-2000346974-1273818476=:3348--
