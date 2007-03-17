From: Hiroshi.DOYU@nokia.com
Subject: [PATCH 2/2] OMAP: MBOX: N800: remaining updates for mailbox parts
Date: Sat, 17 Mar 2007 19:44:30 +0200
Message-ID: <11741534773311-git-send-email-Hiroshi.DOYU@nokia.com>
References: <1174153470622-git-send-email-Hiroshi.DOYU@nokia.com>
	<11741534753734-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11741534753734-git-send-email-Hiroshi.DOYU@nokia.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
List-Id: linux-omap@vger.kernel.org

From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/mach-omap1/mailbox.c |    2 +-
 arch/arm/mach-omap2/mailbox.c |    8 ++++----
 arch/arm/plat-omap/mailbox.h  |    2 --
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap1/mailbox.c b/arch/arm/mach-omap1/mailbox.c
index 877b838..25e1d95 100644
--- a/arch/arm/mach-omap1/mailbox.c
+++ b/arch/arm/mach-omap1/mailbox.c
@@ -109,7 +109,7 @@ omap1_mbox_is_irq(struct omap_mbox *mbox, omap_mbox_type_t irq)
 	return 1;
 }
 
-struct omap_mbox_ops omap1_mbox_ops = {
+static struct omap_mbox_ops omap1_mbox_ops = {
 	.type = OMAP_MBOX_TYPE1,
 	.fifo_read = omap1_mbox_fifo_read,
 	.fifo_write = omap1_mbox_fifo_write,
diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
index e541e95..824fd21 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -48,7 +48,7 @@
 #define MAILBOX_IRQSTATUS_3		0x118
 #define MAILBOX_IRQENABLE_3		0x11c
 
-unsigned long mbox_base;
+static unsigned long mbox_base;
 
 #define MAILBOX_IRQ_NOTFULL(n)		(1 << (2 * (n) + 1))
 #define MAILBOX_IRQ_NEWMSG(n)		(1 << (2 * (n)))
@@ -68,7 +68,7 @@ struct omap_mbox2_priv {
 	u32 notfull_bit;
 };
 
-struct clk *mbox_ick_handle;
+static struct clk *mbox_ick_handle;
 
 static inline unsigned int mbox_read_reg(unsigned int reg)
 {
@@ -170,7 +170,7 @@ static inline int omap2_mbox_is_irq(struct omap_mbox *mbox, omap_mbox_type_t irq
 	return (enable & status & bit);
 }
 
-struct omap_mbox_ops omap2_mbox_ops = {
+static struct omap_mbox_ops omap2_mbox_ops = {
 	.type = OMAP_MBOX_TYPE2,
 	.startup = omap2_mbox_startup,
 	.shutdown = omap2_mbox_shutdown,
@@ -294,7 +294,7 @@ static struct platform_driver omap2_mbox_driver = {
 	},
 };
 
-int __init omap2_mbox_init(void)
+static int __init omap2_mbox_init(void)
 {
 	return platform_driver_register(&omap2_mbox_driver);
 }
diff --git a/arch/arm/plat-omap/mailbox.h b/arch/arm/plat-omap/mailbox.h
index 9b60271..67c6740 100644
--- a/arch/arm/plat-omap/mailbox.h
+++ b/arch/arm/plat-omap/mailbox.h
@@ -12,8 +12,6 @@
 #ifndef __ARCH_ARM_PLAT_MAILBOX_H
 #define __ARCH_ARM_PLAT_MAILBOX_H
 
-#define MBOX_NAME_LEN 255
-
 /*
  * Mailbox sequence bit API
  */
-- 
1.5.0.3.271.g5ced
