From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] ARM: OMAP2+: Fix multiple randconfig errors if no SoC is
 selected, take3
Date: Fri, 17 May 2013 14:03:17 -0700
Message-ID: <20130517210317.GB10378@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:15638 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755442Ab3EQVDV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 May 2013 17:03:21 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Rob Herring <rob.herring@calxeda.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>

If no SoC is selected, we should not build any of the SoC support
code for omap2+. Otherwise we can get multiple errors with make
randconfig.

Based on the mailing list discussions we came to the conclusion that
this is best fixed with a combination of Makefile and Kconfig changes.

Some issues are best fixed by selecting objects in Makefile based on
a combination of features and SoC as suggested by Arnd Bergman and
done in commit 572b16db7 (ARM: OMAP: build SMP code only for OMAP4/5).

For the SoC related code, we should not build any of the dependant
features though. This is best done by making the SoC dependant
features depend on at least one SoC being selected as done in
this patch.

The minimal fix is to select the existing config ARCH_OMAP only if a SoC
is selected, and then build the SoC dependant objects only if config
ARCH_OMAP is selected. While at it, we can also change ARCH_OMAP2
to a menuconfig which allows us to drop the now unnecessary menu entry.

For reference, the build errors without this patch are something like:

arch/arm/mach-omap2/built-in.o: In function `_add_initiator_dep':
arch/arm/mach-omap2/omap_hwmod.c:691: undefined reference to `clkdm_add_sleepdep'
arch/arm/mach-omap2/built-in.o: In function `_deassert_hardreset':
arch/arm/mach-omap2/omap_hwmod.c:1677: undefined reference to `clkdm_in_hwsup'
arch/arm/mach-omap2/omap_hwmod.c:1678: undefined reference to `clkdm_hwmod_enable'
arch/arm/mach-omap2/omap_hwmod.c:1705: undefined reference to `clkdm_allow_idle'
arch/arm/mach-omap2/omap_hwmod.c:1708: undefined reference to `clkdm_hwmod_disable'
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
arch/arm/mach-omap2/built-in.o: In function `pm_dbg_init':
arch/arm/mach-omap2/pm-debug.c:272: undefined reference to `pwrdm_for_each'

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>
Signed-off-by: Tony Lindgren <tony@atomide.com>

---

Here's a combined Kconfig + Makefile fix for this. I've tried to keep it
as minimal as possible as I'd like to get this fix merged as a fix.
That is unless you guys think it's too intrusive for the -rc series.


diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index f49cd51..b6eb91d 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -1,11 +1,10 @@
 config ARCH_OMAP
 	bool
 
-config ARCH_OMAP2PLUS
+menuconfig ARCH_OMAP2PLUS
 	bool "TI OMAP2/3/4/5 SoCs with device tree support" if (ARCH_MULTI_V6 || ARCH_MULTI_V7)
 	select ARCH_HAS_CPUFREQ
 	select ARCH_HAS_HOLES_MEMORYMODEL
-	select ARCH_OMAP
 	select ARCH_REQUIRE_GPIOLIB
 	select CLKDEV_LOOKUP
 	select CLKSRC_MMIO
@@ -24,8 +23,6 @@ config ARCH_OMAP2PLUS
 
 if ARCH_OMAP2PLUS
 
-menu "TI OMAP2/3/4 Specific Features"
-
 config ARCH_OMAP2PLUS_TYPICAL
 	bool "Typical OMAP configuration"
 	default y
@@ -45,6 +42,7 @@ config ARCH_OMAP2PLUS_TYPICAL
 
 config SOC_HAS_OMAP2_SDRC
 	bool "OMAP2 SDRAM Controller support"
+	depends on ARCH_OMAP
 
 config SOC_HAS_REALTIME_COUNTER
 	bool "Real time free running counter"
@@ -57,6 +55,7 @@ config ARCH_OMAP2
 	depends on ARCH_MULTI_V6
 	default y
 	select CPU_V6
+	select ARCH_OMAP
 	select MULTI_IRQ_HANDLER
 	select SOC_HAS_OMAP2_SDRC
 	select COMMON_CLK
@@ -69,6 +68,7 @@ config ARCH_OMAP3
 	select ARCH_HAS_OPP
 	select ARM_CPU_SUSPEND if PM
 	select CPU_V7
+	select ARCH_OMAP
 	select MULTI_IRQ_HANDLER
 	select OMAP_INTERCONNECT
 	select PM_OPP if PM
@@ -89,6 +89,7 @@ config ARCH_OMAP4
 	select ARM_GIC
 	select CACHE_L2X0
 	select CPU_V7
+	select ARCH_OMAP
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if LOCAL_TIMERS
 	select HAVE_SMP
@@ -109,6 +110,7 @@ config SOC_OMAP5
 	select ARM_CPU_SUSPEND if PM
 	select ARM_GIC
 	select CPU_V7
+	select ARCH_OMAP
 	select HAVE_SMP
 	select COMMON_CLK
 	select HAVE_ARM_ARCH_TIMER
@@ -146,6 +148,7 @@ config SOC_AM33XX
 	default y
 	select ARM_CPU_SUSPEND if PM
 	select CPU_V7
+	select ARCH_OMAP
 	select MULTI_IRQ_HANDLER
 	select COMMON_CLK
 
@@ -435,6 +438,5 @@ config OMAP4_ERRATA_I688
 	  In MPU case, L3 T2ASYNC FIFO and DDR T2ASYNC FIFO needs to be drained.
 	  IO barrier ensure that there is no synchronisation loss on initiators
 	  operating on both interconnect port simultaneously.
-endmenu
 
 endif
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 55a9d67..a0e0251 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -6,7 +6,7 @@ ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include \
 	-I$(srctree)/arch/arm/plat-omap/include
 
 # Common support
-obj-y := id.o io.o control.o mux.o devices.o fb.o serial.o gpmc.o timer.o pm.o \
+soc-y := id.o io.o control.o mux.o devices.o fb.o serial.o gpmc.o timer.o pm.o \
 	 common.o gpio.o dma.o wd_timer.o display.o i2c.o hdq1w.o omap_hwmod.o \
 	 omap_device.o sram.o
 
@@ -85,7 +85,8 @@ obj-$(CONFIG_ARCH_OMAP2)		+= sleep24xx.o
 obj-$(CONFIG_ARCH_OMAP3)		+= pm34xx.o sleep34xx.o
 obj-$(CONFIG_ARCH_OMAP4)		+= pm44xx.o omap-mpuss-lowpower.o
 obj-$(CONFIG_SOC_OMAP5)			+= omap-mpuss-lowpower.o
-obj-$(CONFIG_PM_DEBUG)			+= pm-debug.o
+pm-$(CONFIG_ARCH_OMAP)			+= pm-debug.o
+obj-$(CONFIG_PM_DEBUG)			+= $(pm-y)
 
 obj-$(CONFIG_POWER_AVS_OMAP)		+= sr_device.o
 obj-$(CONFIG_POWER_AVS_OMAP_CLASS3)    += smartreflex-class3.o
@@ -201,7 +202,8 @@ obj-$(CONFIG_ARCH_OMAP4)		+= omap_hwmod_44xx_data.o
 
 # EMU peripherals
 obj-$(CONFIG_OMAP3_EMU)			+= emu.o
-obj-$(CONFIG_HW_PERF_EVENTS)		+= pmu.o
+pmu-$(CONFIG_ARCH_OMAP)			+= pmu.o
+obj-$(CONFIG_HW_PERF_EVENTS)		+= $(pmu-y)
 
 obj-$(CONFIG_OMAP_MBOX_FWK)		+= mailbox_mach.o
 mailbox_mach-objs			:= mailbox.o
@@ -266,28 +268,28 @@ obj-$(CONFIG_MACH_TI8148EVM)		+= board-ti8168evm.o
 
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
 
 obj-$(CONFIG_MACH_OMAP2_TUSB6010)	+= usb-tusb6010.o
-obj-y					+= usb-host.o
+soc-y					+= usb-host.o
 
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
 obj-y					+= hwspinlock.o
 endif
@@ -295,4 +297,7 @@ endif
 emac-$(CONFIG_TI_DAVINCI_EMAC)		:= am35xx-emac.o
 obj-y					+= $(emac-m) $(emac-y)
 
-obj-y					+= common-board-devices.o twl-common.o dss-common.o
+soc-y					+= common-board-devices.o twl-common.o dss-common.o
+
+# SoC dependant objects
+obj-$(CONFIG_ARCH_OMAP)			+= $(soc-y)
