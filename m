From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH]OMAP HDQ driver ioremap changes
Date: Mon, 22 Sep 2008 17:37:41 +0300
Message-ID: <20080922143741.GV24627@gandalf.research.nokia.com>
References: <43198.192.168.10.89.1222078557.squirrel@dbdmail.itg.ti.com> <20080922130621.GC30680@2ka.mipt.ru> <018001c91cb4$f8088a10$LocalHost@wipultra1303> <20080922132717.GR24627@gandalf.research.nokia.com> <01c201c91cb7$97e06bf0$LocalHost@wipultra1303>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0OAP2g/MAC+5xKAE"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:47601 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752181AbYIVOie (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Sep 2008 10:38:34 -0400
Content-Disposition: inline
In-Reply-To: <01c201c91cb7$97e06bf0$LocalHost@wipultra1303>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Madhusudhan Chikkature <madhu.cr@ti.com>
Cc: felipe.balbi@nokia.com, Evgeniy Polyakov <johnpol@2ka.mipt.ru>, tony@atomide.com, linux-omap@vger.kernel.org


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 22, 2008 at 07:01:57PM +0530, ext Madhusudhan Chikkature wrote:
> 
> ----- Original Message ----- 
> From: "Felipe Balbi" <felipe.balbi@nokia.com>
> To: "ext Madhusudhan Chikkature" <madhu.cr@ti.com>
> Cc: "Evgeniy Polyakov" <johnpol@2ka.mipt.ru>; <tony@atomide.com>; <linux-omap@vger.kernel.org>
> Sent: Monday, September 22, 2008 6:57 PM
> Subject: Re: [PATCH]OMAP HDQ driver ioremap changes
> 
> 
> > On Mon, Sep 22, 2008 at 06:43:10PM +0530, ext Madhusudhan Chikkature wrote:
> >> Hi Evgeniy Polyakov,
> >> 
> >> Thanks for the comments. I will incorporate them and send the patch again. My comments inlined.
> > 
> > How about fixing it and later sending to mainline for integration ?
> 
> Yes. I will do that.

Really, that driver is a mess. Get the attached patch, break it into
proper smaller patches, see if it's really working since I just compile
tested, change the semaphore to mutex (in a separate patch), fix
comments to kernel-doc style, then you send a nice series fixing the
driver before sending the final driver to mainline.

It's time to start doing things properly. It's really annoying have to
keep cleaning stuff after it's in-tree.

-- 
balbi

--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0001-w1-clean-up-a-lot-omap_hdq.c.diff"

>From 3c916a3e83f04d1ecc57886dc40be19bed46ec23 Mon Sep 17 00:00:00 2001
From: Felipe Balbi <felipe.balbi@nokia.com>
Date: Mon, 22 Sep 2008 17:35:56 +0300
Subject: [PATCH] w1: clean up a *lot* omap_hdq.c

The driver is a mess, this patch should be broken in
smaller pieces to be applied.

Not-Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/w1/masters/omap_hdq.c |  379 ++++++++++++++++++++++-------------------
 1 files changed, 201 insertions(+), 178 deletions(-)

diff --git a/drivers/w1/masters/omap_hdq.c b/drivers/w1/masters/omap_hdq.c
index 880e282..85a3473 100644
--- a/drivers/w1/masters/omap_hdq.c
+++ b/drivers/w1/masters/omap_hdq.c
@@ -8,6 +8,7 @@
  * kind, whether express or implied.
  *
  */
+
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
@@ -49,42 +50,47 @@
 
 #define OMAP_HDQ_MAX_USER			4
 
-DECLARE_WAIT_QUEUE_HEAD(hdq_wait_queue);
-int W1_ID;
+/*
+ * Used to control the call to omap_hdq_get and omap_hdq_put.
+ * HDQ Protocol: Write the CMD|REG_address first, followed by
+ * the data wrire or read.
+ */
+static int init_trans;
+
+static DECLARE_WAIT_QUEUE_HEAD(hdq_wait_queue);
+static int w1_id;
 
 struct hdq_data {
-	resource_size_t		hdq_base;
+	struct device		*dev;
+	void __iomem		*hdq_base;
 	struct	semaphore	hdq_semlock;
 	int			hdq_usecount;
 	struct	clk		*hdq_ick;
 	struct	clk		*hdq_fck;
 	u8			hdq_irqstatus;
+	/* device lock */
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
 
 static struct platform_driver omap_hdq_driver = {
-	.probe = omap_hdq_probe,
-	.remove = omap_hdq_remove,
-	.suspend = NULL,
-	.resume = NULL,
-	.driver = {
-		.name = "omap_hdq",
+	.probe		= omap_hdq_probe,
+	.remove		= omap_hdq_remove,
+	.driver		= {
+		.name	= "omap_hdq",
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
 
 static struct w1_bus_master omap_w1_master = {
@@ -97,25 +103,25 @@ static struct w1_bus_master omap_w1_master = {
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
+		u8 val, u8 mask)
 {
 	u8 new_val = (omap_readb(hdq_data->hdq_base + offset) & ~mask)
 			| (val & mask);
 	omap_writeb(new_val, hdq_data->hdq_base + offset);
+
 	return new_val;
 }
 
@@ -125,32 +131,33 @@ hdq_reg_merge(u32 offset, u8 val, u8 mask)
  * HDQ_FLAG_CLEAR: wait until all bits in the flag are cleared.
  * return 0 on success and -ETIMEDOUT in the case of timeout.
  */
-static int
-hdq_wait_for_flag(u32 offset, u8 flag, u8 flag_set, u8 *status)
+static int hdq_wait_for_flag(struct hdq_data *hdq_data, u32 offset,
+		u8 flag, u8 flag_set, u8 *status)
 {
-	int ret = 0;
 	unsigned long timeout = jiffies + OMAP_HDQ_TIMEOUT;
+	int ret = 0;
 
 	if (flag_set == OMAP_HDQ_FLAG_CLEAR) {
 		/* wait for the flag clear */
-		while (((*status = hdq_reg_in(offset)) & flag)
+		while (((*status = hdq_reg_in(hdq_data, offset)) & flag)
 			&& time_before(jiffies, timeout)) {
 			set_current_state(TASK_UNINTERRUPTIBLE);
 			schedule_timeout(1);
 		}
-		if (unlikely(*status & flag))
+		if (*status & flag)
 			ret = -ETIMEDOUT;
 	} else if (flag_set == OMAP_HDQ_FLAG_SET) {
 		/* wait for the flag set */
-		while (!((*status = hdq_reg_in(offset)) & flag)
+		while (!((*status = hdq_reg_in(hdq_data, offset)) & flag)
 			&& time_before(jiffies, timeout)) {
 			set_current_state(TASK_UNINTERRUPTIBLE);
 			schedule_timeout(1);
 		}
-		if (unlikely(!(*status & flag)))
+		if (!(*status & flag))
 			ret = -ETIMEDOUT;
-	} else
+	} else {
 		return -EINVAL;
+	}
 
 	return ret;
 }
@@ -158,32 +165,31 @@ hdq_wait_for_flag(u32 offset, u8 flag, u8 flag_set, u8 *status)
 /*
  * write out a byte and fill *status with HDQ_INT_STATUS
  */
-static int
-hdq_write_byte(u8 val, u8 *status)
+static int hdq_write_byte(struct hdq_data *hdq_data, u8 val, u8 *status)
 {
-	int ret;
-	u8 tmp_status;
 	unsigned long irqflags;
+	u8 tmp_status;
+	int ret;
 
 	*status = 0;
 
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
 		hdq_data->hdq_irqstatus, OMAP_HDQ_TIMEOUT);
-	if (unlikely(ret < 0)) {
-		pr_debug("wait interrupted");
+	if (ret < 0) {
+		dev_dbg(hdq_data->dev, "wait interrupted");
 		return -EINTR;
 	}
 
@@ -192,17 +198,20 @@ hdq_write_byte(u8 val, u8 *status)
 	spin_unlock_irqrestore(&hdq_data->hdq_spinlock, irqflags);
 	/* check irqstatus */
 	if (!(*status & OMAP_HDQ_INT_STATUS_TXCOMPLETE)) {
-		pr_debug("timeout waiting for TXCOMPLETE/RXCOMPLETE, %x",
-			*status);
+		dev_dbg(hdq_data->dev,
+				"timeout waiting for TXCOMPLETE/RXCOMPLETE, %x",
+				*status);
 		return -ETIMEDOUT;
 	}
 
 	/* wait for the GO bit return to zero */
-	ret = hdq_wait_for_flag(OMAP_HDQ_CTRL_STATUS, OMAP_HDQ_CTRL_STATUS_GO,
-		OMAP_HDQ_FLAG_CLEAR, &tmp_status);
+	ret = hdq_wait_for_flag(hdq_data, OMAP_HDQ_CTRL_STATUS,
+			OMAP_HDQ_CTRL_STATUS_GO,
+			OMAP_HDQ_FLAG_CLEAR, &tmp_status);
 	if (ret) {
-		pr_debug("timeout waiting GO bit return to zero, %x",
-			tmp_status);
+		dev_dbg(hdq_data->dev,
+				"timeout waiting GO bit return to zero, %x",
+				tmp_status);
 		return ret;
 	}
 
@@ -212,15 +221,15 @@ hdq_write_byte(u8 val, u8 *status)
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
-	pr_debug("hdq_isr: %x", hdq_data->hdq_irqstatus);
+	dev_dbg(hdq_data->dev, "hdq_isr: %x", hdq_data->hdq_irqstatus);
 
 	if (hdq_data->hdq_irqstatus &
 		(OMAP_HDQ_INT_STATUS_TXCOMPLETE | OMAP_HDQ_INT_STATUS_RXCOMPLETE
@@ -248,8 +257,8 @@ static void omap_w1_search_bus(void *data, u8 search_type,
 {
 	u64 module_id, rn_le, cs, id;
 
-	if (W1_ID)
-		module_id = W1_ID;
+	if (w1_id)
+		module_id = w1_id;
 	else
 		module_id = 0x1;
 
@@ -264,33 +273,34 @@ static void omap_w1_search_bus(void *data, u8 search_type,
 	slave_found(data, id);
 }
 
-static int
-_omap_hdq_reset(void)
+static int _omap_hdq_reset(struct hdq_data *hdq_data)
 {
-	int ret;
 	u8 tmp_status;
+	int ret;
 
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
-	if (ret)
-		pr_debug("timeout waiting HDQ reset, %x", tmp_status);
-	else {
-		hdq_reg_out(OMAP_HDQ_CTRL_STATUS,
+	if (ret) {
+		dev_dbg(hdq_data->dev, "timeout waiting HDQ reset, %x",
+				tmp_status);
+	} else {
+		hdq_reg_out(hdq_data, OMAP_HDQ_CTRL_STATUS,
 			OMAP_HDQ_CTRL_STATUS_CLOCKENABLE |
 			OMAP_HDQ_CTRL_STATUS_INTERRUPTMASK);
-		hdq_reg_out(OMAP_HDQ_SYSCONFIG, OMAP_HDQ_SYSCONFIG_AUTOIDLE);
+		hdq_reg_out(hdq_data, OMAP_HDQ_SYSCONFIG,
+				OMAP_HDQ_SYSCONFIG_AUTOIDLE);
 	}
 
 	return ret;
@@ -299,12 +309,11 @@ _omap_hdq_reset(void)
 /*
  * Issue break pulse to the device.
  */
-static int
-omap_hdq_break()
+static int omap_hdq_break(struct hdq_data *hdq_data)
 {
-	int ret;
-	u8 tmp_status;
 	unsigned long irqflags;
+	u8 tmp_status;
+	int ret;
 
 	ret = down_interruptible(&hdq_data->hdq_semlock);
 	if (ret < 0)
@@ -317,13 +326,13 @@ omap_hdq_break()
 
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
@@ -331,8 +340,8 @@ omap_hdq_break()
 	/* wait for the TIMEOUT bit */
 	ret = wait_event_interruptible_timeout(hdq_wait_queue,
 		hdq_data->hdq_irqstatus, OMAP_HDQ_TIMEOUT);
-	if (unlikely(ret < 0)) {
-		pr_debug("wait interrupted");
+	if (ret < 0) {
+		dev_dbg(hdq_data->dev, "wait interrupted");
 		up(&hdq_data->hdq_semlock);
 		return -EINTR;
 	}
@@ -340,33 +349,39 @@ omap_hdq_break()
 	spin_lock_irqsave(&hdq_data->hdq_spinlock, irqflags);
 	tmp_status = hdq_data->hdq_irqstatus;
 	spin_unlock_irqrestore(&hdq_data->hdq_spinlock, irqflags);
+
 	/* check irqstatus */
 	if (!(tmp_status & OMAP_HDQ_INT_STATUS_TIMEOUT)) {
-		pr_debug("timeout waiting for TIMEOUT, %x", tmp_status);
+		dev_dbg(hdq_data->dev, "timeout waiting for TIMEOUT, %x",
+				tmp_status);
 		up(&hdq_data->hdq_semlock);
 		return -ETIMEDOUT;
 	}
+
 	/*
 	 * wait for both INIT and GO bits rerurn to zero.
 	 * zero wait time expected for interrupt mode.
 	 */
-	ret = hdq_wait_for_flag(OMAP_HDQ_CTRL_STATUS,
+	ret = hdq_wait_for_flag(hdq_data, OMAP_HDQ_CTRL_STATUS,
 			OMAP_HDQ_CTRL_STATUS_INITIALIZATION |
 			OMAP_HDQ_CTRL_STATUS_GO, OMAP_HDQ_FLAG_CLEAR,
 			&tmp_status);
 	if (ret)
-		pr_debug("timeout waiting INIT&GO bits return to zero, %x",
+		dev_dbg(hdq_data->dev,
+			"timeout waiting INIT&GO bits return to zero, %x",
 			tmp_status);
 
 	up(&hdq_data->hdq_semlock);
+
 	return ret;
 }
 
-static int hdq_read_byte(u8 *val)
+static int hdq_read_byte(struct hdq_data *hdq_data, u8 *val)
 {
-	int ret;
-	u8 status;
+	unsigned long timeout = jiffies + OMAP_HDQ_TIMEOUT;
 	unsigned long irqflags;
+	u8 status;
+	int ret;
 
 	ret = down_interruptible(&hdq_data->hdq_semlock);
 	if (ret < 0)
@@ -378,7 +393,7 @@ static int hdq_read_byte(u8 *val)
 	}
 
 	if (!(hdq_data->hdq_irqstatus & OMAP_HDQ_INT_STATUS_RXCOMPLETE)) {
-		hdq_reg_merge(OMAP_HDQ_CTRL_STATUS,
+		hdq_reg_merge(hdq_data, OMAP_HDQ_CTRL_STATUS,
 			OMAP_HDQ_CTRL_STATUS_DIR | OMAP_HDQ_CTRL_STATUS_GO,
 			OMAP_HDQ_CTRL_STATUS_DIR | OMAP_HDQ_CTRL_STATUS_GO);
 		/*
@@ -386,29 +401,28 @@ static int hdq_read_byte(u8 *val)
 		 * triggers another interrupt before we
 		 * sleep. So we have to wait for RXCOMPLETE bit.
 		 */
-		{
-			unsigned long timeout = jiffies + OMAP_HDQ_TIMEOUT;
-			while (!(hdq_data->hdq_irqstatus
-				& OMAP_HDQ_INT_STATUS_RXCOMPLETE)
+		while (!(hdq_data->hdq_irqstatus
+					& OMAP_HDQ_INT_STATUS_RXCOMPLETE)
 				&& time_before(jiffies, timeout)) {
-				set_current_state(TASK_UNINTERRUPTIBLE);
-				schedule_timeout(1);
-			}
+			set_current_state(TASK_UNINTERRUPTIBLE);
+			schedule_timeout(1);
 		}
-		hdq_reg_merge(OMAP_HDQ_CTRL_STATUS, 0,
+
+		hdq_reg_merge(hdq_data, OMAP_HDQ_CTRL_STATUS, 0,
 			OMAP_HDQ_CTRL_STATUS_DIR);
 		spin_lock_irqsave(&hdq_data->hdq_spinlock, irqflags);
 		status = hdq_data->hdq_irqstatus;
 		spin_unlock_irqrestore(&hdq_data->hdq_spinlock, irqflags);
 		/* check irqstatus */
 		if (!(status & OMAP_HDQ_INT_STATUS_RXCOMPLETE)) {
-			pr_debug("timeout waiting for RXCOMPLETE, %x", status);
+			dev_dbg(hdq_data->dev,
+				"timeout waiting for RXCOMPLETE, %x", status);
 			up(&hdq_data->hdq_semlock);
 			return -ETIMEDOUT;
 		}
 	}
 	/* the data is ready. Read it in! */
-	*val = hdq_reg_in(OMAP_HDQ_RX_DATA);
+	*val = hdq_reg_in(hdq_data, OMAP_HDQ_RX_DATA);
 	up(&hdq_data->hdq_semlock);
 
 	return 0;
@@ -418,8 +432,7 @@ static int hdq_read_byte(u8 *val)
 /*
  * Enable clocks and set the controller to HDQ mode.
  */
-static int
-omap_hdq_get()
+static int omap_hdq_get(struct hdq_data *hdq_data)
 {
 	int ret = 0;
 
@@ -428,7 +441,7 @@ omap_hdq_get()
 		return -EINTR;
 
 	if (OMAP_HDQ_MAX_USER == hdq_data->hdq_usecount) {
-		pr_debug("attempt to exceed the max use count");
+		dev_dbg(hdq_data->dev, "attempt to exceed the max use count");
 		up(&hdq_data->hdq_semlock);
 		ret = -EINVAL;
 	} else {
@@ -436,14 +449,14 @@ omap_hdq_get()
 		try_module_get(THIS_MODULE);
 		if (1 == hdq_data->hdq_usecount) {
 			if (clk_enable(hdq_data->hdq_ick)) {
-				pr_debug("Can not enable ick\n");
+				dev_dbg(hdq_data->dev, "Can not enable ick\n");
 				clk_put(hdq_data->hdq_ick);
 				clk_put(hdq_data->hdq_fck);
 				up(&hdq_data->hdq_semlock);
 				return -ENODEV;
 			}
 			if (clk_enable(hdq_data->hdq_fck)) {
-				pr_debug("Can not enable fck\n");
+				dev_dbg(hdq_data->dev, "Can not enable fck\n");
 				clk_put(hdq_data->hdq_ick);
 				clk_put(hdq_data->hdq_fck);
 				up(&hdq_data->hdq_semlock);
@@ -451,32 +464,32 @@ omap_hdq_get()
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
 	up(&hdq_data->hdq_semlock);
+
 	return ret;
 }
 
 /*
  * Disable clocks to the module.
  */
-static int
-omap_hdq_put()
+static int omap_hdq_put(struct hdq_data *hdq_data)
 {
 	int ret = 0;
 
@@ -485,7 +498,8 @@ omap_hdq_put()
 		return -EINTR;
 
 	if (0 == hdq_data->hdq_usecount) {
-		pr_debug("attempt to decrement use count when it is zero");
+		dev_dbg(hdq_data->dev,
+			"attempt to decrement use count when it is zero");
 		ret = -EINVAL;
 	} else {
 		hdq_data->hdq_usecount--;
@@ -496,35 +510,30 @@ omap_hdq_put()
 		}
 	}
 	up(&hdq_data->hdq_semlock);
+
 	return ret;
 }
 
 /*
- * Used to control the call to omap_hdq_get and omap_hdq_put.
- * HDQ Protocol: Write the CMD|REG_address first, followed by
- * the data wrire or read.
- */
-static int init_trans;
-
-/*
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
@@ -533,30 +542,30 @@ static u8 omap_w1_read_byte(void *data)
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
-	pr_debug("Ctrl status %x\n", status);
+	hdq_write_byte(hdq_data, byte, &status);
+	dev_dbg(hdq_data->dev, "Ctrl status %x\n", status);
 
 	/* Second write, data transfered. Release the module */
 	if (init_trans > 1) {
-		omap_hdq_put();
+		omap_hdq_put(hdq_data);
 		init_trans = 0;
 	}
-
-	return;
 }
 
 static int __init omap_hdq_probe(struct platform_device *pdev)
 {
+	struct hdq_data *hdq_data;
 	struct resource *res;
 	int ret, irq;
 	u8 rev;
@@ -565,37 +574,42 @@ static int __init omap_hdq_probe(struct platform_device *pdev)
 		return -ENODEV;
 
 	hdq_data = kmalloc(sizeof(*hdq_data), GFP_KERNEL);
-	if (!hdq_data)
-		return -ENODEV;
+	if (!hdq_data) {
+		dev_dbg(&pdev->dev, "unable to allocate memory\n");
+		ret = -ENODEV;
+		goto err_kmalloc;
+	}
 
+	hdq_data->dev = &pdev->dev;
 	platform_set_drvdata(pdev, hdq_data);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (res == NULL) {
-		platform_set_drvdata(pdev, NULL);
-		kfree(hdq_data);
-		return -ENXIO;
+	if (!res) {
+		dev_dbg(&pdev->dev, "unable to get resource\n");
+		ret = ENXIO;
+		goto err_resource;
 	}
 
-	hdq_data->hdq_base = res->start;
+	hdq_data->hdq_base = ioremap(res->start, res->end - res->start + 1);
+	if (!hdq_data->hdq_base) {
+		dev_dbg(&pdev->dev, "ioremap failed\n");
+		ret = -EINVAL;
+		goto err_ioremap;
+	}
 
 	/* get interface & functional clock objects */
 	hdq_data->hdq_ick = clk_get(&pdev->dev, "hdq_ick");
 	hdq_data->hdq_fck = clk_get(&pdev->dev, "hdq_fck");
 
 	if (IS_ERR(hdq_data->hdq_ick) || IS_ERR(hdq_data->hdq_fck)) {
-		pr_debug("Can't get HDQ clock objects\n");
+		dev_dbg(&pdev->dev, "could not get HDQ clock objects\n");
 		if (IS_ERR(hdq_data->hdq_ick)) {
 			ret = PTR_ERR(hdq_data->hdq_ick);
-			platform_set_drvdata(pdev, NULL);
-			kfree(hdq_data);
-			return ret;
+			goto err_clk;
 		}
 		if (IS_ERR(hdq_data->hdq_fck)) {
 			ret = PTR_ERR(hdq_data->hdq_fck);
-			platform_set_drvdata(pdev, NULL);
-			kfree(hdq_data);
-			return ret;
+			goto err_clk;
 		}
 	}
 
@@ -603,71 +617,82 @@ static int __init omap_hdq_probe(struct platform_device *pdev)
 	sema_init(&hdq_data->hdq_semlock, 1);
 
 	if (clk_enable(hdq_data->hdq_ick)) {
-		pr_debug("Can not enable ick\n");
-		clk_put(hdq_data->hdq_ick);
-		clk_put(hdq_data->hdq_fck);
-		platform_set_drvdata(pdev, NULL);
-		kfree(hdq_data);
-		return -ENODEV;
+		dev_dbg(&pdev->dev, "could not enable ick\n");
+		ret = -ENODEV;
+		goto err_ick;
 	}
 
 	if (clk_enable(hdq_data->hdq_fck)) {
-		pr_debug("Can not enable fck\n");
-		clk_disable(hdq_data->hdq_ick);
-		clk_put(hdq_data->hdq_ick);
-		clk_put(hdq_data->hdq_fck);
-		platform_set_drvdata(pdev, NULL);
-		kfree(hdq_data);
-		return -ENODEV;
+		dev_dbg(&pdev->dev, "could not enable fck\n");
+		ret = -ENODEV;
+		goto err_fck;
 	}
 
-	rev = hdq_reg_in(OMAP_HDQ_REVISION);
-	pr_info("OMAP HDQ Hardware Revision %c.%c. Driver in %s mode.\n",
-		(rev >> 4) + '0', (rev & 0x0f) + '0', "Interrupt");
+	rev = hdq_reg_in(hdq_data, OMAP_HDQ_REVISION);
+	dev_info(&pdev->dev, "OMAP HDQ Hardware Revision %c.%c. Driver "
+			"in %s mode.\n", (rev >> 4) + '0', (rev & 0x0f)
+			+ '0', "Interrupt");
 
 	spin_lock_init(&hdq_data->hdq_spinlock);
-	omap_hdq_break();
+	omap_hdq_break(hdq_data);
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq	< 0) {
-		platform_set_drvdata(pdev, NULL);
-		kfree(hdq_data);
-		return -ENXIO;
+		ret = -ENXIO;
+		goto err_irq;
 	}
 
-	if (request_irq(irq, hdq_isr, IRQF_DISABLED, "OMAP HDQ",
-		&hdq_data->hdq_semlock)) {
-		pr_debug("request_irq failed\n");
-		clk_disable(hdq_data->hdq_ick);
-		clk_put(hdq_data->hdq_ick);
-		clk_put(hdq_data->hdq_fck);
-		platform_set_drvdata(pdev, NULL);
-		kfree(hdq_data);
-		return -ENODEV;
+	ret = request_irq(irq, hdq_isr, IRQF_DISABLED, "omap_hdq", &hdq_data);
+	if (ret < 0) {
+		dev_dbg(&pdev->dev, "could not request irq\n");
+		goto err_irq;
 	}
 
 	/* don't clock the HDQ until it is needed */
 	clk_disable(hdq_data->hdq_ick);
 	clk_disable(hdq_data->hdq_fck);
 
+	omap_w1_master.data = hdq_data;
+
 	ret = w1_add_master_device(&omap_w1_master);
 	if (ret) {
-		pr_debug("Failure in registering w1 master\n");
-		clk_put(hdq_data->hdq_ick);
-		clk_put(hdq_data->hdq_fck);
-		platform_set_drvdata(pdev, NULL);
-		kfree(hdq_data);
-		return ret;
+		dev_dbg(&pdev->dev, "could not register w1 master\n");
+		goto err_w1;
 	}
 
 	return 0;
+
+err_w1:
+err_irq:
+	clk_disable(hdq_data->hdq_fck);
+
+err_fck:
+	clk_disable(hdq_data->hdq_ick);
+
+err_ick:
+	clk_put(hdq_data->hdq_ick);
+	clk_put(hdq_data->hdq_fck);
+
+err_clk:
+	hdq_data->hdq_base = NULL;
+
+err_ioremap:
+err_resource:
+	platform_set_drvdata(pdev, NULL);
+	kfree(hdq_data);
+
+err_kmalloc:
+
+	return ret;
 }
 
 static int omap_hdq_remove(struct platform_device *pdev)
 {
-	down_interruptible(&hdq_data->hdq_semlock);
+	struct hdq_data *hdq_data = platform_get_drvdata(pdev);
+
+	down(&hdq_data->hdq_semlock);
 	if (0 != hdq_data->hdq_usecount) {
-		pr_debug("removed when use count is not zero\n");
+		dev_dbg(&pdev->dev, "removed when use count is not zero\n");
 		return -EBUSY;
 	}
 	up(&hdq_data->hdq_semlock);
@@ -682,23 +707,21 @@ static int omap_hdq_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static int __init
-omap_hdq_init(void)
+static int __init omap_hdq_init(void)
 {
 	return platform_driver_register(&omap_hdq_driver);
 }
+module_init(omap_hdq_init);
 
-static void __exit
-omap_hdq_exit(void)
+static void __exit omap_hdq_exit(void)
 {
 	platform_driver_unregister(&omap_hdq_driver);
 }
-
-module_init(omap_hdq_init);
 module_exit(omap_hdq_exit);
 
-module_param(W1_ID, int, S_IRUSR);
+module_param(w1_id, int, S_IRUSR);
 
 MODULE_AUTHOR("Texas Instruments");
 MODULE_DESCRIPTION("HDQ driver Library");
 MODULE_LICENSE("GPL");
+
-- 
1.6.0.1.308.gede4c


--0OAP2g/MAC+5xKAE--
