From: "Rajendra Nayak" <rnayak@ti.com>
Subject: [PATCH 03/11] menuconfig updates for cpuidle
Date: Wed, 6 Aug 2008 18:43:48 +0530 (IST)
Message-ID: <42082.192.168.10.89.1218028428.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33598 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753220AbYHFNNy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 6 Aug 2008 09:13:54 -0400
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id m76DDnrk013308
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 6 Aug 2008 08:13:54 -0500
Received: from webmail.ti.com (localhost [127.0.0.1])
	by dlep33.itg.ti.com (8.13.7/8.13.7) with ESMTP id m76DDjB5022915
	for <linux-omap@vger.kernel.org>; Wed, 6 Aug 2008 08:13:47 -0500 (CDT)
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
--- linux-omap-2.6.orig/arch/arm/Kconfig	2008-08-06 18:07:31.000000000 +0530
+++ linux-omap-2.6/arch/arm/Kconfig	2008-08-06 18:09:56.000000000 +0530
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
--- linux-omap-2.6.orig/drivers/cpuidle/Kconfig	2008-08-06 18:07:31.000000000
+0530
+++ linux-omap-2.6/drivers/cpuidle/Kconfig	2008-08-06 18:09:56.000000000 +0530
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


