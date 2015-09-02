From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2] security: device_cgroup: fix RCU lockdep splat
Date: Wed, 2 Sep 2015 12:24:50 -0400
Message-ID: <20150902162450.GJ22326@mtj.duckdns.org>
References: <20150902125608.GA8299@saruman.tx.rr.com>
 <1441199548-29633-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1441199548-29633-1-git-send-email-balbi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: James Morris <james.l.morris@oracle.com>, serge@hallyn.com, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: linux-omap@vger.kernel.org

cc'ing Paul.

On Wed, Sep 02, 2015 at 08:12:28AM -0500, Felipe Balbi wrote:
> while booting AM437x device, the following splat
> triggered:
> 
> [   12.005238] ===============================
> [   12.009749] [ INFO: suspicious RCU usage. ]
> [   12.014116] 4.2.0-next-20150831 #1154 Not tainted
> [   12.019050] -------------------------------
> [   12.023408] security/device_cgroup.c:405 device_cgroup:verify_new_ex called without proper synchronization!
...
> [   12.128326] [<c0317a04>] (verify_new_ex) from [<c0317f50>] (devcgroup_access_write+0x374/0x658)
> [   12.137426] [<c0317f50>] (devcgroup_access_write) from [<c00d2800>] (cgroup_file_write+0x28/0x1bc)
> [   12.146796] [<c00d2800>] (cgroup_file_write) from [<c01f1670>] (kernfs_fop_write+0xc0/0x1b8)
> [   12.155620] [<c01f1670>] (kernfs_fop_write) from [<c0177c94>] (__vfs_write+0x1c/0xd8)
> [   12.163783] [<c0177c94>] (__vfs_write) from [<c0178594>] (vfs_write+0x90/0x16c)
> [   12.171426] [<c0178594>] (vfs_write) from [<c0178db4>] (SyS_write+0x44/0x9c)
> [   12.178806] [<c0178db4>] (SyS_write) from [<c000f680>] (ret_fast_syscall+0x0/0x1c)

This shouldn't be happening because devcgroup_access_write() always
grabs devcgroup_mutex.  Looking at the log, the culprit seems to be
f78f5b90c4ff ("rcu: Rename rcu_lockdep_assert() to
RCU_LOCKDEP_WARN()").  It missed the bang for the second test while
inverting it, so adding rcu_read_lock() isn't the right fix here.

Paul, can you please fix it?

Thanks.

-- 
tejun
