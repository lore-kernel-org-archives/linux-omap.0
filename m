From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 1/2] I2C: OMAP: use consolidated flags field rather than
	bitfields
Date: Sat, 25 Apr 2009 22:28:10 -0600
Message-ID: <20090426042805.31316.29817.stgit@localhost.localdomain>
References: <20090426042504.31316.68357.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:59245 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751426AbZDZEns (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 26 Apr 2009 00:43:48 -0400
In-Reply-To: <20090426042504.31316.68357.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>

Convert existing flag usage in the i2c-omap.c driver to use a 'flags' u8
rather than bitfields.  Define static inline functions to set and clear
these flags.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 drivers/i2c/busses/i2c-omap.c |   51 +++++++++++++++++++++++++++--------------
 1 files changed, 33 insertions(+), 18 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 9919c08..387a2d3 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -26,6 +26,9 @@
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ * To do:
+ * - Add DMA support for large reads/writes
  */
 
 #include <linux/module.h>
@@ -157,6 +160,10 @@
 #define SYSC_CLOCKACTIVITY_FCLK		0x2
 
 
+/* omap_i2c_dev.flags */
+#define OMAP_I2C_BAD_HW			(1 << 0)  /* bad hardware */
+#define OMAP_I2C_IDLE			(1 << 1)  /* device clocks off */
+
 struct omap_i2c_dev {
 	struct device		*dev;
 	void __iomem		*base;		/* virtual */
@@ -166,18 +173,17 @@ struct omap_i2c_dev {
 	struct completion	cmd_complete;
 	struct resource		*ioarea;
 	u32			speed;		/* Speed of bus in Khz */
-	u16			cmd_err;
 	u8			*buf;
 	size_t			buf_len;
 	struct i2c_adapter	adapter;
+	u16			cmd_err;
+	u16			iestate;	/* Saved interrupt register */
 	u8			fifo_size;	/* use as flag and value
 						 * fifo_size==0 implies no fifo
 						 * if set, should be trsh+1
 						 */
 	u8			rev;
-	unsigned		b_hw:1;		/* bad h/w fixes */
-	unsigned		idle:1;
-	u16			iestate;	/* Saved interrupt register */
+	u8			flags;
 };
 
 static inline void omap_i2c_write_reg(struct omap_i2c_dev *i2c_dev,
@@ -191,6 +197,17 @@ static inline u16 omap_i2c_read_reg(struct omap_i2c_dev *i2c_dev, int reg)
 	return __raw_readw(i2c_dev->base + reg);
 }
 
+static inline void omap_i2c_set_flag(struct omap_i2c_dev *i2c_dev, u8 flag_mask)
+{
+	i2c_dev->flags |= flag_mask;
+}
+
+static inline void omap_i2c_clear_flag(struct omap_i2c_dev *i2c_dev,
+				       u8 flag_mask)
+{
+	i2c_dev->flags &= ~flag_mask;
+}
+
 static int __init omap_i2c_get_clocks(struct omap_i2c_dev *dev)
 {
 	int ret;
@@ -226,32 +243,30 @@ static void omap_i2c_put_clocks(struct omap_i2c_dev *dev)
 
 static void omap_i2c_unidle(struct omap_i2c_dev *dev)
 {
-	WARN_ON(!dev->idle);
+	WARN_ON(!(dev->flags & OMAP_I2C_IDLE));
 
 	clk_enable(dev->iclk);
 	clk_enable(dev->fclk);
-	dev->idle = 0;
+	omap_i2c_clear_flag(dev, OMAP_I2C_IDLE);
 	if (dev->iestate)
 		omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, dev->iestate);
 }
 
 static void omap_i2c_idle(struct omap_i2c_dev *dev)
 {
-	u16 iv;
-
-	WARN_ON(dev->idle);
+	WARN_ON(dev->flags & OMAP_I2C_IDLE);
 
 	dev->iestate = omap_i2c_read_reg(dev, OMAP_I2C_IE_REG);
 	omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, 0);
 	if (dev->rev < OMAP_I2C_REV_2) {
-		iv = omap_i2c_read_reg(dev, OMAP_I2C_IV_REG); /* Read clears */
+		omap_i2c_read_reg(dev, OMAP_I2C_IV_REG); /* Read clears */
 	} else {
 		omap_i2c_write_reg(dev, OMAP_I2C_STAT_REG, dev->iestate);
 
-		/* Flush posted write before the dev->idle store occurs */
+		/* Flush posted write before setting the idle flag */
 		omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);
 	}
-	dev->idle = 1;
+	omap_i2c_set_flag(dev, OMAP_I2C_IDLE);
 	clk_disable(dev->fclk);
 	clk_disable(dev->iclk);
 }
@@ -455,7 +470,7 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
 	if (!(msg->flags & I2C_M_RD))
 		w |= OMAP_I2C_CON_TRX;
 
-	if (!dev->b_hw && stop)
+	if (!(dev->flags & OMAP_I2C_BAD_HW) && stop)
 		w |= OMAP_I2C_CON_STP;
 
 	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, w);
@@ -463,7 +478,7 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
 	/*
 	 * Don't write stt and stp together on some hardware.
 	 */
-	if (dev->b_hw && stop) {
+	if ((dev->flags & OMAP_I2C_BAD_HW) && stop) {
 		unsigned long delay = jiffies + OMAP_I2C_TIMEOUT;
 		u16 con = omap_i2c_read_reg(dev, OMAP_I2C_CON_REG);
 		while (con & OMAP_I2C_CON_STT) {
@@ -580,7 +595,7 @@ omap_i2c_rev1_isr(int this_irq, void *dev_id)
 	struct omap_i2c_dev *dev = dev_id;
 	u16 iv, w;
 
-	if (dev->idle)
+	if (dev->flags & OMAP_I2C_IDLE)
 		return IRQ_NONE;
 
 	iv = omap_i2c_read_reg(dev, OMAP_I2C_IV_REG);
@@ -640,7 +655,7 @@ omap_i2c_isr(int this_irq, void *dev_id)
 	u16 stat, w;
 	int err, count = 0;
 
-	if (dev->idle)
+	if (dev->flags & OMAP_I2C_IDLE)
 		return IRQ_NONE;
 
 	bits = omap_i2c_read_reg(dev, OMAP_I2C_IE_REG);
@@ -806,7 +821,7 @@ omap_i2c_probe(struct platform_device *pdev)
 		speed = 100;	/* Defualt speed */
 
 	dev->speed = speed;
-	dev->idle = 1;
+	omap_i2c_set_flag(dev, OMAP_I2C_IDLE);
 	dev->dev = &pdev->dev;
 	dev->irq = irq->start;
 	dev->base = ioremap(mem->start, mem->end - mem->start + 1);
@@ -837,7 +852,7 @@ omap_i2c_probe(struct platform_device *pdev)
 		 * call back latencies.
 		 */
 		dev->fifo_size = (dev->fifo_size / 2);
-		dev->b_hw = 1; /* Enable hardware fixes */
+		omap_i2c_set_flag(dev, OMAP_I2C_BAD_HW);  /* Enable hw fixes */
 	}
 
 	/* reset ASAP, clearing any IRQs */


