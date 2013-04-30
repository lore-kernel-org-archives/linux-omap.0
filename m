From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] ARM: OMAP2+: Fix multiple make randconfig errors if no SoC
 is selected
Date: Tue, 30 Apr 2013 15:04:13 -0700
Message-ID: <20130430220413.GE28721@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:20097 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760775Ab3D3WER (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Apr 2013 18:04:17 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>

If no SoC is selected, we should build in only minimal code
to bring up a new SoC as none of the SoC specific features are
implemented. Otherwise we will get multiple randconfig errors
when no SoC is selected.

Fix this by tagging the SoC dependant code with soc-y in the omap2+
related makefiles as suggested by Arnd Bergmann <arnd@arndb.de>.
Note that we could improve some of the dependencies further by adding
a silent Kconfig entry for SOC_OMAP. But let's do that separately
as that's not needed for the minimal fix.

Without this patch the build errors are something like:

arch/arm/mach-omap2/built-in.o: In function `_add_initiator_dep':
arch/arm/mach-omap2/omap_hwmod.c:691: undefined reference to `clkdm_add_sleepdep'
arch/arm/mach-omap2/built-in.o: In function `_deassert_hardreset':
arch/arm/mach-omap2/omap_hwmod.c:1677: undefined reference to `clkdm_in_hwsup'
arch/arm/mach-omap2/omap_hwmod.c:1678: undefined reference to `clkdm_hwmod_enable'
arch/arm/mach-omap2/omap_hwmod.c:1705: undefined reference to `clkdm_allow_idle'
arch/arm/mach-omap2/omap_hwmod.c:1708: undefined reference to `clkdm_hwmod_disable'
arch/arm/mach-omap2/built-in.o: In function `_enable':
arch/arm/mach-omap2/built-in.o: In function `_enable':
arch/arm/mach-omap2/omap_hwmod.c:2145: undefined reference to `clkdm_in_hwsup'
arch/arm/mach-omap2/omap_hwmod.c:2147: undefined reference to `clkdm_hwmod_enable'
arch/arm/mach-omap2/omap_hwmod.c:2145: undefined reference to `clkdm_missing_idle_reporting'
arch/arm/mach-omap2/omap_hwmod.c:2191: undefined reference to `clkdm_hwmod_disable'
arch/arm/mach-omap2/omap_hwmod.c:2172: undefined reference to `clkdm_allow_idle'
arch/arm/mach-omap2/built-in.o: In function `_del_initiator_dep':
arch/arm/mach-omap2/omap_hwmod.c:720: undefined reference to `clkdm_del_sleepdep'
arch/arm/mach-omap2/built-in.o: In function `_idle':
arch/arm/mach-omap2/omap_hwmod.c:2235: undefined reference to `clkdm_hwmod_disable'
arch/arm/mach-omap2/built-in.o: In function `_shutdown':
arch/arm/mach-omap2/omap_hwmod.c:2338: undefined reference to `clkdm_hwmod_disable'
arch/arm/mach-omap2/built-in.o: In function `omap_hwmod_get_context_loss_count':
arch/arm/mach-omap2/omap_hwmod.c:4071: undefined reference to `pwrdm_get_context_loss_count'
arch/arm/mach-omap2/built-in.o: In function `pm_dbg_show_timers':
arch/arm/mach-omap2/pm-debug.c:155: undefined reference to `pwrdm_for_each'
arch/arm/mach-omap2/built-in.o: In function `pwrdm_dbg_show_timer':
arch/arm/mach-omap2/pm-debug.c:132: undefined reference to `pwrdm_state_switch'
arch/arm/mach-omap2/built-in.o: In function `pm_dbg_show_counters':
arch/arm/mach-omap2/pm-debug.c:147: undefined reference to `pwrdm_for_each'
arch/arm/mach-omap2/pm-debug.c:148: undefined reference to `clkdm_for_each'
arch/arm/mach-omap2/built-in.o: In function `pwrdm_dbg_show_counter':
arch/arm/mach-omap2/pm-debug.c:102: undefined reference to `pwrdm_read_pwrst'
arch/arm/mach-omap2/pm-debug.c:103: undefined reference to `pwrdm_read_pwrst'
arch/arm/mach-omap2/built-in.o: In function `omap2_common_pm_late_init':
arch/arm/mach-omap2/pm.c:294: undefined reference to `omap_voltage_late_init'
arch/arm/mach-omap2/built-in.o: In function `omap_pm_clkdms_setup':
arch/arm/mach-omap2/pm.c:117: undefined reference to `clkdm_sleep'
arch/arm/mach-omap2/pm.c:114: undefined reference to `clkdm_allow_idle'
arch/arm/mach-omap2/built-in.o: In function `omap2_gpio_dev_init':
arch/arm/mach-omap2/gpio.c:133: undefined reference to `pwrdm_can_ever_lose_context'
arch/arm/mach-omap2/built-in.o: In function `omap4_smp_prepare_cpus':
arch/arm/mach-omap2/omap-smp.c:204: undefined reference to `omap_get_wakeupgen_base'
arch/arm/mach-omap2/omap-smp.c:224: undefined reference to `omap_secure_apis_support'
arch/arm/mach-omap2/omap-smp.c:225: undefined reference to `omap_auxcoreboot_addr'
arch/arm/mach-omap2/built-in.o: In function `pm_dbg_init':
arch/arm/mach-omap2/pm-debug.c:272: undefined reference to `pwrdm_for_each'
arch/arm/mach-omap2/built-in.o: In function `omap4_boot_secondary':
arch/arm/mach-omap2/omap-smp.c:80: undefined reference to `omap_get_wakeupgen_base'
arch/arm/mach-omap2/omap-smp.c:94: undefined reference to `omap_secure_apis_support'
arch/arm/mach-omap2/omap-smp.c:140: undefined reference to `clkdm_wakeup'
arch/arm/mach-omap2/omap-smp.c:141: undefined reference to `omap_set_pwrdm_state'
arch/arm/mach-omap2/omap-smp.c:142: undefined reference to `clkdm_allow_idle'
arch/arm/mach-omap2/omap-smp.c:95: undefined reference to `omap_modify_auxcoreboot0'
arch/arm/mach-omap2/omap-smp.c:100: undefined reference to `clkdm_lookup'
arch/arm/mach-omap2/omap-smp.c:101: undefined reference to `pwrdm_lookup'
arch/arm/mach-omap2/built-in.o: In function `omap4_cpu_die':
arch/arm/mach-omap2/omap-hotplug.c:33: undefined reference to `omap_get_wakeupgen_base'
arch/arm/mach-omap2/omap-hotplug.c:38: undefined reference to `omap_secure_apis_support'
arch/arm/mach-omap2/omap-hotplug.c:50: undefined reference to `omap4_hotplug_cpu'
arch/arm/mach-omap2/omap-hotplug.c:52: undefined reference to `omap_secure_apis_support'
arch/arm/mach-omap2/omap-hotplug.c:53: undefined reference to `omap_read_auxcoreboot0'
arch/arm/mach-omap2/omap-hotplug.c:39: undefined reference to `omap_modify_auxcoreboot0'

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -5,8 +5,11 @@
 ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include \
 	-I$(srctree)/arch/arm/plat-omap/include
 
-# Common support
-obj-y := id.o io.o control.o mux.o devices.o fb.o serial.o gpmc.o timer.o pm.o \
+# Always built even if no SoC is selected
+obj-y := id.o control.o
+
+# Built when at least one SoC is selected
+soc-y := io.o mux.o devices.o fb.o serial.o gpmc.o timer.o pm.o \
 	 common.o gpio.o dma.o wd_timer.o display.o i2c.o hdq1w.o omap_hwmod.o \
 	 omap_device.o sram.o
 
@@ -24,7 +27,7 @@ obj-$(CONFIG_SOC_AM33XX) += irq.o $(hwmod-common)
 obj-$(CONFIG_SOC_OMAP5)	 += prm44xx.o $(hwmod-common) $(secure-common)
 
 ifneq ($(CONFIG_SND_OMAP_SOC_MCBSP),)
-obj-y += mcbsp.o
+soc-y += mcbsp.o
 endif
 
 obj-$(CONFIG_TWL4030_CORE) += omap_twl.o
@@ -32,8 +35,8 @@ obj-$(CONFIG_SOC_HAS_OMAP2_SDRC)	+= sdrc.o
 
 # SMP support ONLY available for OMAP4
 
-obj-$(CONFIG_SMP)			+= omap-smp.o omap-headsmp.o
-obj-$(CONFIG_HOTPLUG_CPU)		+= omap-hotplug.o
+soc-$(CONFIG_SMP)			+= omap-smp.o omap-headsmp.o
+soc-$(CONFIG_HOTPLUG_CPU)		+= omap-hotplug.o
 omap-4-5-common				=  omap4-common.o omap-wakeupgen.o \
 					   sleep44xx.o
 obj-$(CONFIG_ARCH_OMAP4)		+= $(omap-4-5-common)
@@ -77,7 +80,7 @@ obj-$(CONFIG_ARCH_OMAP4)		+= opp4xxx_data.o
 endif
 
 # Power Management
-obj-$(CONFIG_OMAP_PM_NOOP)		+= omap-pm-noop.o
+soc-$(CONFIG_OMAP_PM_NOOP)		+= omap-pm-noop.o
 
 ifeq ($(CONFIG_PM),y)
 obj-$(CONFIG_ARCH_OMAP2)		+= pm24xx.o
@@ -85,7 +88,7 @@ obj-$(CONFIG_ARCH_OMAP2)		+= sleep24xx.o
 obj-$(CONFIG_ARCH_OMAP3)		+= pm34xx.o sleep34xx.o
 obj-$(CONFIG_ARCH_OMAP4)		+= pm44xx.o omap-mpuss-lowpower.o
 obj-$(CONFIG_SOC_OMAP5)			+= omap-mpuss-lowpower.o
-obj-$(CONFIG_PM_DEBUG)			+= pm-debug.o
+soc-$(CONFIG_PM_DEBUG)			+= pm-debug.o
 
 obj-$(CONFIG_POWER_AVS_OMAP)		+= sr_device.o
 obj-$(CONFIG_POWER_AVS_OMAP_CLASS3)    += smartreflex-class3.o
@@ -201,7 +204,7 @@ obj-$(CONFIG_ARCH_OMAP4)		+= omap_hwmod_44xx_data.o
 
 # EMU peripherals
 obj-$(CONFIG_OMAP3_EMU)			+= emu.o
-obj-$(CONFIG_HW_PERF_EVENTS)		+= pmu.o
+soc-$(CONFIG_HW_PERF_EVENTS)		+= pmu.o
 
 obj-$(CONFIG_OMAP_MBOX_FWK)		+= mailbox_mach.o
 mailbox_mach-objs			:= mailbox.o
@@ -269,33 +272,40 @@ obj-$(CONFIG_MACH_TI8148EVM)		+= board-ti8168evm.o
 
 omap-flash-$(CONFIG_MTD_NAND_OMAP2)	:= board-flash.o
 omap-flash-$(CONFIG_MTD_ONENAND_OMAP2)	:= board-flash.o
-obj-y					+= $(omap-flash-y) $(omap-flash-m)
+soc-y					+= $(omap-flash-y) $(omap-flash-m)
 
 omap-hsmmc-$(CONFIG_MMC_OMAP_HS)	:= hsmmc.o
 obj-y					+= $(omap-hsmmc-m) $(omap-hsmmc-y)
 
-obj-y					+= usb-musb.o
-obj-y					+= omap_phy_internal.o
+soc-y					+= usb-musb.o
+soc-y					+= omap_phy_internal.o
 
-obj-$(CONFIG_MACH_OMAP2_TUSB6010)	+= usb-tusb6010.o
+soc-$(CONFIG_MACH_OMAP2_TUSB6010)	+= usb-tusb6010.o
 obj-y					+= usb-host.o
 
 onenand-$(CONFIG_MTD_ONENAND_OMAP2)	:= gpmc-onenand.o
-obj-y					+= $(onenand-m) $(onenand-y)
+soc-y					+= $(onenand-m) $(onenand-y)
 
 nand-$(CONFIG_MTD_NAND_OMAP2)		:= gpmc-nand.o
-obj-y					+= $(nand-m) $(nand-y)
+soc-y					+= $(nand-m) $(nand-y)
 
 smc91x-$(CONFIG_SMC91X)			:= gpmc-smc91x.o
-obj-y					+= $(smc91x-m) $(smc91x-y)
+soc-y					+= $(smc91x-m) $(smc91x-y)
 
 smsc911x-$(CONFIG_SMSC911X)		:= gpmc-smsc911x.o
-obj-y					+= $(smsc911x-m) $(smsc911x-y)
+soc-y					+= $(smsc911x-m) $(smsc911x-y)
 ifneq ($(CONFIG_HWSPINLOCK_OMAP),)
-obj-y					+= hwspinlock.o
+soc-y					+= hwspinlock.o
 endif
 
 emac-$(CONFIG_TI_DAVINCI_EMAC)		:= am35xx-emac.o
-obj-y					+= $(emac-m) $(emac-y)
+soc-y					+= $(emac-m) $(emac-y)
+
+soc-y					+= common-board-devices.o twl-common.o dss-common.o
 
-obj-y					+= common-board-devices.o twl-common.o dss-common.o
+# SoC dependant objects
+obj-$(CONFIG_ARCH_OMAP2)		+= $(soc-y)
+obj-$(CONFIG_ARCH_OMAP3)		+= $(soc-y)
+obj-$(CONFIG_ARCH_OMAP4)		+= $(soc-y)
+obj-$(CONFIG_SOC_AM33XX)		+= $(soc-y)
+obj-$(CONFIG_SOC_OMAP5)			+= $(soc-y)
--- a/arch/arm/plat-omap/Makefile
+++ b/arch/arm/plat-omap/Makefile
@@ -4,19 +4,23 @@
 
 ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/arch/arm/plat-omap/include
 
-# Common support
-obj-y := sram.o dma.o counter_32k.o
-obj-m :=
-obj-n :=
-obj-  :=
+# Always built even if no SoC is selected
+obj-y := dma.o
+# Built when at least one SoC is selected
+soc-y := sram.o counter_32k.o
 
-# omap_device support (OMAP2+ only at the moment)
-
-obj-$(CONFIG_OMAP_DM_TIMER) += dmtimer.o
-obj-$(CONFIG_OMAP_DEBUG_LEDS) += debug-leds.o
+soc-$(CONFIG_OMAP_DM_TIMER) += dmtimer.o
+soc-$(CONFIG_OMAP_DEBUG_LEDS) += debug-leds.o
 i2c-omap-$(CONFIG_I2C_OMAP) := i2c.o
-obj-y += $(i2c-omap-m) $(i2c-omap-y)
+soc-y += $(i2c-omap-m) $(i2c-omap-y)
 
 # OMAP mailbox framework
 obj-$(CONFIG_OMAP_MBOX_FWK) += mailbox.o
 
+# SoC dependant objects
+obj-$(CONFIG_ARCH_OMAP1)	+= $(soc-y)
+obj-$(CONFIG_ARCH_OMAP2)	+= $(soc-y)
+obj-$(CONFIG_ARCH_OMAP3)	+= $(soc-y)
+obj-$(CONFIG_ARCH_OMAP4)	+= $(soc-y)
+obj-$(CONFIG_SOC_AM33XX)	+= $(soc-y)
+obj-$(CONFIG_SOC_OMAP5)		+= $(soc-y)
