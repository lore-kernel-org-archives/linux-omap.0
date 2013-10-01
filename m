From: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/3] dma: cppi41: use cppi41_pop_desc() where possible
Date: Tue,  1 Oct 2013 15:31:10 +0200
Message-ID: <1380634271-27588-3-git-send-email-zonque@gmail.com>
References: <1380634271-27588-1-git-send-email-zonque@gmail.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1380634271-27588-1-git-send-email-zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, neumann-SRDuVqtxQLSzQB+pC5nmwQ@public.gmane.org, bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Use cppi41_pop_desc() when appropriate instead of open-coding the same
functionality again. That makes the code more readable. The function has
to be moved some lines up for this change.

Signed-off-by: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/dma/cppi41.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/dma/cppi41.c b/drivers/dma/cppi41.c
index 9a298b1..7747bf7 100644
--- a/drivers/dma/cppi41.c
+++ b/drivers/dma/cppi41.c
@@ -266,6 +266,15 @@ static u32 pd_trans_len(u32 val)
 	return val & ((1 << (DESC_LENGTH_BITS_NUM + 1)) - 1);
 }
 
+static u32 cppi41_pop_desc(struct cppi41_dd *cdd, unsigned queue_num)
+{
+	u32 desc;
+
+	desc = cppi_readl(cdd->qmgr_mem + QMGR_QUEUE_D(queue_num));
+	desc &= ~0x1f;
+	return desc;
+}
+
 static irqreturn_t cppi41_irq(int irq, void *data)
 {
 	struct cppi41_dd *cdd = data;
@@ -303,8 +312,7 @@ static irqreturn_t cppi41_irq(int irq, void *data)
 			q_num = __fls(val);
 			val &= ~(1 << q_num);
 			q_num += 32 * i;
-			desc = cppi_readl(cdd->qmgr_mem + QMGR_QUEUE_D(q_num));
-			desc &= ~0x1f;
+			desc = cppi41_pop_desc(cdd, q_num);
 			c = desc_to_chan(cdd, desc);
 			if (WARN_ON(!c)) {
 				pr_err("%s() q %d desc %08x\n", __func__,
@@ -520,15 +528,6 @@ static void cppi41_compute_td_desc(struct cppi41_desc *d)
 	d->pd0 = DESC_TYPE_TEARD << DESC_TYPE;
 }
 
-static u32 cppi41_pop_desc(struct cppi41_dd *cdd, unsigned queue_num)
-{
-	u32 desc;
-
-	desc = cppi_readl(cdd->qmgr_mem + QMGR_QUEUE_D(queue_num));
-	desc &= ~0x1f;
-	return desc;
-}
