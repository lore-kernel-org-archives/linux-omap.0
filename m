From: Tony Lindgren <tony@atomide.com>
Subject: Re: linux-omap vs N810
Date: Mon, 28 Apr 2008 16:21:42 -0700
Message-ID: <20080428232142.GC8449@atomide.com>
References: <55288.89.77.111.170.1209333669.squirrel@mail.gen2.org> <20080428092655.a5e285a9.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="nVMJ2NtxeReIH9PS"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:65050 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934184AbYD1XVx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Apr 2008 19:21:53 -0400
Content-Disposition: inline
In-Reply-To: <20080428092655.a5e285a9.jarkko.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: "ext astralstorm@gen2.org" <astralstorm@gen2.org>, linux-omap@vger.kernel.org


--nVMJ2NtxeReIH9PS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

* Jarkko Nikula <jarkko.nikula@nokia.com> [080427 23:26]:
> On Mon, 28 Apr 2008 00:01:09 +0200 (CEST)
> "ext astralstorm@gen2.org" <astralstorm@gen2.org> wrote:
> 
> > Hello,
> > I'm having a major problem running linux-omap kernel on Nokia N810.
> > After correct build and flashing (tested by the use of self-built
> > patched Nokia kernel) the device seems to hang before framebuffer
> > initialization, then is rebooted by the watchdog. Manual FB update is
> > disabled, I've checked the configuration in many possible ways.
> > 
> > I'd like to hear about possible causes of that.
> > 
> Most probably reason is development time machine id 5555 passed by the
> bootloader where linux-omap is using official id of 1548. This will be
> corrected in our future SW releases.
> 
> Try to "hack" change N810 machine id in arch/arm/tools/mach-types from
> 1548 to 5555.

Attached are some patches to boot N810 with current linux-omap kernel and
mount root on the internal MMC. I'm currently booting to Debian sid
created with debootstrap, but this should work for any distro.

I also put up a page for it with more notes:

http://www.muru.com/linux/n8x0/

Only the first few patches are ready for merging, hopefully we can get
all the attached hacks worked away soon..

Tony


--nVMJ2NtxeReIH9PS
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="0001-V4L-Fix-compile-for-24xx-camera.patch"

>From 19e546ef60e84692e8c357e092a03365993e1552 Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Mon, 28 Apr 2008 14:55:27 -0700
Subject: [PATCH] V4L: Fix compile for 24xx camera

Fix compile for 24xx camera

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/media/video/omap/camera_core.c |    2 +-
 drivers/media/video/omap24xxcam.c      |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/video/omap/camera_core.c b/drivers/media/video/omap/camera_core.c
index dce47fc..eeedb36 100644
--- a/drivers/media/video/omap/camera_core.c
+++ b/drivers/media/video/omap/camera_core.c
@@ -916,7 +916,7 @@ static int camera_core_open(struct inode *inode, struct file *file)
 	vidioc_int_g_fmt_cap(cam->sdev, &format);
 	spin_unlock(&cam->img_lock);
 
-	videobuf_queue_pci_init(&fh->vbq, &cam->vbq_ops, NULL, &cam->vbq_lock,
+	videobuf_queue_sg_init(&fh->vbq, &cam->vbq_ops, NULL, &cam->vbq_lock,
 			    fh->type, V4L2_FIELD_NONE,
 			    sizeof(struct videobuf_buffer), fh);
 
diff --git a/drivers/media/video/omap24xxcam.c b/drivers/media/video/omap24xxcam.c
index 4308fec..dfd3479 100644
--- a/drivers/media/video/omap24xxcam.c
+++ b/drivers/media/video/omap24xxcam.c
@@ -1493,7 +1493,7 @@ static int omap24xxcam_open(struct inode *inode, struct file *file)
 
 	spin_lock_init(&fh->vbq_lock);
 
-	videobuf_queue_pci_init(&fh->vbq, &omap24xxcam_vbq_ops, NULL,
+	videobuf_queue_sg_init(&fh->vbq, &omap24xxcam_vbq_ops, NULL,
 				&fh->vbq_lock, V4L2_BUF_TYPE_VIDEO_CAPTURE,
 				V4L2_FIELD_NONE,
 				sizeof(struct videobuf_buffer), fh);
-- 
1.5.3.6


--nVMJ2NtxeReIH9PS
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="0002-BT-Sync-hcih4p-with-Nokia-N810-driver-and-fix-compi.patch"

>From 74c922e92ccaf702baf04eb72c93c25c4f4fea09 Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Wed, 23 Apr 2008 16:39:36 -0700
Subject: [PATCH] BT: Sync hcih4p with Nokia N810 driver and fix compile

Sync hcih4p with kernel-source-rx-34-2.6.21.0 and fix compile.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/bluetooth/hci_h4p/core.c    |   19 ++++++++-----------
 drivers/bluetooth/hci_h4p/hci_h4p.h |    1 +
 drivers/bluetooth/hci_h4p/uart.c    |   11 ++++++++++-
 3 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/bluetooth/hci_h4p/core.c b/drivers/bluetooth/hci_h4p/core.c
index 09c1f93..7fb5d12 100644
--- a/drivers/bluetooth/hci_h4p/core.c
+++ b/drivers/bluetooth/hci_h4p/core.c
@@ -144,7 +144,7 @@ static void hci_h4p_enable_rx(struct hci_h4p_info *info)
 	if (info->rx_pm_enabled) {
 		hci_h4p_set_clk(info, &info->rx_clocks_en, 1);
 		hci_h4p_outb(info, UART_IER, hci_h4p_inb(info, UART_IER) | UART_IER_RDI);
-		hci_h4p_set_auto_ctsrts(info, 1, UART_EFR_RTS);
+		__hci_h4p_set_auto_ctsrts(info, 1, UART_EFR_RTS);
 		info->rx_pm_enabled = 0;
 	}
 	spin_unlock_irqrestore(&info->lock, flags);
@@ -157,7 +157,7 @@ static void hci_h4p_rx_pm_timer(unsigned long data)
 
 	spin_lock_irqsave(&info->lock, flags);
 	if (!(hci_h4p_inb(info, UART_LSR) & UART_LSR_DR)) {
-		hci_h4p_set_auto_ctsrts(info, 0, UART_EFR_RTS);
+		__hci_h4p_set_auto_ctsrts(info, 0, UART_EFR_RTS);
 		hci_h4p_set_rts(info, 0);
 		hci_h4p_outb(info, UART_IER, hci_h4p_inb(info, UART_IER) & ~UART_IER_RDI);
 		hci_h4p_set_clk(info, &info->rx_clocks_en, 0);
@@ -231,7 +231,6 @@ static void hci_h4p_negotiation_packet(struct hci_h4p_info *info,
 			goto neg_ret;
 
 		hci_h4p_change_speed(info, MAX_BAUD_RATE);
-		hci_h4p_set_rts(info, 1);
 
 		err = hci_h4p_wait_for_cts(info, 1, 100);
 		if (err < 0)
@@ -252,8 +251,8 @@ static void hci_h4p_negotiation_packet(struct hci_h4p_info *info,
 	return;
 
 neg_ret:
-	complete(&info->init_completion);
 	info->init_error = err;
+	complete(&info->init_completion);
 	kfree_skb(skb);
 }
 
@@ -511,7 +510,6 @@ static irqreturn_t hci_h4p_interrupt(int irq, void *data)
 		ret = IRQ_HANDLED;
 	}
 
-
 	return ret;
 }
 
@@ -545,7 +543,6 @@ static int hci_h4p_reset(struct hci_h4p_info *info)
 	int err;
 
 	hci_h4p_init_uart(info);
-	hci_h4p_set_auto_ctsrts(info, 0, UART_EFR_CTS | UART_EFR_RTS);
 	hci_h4p_set_rts(info, 0);
 
 	omap_set_gpio_dataout(info->reset_gpio, 0);
@@ -626,8 +623,6 @@ static int hci_h4p_hci_open(struct hci_dev *hdev)
 	if (err < 0)
 		goto err_clean;
 
-	hci_h4p_set_auto_ctsrts(info, 1, UART_EFR_CTS | UART_EFR_RTS);
-
 	err = hci_h4p_send_fw(info, &fw_queue);
 	if (err < 0) {
 		dev_err(info->dev, "Sending firmware failed.\n");
@@ -675,6 +670,8 @@ static int hci_h4p_hci_close(struct hci_dev *hdev)
 	del_timer_sync(&info->rx_pm_timer);
 	tasklet_disable(&info->tx_task);
 	tasklet_disable(&info->rx_task);
+	hci_h4p_set_clk(info, &info->tx_clocks_en, 1);
+	hci_h4p_set_clk(info, &info->rx_clocks_en, 1);
 	hci_h4p_reset_uart(info);
 	hci_h4p_set_clk(info, &info->tx_clocks_en, 0);
 	hci_h4p_set_clk(info, &info->rx_clocks_en, 0);
@@ -906,7 +903,8 @@ static int hci_h4p_probe(struct platform_device *pdev)
 	}
 
 	err = request_irq(OMAP_GPIO_IRQ(info->host_wakeup_gpio),
-			  hci_h4p_wakeup_interrupt, SA_TRIGGER_FALLING | SA_TRIGGER_RISING,
+			  hci_h4p_wakeup_interrupt,
+				IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING,
 			  "hci_h4p_wkup", (void *)info);
 	if (err < 0) {
 		dev_err(info->dev, "hci_h4p: unable to get wakeup IRQ %d\n",
@@ -916,11 +914,10 @@ static int hci_h4p_probe(struct platform_device *pdev)
 	}
 
 	hci_h4p_set_clk(info, &info->tx_clocks_en, 1);
+	hci_h4p_set_auto_ctsrts(info, 0, UART_EFR_CTS | UART_EFR_RTS);
 	err = hci_h4p_init_uart(info);
 	if (err < 0)
 		goto cleanup_irq;
-	hci_h4p_set_auto_ctsrts(info, 0, UART_EFR_CTS | UART_EFR_RTS);
-	hci_h4p_set_rts(info, 0);
 	err = hci_h4p_reset(info);
 	if (err < 0)
 		goto cleanup_irq;
diff --git a/drivers/bluetooth/hci_h4p/hci_h4p.h b/drivers/bluetooth/hci_h4p/hci_h4p.h
index af9da25..eed5205 100644
--- a/drivers/bluetooth/hci_h4p/hci_h4p.h
+++ b/drivers/bluetooth/hci_h4p/hci_h4p.h
@@ -174,6 +174,7 @@ void hci_h4p_outb(struct hci_h4p_info *info, unsigned int offset, u8 val);
 u8 hci_h4p_inb(struct hci_h4p_info *info, unsigned int offset);
 void hci_h4p_set_rts(struct hci_h4p_info *info, int active);
 int hci_h4p_wait_for_cts(struct hci_h4p_info *info, int active, int timeout_ms);
+void __hci_h4p_set_auto_ctsrts(struct hci_h4p_info *info, int on, u8 which);
 void hci_h4p_set_auto_ctsrts(struct hci_h4p_info *info, int on, u8 which);
 void hci_h4p_change_speed(struct hci_h4p_info *info, unsigned long speed);
 int hci_h4p_reset_uart(struct hci_h4p_info *info);
diff --git a/drivers/bluetooth/hci_h4p/uart.c b/drivers/bluetooth/hci_h4p/uart.c
index 67220fb..1b75a42 100644
--- a/drivers/bluetooth/hci_h4p/uart.c
+++ b/drivers/bluetooth/hci_h4p/uart.c
@@ -75,7 +75,7 @@ int hci_h4p_wait_for_cts(struct hci_h4p_info *info, int active,
 	}
 }
 
-void hci_h4p_set_auto_ctsrts(struct hci_h4p_info *info, int on, u8 which)
+void __hci_h4p_set_auto_ctsrts(struct hci_h4p_info *info, int on, u8 which)
 {
 	u8 lcr, b;
 
@@ -90,6 +90,15 @@ void hci_h4p_set_auto_ctsrts(struct hci_h4p_info *info, int on, u8 which)
 	hci_h4p_outb(info, UART_LCR, lcr);
 }
 
+void hci_h4p_set_auto_ctsrts(struct hci_h4p_info *info, int on, u8 which)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&info->lock, flags);
+	__hci_h4p_set_auto_ctsrts(info, on, which);
+	spin_unlock_irqrestore(&info->lock, flags);
+}
+
 void hci_h4p_change_speed(struct hci_h4p_info *info, unsigned long speed)
 {
 	unsigned int divisor;
-- 
1.5.3.6


--nVMJ2NtxeReIH9PS
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="0003-Add-support-for-N810-internal-MMC.-Adapted-from-Noki.patch"

>From 20d9c19a2230fbafdf0df85e69ad99f3887280cc Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Mon, 21 Apr 2008 13:01:25 -0700
Subject: [PATCH] Add support for N810 internal MMC. Adapted from Nokia
 Maemo sources kernel-source-rx-34-2.6.21.0 with Menelaus
 changes left out for now.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-n800-mmc.c |  147 ++++++++++++++++++++++++++--------
 include/asm-arm/arch-omap/mmc.h      |    4 +
 2 files changed, 119 insertions(+), 32 deletions(-)

diff --git a/arch/arm/mach-omap2/board-n800-mmc.c b/arch/arm/mach-omap2/board-n800-mmc.c
index b1219d1..26f3709 100644
--- a/arch/arm/mach-omap2/board-n800-mmc.c
+++ b/arch/arm/mach-omap2/board-n800-mmc.c
@@ -19,14 +19,20 @@
 #ifdef CONFIG_MMC_OMAP
 
 static const int slot_switch_gpio = 96;
+
+static const int n810_slot2_pw_vddf = 23;
+static const int n810_slot2_pw_vdd = 9;
+
 static int slot1_cover_open;
 static int slot2_cover_open;
 static struct device *mmc_device;
 
 /*
- * VMMC --> slot 1
- * VDCDC3_APE, VMCS2_APE --> slot 2
+ * VMMC   --> slot 1 (N800 & N810)
+ * VDCDC3_APE, VMCS2_APE --> slot 2 on N800
  * GPIO96 --> Menelaus GPIO2
+ * GPIO23 --> controls slot2 VSD    (N810 only)
+ * GPIO9  --> controls slot2 VIO_SD (N810 only)
  */
 
 static int n800_mmc_switch_slot(struct device *dev, int slot)
@@ -41,8 +47,8 @@ static int n800_mmc_switch_slot(struct device *dev, int slot)
 	return 0;
 }
 
-static int n800_mmc_set_power(struct device *dev, int slot, int power_on,
-				int vdd)
+static int n800_mmc_set_power_menelaus(struct device *dev, int slot,
+					int power_on, int vdd)
 {
 	int mV;
 
@@ -110,14 +116,42 @@ static int n800_mmc_set_power(struct device *dev, int slot, int power_on,
 	return 0;
 }
 
+static void nokia_mmc_set_power_internal(struct device *dev,
+					 int power_on)
+{
+	dev_dbg(dev, "Set internal slot power %s\n",
+		power_on ? "on" : "off");
+
+	if (power_on) {
+		omap_set_gpio_dataout(n810_slot2_pw_vddf, 1);
+		udelay(30);
+		omap_set_gpio_dataout(n810_slot2_pw_vdd, 1);
+		udelay(100);
+	} else {
+		omap_set_gpio_dataout(n810_slot2_pw_vdd, 0);
+		msleep(50);
+		omap_set_gpio_dataout(n810_slot2_pw_vddf, 0);
+		msleep(50);
+	}
+}
+
+static int n800_mmc_set_power(struct device *dev, int slot, int power_on,
+			      int vdd)
+{
+	if (machine_is_nokia_n800() || slot == 0)
+		return n800_mmc_set_power_menelaus(dev, slot, power_on, vdd);
+
+	nokia_mmc_set_power_internal(dev, power_on);
+
+	return 0;
+}
+
 static int n800_mmc_set_bus_mode(struct device *dev, int slot, int bus_mode)
 {
 	int r;
 
-#ifdef CONFIG_MMC_DEBUG
 	dev_dbg(dev, "Set slot %d bus mode %s\n", slot + 1,
 		bus_mode == MMC_BUSMODE_OPENDRAIN ? "open-drain" : "push-pull");
-#endif
 	BUG_ON(slot != 0 && slot != 1);
 	slot++;
 	switch (bus_mode) {
@@ -136,24 +170,6 @@ static int n800_mmc_set_bus_mode(struct device *dev, int slot, int bus_mode)
 	return r;
 }
 
-#if 0
-static int n800_mmc_get_ro(struct device *dev, int slot)
-{
-	int ro;
-
-	slot++;
-	if (slot == 1)
-		ro = omap_get_gpio_datain(slot1_wp_gpio);
-	else
-		ro = omap_get_gpio_datain(slot2_wp_gpio);
-#ifdef CONFIG_MMC_DEBUG
-	dev_dbg(dev, "Get RO slot %d: %s\n",
-		slot, ro ? "read-only" : "read-write");
-#endif
-	return ro;
-}
-#endif
-
 static int n800_mmc_get_cover_state(struct device *dev, int slot)
 {
 	slot++;
@@ -172,6 +188,10 @@ static void n800_mmc_callback(void *data, u8 card_mask)
 		bit = 1 << 1;
 		openp = &slot2_cover_open;
 		index = 1;
+	} else {
+		bit = 1;
+		openp = &slot1_cover_open;
+		index = 0;
 	}
 
 	if (card_mask & bit)
@@ -182,18 +202,19 @@ static void n800_mmc_callback(void *data, u8 card_mask)
 	omap_mmc_notify_cover_event(mmc_device, index, *openp);
 }
 
-void n800_mmc_slot1_cover_handler(void *arg, int state)
+void n800_mmc_slot1_cover_handler(void *arg, int closed_state)
 {
 	if (mmc_device == NULL)
 		return;
 
-	slot1_cover_open = !state;
-	omap_mmc_notify_cover_event(mmc_device, 0, state);
+	slot1_cover_open = !closed_state;
+	omap_mmc_notify_cover_event(mmc_device, 0, closed_state);
 }
 
 static int n800_mmc_late_init(struct device *dev)
 {
 	int r, bit, *openp;
+	int vs2sel;
 
 	mmc_device = dev;
 
@@ -201,10 +222,22 @@ static int n800_mmc_late_init(struct device *dev)
 	if (r < 0)
 		return r;
 
+	if (machine_is_nokia_n800())
+		vs2sel = 0;
+	else
+		vs2sel = 2;
+
+	r = menelaus_set_mmc_slot(2, 0, vs2sel, 1);
+	if (r < 0)
+		return r;
+
+	n800_mmc_set_power(dev, 0, MMC_POWER_ON, 16); /* MMC_VDD_28_29 */
+	n800_mmc_set_power(dev, 1, MMC_POWER_ON, 16);
+
 	r = menelaus_set_mmc_slot(1, 1, 0, 1);
 	if (r < 0)
 		return r;
-	r = menelaus_set_mmc_slot(2, 1, 0, 1);
+	r = menelaus_set_mmc_slot(2, 1, vs2sel, 1);
 	if (r < 0)
 		return r;
 
@@ -215,6 +248,10 @@ static int n800_mmc_late_init(struct device *dev)
 	if (machine_is_nokia_n800()) {
 		bit = 1 << 1;
 		openp = &slot2_cover_open;
+	} else {
+		bit = 1;
+		openp = &slot1_cover_open;
+		slot2_cover_open = 0;
 	}
 
 	/* All slot pin bits seem to be inversed until first swith change */
@@ -231,9 +268,29 @@ static int n800_mmc_late_init(struct device *dev)
 	return r;
 }
 
+static void n800_mmc_shutdown(struct device *dev)
+{
+	int vs2sel;
+
+	if (machine_is_nokia_n800())
+		vs2sel = 0;
+	else
+		vs2sel = 2;
+
+	menelaus_set_mmc_slot(1, 0, 0, 0);
+	menelaus_set_mmc_slot(2, 0, vs2sel, 0);
+}
+
 static void n800_mmc_cleanup(struct device *dev)
 {
 	menelaus_unregister_mmc_callback();
+
+	omap_free_gpio(slot_switch_gpio);
+
+	if (machine_is_nokia_n810()) {
+		omap_free_gpio(n810_slot2_pw_vddf);
+		omap_free_gpio(n810_slot2_pw_vdd);
+	}
 }
 
 static struct omap_mmc_platform_data n800_mmc_data = {
@@ -241,14 +298,15 @@ static struct omap_mmc_platform_data n800_mmc_data = {
 	.switch_slot		= n800_mmc_switch_slot,
 	.init			= n800_mmc_late_init,
 	.cleanup		= n800_mmc_cleanup,
+	.shutdown		= n800_mmc_shutdown,
+	.max_freq               = 24000000,
 	.slots[0] = {
 		.set_power	= n800_mmc_set_power,
 		.set_bus_mode	= n800_mmc_set_bus_mode,
 		.get_ro		= NULL,
 		.get_cover_state= n800_mmc_get_cover_state,
-		.ocr_mask	= MMC_VDD_165_195 |
-				  MMC_VDD_28_29 | MMC_VDD_30_31 |
-				  MMC_VDD_32_33 | MMC_VDD_33_34,
+		.ocr_mask	= MMC_VDD_165_195 | MMC_VDD_30_31 |
+				  MMC_VDD_32_33   | MMC_VDD_33_34,
 		.name		= "internal",
 	},
 	.slots[1] = {
@@ -266,14 +324,39 @@ static struct omap_mmc_platform_data n800_mmc_data = {
 };
 
 void __init n800_mmc_init(void)
+
 {
+	if (machine_is_nokia_n810()) {
+		n800_mmc_data.slots[0].name = "external";
+
+		/*
+		 * Some Samsung Movinand chips do not like open-ended
+		 * multi-block reads and fall to braind-dead state
+		 * while doing so. Reducing the number of blocks in
+		 * the transfer or delays in clock disable do not help
+		 */
+		n800_mmc_data.slots[1].name = "internal";
+		n800_mmc_data.slots[1].ban_openended = 1;
+	}
+
 	omap_set_mmc_info(1, &n800_mmc_data);
 	if (omap_request_gpio(slot_switch_gpio) < 0)
 		BUG();
 	omap_set_gpio_dataout(slot_switch_gpio, 0);
 	omap_set_gpio_direction(slot_switch_gpio, 0);
-}
 
+	if (machine_is_nokia_n810()) {
+		if (omap_request_gpio(n810_slot2_pw_vddf) < 0)
+			BUG();
+		omap_set_gpio_dataout(n810_slot2_pw_vddf, 0);
+		omap_set_gpio_direction(n810_slot2_pw_vddf, 0);
+
+		if (omap_request_gpio(n810_slot2_pw_vdd) < 0)
+			BUG();
+		omap_set_gpio_dataout(n810_slot2_pw_vdd, 0);
+		omap_set_gpio_direction(n810_slot2_pw_vdd, 0);
+	}
+}
 #else
 
 void __init n800_mmc_init(void)
diff --git a/include/asm-arm/arch-omap/mmc.h b/include/asm-arm/arch-omap/mmc.h
index 3c2f2c1..6dff38e 100644
--- a/include/asm-arm/arch-omap/mmc.h
+++ b/include/asm-arm/arch-omap/mmc.h
@@ -35,6 +35,7 @@ struct omap_mmc_platform_data {
 	 * not supported */
 	int (* init)(struct device *dev);
 	void (* cleanup)(struct device *dev);
+	void (* shutdown)(struct device *dev);
 
 	/* To handle board related suspend/resume functionality for MMC */
 	int (*suspend)(struct device *dev, int slot);
@@ -59,6 +60,9 @@ struct omap_mmc_platform_data {
 		/* Card detection IRQs */
 		int card_detect_irq;
 		int (* card_detect)(int irq);
+
+		unsigned int ban_openended:1;
+
 	} slots[OMAP_MMC_MAX_SLOTS];
 };
 
-- 
1.5.3.6


--nVMJ2NtxeReIH9PS
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="0004-Change-N810-machine-id-temporarily-to-5555-as-that-s.patch"

>From b0f2ec32cc7e4ef36d483d2786d123f995eb6088 Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Mon, 28 Apr 2008 10:40:58 -0700
Subject: [PATCH] Change N810 machine id temporarily to 5555 as that's what the booloader uses..

Not intended for merging, bootloader should be updated instead.
---
 arch/arm/tools/mach-types |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/tools/mach-types b/arch/arm/tools/mach-types
index 207a8b5..9be1704 100644
--- a/arch/arm/tools/mach-types
+++ b/arch/arm/tools/mach-types
@@ -1544,7 +1544,7 @@ a9sam6432		MACH_A9SAM6432		A9SAM6432		1544
 shiny			MACH_SHINY		SHINY			1545
 omap3_beagle		MACH_OMAP3_BEAGLE	OMAP3_BEAGLE		1546
 csr_bdb2		MACH_CSR_BDB2		CSR_BDB2		1547
-nokia_n810		MACH_NOKIA_N810		NOKIA_N810		1548
+nokia_n810		MACH_NOKIA_N810		NOKIA_N810		5555
 c270			MACH_C270		C270			1549
 sentry			MACH_SENTRY		SENTRY			1550
 pcm038			MACH_PCM038		PCM038			1551
-- 
1.5.3.6


--nVMJ2NtxeReIH9PS
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="0005-N810-Disables-serial-port-clocks.patch"

>From ae2db425aac36719575eb8b464550c455a42eb09 Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Mon, 28 Apr 2008 15:26:58 -0700
Subject: [PATCH] N810: Disables serial port clocks

As 8250 driver does not support managing clocks, disable serial clocks.
Disabling serial clocks is needed for power management to enter
deep sleep during idle.

N810 bluetooth driver will enable it's clock so bluetooth works.

Note that trying to access serial ports will cause
"Unhandled fault: external abort on linefetch" errors.

This issue will get properly fixed with omap specific serial driver.

This patch is not intended for merging.
---
 arch/arm/mach-omap2/serial.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index c9697a4..0dd6051 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -19,6 +19,7 @@
 #include <linux/clk.h>
 
 #include <asm/io.h>
+#include <asm/mach-types.h>
 
 #include <asm/arch/common.h>
 #include <asm/arch/board.h>
@@ -112,6 +113,9 @@ void __init omap_serial_init(void)
 			continue;
 		}
 
+		if (machine_is_nokia_n800() || machine_is_nokia_n810())
+			continue;
+
 		switch (i) {
 		case 0:
 			uart1_ick = clk_get(NULL, "uart1_ick");
-- 
1.5.3.6


--nVMJ2NtxeReIH9PS
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="0006-n810-debian-config.patch"

>From 628fa7cee2e2883d1f19dcaa250d0fc06ca45d73 Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Wed, 23 Apr 2008 16:39:36 -0700
Subject: [PATCH] n810-debian-config

---
 arch/arm/configs/n800_defconfig |  233 +++++++++++++++++++++++++++++----------
 1 files changed, 173 insertions(+), 60 deletions(-)

diff --git a/arch/arm/configs/n800_defconfig b/arch/arm/configs/n800_defconfig
index a8e133c..5d602c0 100644
--- a/arch/arm/configs/n800_defconfig
+++ b/arch/arm/configs/n800_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.25-rc8-omap1
-# Tue Apr  8 15:34:27 2008
+# Linux kernel version: 2.6.25-omap1
+# Mon Apr 28 10:50:37 2008
 #
 CONFIG_ARM=y
 CONFIG_SYS_SUPPORTS_APM_EMULATION=y
@@ -42,7 +42,7 @@ CONFIG_POSIX_MQUEUE=y
 # CONFIG_TASKSTATS is not set
 # CONFIG_AUDIT is not set
 # CONFIG_IKCONFIG is not set
-CONFIG_LOG_BUF_SHIFT=14
+CONFIG_LOG_BUF_SHIFT=18
 # CONFIG_CGROUPS is not set
 CONFIG_GROUP_SCHED=y
 CONFIG_FAIR_GROUP_SCHED=y
@@ -148,7 +148,7 @@ CONFIG_CLASSIC_RCU=y
 # CONFIG_ARCH_KS8695 is not set
 # CONFIG_ARCH_NS9XXX is not set
 # CONFIG_ARCH_MXC is not set
-# CONFIG_ARCH_ORION is not set
+# CONFIG_ARCH_ORION5X is not set
 # CONFIG_ARCH_PNX4008 is not set
 # CONFIG_ARCH_PXA is not set
 # CONFIG_ARCH_RPC is not set
@@ -172,13 +172,15 @@ CONFIG_ARCH_OMAP2=y
 # OMAP Feature Selections
 #
 CONFIG_OMAP_DEBUG_SRAM_PATCH=y
+# CONFIG_OMAP_DEBUG_POWERDOMAIN is not set
+# CONFIG_OMAP_DEBUG_CLOCKDOMAIN is not set
 CONFIG_OMAP_RESET_CLOCKS=y
 CONFIG_OMAP_BOOT_TAG=y
 CONFIG_OMAP_BOOT_REASON=y
 CONFIG_OMAP_COMPONENT_VERSION=y
 CONFIG_OMAP_GPIO_SWITCH=y
 # CONFIG_OMAP_MUX is not set
-# CONFIG_OMAP_MCBSP is not set
+CONFIG_OMAP_MCBSP=y
 CONFIG_OMAP_MMU_FWK=y
 CONFIG_OMAP_MBOX_FWK=y
 # CONFIG_OMAP_MPU_TIMER is not set
@@ -282,7 +284,7 @@ CONFIG_ALIGNMENT_TRAP=y
 CONFIG_ZBOOT_ROM_TEXT=0x10C08000
 CONFIG_ZBOOT_ROM_BSS=0x10200000
 # CONFIG_ZBOOT_ROM is not set
-CONFIG_CMDLINE="root=1f03 rootfstype=jffs2"
+CONFIG_CMDLINE="root=/dev/mmcblk1p2 console=tty0 rootdelay=2"
 # CONFIG_XIP_KERNEL is not set
 # CONFIG_KEXEC is not set
 
@@ -366,8 +368,6 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
 # CONFIG_TCP_MD5SIG is not set
 # CONFIG_IP_VS is not set
 # CONFIG_IPV6 is not set
-# CONFIG_INET6_XFRM_TUNNEL is not set
-# CONFIG_INET6_TUNNEL is not set
 # CONFIG_NETLABEL is not set
 # CONFIG_NETWORK_SECMARK is not set
 CONFIG_NETFILTER=y
@@ -473,7 +473,7 @@ CONFIG_BT_HIDP=y
 # CONFIG_BT_HCIBPA10X is not set
 # CONFIG_BT_HCIBFUSB is not set
 # CONFIG_BT_HCIBRF6150 is not set
-# CONFIG_BT_HCIH4P is not set
+CONFIG_BT_HCIH4P=y
 # CONFIG_BT_HCIVHCI is not set
 # CONFIG_AF_RXRPC is not set
 
@@ -657,6 +657,7 @@ CONFIG_NETDEV_10000=y
 #
 # CONFIG_WLAN_PRE80211 is not set
 # CONFIG_WLAN_80211 is not set
+# CONFIG_IWLWIFI_LEDS is not set
 
 #
 # USB Network Adapters
@@ -784,13 +785,6 @@ CONFIG_I2C_BOARDINFO=y
 # CONFIG_I2C_CHARDEV is not set
 
 #
-# I2C Algorithms
-#
-# CONFIG_I2C_ALGOBIT is not set
-# CONFIG_I2C_ALGOPCF is not set
-# CONFIG_I2C_ALGOPCA is not set
-
-#
 # I2C Hardware Bus support
 #
 # CONFIG_I2C_GPIO is not set
@@ -801,6 +795,7 @@ CONFIG_I2C_OMAP=y
 # CONFIG_I2C_TAOS_EVM is not set
 # CONFIG_I2C_STUB is not set
 # CONFIG_I2C_TINY_USB is not set
+# CONFIG_I2C_PCA_PLATFORM is not set
 
 #
 # Miscellaneous I2C Chip support
@@ -944,33 +939,51 @@ CONFIG_SSB_POSSIBLE=y
 #
 # CONFIG_MFD_SM501 is not set
 # CONFIG_MFD_ASIC3 is not set
+# CONFIG_HTC_EGPIO is not set
+# CONFIG_HTC_PASIC3 is not set
 
 #
 # Multimedia devices
 #
 CONFIG_VIDEO_DEV=y
 CONFIG_VIDEO_V4L2_COMMON=y
-# CONFIG_VIDEO_V4L1 is not set
-# CONFIG_VIDEO_V4L1_COMPAT is not set
+CONFIG_VIDEO_ALLOW_V4L1=y
+CONFIG_VIDEO_V4L1_COMPAT=y
 CONFIG_VIDEO_V4L2=y
+CONFIG_VIDEO_V4L1=y
 CONFIG_VIDEO_CAPTURE_DRIVERS=y
 # CONFIG_VIDEO_ADV_DEBUG is not set
 CONFIG_VIDEO_HELPER_CHIPS_AUTO=y
 CONFIG_VIDEO_TCM825X=y
 # CONFIG_VIDEO_VIVI is not set
+# CONFIG_VIDEO_CPIA is not set
+# CONFIG_VIDEO_CPIA2 is not set
 # CONFIG_VIDEO_SAA5246A is not set
 # CONFIG_VIDEO_SAA5249 is not set
+# CONFIG_TUNER_3036 is not set
+# CONFIG_VIDEO_AU0828 is not set
 # CONFIG_VIDEO_OMAP_CAMERA is not set
 CONFIG_VIDEO_OMAP2=y
 CONFIG_V4L_USB_DRIVERS=y
 # CONFIG_VIDEO_PVRUSB2 is not set
 # CONFIG_VIDEO_EM28XX is not set
 # CONFIG_VIDEO_USBVISION is not set
+# CONFIG_USB_VICAM is not set
+# CONFIG_USB_IBMCAM is not set
+# CONFIG_USB_KONICAWC is not set
+# CONFIG_USB_QUICKCAM_MESSENGER is not set
 # CONFIG_USB_ET61X251 is not set
+# CONFIG_VIDEO_OVCAMCHIP is not set
+# CONFIG_USB_W9968CF is not set
+# CONFIG_USB_OV511 is not set
+# CONFIG_USB_SE401 is not set
 # CONFIG_USB_SN9C102 is not set
+# CONFIG_USB_STV680 is not set
 # CONFIG_USB_ZC0301 is not set
+# CONFIG_USB_PWC is not set
 # CONFIG_USB_ZR364XX is not set
 # CONFIG_USB_STKWEBCAM is not set
+# CONFIG_SOC_CAMERA is not set
 CONFIG_RADIO_ADAPTERS=y
 CONFIG_RADIO_TEA5761=y
 # CONFIG_USB_DSBR is not set
@@ -1012,11 +1025,15 @@ CONFIG_FB_OMAP=y
 CONFIG_FB_OMAP_LCDC_EXTERNAL=y
 # CONFIG_FB_OMAP_LCDC_HWA742 is not set
 CONFIG_FB_OMAP_LCDC_BLIZZARD=y
-CONFIG_FB_OMAP_MANUAL_UPDATE=y
+# CONFIG_FB_OMAP_MANUAL_UPDATE is not set
 CONFIG_FB_OMAP_LCD_MIPID=y
 CONFIG_FB_OMAP_BOOTLOADER_INIT=y
 CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE=4
-# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
+CONFIG_BACKLIGHT_LCD_SUPPORT=y
+# CONFIG_LCD_CLASS_DEVICE is not set
+CONFIG_BACKLIGHT_CLASS_DEVICE=y
+# CONFIG_BACKLIGHT_CORGI is not set
+CONFIG_BACKLIGHT_OMAP=y
 
 #
 # Display device support
@@ -1028,8 +1045,24 @@ CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE=4
 #
 # CONFIG_VGA_CONSOLE is not set
 CONFIG_DUMMY_CONSOLE=y
-# CONFIG_FRAMEBUFFER_CONSOLE is not set
-# CONFIG_LOGO is not set
+CONFIG_FRAMEBUFFER_CONSOLE=y
+# CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY is not set
+CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
+CONFIG_FONTS=y
+# CONFIG_FONT_8x8 is not set
+CONFIG_FONT_8x16=y
+# CONFIG_FONT_6x11 is not set
+# CONFIG_FONT_7x14 is not set
+# CONFIG_FONT_PEARL_8x8 is not set
+# CONFIG_FONT_ACORN_8x8 is not set
+# CONFIG_FONT_MINI_4x6 is not set
+# CONFIG_FONT_SUN8x16 is not set
+# CONFIG_FONT_SUN12x22 is not set
+# CONFIG_FONT_10x18 is not set
+CONFIG_LOGO=y
+CONFIG_LOGO_LINUX_MONO=y
+CONFIG_LOGO_LINUX_VGA16=y
+CONFIG_LOGO_LINUX_CLUT224=y
 
 #
 # Sound
@@ -1040,6 +1073,8 @@ CONFIG_SOUND=y
 # Advanced Linux Sound Architecture
 #
 CONFIG_SND=y
+CONFIG_SND_TIMER=y
+CONFIG_SND_PCM=y
 # CONFIG_SND_SEQUENCER is not set
 CONFIG_SND_OSSEMUL=y
 CONFIG_SND_MIXER_OSS=y
@@ -1065,7 +1100,7 @@ CONFIG_SND_SUPPORT_OLD_API=y
 # CONFIG_SND_OMAP_TSC2101 is not set
 # CONFIG_SND_SX1 is not set
 # CONFIG_SND_OMAP_TSC2102 is not set
-CONFIG_SND_OMAP24XX_EAC=y
+# CONFIG_SND_OMAP24XX_EAC is not set
 
 #
 # SPI devices
@@ -1080,15 +1115,19 @@ CONFIG_SND_OMAP24XX_EAC=y
 #
 # System on Chip audio support
 #
-# CONFIG_SND_SOC is not set
+CONFIG_SND_SOC=y
 
 #
-# SoC Audio support for SuperH
+# ALSA SoC audio for Freescale SOCs
 #
 
 #
-# ALSA SoC audio for Freescale SOCs
+# SoC Audio for the Texas Instruments OMAP
 #
+CONFIG_SND_OMAP_SOC=y
+CONFIG_SND_OMAP_SOC_MCBSP=y
+CONFIG_SND_OMAP_SOC_N810=y
+CONFIG_SND_SOC_TLV320AIC3X=y
 
 #
 # Open Sound System
@@ -1183,7 +1222,49 @@ CONFIG_USB_MON=y
 #
 # USB port drivers
 #
-# CONFIG_USB_SERIAL is not set
+CONFIG_USB_SERIAL=y
+# CONFIG_USB_SERIAL_CONSOLE is not set
+# CONFIG_USB_EZUSB is not set
+# CONFIG_USB_SERIAL_GENERIC is not set
+# CONFIG_USB_SERIAL_AIRCABLE is not set
+# CONFIG_USB_SERIAL_AIRPRIME is not set
+# CONFIG_USB_SERIAL_ARK3116 is not set
+# CONFIG_USB_SERIAL_BELKIN is not set
+# CONFIG_USB_SERIAL_CH341 is not set
+# CONFIG_USB_SERIAL_WHITEHEAT is not set
+# CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
+# CONFIG_USB_SERIAL_CP2101 is not set
+# CONFIG_USB_SERIAL_CYPRESS_M8 is not set
+# CONFIG_USB_SERIAL_EMPEG is not set
+CONFIG_USB_SERIAL_FTDI_SIO=y
+# CONFIG_USB_SERIAL_FUNSOFT is not set
+# CONFIG_USB_SERIAL_VISOR is not set
+# CONFIG_USB_SERIAL_IPAQ is not set
+# CONFIG_USB_SERIAL_IR is not set
+# CONFIG_USB_SERIAL_EDGEPORT is not set
+# CONFIG_USB_SERIAL_EDGEPORT_TI is not set
+# CONFIG_USB_SERIAL_GARMIN is not set
+# CONFIG_USB_SERIAL_IPW is not set
+# CONFIG_USB_SERIAL_IUU is not set
+# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
+# CONFIG_USB_SERIAL_KEYSPAN is not set
+# CONFIG_USB_SERIAL_KLSI is not set
+# CONFIG_USB_SERIAL_KOBIL_SCT is not set
+# CONFIG_USB_SERIAL_MCT_U232 is not set
+# CONFIG_USB_SERIAL_MOS7720 is not set
+# CONFIG_USB_SERIAL_MOS7840 is not set
+# CONFIG_USB_SERIAL_NAVMAN is not set
+CONFIG_USB_SERIAL_PL2303=y
+# CONFIG_USB_SERIAL_OTI6858 is not set
+# CONFIG_USB_SERIAL_HP4X is not set
+# CONFIG_USB_SERIAL_SAFE is not set
+# CONFIG_USB_SERIAL_SIERRAWIRELESS is not set
+# CONFIG_USB_SERIAL_TI is not set
+# CONFIG_USB_SERIAL_CYBERJACK is not set
+# CONFIG_USB_SERIAL_XIRCOM is not set
+# CONFIG_USB_SERIAL_OPTION is not set
+# CONFIG_USB_SERIAL_OMNINET is not set
+# CONFIG_USB_SERIAL_DEBUG is not set
 
 #
 # USB Miscellaneous drivers
@@ -1210,6 +1291,7 @@ CONFIG_USB_TEST=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_DEBUG=y
 CONFIG_USB_GADGET_DEBUG_FILES=y
+CONFIG_USB_GADGET_DEBUG_FS=y
 CONFIG_USB_GADGET_SELECTED=y
 # CONFIG_USB_GADGET_AMD5536UDC is not set
 # CONFIG_USB_GADGET_ATMEL_USBA is not set
@@ -1267,6 +1349,7 @@ CONFIG_LEDS_TRIGGER_TIMER=y
 CONFIG_LEDS_TRIGGER_HEARTBEAT=y
 CONFIG_RTC_LIB=y
 # CONFIG_RTC_CLASS is not set
+# CONFIG_UIO is not set
 
 #
 # CBUS support
@@ -1288,23 +1371,23 @@ CONFIG_OMAP_DSP_FBEXPORT=y
 #
 # File systems
 #
-CONFIG_EXT2_FS=m
+CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 # CONFIG_EXT2_FS_POSIX_ACL is not set
 # CONFIG_EXT2_FS_SECURITY is not set
 # CONFIG_EXT2_FS_XIP is not set
-CONFIG_EXT3_FS=m
+CONFIG_EXT3_FS=y
 CONFIG_EXT3_FS_XATTR=y
 # CONFIG_EXT3_FS_POSIX_ACL is not set
 # CONFIG_EXT3_FS_SECURITY is not set
 # CONFIG_EXT4DEV_FS is not set
-CONFIG_JBD=m
-CONFIG_FS_MBCACHE=m
+CONFIG_JBD=y
+# CONFIG_JBD_DEBUG is not set
+CONFIG_FS_MBCACHE=y
 # CONFIG_REISERFS_FS is not set
 # CONFIG_JFS_FS is not set
 # CONFIG_FS_POSIX_ACL is not set
 # CONFIG_XFS_FS is not set
-# CONFIG_GFS2_FS is not set
 # CONFIG_OCFS2_FS is not set
 CONFIG_DNOTIFY=y
 CONFIG_INOTIFY=y
@@ -1438,7 +1521,7 @@ CONFIG_ENABLE_WARN_DEPRECATED=y
 CONFIG_ENABLE_MUST_CHECK=y
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_UNUSED_SYMBOLS is not set
-# CONFIG_DEBUG_FS is not set
+CONFIG_DEBUG_FS=y
 # CONFIG_HEADERS_CHECK is not set
 CONFIG_DEBUG_KERNEL=y
 # CONFIG_DEBUG_SHIRQ is not set
@@ -1460,6 +1543,7 @@ CONFIG_SCHED_DEBUG=y
 CONFIG_DEBUG_BUGVERBOSE=y
 # CONFIG_DEBUG_INFO is not set
 # CONFIG_DEBUG_VM is not set
+# CONFIG_DEBUG_WRITECOUNT is not set
 # CONFIG_DEBUG_LIST is not set
 # CONFIG_DEBUG_SG is not set
 CONFIG_FRAME_POINTER=y
@@ -1484,48 +1568,77 @@ CONFIG_SECURITY=y
 # CONFIG_SECURITY_LOWMEM is not set
 CONFIG_SECURITY_DEFAULT_MMAP_MIN_ADDR=0
 CONFIG_CRYPTO=y
-# CONFIG_CRYPTO_SEQIV is not set
+
+#
+# Crypto core or helper
+#
 # CONFIG_CRYPTO_MANAGER is not set
+# CONFIG_CRYPTO_GF128MUL is not set
+# CONFIG_CRYPTO_NULL is not set
+# CONFIG_CRYPTO_CRYPTD is not set
+# CONFIG_CRYPTO_AUTHENC is not set
+# CONFIG_CRYPTO_TEST is not set
+
+#
+# Authenticated Encryption with Associated Data
+#
+# CONFIG_CRYPTO_CCM is not set
+# CONFIG_CRYPTO_GCM is not set
+# CONFIG_CRYPTO_SEQIV is not set
+
+#
+# Block modes
+#
+# CONFIG_CRYPTO_CBC is not set
+# CONFIG_CRYPTO_CTR is not set
+# CONFIG_CRYPTO_CTS is not set
+# CONFIG_CRYPTO_ECB is not set
+# CONFIG_CRYPTO_LRW is not set
+# CONFIG_CRYPTO_PCBC is not set
+# CONFIG_CRYPTO_XTS is not set
+
+#
+# Hash modes
+#
 # CONFIG_CRYPTO_HMAC is not set
 # CONFIG_CRYPTO_XCBC is not set
-# CONFIG_CRYPTO_NULL is not set
+
+#
+# Digest
+#
+# CONFIG_CRYPTO_CRC32C is not set
 # CONFIG_CRYPTO_MD4 is not set
 # CONFIG_CRYPTO_MD5 is not set
+# CONFIG_CRYPTO_MICHAEL_MIC is not set
 # CONFIG_CRYPTO_SHA1 is not set
 # CONFIG_CRYPTO_SHA256 is not set
 # CONFIG_CRYPTO_SHA512 is not set
-# CONFIG_CRYPTO_WP512 is not set
 # CONFIG_CRYPTO_TGR192 is not set
-# CONFIG_CRYPTO_GF128MUL is not set
-# CONFIG_CRYPTO_ECB is not set
-# CONFIG_CRYPTO_CBC is not set
-# CONFIG_CRYPTO_PCBC is not set
-# CONFIG_CRYPTO_LRW is not set
-# CONFIG_CRYPTO_XTS is not set
-# CONFIG_CRYPTO_CTR is not set
-# CONFIG_CRYPTO_GCM is not set
-# CONFIG_CRYPTO_CCM is not set
-# CONFIG_CRYPTO_CRYPTD is not set
-# CONFIG_CRYPTO_DES is not set
-# CONFIG_CRYPTO_FCRYPT is not set
-# CONFIG_CRYPTO_BLOWFISH is not set
-# CONFIG_CRYPTO_TWOFISH is not set
-# CONFIG_CRYPTO_SERPENT is not set
+# CONFIG_CRYPTO_WP512 is not set
+
+#
+# Ciphers
+#
 # CONFIG_CRYPTO_AES is not set
+# CONFIG_CRYPTO_ANUBIS is not set
+# CONFIG_CRYPTO_ARC4 is not set
+# CONFIG_CRYPTO_BLOWFISH is not set
+# CONFIG_CRYPTO_CAMELLIA is not set
 # CONFIG_CRYPTO_CAST5 is not set
 # CONFIG_CRYPTO_CAST6 is not set
-# CONFIG_CRYPTO_TEA is not set
-# CONFIG_CRYPTO_ARC4 is not set
+# CONFIG_CRYPTO_DES is not set
+# CONFIG_CRYPTO_FCRYPT is not set
 # CONFIG_CRYPTO_KHAZAD is not set
-# CONFIG_CRYPTO_ANUBIS is not set
-# CONFIG_CRYPTO_SEED is not set
 # CONFIG_CRYPTO_SALSA20 is not set
+# CONFIG_CRYPTO_SEED is not set
+# CONFIG_CRYPTO_SERPENT is not set
+# CONFIG_CRYPTO_TEA is not set
+# CONFIG_CRYPTO_TWOFISH is not set
+
+#
+# Compression
+#
 # CONFIG_CRYPTO_DEFLATE is not set
-# CONFIG_CRYPTO_MICHAEL_MIC is not set
-# CONFIG_CRYPTO_CRC32C is not set
-# CONFIG_CRYPTO_CAMELLIA is not set
-# CONFIG_CRYPTO_TEST is not set
-# CONFIG_CRYPTO_AUTHENC is not set
 # CONFIG_CRYPTO_LZO is not set
 CONFIG_CRYPTO_HW=y
 
-- 
1.5.3.6


--nVMJ2NtxeReIH9PS--
