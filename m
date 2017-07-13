From: Tony Lindgren <tony@atomide.com>
Subject: Regression with suspicious RCU usage splats with cpu_pm change
Date: Thu, 13 Jul 2017 00:07:49 -0700
Message-ID: <20170713070749.GE16509@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
To: Alex Shi <alex.shi@linaro.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

Looks like next-20170713 gives me a bunch of "suspicious RCU usage"
splats with cpuidle_coupled on duovero, see below. I bisected it down
to commit 2f027e003d05 ("cpu_pm: replace raw_notifier with
atomic_notifier").

Regards,

Tony

8< -----------------------
=============================
WARNING: suspicious RCU usage
4.12.0-next-20170713+ #118 Tainted: G        W
-----------------------------
./include/linux/rcupdate.h:611 rcu_read_lock() used illegally while idle!
[    2.928802]
other info that might help us debug this:
[    2.928802]
[    2.946777]
RCU used illegally from idle CPU!
rcu_scheduler_active = 2, debug_locks = 1
RCU used illegally from extended quiescent state!
1 lock held by swapper/1/0:
 #0:  (rcu_read_lock){......}, at: [<c01624fc>] __atomic_notifier_call_chain+0x0/0x150
[    2.975433]
stack backtrace:
CPU: 1 PID: 0 Comm: swapper/1 Tainted: G        W       4.12.0-next-20170713+ #118
Hardware name: Generic OMAP4 (Flattened Device Tree)
[<c0111524>] (unwind_backtrace) from [<c010d20c>] (show_stack+0x10/0x14)
[<c010d20c>] (show_stack) from [<c086259c>] (dump_stack+0xac/0xe0)
[<c086259c>] (dump_stack) from [<c0162624>] (__atomic_notifier_call_chain+0x128/0x150)
[<c0162624>] (__atomic_notifier_call_chain) from [<c023d9e8>] (cpu_pm_enter+0x24/0x64)
[<c023d9e8>] (cpu_pm_enter) from [<c0128e68>] (omap_enter_idle_coupled+0x188/0x208)
[<c0128e68>] (omap_enter_idle_coupled) from [<c069e640>] (cpuidle_enter_state+0x118/0x514)
[<c069e640>] (cpuidle_enter_state) from [<c06a07c0>] (cpuidle_enter_state_coupled+0x3a8/0x40c)
[<c06a07c0>] (cpuidle_enter_state_coupled) from [<c018d844>] (do_idle+0x1a8/0x21c)
[<c018d844>] (do_idle) from [<c018dc3c>] (cpu_startup_entry+0x18/0x1c)
[<c018dc3c>] (cpu_startup_entry) from [<8010164c>] (0x8010164c)
[    3.088043]
=============================
WARNING: suspicious RCU usage
4.12.0-next-20170713+ #118 Tainted: G        W
-----------------------------
./include/linux/rcupdate.h:611 rcu_read_lock() used illegally while idle!
[    3.115661]
other info that might help us debug this:
[    3.115661]
[    3.123718]
RCU used illegally from idle CPU!
rcu_scheduler_active = 2, debug_locks = 1
RCU used illegally from extended quiescent state!
2 locks held by swapper/1/0:
 #0:  (rcu_read_lock){......}, at: [<c01624fc>] __atomic_notifier_call_chain+0x0/0x150
 #1:  (rcu_read_lock){......}, at: [<c0216434>] __is_insn_slot_addr+0x0/0x16c
[    3.161773]
stack backtrace:
CPU: 1 PID: 0 Comm: swapper/1 Tainted: G        W       4.12.0-next-20170713+ #118
Hardware name: Generic OMAP4 (Flattened Device Tree)
[<c0111524>] (unwind_backtrace) from [<c010d20c>] (show_stack+0x10/0x14)
[<c010d20c>] (show_stack) from [<c086259c>] (dump_stack+0xac/0xe0)
[<c086259c>] (dump_stack) from [<c0216578>] (__is_insn_slot_addr+0x144/0x16c)
[<c0216578>] (__is_insn_slot_addr) from [<c015eecc>] (kernel_text_address+0x70/0x9c)
[<c015eecc>] (kernel_text_address) from [<c0110f0c>] (unwind_frame+0x3c/0x654)
[<c0110f0c>] (unwind_frame) from [<c01115c0>] (unwind_backtrace+0x9c/0x120)
[<c01115c0>] (unwind_backtrace) from [<c010d20c>] (show_stack+0x10/0x14)
[<c010d20c>] (show_stack) from [<c086259c>] (dump_stack+0xac/0xe0)
[<c086259c>] (dump_stack) from [<c0162624>] (__atomic_notifier_call_chain+0x128/0x150)
[<c0162624>] (__atomic_notifier_call_chain) from [<c023d9e8>] (cpu_pm_enter+0x24/0x64)
[<c023d9e8>] (cpu_pm_enter) from [<c0128e68>] (omap_enter_idle_coupled+0x188/0x208)
[<c0128e68>] (omap_enter_idle_coupled) from [<c069e640>] (cpuidle_enter_state+0x118/0x514)
[<c069e640>] (cpuidle_enter_state) from [<c06a07c0>] (cpuidle_enter_state_coupled+0x3a8/0x40c)
[<c06a07c0>] (cpuidle_enter_state_coupled) from [<c018d844>] (do_idle+0x1a8/0x21c)
[<c018d844>] (do_idle) from [<c018dc3c>] (cpu_startup_entry+0x18/0x1c)
[<c018dc3c>] (cpu_startup_entry) from [<8010164c>] (0x8010164c)
[    3.313781]
=============================
WARNING: suspicious RCU usage
4.12.0-next-20170713+ #118 Tainted: G        W
-----------------------------
./include/linux/rcupdate.h:662 rcu_read_unlock() used illegally while idle!
[    3.341583]
other info that might help us debug this:
[    3.341583]
[    3.349639]
RCU used illegally from idle CPU!
rcu_scheduler_active = 2, debug_locks = 1
RCU used illegally from extended quiescent state!
3 locks held by swapper/1/0:
 #0:  (rcu_read_lock){......}, at: [<c01624fc>] __atomic_notifier_call_chain+0x0/0x150
 #1:  (rcu_read_lock){......}, at: [<c0216434>] __is_insn_slot_addr+0x0/0x16c
 #2:  (rcu_read_lock){......}, at: [<c0216434>] __is_insn_slot_addr+0x0/0x16c
[    3.395996]
stack backtrace:
CPU: 1 PID: 0 Comm: swapper/1 Tainted: G        W       4.12.0-next-20170713+ #118
Hardware name: Generic OMAP4 (Flattened Device Tree)
[<c0111524>] (unwind_backtrace) from [<c010d20c>] (show_stack+0x10/0x14)
[<c010d20c>] (show_stack) from [<c086259c>] (dump_stack+0xac/0xe0)
[<c086259c>] (dump_stack) from [<c0216550>] (__is_insn_slot_addr+0x11c/0x16c)
[<c0216550>] (__is_insn_slot_addr) from [<c015eecc>] (kernel_text_address+0x70/0x9c)
[<c015eecc>] (kernel_text_address) from [<c0110f0c>] (unwind_frame+0x3c/0x654)
[<c0110f0c>] (unwind_frame) from [<c01115c0>] (unwind_backtrace+0x9c/0x120)
[<c01115c0>] (unwind_backtrace) from [<c010d20c>] (show_stack+0x10/0x14)
[<c010d20c>] (show_stack) from [<c086259c>] (dump_stack+0xac/0xe0)
[<c086259c>] (dump_stack) from [<c0216578>] (__is_insn_slot_addr+0x144/0x16c)
[<c0216578>] (__is_insn_slot_addr) from [<c015eecc>] (kernel_text_address+0x70/0x9c)
[<c015eecc>] (kernel_text_address) from [<c0110f0c>] (unwind_frame+0x3c/0x654)
[<c0110f0c>] (unwind_frame) from [<c01115c0>] (unwind_backtrace+0x9c/0x120)
[<c01115c0>] (unwind_backtrace) from [<c010d20c>] (show_stack+0x10/0x14)
[<c010d20c>] (show_stack) from [<c086259c>] (dump_stack+0xac/0xe0)
[<c086259c>] (dump_stack) from [<c0162624>] (__atomic_notifier_call_chain+0x128/0x150)
[<c0162624>] (__atomic_notifier_call_chain) from [<c023d9e8>] (cpu_pm_enter+0x24/0x64)
[<c023d9e8>] (cpu_pm_enter) from [<c0128e68>] (omap_enter_idle_coupled+0x188/0x208)
[<c0128e68>] (omap_enter_idle_coupled) from [<c069e640>] (cpuidle_enter_state+0x118/0x514)
[<c069e640>] (cpuidle_enter_state) from [<c06a07c0>] (cpuidle_enter_state_coupled+0x3a8/0x40c)
[<c06a07c0>] (cpuidle_enter_state_coupled) from [<c018d844>] (do_idle+0x1a8/0x21c)
[<c018d844>] (do_idle) from [<c018dc3c>] (cpu_startup_entry+0x18/0x1c)
[<c018dc3c>] (cpu_startup_entry) from [<8010164c>] (0x8010164c)
[    3.596588]
=============================
WARNING: suspicious RCU usage
4.12.0-next-20170713+ #118 Tainted: G        W
-----------------------------
./include/linux/rcupdate.h:662 rcu_read_unlock() used illegally while idle!
[    3.624328]
other info that might help us debug this:
[    3.624328]
[    3.632385]
RCU used illegally from idle CPU!
rcu_scheduler_active = 2, debug_locks = 1
RCU used illegally from extended quiescent state!
1 lock held by swapper/1/0:
 #0:  (rcu_read_lock){......}, at: [<c01624fc>] __atomic_notifier_call_chain+0x0/0x150
[    3.662048]
stack backtrace:
CPU: 1 PID: 0 Comm: swapper/1 Tainted: G        W       4.12.0-next-20170713+ #118
Hardware name: Generic OMAP4 (Flattened Device Tree)
[<c0111524>] (unwind_backtrace) from [<c010d20c>] (show_stack+0x10/0x14)
[<c010d20c>] (show_stack) from [<c086259c>] (dump_stack+0xac/0xe0)
[<c086259c>] (dump_stack) from [<c01625fc>] (__atomic_notifier_call_chain+0x100/0x150)
[<c01625fc>] (__atomic_notifier_call_chain) from [<c023d9e8>] (cpu_pm_enter+0x24/0x64)
[<c023d9e8>] (cpu_pm_enter) from [<c0128e68>] (omap_enter_idle_coupled+0x188/0x208)
[<c0128e68>] (omap_enter_idle_coupled) from [<c069e640>] (cpuidle_enter_state+0x118/0x514)
[<c069e640>] (cpuidle_enter_state) from [<c06a07c0>] (cpuidle_enter_state_coupled+0x3a8/0x40c)
[<c06a07c0>] (cpuidle_enter_state_coupled) from [<c018d844>] (do_idle+0x1a8/0x21c)
[<c018d844>] (do_idle) from [<c018dc3c>] (cpu_startup_entry+0x18/0x1c)
[<c018dc3c>] (cpu_startup_entry) from [<8010164c>] (0x8010164c)
