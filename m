From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/8] PM: Add suspend block api.
Date: Thu, 13 May 2010 13:01:33 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1005130839210.7624@utopia.booyaka.com>
References: <1272667021-21312-1-git-send-email-arve@android.com>
	<1272667021-21312-2-git-send-email-arve@android.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-583129415-1273761562=:7624"
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1272667021-21312-2-git-send-email-arve@android.com>
Content-ID: <alpine.DEB.2.00.1005130841120.7624@utopia.booyaka.com>
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
Cc: linux-doc@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, Liam Girdwood <lrg@slimlogic.co.uk>, Matthew Garrett <mjg@redhat.com>, Len Brown <len.brown@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Linus Walleij <linus.walleij@stericsson.com>, Magnus Damm <damm@igel.co.jp>, linux-omap@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>, Daniel Walker <dwalker@codeaurora.org>, Theodore Ts'o <tytso@mit.edu>, Geoff Smith <geoffx.smith@intel.com>, Brian Swetland <swetland@google.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>
List-Id: linux-omap@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-583129415-1273761562=:7624
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <alpine.DEB.2.00.1005130841121.7624@utopia.booyaka.com>

Hi,

Some comments on the opportunistic suspend portion of this patch.

On Fri, 30 Apr 2010, Arve Hj=F8nnev=E5g wrote:

> Adds /sys/power/policy that selects the behaviour of /sys/power/state.
> After setting the policy to opportunistic, writes to /sys/power/state
> become non-blocking requests that specify which suspend state to enter
> when no suspend blockers are active. A special state, "on", stops the
> process by activating the "main" suspend blocker.
>=20
> Signed-off-by: Arve Hj=F8nnev=E5g <arve@android.com>
> ---
>  Documentation/power/opportunistic-suspend.txt |  119 +++++++++++
>  include/linux/suspend_blocker.h               |   64 ++++++
>  kernel/power/Kconfig                          |   16 ++
>  kernel/power/Makefile                         |    1 +
>  kernel/power/main.c                           |   92 ++++++++-
>  kernel/power/power.h                          |    9 +
>  kernel/power/suspend.c                        |    4 +-
>  kernel/power/suspend_blocker.c                |  261 +++++++++++++++++++=
++++++
>  8 files changed, 559 insertions(+), 7 deletions(-)
>  create mode 100644 Documentation/power/opportunistic-suspend.txt
>  create mode 100755 include/linux/suspend_blocker.h
>  create mode 100644 kernel/power/suspend_blocker.c


While reading the patch, it seemed that this opportunistic suspend
mechanism is a degenerate case of a system-wide form of CPUIdle.  I'll
call it "SystemIdle," for lack of a better term.  The main difference
between this and the CPUIdle design is that this patch's SystemIdle is
not integrated with any of the existing Linux mechanisms for limiting
idle duration or depth.  This is a major problem with the current
patch and should prevent it from being merged in its current state.
But if some SystemIdle-type code were to be written that did work with
the rest of the Linux kernel, it would be very useful.

To take an example from the current Linux-OMAP kernels: right now, the
Linux-OMAP code handles system-level idle through CPUIdle.[1] To
borrow ACPI terminology, some of the S-states are implemented as
C-states.  That isn't right, for several reasons:

- There are other constraints on system-level idle modes beyond those
  that apply to the CPU.  To take an OMAP example, on boards that
  support it, OMAP2+ chips can cut power to the external SoC
  high-frequency clock oscillator ("HF oscillator").[2] This is the
  clock that is later used to drive the CPU clock, bus clock, etc., on
  the SoC, but can also be used to drive other chips on the board,
  such as external audio codec chips, GPS receivers, etc.)  If power
  is cut to the HF oscillator, it can take several milliseconds to
  stabilize once power is reapplied.  Part of the decision as to
  whether to cut power to the HF oscillator is a classic idle
  balancing test between power economy and wakeup latency.  But this
  occurs on a system level - the CPU may not even be involved.

  Consider a low-power audio playback use-case.  The CPU may be only
  rarely involved, but other devices on the SoC may need to be active.
  For example, if a large number of audio samples are loaded into main
  memory, the CPU can go into a very deep sleep state while the DMA
  controller transfers the samples to the audio serial interface
  device.  But the DMA controller and audio serial interface need to
  run occasionally, so depending on FIFO depths in the system, the HF
  oscillator clock may need to be kept on, even if the CPU idle level
  would suggest that it could be disabled.

  Additionally, other external chips outside the SoC, may be clocked
  by that HF oscillator.  Continuing the low-power audio playback
  use-case, the external audio codec chip may also be clocked from the
  HF oscillator.  If the HF oscillator is cut when the SoC is idle,
  but the audio codec has samples in its buffer, audio playback will
  be disrupted.

- There should be only one system-level governor.  Since all of the
  production OMAPs so far have been single-CPU systems, we've been
  able to get away with this.  But on multi-CPU systems, there is one
  CPUIdle governor per CPU.  So reusing the CPUIdle governor to do this
  won't work the same way as it has for us in the past.

So some good SystemIdle-type code would be really useful for us.  But a=20
significant part of what "good" means is that such a SystemIdle needs to=20
be driven from the bottom up, rather than from the top down. In other=20
words, both the 'policy' (i.e., the choice of metrics to use to determine=
=20
the system idle state), and the 'implementation of that policy' (i.e., the=
=20
way to enter those idle states), should be left up to the underlying chip=
=20
architecture code that would implement SystemIdle client drivers.  (In=20
this regard, it would be even more different than CPUIdle, which hardcodes=
=20
the policy.)

This way, at least initially, there will be minimal top-down
restrictions on what architectures need to do to implement to their
chip's power management features.  As common features are identified,
by individual architectures implementing working code, then the
architecture developers can collaborate, and common components can be
proposed for merging into the top-level SystemIdle code.

Such a SystemIdle implementation should also work for Android's
opportunistic suspend code.  Google developers could choose the system
metrics that they wish to use to control system idle levels.  If they
want to ignore timers and the scheduler, that's fine - that design
decision can be confined to their policy driver, and the suspend-block
code can be activated the moment that some driver sets a PM
constraint, rather than doing anything more refined.  Similarly,
Google can change the way that the policy decisions are implemented.
Google could use a driver that does not take any advantage of
fine-grained power management aside from CPUIdle.  This driver could
simply enter full system suspend whenever the policy driver authorizes
it to do.

This approach - or some similar approach - should allow Android to do what=
=20
it needs, while still allowing other, more finely-grained power management=
=20
approaches to do something different.


regards,

- Paul
--155748971-583129415-1273761562=:7624
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--155748971-583129415-1273761562=:7624--
