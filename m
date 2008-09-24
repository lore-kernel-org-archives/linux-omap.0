From: "Madhusudhan Chikkature" <madhu.cr@ti.com>
Subject: [PATCH 1/9]HDQ driver: Remove global pointer
Date: Wed, 24 Sep 2008 16:49:40 +0530 (IST)
Message-ID: <43035.192.168.10.89.1222255180.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33592 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751359AbYIXLTv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Sep 2008 07:19:51 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: johnpol@2ka.mipt.ru, felipe.balbi@nokia.com, linux-omap@vger.kernel.org

From: Madhusudhan Chikkature<madhu.cr@ti.com>

This patch provides the necessary modifications to the driver to remove the
global ptr hdq_data.

Signed-off-by: Madhusudhan Chikkature<madhu.cr@ti.com>
---
 drivers/w1/masters/omap_hdq.c |  137 ++++++++++++++++++++++--------------------
 1 files changed, 72 insertions(+), 65 deletions(-)

Index: linux-omap-2.6/drivers/w1/masters/omap_hdq.c
===================================================================
--- linux-omap-2.6.orig/drivers/w1/masters/omap_hdq.c	2008-08-18
14:48:26.000000000 +0530
+++ linux-omap-2.6/drivers/w1/masters/omap_hdq.c	2008-09-23 12:39:19.000000000
+0530
@@ -62,11 +62,9 @@ struct hdq_data {
 	spinlock_t		hdq_spinlock;
 };

-static struct hdq_data *hdq_data;
-
-static int omap_hdq_get(void);
-static int omap_hdq_put(void);
-static int omap_hdq_break(void);
+static int omap_hdq_get(struct hdq_data *hdq_data);
+static int omap_hdq_put(struct hdq_data *hdq_data);
+static int omap_hdq_break(struct hdq_data *hdq_data);

 static int __init omap_hdq_probe(struct platform_device *pdev);
 static int omap_hdq_remove(struct platform_device *pdev);
@@ -81,12 +79,13 @@ static struct platform_driver omap_hdq_d
 	},
 };

-static u8 omap_w1_read_byte(void *data);
-static void omap_w1_write_byte(void *data, u8 byte);
-static u8 omap_w1_reset_bus(void *data);
-static void omap_w1_search_bus(void *data, u8 search_type,
+static u8 omap_w1_read_byte(void *_hdq);
+static void omap_w1_write_byte(void *_hdq, u8 byte);
+static u8 omap_w1_reset_bus(void *_hdq);
+static void omap_w1_search_bus(void *_hdq, u8 search_type,
 	w1_slave_found_callback slave_found);

+
 static struct w1_bus_master omap_w1_master = {
 	.read_byte	= omap_w1_read_byte,
 	.write_byte	= omap_w1_write_byte,
@@ -97,25 +96,25 @@ static struct w1_bus_master omap_w1_mast
 /*
  * HDQ register I/O routines
  */
-static inline u8
-hdq_reg_in(u32 offset)
+static inline u8 hdq_reg_in(struct hdq_data *hdq_data, u32 offset)
 {
 	return omap_readb(hdq_data->hdq_base + offset);
 }

-static inline u8
-hdq_reg_out(u32 offset, u8 val)
+static inline u8 hdq_reg_out(struct hdq_data *hdq_data, u32 offset, u8 val)
 {
 	omap_writeb(val, hdq_data->hdq_base + offset);
+
 	return val;
 }

-static inline u8
-hdq_reg_merge(u32 offset, u8 val, u8 mask)
+static inline u8 hdq_reg_merge(struct hdq_data *hdq_data, u32 offset,
+			u8 val, u8 mask)
 {
 	u8 new_val = (omap_readb(hdq_data->hdq_base + offset) & ~mask)
 			| (val & mask);
 	omap_writeb(new_val, hdq_data->hdq_base + offset);
+
 	return new_val;
 }

@@ -125,15 +124,15 @@ hdq_reg_merge(u32 offset, u8 val, u8 mas
  * HDQ_FLAG_CLEAR: wait until all bits in the flag are cleared.
  * return 0 on success and -ETIMEDOUT in the case of timeout.
  */
-static int
-hdq_wait_for_flag(u32 offset, u8 flag, u8 flag_set, u8 *status)
+static int hdq_wait_for_flag(struct hdq_data *hdq_data, u32 offset,
+		u8 flag, u8 flag_set, u8 *status)
 {
 	int ret = 0;
 	unsigned long timeout = jiffies + OMAP_HDQ_TIMEOUT;

 	if (flag_set == OMAP_HDQ_FLAG_CLEAR) {
 		/* wait for the flag clear */
-		while (((*status = hdq_reg_in(offset)) & flag)
+		while (((*status = hdq_reg_in(hdq_data, offset)) & flag)
 			&& time_before(jiffies, timeout)) {
 			set_current_state(TASK_UNINTERRUPTIBLE);
 			schedule_timeout(1);
@@ -142,7 +141,7 @@ hdq_wait_for_flag(u32 offset, u8 flag, u
 			ret = -ETIMEDOUT;
 	} else if (flag_set == OMAP_HDQ_FLAG_SET) {
 		/* wait for the flag set */
-		while (!((*status = hdq_reg_in(offset)) & flag)
+		while (!((*status = hdq_reg_in(hdq_data, offset)) & flag)
 			&& time_before(jiffies, timeout)) {
 			set_current_state(TASK_UNINTERRUPTIBLE);
 			schedule_timeout(1);
@@ -159,7 +158,7 @@ hdq_wait_for_flag(u32 offset, u8 flag, u
  * write out a byte and fill *status with HDQ_INT_STATUS
  */
 static int
-hdq_write_byte(u8 val, u8 *status)
+hdq_write_byte(struct hdq_data *hdq_data, u8 val, u8 *status)
 {
 	int ret;
 	u8 tmp_status;
@@ -169,15 +168,15 @@ hdq_write_byte(u8 val, u8 *status)

 	spin_lock_irqsave(&hdq_data->hdq_spinlock, irqflags);
 	/* clear interrupt flags via a dummy read */
-	hdq_reg_in(OMAP_HDQ_INT_STATUS);
+	hdq_reg_in(hdq_data, OMAP_HDQ_INT_STATUS);
 	/* ISR loads it with new INT_STATUS */
 	hdq_data->hdq_irqstatus = 0;
 	spin_unlock_irqrestore(&hdq_data->hdq_spinlock, irqflags);

-	hdq_reg_out(OMAP_HDQ_TX_DATA, val);
+	hdq_reg_out(hdq_data, OMAP_HDQ_TX_DATA, val);

 	/* set the GO bit */
-	hdq_reg_merge(OMAP_HDQ_CTRL_STATUS, OMAP_HDQ_CTRL_STATUS_GO,
+	hdq_reg_merge(hdq_data, OMAP_HDQ_CTRL_STATUS, OMAP_HDQ_CTRL_STATUS_GO,
 		OMAP_HDQ_CTRL_STATUS_DIR | OMAP_HDQ_CTRL_STATUS_GO);
 	/* wait for the TXCOMPLETE bit */
 	ret = wait_event_interruptible_timeout(hdq_wait_queue,
@@ -198,8 +197,9 @@ hdq_write_byte(u8 val, u8 *status)
 	}

 	/* wait for the GO bit return to zero */
-	ret = hdq_wait_for_flag(OMAP_HDQ_CTRL_STATUS, OMAP_HDQ_CTRL_STATUS_GO,
-		OMAP_HDQ_FLAG_CLEAR, &tmp_status);
+	ret = hdq_wait_for_flag(hdq_data, OMAP_HDQ_CTRL_STATUS,
+			OMAP_HDQ_CTRL_STATUS_GO,
+			OMAP_HDQ_FLAG_CLEAR, &tmp_status);
 	if (ret) {
 		pr_debug("timeout waiting GO bit return to zero, %x",
 			tmp_status);
@@ -212,13 +212,13 @@ hdq_write_byte(u8 val, u8 *status)
 /*
  * HDQ Interrupt service routine.
  */
-static irqreturn_t
-hdq_isr(int irq, void *arg)
+static irqreturn_t hdq_isr(int irq, void *_hdq)
 {
+	struct hdq_data *hdq_data = _hdq;
 	unsigned long irqflags;

 	spin_lock_irqsave(&hdq_data->hdq_spinlock, irqflags);
-	hdq_data->hdq_irqstatus = hdq_reg_in(OMAP_HDQ_INT_STATUS);
+	hdq_data->hdq_irqstatus = hdq_reg_in(hdq_data, OMAP_HDQ_INT_STATUS);
 	spin_unlock_irqrestore(&hdq_data->hdq_spinlock, irqflags);
 	pr_debug("hdq_isr: %x", hdq_data->hdq_irqstatus);

@@ -235,7 +235,7 @@ hdq_isr(int irq, void *arg)
 /*
  * HDQ Mode: always return success.
  */
-static u8 omap_w1_reset_bus(void *data)
+static u8 omap_w1_reset_bus(void *_hdq)
 {
 	return 0;
 }
@@ -243,7 +243,7 @@ static u8 omap_w1_reset_bus(void *data)
 /*
  * W1 search callback function.
  */
-static void omap_w1_search_bus(void *data, u8 search_type,
+static void omap_w1_search_bus(void *_hdq, u8 search_type,
 	w1_slave_found_callback slave_found)
 {
 	u64 module_id, rn_le, cs, id;
@@ -261,36 +261,36 @@ static void omap_w1_search_bus(void *dat
 	cs = w1_calc_crc8((u8 *)&rn_le, 7);
 	id = (cs << 56) | module_id;

-	slave_found(data, id);
+	slave_found(_hdq, id);
 }

-static int
-_omap_hdq_reset(void)
+static int _omap_hdq_reset(struct hdq_data *hdq_data)
 {
 	int ret;
 	u8 tmp_status;

-	hdq_reg_out(OMAP_HDQ_SYSCONFIG, OMAP_HDQ_SYSCONFIG_SOFTRESET);
+	hdq_reg_out(hdq_data, OMAP_HDQ_SYSCONFIG, OMAP_HDQ_SYSCONFIG_SOFTRESET);
 	/*
 	 * Select HDQ mode & enable clocks.
 	 * It is observed that INT flags can't be cleared via a read and GO/INIT
 	 * won't return to zero if interrupt is disabled. So we always enable
 	 * interrupt.
 	 */
-	hdq_reg_out(OMAP_HDQ_CTRL_STATUS,
+	hdq_reg_out(hdq_data, OMAP_HDQ_CTRL_STATUS,
 		OMAP_HDQ_CTRL_STATUS_CLOCKENABLE |
 		OMAP_HDQ_CTRL_STATUS_INTERRUPTMASK);

 	/* wait for reset to complete */
-	ret = hdq_wait_for_flag(OMAP_HDQ_SYSSTATUS,
+	ret = hdq_wait_for_flag(hdq_data, OMAP_HDQ_SYSSTATUS,
 		OMAP_HDQ_SYSSTATUS_RESETDONE, OMAP_HDQ_FLAG_SET, &tmp_status);
 	if (ret)
 		pr_debug("timeout waiting HDQ reset, %x", tmp_status);
 	else {
-		hdq_reg_out(OMAP_HDQ_CTRL_STATUS,
+		hdq_reg_out(hdq_data, OMAP_HDQ_CTRL_STATUS,
 			OMAP_HDQ_CTRL_STATUS_CLOCKENABLE |
 			OMAP_HDQ_CTRL_STATUS_INTERRUPTMASK);
-		hdq_reg_out(OMAP_HDQ_SYSCONFIG, OMAP_HDQ_SYSCONFIG_AUTOIDLE);
+		hdq_reg_out(hdq_data, OMAP_HDQ_SYSCONFIG,
+			OMAP_HDQ_SYSCONFIG_AUTOIDLE);
 	}

 	return ret;
@@ -300,7 +300,7 @@ _omap_hdq_reset(void)
  * Issue break pulse to the device.
  */
 static int
-omap_hdq_break()
+omap_hdq_break(struct hdq_data *hdq_data)
 {
 	int ret;
 	u8 tmp_status;
@@ -317,13 +317,13 @@ omap_hdq_break()

 	spin_lock_irqsave(&hdq_data->hdq_spinlock, irqflags);
 	/* clear interrupt flags via a dummy read */
-	hdq_reg_in(OMAP_HDQ_INT_STATUS);
+	hdq_reg_in(hdq_data, OMAP_HDQ_INT_STATUS);
 	/* ISR loads it with new INT_STATUS */
 	hdq_data->hdq_irqstatus = 0;
 	spin_unlock_irqrestore(&hdq_data->hdq_spinlock, irqflags);

 	/* set the INIT and GO bit */
-	hdq_reg_merge(OMAP_HDQ_CTRL_STATUS,
+	hdq_reg_merge(hdq_data, OMAP_HDQ_CTRL_STATUS,
 		OMAP_HDQ_CTRL_STATUS_INITIALIZATION | OMAP_HDQ_CTRL_STATUS_GO,
 		OMAP_HDQ_CTRL_STATUS_DIR | OMAP_HDQ_CTRL_STATUS_INITIALIZATION |
 		OMAP_HDQ_CTRL_STATUS_GO);
@@ -350,7 +350,7 @@ omap_hdq_break()
 	 * wait for both INIT and GO bits rerurn to zero.
 	 * zero wait time expected for interrupt mode.
 	 */
-	ret = hdq_wait_for_flag(OMAP_HDQ_CTRL_STATUS,
+	ret = hdq_wait_for_flag(hdq_data, OMAP_HDQ_CTRL_STATUS,
 			OMAP_HDQ_CTRL_STATUS_INITIALIZATION |
 			OMAP_HDQ_CTRL_STATUS_GO, OMAP_HDQ_FLAG_CLEAR,
 			&tmp_status);
@@ -362,7 +362,7 @@ omap_hdq_break()
 	return ret;
 }

-static int hdq_read_byte(u8 *val)
+static int hdq_read_byte(struct hdq_data *hdq_data, u8 *val)
 {
 	int ret;
 	u8 status;
@@ -378,7 +378,7 @@ static int hdq_read_byte(u8 *val)
 	}

 	if (!(hdq_data->hdq_irqstatus & OMAP_HDQ_INT_STATUS_RXCOMPLETE)) {
-		hdq_reg_merge(OMAP_HDQ_CTRL_STATUS,
+		hdq_reg_merge(hdq_data, OMAP_HDQ_CTRL_STATUS,
 			OMAP_HDQ_CTRL_STATUS_DIR | OMAP_HDQ_CTRL_STATUS_GO,
 			OMAP_HDQ_CTRL_STATUS_DIR | OMAP_HDQ_CTRL_STATUS_GO);
 		/*
@@ -395,7 +395,7 @@ static int hdq_read_byte(u8 *val)
 				schedule_timeout(1);
 			}
 		}
-		hdq_reg_merge(OMAP_HDQ_CTRL_STATUS, 0,
+		hdq_reg_merge(hdq_data, OMAP_HDQ_CTRL_STATUS, 0,
 			OMAP_HDQ_CTRL_STATUS_DIR);
 		spin_lock_irqsave(&hdq_data->hdq_spinlock, irqflags);
 		status = hdq_data->hdq_irqstatus;
@@ -408,7 +408,7 @@ static int hdq_read_byte(u8 *val)
 		}
 	}
 	/* the data is ready. Read it in! */
-	*val = hdq_reg_in(OMAP_HDQ_RX_DATA);
+	*val = hdq_reg_in(hdq_data, OMAP_HDQ_RX_DATA);
 	up(&hdq_data->hdq_semlock);

 	return 0;
@@ -419,7 +419,7 @@ static int hdq_read_byte(u8 *val)
  * Enable clocks and set the controller to HDQ mode.
  */
 static int
-omap_hdq_get()
+omap_hdq_get(struct hdq_data *hdq_data)
 {
 	int ret = 0;

@@ -451,20 +451,20 @@ omap_hdq_get()
 			}

 			/* make sure HDQ is out of reset */
-			if (!(hdq_reg_in(OMAP_HDQ_SYSSTATUS) &
+			if (!(hdq_reg_in(hdq_data, OMAP_HDQ_SYSSTATUS) &
 				OMAP_HDQ_SYSSTATUS_RESETDONE)) {
-				ret = _omap_hdq_reset();
+				ret = _omap_hdq_reset(hdq_data);
 				if (ret)
 					/* back up the count */
 					hdq_data->hdq_usecount--;
 			} else {
 				/* select HDQ mode & enable clocks */
-				hdq_reg_out(OMAP_HDQ_CTRL_STATUS,
+				hdq_reg_out(hdq_data, OMAP_HDQ_CTRL_STATUS,
 					OMAP_HDQ_CTRL_STATUS_CLOCKENABLE |
 					OMAP_HDQ_CTRL_STATUS_INTERRUPTMASK);
-				hdq_reg_out(OMAP_HDQ_SYSCONFIG,
+				hdq_reg_out(hdq_data, OMAP_HDQ_SYSCONFIG,
 					OMAP_HDQ_SYSCONFIG_AUTOIDLE);
-				hdq_reg_in(OMAP_HDQ_INT_STATUS);
+				hdq_reg_in(hdq_data, OMAP_HDQ_INT_STATUS);
 			}
 		}
 	}
@@ -476,7 +476,7 @@ omap_hdq_get()
  * Disable clocks to the module.
  */
 static int
-omap_hdq_put()
+omap_hdq_put(struct hdq_data *hdq_data)
 {
 	int ret = 0;

@@ -509,22 +509,23 @@ static int init_trans;
 /*
  * Read a byte of data from the device.
  */
-static u8 omap_w1_read_byte(void *data)
+static u8 omap_w1_read_byte(void *_hdq)
 {
+	struct hdq_data *hdq_data = _hdq;
 	u8 val;
 	int ret;

-	ret = hdq_read_byte(&val);
+	ret = hdq_read_byte(hdq_data, &val);
 	if (ret) {
 		init_trans = 0;
-		omap_hdq_put();
+		omap_hdq_put(hdq_data);
 		return -1;
 	}

 	/* Write followed by a read, release the module */
 	if (init_trans) {
 		init_trans = 0;
-		omap_hdq_put();
+		omap_hdq_put(hdq_data);
 	}

 	return val;
@@ -533,22 +534,23 @@ static u8 omap_w1_read_byte(void *data)
 /*
  * Write a byte of data to the device.
  */
-static void omap_w1_write_byte(void *data, u8 byte)
+static void omap_w1_write_byte(void *_hdq, u8 byte)
 {
+	struct hdq_data *hdq_data = _hdq;
 	u8 status;

 	/* First write to initialize the transfer */
 	if (init_trans == 0)
-		omap_hdq_get();
+		omap_hdq_get(hdq_data);

 	init_trans++;

-	hdq_write_byte(byte, &status);
+	hdq_write_byte(hdq_data, byte, &status);
 	pr_debug("Ctrl status %x\n", status);

 	/* Second write, data transfered. Release the module */
 	if (init_trans > 1) {
-		omap_hdq_put();
+		omap_hdq_put(hdq_data);
 		init_trans = 0;
 	}

@@ -557,6 +559,7 @@ static void omap_w1_write_byte(void *dat

 static int __init omap_hdq_probe(struct platform_device *pdev)
 {
+	struct hdq_data *hdq_data;
 	struct resource *res;
 	int ret, irq;
 	u8 rev;
@@ -621,12 +624,12 @@ static int __init omap_hdq_probe(struct
 		return -ENODEV;
 	}

-	rev = hdq_reg_in(OMAP_HDQ_REVISION);
+	rev = hdq_reg_in(hdq_data, OMAP_HDQ_REVISION);
 	pr_info("OMAP HDQ Hardware Revision %c.%c. Driver in %s mode.\n",
 		(rev >> 4) + '0', (rev & 0x0f) + '0', "Interrupt");

 	spin_lock_init(&hdq_data->hdq_spinlock);
-	omap_hdq_break();
+	omap_hdq_break(hdq_data);

 	irq = platform_get_irq(pdev, 0);
 	if (irq	< 0) {
@@ -636,7 +639,7 @@ static int __init omap_hdq_probe(struct
 	}

 	if (request_irq(irq, hdq_isr, IRQF_DISABLED, "OMAP HDQ",
-		&hdq_data->hdq_semlock)) {
+		hdq_data)) {
 		pr_debug("request_irq failed\n");
 		clk_disable(hdq_data->hdq_ick);
 		clk_put(hdq_data->hdq_ick);
@@ -650,6 +653,8 @@ static int __init omap_hdq_probe(struct
 	clk_disable(hdq_data->hdq_ick);
 	clk_disable(hdq_data->hdq_fck);

+	omap_w1_master.data = hdq_data;
+
 	ret = w1_add_master_device(&omap_w1_master);
 	if (ret) {
 		pr_debug("Failure in registering w1 master\n");
@@ -665,6 +670,8 @@ static int __init omap_hdq_probe(struct

 static int omap_hdq_remove(struct platform_device *pdev)
 {
+	struct hdq_data *hdq_data = platform_get_drvdata(pdev);
+
 	down_interruptible(&hdq_data->hdq_semlock);
 	if (0 != hdq_data->hdq_usecount) {
 		pr_debug("removed when use count is not zero\n");
@@ -675,7 +682,7 @@ static int omap_hdq_remove(struct platfo
 	/* remove module dependency */
 	clk_put(hdq_data->hdq_ick);
 	clk_put(hdq_data->hdq_fck);
-	free_irq(INT_24XX_HDQ_IRQ, &hdq_data->hdq_semlock);
+	free_irq(INT_24XX_HDQ_IRQ, hdq_data);
 	platform_set_drvdata(pdev, NULL);
 	kfree(hdq_data);



