From: "Rajendra Nayak" <rnayak@ti.com>
Subject: [PATCH 02/02] Kconfig changes
Date: Tue, 10 Jun 2008 12:39:02 +0530
Message-ID: <0a2501c8cac8$dca4ffd0$68bf18ac@ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34416 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751808AbYFJHJL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 10 Jun 2008 03:09:11 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id m5A793MC017251
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 10 Jun 2008 02:09:10 -0500
Received: from a0393137pc (localhost [127.0.0.1])
	by dbdp31.itg.ti.com (8.13.8/8.13.8) with ESMTP id m5A790i9004626
	for <linux-omap@vger.kernel.org>; Tue, 10 Jun 2008 12:39:02 +0530 (IST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Updates the CPUidle Kconfig

Signed-off-by: Rajendra Nayak <rnayak@ti.com>   

---
 arch/arm/Kconfig        |   10 ++++++++++
 drivers/cpuidle/Kconfig |   28 ++++++++++++++++++++++------
 2 files changed, 32 insertions(+), 6 deletions(-)

Index: linux-omap-2.6/arch/arm/Kconfig
===================================================================
--- linux-omap-2.6.orig/arch/arm/Kconfig	2008-06-10 11:43:10.790502713 +0530
+++ linux-omap-2.6/arch/arm/Kconfig	2008-06-10 11:43:38.701604549 +0530
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
--- linux-omap-2.6.orig/drivers/cpuidle/Kconfig	2008-06-10 11:43:10.790502713 +0530
+++ linux-omap-2.6/drivers/cpuidle/Kconfig	2008-06-10 12:06:36.139332151 +0530
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
-	default y
+	default n
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

