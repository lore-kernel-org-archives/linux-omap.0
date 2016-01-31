From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 2/5] HSI: nokia-modem: kernel based PM
Date: Sun, 31 Jan 2016 02:19:44 +0100
Message-ID: <1454203187-688-3-git-send-email-sre@kernel.org>
References: <1454203187-688-1-git-send-email-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1454203187-688-1-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Pavel Machek <pavel@ucw.cz>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

So far power management had to be done in uerspace using exported GPIOs.
This patch adds kernel based power management, which will bind the
modem's power state to the state of the phonet network interface.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/hsi/clients/nokia-modem.c  | 116 +++++++++++++++++++++++++++++++++++--
 drivers/hsi/clients/ssi_protocol.c |  21 +++++++
 include/linux/hsi/ssi_protocol.h   |   9 +++
 3 files changed, 141 insertions(+), 5 deletions(-)

diff --git a/drivers/hsi/clients/nokia-modem.c b/drivers/hsi/clients/nokia-modem.c
index f20ede611593..6485f4c61092 100644
--- a/drivers/hsi/clients/nokia-modem.c
+++ b/drivers/hsi/clients/nokia-modem.c
@@ -28,11 +28,12 @@
 #include <linux/of_irq.h>
 #include <linux/of_gpio.h>
 #include <linux/hsi/ssi_protocol.h>
+#include <linux/delay.h>
 
 static unsigned int pm = 1;
 module_param(pm, int, 0400);
 MODULE_PARM_DESC(pm,
-	"Enable power management (0=disabled, 1=userland based [default])");
+	"Enable power management (0=disabled, 1=userland based [default], 2=kernel based)");
 
 enum nokia_modem_type {
 	RAPUYAMA_V1,
@@ -51,6 +52,7 @@ struct nokia_modem_device {
 	struct gpio_desc	*gpio_cmt_rst_rq;
 	struct gpio_desc	*gpio_cmt_rst;
 	struct gpio_desc	*gpio_cmt_bsi;
+	struct notifier_block	nb;
 };
 
 static void do_nokia_modem_rst_ind_tasklet(unsigned long data)
@@ -75,6 +77,93 @@ static irqreturn_t nokia_modem_rst_ind_isr(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+static void nokia_modem_power_boot(struct nokia_modem_device *modem)
+{
+	/* skip flash mode */
+	gpiod_set_value(modem->gpio_cmt_apeslpx, 0);
+	/* prevent current drain */
+	gpiod_set_value(modem->gpio_cmt_rst_rq, 0);
+
+	if (modem->type == RAPUYAMA_V1) {
+		gpiod_set_value(modem->gpio_cmt_en, 0);
+		/* toggle BSI visible to modem */
+		gpiod_set_value(modem->gpio_cmt_bsi, 0);
+		/* Assert PURX */
+		gpiod_set_value(modem->gpio_cmt_rst, 0);
+		/* Press "power key" */
+		gpiod_set_value(modem->gpio_cmt_en, 1);
+		/* Release CMT to boot */
+		gpiod_set_value(modem->gpio_cmt_rst, 1);
+	} else if(modem->type == RAPUYAMA_V2) {
+		gpiod_set_value(modem->gpio_cmt_en, 0);
+		/* 15 ms needed for ASIC poweroff */
+		usleep_range(15000, 25000);
+		gpiod_set_value(modem->gpio_cmt_en, 1);
+	}
+
+	gpiod_set_value(modem->gpio_cmt_rst_rq, 1);
+}
+
+static void nokia_modem_power_on(struct nokia_modem_device *modem)
+{
+	gpiod_set_value(modem->gpio_cmt_rst_rq, 0);
+
+	if (modem->type == RAPUYAMA_V1) {
+		/* release "power key" */
+		gpiod_set_value(modem->gpio_cmt_en, 0);
+	}
+}
+
+static void nokia_modem_power_off(struct nokia_modem_device *modem)
+{
+	/* skip flash mode */
+	gpiod_set_value(modem->gpio_cmt_apeslpx, 0);
+	/* prevent current drain */
+	gpiod_set_value(modem->gpio_cmt_rst_rq, 0);
+
+	if (modem->type == RAPUYAMA_V1) {
+		/* release "power key" */
+		gpiod_set_value(modem->gpio_cmt_en, 0);
+		/* force modem to reset state */
+		gpiod_set_value(modem->gpio_cmt_rst, 0);
+		/* release modem to be powered off by bootloader */
+		gpiod_set_value(modem->gpio_cmt_rst, 1);
+	} else if(modem->type == RAPUYAMA_V2) {
+		/* power off */
+		gpiod_set_value(modem->gpio_cmt_en, 0);
+	}
+}
+
+static int ssi_protocol_event(struct notifier_block *nb, unsigned long event,
+			      void *data __maybe_unused)
+{
+	struct nokia_modem_device *modem =
+		container_of(nb, struct nokia_modem_device, nb);
+
+	switch(event) {
+		/* called on interface up */
+		case STATE_BOOT:
+			dev_info(modem->device, "modem power state: boot");
+			nokia_modem_power_boot(modem);
+			break;
+		/* called on link up */
+		case STATE_ON:
+			dev_info(modem->device, "modem power state: enabled");
+			nokia_modem_power_on(modem);
+			break;
+		/* called on interface down */
+		case STATE_OFF:
+			dev_info(modem->device, "modem power state: disabled");
+			nokia_modem_power_off(modem);
+			break;
+		default:
+			dev_warn(modem->device, "unknown ssi-protocol event");
+			break;
+	}
+
+	return NOTIFY_DONE;
+}
+
 static void nokia_modem_gpio_unexport(struct device *dev)
 {
 	struct nokia_modem_device *modem = dev_get_drvdata(dev);
@@ -218,6 +307,9 @@ static int nokia_modem_probe(struct device *dev)
 		modem->type = RAPUYAMA_V2;
 	}
 
+	modem->nb.notifier_call = ssi_protocol_event;
+	modem->nb.priority = INT_MAX;
+
 	irq = irq_of_parse_and_map(np, 0);
 	if (!irq) {
 		dev_err(dev, "Invalid rst_ind interrupt (%d)\n", irq);
@@ -268,6 +360,14 @@ static int nokia_modem_probe(struct device *dev)
 		goto error3;
 	}
 
+	if (pm == 2) {
+		err = ssip_notifier_register(modem->ssi_protocol, &modem->nb);
+		if (err < 0) {
+			dev_err(dev, "Could not register ssi-protocol notifier!");
+			goto error3;
+		}
+	}
+
 	cmtspeech.name = "cmt-speech";
 	cmtspeech.tx_cfg = cl->tx_cfg;
 	cmtspeech.rx_cfg = cl->rx_cfg;
@@ -278,25 +378,28 @@ static int nokia_modem_probe(struct device *dev)
 	if (!modem->cmt_speech) {
 		dev_err(dev, "Could not register cmt-speech device\n");
 		err = -ENOMEM;
-		goto error3;
+		goto error4;
 	}
 
 	err = device_attach(&modem->cmt_speech->device);
 	if (err == 0) {
 		dev_dbg(dev, "Missing cmt-speech driver\n");
 		err = -EPROBE_DEFER;
-		goto error4;
+		goto error5;
 	} else if (err < 0) {
 		dev_err(dev, "Could not load cmt-speech driver (%d)\n", err);
-		goto error4;
+		goto error5;
 	}
 
 	dev_info(dev, "Registered Nokia HSI modem\n");
 
 	return 0;
 
-error4:
+error5:
 	hsi_remove_client(&modem->cmt_speech->device, NULL);
+error4:
+	if (pm == 2)
+		ssip_notifier_unregister(modem->ssi_protocol, &modem->nb);
 error3:
 	hsi_remove_client(&modem->ssi_protocol->device, NULL);
 error2:
@@ -320,6 +423,9 @@ static int nokia_modem_remove(struct device *dev)
 		modem->cmt_speech = NULL;
 	}
 
+	if (pm == 2)
+		ssip_notifier_unregister(modem->ssi_protocol, &modem->nb);
+
 	if (modem->ssi_protocol) {
 		hsi_remove_client(&modem->ssi_protocol->device, NULL);
 		modem->ssi_protocol = NULL;
diff --git a/drivers/hsi/clients/ssi_protocol.c b/drivers/hsi/clients/ssi_protocol.c
index 6595d2091268..cee33cab889e 100644
--- a/drivers/hsi/clients/ssi_protocol.c
+++ b/drivers/hsi/clients/ssi_protocol.c
@@ -153,6 +153,7 @@ struct ssi_protocol {
 	atomic_t		tx_usecnt;
 	int			channel_id_cmd;
 	int			channel_id_data;
+	struct blocking_notifier_head	modem_state_notifier;
 };
 
 /* List of ssi protocol instances */
@@ -735,6 +736,7 @@ static void ssip_rx_waketest(struct hsi_client *cl, u32 cmd)
 	dev_dbg(&cl->device, "CMT is ONLINE\n");
 	netif_wake_queue(ssi->netdev);
 	netif_carrier_on(ssi->netdev);
+	blocking_notifier_call_chain(&ssi->modem_state_notifier, STATE_ON, NULL);
 }
 
 static void ssip_rx_ready(struct hsi_client *cl)
@@ -924,6 +926,7 @@ static int ssip_pn_open(struct net_device *dev)
 			err);
 		return err;
 	}
+	blocking_notifier_call_chain(&ssi->modem_state_notifier, STATE_BOOT, NULL);
 	dev_dbg(&cl->device, "Configuring SSI port\n");
 	hsi_setup(cl);
 	spin_lock_bh(&ssi->lock);
@@ -942,11 +945,14 @@ static int ssip_pn_open(struct net_device *dev)
 static int ssip_pn_stop(struct net_device *dev)
 {
 	struct hsi_client *cl = to_hsi_client(dev->dev.parent);
+	struct ssi_protocol *ssi = hsi_client_drvdata(cl);
 
 	ssip_reset(cl);
 	hsi_unregister_port_event(cl);
 	hsi_release_port(cl);
 
+	blocking_notifier_call_chain(&ssi->modem_state_notifier, STATE_OFF, NULL);
+
 	return 0;
 }
 
@@ -1037,6 +1043,20 @@ void ssip_reset_event(struct hsi_client *master)
 }
 EXPORT_SYMBOL_GPL(ssip_reset_event);
 
+int ssip_notifier_register(struct hsi_client *master, struct notifier_block *nb)
+{
+	struct ssi_protocol *ssi = hsi_client_drvdata(master);
+	return blocking_notifier_chain_register(&ssi->modem_state_notifier, nb);
+}
+EXPORT_SYMBOL_GPL(ssip_notifier_register);
+
+int ssip_notifier_unregister(struct hsi_client *master, struct notifier_block *nb)
+{
+	struct ssi_protocol *ssi = hsi_client_drvdata(master);
+	return blocking_notifier_chain_unregister(&ssi->modem_state_notifier, nb);
+}
+EXPORT_SYMBOL_GPL(ssip_notifier_unregister);
+
 static const struct net_device_ops ssip_pn_ops = {
 	.ndo_open	= ssip_pn_open,
 	.ndo_stop	= ssip_pn_stop,
@@ -1085,6 +1105,7 @@ static int ssi_protocol_probe(struct device *dev)
 	ssi->keep_alive.function = ssip_keep_alive;
 	INIT_LIST_HEAD(&ssi->txqueue);
 	INIT_LIST_HEAD(&ssi->cmdqueue);
+	BLOCKING_INIT_NOTIFIER_HEAD(&ssi->modem_state_notifier);
 	atomic_set(&ssi->tx_usecnt, 0);
 	hsi_client_set_drvdata(cl, ssi);
 	ssi->cl = cl;
diff --git a/include/linux/hsi/ssi_protocol.h b/include/linux/hsi/ssi_protocol.h
index 1433651be0dc..6b742e9368a7 100644
--- a/include/linux/hsi/ssi_protocol.h
+++ b/include/linux/hsi/ssi_protocol.h
@@ -27,6 +27,12 @@
 
 #include <linux/hsi/hsi.h>
 
+enum nokia_modem_state {
+	STATE_BOOT,
+	STATE_ON,
+	STATE_OFF,
+};
+
 static inline void ssip_slave_put_master(struct hsi_client *master)
 {
 }
@@ -36,6 +42,9 @@ int ssip_slave_start_tx(struct hsi_client *master);
 int ssip_slave_stop_tx(struct hsi_client *master);
 void ssip_reset_event(struct hsi_client *master);
 
+int ssip_notifier_register(struct hsi_client *master, struct notifier_block *nb);
+int ssip_notifier_unregister(struct hsi_client *master, struct notifier_block *nb);
+
 int ssip_slave_running(struct hsi_client *master);
 
 #endif /* __LINUX_SSIP_SLAVE_H__ */
-- 
2.7.0.rc3
