From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 07/29] menuconfig updates for cpuidle
Date: Thu, 11 Sep 2008 15:33:51 +0300
Message-ID: <1221136453-16697-7-git-send-email-khilman@deeprootsystems.com>
References: <87iqt2amoi.fsf@deeprootsystems.com>
 <1221136453-16697-1-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-2-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-3-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-4-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-5-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-6-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:48462 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755234AbYIKMeb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Sep 2008 08:34:31 -0400
In-Reply-To: <1221136453-16697-6-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Rajendra Nayak <rnayak@ti.com>

From: Rajendra Nayak <rnayak@ti.com>

This patch enables the cpuidle option in menuconfig
and selects the menu governor
---
 arch/arm/Kconfig        |   10 ++++++++++
 drivers/cpuidle/Kconfig |   26 +++++++++++++++++++++-----
 2 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index aa475d9..a365bfc 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1005,6 +1005,16 @@ config ATAGS_PROC
 
 endmenu
 
+if (ARCH_OMAP)
+
+menu "CPUIdle"
+
+source "drivers/cpuidle/Kconfig"
+
+endmenu
+
+endif
+
 if (ARCH_SA1100 || ARCH_INTEGRATOR || ARCH_OMAP || ARCH_IMX || ARCH_PXA)
 
 menu "CPU Frequency scaling"
diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
index 7dbc4a8..e27bb34 100644
--- a/drivers/cpuidle/Kconfig
+++ b/drivers/cpuidle/Kconfig
@@ -1,20 +1,36 @@
+menu "CPU idle PM support"
 
 config CPU_IDLE
 	bool "CPU idle PM support"
-	default ACPI
+	default n
 	help
 	  CPU idle is a generic framework for supporting software-controlled
 	  idle processor power management.  It includes modular cross-platform
 	  governors that can be swapped during runtime.
 
-	  If you're using an ACPI-enabled platform, you should say Y here.
+	  If you're using a mobile platform that supports CPU idle PM (e.g.
+	  an ACPI-capable notebook), you should say Y here.
+
+if CPU_IDLE
+
+comment "Governors"
 
 config CPU_IDLE_GOV_LADDER
-	bool
+	bool "ladder"
 	depends on CPU_IDLE
-	default y
+	default n
 
 config CPU_IDLE_GOV_MENU
-	bool
+	bool "menu"
 	depends on CPU_IDLE && NO_HZ
 	default y
+        help
+	  This cpuidle governor evaluates all available states and chooses the
+	  deepest state that meets all of the following constraints: BM activity,
+	  expected time until next timer interrupt, and last break event time
+	  delta.  It is designed to minimize power consumption.  Currently
+	  dynticks is required.
+
+endif   # CPU_IDLE
+
+endmenu
-- 
1.6.0

