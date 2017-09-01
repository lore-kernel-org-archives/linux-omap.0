From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v3 4/4] soc: ti: Add pm33xx driver for basic suspend
 support
Date: Fri, 1 Sep 2017 14:55:41 +0200
Message-ID: <20170901125541.GS20634@localhost>
References: <20170725144414.7129-1-d-gerlach@ti.com>
 <20170725144414.7129-5-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170725144414.7129-5-d-gerlach@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <ssantosh@kernel.org>, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Keerthy J <j-keerthy@ti.com>, Johan Hovold <johan@kernel.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Jul 25, 2017 at 09:44:14AM -0500, Dave Gerlach wrote:
> AM335x and AM437x support various low power modes as documented
> in section 8.1.4.3 of the AM335x Technical Reference Manual and
> section 6.4.3 of the AM437x Technical Reference Manual.

> v2->v3:
> * Rename am33xx_pm_prepare_push_sram to am33xx_pm_alloc_sram
> * Add missing of_node_put for mpu node
> * Use dev_err and friends for logging with pm dev.
> * Some general code cleanups.

> +static int am33xx_pm_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	int ret;
> +
> +	if (!of_machine_is_compatible("ti,am33xx") &&
> +	    !of_machine_is_compatible("ti,am43"))
> +		return -ENODEV;
> +
> +	pm_ops = dev->platform_data;
> +	if (!pm_ops) {
> +		dev_err(dev, "PM: Cannot get core PM ops!\n");
> +		return -ENODEV;
> +	}
> +
> +	pm_sram = pm_ops->get_sram_addrs();
> +	if (!pm_sram) {
> +		dev_err(dev, "PM: Cannot get PM asm function addresses!!\n");
> +		return -ENODEV;
> +	}
> +
> +	pm33xx_dev = dev;
> +
> +	ret = am33xx_pm_alloc_sram();
> +	if (ret)
> +		return ret;
> +
> +	ret = am33xx_push_sram_idle();
> +	if (ret)
> +		goto err_free_sram;
> +
> +	m3_ipc = wkup_m3_ipc_get();
> +	if (!m3_ipc) {
> +		dev_dbg(dev, "PM: Cannot get wkup_m3_ipc handle\n");
> +		ret = -EPROBE_DEFER;
> +		goto err_free_sram;
> +	}
> +
> +	am33xx_pm_set_ipc_ops();
> +
> +#ifdef CONFIG_SUSPEND
> +	suspend_set_ops(&am33xx_pm_ops);
> +#endif /* CONFIG_SUSPEND */

I'm still getting the lockdep splat below when suspending after probe
was deferred during boot. Did you look into how this can be avoided?

Thanks,
Johan


======================================================
WARNING: possible circular locking dependency detected
4.13.0-rc7 #7 Not tainted
------------------------------------------------------
pmtest.sh/400 is trying to acquire lock:
 (deferred_probe_work){+.+.+.}, at: [<c014d124>] flush_work+0x30/0x27c

but task is already holding lock:
 (pm_mutex){+.+...}, at: [<c017a9bc>] pm_suspend+0x190/0xc94

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (pm_mutex){+.+...}:
       __mutex_lock+0x80/0x694
       mutex_lock_nested+0x2c/0x34
       suspend_set_ops+0x4c/0x128
       am33xx_pm_probe+0x350/0x454
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
       suspend_devices_and_enter+0xc4/0xec8
       pm_suspend+0x890/0xc94
       state_store+0x80/0xdc
       kobj_attr_store+0x1c/0x28
       sysfs_kf_write+0x5c/0x60
       kernfs_fop_write+0x128/0x254
       __vfs_write+0x38/0x138
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

4 locks held by pmtest.sh/400:
 #0:  (sb_writers#6){.+.+.+}, at: [<c024a88c>] vfs_write+0x160/0x174
 #1:  (&of->mutex){+.+.+.}, at: [<c02c1140>] kernfs_fop_write+0xe4/0x254
 #2:  (s_active#46){.+.+.+}, at: [<c02c1148>] kernfs_fop_write+0xec/0x254
 #3:  (pm_mutex){+.+...}, at: [<c017a9bc>] pm_suspend+0x190/0xc94

stack backtrace:
CPU: 0 PID: 400 Comm: pmtest.sh Not tainted 4.13.0-rc7 #7
Hardware name: Generic AM33XX (Flattened Device Tree)
[<c0111d4c>] (unwind_backtrace) from [<c010e2c4>] (show_stack+0x20/0x24)
[<c010e2c4>] (show_stack) from [<c06b87f4>] (dump_stack+0x24/0x28)
[<c06b87f4>] (dump_stack) from [<c016eed8>] (print_circular_bug+0x20c/0x334)
[<c016eed8>] (print_circular_bug) from [<c01724b8>] (__lock_acquire+0x1be4/0x1bf8)
[<c01724b8>] (__lock_acquire) from [<c0172e58>] (lock_acquire+0x108/0x264)
[<c0172e58>] (lock_acquire) from [<c014d154>] (flush_work+0x60/0x27c)
[<c014d154>] (flush_work) from [<c04a3598>] (wait_for_device_probe+0x24/0xa4)
[<c04a3598>] (wait_for_device_probe) from [<c04b6c20>] (dpm_prepare+0xd0/0x91c)
[<c04b6c20>] (dpm_prepare) from [<c04b7488>] (dpm_suspend_start+0x1c/0x70)
[<c04b7488>] (dpm_suspend_start) from [<c0179a28>] (suspend_devices_and_enter+0xc4/0xec8)
[<c0179a28>] (suspend_devices_and_enter) from [<c017b0bc>] (pm_suspend+0x890/0xc94)
[<c017b0bc>] (pm_suspend) from [<c0178ab0>] (state_store+0x80/0xdc)
[<c0178ab0>] (state_store) from [<c06bc7ec>] (kobj_attr_store+0x1c/0x28)
[<c06bc7ec>] (kobj_attr_store) from [<c02c1e34>] (sysfs_kf_write+0x5c/0x60)
[<c02c1e34>] (sysfs_kf_write) from [<c02c1184>] (kernfs_fop_write+0x128/0x254)
[<c02c1184>] (kernfs_fop_write) from [<c0248fa8>] (__vfs_write+0x38/0x138)
[<c0248fa8>] (__vfs_write) from [<c024a7e0>] (vfs_write+0xb4/0x174)
[<c024a7e0>] (vfs_write) from [<c024b734>] (SyS_write+0x54/0xb0)
[<c024b734>] (SyS_write) from [<c01092a0>] (ret_fast_syscall+0x0/0x1c)
