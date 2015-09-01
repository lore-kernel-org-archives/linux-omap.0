From: Sebastian Ott <sebott@linux.vnet.ibm.com>
Subject: Re: [PATCH] security: device_cgroup: fix RCU lockdep splat
Date: Tue, 1 Sep 2015 11:12:18 +0200 (CEST)
Message-ID: <alpine.LFD.2.11.1509011109150.1709@denkbrett>
References: <1441053629-31844-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1441053629-31844-1-git-send-email-balbi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: James Morris <james.l.morris@oracle.com>, serge@hallyn.com, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Mon, 31 Aug 2015, Felipe Balbi wrote:
> while booting AM437x device, the following splat
> triggered:
> 
> [   12.005238] ===============================
> [   12.009749] [ INFO: suspicious RCU usage. ]
> [   12.014116] 4.2.0-next-20150831 #1154 Not tainted
> [   12.019050] -------------------------------
> [   12.023408] security/device_cgroup.c:405 device_cgroup:verify_new_ex called without proper synchronization!
> [   12.033576] other info that might help us debug this:
> 
> [   12.041942] rcu_scheduler_active = 1, debug_locks = 0
> [   12.048796] 4 locks held by systemd/1:
> [   12.052700]  #0:  (sb_writers#7){.+.+.+}, at: [<c017af84>] __sb_start_write+0x8c/0xb0
> [   12.060954]  #1:  (&of->mutex){+.+.+.}, at: [<c01f1600>] kernfs_fop_write+0x50/0x1b8
> [   12.069085]  #2:  (s_active#30){++++.+}, at: [<c01f1608>] kernfs_fop_write+0x58/0x1b8
> [   12.077310]  #3:  (devcgroup_mutex){+.+...}, at: [<c0317bfc>] devcgroup_access_write+0x20/0x658
> [   12.086575] stack backtrace:
> [   12.091124] CPU: 0 PID: 1 Comm: systemd Not tainted 4.2.0-next-20150831 #1154
> [   12.098609] Hardware name: Generic AM43 (Flattened Device Tree)
> [   12.104807] [<c001770c>] (unwind_backtrace) from [<c0013a58>] (show_stack+0x10/0x14)
> [   12.112924] [<c0013a58>] (show_stack) from [<c034f014>] (dump_stack+0x84/0x9c)
> [   12.120491] [<c034f014>] (dump_stack) from [<c0317a04>] (verify_new_ex+0xc4/0xdc)
> [   12.128326] [<c0317a04>] (verify_new_ex) from [<c0317f50>] (devcgroup_access_write+0x374/0x658)
> [   12.137426] [<c0317f50>] (devcgroup_access_write) from [<c00d2800>] (cgroup_file_write+0x28/0x1bc)
> [   12.146796] [<c00d2800>] (cgroup_file_write) from [<c01f1670>] (kernfs_fop_write+0xc0/0x1b8)
> [   12.155620] [<c01f1670>] (kernfs_fop_write) from [<c0177c94>] (__vfs_write+0x1c/0xd8)
> [   12.163783] [<c0177c94>] (__vfs_write) from [<c0178594>] (vfs_write+0x90/0x16c)
> [   12.171426] [<c0178594>] (vfs_write) from [<c0178db4>] (SyS_write+0x44/0x9c)
> [   12.178806] [<c0178db4>] (SyS_write) from [<c000f680>] (ret_fast_syscall+0x0/0x1c)
> 
> Fix it by making sure rcu_read_lock() is held
> around devcgroup_update_access().

With this patch applied I got the following:

[    4.079102] BUG: sleeping function called from invalid context at mm/slub.c:1266
[    4.079105] in_atomic(): 0, irqs_disabled(): 0, pid: 1, name: systemd
[    4.079108] 5 locks held by systemd/1:
[    4.079110]  #0:  (sb_writers#7){.+.+.+}, at: [<00000000002c4450>] vfs_write+0x180/0x1a8
[    4.079120]  #1:  (&of->mutex){+.+.+.}, at: [<0000000000354d32>] kernfs_fop_write+0x6a/0x1a0
[    4.079127]  #2:  (s_active#7){++++.+}, at: [<0000000000354d3e>] kernfs_fop_write+0x76/0x1a0
[    4.079133]  #3:  (devcgroup_mutex){+.+.+.}, at: [<00000000003f3f7e>] devcgroup_access_write+0x46/0x7b8
[    4.079143]  #4:  (rcu_read_lock){......}, at: [<00000000003f3f38>] devcgroup_access_write+0x0/0x7b8
[    4.079149] Preemption disabled at:[<00000000001ab52c>] vprintk_default+0x44/0x58

[    4.079155] CPU: 0 PID: 1 Comm: systemd Not tainted 4.2.0-02744-g65a9959-dirty #170
[    4.079157]        0000000075c079b0 0000000075c07a40 0000000000000002 0000000000000000 
       0000000075c07ae0 0000000075c07a58 0000000075c07a58 0000000000113e9e 
       0000000000000000 000000000089c4f4 000000000087b700 000000000000000b 
       0000000075c07aa0 0000000075c07a40 0000000000000000 0000000000000000 
       0000000000000000 0000000000113e9e 0000000075c07a40 0000000075c07aa0 
[    4.079239] Call Trace:
[    4.079242] ([<0000000000113d7e>] show_trace+0xfe/0x160)
[    4.079244]  [<0000000000113e50>] show_stack+0x70/0xf0
[    4.079247]  [<00000000006bb184>] dump_stack+0x7c/0xd8
[    4.079250]  [<0000000000164e42>] ___might_sleep+0x19a/0x268
[    4.079255]  [<00000000002bbc06>] __kmalloc_track_caller+0x2fe/0x460
[    4.079258]  [<0000000000275fee>] kmemdup+0x3e/0x68
[    4.079260]  [<00000000003f3dda>] dev_exception_add+0x4a/0x130
[    4.079262]  [<00000000003f459e>] devcgroup_access_write+0x666/0x7b8
[    4.079265]  [<00000000001ea100>] cgroup_file_write+0x50/0x1f0
[    4.079267]  [<0000000000354e1a>] kernfs_fop_write+0x152/0x1a0
[    4.079269]  [<00000000002c38f2>] __vfs_write+0x42/0x108
[    4.079272]  [<00000000002c4362>] vfs_write+0x92/0x1a8
[    4.079274]  [<00000000002c50fe>] SyS_write+0x66/0xd8
[    4.079277]  [<00000000006c4f26>] system_call+0xd6/0x258
[    4.079279]  [<000003fffd5cda58>] 0x3fffd5cda58
[    4.079281] 5 locks held by systemd/1:
[    4.079282]  #0:  (sb_writers#7){.+.+.+}, at: [<00000000002c4450>] vfs_write+0x180/0x1a8
[    4.079289]  #1:  (&of->mutex){+.+.+.}, at: [<0000000000354d32>] kernfs_fop_write+0x6a/0x1a0
[    4.079295]  #2:  (s_active#7){++++.+}, at: [<0000000000354d3e>] kernfs_fop_write+0x76/0x1a0
[    4.079301]  #3:  (devcgroup_mutex){+.+.+.}, at: [<00000000003f3f7e>] devcgroup_access_write+0x46/0x7b8
[    4.079307]  #4:  (rcu_read_lock){......}, at: [<00000000003f3f38>] devcgroup_access_write+0x0/0x7b8


grep RCU .config
# RCU Subsystem
CONFIG_PREEMPT_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TASKS_RCU=y
CONFIG_RCU_STALL_COMMON=y
# CONFIG_TREE_RCU_TRACE is not set
# CONFIG_RCU_EXPEDITE_BOOT is not set
# RCU Debugging
CONFIG_PROVE_RCU=y
# CONFIG_PROVE_RCU_REPEATEDLY is not set
# CONFIG_SPARSE_RCU_POINTER is not set
CONFIG_RCU_TORTURE_TEST=m
# CONFIG_RCU_TORTURE_TEST_SLOW_PREINIT is not set
# CONFIG_RCU_TORTURE_TEST_SLOW_INIT is not set
# CONFIG_RCU_TORTURE_TEST_SLOW_CLEANUP is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=300
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set

Regards,
Sebastian
