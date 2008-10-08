From: "Rajendra Nayak" <rnayak@ti.com>
Subject: [PATCH 05/05] OMAP3: Enables CPUidle on OMAP
Date: Wed, 8 Oct 2008 17:31:42 +0530
Message-ID: <001b01c9293d$a0cec8a0$LocalHost@wipultra1382>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37195 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754497AbYJHMBv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Oct 2008 08:01:51 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: 'Kevin Hilman' <khilman@deeprootsystems.com>

Enables CPUidle for OMAP architectures

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/Kconfig |   10 ++++++++++
 1 files changed, 10 insertions(+)

Index: linux-omap-2.6/arch/arm/Kconfig
===================================================================
--- linux-omap-2.6.orig/arch/arm/Kconfig	2008-09-09 11:29:35.000000000 +0530
+++ linux-omap-2.6/arch/arm/Kconfig	2008-10-08 13:56:06.000000000 +0530
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

