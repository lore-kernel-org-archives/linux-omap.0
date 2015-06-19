From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2] futex: lower the lock contention on the HB lock during
 wake up
Date: Fri, 19 Jun 2015 20:54:44 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1506192053280.4107@nanos>
References: <1432056298-18738-1-git-send-email-dave@stgolabs.net> <1432056298-18738-2-git-send-email-dave@stgolabs.net> <20150616192911.GA19500@linutronix.de> <1434484226.1903.19.camel@stgolabs.net> <20150617083350.GA2433@linutronix.de>
 <CAMAWPa9F3qP41XQ1jb9U+fQxUAogYnomHabbKj6PG1=Mf8sW2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMAWPa9F3qP41XQ1jb9U+fQxUAogYnomHabbKj6PG1=Mf8sW2w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Davidlohr Bueso <dave@stgolabs.net>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Mike Galbraith <umgwanakikbuti@gmail.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, lkml <linux-kernel@vger.kernel.org>, Tyler Baker <tyler.baker@linaro.org>, Olof Johansson <olof@lixom.net>, Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>, Felipe Balbi <balbi@ti.com>, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

On Fri, 19 Jun 2015, Kevin Hilman wrote:
> On Wed, Jun 17, 2015 at 1:33 AM, Sebastian Andrzej Siewior
> A handful of boot test failures on ARM/OMAP were found by kernelci.org
> in next-20150619[1] and were bisected down to this patch, which hit
> next-20150619 in the form of commit 881bd58d6e9e (futex: Lower the
> lock contention on the HB lock during wake up).  I confirmed that
> reverting that patch on top of next-20150619 gets things booting again
> for the affected platforms.
> 
> I haven't debugged this any further, but full boot logs are available
> for the boot failures[2][3] and the linux-omap list and maintainer are
> Cc'd here to help investigate further if needed.

Found it. Dunno, how I missed that one. Fix below.

Thanks,

	tglx
---

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 10dbeb6fe96f..5674b073473c 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1365,9 +1365,14 @@ rt_mutex_fastunlock(struct rt_mutex *lock,
 	if (likely(rt_mutex_cmpxchg(lock, current, NULL))) {
 		rt_mutex_deadlock_account_unlock(current);
 
-	} else if (slowfn(lock, &wake_q)) {
+	} else {
+		bool deboost = slowfn(lock, &wake_q);
+
+		wake_up_q(&wake_q);
+
 		/* Undo pi boosting if necessary: */
-		rt_mutex_adjust_prio(current);
+		if (deboost)
+			rt_mutex_adjust_prio(current);
 	}
 }
 
