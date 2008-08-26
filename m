From: "Rajendra Nayak" <rnayak@ti.com>
Subject: [PATCH 06/06] Enable CPUidle on OMAP architectures
Date: Tue, 26 Aug 2008 18:36:15 +0530 (IST)
Message-ID: <34978.192.168.10.89.1219755975.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41316 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753699AbYHZNGV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Aug 2008 09:06:21 -0400
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id m7QD6FdQ006622
	for <linux-omap@vger.kernel.org>; Tue, 26 Aug 2008 08:06:20 -0500
Received: from webmail.ti.com (localhost [127.0.0.1])
	by dlep33.itg.ti.com (8.13.7/8.13.7) with ESMTP id m7QD6Dam022524
	for <linux-omap@vger.kernel.org>; Tue, 26 Aug 2008 08:06:14 -0500 (CDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Enable support for CPUidle on OMAP architectures.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>

---
 arch/arm/Kconfig |   10 ++++++++++
 1 files changed, 10 insertions(+)

Index: linux-omap-2.6/arch/arm/Kconfig
===================================================================
--- linux-omap-2.6.orig/arch/arm/Kconfig	2008-08-26 12:25:24.000000000 +0530
+++ linux-omap-2.6/arch/arm/Kconfig	2008-08-26 14:32:35.000000000 +0530
@@ -1000,6 +1000,16 @@ config ATAGS_PROC

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


