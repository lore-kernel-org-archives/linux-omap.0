From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v2 4/5] soc: ti: Add pm33xx driver for basic suspend
 support
Date: Tue, 4 Jul 2017 15:46:24 +0200
Message-ID: <20170704134624.GI27842@localhost>
References: <20170519200438.9502-1-d-gerlach@ti.com>
 <20170519200438.9502-5-d-gerlach@ti.com>
 <20170703165419.GC27842@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170703165419.GC27842@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <ssantosh@kernel.org>, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Keerthy J <j-keerthy@ti.com>
List-Id: linux-omap@vger.kernel.org

On Mon, Jul 03, 2017 at 06:54:19PM +0200, Johan Hovold wrote:
> On Fri, May 19, 2017 at 03:04:37PM -0500, Dave Gerlach wrote:

> > +static int am33xx_pm_probe(struct platform_device *pdev)

> > +#ifdef CONFIG_SUSPEND
> > +	suspend_set_ops(&am33xx_pm_ops);
> > +#endif /* CONFIG_SUSPEND */
> 
> This renders a lockdep splash about a circular locking dependency when
> suspending since we're taking the pm_mutex in suspend_set_ops here, and
> during suspend we flush any deferred probes while already holding the
> mutex:

Here's the full splat against 4.12:

 ======================================================
 WARNING: possible circular locking dependency detected
 4.12.0 #30 Not tainted
 ------------------------------------------------------
 bash/404 is trying to acquire lock:
  (deferred_probe_work){+.+.+.}, at: [<c014cf3c>] flush_work+0x30/0x27c
 
 but task is already holding lock:
  (pm_mutex){+.+...}, at: [<c01792dc>] pm_suspend+0x190/0xc94
 
 which lock already depends on the new lock.
 
 
 the existing dependency chain (in reverse order) is:
 
 -> #1 (pm_mutex){+.+...}:
        __mutex_lock+0x80/0x694
        mutex_lock_nested+0x2c/0x34
        suspend_set_ops+0x4c/0x128
        am33xx_pm_probe+0x1fc/0x3a8
        platform_drv_probe+0x5c/0xc0
        driver_probe_device+0x37c/0x490
        __device_attach_driver+0xac/0x128
        bus_for_each_drv+0x74/0xa8
        __device_attach+0xc4/0x154
        device_initial_probe+0x1c/0x20
        bus_probe_device+0x98/0xa0
        deferred_probe_work_func+0x4c/0xe4
        process_one_work+0x1f4/0x758
        worker_thread+0x1e0/0x514
        kthread+0x128/0x158
        ret_from_fork+0x14/0x24
 
 -> #0 (deferred_probe_work){+.+.+.}:
        lock_acquire+0x108/0x264
        flush_work+0x60/0x27c
        wait_for_device_probe+0x24/0xa4
        dpm_prepare+0xd0/0x91c
        dpm_suspend_start+0x1c/0x70
        suspend_devices_and_enter+0xc4/0xeac
        pm_suspend+0x890/0xc94
        state_store+0x80/0xdc
        kobj_attr_store+0x1c/0x28
        sysfs_kf_write+0x5c/0x60
        kernfs_fop_write+0x128/0x254
        __vfs_write+0x38/0x128
        vfs_write+0xb4/0x174
        SyS_write+0x54/0xb0
        ret_fast_syscall+0x0/0x1c
 
 other info that might help us debug this:
 
  Possible unsafe locking scenario:
 
        CPU0                    CPU1
        ----                    ----
   lock(pm_mutex);
                                lock(deferred_probe_work);
                                lock(pm_mutex);
   lock(deferred_probe_work);
 
  *** DEADLOCK ***
 
 4 locks held by bash/404:
  #0:  (sb_writers#6){.+.+.+}, at: [<c0244fac>] vfs_write+0x160/0x174
  #1:  (&of->mutex){+.+.+.}, at: [<c02bab64>] kernfs_fop_write+0xe4/0x254
  #2:  (s_active#99){.+.+.+}, at: [<c02bab6c>] kernfs_fop_write+0xec/0x254
  #3:  (pm_mutex){+.+...}, at: [<c01792dc>] pm_suspend+0x190/0xc94
 
 stack backtrace:
 CPU: 0 PID: 404 Comm: bash Not tainted 4.12.0 #30
 Hardware name: Generic AM33XX (Flattened Device Tree)
 [<c011192c>] (unwind_backtrace) from [<c010e104>] (show_stack+0x20/0x24)
 [<c010e104>] (show_stack) from [<c03f2da0>] (dump_stack+0x24/0x28)
 [<c03f2da0>] (dump_stack) from [<c016e070>] (print_circular_bug+0x20c/0x334)
 [<c016e070>] (print_circular_bug) from [<c0171660>] (__lock_acquire+0x1bf4/0x1c08)
 [<c0171660>] (__lock_acquire) from [<c0172000>] (lock_acquire+0x108/0x264)
 [<c0172000>] (lock_acquire) from [<c014cf6c>] (flush_work+0x60/0x27c)
 [<c014cf6c>] (flush_work) from [<c04a7524>] (wait_for_device_probe+0x24/0xa4)
 [<c04a7524>] (wait_for_device_probe) from [<c04bae20>] (dpm_prepare+0xd0/0x91c)
 [<c04bae20>] (dpm_prepare) from [<c04bb688>] (dpm_suspend_start+0x1c/0x70)
 [<c04bb688>] (dpm_suspend_start) from [<c0178364>] (suspend_devices_and_enter+0xc4/0xeac)
 [<c0178364>] (suspend_devices_and_enter) from [<c01799dc>] (pm_suspend+0x890/0xc94)
 [<c01799dc>] (pm_suspend) from [<c01773f0>] (state_store+0x80/0xdc)
 [<c01773f0>] (state_store) from [<c03f442c>] (kobj_attr_store+0x1c/0x28)
 [<c03f442c>] (kobj_attr_store) from [<c02bb858>] (sysfs_kf_write+0x5c/0x60)
 [<c02bb858>] (sysfs_kf_write) from [<c02baba8>] (kernfs_fop_write+0x128/0x254)
 [<c02baba8>] (kernfs_fop_write) from [<c0243830>] (__vfs_write+0x38/0x128)
 [<c0243830>] (__vfs_write) from [<c0244f00>] (vfs_write+0xb4/0x174)
 [<c0244f00>] (vfs_write) from [<c0245e08>] (SyS_write+0x54/0xb0)
 [<c0245e08>] (SyS_write) from [<c01092e0>] (ret_fast_syscall+0x0/0x1c)

Johan
