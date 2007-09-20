From: Carlos Aguiar <carlos.aguiar@indt.org.br>
Subject: [PATCH 01/14] MMC: OMAP: Introduce new structs for mmc multislot
 support
Date: Thu, 20 Sep 2007 11:03:04 -0400
Message-ID: <46F28BA8.9060409@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: omap-linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

From: Juha Yrjola <juha.yrjola@solidboot.com>

Introduces new structures for MMC multislot support and
also changes (implement functions and handlers on OMAP
MMC host) to use such support.

Signed-off-by: Juha Yrjola <juha.yrjola@solidboot.com>
Signed-off-by: Jarkko Lavinen <jarkko.lavinen@nokia.com>
Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>
---
 drivers/mmc/host/omap.c |  574 ++++++++++++++++++++++++++++++-----------------
 1 files changed, 364 insertions(+), 210 deletions(-)

diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index 0b59e9e..50f0561 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -32,6 +32,7 @@
 #include <asm/mach-types.h>
 
 #include <asm/arch/board.h>
+#include <asm/arch/mmc.h>
 #include <asm/arch/gpio.h>
 #include <asm/arch/dma.h>
 #include <asm/arch/mux.h>
@@ -97,7 +98,25 @@
  * when the cover switch is open */
 #define OMAP_MMC_SWITCH_POLL_DELAY	500
 
-static int mmc_omap_enable_poll = 1;
+struct mmc_omap_host;
+
+struct mmc_omap_slot {
+	int                     id;
+	unsigned int            vdd;
+	u16                     saved_con;
+	u16                     bus_mode;
+	unsigned int            fclk_freq;
+	unsigned                powered:1;
+
+	struct work_struct      switch_work;
+	struct timer_list       switch_timer;
+	unsigned                cover_open;
+
+	struct mmc_request      *mrq;
+	struct mmc_omap_host    *host;
+	struct mmc_host         *mmc;
+	struct omap_mmc_slot_data *pdata;
+};
 
 struct mmc_omap_host {
 	int			initialized;
@@ -133,63 +152,130 @@ struct mmc_omap_host {
 	unsigned		dma_len;
 
 	short			power_pin;
-	short			wp_pin;
 
-	int			switch_pin;
-	struct work_struct	switch_work;
-	struct timer_list	switch_timer;
-	int			switch_last_state;
+	struct mmc_omap_slot    *slots[OMAP_MMC_MAX_SLOTS];
+	struct mmc_omap_slot    *current_slot;
+	spinlock_t              slot_lock;
+	wait_queue_head_t       slot_wq;
+	int                     nr_slots;
+
+	struct omap_mmc_platform_data *pdata;
 };
 
-static inline int
-mmc_omap_cover_is_open(struct mmc_omap_host *host)
+static void mmc_omap_select_slot(struct mmc_omap_slot *slot, int claimed)
 {
-	if (host->switch_pin < 0)
-		return 0;
-	return omap_get_gpio_datain(host->switch_pin);
+	struct mmc_omap_host *host = slot->host;
+	unsigned long flags;
+
+	if (claimed)
+		goto no_claim;
+	spin_lock_irqsave(&host->slot_lock, flags);
+	while (host->mmc != NULL) {
+		spin_unlock_irqrestore(&host->slot_lock, flags);
+		wait_event(host->slot_wq, host->mmc == NULL);
+		spin_lock_irqsave(&host->slot_lock, flags);
+	}
+	host->mmc = slot->mmc;
+	spin_unlock_irqrestore(&host->slot_lock, flags);
+no_claim:
+	clk_enable(host->fclk);
+	if (host->current_slot != slot) {
+		if (host->pdata->switch_slot != NULL)
+			host->pdata->switch_slot(mmc_dev(slot->mmc), slot->id);
+		host->current_slot = slot;
+	}
+
+	/* Doing the dummy read here seems to work around some bug
+	 * at least in OMAP24xx silicon where the command would not
+	 * start after writing the CMD register. Sigh. */
+	OMAP_MMC_READ(host, CON);
+
+	OMAP_MMC_WRITE(host, CON, slot->saved_con);
 }
 
-static ssize_t
-mmc_omap_show_cover_switch(struct device *dev,
-	struct device_attribute *attr, char *buf)
+static void mmc_omap_start_request(struct mmc_omap_host *host,
+				   struct mmc_request *req);
+
+static void mmc_omap_release_slot(struct mmc_omap_slot *slot)
 {
-	struct mmc_omap_host *host = dev_get_drvdata(dev);
+	struct mmc_omap_host *host = slot->host;
+	unsigned long flags;
+	int i;
 
-	return sprintf(buf, "%s\n", mmc_omap_cover_is_open(host) ? "open" :
-			"closed");
+	BUG_ON(slot == NULL || host->mmc == NULL);
+	clk_disable(host->fclk);
+
+	spin_lock_irqsave(&host->slot_lock, flags);
+	/* Check for any pending requests */
+	for (i = 0; i < host->nr_slots; i++) {
+		struct mmc_omap_slot *new_slot;
+		struct mmc_request *rq;
+
+		if (host->slots[i] == NULL || host->slots[i]->mrq == NULL)
+			continue;
+
+		new_slot = host->slots[i];
+		/* The current slot should not have a request in queue */
+		BUG_ON(new_slot == host->current_slot);
+
+		host->mmc = new_slot->mmc;
+		spin_unlock_irqrestore(&host->slot_lock, flags);
+		mmc_omap_select_slot(new_slot, 1);
+		rq = new_slot->mrq;
+		new_slot->mrq = NULL;
+		mmc_omap_start_request(host, rq);
+		return;
+	}
+
+	host->mmc = NULL;
+	wake_up(&host->slot_wq);
+	spin_unlock_irqrestore(&host->slot_lock, flags);
 }
 
-static DEVICE_ATTR(cover_switch, S_IRUGO, mmc_omap_show_cover_switch, NULL);
+static inline
+int mmc_omap_cover_is_open(struct mmc_omap_slot *slot)
+{
+	return slot->pdata->get_cover_state(mmc_dev(slot->mmc), slot->id);
+}
 
 static ssize_t
-mmc_omap_show_enable_poll(struct device *dev,
-	struct device_attribute *attr, char *buf)
+mmc_omap_show_cover_switch(struct device *dev, struct device_attribute *attr,
+			   char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%d\n", mmc_omap_enable_poll);
+	struct mmc_host *mmc = container_of(dev, struct mmc_host, class_dev);
+	struct mmc_omap_slot *slot = mmc_priv(mmc);
+
+	return sprintf(buf, "%s\n", mmc_omap_cover_is_open(slot) ? "open" :
+		       "closed");
 }
 
+static DEVICE_ATTR(cover_switch, S_IRUGO, mmc_omap_show_cover_switch, NULL);
+
+/* Access to the R/O switch is required for production testing
+ * purposes. */
 static ssize_t
-mmc_omap_store_enable_poll(struct device *dev,
-	struct device_attribute *attr, const char *buf,
-	size_t size)
+mmc_omap_show_ro(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	int enable_poll;
+	struct mmc_host *mmc = container_of(dev, struct mmc_host, class_dev);
+	struct mmc_omap_slot *slot = mmc_priv(mmc);
 
-	if (sscanf(buf, "%10d", &enable_poll) != 1)
-		return -EINVAL;
+	return sprintf(buf, "%d\n", slot->pdata->get_ro(mmc_dev(mmc),
+							slot->id));
+}
 
-	if (enable_poll != mmc_omap_enable_poll) {
-		struct mmc_omap_host *host = dev_get_drvdata(dev);
+static DEVICE_ATTR(ro, S_IRUGO, mmc_omap_show_ro, NULL);
 
-		mmc_omap_enable_poll = enable_poll;
-		if (enable_poll && host->switch_pin >= 0)
-			schedule_work(&host->switch_work);
-	}
-	return size;
+static ssize_t
+mmc_omap_show_slot_name(struct device *dev, struct device_attribute *attr,
+			char *buf)
+{
+	struct mmc_host *mmc = container_of(dev, struct mmc_host, class_dev);
+	struct mmc_omap_slot *slot = mmc_priv(mmc);
+
+	return sprintf(buf, "%s\n", slot->pdata->name);
 }
 
-static DEVICE_ATTR(enable_poll, 0664,
-		   mmc_omap_show_enable_poll, mmc_omap_store_enable_poll);
+static DEVICE_ATTR(slot_name, S_IRUGO, mmc_omap_show_slot_name, NULL);
 
 static void
 mmc_omap_start_command(struct mmc_omap_host *host, struct mmc_command *cmd)
@@ -235,7 +321,7 @@ mmc_omap_start_command(struct mmc_omap_host *host, struct mmc_command *cmd)
 
 	cmdreg = cmd->opcode | (resptype << 8) | (cmdtype << 12);
 
-	if (host->bus_mode == MMC_BUSMODE_OPENDRAIN)
+	if (host->current_slot->bus_mode == MMC_BUSMODE_OPENDRAIN)
 		cmdreg |= 1 << 6;
 
 	if (cmd->flags & MMC_RSP_BUSY)
@@ -244,8 +330,6 @@ mmc_omap_start_command(struct mmc_omap_host *host, struct mmc_command *cmd)
 	if (host->data && !(host->data->flags & MMC_DATA_WRITE))
 		cmdreg |= 1 << 15;
 
-	clk_enable(host->fclk);
-
 	OMAP_MMC_WRITE(host, CTO, 200);
 	OMAP_MMC_WRITE(host, ARGL, cmd->arg & 0xffff);
 	OMAP_MMC_WRITE(host, ARGH, cmd->arg >> 16);
@@ -497,12 +581,14 @@ static irqreturn_t mmc_omap_irq(int irq, void *dev_id)
 		if (status & OMAP_MMC_STAT_CMD_TOUT) {
 			/* Timeouts are routine with some commands */
 			if (host->cmd) {
+				struct mmc_omap_slot *slot =
+					host->current_slot;
 				if (host->cmd->opcode != MMC_ALL_SEND_CID &&
 						host->cmd->opcode !=
 						MMC_SEND_OP_COND &&
 						host->cmd->opcode !=
 						MMC_APP_CMD &&
-						!mmc_omap_cover_is_open(host))
+						!mmc_omap_cover_is_open(slot))
 					dev_err(mmc_dev(host->mmc),
 						"command timeout, CMD %d\n",
 						host->cmd->opcode);
@@ -551,47 +637,40 @@ static irqreturn_t mmc_omap_irq(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static irqreturn_t mmc_omap_switch_irq(int irq, void *dev_id)
+void omap_mmc_notify_cover_event(struct device *dev, int slot, int is_closed)
 {
-	struct mmc_omap_host *host = (struct mmc_omap_host *) dev_id;
+	struct mmc_omap_host *host = dev_get_drvdata(dev);
 
-	schedule_work(&host->switch_work);
+	BUG_ON(slot >= host->nr_slots);
 
-	return IRQ_HANDLED;
+	/* Other subsystems can call in here before we're initialised. */
+	if (host->nr_slots == 0 || !host->slots[slot])
+		return;
+
+	schedule_work(&host->slots[slot]->switch_work);
 }
 
 static void mmc_omap_switch_timer(unsigned long arg)
 {
-	struct mmc_omap_host *host = (struct mmc_omap_host *) arg;
+	struct mmc_omap_slot *slot = (struct mmc_omap_slot *) arg;
 
-	schedule_work(&host->switch_work);
+	schedule_work(&slot->switch_work);
 }
 
-static void mmc_omap_switch_handler(struct work_struct *work)
+static void mmc_omap_cover_handler(struct work_struct *work)
 {
-	struct mmc_omap_host *host = container_of(work, struct mmc_omap_host, switch_work);
-	static int complained = 0;
+	struct mmc_omap_slot *slot = container_of(work, struct mmc_omap_slot,
+						  switch_work);
 	int cover_open;
 
-	if (host->switch_pin == -1)
-		return;
-	cover_open = mmc_omap_cover_is_open(host);
-	if (cover_open != host->switch_last_state) {
-		kobject_uevent(&host->dev->kobj, KOBJ_CHANGE);
-		host->switch_last_state = cover_open;
-	}
-	mmc_detect_change(host->mmc, 0);
-	if (mmc_omap_cover_is_open(host)) {
-		if (!complained) {
-			dev_info(mmc_dev(host->mmc), "cover is open\n");
-			complained = 1;
-		}
-		if (mmc_omap_enable_poll)
-			mod_timer(&host->switch_timer, jiffies +
-				msecs_to_jiffies(OMAP_MMC_SWITCH_POLL_DELAY));
-	} else {
-		complained = 0;
+	cover_open = mmc_omap_cover_is_open(slot);
+	if (cover_open != slot->cover_open) {
+		sysfs_notify(&slot->mmc->class_dev.kobj, NULL, "cover_switch");
+		slot->cover_open = cover_open;
+		dev_info(mmc_dev(slot->mmc), "cover is now %s\n",
+			 cover_open ? "open" : "closed");
 	}
+	mmc_detect_change(slot->mmc, slot->id);
 }
 
 /* Prepare to transfer the next segment of a scatterlist */
@@ -851,11 +930,10 @@ mmc_omap_prepare_data(struct mmc_omap_host *host, struct mmc_request *req)
 	}
 }
 
-static void mmc_omap_request(struct mmc_host *mmc, struct mmc_request *req)
+static void mmc_omap_start_request(struct mmc_omap_host *host,
+				   struct mmc_request *req)
 {
-	struct mmc_omap_host *host = mmc_priv(mmc);
-
-	WARN_ON(host->mrq != NULL);
+	BUG_ON(host->mrq != NULL);
 
 	host->mrq = req;
 
@@ -864,6 +942,26 @@ static void mmc_omap_request(struct mmc_host *mmc, struct mmc_request *req)
 	mmc_omap_start_command(host, req->cmd);
 	if (host->dma_in_use)
 		omap_start_dma(host->dma_ch);
+	BUG_ON(irqs_disabled());
+}
+
+static void mmc_omap_request(struct mmc_host *mmc, struct mmc_request *req)
+{
+	struct mmc_omap_slot *slot = mmc_priv(mmc);
+	struct mmc_omap_host *host = slot->host;
+	unsigned long flags;
+
+	spin_lock_irqsave(&host->slot_lock, flags);
+	if (host->mmc != NULL) {
+		BUG_ON(slot->mrq != NULL);
+		slot->mrq = req;
+		spin_unlock_irqrestore(&host->slot_lock, flags);
+		return;
+	} else
+		host->mmc = mmc;
+	spin_unlock_irqrestore(&host->slot_lock, flags);
+	mmc_omap_select_slot(slot, 1);
+	mmc_omap_start_request(host, req);
 }
 
 static void innovator_fpga_socket_power(int on)
@@ -919,7 +1017,8 @@ static void mmc_omap_power(struct mmc_omap_host *host, int on)
 
 static int mmc_omap_calc_divisor(struct mmc_host *mmc, struct mmc_ios *ios)
 {
-	struct mmc_omap_host *host = mmc_priv(mmc);
+	struct mmc_omap_slot *slot = mmc_priv(mmc);
+	struct mmc_omap_host *host = slot->host;
 	int func_clk_rate = clk_get_rate(host->fclk);
 	int dsor;
 
@@ -936,6 +1035,8 @@ static int mmc_omap_calc_divisor(struct mmc_host *mmc, struct mmc_ios *ios)
 	if (dsor > 250)
 		dsor = 250;
 
+	slot->fclk_freq = func_clk_rate / dsor;
+
 	if (ios->bus_width == MMC_BUS_WIDTH_4)
 		dsor |= 1 << 15;
 
@@ -944,9 +1045,9 @@ static int mmc_omap_calc_divisor(struct mmc_host *mmc, struct mmc_ios *ios)
 
 static void mmc_omap_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 {
-	struct mmc_omap_host *host = mmc_priv(mmc);
-	int dsor;
-	int i;
+	struct mmc_omap_slot *slot = mmc_priv(mmc);
+	struct mmc_omap_host *host = slot->host;
+	int i, dsor;
 
 	dsor = mmc_omap_calc_divisor(mmc, ios);
 	host->bus_mode = ios->bus_mode;
@@ -986,9 +1087,11 @@ static void mmc_omap_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 
 static int mmc_omap_get_ro(struct mmc_host *mmc)
 {
-	struct mmc_omap_host *host = mmc_priv(mmc);
+	struct mmc_omap_slot *slot = mmc_priv(mmc);
 
-	return host->wp_pin && omap_get_gpio_datain(host->wp_pin);
+	if (slot->pdata->get_ro != NULL)
+		return slot->pdata->get_ro(mmc_dev(mmc), slot->id);
+	return 0;
 }
 
 static const struct mmc_host_ops mmc_omap_ops = {
@@ -997,19 +1100,129 @@ static const struct mmc_host_ops mmc_omap_ops = {
 	.get_ro		= mmc_omap_get_ro,
 };
 
-static int __init mmc_omap_probe(struct platform_device *pdev)
+static int __init mmc_omap_new_slot(struct mmc_omap_host *host, int id)
 {
-	struct omap_mmc_conf *minfo = pdev->dev.platform_data;
+	struct mmc_omap_slot *slot = NULL;
 	struct mmc_host *mmc;
+	int r;
+
+	mmc = mmc_alloc_host(sizeof(struct mmc_omap_slot), host->dev);
+	if (mmc == NULL)
+		return -ENOMEM;
+
+	slot = mmc_priv(mmc);
+	slot->host = host;
+	slot->mmc = mmc;
+	slot->id = id;
+	slot->pdata = &host->pdata->slots[id];
+
+	host->slots[id] = slot;
+
+	mmc->caps = MMC_CAP_BYTEBLOCK | MMC_CAP_MULTIWRITE |
+		    MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED;
+	if (host->pdata->wire4)
+		mmc->caps |= MMC_CAP_4_BIT_DATA;
+
+	mmc->ops = &mmc_omap_ops;
+	mmc->f_min = 400000;
+
+	if (cpu_class_is_omap2())
+		mmc->f_max = 48000000;
+	else
+		mmc->f_max = 24000000;
+	if (host->pdata->max_freq)
+		mmc->f_max = min(host->pdata->max_freq, mmc->f_max);
+	mmc->ocr_avail = slot->pdata->ocr_mask;
+
+	/* Use scatterlist DMA to reduce per-transfer costs.
+	 * NOTE max_seg_size assumption that small blocks aren't
+	 * normally used (except e.g. for reading SD registers).
+	 */
+	mmc->max_phys_segs = 32;
+	mmc->max_hw_segs = 32;
+	mmc->max_blk_size = 2048;	/* BLEN is 11 bits (+1) */
+	mmc->max_blk_count = 2048;	/* NBLK is 11 bits (+1) */
+	mmc->max_req_size = mmc->max_blk_size * mmc->max_blk_count;
+	mmc->max_seg_size = mmc->max_req_size;
+
+	r = mmc_add_host(mmc);
+	if (r < 0)
+		return r;
+
+	if (slot->pdata->name != NULL) {
+		r = device_create_file(&mmc->class_dev,
+					&dev_attr_slot_name);
+		if (r < 0)
+			goto err_remove_host;
+	}
+
+	if (slot->pdata->get_cover_state != NULL) {
+		r = device_create_file(&mmc->class_dev,
+					&dev_attr_cover_switch);
+		if (r < 0)
+			goto err_remove_slot_name;
+
+		INIT_WORK(&slot->switch_work, mmc_omap_cover_handler);
+		init_timer(&slot->switch_timer);
+		slot->switch_timer.function = mmc_omap_switch_timer;
+		slot->switch_timer.data = (unsigned long) slot;
+		schedule_work(&slot->switch_work);
+	}
+
+	if (slot->pdata->get_ro != NULL) {
+		r = device_create_file(&mmc->class_dev,
+					&dev_attr_ro);
+		if (r < 0)
+			goto err_remove_cover_attr;
+	}
+
+	return 0;
+
+err_remove_cover_attr:
+	if (slot->pdata->get_cover_state != NULL)
+		device_remove_file(&mmc->class_dev, &dev_attr_cover_switch);
+err_remove_slot_name:
+	if (slot->pdata->name != NULL)
+		device_remove_file(&mmc->class_dev, &dev_attr_ro);
+err_remove_host:
+	mmc_remove_host(mmc);
+	return r;
+}
+
+static void mmc_omap_remove_slot(struct mmc_omap_slot *slot)
+{
+	struct mmc_host *mmc = slot->mmc;
+
+	if (slot->pdata->name != NULL)
+		device_remove_file(&mmc->class_dev, &dev_attr_slot_name);
+	if (slot->pdata->get_cover_state != NULL)
+		device_remove_file(&mmc->class_dev, &dev_attr_cover_switch);
+	if (slot->pdata->get_ro != NULL)
+		device_remove_file(&mmc->class_dev, &dev_attr_ro);
+
+	del_timer_sync(&slot->switch_timer);
+	flush_scheduled_work();
+
+	mmc_remove_host(mmc);
+	mmc_free_host(mmc);
+}
+
+static int __init mmc_omap_probe(struct platform_device *pdev)
+{
+	struct omap_mmc_platform_data *pdata = pdev->dev.platform_data;
 	struct mmc_omap_host *host = NULL;
 	struct resource *res;
-	int ret = 0;
+	int i, ret = 0;
 	int irq;
 
-	if (minfo == NULL) {
+	if (pdata == NULL) {
 		dev_err(&pdev->dev, "platform data missing\n");
 		return -ENXIO;
 	}
+	if (pdata->nr_slots == 0) {
+		dev_err(&pdev->dev, "no slots\n");
+		return -ENXIO;
+	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	irq = platform_get_irq(pdev, 0);
@@ -1017,28 +1230,39 @@ static int __init mmc_omap_probe(struct platform_device *pdev)
 		return -ENXIO;
 
 	res = request_mem_region(res->start, res->end - res->start + 1,
-			         pdev->name);
+				 pdev->name);
 	if (res == NULL)
 		return -EBUSY;
 
-	mmc = mmc_alloc_host(sizeof(struct mmc_omap_host), &pdev->dev);
-	if (mmc == NULL) {
+	host = kzalloc(sizeof(struct mmc_omap_host), GFP_KERNEL);
+	if (host == NULL) {
 		ret = -ENOMEM;
 		goto err_free_mem_region;
 	}
 
-	host = mmc_priv(mmc);
-	host->mmc = mmc;
-
 	spin_lock_init(&host->dma_lock);
 	init_timer(&host->dma_timer);
+	spin_lock_init(&host->slot_lock);
+	init_waitqueue_head(&host->slot_wq);
+
 	host->dma_timer.function = mmc_omap_dma_timer;
 	host->dma_timer.data = (unsigned long) host;
 
+	host->pdata = pdata;
+	host->dev = &pdev->dev;
+	platform_set_drvdata(pdev, host);
+
 	host->id = pdev->id;
 	host->mem_res = res;
 	host->irq = irq;
 
+	host->use_dma = 1;
+	host->dma_ch = -1;
+
+	host->irq = irq;
+	host->phys_base = host->mem_res->start;
+	host->virt_base = (void __iomem *) IO_ADDRESS(host->phys_base);
+
 	if (cpu_is_omap24xx()) {
 		host->iclk = clk_get(&pdev->dev, "mmc_ick");
 		if (IS_ERR(host->iclk))
@@ -1056,109 +1280,34 @@ static int __init mmc_omap_probe(struct platform_device *pdev)
 		goto err_free_iclk;
 	}
 
-	/* REVISIT:
-	 * Also, use minfo->cover to decide how to manage
-	 * the card detect sensing.
-	 */
-	host->power_pin = minfo->power_pin;
-	host->switch_pin = minfo->switch_pin;
-	host->wp_pin = minfo->wp_pin;
-	host->use_dma = 1;
-	host->dma_ch = -1;
-
-	host->irq = irq;
-	host->phys_base = host->mem_res->start;
-	host->virt_base = (void __iomem *) IO_ADDRESS(host->phys_base);
-
-	mmc->ops = &mmc_omap_ops;
-	mmc->f_min = 400000;
-	mmc->f_max = 24000000;
-	mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
-	mmc->caps = MMC_CAP_MULTIWRITE | MMC_CAP_BYTEBLOCK;
-
-	if (minfo->wire4)
-		 mmc->caps |= MMC_CAP_4_BIT_DATA;
-
-	/* Use scatterlist DMA to reduce per-transfer costs.
-	 * NOTE max_seg_size assumption that small blocks aren't
-	 * normally used (except e.g. for reading SD registers).
-	 */
-	mmc->max_phys_segs = 32;
-	mmc->max_hw_segs = 32;
-	mmc->max_blk_size = 2048;	/* BLEN is 11 bits (+1) */
-	mmc->max_blk_count = 2048;	/* NBLK is 11 bits (+1) */
-	mmc->max_req_size = mmc->max_blk_size * mmc->max_blk_count;
-	mmc->max_seg_size = mmc->max_req_size;
-
-	if (host->power_pin >= 0) {
-		if ((ret = omap_request_gpio(host->power_pin)) != 0) {
-			dev_err(mmc_dev(host->mmc),
-				"Unable to get GPIO pin for MMC power\n");
-			goto err_free_fclk;
-		}
-		omap_set_gpio_direction(host->power_pin, 0);
-	}
-
 	ret = request_irq(host->irq, mmc_omap_irq, 0, DRIVER_NAME, host);
 	if (ret)
-		goto err_free_power_gpio;
+		goto err_free_fclk;
 
-	host->dev = &pdev->dev;
-	platform_set_drvdata(pdev, host);
+	if (pdata->init != NULL) {
+		ret = pdata->init(&pdev->dev);
+		if (ret < 0)
+			goto err_free_irq;
+	}
 
-	if (host->switch_pin >= 0) {
-		INIT_WORK(&host->switch_work, mmc_omap_switch_handler);
-		init_timer(&host->switch_timer);
-		host->switch_timer.function = mmc_omap_switch_timer;
-		host->switch_timer.data = (unsigned long) host;
-		if (omap_request_gpio(host->switch_pin) != 0) {
-			dev_warn(mmc_dev(host->mmc), "Unable to get GPIO pin for MMC cover switch\n");
-			host->switch_pin = -1;
-			goto no_switch;
-		}
+	host->nr_slots = pdata->nr_slots;
+	for (i = 0; i < pdata->nr_slots; i++) {
+		ret = mmc_omap_new_slot(host, i);
+		if (ret < 0) {
+			while (--i >= 0)
+				mmc_omap_remove_slot(host->slots[i]);
 
-		omap_set_gpio_direction(host->switch_pin, 1);
-		ret = request_irq(OMAP_GPIO_IRQ(host->switch_pin),
-				  mmc_omap_switch_irq, IRQF_TRIGGER_RISING, DRIVER_NAME, host);
-		if (ret) {
-			dev_warn(mmc_dev(host->mmc), "Unable to get IRQ for MMC cover switch\n");
-			omap_free_gpio(host->switch_pin);
-			host->switch_pin = -1;
-			goto no_switch;
-		}
-		ret = device_create_file(&pdev->dev, &dev_attr_cover_switch);
-		if (ret == 0) {
-			ret = device_create_file(&pdev->dev, &dev_attr_enable_poll);
-			if (ret != 0)
-				device_remove_file(&pdev->dev, &dev_attr_cover_switch);
+			goto err_plat_cleanup;
 		}
-		if (ret) {
-			dev_warn(mmc_dev(host->mmc), "Unable to create sysfs attributes\n");
-			free_irq(OMAP_GPIO_IRQ(host->switch_pin), host);
-			omap_free_gpio(host->switch_pin);
-			host->switch_pin = -1;
-			goto no_switch;
-		}
-		if (mmc_omap_enable_poll && mmc_omap_cover_is_open(host))
-			schedule_work(&host->switch_work);
 	}
 
-	mmc_add_host(mmc);
-
 	return 0;
 
-no_switch:
-	/* FIXME: Free other resources too. */
-	if (host) {
-		if (host->iclk && !IS_ERR(host->iclk))
-			clk_put(host->iclk);
-		if (host->fclk && !IS_ERR(host->fclk))
-			clk_put(host->fclk);
-		mmc_free_host(host->mmc);
-	}
-err_free_power_gpio:
-	if (host->power_pin >= 0)
-		omap_free_gpio(host->power_pin);
+err_plat_cleanup:
+	if (pdata->cleanup)
+		pdata->cleanup(&pdev->dev);
+err_free_irq:
+	free_irq(host->irq, host);
 err_free_fclk:
 	clk_put(host->fclk);
 err_free_iclk:
@@ -1167,7 +1316,7 @@ err_free_iclk:
 		clk_put(host->iclk);
 	}
 err_free_mmc_host:
-	mmc_free_host(host->mmc);
+	kfree(host);
 err_free_mem_region:
 	release_mem_region(res->start, res->end - res->start + 1);
 	return ret;
@@ -1176,25 +1325,18 @@ err_free_mem_region:
 static int mmc_omap_remove(struct platform_device *pdev)
 {
 	struct mmc_omap_host *host = platform_get_drvdata(pdev);
+	int i;
 
 	platform_set_drvdata(pdev, NULL);
 
 	BUG_ON(host == NULL);
 
-	mmc_remove_host(host->mmc);
-	free_irq(host->irq, host);
+	for (i = 0; i < host->nr_slots; i++)
+		mmc_omap_remove_slot(host->slots[i]);
+
+	if (host->pdata->cleanup)
+		host->pdata->cleanup(&pdev->dev);
 
-	if (host->power_pin >= 0)
-		omap_free_gpio(host->power_pin);
-	if (host->switch_pin >= 0) {
-		device_remove_file(&pdev->dev, &dev_attr_enable_poll);
-		device_remove_file(&pdev->dev, &dev_attr_cover_switch);
-		free_irq(OMAP_GPIO_IRQ(host->switch_pin), host);
-		omap_free_gpio(host->switch_pin);
-		host->switch_pin = -1;
-		del_timer_sync(&host->switch_timer);
-		flush_scheduled_work();
-	}
 	if (host->iclk && !IS_ERR(host->iclk))
 		clk_put(host->iclk);
 	if (host->fclk && !IS_ERR(host->fclk))
@@ -1203,7 +1345,7 @@ static int mmc_omap_remove(struct platform_device *pdev)
 	release_mem_region(pdev->resource[0].start,
 			   pdev->resource[0].end - pdev->resource[0].start + 1);
 
-	mmc_free_host(host->mmc);
+	kfree(host);
 
 	return 0;
 }
@@ -1211,35 +1353,47 @@ static int mmc_omap_remove(struct platform_device *pdev)
 #ifdef CONFIG_PM
 static int mmc_omap_suspend(struct platform_device *pdev, pm_message_t mesg)
 {
-	int ret = 0;
+	int i, ret = 0;
 	struct mmc_omap_host *host = platform_get_drvdata(pdev);
 
-	if (host && host->suspended)
+	if (host == NULL || host->suspended)
 		return 0;
 
-	if (host) {
-		ret = mmc_suspend_host(host->mmc, mesg);
-		if (ret == 0)
-			host->suspended = 1;
+	for (i = 0; i < host->nr_slots; i++) {
+		struct mmc_omap_slot *slot;
+
+		slot = host->slots[i];
+		ret = mmc_suspend_host(slot->mmc, mesg);
+		if (ret < 0) {
+			while (--i >= 0) {
+				slot = host->slots[i];
+				mmc_resume_host(slot->mmc);
+			}
+			return ret;
+		}
 	}
-	return ret;
+	host->suspended = 1;
+	return 0;
 }
 
 static int mmc_omap_resume(struct platform_device *pdev)
 {
-	int ret = 0;
+	int i, ret = 0;
 	struct mmc_omap_host *host = platform_get_drvdata(pdev);
 
-	if (host && !host->suspended)
+	if (host == NULL || !host->suspended)
 		return 0;
 
-	if (host) {
-		ret = mmc_resume_host(host->mmc);
-		if (ret == 0)
-			host->suspended = 0;
-	}
+	for (i = 0; i < host->nr_slots; i++) {
+		struct mmc_omap_slot *slot;
+		slot = host->slots[i];
+		ret = mmc_resume_host(slot->mmc);
+		if (ret < 0)
+			return ret;
 
-	return ret;
+		host->suspended = 0;
+	}
+	return 0;
 }
 #else
 #define mmc_omap_suspend	NULL
-- 1.5.3.GIT
