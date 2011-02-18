From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH v6 4/4] OMAP: mailbox: use runtime pm for clk and sysc handling
Date: Thu, 17 Feb 2011 19:42:27 -0600
Message-ID: <1297993347-5654-5-git-send-email-omar.ramirez@ti.com>
References: <1297993347-5654-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33643 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752318Ab1BRBxr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Feb 2011 20:53:47 -0500
In-Reply-To: <1297993347-5654-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King <linux@arm.linux.org.uk>, Kevin Hilman <khilman@ti.com>, Benoit Cousson <b-cousson@ti.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Sourav Poddar <sourav.poddar@ti.com>, lo <linux-omap@vger.kernel.org>, lak <linux-arm-kernel@lists.infradead.org>, Omar Ramirez Luna <omar.ramirez@ti.com>

Use runtime pm APIs to enable/disable mailbox clocks and
to configure SYSC register.

Based on the patch sent by Felipe Contreras:
https://patchwork.kernel.org/patch/101662/

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/mach-omap2/mailbox.c |   67 ++++-------------------------------------
 1 files changed, 6 insertions(+), 61 deletions(-)

diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
index de352bd..9a61e1f 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -14,12 +14,11 @@
 #include <linux/err.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
+#include <linux/pm_runtime.h>
 #include <plat/mailbox.h>
 #include <mach/irqs.h>
 
 #define MAILBOX_REVISION		0x000
-#define MAILBOX_SYSCONFIG		0x010
-#define MAILBOX_SYSSTATUS		0x014
 #define MAILBOX_MESSAGE(m)		(0x040 + 4 * (m))
 #define MAILBOX_FIFOSTATUS(m)		(0x080 + 4 * (m))
 #define MAILBOX_MSGSTATUS(m)		(0x0c0 + 4 * (m))
@@ -33,17 +32,6 @@
 #define MAILBOX_IRQ_NEWMSG(m)		(1 << (2 * (m)))
 #define MAILBOX_IRQ_NOTFULL(m)		(1 << (2 * (m) + 1))
 
-/* SYSCONFIG: register bit definition */
-#define AUTOIDLE	(1 << 0)
-#define SOFTRESET	(1 << 1)
-#define SMARTIDLE	(2 << 3)
-#define OMAP4_SOFTRESET	(1 << 0)
-#define OMAP4_NOIDLE	(1 << 2)
-#define OMAP4_SMARTIDLE	(2 << 2)
-
-/* SYSSTATUS: register bit definition */
-#define RESETDONE	(1 << 0)
-
 #define MBOX_REG_SIZE			0x120
 
 #define OMAP4_MBOX_REG_SIZE		0x130
@@ -70,8 +58,6 @@ struct omap_mbox2_priv {
 	unsigned long irqdisable;
 };
 
-static struct clk *mbox_ick_handle;
-
 static void omap2_mbox_enable_irq(struct omap_mbox *mbox,
 				  omap_mbox_type_t irq);
 
@@ -89,53 +75,13 @@ static inline void mbox_write_reg(u32 val, size_t ofs)
 static int omap2_mbox_startup(struct omap_mbox *mbox)
 {
 	u32 l;
-	unsigned long timeout;
 
-	mbox_ick_handle = clk_get(NULL, "mailboxes_ick");
-	if (IS_ERR(mbox_ick_handle)) {
-		printk(KERN_ERR "Could not get mailboxes_ick: %ld\n",
-			PTR_ERR(mbox_ick_handle));
-		return PTR_ERR(mbox_ick_handle);
-	}
-	clk_enable(mbox_ick_handle);
-
-	if (cpu_is_omap44xx()) {
-		mbox_write_reg(OMAP4_SOFTRESET, MAILBOX_SYSCONFIG);
-		timeout = jiffies + msecs_to_jiffies(20);
-		do {
-			l = mbox_read_reg(MAILBOX_SYSCONFIG);
-			if (!(l & OMAP4_SOFTRESET))
-				break;
-		} while (!time_after(jiffies, timeout));
-
-		if (l & OMAP4_SOFTRESET) {
-			pr_err("Can't take mailbox out of reset\n");
-			return -ENODEV;
-		}
-	} else {
-		mbox_write_reg(SOFTRESET, MAILBOX_SYSCONFIG);
-		timeout = jiffies + msecs_to_jiffies(20);
-		do {
-			l = mbox_read_reg(MAILBOX_SYSSTATUS);
-			if (l & RESETDONE)
-				break;
-		} while (!time_after(jiffies, timeout));
-
-		if (!(l & RESETDONE)) {
-			pr_err("Can't take mailbox out of reset\n");
-			return -ENODEV;
-		}
-	}
+	pm_runtime_enable(mbox->dev->parent);
+	pm_runtime_get_sync(mbox->dev->parent);
 
 	l = mbox_read_reg(MAILBOX_REVISION);
 	pr_debug("omap mailbox rev %d.%d\n", (l & 0xf0) >> 4, (l & 0x0f));
 
-	if (cpu_is_omap44xx())
-		l = OMAP4_SMARTIDLE;
-	else
-		l = SMARTIDLE | AUTOIDLE;
-	mbox_write_reg(l, MAILBOX_SYSCONFIG);
-
 	omap2_mbox_enable_irq(mbox, IRQ_RX);
 
 	return 0;
@@ -143,9 +89,8 @@ static int omap2_mbox_startup(struct omap_mbox *mbox)
 
 static void omap2_mbox_shutdown(struct omap_mbox *mbox)
 {
-	clk_disable(mbox_ick_handle);
-	clk_put(mbox_ick_handle);
-	mbox_ick_handle = NULL;
+	pm_runtime_put_sync(mbox->dev->parent);
+	pm_runtime_disable(mbox->dev->parent);
 }
 
 /* Mailbox FIFO handle functions */
-- 
1.7.1

