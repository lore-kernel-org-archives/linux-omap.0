From: Juha =?iso-8859-1?B?WXJq9mzk?= <juha.yrjola@solidboot.com>
Subject: [PATCH] ARM: OMAP: Implement support for two MMC slots
Date: Mon, 19 Jun 2006 19:52:02 +0300
Message-ID: <20060619165202.GA30055@mail.solidboot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
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
List-Id: linux-omap@vger.kernel.org

Hi,

Here's a patch for review.  It is by no means complete yet, but
at least supporting two slots connected to Menelaus does work.

I'd also appreciate patches implementing support for
omap_mmc_platform_data for the various board-*.c files 

Cheers,
Juha

diff-tree 464698d02cea1aae47d88a4fd99fa45f090473f9 (from 6ec81c783e6fe46d02ab2b6d9924ab0788a55e26)
Author: Juha Yrjola <juha.yrjola@solidboot.com>
Date:   Mon Jun 19 19:52:52 2006 +0300

    ARM: OMAP: Implement support for two MMC slots
    
    On OMAP2 boards that use Menelaus, two MMC/SD cards can be connected
    through one set of pins from OMAP to two different slots behind Menelaus.
    Switching which slot is to be accessed is done using a GPIO line.
    
    The MMC driver is now also closer to the way other ARM platforms (e.g. PXA)
    handles board-specific MMC data.  It uses function pointers for powering
    the card and checking the state of the SD read-only switch, among other
    things.
    
    Signed-off-by: Juha Yrjola <juha.yrjola@solidboot.com>

diff --git a/arch/arm/plat-omap/devices.c b/arch/arm/plat-omap/devices.c
index 8bff566..882203e 100644
--- a/arch/arm/plat-omap/devices.c
+++ b/arch/arm/plat-omap/devices.c
@@ -25,6 +25,7 @@ #include <asm/arch/board.h>
 #include <asm/arch/mux.h>
 #include <asm/arch/gpio.h>
 #include <asm/arch/menelaus.h>
+#include <asm/arch/mmc.h>
 
 #if 	defined(CONFIG_I2C_OMAP) || defined(CONFIG_I2C_OMAP_MODULE)
 
@@ -156,7 +157,7 @@ #define OMAP_MMC1_INT		INT_MMC
 #endif
 #define	OMAP_MMC2_BASE		0xfffb7c00	/* omap16xx only */
 
-static struct omap_mmc_conf mmc1_conf;
+static struct omap_mmc_platform_data mmc1_conf;
 
 static u64 mmc1_dmamask = 0xffffffff;
 
@@ -185,7 +186,7 @@ static struct platform_device mmc_omap_d
 
 #ifdef	CONFIG_ARCH_OMAP16XX
 
-static struct omap_mmc_conf mmc2_conf;
+static struct omap_mmc_platform_data mmc2_conf;
 
 static u64 mmc2_dmamask = 0xffffffff;
 
@@ -211,21 +212,16 @@ static struct platform_device mmc_omap_d
 	.num_resources	= ARRAY_SIZE(mmc2_resources),
 	.resource	= mmc2_resources,
 };
+
 #endif
 
 static void __init omap_init_mmc(void)
 {
-	const struct omap_mmc_config	*mmc_conf;
-	const struct omap_mmc_conf	*mmc;
-
-	/* NOTE:  assumes MMC was never (wrongly) enabled */
-	mmc_conf = omap_get_config(OMAP_TAG_MMC, struct omap_mmc_config);
-	if (!mmc_conf)
-		return;
+	struct omap_mmc_platform_data *conf;
 
 	/* block 1 is always available and has just one pinout option */
-	mmc = &mmc_conf->mmc[0];
-	if (mmc->enabled) {
+	conf = &mmc1_conf;
+	if (conf->enabled) {
 		if (!cpu_is_omap24xx()) {
 			omap_cfg_reg(MMC_CMD);
 			omap_cfg_reg(MMC_CLK);
@@ -236,29 +232,28 @@ static void __init omap_init_mmc(void)
 				omap_cfg_reg(P20_1710_MMC_DATDIR0);
 			}
 		}
-		if (mmc->wire4) {
+		if (conf->wire4) {
 			if (!cpu_is_omap24xx()) {
 				omap_cfg_reg(MMC_DAT1);
 				/* NOTE:  DAT2 can be on W10 (here) or M15 */
-				if (!mmc->nomux)
+				if (!conf->nomux)
 					omap_cfg_reg(MMC_DAT2);
 				omap_cfg_reg(MMC_DAT3);
 			}
 		}
-		mmc1_conf = *mmc;
 		(void) platform_device_register(&mmc_omap_device1);
 	}
 
 #ifdef	CONFIG_ARCH_OMAP16XX
 	/* block 2 is on newer chips, and has many pinout options */
-	mmc = &mmc_conf->mmc[1];
-	if (mmc->enabled) {
-		if (!mmc->nomux) {
+	conf = &mmc2_conf;
+	if (conf->enabled) {
+		if (!conf->nomux) {
 			omap_cfg_reg(Y8_1610_MMC2_CMD);
 			omap_cfg_reg(Y10_1610_MMC2_CLK);
 			omap_cfg_reg(R18_1610_MMC2_CLKIN);
 			omap_cfg_reg(W8_1610_MMC2_DAT0);
-			if (mmc->wire4) {
+			if (conf->wire4) {
 				omap_cfg_reg(V8_1610_MMC2_DAT1);
 				omap_cfg_reg(W15_1610_MMC2_DAT2);
 				omap_cfg_reg(R10_1610_MMC2_DAT3);
@@ -274,14 +269,33 @@ #ifdef	CONFIG_ARCH_OMAP16XX
 		if (cpu_is_omap1710())
 			omap_writel(omap_readl(MOD_CONF_CTRL_1) | (1 << 24),
 				     MOD_CONF_CTRL_1);
-		mmc2_conf = *mmc;
 		(void) platform_device_register(&mmc_omap_device2);
 	}
 #endif
 	return;
 }
+
+void omap_set_mmc_info(int host, const struct omap_mmc_platform_data *info)
+{
+	switch (host) {
+	case 1:
+		mmc1_conf = *info;
+		break;
+#ifdef	CONFIG_ARCH_OMAP16XX
+	case 2:
+		mmc2_conf = *info;
+		break;
+#endif
+	default:
+		BUG();
+	}
+}
+
 #else
 static inline void omap_init_mmc(void) {}
+void omap_set_mmc_info(int host, const struct omap_mmc_platform_data *info)
+{
+}
 #endif
 
 /*-------------------------------------------------------------------------*/
diff --git a/drivers/mmc/omap.c b/drivers/mmc/omap.c
index ab2ab45..10d0b32 100644
--- a/drivers/mmc/omap.c
+++ b/drivers/mmc/omap.c
@@ -32,7 +32,7 @@ #include <asm/irq.h>
 #include <asm/scatterlist.h>
 #include <asm/mach-types.h>
 
-#include <asm/arch/board.h>
+#include <asm/arch/mmc.h>
 #include <asm/arch/gpio.h>
 #include <asm/arch/dma.h>
 #include <asm/arch/mux.h>
@@ -98,7 +98,25 @@ #define RSP_TYPE(x)	((x) & ~(MMC_RSP_BUS
  * when the cover switch is open */
 #define OMAP_MMC_SWITCH_POLL_DELAY	500
 
-static int mmc_omap_enable_poll = 1;
+struct mmc_omap_host;
+
+struct mmc_omap_slot {
+	int			id;
+	unsigned int		vdd;
+	u16			saved_con;
+	u16			bus_mode;
+	unsigned		powered:1;
+
+	struct work_struct	cover_work;
+	struct timer_list	cover_timer;
+	int			cover_last_state;
+	int			enable_poll;
+
+	struct mmc_request *	mrq;
+	struct mmc_omap_host *  host;
+	struct mmc_host *	mmc;
+	struct omap_mmc_slot_data *pdata;
+};
 
 struct mmc_omap_host {
 	int			initialized;
@@ -111,12 +129,10 @@ struct mmc_omap_host {
 	unsigned char		id; /* 16xx chips have 2 MMC blocks */
 	struct clk *		iclk;
 	struct clk *		fclk;
-	struct resource		*mem_res;
-	void __iomem		*virt_base;
+	struct resource *	mem_res;
+	void __iomem *		virt_base;
 	unsigned int		phys_base;
 	int			irq;
-	unsigned char		bus_mode;
-	unsigned char		hw_bus_mode;
 
 	unsigned int		sg_len;
 	int			sg_idx;
@@ -133,23 +149,87 @@ struct mmc_omap_host {
 	struct timer_list	dma_timer;
 	unsigned		dma_len;
 
-	short			power_pin;
-	short			wp_pin;
+	struct mmc_omap_slot *	slots[OMAP_MMC_MAX_SLOTS];
+	struct mmc_omap_slot *	current_slot;
+	spinlock_t		slot_lock;
+	wait_queue_head_t	slot_wq;
+	int			nr_slots;
 
-	int			switch_pin;
-	struct work_struct	switch_work;
-	struct timer_list	switch_timer;
-	int			switch_last_state;
+        struct omap_mmc_platform_data *pdata;
 };
 
+static void mmc_omap_select_slot(struct mmc_omap_slot *slot, int claimed)
+{
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
+	OMAP_MMC_WRITE(host, CON, slot->saved_con);
+}
+
+static void mmc_omap_start_request(struct mmc_omap_host *host,
+				   struct mmc_request *req);
+
+static void mmc_omap_release_slot(struct mmc_omap_slot *slot)
+{
+	struct mmc_omap_host *host = slot->host;
+	unsigned long flags;
+	int i;
+
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
+
+		return;
+	}
+
+	host->mmc = NULL;
+	wake_up(&host->slot_wq);
+	spin_unlock_irqrestore(&host->slot_lock, flags);
+}
+
 static inline int
-mmc_omap_cover_is_open(struct mmc_omap_host *host)
+mmc_omap_cover_is_open(struct mmc_omap_slot *slot)
 {
-	if (host->switch_pin < 0)
-		return 0;
-	return omap_get_gpio_datain(host->switch_pin);
+	return slot->pdata->get_cover_state(mmc_dev(slot->mmc), slot->id);
 }
 
+#if 0
 static ssize_t
 mmc_omap_show_cover_switch(struct device *dev,
 	struct device_attribute *attr, char *buf)
@@ -191,6 +271,7 @@ mmc_omap_store_enable_poll(struct device
 
 static DEVICE_ATTR(enable_poll, 0664,
 		   mmc_omap_show_enable_poll, mmc_omap_store_enable_poll);
+#endif
 
 static void
 mmc_omap_start_command(struct mmc_omap_host *host, struct mmc_command *cmd)
@@ -232,7 +313,7 @@ mmc_omap_start_command(struct mmc_omap_h
 
 	cmdreg = cmd->opcode | (resptype << 8) | (cmdtype << 12);
 
-	if (host->bus_mode == MMC_BUSMODE_OPENDRAIN)
+	if (host->current_slot->bus_mode == MMC_BUSMODE_OPENDRAIN)
 		cmdreg |= 1 << 6;
 
 	if (cmd->flags & MMC_RSP_BUSY)
@@ -241,8 +322,6 @@ mmc_omap_start_command(struct mmc_omap_h
 	if (host->data && !(host->data->flags & MMC_DATA_WRITE))
 		cmdreg |= 1 << 15;
 
-	clk_enable(host->fclk);
-
 	OMAP_MMC_WRITE(host, CTO, 200);
 	OMAP_MMC_WRITE(host, ARGL, cmd->arg & 0xffff);
 	OMAP_MMC_WRITE(host, ARGH, cmd->arg >> 16);
@@ -275,7 +354,6 @@ mmc_omap_xfer_done(struct mmc_omap_host 
 	}
 	host->data = NULL;
 	host->sg_len = 0;
-	clk_disable(host->fclk);
 
 	/* NOTE:  MMC layer will sometimes poll-wait CMD13 next, issuing
 	 * dozens of requests until the card finishes writing data.
@@ -283,8 +361,12 @@ mmc_omap_xfer_done(struct mmc_omap_host 
 	 */
 
 	if (!data->stop) {
+		struct mmc_host *mmc;
+
 		host->mrq = NULL;
-		mmc_request_done(host->mmc, data->mrq);
+		mmc = host->mmc;
+		mmc_omap_release_slot(host->current_slot);
+		mmc_request_done(mmc, data->mrq);
 		return;
 	}
 
@@ -368,9 +450,12 @@ mmc_omap_cmd_done(struct mmc_omap_host *
 	}
 
 	if (host->data == NULL || cmd->error != MMC_ERR_NONE) {
+		struct mmc_host *mmc;
+
 		host->mrq = NULL;
-		clk_disable(host->fclk);
-		mmc_request_done(host->mmc, cmd->mrq);
+		mmc = host->mmc;
+		mmc_omap_release_slot(host->current_slot);
+		mmc_request_done(mmc, cmd->mrq);
 	}
 }
 
@@ -495,11 +580,8 @@ #endif
 			/* Timeouts are routine with some commands */
 			if (host->cmd) {
 				if (host->cmd->opcode != MMC_ALL_SEND_CID &&
-						host->cmd->opcode !=
-						MMC_SEND_OP_COND &&
-						host->cmd->opcode !=
-						MMC_APP_CMD &&
-						!mmc_omap_cover_is_open(host))
+				    host->cmd->opcode != MMC_SEND_OP_COND &&
+				    host->cmd->opcode != MMC_APP_CMD)
 					dev_err(mmc_dev(host->mmc),
 						"command timeout, CMD %d\n",
 						host->cmd->opcode);
@@ -566,6 +648,7 @@ #endif
 	return IRQ_HANDLED;
 }
 
+#ifdef XXX
 static irqreturn_t mmc_omap_switch_irq(int irq, void *dev_id, struct pt_regs *regs)
 {
 	struct mmc_omap_host *host = (struct mmc_omap_host *) dev_id;
@@ -620,6 +703,8 @@ static void mmc_omap_switch_handler(void
 	}
 }
 
+#endif
+
 /* Prepare to transfer the next segment of a scatterlist */
 static void
 mmc_omap_prepare_dma(struct mmc_omap_host *host, struct mmc_data *data)
@@ -879,115 +964,109 @@ mmc_omap_prepare_data(struct mmc_omap_ho
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
-
 	/* only touch fifo AFTER the controller readies it */
 	mmc_omap_prepare_data(host, req);
 	mmc_omap_start_command(host, req->cmd);
 	if (host->dma_in_use)
 		omap_start_dma(host->dma_ch);
+	BUG_ON(irqs_disabled());
 }
 
-static void innovator_fpga_socket_power(int on)
+static void mmc_omap_request(struct mmc_host *mmc, struct mmc_request *req)
 {
-#if defined(CONFIG_MACH_OMAP_INNOVATOR) && defined(CONFIG_ARCH_OMAP15XX)
-	if (on) {
-		fpga_write(fpga_read(OMAP1510_FPGA_POWER) | (1 << 3),
-		     OMAP1510_FPGA_POWER);
-	} else {
-		fpga_write(fpga_read(OMAP1510_FPGA_POWER) & ~(1 << 3),
-		     OMAP1510_FPGA_POWER);
-	}
-#endif
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
 
-/*
- * Turn the socket power on/off. Innovator uses FPGA, most boards
- * probably use GPIO.
- */
-static void mmc_omap_power(struct mmc_omap_host *host, int on)
+static void mmc_omap_set_power(struct mmc_omap_slot *slot, int power_on, int vdd)
 {
-	if (on) {
-		if (machine_is_omap_innovator())
-			innovator_fpga_socket_power(1);
-		else if (machine_is_omap_h2())
-			tps65010_set_gpio_out_value(GPIO3, HIGH);
-		else if (machine_is_omap_h3())
-			/* GPIO 4 of TPS65010 sends SD_EN signal */
-			tps65010_set_gpio_out_value(GPIO4, HIGH);
-		else if (cpu_is_omap24xx()) {
-			u16 reg = OMAP_MMC_READ(host, CON);
-			OMAP_MMC_WRITE(host, CON, reg | (1 << 11));
-		} else
-			if (host->power_pin >= 0)
-				omap_set_gpio_dataout(host->power_pin, 1);
-		msleep(1);
-	} else {
-		if (machine_is_omap_innovator())
-			innovator_fpga_socket_power(0);
-		else if (machine_is_omap_h2())
-			tps65010_set_gpio_out_value(GPIO3, LOW);
-		else if (machine_is_omap_h3())
-			tps65010_set_gpio_out_value(GPIO4, LOW);
-		else if (cpu_is_omap24xx()) {
-			u16 reg = OMAP_MMC_READ(host, CON);
-			OMAP_MMC_WRITE(host, CON, reg & ~(1 << 11));
-		} else
-			if (host->power_pin >= 0)
-				omap_set_gpio_dataout(host->power_pin, 0);
+	struct mmc_omap_host *host;
+
+	host = slot->host;
+
+	if (slot->pdata->set_power != NULL)
+		slot->pdata->set_power(mmc_dev(slot->mmc), slot->id, power_on, vdd);
+	if (cpu_is_omap24xx()) {
+		u16 w;
+
+		if (power_on) {
+			w = OMAP_MMC_READ(host, CON);
+			OMAP_MMC_WRITE(host, CON, w | (1 << 11));
+		} else {
+			w = OMAP_MMC_READ(host, CON);
+			OMAP_MMC_WRITE(host, CON, w & ~(1 << 11));
+		}
 	}
 }
 
 static void mmc_omap_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 {
-	struct mmc_omap_host *host = mmc_priv(mmc);
-	int fclk_rate;
-	int dsor;
-	int freq, i;
+	struct mmc_omap_slot *slot = mmc_priv(mmc);
+	struct mmc_omap_host *host = slot->host;
+	int dsor, power_on;
+	int i;
 
-	freq = ios->clock;
+	if (ios->clock != 0) {
+		int freq, fclk_rate;
 
-	/* At least on OMAP2420, the divisor must be != 0 for the
-	 * initialization sequence to complete successfully. */
-	if (freq == 0)
-		freq = 4000000;
+		freq = ios->clock;
 
-	fclk_rate = clk_get_rate(host->fclk);
-	dsor = fclk_rate / freq;
-	if (dsor < 1)
-		dsor = 1;
+		fclk_rate = clk_get_rate(host->fclk);
+		dsor = fclk_rate / freq;
+		if (dsor < 1)
+			dsor = 1;
 
-	if (fclk_rate / dsor > freq)
-		dsor++;
+		if (fclk_rate / dsor > freq)
+			dsor++;
 
-	if (dsor > 250)
-		dsor = 250;
-	dsor++;
+		if (dsor > 250)
+			dsor = 250;
+	} else
+		dsor = 0;
 
 	if (ios->bus_width == MMC_BUS_WIDTH_4)
 		dsor |= 1 << 15;
 
-	switch (ios->power_mode) {
-	case MMC_POWER_OFF:
-		mmc_omap_power(host, 0);
-		break;
-	case MMC_POWER_UP:
-	case MMC_POWER_ON:
-		mmc_omap_power(host, 1);
-		dsor |= 1 << 11;
-		break;
+	if (ios->power_mode != MMC_POWER_OFF)
+		power_on = 1;
+	else
+		power_on = 0;
+
+	mmc_omap_select_slot(slot, 0);
+	if (slot->powered != power_on || ios->vdd != slot->vdd) {
+		mmc_omap_set_power(slot, power_on, ios->vdd);
+		slot->vdd = ios->vdd;
+		slot->powered = power_on;
 	}
 
-	host->bus_mode = ios->bus_mode;
-	host->hw_bus_mode = host->bus_mode;
+	if (power_on)
+		dsor |= 1 << 11;
 
-	clk_enable(host->fclk);
+	slot->bus_mode = ios->bus_mode;
+	if (slot->bus_mode != ios->bus_mode) {
+		if (slot->pdata->set_bus_mode != NULL)
+			slot->pdata->set_bus_mode(mmc_dev(mmc), slot->id, ios->bus_mode);
+		slot->bus_mode = ios->bus_mode;
+	}
 
 	/* On insanely high arm_per frequencies something sometimes
 	 * goes somehow out of sync, and the POW bit is not being set,
@@ -995,23 +1074,25 @@ static void mmc_omap_set_ios(struct mmc_
 	 * Writing to the CON register twice seems to do the trick. */
 	for (i = 0; i < 2; i++)
 		OMAP_MMC_WRITE(host, CON, dsor);
-	if (ios->power_mode == MMC_POWER_UP) {
+	slot->saved_con = dsor;
+	if (ios->power_mode == MMC_POWER_ON) {
 		/* Send clock cycles, poll completion */
 		OMAP_MMC_WRITE(host, IE, 0);
 		OMAP_MMC_WRITE(host, STAT, 0xffff);
 		OMAP_MMC_WRITE(host, CMD, 1 << 7);
-		printk("CMD %04x\n", OMAP_MMC_READ(host, CMD));
 		while ((OMAP_MMC_READ(host, STAT) & 1) == 0);
 		OMAP_MMC_WRITE(host, STAT, 1);
 	}
-	clk_disable(host->fclk);
+	mmc_omap_release_slot(slot);
 }
 
 static int mmc_omap_get_ro(struct mmc_host *mmc)
 {
-	struct mmc_omap_host *host = mmc_priv(mmc);
+	struct mmc_omap_slot *slot = mmc_priv(mmc);
 
-	return host->wp_pin && omap_get_gpio_datain(host->wp_pin);
+	if (slot->pdata->get_ro != NULL)
+		return slot->pdata->get_ro(mmc_dev(mmc), slot->id);
+	return 0;
 }
 
 static struct mmc_host_ops mmc_omap_ops = {
@@ -1020,19 +1101,62 @@ static struct mmc_host_ops mmc_omap_ops 
 	.get_ro		= mmc_omap_get_ro,
 };
 
-static int __init mmc_omap_probe(struct platform_device *pdev)
+static int __init mmc_omap_new_slot(struct mmc_omap_host *host, int id)
 {
-	struct omap_mmc_conf *minfo = pdev->dev.platform_data;
+	struct mmc_omap_slot *slot;
 	struct mmc_host *mmc;
+
+	mmc = mmc_alloc_host(sizeof(struct mmc_omap_slot), host->dev);
+	if (mmc == NULL)
+		return -ENOMEM;
+	slot = mmc_priv(mmc);
+
+	slot->host = host;
+	slot->mmc = mmc;
+	slot->id = id;
+	slot->pdata = &host->pdata->slots[id];
+
+	host->slots[id] = slot;
+
+	if (host->pdata->wire4)
+		mmc->caps |= MMC_CAP_4_BIT_DATA;
+
+	mmc->ops = &mmc_omap_ops;
+	mmc->f_min = 400000;
+	if (cpu_class_is_omap2())
+		mmc->f_max = 48000000;
+	else
+		mmc->f_max = 24000000;
+	mmc->ocr_avail = slot->pdata->ocr_mask;
+
+	/* Use scatterlist DMA to reduce per-transfer costs.
+	 * NOTE max_seg_size assumption that small blocks aren't
+	 * normally used (except e.g. for reading SD registers).
+	 */
+	mmc->max_phys_segs = 32;
+	mmc->max_hw_segs = 32;
+	mmc->max_sectors = 256; /* NBLK max 11-bits, OMAP also limited by DMA */
+	mmc->max_seg_size = mmc->max_sectors * 512;
+
+	return mmc_add_host(mmc);
+}
+
+static int __init mmc_omap_probe(struct platform_device *pdev)
+{
+	struct omap_mmc_platform_data *pdata = pdev->dev.platform_data;
 	struct mmc_omap_host *host = NULL;
 	struct resource *res;
-	int ret = 0;
+	int ret = 0, i;
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
@@ -1044,29 +1168,39 @@ static int __init mmc_omap_probe(struct 
 	if (res == NULL)
 		return -EBUSY;
 
-	mmc = mmc_alloc_host(sizeof(struct mmc_omap_host), &pdev->dev);
-	if (mmc == NULL) {
+	host = kzalloc(sizeof(*host), GFP_KERNEL);
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
-			goto err_free_mmc_host;
+			goto err_free_host;
 		clk_enable(host->iclk);
 	}
 
@@ -1079,106 +1213,34 @@ static int __init mmc_omap_probe(struct 
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
-	if (minfo->wire4)
-		 mmc->caps |= MMC_CAP_4_BIT_DATA;
-
-	mmc->ops = &mmc_omap_ops;
-	mmc->f_min = 400000;
-	mmc->f_max = 24000000;
-	mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
-
-	/* Use scatterlist DMA to reduce per-transfer costs.
-	 * NOTE max_seg_size assumption that small blocks aren't
-	 * normally used (except e.g. for reading SD registers).
-	 */
-	mmc->max_phys_segs = 32;
-	mmc->max_hw_segs = 32;
-	mmc->max_sectors = 256; /* NBLK max 11-bits, OMAP also limited by DMA */
-	mmc->max_seg_size = mmc->max_sectors * 512;
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
-
-	host->dev = &pdev->dev;
-	platform_set_drvdata(pdev, host);
+		goto err_free_fclk;
 
-	if (host->switch_pin >= 0) {
-		INIT_WORK(&host->switch_work, mmc_omap_switch_handler, host);
-		init_timer(&host->switch_timer);
-		host->switch_timer.function = mmc_omap_switch_timer;
-		host->switch_timer.data = (unsigned long) host;
-		if (omap_request_gpio(host->switch_pin) != 0) {
-			dev_warn(mmc_dev(host->mmc), "Unable to get GPIO pin for MMC cover switch\n");
-			host->switch_pin = -1;
-			goto no_switch;
-		}
+	if (pdata->init != NULL) {
+		ret = pdata->init(&pdev->dev);
+		if (ret < 0)
+			goto err_free_irq;
+	}
 
-		omap_set_gpio_direction(host->switch_pin, 1);
-		ret = request_irq(OMAP_GPIO_IRQ(host->switch_pin),
-				  mmc_omap_switch_irq, SA_TRIGGER_RISING, DRIVER_NAME, host);
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
-		}
-		if (ret) {
-			dev_warn(mmc_dev(host->mmc), "Unable to create sysfs attributes\n");
-			free_irq(OMAP_GPIO_IRQ(host->switch_pin), host);
-			omap_free_gpio(host->switch_pin);
-			host->switch_pin = -1;
-			goto no_switch;
+	host->nr_slots = pdata->nr_slots;
+	for (i = 0; i < pdata->nr_slots; i++) {
+		ret = mmc_omap_new_slot(host, i);
+		if (ret < 0) {
+			while (--i >= 0) {
+				mmc_remove_host(host->slots[i]->mmc);
+				mmc_free_host(host->slots[i]->mmc);
+			}
+			goto err_plat_cleanup;
 		}
-		if (mmc_omap_enable_poll && mmc_omap_cover_is_open(host))
-			schedule_work(&host->switch_work);
 	}
-
-	mmc_add_host(mmc);
-
-no_switch:
 	return 0;
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
@@ -1186,35 +1248,30 @@ err_free_iclk:
 		clk_disable(host->iclk);
 		clk_put(host->iclk);
 	}
-err_free_mmc_host:
-	mmc_free_host(host->mmc);
+err_free_host:
+	kfree(host);
 err_free_mem_region:
 	release_mem_region(res->start, res->end - res->start + 1);
+
 	return ret;
 }
 
 static int mmc_omap_remove(struct platform_device *pdev)
 {
 	struct mmc_omap_host *host = platform_get_drvdata(pdev);
+	int i;
 
 	platform_set_drvdata(pdev, NULL);
-
 	BUG_ON(host == NULL);
 
-	mmc_remove_host(host->mmc);
-	free_irq(host->irq, host);
-
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
+	for (i = 0; i < host->nr_slots; i++) {
+		mmc_remove_host(host->slots[i]->mmc);
+		mmc_free_host(host->slots[i]->mmc);
 	}
+
+	if (host->pdata->cleanup)
+		host->pdata->cleanup(&pdev->dev);
+
 	if (host->iclk && !IS_ERR(host->iclk))
 		clk_put(host->iclk);
 	if (host->fclk && !IS_ERR(host->fclk))
@@ -1223,7 +1280,7 @@ static int mmc_omap_remove(struct platfo
 	release_mem_region(pdev->resource[0].start,
 			   pdev->resource[0].end - pdev->resource[0].start + 1);
 
-	mmc_free_host(host->mmc);
+	kfree(host);
 
 	return 0;
 }
diff --git a/include/asm-arm/arch-omap/mmc.h b/include/asm-arm/arch-omap/mmc.h
new file mode 100644
index 0000000..780659a
--- /dev/null
+++ b/include/asm-arm/arch-omap/mmc.h
@@ -0,0 +1,65 @@
+/*
+ * MMC definitions for OMAP2
+ *
+ * Copyright (C) 2006 Nokia Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __OMAP2_MMC_H
+#define __OMAP2_MMC_H
+
+#include <linux/types.h>
+#include <linux/device.h>
+#include <linux/mmc/protocol.h>
+#include <linux/mmc/host.h>
+
+#define OMAP_MMC_MAX_SLOTS	2
+
+struct omap_mmc_platform_data {
+	unsigned enabled:1;
+	/* number of slots on board */
+	unsigned nr_slots:2;
+	/* nomux means "standard" muxing is wrong on this board, and that
+	 * board-specific code handled it before common init logic.
+	 */
+	unsigned nomux:1;
+	/* 4 wire signaling is optional, and is only used for SD/SDIO and
+	 * MMCv4 */
+	unsigned wire4:1;
+
+	/* switch the bus to a new slot */
+	int (* switch_slot)(struct device *dev, int slot);
+	/* initialize board-specific MMC functionality, can be NULL if
+	 * not supported */
+	int (* init)(struct device *dev);
+	void (* cleanup)(struct device *dev);
+
+	struct omap_mmc_slot_data {
+		int (* set_bus_mode)(struct device *dev, int slot, int bus_mode);
+		int (* set_power)(struct device *dev, int slot, int power_on, int vdd);
+		int (* get_ro)(struct device *dev, int slot);
+
+		/* return MMC cover switch state, can be NULL if not supported.
+		 *
+		 * possible return values:
+		 *  -1 - no cover
+		 *   0 - open
+		 *   1 - closed
+		 */
+		int (* get_cover_state)(struct device *dev, int slot);
+
+		u32 ocr_mask;
+	} slots[OMAP_MMC_MAX_SLOTS];
+};
+
+extern void omap_set_mmc_info(int host, const struct omap_mmc_platform_data *info);
+
+/* called from board-specific card detection service routine */
+extern void omap_notify_mmc_card_detect(struct device *dev, int slot, int detected);
+
+extern void omap_notify_cover_event(struct device *dev, int slot, int is_closed);
+
+#endif
