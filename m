From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH 1/1] omap mailbox: execute softreset at startup
Date: Thu, 27 Aug 2009 12:33:32 +0300
Message-ID: <1251365612-26258-1-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:60269 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751972AbZH0Jdx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 Aug 2009 05:33:53 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx03.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n7R9XKVU007757
	for <linux-omap@vger.kernel.org>; Thu, 27 Aug 2009 12:33:46 +0300
Received: from oreo.research.nokia.com (esdhcp04130.research.nokia.com [172.21.41.30])
	by mgw-sa01.ext.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n7R9XU32021283
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 27 Aug 2009 12:33:31 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

The softreset at startup is introduced as TRM describes and also some
register bit definitions are added instead of magic number.

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/mach-omap2/mailbox.c |   30 +++++++++++++++++++++++++-----
 1 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
index 6f71f37..5bf9a2f 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -30,6 +30,14 @@
 #define MAILBOX_IRQ_NEWMSG(u)		(1 << (2 * (u)))
 #define MAILBOX_IRQ_NOTFULL(u)		(1 << (2 * (u) + 1))
 
+/* SYSCONFIG: register bit definition */
+#define AUTOIDLE	(1 << 0)
+#define SOFTRESET	(1 << 1)
+#define SMARTIDLE	(2 << 3)
+
+/* SYSSTATUS: register bit definition */
+#define RESETDONE	(1 << 0)
+
 #define MBOX_REG_SIZE			0x120
 #define MBOX_NR_REGS			(MBOX_REG_SIZE / sizeof(u32))
 
@@ -69,21 +77,33 @@ static inline void mbox_write_reg(u32 val, size_t ofs)
 /* Mailbox H/W preparations */
 static int omap2_mbox_startup(struct omap_mbox *mbox)
 {
-	unsigned int l;
+	u32 l;
+	unsigned long timeout;
 
 	mbox_ick_handle = clk_get(NULL, "mailboxes_ick");
 	if (IS_ERR(mbox_ick_handle)) {
-		printk("Could not get mailboxes_ick\n");
+		pr_err("Can't get mailboxes_ick\n");
 		return -ENODEV;
 	}
 	clk_enable(mbox_ick_handle);
 
+	mbox_write_reg(SOFTRESET, MAILBOX_SYSCONFIG);
+	timeout = jiffies + msecs_to_jiffies(20);
+	do {
+		l = mbox_read_reg(MAILBOX_SYSSTATUS);
+		if (l & RESETDONE)
+			break;
+	} while (time_after(jiffies, timeout));
+
+	if (!(l & RESETDONE)) {
+		pr_err("Can't take mmu out of reset\n");
+		return -ENODEV;
+	}
+
 	l = mbox_read_reg(MAILBOX_REVISION);
 	pr_info("omap mailbox rev %d.%d\n", (l & 0xf0) >> 4, (l & 0x0f));
 
-	/* set smart-idle & autoidle */
-	l = mbox_read_reg(MAILBOX_SYSCONFIG);
-	l |= 0x00000011;
+	l = SMARTIDLE | AUTOIDLE;
 	mbox_write_reg(l, MAILBOX_SYSCONFIG);
 
 	omap2_mbox_enable_irq(mbox, IRQ_RX);
-- 
1.6.0.4

