From: Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH v3] PM-runtime: fix deadlock with ktime
Date: Fri, 1 Feb 2019 16:45:42 +0100
Message-ID: <20190201154542.GA6174@linaro.org>
References: <CAJZ5v0gunbCHp_9mDTmtwW1i-_GcXPcjTP48NdV2zv-B6UrD4g@mail.gmail.com>
 <1548869162-6223-1-git-send-email-vincent.guittot@linaro.org>
 <CAJZ5v0gnJ5DKvOO9OcJoMrGYpHfeQBt2Ec0pMW6=2q5aMoFpww@mail.gmail.com>
 <OSBPR01MB210387DEC42870D8E5688CE9B8920@OSBPR01MB2103.jpnprd01.prod.outlook.com>
 <CAKfTPtDNMV+HFsqc9A0VcMHOO=MvxWYZt8XkmWepso7SpfeAqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAKfTPtDNMV+HFsqc9A0VcMHOO=MvxWYZt8XkmWepso7SpfeAqA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Biju Das <biju.das@bp.renesas.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Le Friday 01 Feb 2019 à 16:28:54 (+0100), Vincent Guittot a écrit :
> On Fri, 1 Feb 2019 at 16:02, Biju Das <biju.das@bp.renesas.com> wrote:
> >
> > Hi Vincent,
> >
> > I have rebased my kernel to "next-20190201".  Still I am seeing dead lock.
> >
> > Am I missing any patch?
> 
> No you don't miss anything.
> I think that it's the opposite.
> 
> Modification in time accounting in PM runtime has been queued but it
> has not moved (yet) to ktime_get_mono_fast_ns()
> 
> Can you try to revert c669560be6c8 ("PM-runtime: Replace jiffies-based
> accounting with ktime-based accounting") ?

Or instead you can apply :

---
 drivers/base/power/runtime.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 4eaf166..1c40e2a 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -66,7 +66,7 @@ static int rpm_suspend(struct device *dev, int rpmflags);
  */
 void update_pm_runtime_accounting(struct device *dev)
 {
-	u64 now = ktime_to_ns(ktime_get());
+	u64 now = ktime_get_mono_fast_ns();
 	u64 delta;
 
 	delta = now - dev->power.accounting_timestamp;
@@ -1315,7 +1315,7 @@ void pm_runtime_enable(struct device *dev)
 
 		/* About to enable runtime pm, set accounting_timestamp to now */
 		if (!dev->power.disable_depth)
-			dev->power.accounting_timestamp = ktime_to_ns(ktime_get());
+			dev->power.accounting_timestamp = ktime_get_mono_fast_ns();
 	} else {
 		dev_warn(dev, "Unbalanced %s!\n", __func__);
 	}
-- 
2.7.4


>
> 
> >
> > root@ek874:/# echo e61e0000.timer > /sys/devices/system/clocksource/clocksource0/current_clocksource
> > [  193.869423]
> > [  193.870963] ============================================
> > [  193.876292] WARNING: possible recursive locking detected
> > [  193.881625] 5.0.0-rc4-next-20190201-00007-g731346f #3 Not tainted
> > [  193.887737] --------------------------------------------
> > [  193.893066] migration/0/11 is trying to acquire lock:
> > [  193.898136] (____ptrval____) (tk_core.seq){----}, at: update_pm_runtime_accounting+0x14/0x68
> > [  193.906632]
> > [  193.906632] but task is already holding lock:
> > [  193.912483] (____ptrval____) (tk_core.seq){----}, at: multi_cpu_stop+0x8c/0x140
> > [  193.919828]
> > [  193.919828] other info that might help us debug this:
> > [  193.926377]  Possible unsafe locking scenario:
> > [  193.926377]
> > [  193.932314]        CPU0
> > [  193.934765]        ----
> > [  193.937216]   lock(tk_core.seq);
> > [  193.940453]   lock(tk_core.seq);
> > [  193.943691]
> > [  193.943691]  *** DEADLOCK ***
> > [  193.943691]
> > [  193.949634]  May be due to missing lock nesting notation
> > [  193.949634]
> > [  193.956446] 3 locks held by migration/0/11:
> > [  193.960642]  #0: (____ptrval____) (timekeeper_lock){-.-.}, at: change_clocksource+0x2c/0x118
> > [  193.969125]  #1: (____ptrval____) (tk_core.seq){----}, at: multi_cpu_stop+0x8c/0x140
> > [  193.976903]  #2: (____ptrval____) (&(&dev->power.lock)->rlock){....}, at: __pm_runtime_resume+0x40/0x98
> > [  193.986339]
> > [  193.986339] stack backtrace:
> > [  193.990715] CPU: 0 PID: 11 Comm: migration/0 Not tainted 5.0.0-rc4-next-20190201-00007-g731346f #3
> > [  193.999707] Hardware name: Silicon Linux RZ/G2E evaluation kit EK874 (CAT874 + CAT875) (DT)
> > [  194.008089] Call trace:
> > [  194.010553]  dump_backtrace+0x0/0x178
> > [  194.014227]  show_stack+0x14/0x20
> > [  194.017562]  dump_stack+0xb0/0xec
> > [  194.020895]  __lock_acquire+0xfb4/0x1c08
> > [  194.024832]  lock_acquire+0xd0/0x268
> > [  194.028420]  ktime_get+0x5c/0x108
> > [  194.031747]  update_pm_runtime_accounting+0x14/0x68
> > [  194.036643]  rpm_resume+0x4ec/0x698
> > [  194.040144]  __pm_runtime_resume+0x50/0x98
> > [  194.044264]  sh_tmu_enable.part.1+0x24/0x50
> > [  194.048462]  sh_tmu_clocksource_enable+0x48/0x70
> > [  194.053097]  change_clocksource+0x84/0x118
> > [  194.057208]  multi_cpu_stop+0x8c/0x140
> > [  194.060970]  cpu_stopper_thread+0xac/0x120
> > [  194.065087]  smpboot_thread_fn+0x1ac/0x2c8
> > [  194.069198]  kthread+0x128/0x130
> > [  194.072439]  ret_from_fork+0x10/0x18
> >
> >
> > Regards,
> > Biju
> >
> > > -----Original Message-----
> > > From: Rafael J. Wysocki <rafael@kernel.org>
> > > Sent: 30 January 2019 21:53
> > > To: Vincent Guittot <vincent.guittot@linaro.org>
> > > Cc: Linux PM <linux-pm@vger.kernel.org>; Linux Kernel Mailing List <linux-
> > > kernel@vger.kernel.org>; Linux ARM <linux-arm-
> > > kernel@lists.infradead.org>; Linux OMAP Mailing List <linux-
> > > omap@vger.kernel.org>; Rafael J. Wysocki <rjw@rjwysocki.net>; Ulf
> > > Hansson <ulf.hansson@linaro.org>; Biju Das <biju.das@bp.renesas.com>;
> > > Geert Uytterhoeven <geert@linux-m68k.org>; Linux-Renesas <linux-
> > > renesas-soc@vger.kernel.org>
> > > Subject: Re: [PATCH v3] PM-runtime: fix deadlock with ktime
> > >
> > > On Wed, Jan 30, 2019 at 6:26 PM Vincent Guittot
> > > <vincent.guittot@linaro.org> wrote:
> > > >
> > > > A deadlock has been seen when swicthing clocksources which use PM
> > > runtime.
> > > > The call path is:
> > > > change_clocksource
> > > >     ...
> > > >     write_seqcount_begin
> > > >     ...
> > > >     timekeeping_update
> > > >         ...
> > > >         sh_cmt_clocksource_enable
> > > >             ...
> > > >             rpm_resume
> > > >                 pm_runtime_mark_last_busy
> > > >                     ktime_get
> > > >                         do
> > > >                             read_seqcount_begin
> > > >                         while read_seqcount_retry
> > > >     ....
> > > >     write_seqcount_end
> > > >
> > > > Although we should be safe because we haven't yet changed the
> > > > clocksource at that time, we can't because of seqcount protection.
> > > >
> > > > Use ktime_get_mono_fast_ns() instead which is lock safe for such case
> > > >
> > > > With ktime_get_mono_fast_ns, the timestamp is not guaranteed to be
> > > > monotonic across an update and as a result can goes backward.
> > > > According to
> > > > update_fast_timekeeper() description: "In the worst case, this can
> > > > result is a slightly wrong timestamp (a few nanoseconds)". For PM
> > > > runtime autosuspend, this means only that the suspend decision can be
> > > > slightly sub optimal.
> > > >
> > > > Fixes: 8234f6734c5d ("PM-runtime: Switch autosuspend over to using
> > > > hrtimers")
> > > > Reported-by: Biju Das <biju.das@bp.renesas.com>
> > > > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > > > ---
> > > >
> > > > Hi Rafael,
> > > >
> > > > Sorry, I sent the version with the typo mistake that generated the
> > > > compilation error reported by kbuild-test-robot
> > > >
> > > > This version doesn't have the typo.
> > >
> > > OK, I've applied this one, thanks!
> >
> >
> >
> > Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, Buckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered No. 04586709.
