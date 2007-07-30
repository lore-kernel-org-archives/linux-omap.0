From: Hiroshi.DOYU@nokia.com
Subject: [PATCH 7/8] ARM: OMAP: Fix Unbalanced enable for IRQ in omap mailbox
Date: Mon, 30 Jul 2007 14:04:04 +0300
Message-ID: <11857934604148-git-send-email-Hiroshi.DOYU@nokia.com>
References: <11857934452717-git-send-email-Hiroshi.DOYU@nokia.com>
	<11857934482616-git-send-email-Hiroshi.DOYU@nokia.com>
	<11857934501598-git-send-email-Hiroshi.DOYU@nokia.com>
	<11857934533223-git-send-email-Hiroshi.DOYU@nokia.com>
	<11857934552591-git-send-email-Hiroshi.DOYU@nokia.com>
	<11857934584117-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11857934584117-git-send-email-Hiroshi.DOYU@nokia.com>
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
 arch/arm/mach-omap1/mailbox.c |   14 +++++++-------
 arch/arm/mach-omap2/mailbox.c |   25 +++++++++++++++----------
 arch/arm/plat-omap/mailbox.c  |    1 -
 3 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-omap1/mailbox.c b/arch/arm/mach-omap1/mailbox.c
index d3abf56..bad1e71 100644
--- a/arch/arm/mach-omap1/mailbox.c
+++ b/arch/arm/mach-omap1/mailbox.c
@@ -51,7 +51,7 @@ static inline void mbox_write_reg(unsigned int val, unsigned int reg)
 }
 
 /* msg */
-static inline mbox_msg_t omap1_mbox_fifo_read(struct omap_mbox *mbox)
+static mbox_msg_t omap1_mbox_fifo_read(struct omap_mbox *mbox)
 {
 	struct omap_mbox1_fifo *fifo =
 		&((struct omap_mbox1_priv *)mbox->priv)->rx_fifo;
@@ -63,7 +63,7 @@ static inline mbox_msg_t omap1_mbox_fifo_read(struct omap_mbox *mbox)
 	return msg;
 }
 
-static inline void
+static void
 omap1_mbox_fifo_write(struct omap_mbox *mbox, mbox_msg_t msg)
 {
 	struct omap_mbox1_fifo *fifo =
@@ -73,12 +73,12 @@ omap1_mbox_fifo_write(struct omap_mbox *mbox, mbox_msg_t msg)
 	mbox_write_reg(msg >> 16, fifo->cmd);
 }
 
-static inline int omap1_mbox_fifo_empty(struct omap_mbox *mbox)
+static int omap1_mbox_fifo_empty(struct omap_mbox *mbox)
 {
 	return 0;
 }
 
-static inline int omap1_mbox_fifo_full(struct omap_mbox *mbox)
+static int omap1_mbox_fifo_full(struct omap_mbox *mbox)
 {
 	struct omap_mbox1_fifo *fifo =
 		&((struct omap_mbox1_priv *)mbox->priv)->rx_fifo;
@@ -87,21 +87,21 @@ static inline int omap1_mbox_fifo_full(struct omap_mbox *mbox)
 }
 
 /* irq */
-static inline void
+static void
 omap1_mbox_enable_irq(struct omap_mbox *mbox, omap_mbox_type_t irq)
 {
 	if (irq == IRQ_RX)
 		enable_irq(mbox->irq);
 }
 
-static inline void
+static void
 omap1_mbox_disable_irq(struct omap_mbox *mbox, omap_mbox_type_t irq)
 {
 	if (irq == IRQ_RX)
 		disable_irq(mbox->irq);
 }
 
-static inline int
+static int
 omap1_mbox_is_irq(struct omap_mbox *mbox, omap_mbox_type_t irq)
 {
 	if (irq == IRQ_TX)
diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
index b03cd06..4799561 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -70,6 +70,9 @@ struct omap_mbox2_priv {
 
 static struct clk *mbox_ick_handle;
 
+static void omap2_mbox_enable_irq(struct omap_mbox *mbox,
+				  omap_mbox_type_t irq);
+
 static inline unsigned int mbox_read_reg(unsigned int reg)
 {
 	return __raw_readl(mbox_base + reg);
@@ -81,7 +84,7 @@ static inline void mbox_write_reg(unsigned int val, unsigned int reg)
 }
 
 /* Mailbox H/W preparations */
-static inline int omap2_mbox_startup(struct omap_mbox *mbox)
+static int omap2_mbox_startup(struct omap_mbox *mbox)
 {
 	unsigned int l;
 
@@ -97,38 +100,40 @@ static inline int omap2_mbox_startup(struct omap_mbox *mbox)
 	l |= 0x00000011;
 	mbox_write_reg(l, MAILBOX_SYSCONFIG);
 
+	omap2_mbox_enable_irq(mbox, IRQ_RX);
+
 	return 0;
 }
 
-static inline void omap2_mbox_shutdown(struct omap_mbox *mbox)
+static void omap2_mbox_shutdown(struct omap_mbox *mbox)
 {
 	clk_disable(mbox_ick_handle);
 	clk_put(mbox_ick_handle);
 }
 
 /* Mailbox FIFO handle functions */
-static inline mbox_msg_t omap2_mbox_fifo_read(struct omap_mbox *mbox)
+static mbox_msg_t omap2_mbox_fifo_read(struct omap_mbox *mbox)
 {
 	struct omap_mbox2_fifo *fifo =
 		&((struct omap_mbox2_priv *)mbox->priv)->rx_fifo;
 	return (mbox_msg_t) mbox_read_reg(fifo->msg);
 }
 
-static inline void omap2_mbox_fifo_write(struct omap_mbox *mbox, mbox_msg_t msg)
+static void omap2_mbox_fifo_write(struct omap_mbox *mbox, mbox_msg_t msg)
 {
 	struct omap_mbox2_fifo *fifo =
 		&((struct omap_mbox2_priv *)mbox->priv)->tx_fifo;
 	mbox_write_reg(msg, fifo->msg);
 }
 
-static inline int omap2_mbox_fifo_empty(struct omap_mbox *mbox)
+static int omap2_mbox_fifo_empty(struct omap_mbox *mbox)
 {
 	struct omap_mbox2_fifo *fifo =
 		&((struct omap_mbox2_priv *)mbox->priv)->rx_fifo;
 	return (mbox_read_reg(fifo->msg_stat) == 0);
 }
 
-static inline int omap2_mbox_fifo_full(struct omap_mbox *mbox)
+static int omap2_mbox_fifo_full(struct omap_mbox *mbox)
 {
 	struct omap_mbox2_fifo *fifo =
 		&((struct omap_mbox2_priv *)mbox->priv)->tx_fifo;
@@ -136,7 +141,7 @@ static inline int omap2_mbox_fifo_full(struct omap_mbox *mbox)
 }
 
 /* Mailbox IRQ handle functions */
-static inline void omap2_mbox_enable_irq(struct omap_mbox *mbox,
+static void omap2_mbox_enable_irq(struct omap_mbox *mbox,
 		omap_mbox_type_t irq)
 {
 	struct omap_mbox2_priv *p = (struct omap_mbox2_priv *)mbox->priv;
@@ -147,7 +152,7 @@ static inline void omap2_mbox_enable_irq(struct omap_mbox *mbox,
 	mbox_write_reg(l, p->irqenable);
 }
 
-static inline void omap2_mbox_disable_irq(struct omap_mbox *mbox,
+static void omap2_mbox_disable_irq(struct omap_mbox *mbox,
 		omap_mbox_type_t irq)
 {
 	struct omap_mbox2_priv *p = (struct omap_mbox2_priv *)mbox->priv;
@@ -158,7 +163,7 @@ static inline void omap2_mbox_disable_irq(struct omap_mbox *mbox,
 	mbox_write_reg(l, p->irqenable);
 }
 
-static inline void omap2_mbox_ack_irq(struct omap_mbox *mbox,
+static void omap2_mbox_ack_irq(struct omap_mbox *mbox,
 		omap_mbox_type_t irq)
 {
 	struct omap_mbox2_priv *p = (struct omap_mbox2_priv *)mbox->priv;
@@ -167,7 +172,7 @@ static inline void omap2_mbox_ack_irq(struct omap_mbox *mbox,
 	mbox_write_reg(bit, p->irqstatus);
 }
 
-static inline int omap2_mbox_is_irq(struct omap_mbox *mbox,
+static int omap2_mbox_is_irq(struct omap_mbox *mbox,
 		omap_mbox_type_t irq)
 {
 	struct omap_mbox2_priv *p = (struct omap_mbox2_priv *)mbox->priv;
diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
index de7e6ef..91efd16 100644
--- a/arch/arm/plat-omap/mailbox.c
+++ b/arch/arm/plat-omap/mailbox.c
@@ -359,7 +359,6 @@ static int omap_mbox_init(struct omap_mbox *mbox)
 			"failed to register mailbox interrupt:%d\n", ret);
 		goto fail_request_irq;
 	}
-	enable_mbox_irq(mbox, IRQ_RX);
 
 	mq = mbox_queue_alloc(mbox, mbox_txq_fn, mbox_tx_work);
 	if (!mq) {
-- 
1.5.3.rc3.24.g83b3d
