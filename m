From: "Rajendra Nayak" <rnayak@ti.com>
Subject: [PATCH 11/12] Attempt only C0 during serial activity
Date: Mon, 1 Sep 2008 19:12:32 +0530 (IST)
Message-ID: <63209.192.168.10.89.1220276552.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49430 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750964AbYIANmj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Sep 2008 09:42:39 -0400
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id m81DgXxS008453
	for <linux-omap@vger.kernel.org>; Mon, 1 Sep 2008 08:42:38 -0500
Received: from webmail.ti.com (localhost [127.0.0.1])
	by dlep33.itg.ti.com (8.13.7/8.13.7) with ESMTP id m81DgVct017253
	for <linux-omap@vger.kernel.org>; Mon, 1 Sep 2008 08:42:32 -0500 (CDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This patch keeps the system active while UART inactivity timer is ON

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/cpuidle34xx.c        |    3 ++-
 arch/arm/mach-omap2/pm34xx.c             |    2 --
 arch/arm/plat-omap/include/mach/serial.h |    1 +
 3 files changed, 3 insertions(+), 3 deletions(-)

Index: linux-omap-2.6/arch/arm/mach-omap2/cpuidle34xx.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/cpuidle34xx.c	2008-09-01
18:11:55.000000000 +0530
+++ linux-omap-2.6/arch/arm/mach-omap2/cpuidle34xx.c	2008-09-01
18:11:56.000000000 +0530
@@ -29,6 +29,7 @@
 #include <mach/gpmc.h>
 #include <mach/control.h>
 #include <mach/irqs.h>
+#include <mach/serial.h>
 #include <linux/sched.h>

 #include "cpuidle34xx.h"
@@ -93,7 +94,7 @@ static int omap3_enter_idle(struct cpuid

 	current_cx_state = *cx;

-	if (cx->type == OMAP3_STATE_C0) {
+	if (cx->type == OMAP3_STATE_C0 || !omap_serial_can_sleep()) {
 		/* Do nothing for C0, not even a wfi */
 		return 0;
 	}
Index: linux-omap-2.6/arch/arm/mach-omap2/pm34xx.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/pm34xx.c	2008-09-01
18:11:55.000000000 +0530
+++ linux-omap-2.6/arch/arm/mach-omap2/pm34xx.c	2008-09-01 18:11:56.000000000
+0530
@@ -390,8 +390,6 @@ int omap3_can_sleep(void)
 		return 0;
 	if (atomic_read(&sleep_block) > 0)
 		return 0;
-	if (!omap_serial_can_sleep())
-		return 0;
 	return 1;
 }

Index: linux-omap-2.6/arch/arm/plat-omap/include/mach/serial.h
===================================================================
--- linux-omap-2.6.orig/arch/arm/plat-omap/include/mach/serial.h	2008-09-01
18:11:50.000000000 +0530
+++ linux-omap-2.6/arch/arm/plat-omap/include/mach/serial.h	2008-09-01
18:11:56.000000000 +0530
@@ -50,5 +50,6 @@ struct omap3_uart_regs {
 };
 extern void omap3_save_uart_ctx(int unum);
 extern void omap3_restore_uart_ctx(int unum);
+extern int omap_serial_can_sleep(void);
 #endif /* __ASSEMBLY__ */
 #endif


