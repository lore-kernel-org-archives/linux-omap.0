From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH] security: device_cgroup: fix RCU lockdep splat
Date: Mon, 31 Aug 2015 15:40:29 -0500
Message-ID: <1441053629-31844-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: James Morris <james.l.morris@oracle.com>
Cc: serge@hallyn.com, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

while booting AM437x device, the following splat
triggered:

[   12.005238] ===============================
[   12.009749] [ INFO: suspicious RCU usage. ]
[   12.014116] 4.2.0-next-20150831 #1154 Not tainted
[   12.019050] -------------------------------
[   12.023408] security/device_cgroup.c:405 device_cgroup:verify_new_ex called without proper synchronization!
[   12.033576] other info that might help us debug this:

[   12.041942] rcu_scheduler_active = 1, debug_locks = 0
[   12.048796] 4 locks held by systemd/1:
[   12.052700]  #0:  (sb_writers#7){.+.+.+}, at: [<c017af84>] __sb_start_write+0x8c/0xb0
[   12.060954]  #1:  (&of->mutex){+.+.+.}, at: [<c01f1600>] kernfs_fop_write+0x50/0x1b8
[   12.069085]  #2:  (s_active#30){++++.+}, at: [<c01f1608>] kernfs_fop_write+0x58/0x1b8
[   12.077310]  #3:  (devcgroup_mutex){+.+...}, at: [<c0317bfc>] devcgroup_access_write+0x20/0x658
[   12.086575] stack backtrace:
[   12.091124] CPU: 0 PID: 1 Comm: systemd Not tainted 4.2.0-next-20150831 #1154
[   12.098609] Hardware name: Generic AM43 (Flattened Device Tree)
[   12.104807] [<c001770c>] (unwind_backtrace) from [<c0013a58>] (show_stack+0x10/0x14)
[   12.112924] [<c0013a58>] (show_stack) from [<c034f014>] (dump_stack+0x84/0x9c)
[   12.120491] [<c034f014>] (dump_stack) from [<c0317a04>] (verify_new_ex+0xc4/0xdc)
[   12.128326] [<c0317a04>] (verify_new_ex) from [<c0317f50>] (devcgroup_access_write+0x374/0x658)
[   12.137426] [<c0317f50>] (devcgroup_access_write) from [<c00d2800>] (cgroup_file_write+0x28/0x1bc)
[   12.146796] [<c00d2800>] (cgroup_file_write) from [<c01f1670>] (kernfs_fop_write+0xc0/0x1b8)
[   12.155620] [<c01f1670>] (kernfs_fop_write) from [<c0177c94>] (__vfs_write+0x1c/0xd8)
[   12.163783] [<c0177c94>] (__vfs_write) from [<c0178594>] (vfs_write+0x90/0x16c)
[   12.171426] [<c0178594>] (vfs_write) from [<c0178db4>] (SyS_write+0x44/0x9c)
[   12.178806] [<c0178db4>] (SyS_write) from [<c000f680>] (ret_fast_syscall+0x0/0x1c)

Fix it by making sure rcu_read_lock() is held
around devcgroup_update_access().

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 security/device_cgroup.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/security/device_cgroup.c b/security/device_cgroup.c
index 73455089feef..0a6316b50357 100644
--- a/security/device_cgroup.c
+++ b/security/device_cgroup.c
@@ -766,8 +766,10 @@ static ssize_t devcgroup_access_write(struct kernfs_open_file *of,
 	int retval;
 
 	mutex_lock(&devcgroup_mutex);
+	rcu_read_lock();
 	retval = devcgroup_update_access(css_to_devcgroup(of_css(of)),
 					 of_cft(of)->private, strstrip(buf));
+	rcu_read_unlock();
 	mutex_unlock(&devcgroup_mutex);
 	return retval ?: nbytes;
 }
-- 
2.5.0
