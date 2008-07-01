From: "Rajendra Nayak" <rnayak@ti.com>
Subject: [PATCH 03/11] menuconfig updates for cpuidle
Date: Tue, 1 Jul 2008 19:46:12 +0530
Message-ID: <004001c8db85$042cd740$68bf18ac@ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from calf.ext.ti.com ([198.47.26.144]:58708 "EHLO calf.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758982AbYGAOQT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 1 Jul 2008 10:16:19 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by calf.ext.ti.com (8.13.7/8.13.7) with ESMTP id m61EGDjC026416
	for <linux-omap@vger.kernel.org>; Tue, 1 Jul 2008 09:16:18 -0500
Received: from a0393137pc (localhost [127.0.0.1])
	by dbdp31.itg.ti.com (8.13.8/8.13.8) with ESMTP id m61EG7uo011322
	for <linux-omap@vger.kernel.org>; Tue, 1 Jul 2008 19:46:12 +0530 (IST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This patch enables the cpuidle option in menuconfig
and selects the menu governor

Signed-off-by: Rajendra Nayak <rnayak@ti.com>

---
 arch/arm/Kconfig        |   10 ++++++++++
 drivers/cpuidle/Kconfig |   26 +++++++++++++++++++++-----
 2 files changed, 31 insertions(+), 5 deletions(-)

Index: linux-omap-2.6/arch/arm/Kconfig
===================================================================
--- linux-omap-2.6.orig/arch/arm/Kconfig	2008-07-01 13:57:04.791784457 +0530
+++ linux-omap-2.6/arch/arm/Kconfig	2008-07-01 13:57:08.862654131 +0530
@@ -954,6 +954,16 @@ config ATAGS_PROC
 
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
Index: linux-omap-2.6/drivers/cpuidle/Kconfig
===================================================================
--- linux-omap-2.6.orig/drivers/cpuidle/Kconfig	2008-07-01 13:57:04.791784457 +0530
+++ linux-omap-2.6/drivers/cpuidle/Kconfig	2008-07-01 13:57:08.863654099 +0530
@@ -1,20 +1,36 @@
+menu "CPU idle PM support"
 
 config CPU_IDLE
 	bool "CPU idle PM support"
-	default ACPI
+	default y
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

