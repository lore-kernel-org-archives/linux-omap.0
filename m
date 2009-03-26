From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: PM branch rebased to 2.6.29
Date: Thu, 26 Mar 2009 10:01:10 -0700
Message-ID: <87prg4i5gp.fsf@deeprootsystems.com>
References: <87bprz9zju.fsf@deeprootsystems.com>
	<200903261754.31577.jpihet@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f118.google.com ([209.85.221.118]:61133 "EHLO
	mail-qy0-f118.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754977AbZCZRBR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Mar 2009 13:01:17 -0400
Received: by qyk16 with SMTP id 16so1171112qyk.33
        for <linux-omap@vger.kernel.org>; Thu, 26 Mar 2009 10:01:15 -0700 (PDT)
In-Reply-To: <200903261754.31577.jpihet@mvista.com> (Jean Pihet's message of "Thu\, 26 Mar 2009 17\:54\:31 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jpihet@mvista.com>
Cc: linux-omap@vger.kernel.org

Jean Pihet <jpihet@mvista.com> writes:

> Hi,
>
> I am having a crash with the latest 2.6.29 pm branch with CPU_FREQ enabled. It 
> looks like clk_set_rate is called recursively, thus deadlocking on the mutex.
>
> Any idea why this worked fine on 2.6.29-rc8 pm?

One of the differences is the new clock notifier patches, which may
have changed the locking, but I haven't dug into this yet so I don't
know if it's a bug in the clock locking or in CPUfreq locking.

Kevin


> Here is the dump excerpt:
> ...
> Disabling unused clock "sys_clkout1"
> BUG: scheduling while atomic: swapper/1/0x00000002
> Modules linked in:
> [<c0032f40>] (dump_stack+0x0/0x14) from [<c0055dcc>] 
> (__schedule_bug+0x54/0x60)
> [<c0055d78>] (__schedule_bug+0x0/0x60) from [<c02e7be4>] (schedule+0x78/0x2bc)
>  r4:c781c000
> [<c02e7b6c>] (schedule+0x0/0x2bc) from [<c02e8b60>] 
> (__mutex_lock_slowpath+0x174/0x290)
> [<c02e89ec>] (__mutex_lock_slowpath+0x0/0x290) from [<c02e8ca4>] 
> (mutex_lock+0x28/0x30)
> [<c02e8c7c>] (mutex_lock+0x0/0x30) from [<c00413b4>] (clk_set_rate+0x2c/0xec)
>  r4:c03ced20
> [<c0041388>] (clk_set_rate+0x0/0xec) from [<c003fc94>] 
> (omap3_select_table_rate+0xd0/0x168)
>  r6:00000004 r5:c03fd474 r4:c03d426c
> [<c003fbc4>] (omap3_select_table_rate+0x0/0x168) from [<c0038d3c>] 
> (omap2_clk_set_rate+0x20/0x24)
>  r6:60000013 r5:20c85580 r4:c03ce41c
> [<c0038d1c>] (omap2_clk_set_rate+0x0/0x24) from [<c0041410>] 
> (clk_set_rate+0x88/0xec)
> [<c0041388>] (clk_set_rate+0x0/0xec) from [<c0013518>] 
> (omap_cpu_init+0xc8/0x108)
>  r6:c03f4b20 r5:c03fddac r4:c7be9be0
> [<c0013450>] (omap_cpu_init+0x0/0x108) from [<c022c3a0>] 
> (cpufreq_add_dev+0x120/0x300)
>  r5:c7be9be0 r4:00000000
> [<c022c280>] (cpufreq_add_dev+0x0/0x300) from [<c01dc130>] 
> (sysdev_driver_register+0xb4/0x124)
>  r8:00000000 r7:00000000 r6:c03f4b20 r5:c03ef708 r4:c03fc95c
> [<c01dc07c>] (sysdev_driver_register+0x0/0x124) from [<c022c214>] 
> (cpufreq_register_driver+0x98/0x104)
>  r6:00000000 r5:c041efac r4:c03d541c
> [<c022c17c>] (cpufreq_register_driver+0x0/0x104) from [<c0013448>] 
> (omap_cpufreq_init+0x14/0x1c)
>  r5:c00266fc r4:c03fc080
> [<c0013434>] (omap_cpufreq_init+0x0/0x1c) from [<c002e2ac>] 
> (__exception_text_end+0x54/0x188)
> [<c002e258>] (__exception_text_end+0x0/0x188) from [<c0008768>] 
> (kernel_init+0x74/0xdc)
> [<c00086f4>] (kernel_init+0x0/0xdc) from [<c005d568>] (do_exit+0x0/0x6b8)
>  r5:00000000 r4:00000000
>
> Regards,
> Jean
>
> On Wednesday 18 March 2009 06:21:09 Kevin Hilman wrote:
>> FYI...
>>
>> The PM branch has now been rebased to today's linux-omap HEAD which is
>> based on v2.6.29-rc8.  The previous PM branch has been renamed to
>> pm-2.6.28.  Depending on when you look, Tony's linux-omap tree may not
>> (yet) have the latest PM branch.  If not, you can use my PM tree[1]
>> directly.  Also, pm-2.6.28 will only be available on my tree.
>>
>> Tested on OMAP3 Beagle and RX51 and was able to hit RET and OFF in
>> suspend and in PM idle with minimal kernel.  No testing yet done for
>> CPUidle or DVFS.  Please test on your hardware and submit results to
>> the list.  Thanks.
>>
>> Kevin
>>
>> --
>>
>> Misc. conflicts/issues resolved after rebase:
>>
>> - no longer safe to use getnstimeofday() in suspend path since timekeeping
>>   subsystem is also suspended in the suspend path.  PM debug timing has
>>   been converted to use sched_clock() which is 32k sync-timer based.
>>
>> - Update board-rx51.c to use common OMAP3 OPPs
>>
>> Known issues:
>>
>> - Beagle: MMC: off-mode needs work in MMC driver, so if you hit off
>>   and have a rootfs on MMC, you're dead.
>>
>> - Beagle: MMC regulator: unbalanced disables.  This happens on boot
>>   and during suspend/resume. I don't think this is related to the PM
>>   branch, but is probably in linux-omap HEAD also, but didn't test.
>>
>> Linux version 2.6.29-rc8-omap1-arm-omap3beagle-default-05653-gd803372-dirty
>> (khilman@vence) (gcc version 4.3.2 (Sourcery G++ Lite 2008q3-66) ) #4
>> PREEMPT Tue Mar 17 21:38:09 PDT 2009 [...]
>> i2c_omap i2c_omap.1: bus 1 rev3.12 at 2600 kHz
>> twl4030: PIH (irq 7) chaining IRQs 368..375
>> twl4030: power (irq 373) chaining IRQs 376..383
>> twl4030: gpio (irq 368) chaining IRQs 384..401
>> beagle_twl_gpio_setup:145
>> twl4030_mmc_init:303
>> twl4030_mmc_init:318
>> regulator: VMMC1: 1850 <--> 3150 mV normal standby
>> regulator: VDAC: 1800 mV normal standby
>> regulator: VUSB1V5: 1500 <--> 0 mV normal standby
>> regulator: VUSB1V8: 1800 <--> 0 mV normal standby
>> regulator: VUSB3V1: 3100 <--> 0 mV normal standby
>> regulator: VSIM: 1800 <--> 3000 mV normal standby
>> [...]
>> mmci-omap-hs mmci-omap-hs.0: Failed to get debounce clock
>> ------------[ cut here ]------------
>> WARNING: at
>> /net/home/khilman/work/kernel/omap/pm/drivers/regulator/core.c:1216
>> regulator_disable+0x64/0x90() unbalanced disables for supply
>> mmci-omap-hs.0-vmmc
>> Modules linked in:
>> [<c02a0830>] (dump_stack+0x0/0x14) from [<c0053af0>]
>> (warn_slowpath+0x6c/0x88) [<c0053a84>] (warn_slowpath+0x0/0x88) from
>> [<c01b8bdc>] (regulator_disable+0x64/0x90) r3:c79dc2a0 r2:c03390cb
>>  r7:c78e8c20 r6:c78aac38 r5:c78e8c20 r4:fffffffb
>> [<c01b8b78>] (regulator_disable+0x0/0x90) from [<c0209400>]
>> (mmc_regulator_set_ocr+0xb0/0xcc) r7:c78e8c20 r6:00000001 r5:00000000
>> r4:00000000
>> [<c0209350>] (mmc_regulator_set_ocr+0x0/0xcc) from [<c003abe8>]
>> (twl_mmc1_set_power+0xc0/0xec) r7:c784f538 r6:00000000 r5:00000000
>> r4:c039185c
>> [<c003ab28>] (twl_mmc1_set_power+0x0/0xec) from [<c0210aa8>]
>> (omap_mmc_set_ios+0x54/0x2b0) r7:c784f538 r6:c784f5c0 r5:c784f400
>> r4:c7844380
>> [<c0210a54>] (omap_mmc_set_ios+0x0/0x2b0) from [<c0208dc8>]
>> (mmc_power_off+0x54/0x58) r7:c784f400 r6:c7910400 r5:00000000 r4:c784f400
>> [<c0208d74>] (mmc_power_off+0x0/0x58) from [<c0209074>]
>> (mmc_start_host+0x14/0x24) [<c0209060>] (mmc_start_host+0x0/0x24) from
>> [<c020a2a0>] (mmc_add_host+0x58/0x64) r5:00000000 r4:c784f400
>> [<c020a248>] (mmc_add_host+0x0/0x64) from [<c001ec00>]
>> (omap_mmc_probe+0x3d0/0x548) r5:c784f5c0 r4:00000000
>> [<c001e830>] (omap_mmc_probe+0x0/0x548) from [<c01dd554>]
>> (platform_drv_probe+0x20/0x24) [<c01dd534>] (platform_drv_probe+0x0/0x24)
>> from [<c01dc740>] (driver_probe_device+0xd4/0x180) [<c01dc66c>]
>> (driver_probe_device+0x0/0x180) from [<c01dc854>]
>> (__driver_attach+0x68/0x8c) r7:c789d140 r6:c038ada4 r5:c7910490 r4:c7910408
>> [<c01dc7ec>] (__driver_attach+0x0/0x8c) from [<c01dbf8c>]
>> (bus_for_each_dev+0x4c/0x80) r7:c789d140 r6:c038ada4 r5:c01dc7ec
>> r4:00000000
>> [<c01dbf40>] (bus_for_each_dev+0x0/0x80) from [<c01dc584>]
>> (driver_attach+0x20/0x28) r6:c038ada4 r5:00000000 r4:00000000
>> [<c01dc564>] (driver_attach+0x0/0x28) from [<c01db868>]
>> (bus_add_driver+0xa8/0x210) [<c01db7c0>] (bus_add_driver+0x0/0x210) from
>> [<c01dca78>] (driver_register+0x98/0x120) r8:00000001 r7:c001e814
>> r6:c038ada4 r5:00000000 r4:c0024a44
>> [<c01dc9e0>] (driver_register+0x0/0x120) from [<c01dd9fc>]
>> (platform_driver_register+0x6c/0x88) r9:00000000 r8:00000001 r7:c001e814
>> r6:00000000 r5:00000000
>> r4:c0024a44
>> [<c01dd990>] (platform_driver_register+0x0/0x88) from [<c001e828>]
>> (omap_mmc_init+0x14/0x1c) [<c001e814>] (omap_mmc_init+0x0/0x1c) from
>> [<c00292ec>] (do_one_initcall+0x5c/0x19c) [<c0029290>]
>> (do_one_initcall+0x0/0x19c) from [<c0008404>] (kernel_init+0x84/0xf8)
>> r8:00000000 r7:00000000 r6:00000000 r5:00000000 r4:c0024a44
>> [<c0008380>] (kernel_init+0x0/0xf8) from [<c0056ea0>] (do_exit+0x0/0x764)
>>  r4:00000000
>> ---[ end trace e339700732a37a4d ]---
>> [.../
>> (none):~# echo 1 > /sys/power/clocks_off_while_idle
>> (none):~# echo mem > /sys/power/state
>> PM: Syncing filesystems ... done.
>> Freezing user space processes ... (elapsed 0.00 seconds) done.
>> Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done.
>> Suspending console(s) (use no_console_suspend to debug)
>> ------------[ cut here ]------------
>> WARNING: at
>> /net/home/khilman/work/kernel/omap/pm/drivers/regulator/core.c:1216
>> regulator_disable+0x64/0x90() unbalanced disables for supply
>> mmci-omap-hs.0-vmmc
>> Modules linked in:
>> [<c02a0830>] (dump_stack+0x0/0x14) from [<c0053af0>]
>> (warn_slowpath+0x6c/0x88) [<c0053a84>] (warn_slowpath+0x0/0x88) from
>> [<c01b8bdc>] (regulator_disable+0x64/0x90) r3:c79dc2a0 r2:c03390cb
>>  r7:c78e8c20 r6:c78aac38 r5:c78e8c20 r4:fffffffb
>> [<c01b8b78>] (regulator_disable+0x0/0x90) from [<c0209400>]
>> (mmc_regulator_set_ocr+0xb0/0xcc) r7:c78e8c20 r6:00000001 r5:00000000
>> r4:00000000
>> [<c0209350>] (mmc_regulator_set_ocr+0x0/0xcc) from [<c003abe8>]
>> (twl_mmc1_set_power+0xc0/0xec) r7:c784f538 r6:00000000 r5:00000000
>> r4:c039185c
>> [<c003ab28>] (twl_mmc1_set_power+0x0/0xec) from [<c0210aa8>]
>> (omap_mmc_set_ios+0x54/0x2b0) r7:c784f538 r6:c784f5c0 r5:c784f400
>> r4:c7844380
>> [<c0210a54>] (omap_mmc_set_ios+0x0/0x2b0) from [<c0208dc8>]
>> (mmc_power_off+0x54/0x58) r7:c7910490 r6:c7910400 r5:a0000013 r4:c784f400
>> [<c0208d74>] (mmc_power_off+0x0/0x58) from [<c02097e0>]
>> (mmc_suspend_host+0x14c/0x154) [<c0209694>] (mmc_suspend_host+0x0/0x154)
>> from [<c02107e0>] (omap_mmc_suspend+0x30/0xe0) r5:c0388a74 r4:c784f5c0
>> [<c02107b0>] (omap_mmc_suspend+0x0/0xe0) from [<c01dd5d4>]
>> (platform_drv_suspend+0x20/0x24) r7:c7910490 r6:c79104b8 r5:c0388a74
>> r4:c0388ba4
>> [<c01dd5b4>] (platform_drv_suspend+0x0/0x24) from [<c01dd6c4>]
>> (platform_pm_suspend+0x50/0x5c) [<c01dd674>] (platform_pm_suspend+0x0/0x5c)
>> from [<c01df9ec>] (pm_op+0x38/0x7c) [<c01df9b4>] (pm_op+0x0/0x7c) from
>> [<c01e0150>] (device_suspend+0x350/0x480) r5:c7910408 r4:c0388ba4
>> [<c01dfe00>] (device_suspend+0x0/0x480) from [<c007d4b8>]
>> (suspend_devices_and_enter+0x44/0x1c4) [<c007d474>]
>> (suspend_devices_and_enter+0x0/0x1c4) from [<c007d7a0>]
>> (enter_state+0x134/0x1b8) r7:c02a5bf4 r6:00000003 r5:c031de6b r4:000072ab
>> [<c007d66c>] (enter_state+0x0/0x1b8) from [<c007d8c0>]
>> (state_store+0x9c/0xc4) r7:c02a5bf4 r6:00000003 r5:00000003 r4:c031de6b
>> [<c007d824>] (state_store+0x0/0xc4) from [<c019329c>]
>> (kobj_attr_store+0x20/0x24) [<c019327c>] (kobj_attr_store+0x0/0x24) from
>> [<c00f7010>] (sysfs_write_file+0x110/0x144) [<c00f6f00>]
>> (sysfs_write_file+0x0/0x144) from [<c00ac7b4>] (vfs_write+0xb8/0x148)
>> [<c00ac6fc>] (vfs_write+0x0/0x148) from [<c00ac908>] (sys_write+0x44/0x70)
>> r7:00000004 r6:c78d3ae0 r5:00000000 r4:00000000
>> [<c00ac8c4>] (sys_write+0x0/0x70) from [<c0029e20>]
>> (ret_fast_syscall+0x0/0x2c) r8:c0029fc8 r7:00000004 r6:401ab5e0 r5:000c3408
>> r4:00000004
>> ---[ end trace e339700732a37a4f ]---
>> Successfully put all powerdomains to target state
>> Restarting tasks ... done.
>>
>> [1]
>> http://git.kernel.org/?p=linux/kernel/git/khilman/linux-omap-pm.git;a=summa
>>ry --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
