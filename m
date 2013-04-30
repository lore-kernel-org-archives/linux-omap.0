From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: Latest build results - errors/warnings - lots of them
Date: Tue, 30 Apr 2013 13:04:20 +0200
Message-ID: <201304301304.20650.arnd@arndb.de>
References: <20130430081739.GP14496@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:60081 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752591Ab3D3LE5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Apr 2013 07:04:57 -0400
In-Reply-To: <20130430081739.GP14496@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Nicolas Pitre <nico@fluxnic.net>, Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>

On Tuesday 30 April 2013, Russell King - ARM Linux wrote:
> Latest nightly build of 3.9+my for-next+arm-soc's for-next results in a
> great load of new warnings and errors.  arch/arm/common/mcpm_head.S,
> arch/arm/common/mcpm_platsmp.c, arch/arm/common/vlock.S are the biggest
> source of errors.

Yes, I noticed this but haven't gotten around to prepare a patch. I'll comment
below.

> OMAP stuff needs a serious look at too - much Kconfig madness there
> caused by over-use of select, which then goes on to cause build errors
> because it assumes some stuff is always enabled.

Ack. I have not looked much at randconfig output, but this has certianly
grown worse after CONFIG_ARCH_OMAP has gotten included in ARCH_MULTIPLATFORM

> There's also warnings about of_device_id from include/linux/of_platform.h
> via from arch/arm/kernel/setup.c which feature in all the non-OF builds
> too which need addressing.

Hmm, I did not get that one, but I think that's from arm-soc and I'll
try to fix it up.

>arch/arm/common/mcpm_head.S:39: Error: selected processor does not support ARM mode `ubfx r9,r0,#0,#8'
>arch/arm/common/mcpm_head.S:40: Error: selected processor does not support ARM mode `ubfx r10,r0,#8,#8'
>arch/arm/common/mcpm_head.S:100: Error: selected processor does not support ARM mode `dmb'
>arch/arm/common/mcpm_head.S:115: Error: selected processor does not support ARM mode `dmb'
>arch/arm/common/mcpm_head.S:127: Error: selected processor does not support ARM mode `dmb'
>arch/arm/common/mcpm_head.S:131: Error: selected processor does not support ARM mode `dmb'
>arch/arm/common/mcpm_head.S:138: Error: selected processor does not support ARM mode `dsb'
>arch/arm/common/mcpm_head.S:152: Error: selected processor does not support ARM mode `dmb'
>arch/arm/common/mcpm_head.S:161: Error: selected processor does not support ARM mode `dmb'
>arch/arm/common/mcpm_head.S:175: Error: selected processor does not support ARM mode `dmb'
>arch/arm/common/vlock.S:62: Error: selected processor does not support ARM mode `dmb'
>arch/arm/common/vlock.S:72: Error: selected processor does not support ARM mode `dmb'
>arch/arm/common/vlock.S:72: Error: selected processor does not support ARM mode `dsb'
>arch/arm/common/vlock.S:89: Error: selected processor does not support ARM mode `dmb'
>arch/arm/common/vlock.S:95: Error: selected processor does not support ARM mode `dmb'
>arch/arm/common/vlock.S:95: Error: selected processor does not support ARM mode `dsb'
>arch/arm/common/vlock.S:102: Error: selected processor does not support ARM mode `dmb'
>arch/arm/common/vlock.S:105: Error: selected processor does not support ARM mode `dsb'

Right, the problem here is that the code was never tested with an ARMv6+ARMv7 config.
We can either fix it up by adding

	.arch	armv7-a

in the assembly files, or by doing the same in the Makefile:

AFLAGS_vlock.S += -march=armv7-a
AFLAGS_mcpm_head.S += -march=armv7-a

If you have a preference one way or another I can send you a proper patch,
or you just fix it up in your tree.

>arch/arm/common/mcpm_platsmp.c: In function 'mcpm_secondary_init':
>arch/arm/common/mcpm_platsmp.c:52:2: error: implicit declaration of function 'gic_secondary_init'

This is from a conflict between Nico's patch and Catalin's removal of the
gic_secondary_init function as part of c0114709ed "irqchip: gic: Perform
the gic_secondary_init() call via CPU notifier". I think we can just remove
the call here, but I'm not completely sure if I understand the patch
right.

>arch/arm/mach-imx/hotplug.c: In function 'imx_cpu_die':
>arch/arm/mach-imx/hotplug.c:53:2: error: implicit declaration of function 'cpu_do_idle'
>arch/arm/mach-imx/hotplug.c: In function 'imx_cpu_kill':
>arch/arm/mach-imx/hotplug.c:58:26: error: 'jiffies' undeclared (first use in this function)
>arch/arm/mach-imx/hotplug.c:58:2: error: implicit declaration of function 'msecs_to_jiffies'
>arch/arm/mach-imx/hotplug.c:61:3: error: implicit declaration of function 'time_after'

I've not seen this one before. There are many randconfig problems remaining I fear.

>In file included from arch/arm/include/asm/kvm_host.h:41:0,
>                 from include/linux/kvm_host.h:33,
>                 from kernel/context_tracking.c:18:
>arch/arm/include/asm/kvm_vgic.h:59:11: error: 'CONFIG_KVM_ARM_MAX_VCPUS' undeclared here (not in a function)

I sent a patch last week for this one, and the patch was applied in the
KVM tree.

>drivers/gpu/drm/tilcdc/tilcdc_slave.o:(.data+0x54): multiple definition of `__mod_of_device_table'
>drivers/gpu/drm/tilcdc/tilcdc_tfp410.o:(.data+0x54): first defined here
>drivers/gpu/drm/tilcdc/tilcdc_panel.o:(.data+0x54): multiple definition of `__mod_of_device_table'
>drivers/gpu/drm/tilcdc/tilcdc_tfp410.o:(.data+0x54): first defined here
>drivers/gpu/drm/tilcdc/tilcdc_drv.o:(.data+0x184): multiple definition of `__mod_of_device_table'
>drivers/gpu/drm/tilcdc/tilcdc_tfp410.o:(.data+0x54): first defined here

My patch for this one was applied to the DRM tree.

>drivers/tty/serial/omap-serial.c: In function 'serial_omap_console_write':
>drivers/tty/serial/omap-serial.c:1224:14: error: 'struct uart_port' has no member named 'sysrq'

I haven't seen this one.

>Warnings
>
>warning: (BPCTL) selects NET_CORE which has unmet direct dependencies (NETDEVICES)

I'm not that worried about staging drivers, although I sent a couple of fixes for
other staging bugs I found.

>warning: (UX500_SOC_COMMON) selects PINCTRL_ABX500 which has unmet direct dependencies (PINCTRL && AB8500_CORE)

This seems to be newly introduced and should definitely be fixed soon.

>warning: (VIRTIO_PCI && VIRTIO_MMIO && REMOTEPROC && RPMSG) selects VIRTIO which has unmet direct dependencies (VIRTUALIZATION)

This one has been around forever. I had a patch before but it was never urgent enough, since it's
only a harmless warning in randconfig.


>In file included from arch/arm/mach-imx/hotplug.c:16:0:
>arch/arm/mach-imx/common.h:100:29: warning: 'struct pt_regs' declared inside parameter list
>arch/arm/mach-imx/common.h:100:29: warning: its scope is only this definition or declaration, which is probably not what you want
>arch/arm/mach-imx/common.h:101:29: warning: 'struct pt_regs' declared inside parameter list

I don't know this one.

>kernel/time/tick-sched.c:89:16: warning: 'tick_init_jiffy_update' defined but not used
>kernel/time/tick-sched.c:103:13: warning: 'tick_sched_do_timer' defined but not used
>kernel/time/tick-sched.c:124:13: warning: 'tick_sched_handle' defined but not used
>kernel/profile.c:247:13: warning: 'profile_flip_buffers' defined but not used
>kernel/profile.c:270:13: warning: 'profile_discard_flip_buffers' defined but not used
>kernel/profile.c:334:125: warning: 'profile_cpu_callback' defined but not used
>drivers/staging/csr/io.c:80:12: warning: 'uf_read_proc' used but never defined
>drivers/video/aty/radeon_pm.c:1718:13: warning: 'radeon_reinitialize_M10' defined but not used

I think I made a fix for these before but gave up for now with too many other randconfig
warnings without CONFIG_PROC_FS. Same thing for CONFIG_BUG: I ended up just hard enabling
those.

>crypto/wp512.c: In function 'wp512_process_buffer':
>crypto/wp512.c:987:1: warning: the frame size of 1296 bytes is larger than 1024 bytes

My solution to this one was to slightly enlarge the stack size limit on ARM. There are a couple
of functions that have a stack that is just over 1KB on ARM but just under 1KB on other
architectures.

>drivers/mfd/wm8994-core.c: In function 'wm8994_device_init.clone.1':
>drivers/mfd/wm8994-core.c:408:14: warning: 'patch_regs' may be used uninitialized in this function
>drivers/pinctrl/pinctrl-nomadik.c: In function 'nmk_pmx_enable':
>drivers/pinctrl/pinctrl-nomadik.c:1810:16: warning: 'flags' may be used uninitialized in this function
>drivers/gpu/drm/radeon/r100.c: In function 'r100_bandwidth_update':
>drivers/gpu/drm/radeon/r100.c:3153:50: warning: 'disp_drain_rate.full' may be used uninitialized in this function
>drivers/gpu/drm/radeon/r100.c:3099:63: warning: 'crit_point_ff.full' may be used uninitialized in this function
>drivers/gpu/drm/tegra/dc.c: In function 'tegra_dc_setup_window':
>drivers/gpu/drm/tegra/dc.c:420:12: warning: 'planar' may be used uninitialized in this function
>drivers/gpu/drm/drm_irq.c: In function 'drm_calc_vbltimestamp_from_scanoutpos':
>drivers/gpu/drm/drm_irq.c:587:24: warning: 'mono_time_offset.tv64' may be used uninitialized in this function
>net/wireless/reg.c: In function 'reg_device_uevent':
>net/wireless/reg.c:2271:5: warning: 'alpha2[0]' may be used uninitialized in this function
>net/wireless/reg.c:2271:5: warning: 'alpha2[1]' may be used uninitialized in this function
>net/wireless/nl80211.c: In function '__cfg80211_wdev_from_attrs.clone.61':
>net/wireless/nl80211.c:58:6: warning: 'wdev_id' may be used uninitialized in this function

I have now queued up my patch that removes the bogus "used uninitialized" warnings
we get with gcc-4.7 or later and -Os.

>
>Section mismatch errors
>
>WARNING: arch/arm/mach-tegra/built-in.o(.text+0xb4c): Section mismatch in reference from the function tegra_pmc_parse_dt() to the (unknown reference) .init.rodata:(unknown)
>The function tegra_pmc_parse_dt() references
>the (unknown reference) __initconst (unknown).
>This is often because tegra_pmc_parse_dt lacks a __initconst 
>annotation or the annotation of (unknown) is wrong.

Stupid gcc optimization. I thought this was fixed in gcc. Which version are you using?

	Arnd
