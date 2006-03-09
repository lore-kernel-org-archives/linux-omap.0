From: Carlos Aguiar <carlos.aguiar@indt.org.br>
Subject: Re: [patch 5/5] MMC OMAP DBG CLEANUP
Date: Thu, 09 Mar 2006 10:58:44 -0400
Message-ID: <441042A4.7070707@indt.org.br>
References: <20060307171122.002855000@localhost.localdomain>
	<20060308102739.b3e2958d.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070709000605080908050707"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20060308102739.b3e2958d.Hiroshi.DOYU@nokia.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: ext Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------070709000605080908050707
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi folks,

Find below my propose of debug cleanup in omap.c. I'm working now in a 
merging
of omap.c into mainline kernel 
(http://marc.theaimsgroup.com/?l=linux-kernel&m=114176508216915&w=2).

Following the Russell King's suggestion, there's no need to print
host->id - mmc_dev(host->mmc) will print the platform device bus_id,
which is generated from the platform device name and the platform
device id. This change was applied for dev_err, dev_dbg, dev_warn
and dev_info.

All suggestions and comments are welcome!

BR,

Carlos.

-- 
Carlos Eduardo
Software Engineer
Nokia Institute of Technology - INdT
Embedded Linux Laboratory - 10LE
Phone: +55 92 2126-1079
Mobile: +55 92 8127-1797
E-mail: carlos.aguiar@indt.org.br


--------------070709000605080908050707
Content-Type: text/plain;
 name="mmc_omap_debug.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mmc_omap_debug.diff"

Index: linux-omap-2.6.git/drivers/mmc/omap.c
===================================================================
--- linux-omap-2.6.git.orig/drivers/mmc/omap.c	2006-02-24 12:14:09.000000000 -0400
+++ linux-omap-2.6.git/drivers/mmc/omap.c	2006-03-09 10:29:37.000000000 -0400
@@ -50,13 +50,6 @@
 
 #define DRIVER_NAME "mmci-omap"
 
-#ifdef CONFIG_MMC_DEBUG
-#define DBG(x...)	pr_debug(x)
-//#define DBG(x...)	printk(x)
-#else
-#define DBG(x...)	do { } while (0)
-#endif
-
 /* Specifies how often in millisecs to poll for card status changes
  * when the cover switch is open */
 #define OMAP_MMC_SWITCH_POLL_DELAY	500
@@ -160,13 +153,6 @@ mmc_omap_start_command(struct mmc_omap_h
 	u32 resptype;
 	u32 cmdtype;
 
-	pr_debug("MMC%d: CMD%d, argument 0x%08x%s%s%s%s\n",
-		host->id, cmd->opcode, cmd->arg,
-		(cmd->flags & MMC_RSP_SHORT) ?  ", 32-bit response" : "",
-		(cmd->flags & MMC_RSP_LONG) ?  ", 128-bit response" : "",
-		(cmd->flags & MMC_RSP_CRC) ?  ", CRC" : "",
-		(cmd->flags & MMC_RSP_BUSY) ?  ", busy notification" : "");
-
 	host->cmd = cmd;
 
 	resptype = 0;
@@ -309,7 +295,7 @@ mmc_omap_dma_timer(unsigned long data)
 {
 	struct mmc_omap_host *host = (struct mmc_omap_host *) data;
 
-	DBG("MMC%d: Freeing DMA channel %d\n", host->id, host->dma_ch);
+	dev_dbg(mmc_dev(host->mmc), "Freeing DMA channel %d\n", host->dma_ch);
 	BUG_ON(host->dma_ch < 0);
 	omap_free_dma(host->dma_ch);
 	host->dma_ch = -1;
@@ -351,7 +337,7 @@ mmc_omap_cmd_done(struct mmc_omap_host *
 		cmd->resp[0] =
 			OMAP_MMC_READ(host->base, RSP6) |
 			(OMAP_MMC_READ(host->base, RSP7) << 16);
-		DBG("MMC%d: Response %08x %08x %08x %08x\n", host->id,
+		dev_dbg(mmc_dev(host->mmc), "Response %08x %08x %08x %08x\n",
 		    cmd->resp[0], cmd->resp[1],
 		    cmd->resp[2], cmd->resp[3]);
 	} else {
@@ -359,15 +345,15 @@ mmc_omap_cmd_done(struct mmc_omap_host *
 		cmd->resp[0] =
 			OMAP_MMC_READ(host->base, RSP6) |
 			(OMAP_MMC_READ(host->base, RSP7) << 16);
-		DBG("MMC%d: Response %08x\n", host->id, cmd->resp[0]);
+		dev_dbg(mmc_dev(host->mmc), "Response %08x\n", cmd->resp[0]);
 		if (card_ready) {
-			pr_debug("MMC%d: Faking card ready based on EOFB\n", host->id);
+			dev_dbg(mmc_dev(host->mmc), "Faking card ready based on EOFB\n");
 			cmd->resp[0] |= R1_READY_FOR_DATA;
 		}
 	}
 
 	if (host->data == NULL || cmd->error != MMC_ERR_NONE) {
-		DBG("MMC%d: End request, err %x\n", host->id, cmd->error);
+		dev_dbg(mmc_dev(host->mmc), "End request, err %x\n", cmd->error);
 		if (host->data != NULL)
 			del_timer_sync(&host->xfer_timer);
  		host->mrq = NULL;
@@ -381,7 +367,7 @@ mmc_omap_xfer_timeout(unsigned long data
 {
 	struct mmc_omap_host *host = (struct mmc_omap_host *) data;
 
-	printk(KERN_ERR "MMC%d: Data xfer timeout\n", host->id);
+	dev_err(mmc_dev(host->mmc), "Data xfer timeout\n");
 	if (host->data != NULL) {
 		host->data->error |= MMC_ERR_TIMEOUT;
 		/* Perform a pseudo-reset of the MMC core logic, since
@@ -468,7 +454,7 @@ static irqreturn_t mmc_omap_irq(int irq,
 
 	if (host->cmd == NULL && host->data == NULL) {
 		status = OMAP_MMC_READ(host->base, STAT);
-		printk(KERN_INFO "MMC%d: Spurious interrupt 0x%04x\n", host->id, status);
+		dev_info(mmc_dev(host->mmc), "spurious irq 0x%04x\n", status);
 		if (status != 0) {
 			OMAP_MMC_WRITE(host->base, STAT, status);
 			OMAP_MMC_WRITE(host->base, IE, 0);
@@ -484,8 +470,8 @@ static irqreturn_t mmc_omap_irq(int irq,
 	while ((status = OMAP_MMC_READ(host->base, STAT)) != 0) {
 		OMAP_MMC_WRITE(host->base, STAT, status); // Reset status bits
 #ifdef CONFIG_MMC_DEBUG
-		printk(KERN_DEBUG "\tMMC IRQ %04x (CMD %d): ", status,
-		       host->cmd != NULL ? host->cmd->opcode : -1);
+		dev_dbg(mmc_dev(host->mmc), "MMC IRQ %04x (CMD %d): ",
+			status, host->cmd != NULL ? host->cmd->opcode : -1);
 		mmc_omap_report_irq(status);
 		printk("\n");
 #endif
@@ -504,7 +490,7 @@ static irqreturn_t mmc_omap_irq(int irq,
 
 		if (status & OMAP_MMC_STAT_DATA_TOUT) {
 			// Data timeout
-			printk(KERN_DEBUG "MMC%d: Data timeout\n", host->id);
+			dev_dbg(mmc_dev(host->mmc), "data timeout\n");
 			if (host->data) {
 				host->data->error |= MMC_ERR_TIMEOUT;
 				transfer_error = 1;
@@ -515,12 +501,12 @@ static irqreturn_t mmc_omap_irq(int irq,
 			// Data CRC error
 			if (host->data) {
 				host->data->error |= MMC_ERR_BADCRC;
-				printk(KERN_DEBUG "MMC%d: Data CRC error, bytes left %d\n",
-				       host->id, host->total_bytes_left);
+				dev_dbg(mmc_dev(host->mmc),
+					 "data CRC error, bytes left %d\n",
+					host->total_bytes_left);
 				transfer_error = 1;
 			} else {
-				printk(KERN_DEBUG "MMC%d: Data CRC error\n",
-				       host->id);
+				dev_dbg(mmc_dev(host->mmc), "data CRC error\n");
 			}
 		}
 
@@ -528,11 +514,14 @@ static irqreturn_t mmc_omap_irq(int irq,
 			/* Timeouts are routine with some commands */
 			if (host->cmd) {
 				if (host->cmd->opcode != MMC_ALL_SEND_CID &&
-				    host->cmd->opcode != MMC_SEND_OP_COND &&
-				    host->cmd->opcode != MMC_APP_CMD &&
-				    !mmc_omap_cover_is_open(host))
-					printk(KERN_ERR "MMC%d: Command timeout, CMD%d\n",
-					       host->id, host->cmd->opcode);
+						host->cmd->opcode !=
+						MMC_SEND_OP_COND &&
+						host->cmd->opcode !=
+						MMC_APP_CMD &&
+						!mmc_omap_cover_is_open(host))
+					dev_err(mmc_dev(host->mmc),
+						"command timeout, CMD %d\n",
+						host->cmd->opcode);
 				host->cmd->error |= MMC_ERR_TIMEOUT;
 				end_command = 1;
 			}
@@ -541,21 +530,21 @@ static irqreturn_t mmc_omap_irq(int irq,
 		if (status & OMAP_MMC_STAT_CMD_CRC) {
 			// Command CRC error
 			if (host->cmd) {
-				printk(KERN_ERR "MMC%d: Command CRC error (CMD%d, arg 0x%08x)\n",
-				       host->id, host->cmd->opcode,
-				       host->cmd->arg);
+				dev_err(mmc_dev(host->mmc),
+					"command CRC error (CMD%d, arg 0x%08x)\n",
+					host->cmd->opcode, host->cmd->arg);
 				host->cmd->error |= MMC_ERR_BADCRC;
 				end_command = 1;
 			} else
-				printk(KERN_ERR "MMC%d: Command CRC error without cmd?\n", host->id);
+				dev_err(mmc_dev(host->mmc),
+					"command CRC error without cmd?\n");
 		}
 
 		if (status & OMAP_MMC_STAT_OCR_BUSY) {
 			/* OCR Busy ... happens a lot */
 			if (host->cmd && host->cmd->opcode != MMC_SEND_OP_COND
 				&& host->cmd->opcode != MMC_SET_RELATIVE_ADDR) {
-				DBG("MMC%d: OCR busy error, CMD%d\n",
-				       host->id, host->cmd->opcode);
+				dev_dbg(mmc_dev(host->mmc), "OCR busy error, CMD%d\n", host->cmd->opcode);
 			}
 		}
 
@@ -573,8 +562,8 @@ static irqreturn_t mmc_omap_irq(int irq,
 			}
 
 			// Card status error
-			printk(KERN_DEBUG "MMC%d: Card status error (CMD%d)\n",
-			       host->id, host->cmd->opcode);
+			dev_dbg(mmc_dev(host->mmc), "card status error (CMD%d)\n",
+				host->cmd->opcode);
 			if (host->cmd) {
 				host->cmd->error |= MMC_ERR_FAILED;
 				end_command = 1;
@@ -623,8 +612,7 @@ static irqreturn_t mmc_omap_switch_irq(i
 	int cover_open, detect_now;
 
 	cover_open = mmc_omap_cover_is_open(host);
-	DBG("MMC%d cover is now %s\n", host->id,
-	    cover_open ? "open" : "closed");
+	dev_dbg(mmc_dev(host->mmc), "cover is now %s\n", cover_open ? "open" : "closed");
 	set_irq_type(OMAP_GPIO_IRQ(host->switch_pin), 0);
 	detect_now = 0;
 	if (host->switch_last_state != cover_open) {
@@ -691,16 +679,16 @@ static void mmc_omap_switch_handler(void
 		kobject_uevent(&host->dev->kobj, KOBJ_CHANGE);
 		host->switch_last_state = cover_open;
 	}
-	DBG("MMC cover switch handler started\n");
+	dev_dbg(mmc_dev(host->mmc), "MMC cover switch handler started\n");
 	mmc_detect_change(host->mmc, 0);
 	list_for_each_entry(card, &host->mmc->cards, node) {
 		if (mmc_card_present(card))
 			cards++;
 	}
-	DBG("MMC%d: %d card(s) present\n", host->id, cards);
+	dev_dbg(mmc_dev(host->mmc), "%d card(s) present\n", cards);
 	if (cover_open) {
 		if (!complained) {
-			printk(KERN_INFO "MMC%d: cover is open\n", host->id);
+			dev_info(mmc_dev(host->mmc), "cover is open");
 			complained = 1;
 		}
 		if (cover_open && (cards || mmc_omap_enable_poll))
@@ -802,17 +790,16 @@ static void mmc_omap_dma_cb(int lch, u16
 	struct mmc_data *mmcdat = host->data;
 
 	if (unlikely(host->dma_ch < 0)) {
-		printk(KERN_ERR "MMC%d: DMA callback while DMA not enabled\n",
-		       host->id);
+		dev_err(mmc_dev(host->mmc), "DMA callback while DMA not enabled\n");
 		return;
 	}
 	/* FIXME: We really should do something to _handle_ the errors */
 	if (ch_status & OMAP_DMA_TOUT_IRQ) {
-		printk(KERN_ERR "MMC%d: DMA timeout\n", host->id);
+		dev_err(mmc_dev(host->mmc), "DMA timeout\n");
 		return;
 	}
 	if (ch_status & OMAP_DMA_DROP_IRQ) {
-		printk(KERN_ERR "MMC%d: DMA sync error\n", host->id);
+		dev_err(mmc_dev(host->mmc), "DMA sync error\n");
 		return;
 	}
 	if (!(ch_status & OMAP_DMA_BLOCK_IRQ)) {
@@ -820,16 +807,13 @@ static void mmc_omap_dma_cb(int lch, u16
 		 * just SYNC status ...
 		 */
 		if ((ch_status & ~OMAP1_DMA_SYNC_IRQ))
-			pr_debug("MMC%d: DMA channel status: %04x\n",
-			       host->id, ch_status);
+			dev_dbg(mmc_dev(host->mmc), "DMA channel status: %04x\n", ch_status);
 		return;
 	}
 	mmcdat->bytes_xfered += host->dma_len;
 
-	pr_debug("\tMMC DMA %d bytes CB %04x (%d segments to go), %p\n",
-		host->dma_len, ch_status,
+	dev_dbg(mmc_dev(host->mmc), "DMA %d bytes CB %04x (%d segments to go), %p\n", host->dma_len, ch_status,
 		host->sg_len - host->sg_idx - 1, host->data);
-
 	host->sg_idx++;
 	if (host->sg_idx < host->sg_len) {
 		mmc_omap_prepare_dma(host, host->data);
@@ -872,8 +856,7 @@ static int mmc_omap_get_dma_channel(stru
 	r = omap_request_dma(sync_dev, dev_name, mmc_omap_dma_cb,
 			     host, &dma_ch);
 	if (r != 0) {
-		printk("MMC%d: omap_request_dma() failed with %d\n",
-		       host->id, r);
+		dev_dbg(mmc_dev(host->mmc), "omap_request_dma() failed with %d\n", r);
 		return r;
 	}
 	host->dma_ch = dma_ch;
@@ -1049,13 +1032,12 @@ static void mmc_omap_request(struct mmc_
 			static int complained = 0;
 
 			if (!complained) {
-				printk(KERN_WARNING "MMC%d: Broken card workaround enabled\n",
-				       host->id);
+				dev_warn(mmc_dev(host->mmc), "Broken card workaround enabled\n");
 				complained = 1;
 			}
 			if (in_interrupt()) {
 				/* This is nasty */
-				 printk(KERN_ERR "Sleeping in IRQ handler, FIXME please!\n");
+				dev_err(mmc_dev(host->mmc), "Sleeping in IRQ handler, FIXME please!\n");
 				 dump_stack();
 				 mdelay(100);
 			} else {
@@ -1128,8 +1110,8 @@ static void mmc_omap_set_ios(struct mmc_
 	int dsor;
 	int realclock, i;
 
-	DBG("MMC%d: set_ios: clock %dHz busmode %d powermode %d Vdd %d.%02d\n",
-	    host->id, ios->clock, ios->bus_mode, ios->power_mode,
+	dev_dbg(mmc_dev(host->mmc), "set_ios: clock %dHz busmode %d powermode %d Vdd %d.%02d\n",
+	    ios->clock, ios->bus_mode, ios->power_mode,
 	    ios->vdd / 100, ios->vdd % 100);
 
 	if (ios->power_mode == MMC_POWER_UP && ios->clock < 400000)
@@ -1221,7 +1203,7 @@ static int __init mmc_omap_probe(struct 
 
 	if (pdev->resource[0].flags != IORESOURCE_MEM
 	    || pdev->resource[1].flags != IORESOURCE_IRQ) {
-		printk(KERN_ERR "mmc_omap_probe: invalid resource type\n");
+		dev_err(&pdev->dev, "mmc_omap_probe: invalid resource type\n");
 		return -ENODEV;
 	}
 
@@ -1301,8 +1283,7 @@ static int __init mmc_omap_probe(struct 
 
 	if (host->power_pin >= 0) {
 		if ((ret = omap_request_gpio(host->power_pin)) != 0) {
-			printk(KERN_ERR "MMC%d: Unable to get GPIO pin for MMC power\n",
-			       host->id);
+			dev_err(mmc_dev(host->mmc), "Unable to get GPIO pin for MMC power\n");
 			goto out;
 		}
 		omap_set_gpio_direction(host->power_pin, 0);
@@ -1323,8 +1304,7 @@ static int __init mmc_omap_probe(struct 
 		host->switch_timer.function = mmc_omap_switch_timer;
 		host->switch_timer.data = (unsigned long) host;
 		if (omap_request_gpio(host->switch_pin) != 0) {
-			printk(KERN_WARNING "MMC%d: Unable to get GPIO pin for MMC cover switch\n",
-			       host->id);
+			dev_warn(mmc_dev(host->mmc), "Unable to get GPIO pin for MMC cover switch\n");
 			host->switch_pin = -1;
 			goto no_switch;
 		}
@@ -1335,8 +1315,7 @@ static int __init mmc_omap_probe(struct 
 				  SA_TRIGGER_RISING | SA_TRIGGER_FALLING,
 				  DRIVER_NAME, host);
 		if (ret) {
-			printk(KERN_WARNING "MMC%d: Unable to get IRQ for MMC cover switch\n",
-			       host->id);
+			dev_warn(mmc_dev(host->mmc), "Unable to get IRQ for MMC cover switch\n");
 			omap_free_gpio(host->switch_pin);
 			host->switch_pin = -1;
 			goto no_switch;
@@ -1348,8 +1327,7 @@ static int __init mmc_omap_probe(struct 
 				device_remove_file(&pdev->dev, &dev_attr_cover_switch);
 		}
 		if (ret) {
-			printk(KERN_WARNING "MMC%d: Unable to create sysfs attributes\n", 
-			       host->id);
+			dev_warn(mmc_dev(host->mmc), "Unable to create sysfs attributes\n");
 			free_irq(OMAP_GPIO_IRQ(host->switch_pin), host);
 			omap_free_gpio(host->switch_pin);
 			host->switch_pin = -1;

--------------070709000605080908050707
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------070709000605080908050707--
