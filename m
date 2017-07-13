From: Alex Shi <alex.shi@linaro.org>
Subject: Re: Regression with suspicious RCU usage splats with cpu_pm change
Date: Thu, 13 Jul 2017 17:43:06 +0800
Message-ID: <c00272dc-cf84-81a2-b2e2-d52cadf7bcc6@linaro.org>
References: <20170713070749.GE16509@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20170713070749.GE16509@atomide.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>
List-Id: linux-omap@vger.kernel.org


On 07/13/2017 03:07 PM, Tony Lindgren wrote:
> Hi,
> 
> Looks like next-20170713 gives me a bunch of "suspicious RCU usage"
> splats with cpuidle_coupled on duovero, see below. I bisected it down
> to commit 2f027e003d05 ("cpu_pm: replace raw_notifier with
> atomic_notifier").
> 
> Regards,
> 
> Tony
> 
> 8< -----------------------
> =============================
> WARNING: suspicious RCU usage
> 4.12.0-next-20170713+ #118 Tainted: G        W
> -----------------------------
> ./include/linux/rcupdate.h:611 rcu_read_lock() used illegally while idle!
> [    2.928802]
> other info that might help us debug this:
> [    2.928802]
> [    2.946777]
> RCU used illegally from idle CPU!
> rcu_scheduler_active = 2, debug_locks = 1
> RCU used illegally from extended quiescent state!

CC Catalin & Will,

It's a shame for me. :(

lockdep_rcu_suspicious() explained, rcu_read_lock can not be used after
rcu_idle_enter():

* If a CPU is in the RCU-free window in idle (ie: in the section
* between rcu_idle_enter() and rcu_idle_exit(), then RCU
* considers that CPU to be in an "extended quiescent state",
* which means that RCU will be completely ignoring that CPU.
* Therefore, rcu_read_lock() and friends have absolutely no
* effect on a CPU running in that state. In other words, even if
* such an RCU-idle CPU has called rcu_read_lock(), RCU might well
* delete data structures out from under it.  RCU really has no
* choice here: we need to keep an RCU-free window in idle where
* the CPU may possibly enter into low power mode. This way we can
* notice an extended quiescent state to other CPUs that started a grace
* period. Otherwise we would delay any grace period as long as we run
* in the idle task.

Although the cpu is still alive and not going to idle yet, the RCU is
starting to count this cpu into quiescent state. I guess it's not so
good to put off rcu_idle_enter for all archs. We need another solution
on this problem, maybe unsleepable raw_rwlock? or may best way is split
the notification and the real idle trigger in the function
arm_enter_idle_state()?



Regards
Alex
