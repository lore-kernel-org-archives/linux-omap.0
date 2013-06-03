From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH V3] cpuidle: Improve governor Kconfig options
Date: Mon,  3 Jun 2013 16:59:35 +0200
Message-ID: <1370271575-13494-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f175.google.com ([74.125.82.175]:46903 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758231Ab3FCO7i (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Jun 2013 10:59:38 -0400
Received: by mail-we0-f175.google.com with SMTP id t59so691492wes.20
        for <linux-omap@vger.kernel.org>; Mon, 03 Jun 2013 07:59:36 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: rjw@sisk.pl
Cc: swarren@wwwdotorg.org, tony@atomide.com, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org, patches@linaro.org, linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org

Each governor is suitable for different kernel configurations: the menu
governor suits better for a tickless system, while the ladder governor fits
better for a periodic timer tick system.

The Kconfig does not allow to [un]select a governor, thus both are compiled in
the kernel but the init order makes the menu governor to be the last one to be
registered, so becoming the default. The only way to switch back to the ladder
governor is to enable the sysfs governor switch in the kernel command line.

Because it seems nobody complained about this, the menu governor is used by
default most of the time on the system, having both governors is not really
necessary on a tickless system but there isn't a config option to disable one
or another governor.

Create a submenu for cpuidle and add a label for each governor, so we can see
the option in the menu config and enable/disable it.

The governors will be enabled depending on the CONFIG_NO_HZ option:
 - If CONFIG_NO_HZ is set, then the menu governor is selected and the ladder
   governor is optional, defaulting to 'yes'
 - If CONFIG_NO_HZ is not set, then the ladder governor is selected and the
   menu governor is optional, defaulting to 'yes'

Before this patch, the ARCH_NEEDS_CPU_IDLE_COUPLED option was wrongly not
depending on the CPU_IDLE and the Kconfig for OMAP / TEGRA was not checking
this dependency when setting the option.

With this patch, the ARCH_NEEDS_CPU_IDLE_COUPLED has been moved under the
CPU_IDLE option. The dependency has been fixed in the relevant arch's Kconfig.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---

V3:
 - Fixed Kconfig dependency between CPU_IDLE and ARCH_NEEDS_CPU_IDLE_COUPLED
V2:
 - Set default values to 'yes' for the governors

 arch/arm/mach-omap2/Kconfig |    2 +-
 arch/arm/mach-tegra/Kconfig |    2 +-
 drivers/cpuidle/Kconfig     |   16 +++++++---------
 3 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index f49cd51..831e89e 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -83,7 +83,7 @@ config ARCH_OMAP4
 	depends on ARCH_OMAP2PLUS
 	depends on ARCH_MULTI_V7
 	select ARCH_HAS_OPP
-	select ARCH_NEEDS_CPU_IDLE_COUPLED if SMP
+	select ARCH_NEEDS_CPU_IDLE_COUPLED if (SMP && CPU_IDLE)
 	select ARM_CPU_SUSPEND if PM
 	select ARM_ERRATA_720789
 	select ARM_GIC
diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
index 84d72fc..04c6221 100644
--- a/arch/arm/mach-tegra/Kconfig
+++ b/arch/arm/mach-tegra/Kconfig
@@ -23,7 +23,7 @@ menu "NVIDIA Tegra options"
 
 config ARCH_TEGRA_2x_SOC
 	bool "Enable support for Tegra20 family"
-	select ARCH_NEEDS_CPU_IDLE_COUPLED if SMP
+	select ARCH_NEEDS_CPU_IDLE_COUPLED if (SMP && CPU_IDLE)
 	select ARM_ERRATA_720789
 	select ARM_ERRATA_754327 if SMP
 	select ARM_ERRATA_764369 if SMP
diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
index c4cc27e..e997f15 100644
--- a/drivers/cpuidle/Kconfig
+++ b/drivers/cpuidle/Kconfig
@@ -1,7 +1,9 @@
 
-config CPU_IDLE
+menuconfig CPU_IDLE
 	bool "CPU idle PM support"
 	default y if ACPI || PPC_PSERIES
+	select CPU_IDLE_GOV_LADDER if (!NO_HZ && !NO_HZ_IDLE)
+	select CPU_IDLE_GOV_MENU if (NO_HZ || NO_HZ_IDLE)
 	help
 	  CPU idle is a generic framework for supporting software-controlled
 	  idle processor power management.  It includes modular cross-platform
@@ -9,9 +11,10 @@ config CPU_IDLE
 
 	  If you're using an ACPI-enabled platform, you should say Y here.
 
+if CPU_IDLE
+
 config CPU_IDLE_MULTIPLE_DRIVERS
         bool "Support multiple cpuidle drivers"
-        depends on CPU_IDLE
         default n
         help
          Allows the cpuidle framework to use different drivers for each CPU.
@@ -19,24 +22,19 @@ config CPU_IDLE_MULTIPLE_DRIVERS
          states. If unsure say N.
 
 config CPU_IDLE_GOV_LADDER
-	bool
-	depends on CPU_IDLE
+	bool "Ladder governor (for periodic timer tick)"
 	default y
 
 config CPU_IDLE_GOV_MENU
-	bool
-	depends on CPU_IDLE && NO_HZ
+	bool "Menu governor (for tickless system)"
 	default y
 
 config ARCH_NEEDS_CPU_IDLE_COUPLED
 	def_bool n
 
-if CPU_IDLE
-
 config CPU_IDLE_CALXEDA
 	bool "CPU Idle Driver for Calxeda processors"
 	depends on ARCH_HIGHBANK
 	help
 	  Select this to enable cpuidle on Calxeda processors.
-
 endif
-- 
1.7.9.5

