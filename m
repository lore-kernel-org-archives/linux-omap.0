From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 05/12] omap: mailbox: Execute softreset at startup
Date: Thu, 24 Sep 2009 16:38:04 -0700
Message-ID: <20090924233804.6065.32615.stgit@localhost>
References: <20090924233027.6065.95725.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:50430 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752257AbZIXXiB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Sep 2009 19:38:01 -0400
In-Reply-To: <20090924233027.6065.95725.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

The softreset at startup is introduced as TRM describes and also some
register bit definitions are added instead of magic number.

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
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

