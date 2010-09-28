From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [GIT PULL] for testing: OMAP hwmod driver conversions: watchdog, UART, i2c
Date: Tue, 28 Sep 2010 14:35:49 -0700
Message-ID: <87d3rxblfu.fsf@deeprootsystems.com>
References: <8762xpenf8.fsf@deeprootsystems.com>
	<20100928201844.GI3117@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:40493 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753872Ab0I1Vfw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Sep 2010 17:35:52 -0400
Received: by pvg2 with SMTP id 2so28636pvg.19
        for <linux-omap@vger.kernel.org>; Tue, 28 Sep 2010 14:35:51 -0700 (PDT)
In-Reply-To: <20100928201844.GI3117@atomide.com> (Tony Lindgren's message of
	"Tue, 28 Sep 2010 13:18:44 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Charulatha Varadarajan <charu@ti.com>, "Govindraj R." <govindraj.raja@ti.com>

Rajendra,

Tony Lindgren <tony@atomide.com> writes:

> * Kevin Hilman <khilman@deeprootsystems.com> [100928 11:25]:
>> Tony,
>> 
>> The following pull request will bring hwmod driver conversions for
>> watchdog, UART and i2c drivers.  It is based on your omap-for-linus
>> branch.
>> 
>> The i2c driver is waiting for final signoff/ack from the upstream
>> subsystem maintainers, but are otherwise ready to go for broader
>> testing.  After I get the final ack, I will update the branch for a
>> final pull.
>> 
>> In the meantime, I'd like to get them into l-o master (or omap-testing)
>> for broader testing.
>
> Tried pulling it but I'm getting tons of these errors on omap2:
>
> WARNING: at arch/arm/mach-omap2/omap_hwmod.c:1237 _omap_hwmod_idle+0x28/0xd8()
> omap_hwmod: i2c1: idle state can only be entered from enabled state
> Modules linked in:
> [<c0054534>] (unwind_backtrace+0x0/0xec) from [<c008b55c>] (warn_slowpath_common+0x4c/0x64)
> [<c008b55c>] (warn_slowpath_common+0x4c/0x64) from [<c008b5f4>] (warn_slowpath_fmt+0x2c/0x3c)
> [<c008b5f4>] (warn_slowpath_fmt+0x2c/0x3c) from [<c005e2f8>] (_omap_hwmod_idle+0x28/0xd8)
> [<c005e2f8>] (_omap_hwmod_idle+0x28/0xd8) from [<c005e3d0>] (omap_hwmod_idle+0x28/0x38)
> [<c005e3d0>] (omap_hwmod_idle+0x28/0x38) from [<c006bc6c>] (omap_device_idle_hwmods+0x1c/0x34)
> [<c006bc6c>] (omap_device_idle_hwmods+0x1c/0x34) from [<c006bd40>] (_omap_device_deactivate+0x4c/0x154)
> [<c006bd40>] (_omap_device_deactivate+0x4c/0x154) from [<c006c018>] (omap_device_idle+0x44/0x64)
> [<c006c018>] (omap_device_idle+0x44/0x64) from [<c005fbfc>] (omap_pm_runtime_suspend+0x2c/0x50)
> [<c005fbfc>] (omap_pm_runtime_suspend+0x2c/0x50) from [<c0292ecc>] (__pm_runtime_suspend+0x210/0x36c)
> [<c0292ecc>] (__pm_runtime_suspend+0x210/0x36c) from [<c02930c8>] (pm_runtime_suspend+0x20/0x34)
> [<c02930c8>] (pm_runtime_suspend+0x20/0x34) from [<c0293898>] (pm_generic_runtime_idle+0x40/0x48)
> [<c0293898>] (pm_generic_runtime_idle+0x40/0x48) from [<c02927d0>] (__pm_runtime_idle+0x164/0x1a0)
> [<c02927d0>] (__pm_runtime_idle+0x164/0x1a0) from [<c029288c>] (pm_runtime_idle+0x1c/0x30)
> [<c029288c>] (pm_runtime_idle+0x1c/0x30) from [<c028d5cc>] (driver_probe_device+0x168/0x188)
> [<c028d5cc>] (driver_probe_device+0x168/0x188) from [<c028d654>] (__driver_attach+0x68/0x8c)
> [<c028d654>] (__driver_attach+0x68/0x8c) from [<c028cce0>] (bus_for_each_dev+0x44/0x74)
> [<c028cce0>] (bus_for_each_dev+0x44/0x74) from [<c028c610>] (bus_add_driver+0x104/0x294)
> [<c028c610>] (bus_add_driver+0x104/0x294) from [<c028d94c>] (driver_register+0xa8/0x130)
> [<c028d94c>] (driver_register+0xa8/0x130) from [<c004d574>] (do_one_initcall+0xc8/0x1a0)
> [<c004d574>] (do_one_initcall+0xc8/0x1a0) from [<c00085f0>] (kernel_init+0x14c/0x214)
> [<c00085f0>] (kernel_init+0x14c/0x214) from [<c004eca8>] (kernel_thread_exit+0x0/0x8)
>
> This is with the omap2plus_defconfig and after editing cmdline to have console set
> to ttyO2.
>
> Would be nice to have those fixed before we merge it.

Rajendra, can you look into this on OMAP2?  This is happening for Tony
on both n8x0 and 2430sdp.

>> Note this also depends on a handful of patches from my pm-backports
>> branch, most of which you have picked into omap-testing, except for the
>> one I just posted to linux-arm-kernel:
>> 
>>    ARM: add cpu_idle_wait() to support CPUidle on SMP systems.
>> 
>> This one is required now that the default config enables SMP.
>
> I'll apply that into omap-testing branch.

Thanks,

Kevin
