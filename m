From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [patch 2/5] MMC MULTIPLE SLOT SUPPORT BASE
Date: Wed, 8 Mar 2006 10:27:21 +0200
Message-ID: <20060308102721.568c4e98.Hiroshi.DOYU@nokia.com>
References: <20060307171122.002855000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20060307171122.002855000@localhost.localdomain>
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

This modification handles multiple slots at the same time
when an external transceiver(in case, Menelaus) is used.

MMC should handle multiple slots(bus) if an external 
transceiver is used. In that case, we have to take care of 
current working slot until RCA number is assigned to every 
cards in slots by host during card detection phase.
Until RCA assignment is done(in card detection phase), 
when issuing the command, we choose a slot which we want
to access(detect cards), and then after card detection, 
we can access any card by using RCA number and we do not 
have to choose slot number anymore. the concept of slot
number is only needed in detection phase.

For choosing a slot for detection, new struct member "slot" is 
added in "struct mmc_omap_host". This struct can be seen only
in omap layer("drivers/mmc/omap.c"), not by mmc common layer(
"drivers/mmc/mmc.c"). mmc common layer does not know anything 
about slot concept. It can work because a real slot selecting
work(for card detection) is just done by omap layer when issuing
a mmc command(setting some value in register) indeed. This 
advantage is that we can use mmc common layer just as a library
which is a collection of functions to meet just mmc specs without
h/w information at all. There is not h/w specific stuffs in it, 
which means, there are some h/w specific datas, the number of slots, 
current working slot, interrupt event from cover switch,
such kind of concept, mmc common layer need not to care about them
at all. H/W specific work is just  handled by omap layer 
transparently by setting slot number to detect by setting 
slot number in memeber "slot" of "struct mmc_omap_host".

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

 drivers/i2c/chips/menelaus.c         |   19 ++++++++++
 drivers/mmc/mmc.c                    |    4 +-
 drivers/mmc/omap.c                   |   63 ++++++++++++++++++++++++++++-------
 include/asm-arm/arch-omap/menelaus.h |    1 
 4 files changed, 73 insertions(+), 14 deletions(-)

Index: linux-omap/drivers/i2c/chips/menelaus.c
===================================================================
--- linux-omap.orig/drivers/i2c/chips/menelaus.c	2006-03-07 18:19:34.000000000 +0200
+++ linux-omap/drivers/i2c/chips/menelaus.c	2006-03-07 18:19:58.000000000 +0200
@@ -254,6 +254,20 @@
 	return 0;
 }
 
+/* Enable slot selection */
+void menelaus_mmc_slot_selectable(int enable)
+{
+	int reg;
+	down(&menelaus.lock);
+	reg = menelaus_read(MENELAUS_GPIO_CTRL);
+	if (enable)
+		reg |= 0x22;  /* Set SLETSELEN and GPIO2 INPUT*/
+	else
+		reg &= ~0x22;
+	menelaus_write(reg, MENELAUS_GPIO_CTRL);
+	up(&menelaus.lock);
+}
+
 /* Initializes MMC slots */
 void menelaus_mmc_register(void (*callback)(unsigned long data, u8 card_mask), unsigned long data)
 {
@@ -265,7 +279,7 @@
 	menelaus_write(reg, MENELAUS_DCDC_CTRL1);
 
 	reg = menelaus_read(MENELAUS_DCDC_CTRL3);
-	reg |= 0x6;
+	reg = 0x3;
 	menelaus_write(reg, MENELAUS_DCDC_CTRL3);
 
 	/* Enable both slots, do not set auto shutdown */
@@ -288,6 +302,9 @@
 	reg |= 0x03;
 	menelaus_write(reg, MENELAUS_LDO_CTRL7);
 
+	/* set off slot selection at first */
+	menelaus_mmc_slot_selectable(0);
+
 	menelaus.mmc_callback_data = data;
 	menelaus.mmc_callback = callback;
 
Index: linux-omap/drivers/mmc/mmc.c
===================================================================
--- linux-omap.orig/drivers/mmc/mmc.c	2006-03-07 18:19:34.000000000 +0200
+++ linux-omap/drivers/mmc/mmc.c	2006-03-07 18:19:58.000000000 +0200
@@ -285,6 +285,7 @@
 	remove_wait_queue(&host->wq, &wait);
 
 	if (card != (void *)-1) {
+		host->ops->set_ios(host, &host->ios);
 		err = mmc_select_card(host, card);
 		if (err != MMC_ERR_NONE)
 			return err;
@@ -1035,7 +1036,7 @@
 
 			err = mmc_send_op_cond(host, 0, &ocr);
 			if (err != MMC_ERR_NONE)
-				return;
+				goto out;
 		}
 
 		host->ocr = mmc_select_voltage(host, ocr);
@@ -1086,6 +1087,7 @@
 	/*
 	 * Ok, now switch to push-pull mode.
 	 */
+ out:
 	host->ios.bus_mode = MMC_BUSMODE_PUSHPULL;
 	host->ops->set_ios(host, &host->ios);
 
Index: linux-omap/drivers/mmc/omap.c
===================================================================
--- linux-omap.orig/drivers/mmc/omap.c	2006-03-07 18:19:37.000000000 +0200
+++ linux-omap/drivers/mmc/omap.c	2006-03-07 18:19:58.000000000 +0200
@@ -95,8 +95,12 @@
 	struct timer_list	dma_timer;
 	unsigned		dma_len;
 
+	unsigned int            slot;           /* currently working slot */
+	unsigned int            slots;          /* # of slots */
+
 	short			power_pin;
 	short			wp_pin;
+	short			slot_enable_gpio;
 
 	int			switch_pin;
 	struct work_struct	switch_work;
@@ -104,6 +108,37 @@
 	int			switch_last_state;
 };
 
+static inline void mmc_omap_enable_slot(struct mmc_omap_host *host)
+{
+	BUG_ON(((host->slot != 0) && (host->slot != 1)));
+
+	omap_set_gpio_direction(host->slot_enable_gpio, 0);
+
+	switch (host->slot) {
+	case 0: /* SLOT 1 */
+		omap_set_gpio_dataout(host->slot_enable_gpio, 0);
+		break;
+	case 1: /* SLOT 2 */
+		omap_set_gpio_dataout(host->slot_enable_gpio, 1);
+		break;
+	}
+}
+
+static inline void mmc_omap_set_menelaus(struct mmc_omap_host *host)
+{
+	if (!omap_has_menelaus())
+		return;
+
+	if (host->bus_mode == MMC_BUSMODE_OPENDRAIN) {
+		menelaus_mmc_opendrain(1);
+		menelaus_mmc_slot_selectable(1);
+		mmc_omap_enable_slot(host);
+	} else {
+		menelaus_mmc_opendrain(0);
+		menelaus_mmc_slot_selectable(0);
+	}
+}
+
 static inline int
 mmc_omap_cover_is_open(struct mmc_omap_host *host)
 {
@@ -177,11 +212,8 @@
 	 * In that case we need to manually toggle between open-drain
 	 * and push-pull states.
 	 */
-	if (omap_has_menelaus() && (host->bus_mode != host->hw_bus_mode)) {
-		if (host->bus_mode == MMC_BUSMODE_OPENDRAIN)
-			menelaus_mmc_opendrain(1);
-		else
-			menelaus_mmc_opendrain(0);
+	if (host->bus_mode != host->hw_bus_mode) {
+		mmc_omap_set_menelaus(host);
 		host->hw_bus_mode = host->bus_mode;
 	}
 
@@ -1169,12 +1201,7 @@
 	}
 
 	host->bus_mode = ios->bus_mode;
-	if (omap_has_menelaus()) {
-		if (host->bus_mode == MMC_BUSMODE_OPENDRAIN)
-			menelaus_mmc_opendrain(1);
-		else
-			menelaus_mmc_opendrain(0);
-	}
+	mmc_omap_set_menelaus(host);
 	host->hw_bus_mode = host->bus_mode;
 
 	clk_enable(host->fclk);
@@ -1203,7 +1230,7 @@
 {
 	struct mmc_omap_host *host = mmc_priv(mmc);
 
-	return host->wp_pin && omap_get_gpio_datain(host->wp_pin);
+	return (host->wp_pin >= 0) && omap_get_gpio_datain(host->wp_pin);
 }
 
 static struct mmc_host_ops mmc_omap_ops = {
@@ -1276,6 +1303,8 @@
 	host->power_pin = minfo->power_pin;
 	host->switch_pin = minfo->switch_pin;
 	host->wp_pin = minfo->wp_pin;
+	host->slot_enable_gpio = minfo->slot_enable_gpio;
+
 	host->use_dma = 1;
 	host->dma_ch = -1;
 
@@ -1315,7 +1344,17 @@
 	host->dev = &pdev->dev;
 	platform_set_drvdata(pdev, host);
 
+	if (host->slot_enable_gpio != -1)
+		host->slots = 2;
+
 	mmc_add_host(mmc);
+	flush_scheduled_work();
+
+	while (++host->slot < host->slots) {
+		mmc->ios.power_mode = MMC_POWER_OFF;
+		mmc_detect_change(mmc, 0);
+		flush_scheduled_work();
+	}
 
 	if (host->switch_pin >= 0) {
 		INIT_WORK(&host->switch_work, mmc_omap_switch_handler, host);
Index: linux-omap/include/asm-arm/arch-omap/menelaus.h
===================================================================
--- linux-omap.orig/include/asm-arm/arch-omap/menelaus.h	2006-03-07 18:19:34.000000000 +0200
+++ linux-omap/include/asm-arm/arch-omap/menelaus.h	2006-03-07 18:19:58.000000000 +0200
@@ -11,6 +11,7 @@
 				  unsigned long data);
 extern void menelaus_mmc_remove(void);
 extern void menelaus_mmc_opendrain(int enable);
+extern void menelaus_mmc_slot_selectable(int enable);
 
 #if defined(CONFIG_ARCH_OMAP24XX) && defined(CONFIG_MENELAUS)
 #define omap_has_menelaus()	1

--

		Hiroshi DOYU
