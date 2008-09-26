From: "Rajendra Nayak" <rnayak@ti.com>
Subject: [PATCH 01/16] OMAP3: Adds missing CM offset defs
Date: Fri, 26 Sep 2008 17:47:27 +0530
Message-ID: <01f201c91fd1$d78a97e0$LocalHost@wipultra1382>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52895 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751651AbYIZMRh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Sep 2008 08:17:37 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: 'Kevin Hilman' <khilman@deeprootsystems.com>

This is a *temp* patch needed only till the clock patches 
which add additional offset defs from Paul W are in pm-1

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/cm.h |    2 ++
 1 files changed, 2 insertions(+)

Index: linux-omap-2.6/arch/arm/mach-omap2/cm.h
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/cm.h	2008-09-25 16:26:59.000000000 +0530
+++ linux-omap-2.6/arch/arm/mach-omap2/cm.h	2008-09-25 16:27:12.000000000 +0530
@@ -36,6 +36,8 @@
 #define OMAP3430_CM_CLKOUT_CTRL						\
 				OMAP34XX_CM_REGADDR(OMAP3430_CCR_MOD, 0x0070)
 
+#define OMAP3430_CM_CLKOUT_CTRL_OFFSET                  0x0070
+
 /*
  * Module specific CM registers from CM_BASE + domain offset
  * Use cm_{read,write}_mod_reg() with these registers.

