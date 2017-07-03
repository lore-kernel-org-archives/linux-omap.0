From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v2 4/5] soc: ti: Add pm33xx driver for basic suspend
 support
Date: Mon, 3 Jul 2017 18:54:19 +0200
Message-ID: <20170703165419.GC27842@localhost>
References: <20170519200438.9502-1-d-gerlach@ti.com>
 <20170519200438.9502-5-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170519200438.9502-5-d-gerlach@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <ssantosh@kernel.org>, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Keerthy J <j-keerthy@ti.com>
List-Id: linux-omap@vger.kernel.org

On Fri, May 19, 2017 at 03:04:37PM -0500, Dave Gerlach wrote:
> AM335x and AM437x support various low power modes as documented
> in section 8.1.4.3 of the AM335x Technical Reference Manual and
> section 6.4.3 of the AM437x Technical Reference Manual.
> 
> DeepSleep0 mode offers the lowest power mode with limited
> wakeup sources without a system reboot and is mapped as
> the suspend state in the kernel. In this state, MPU and
> PER domains are turned off with the internal RAM held in
> retention to facilitate the resume process. As part of
> the boot process, the assembly code is copied over to OCMCRAM
> so it can be executed to turn of the EMIF and put DDR into self
> refresh.
> 
> Both platforms have a Cortex-M3 (WKUP_M3) which assists the MPU
> in DeepSleep0 entry and exit. WKUP_M3 takes care
> of the clockdomain and powerdomain transitions based on the
> intended low power state. MPU needs to load the appropriate
> WKUP_M3 binary onto the WKUP_M3 memory space before it can
> leverage any of the PM features like DeepSleep. This loading
> is handled by the remoteproc driver wkup_m3_rproc.
> 
> Communication with the WKUP_M3 is handled by a wkup_m3_ipc
> driver that exposes the specific PM functionality to be used
> the PM code.

> +static void am33xx_pm_free_sram(void)
> +{
> +	gen_pool_free(sram_pool, ocmcram_location, *pm_sram->do_wfi_sz);
> +	gen_pool_free(sram_pool_data, ocmcram_location_data,
> +		      sizeof(struct am33xx_pm_ro_sram_data));
> +}
> +
> +/*
> + * Push the minimal suspend-resume code to SRAM
> + */
> +static int am33xx_prepare_push_sram_idle(void)
> +{
> +	struct device_node *np;
> +
> +	np = of_find_compatible_node(NULL, NULL, "ti,omap3-mpu");
> +

Stray newline.

> +	if (!np) {
> +		np = of_find_compatible_node(NULL, NULL, "ti,omap4-mpu");
> +		if (!np) {
> +			pr_warn("PM: %s: Unable to find device node for mpu\n",
> +				__func__);
> +			return -ENODEV;
> +		}
> +	}

You never put the reference to np you acquire here.

[snip] 

> +static int am33xx_push_sram_idle(void)
> +{
> +	struct am33xx_pm_ro_sram_data ro_sram_data;
> +	int ret;
> +	void *copy_addr;
> +
> +	ro_sram_data.amx3_pm_sram_data_virt = ocmcram_location_data;
> +	ro_sram_data.amx3_pm_sram_data_phys =
> +		gen_pool_virt_to_phys(sram_pool_data, ocmcram_location_data);
> +
> +	/* Save physical address to calculate resume offset during pm init */
> +	am33xx_do_wfi_sram_phys = gen_pool_virt_to_phys(sram_pool,
> +							ocmcram_location);
> +
> +	am33xx_do_wfi_sram = sram_exec_copy(sram_pool, (void *)ocmcram_location,
> +					    pm_sram->do_wfi,
> +					    *pm_sram->do_wfi_sz);
> +	if (!am33xx_do_wfi_sram) {
> +		pr_err("PM: %s: am33xx_do_wfi copy to sram failed\n", __func__);
> +		return -ENODEV;
> +	}
> +
> +	ret = ti_emif_copy_pm_function_table(sram_pool,
> +			(void *)sram_suspend_address((unsigned long)pm_sram->emif_sram_table));
> +	if (ret) {
> +		pr_warn("PM: %s: EMIF function copy failed\n", __func__);
> +		return -EPROBE_DEFER;
> +	}

Here's the dependency to the emif device I commented on earlier (and
below).

> +
> +	copy_addr = sram_exec_copy(sram_pool,
> +			(void *)sram_suspend_address((unsigned long)pm_sram->ro_sram_data),
> +			&ro_sram_data,
> +			sizeof(ro_sram_data));
> +	if (!copy_addr) {
> +		pr_err("PM: %s: ro_sram_data copy to sram failed\n", __func__);
> +		return -ENODEV;
> +	}
> +
> +	return 0;
> +}
> +
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
> +		pr_err("PM: Cannot get core PM ops!\n");
> +		return -ENODEV;
> +	}
> +
> +	pm_sram = pm_ops->get_sram_addrs();
> +	if (!pm_sram) {
> +		pr_err("PM: Cannot get PM asm function addresses!!\n");
> +		return -ENODEV;
> +	}
> +
> +	ret = am33xx_prepare_push_sram_idle();

Perhaps calling this one am33xx_pm_alloc_sram() would be more
descriptive (and match the release function)?

> +	if (ret)
> +		return ret;
> +
> +	ret = am33xx_push_sram_idle();
> +	if (ret)
> +		goto err_free_sram;

As I mentioned in my comments to the emif-sram driver, you may need to
create device link to the emif-sram device to prevent it from going away
under you here.

> +
> +	m3_ipc = wkup_m3_ipc_get();
> +	if (!m3_ipc) {
> +		pr_err("PM: Cannot get wkup_m3_ipc handle\n");

You shouldn't log this as an error when probe is being deferred. 

Why not use dev_err and friends for logging now that you have a struct
device?

And similarly to the emif-sram device, you may need to create a
device-link also to the ipc device to prevent its driver from being
unbound.

> +		ret = -EPROBE_DEFER;
> +		goto err_free_sram;
> +	}
> +
> +	am33xx_pm_set_ipc_ops();
> +
> +#ifdef CONFIG_SUSPEND
> +	suspend_set_ops(&am33xx_pm_ops);
> +#endif /* CONFIG_SUSPEND */

This renders a lockdep splash about a circular locking dependency when
suspending since we're taking the pm_mutex in suspend_set_ops here, and
during suspend we flush any deferred probes while already holding the
mutex:

 ======================================================
 WARNING: possible circular locking dependency detected
 4.12.0-rc7 #11 Not tainted
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

Johan
