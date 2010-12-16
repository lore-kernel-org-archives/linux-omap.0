From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH v4 5/5] OMAP: mailbox: use runtime pm for clk and sysc handling
Date: Thu, 16 Dec 2010 00:47:59 -0600
Message-ID: <1292482079-2226-6-git-send-email-omar.ramirez@ti.com>
References: <1292482079-2226-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37459 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753200Ab0LPG7P (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Dec 2010 01:59:15 -0500
In-Reply-To: <1292482079-2226-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, Benoit Cousson <b-cousson@ti.com>
Cc: Russell King <linux@arm.linux.org.uk>, Omar Ramirez Luna <omar.ramirez@ti.com>, Charulatha V <charu@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Use runtime pm APIs to enable/disable mailbox clocks and
to configure SYSC register.

Based on the patch sent by Felipe Contreras:
https://patchwork.kernel.org/patch/101662/

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/mach-omap2/mailbox.c |   27 +++++----------------------
 1 files changed, 5 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
index 40ddeca..f5f72ba 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -14,6 +14,7 @@
 #include <linux/err.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
+#include <linux/pm_runtime.h>
 #include <plat/mailbox.h>
 #include <mach/irqs.h>
 
@@ -34,12 +35,8 @@
 #define MAILBOX_IRQ_NOTFULL(m)		(1 << (2 * (m) + 1))
 
 /* SYSCONFIG: register bit definition */
-#define AUTOIDLE	(1 << 0)
 #define SOFTRESET	(1 << 1)
-#define SMARTIDLE	(2 << 3)
 #define OMAP4_SOFTRESET	(1 << 0)
-#define OMAP4_NOIDLE	(1 << 2)
-#define OMAP4_SMARTIDLE	(2 << 2)
 
 /* SYSSTATUS: register bit definition */
 #define RESETDONE	(1 << 0)
@@ -70,8 +67,6 @@ struct omap_mbox2_priv {
 	unsigned long irqdisable;
 };
 
-static struct clk *mbox_ick_handle;
-
 static void omap2_mbox_enable_irq(struct omap_mbox *mbox,
 				  omap_mbox_type_t irq);
 
@@ -91,13 +86,8 @@ static int omap2_mbox_startup(struct omap_mbox *mbox)
 	u32 l;
 	unsigned long timeout;
 
-	mbox_ick_handle = clk_get(NULL, "mailboxes_ick");
-	if (IS_ERR(mbox_ick_handle)) {
-		printk(KERN_ERR "Could not get mailboxes_ick: %ld\n",
-			PTR_ERR(mbox_ick_handle));
-		return PTR_ERR(mbox_ick_handle);
-	}
-	clk_enable(mbox_ick_handle);
+	pm_runtime_enable(mbox->dev->parent);
+	pm_runtime_get_sync(mbox->dev->parent);
 
 	if (cpu_is_omap44xx()) {
 		mbox_write_reg(OMAP4_SOFTRESET, MAILBOX_SYSCONFIG);
@@ -130,12 +120,6 @@ static int omap2_mbox_startup(struct omap_mbox *mbox)
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
@@ -143,9 +127,8 @@ static int omap2_mbox_startup(struct omap_mbox *mbox)
 
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

