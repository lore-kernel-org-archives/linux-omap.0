From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.27-rc8-omap 3/7] remove <linux/i2c/twl4030-pwrirq.h>
Date: Fri, 3 Oct 2008 09:00:10 -0700
Message-ID: <200810030900.10745.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp127.sbc.mail.sp1.yahoo.com ([69.147.65.186]:32631 "HELO
	smtp127.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752964AbYJCQbg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Oct 2008 12:31:36 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: David Brownell <dbrownell@users.sourceforge.net>

Get rid of another needless TWL header file:  twl4030-pwrirq.h
can easily live in twl4030.h; updating its three users.

Also switch to the shared definition of the SIH_CTRL COR bit,
remove useless-to-non-driver MODULE_ALIAS(), and add a note
about a bug that will appear if anyone ever removes this code.

No functional changes, just shrinkage.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Acked-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/i2c/chips/twl4030-pwrirq.c |   13 +++++------
 drivers/mfd/twl4030-core.c         |    1 
 drivers/rtc/rtc-twl4030.c          |    1 
 include/linux/i2c/twl4030-pwrirq.h |   39 -----------------------------------
 include/linux/i2c/twl4030.h        |   15 +++++++++++++
 5 files changed, 21 insertions(+), 48 deletions(-)

--- a/drivers/i2c/chips/twl4030-pwrirq.c
+++ b/drivers/i2c/chips/twl4030-pwrirq.c
@@ -27,9 +27,7 @@
 #include <linux/random.h>
 #include <linux/kthread.h>
 #include <linux/i2c/twl4030.h>
-#include <linux/i2c/twl4030-pwrirq.h>
 
-#define PWR_SIH_CTRL_COR (1<<2)
 
 static u8 twl4030_pwrirq_mask;
 static u8 twl4030_pwrirq_pending_unmask;
@@ -177,8 +175,9 @@ static int __init twl4030_pwrirq_init(vo
 
 	/* Enable clear on read */
 
-	err = twl4030_i2c_write_u8(TWL4030_MODULE_INT, PWR_SIH_CTRL_COR,
-				   TWL4030_INT_PWR_SIH_CTRL);
+	err = twl4030_i2c_write_u8(TWL4030_MODULE_INT,
+				TWL4030_SIH_CTRL_COR_MASK,
+				TWL4030_INT_PWR_SIH_CTRL);
 	if (err)
 		return err;
 
@@ -201,12 +200,15 @@ static int __init twl4030_pwrirq_init(vo
 
 	return 0;
 }
+subsys_initcall(twl4030_pwrirq_init);
 
 static void __exit twl4030_pwrirq_exit(void)
 {
 
 	int i;
 
+	/* FIXME the irqs are left enabled; trouble when they arrive... */
+
 	set_irq_handler(TWL4030_MODIRQ_PWR, NULL);
 	set_irq_flags(TWL4030_MODIRQ_PWR, 0);
 
@@ -220,7 +222,4 @@ static void __exit twl4030_pwrirq_exit(v
 		twl4030_pwrirq_unmask_thread = NULL;
 	}
 }
-
-MODULE_ALIAS("i2c:twl4030-pwrirq");
-subsys_initcall(twl4030_pwrirq_init);
 module_exit(twl4030_pwrirq_exit);
--- a/drivers/mfd/twl4030-core.c
+++ b/drivers/mfd/twl4030-core.c
@@ -40,7 +40,6 @@
 #include <linux/i2c.h>
 #include <linux/i2c/twl4030.h>
 #include <linux/i2c/twl4030-madc.h>
-#include <linux/i2c/twl4030-pwrirq.h>
 
 #define DRIVER_NAME			"twl4030"
 
--- a/drivers/rtc/rtc-twl4030.c
+++ b/drivers/rtc/rtc-twl4030.c
@@ -28,7 +28,6 @@
 #include <linux/interrupt.h>
 
 #include <linux/i2c/twl4030.h>
-#include <linux/i2c/twl4030-pwrirq.h>
 
 
 /*
--- a/include/linux/i2c/twl4030-pwrirq.h
+++ /dev/null
@@ -1,39 +0,0 @@
-/*
- * twl4030-pwrirq.h - header for TWL4030 power interrupts
- *
- * Copyright (C) 2008 Texas Instruments, Inc.
- * Copyright (C) 2008 Nokia Corporation
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
- *
- */
-
-#ifndef __TWL4030_PWRIRQ_H_
-#define __TWL4030_PWRIRQ_H_
-
-/*
- * Power Interrupt block register offsets (use TWL4030_MODULE_INT)
- */
-
-#define TWL4030_INT_PWR_ISR1		0x0
-#define TWL4030_INT_PWR_IMR1		0x1
-#define TWL4030_INT_PWR_ISR2		0x2
-#define TWL4030_INT_PWR_IMR2		0x3
-#define TWL4030_INT_PWR_SIR		0x4	/* test register */
-#define TWL4030_INT_PWR_EDR1		0x5
-#define TWL4030_INT_PWR_EDR2		0x6
-#define TWL4030_INT_PWR_SIH_CTRL	0x7
-
-#endif /* End of __TWL4030_PWRIRQ_H */
--- a/include/linux/i2c/twl4030.h
+++ b/include/linux/i2c/twl4030.h
@@ -152,6 +152,21 @@ int twl4030_i2c_read(u8 mod_no, u8 *valu
 
 /*----------------------------------------------------------------------*/
 
+/*
+ * Power Interrupt block register offsets (use TWL4030_MODULE_INT)
+ */
+
+#define TWL4030_INT_PWR_ISR1		0x0
+#define TWL4030_INT_PWR_IMR1		0x1
+#define TWL4030_INT_PWR_ISR2		0x2
+#define TWL4030_INT_PWR_IMR2		0x3
+#define TWL4030_INT_PWR_SIR		0x4	/* test register */
+#define TWL4030_INT_PWR_EDR1		0x5
+#define TWL4030_INT_PWR_EDR2		0x6
+#define TWL4030_INT_PWR_SIH_CTRL	0x7
+
+/*----------------------------------------------------------------------*/
+
 struct twl4030_bci_platform_data {
 	int *battery_tmp_tbl;
 	unsigned int tblsize;
