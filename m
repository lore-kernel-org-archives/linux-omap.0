From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v2 07/14] OMAP: Introduce dependent voltage domain support.
Date: Thu, 11 Nov 2010 09:06:31 -0800
Message-ID: <87zktfvlgo.fsf@deeprootsystems.com>
References: <1288366708-32302-1-git-send-email-thara@ti.com>
	<1288366708-32302-8-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:50248 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752492Ab0KKRGe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Nov 2010 12:06:34 -0500
Received: by pzk28 with SMTP id 28so442556pzk.19
        for <linux-omap@vger.kernel.org>; Thu, 11 Nov 2010 09:06:34 -0800 (PST)
In-Reply-To: <1288366708-32302-8-git-send-email-thara@ti.com> (Thara
	Gopinath's message of "Fri, 29 Oct 2010 21:08:21 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com

Thara Gopinath <thara@ti.com> writes:

> There could be dependencies between various voltage domains for
> maintaining system performance or hardware limitation reasons
> like VDD<X> should be at voltage v1 when VDD<Y> is at voltage v2.
> This patch introduce dependent vdd information structures in the
> voltage layer which can be used to populate these dependencies
> for a voltage domain. This patch also adds support to scale
> the dependent vdd and the scalable devices belonging to it
> during the scaling of a main vdd through omap_voltage_scale.
>
> Signed-off-by: Thara Gopinath <thara@ti.com>

This patch introduces recursive locking (found by lockdep)

[...]

>  /**
>   * omap_voltage_get_nom_volt() - Gets the current non-auto-compensated voltage
> @@ -1697,6 +1803,8 @@ int omap_voltage_scale(struct voltagedomain *voltdm, unsigned long volt)
>  	int is_volt_scaled = 0;
>  	struct omap_vdd_info *vdd;
>  	struct omap_vdd_dev_list *temp_dev;
> +	struct plist_node *node;
> +	struct omap_vdd_user_list *user;
>  
>  	if (!voltdm || IS_ERR(voltdm)) {
>  		pr_warning("%s: VDD specified does not exist!\n", __func__);
> @@ -1709,6 +1817,17 @@ int omap_voltage_scale(struct voltagedomain *voltdm, unsigned long volt)
>  
>  	curr_volt = omap_voltage_get_nom_volt(voltdm);

Just above here, there is an existing mutex_lock()

> +	/* Find the device requesting the voltage scaling */
> +	node = plist_first(&vdd->user_list);
> +	user = container_of(node, struct omap_vdd_user_list, node);
>
> +	/* calculate the voltages for dependent vdd's */
> +	if (calc_dep_vdd_volt(user->dev, vdd, volt)) {

This function can call omap_voltage_add_request() which will also try to
take the same mutex.

> +		pr_warning("%s: Error in calculating dependent vdd voltages"
> +			"for vdd_%s\n", __func__, voltdm->name);
> +		return -EINVAL;
> +	}
> +
>
>  	if (curr_volt == volt) {
>  		is_volt_scaled = 1;
>  	} else if (curr_volt < volt) {
> @@ -1746,6 +1865,9 @@ int omap_voltage_scale(struct voltagedomain *voltdm, unsigned long volt)
>  
>  	mutex_unlock(&vdd->scaling_mutex);
>  
> +	/* Scale dependent vdds */
> +	scale_dep_vdd(vdd);
> +
>  	return 0;
>  }

Here is the details reported by lockdep.

Kevin

[    2.314270] SmartReflex Class3 initialized
[    2.318634] omap_device: smartreflex.1: new worst case activate latency 0: 30517
[    2.363861] clock: disabling unused clocks to save power
[    2.372070] 
[    2.372070] =============================================
[    2.379272] [ INFO: possible recursive locking detected ]
[    2.384918] 2.6.36-pm-default-09076-g6ad1eb9 #2
[    2.389648] ---------------------------------------------
[    2.395294] swapper/1 is trying to acquire lock:
[    2.400115]  (&vdd->scaling_mutex){+.+.+.}, at: [<c025b138>] omap_voltage_add_request+0x48/0x1a0
[    2.409362] 
[    2.409362] but task is already holding lock:
[    2.415466]  (&vdd->scaling_mutex){+.+.+.}, at: [<c025b2d0>] omap_voltage_scale+0x40/0x26c
[    2.424133] 
[    2.424133] other info that might help us debug this:
[    2.430938] 3 locks held by swapper/1:
[    2.434875]  #0:  (sysdev_drivers_lock){+.+.+.}, at: [<c047d87c>] sysdev_driver_register+0x60/0x114
[    2.444366]  #1:  (&per_cpu(cpu_policy_rwsem, cpu)){+.+.+.}, at: [<c0512bb0>] lock_policy_rwsem_write+0x40/0x94
[    2.454956]  #2:  (&vdd->scaling_mutex){+.+.+.}, at: [<c025b2d0>] omap_voltage_scale+0x40/0x26c
[    2.464080] 
[    2.464111] stack backtrace:
[    2.468688] [<c024d4a0>] (unwind_backtrace+0x0/0xe4) from [<c02b670c>] (__lock_acquire+0xdc8/0x1758)
[    2.478271] [<c02b670c>] (__lock_acquire+0xdc8/0x1758) from [<c02b7170>] (lock_acquire+0xd4/0xf8)
[    2.487548] [<c02b7170>] (lock_acquire+0xd4/0xf8) from [<c05e4de8>] (mutex_lock_nested+0x54/0x320)
[    2.496948] [<c05e4de8>] (mutex_lock_nested+0x54/0x320) from [<c025b138>] (omap_voltage_add_request+0x48/0x1a0)
[    2.507476] [<c025b138>] (omap_voltage_add_request+0x48/0x1a0) from [<c025b388>] (omap_voltage_scale+0xf8/0x26c)
[    2.518127] [<c025b388>] (omap_voltage_scale+0xf8/0x26c) from [<c0267918>] (omap_device_scale+0x108/0x12c)
[    2.528228] [<c0267918>] (omap_device_scale+0x108/0x12c) from [<c026a754>] (omap_target+0x58/0x60)
[    2.537628] [<c026a754>] (omap_target+0x58/0x60) from [<c0512b5c>] (__cpufreq_driver_target+0x4c/0x60)
[    2.547363] [<c0512b5c>] (__cpufreq_driver_target+0x4c/0x60) from [<c05151c8>] (cpufreq_governor_performance+0x20/0x28)
[    2.558654] [<c05151c8>] (cpufreq_governor_performance+0x20/0x28) from [<c0512d28>] (__cpufreq_governor+0xd8/0x12c)
[    2.569549] [<c0512d28>] (__cpufreq_governor+0xd8/0x12c) from [<c0512eb4>] (__cpufreq_set_policy+0x114/0x15c)
[    2.579925] [<c0512eb4>] (__cpufreq_set_policy+0x114/0x15c) from [<c0514288>] (cpufreq_add_dev_interface+0x268/0x2b4)
[    2.591033] [<c0514288>] (cpufreq_add_dev_interface+0x268/0x2b4) from [<c0514790>] (cpufreq_add_dev+0x4bc/0x528)
[    2.601684] [<c0514790>] (cpufreq_add_dev+0x4bc/0x528) from [<c047d8c8>] (sysdev_driver_register+0xac/0x114)
[    2.611968] [<c047d8c8>] (sysdev_driver_register+0xac/0x114) from [<c051380c>] (cpufreq_register_driver+0x8c/0x16c)
[    2.622924] [<c051380c>] (cpufreq_register_driver+0x8c/0x16c) from [<c0246578>] (do_one_initcall+0xcc/0x1a4)
[    2.633209] [<c0246578>] (do_one_initcall+0xcc/0x1a4) from [<c00088e0>] (kernel_init+0x148/0x210)
[    2.642486] [<c00088e0>] (kernel_init+0x148/0x210) from [<c0247cb8>] (kernel_thread_exit+0x0/0x8)
