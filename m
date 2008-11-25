From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH 01/10] omap mailbox: cleanup omap2 register definition with macro
Date: Tue, 25 Nov 2008 11:39:49 +0200
Message-ID: <1227605998-13531-2-git-send-email-Hiroshi.DOYU@nokia.com>
References: <1227605998-13531-1-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:34856 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752199AbYKYJkQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Nov 2008 04:40:16 -0500
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id mAP9e16x029701
	for <linux-omap@vger.kernel.org>; Tue, 25 Nov 2008 11:40:14 +0200
Received: from oreo.research.nokia.com (esdhcp04130.research.nokia.com [172.21.41.30])
	by mgw-int01.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id mAP9dxQD016085
	for <linux-omap@vger.kernel.org>; Tue, 25 Nov 2008 11:39:59 +0200
In-Reply-To: <1227605998-13531-1-git-send-email-Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/mach-omap2/mailbox.c |   77 +++++++++++++++-------------------------
 1 files changed, 29 insertions(+), 48 deletions(-)

diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
index 22546d0..5ff2ed8 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -1,9 +1,9 @@
 /*
- * Mailbox reservation modules for OMAP2
+ * Mailbox reservation modules for OMAP2/3
  *
- * Copyright (C) 2006 Nokia Corporation
+ * Copyright (C) 2006-2008 Nokia Corporation
  * Written by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
- *        and  Paul Mundt <paul.mundt@nokia.com>
+ *        and  Paul Mundt
  *
  * This file is subject to the terms and conditions of the GNU General Public
  * License.  See the file "COPYING" in the main directory of this archive
@@ -18,40 +18,19 @@
 #include <mach/mailbox.h>
 #include <mach/irqs.h>
 
-#define MAILBOX_REVISION		0x00
-#define MAILBOX_SYSCONFIG		0x10
-#define MAILBOX_SYSSTATUS		0x14
-#define MAILBOX_MESSAGE_0		0x40
-#define MAILBOX_MESSAGE_1		0x44
-#define MAILBOX_MESSAGE_2		0x48
-#define MAILBOX_MESSAGE_3		0x4c
-#define MAILBOX_MESSAGE_4		0x50
-#define MAILBOX_MESSAGE_5		0x54
-#define MAILBOX_FIFOSTATUS_0		0x80
-#define MAILBOX_FIFOSTATUS_1		0x84
-#define MAILBOX_FIFOSTATUS_2		0x88
-#define MAILBOX_FIFOSTATUS_3		0x8c
-#define MAILBOX_FIFOSTATUS_4		0x90
-#define MAILBOX_FIFOSTATUS_5		0x94
-#define MAILBOX_MSGSTATUS_0		0xc0
-#define MAILBOX_MSGSTATUS_1		0xc4
-#define MAILBOX_MSGSTATUS_2		0xc8
-#define MAILBOX_MSGSTATUS_3		0xcc
-#define MAILBOX_MSGSTATUS_4		0xd0
-#define MAILBOX_MSGSTATUS_5		0xd4
-#define MAILBOX_IRQSTATUS_0		0x100
-#define MAILBOX_IRQENABLE_0		0x104
-#define MAILBOX_IRQSTATUS_1		0x108
-#define MAILBOX_IRQENABLE_1		0x10c
-#define MAILBOX_IRQSTATUS_2		0x110
-#define MAILBOX_IRQENABLE_2		0x114
-#define MAILBOX_IRQSTATUS_3		0x118
-#define MAILBOX_IRQENABLE_3		0x11c
+#define MAILBOX_REVISION		0x000
+#define MAILBOX_SYSCONFIG		0x010
+#define MAILBOX_SYSSTATUS		0x014
+#define MAILBOX_MESSAGE(m)		(0x040 + 4 * (m))
+#define MAILBOX_FIFOSTATUS(m)		(0x080 + 4 * (m))
+#define MAILBOX_MSGSTATUS(m)		(0x0c0 + 4 * (m))
+#define MAILBOX_IRQSTATUS(u)		(0x100 + 8 * (u))
+#define MAILBOX_IRQENABLE(u)		(0x108 + 8 * (u))
 
-static unsigned long mbox_base;
+#define MAILBOX_IRQ_NEWMSG(u)		(1 << (2 * (u)))
+#define MAILBOX_IRQ_NOTFULL(u)		(1 << (2 * (u) + 1))
 
-#define MAILBOX_IRQ_NOTFULL(n)		(1 << (2 * (n) + 1))
-#define MAILBOX_IRQ_NEWMSG(n)		(1 << (2 * (n)))
+static unsigned long mbox_base;
 
 struct omap_mbox2_fifo {
 	unsigned long msg;
@@ -209,15 +188,15 @@ static struct omap_mbox_ops omap2_mbox_ops = {
 /* DSP */
 static struct omap_mbox2_priv omap2_mbox_dsp_priv = {
 	.tx_fifo = {
-		.msg		= MAILBOX_MESSAGE_0,
-		.fifo_stat	= MAILBOX_FIFOSTATUS_0,
+		.msg		= MAILBOX_MESSAGE(0),
+		.fifo_stat	= MAILBOX_FIFOSTATUS(0),
 	},
 	.rx_fifo = {
-		.msg		= MAILBOX_MESSAGE_1,
-		.msg_stat	= MAILBOX_MSGSTATUS_1,
+		.msg		= MAILBOX_MESSAGE(1),
+		.msg_stat	= MAILBOX_MSGSTATUS(1),
 	},
-	.irqenable	= MAILBOX_IRQENABLE_0,
-	.irqstatus	= MAILBOX_IRQSTATUS_0,
+	.irqenable	= MAILBOX_IRQENABLE(0),
+	.irqstatus	= MAILBOX_IRQSTATUS(0),
 	.notfull_bit	= MAILBOX_IRQ_NOTFULL(0),
 	.newmsg_bit	= MAILBOX_IRQ_NEWMSG(1),
 };
@@ -232,15 +211,15 @@ EXPORT_SYMBOL(mbox_dsp_info);
 /* IVA */
 static struct omap_mbox2_priv omap2_mbox_iva_priv = {
 	.tx_fifo = {
-		.msg		= MAILBOX_MESSAGE_2,
-		.fifo_stat	= MAILBOX_FIFOSTATUS_2,
+		.msg		= MAILBOX_MESSAGE(2),
+		.fifo_stat	= MAILBOX_FIFOSTATUS(2),
 	},
 	.rx_fifo = {
-		.msg		= MAILBOX_MESSAGE_3,
-		.msg_stat	= MAILBOX_MSGSTATUS_3,
+		.msg		= MAILBOX_MESSAGE(3),
+		.msg_stat	= MAILBOX_MSGSTATUS(3),
 	},
-	.irqenable	= MAILBOX_IRQENABLE_3,
-	.irqstatus	= MAILBOX_IRQSTATUS_3,
+	.irqenable	= MAILBOX_IRQENABLE(3),
+	.irqstatus	= MAILBOX_IRQSTATUS(3),
 	.notfull_bit	= MAILBOX_IRQ_NOTFULL(2),
 	.newmsg_bit	= MAILBOX_IRQ_NEWMSG(3),
 };
@@ -320,4 +299,6 @@ static void __exit omap2_mbox_exit(void)
 module_init(omap2_mbox_init);
 module_exit(omap2_mbox_exit);
 
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("omap mailbox: omap2/3 architecture specific functions");
+MODULE_AUTHOR("Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Paul Mundt");
-- 
1.6.0.3.613.g9f8f13

