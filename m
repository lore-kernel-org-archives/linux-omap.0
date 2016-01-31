From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 3/5] HSI: ssi-protocol: export modem info via sysfs
Date: Sun, 31 Jan 2016 02:19:45 +0100
Message-ID: <1454203187-688-4-git-send-email-sre@kernel.org>
References: <1454203187-688-1-git-send-email-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1454203187-688-1-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Pavel Machek <pavel@ucw.cz>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Currently userspace knows about the rapuyama version by
checking, which gpios have been exported. This does no
longer work with kernel based power management, so export
a sysfs file, which provides the rapuyama generation. Also
export a link to the nokia-modem, so that userspace can
easily check if kernel based PM is used.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/hsi/clients/nokia-modem.c  | 10 ++++------
 drivers/hsi/clients/ssi_protocol.c | 33 ++++++++++++++++++++++++++++++++-
 include/linux/hsi/ssi_protocol.h   | 11 +++++++++++
 3 files changed, 47 insertions(+), 7 deletions(-)

diff --git a/drivers/hsi/clients/nokia-modem.c b/drivers/hsi/clients/nokia-modem.c
index 6485f4c61092..1b4a250cf113 100644
--- a/drivers/hsi/clients/nokia-modem.c
+++ b/drivers/hsi/clients/nokia-modem.c
@@ -35,11 +35,6 @@ module_param(pm, int, 0400);
 MODULE_PARM_DESC(pm,
 	"Enable power management (0=disabled, 1=userland based [default], 2=kernel based)");
 
-enum nokia_modem_type {
-	RAPUYAMA_V1,
-	RAPUYAMA_V2,
-};
-
 struct nokia_modem_device {
 	struct tasklet_struct	nokia_modem_rst_ind_tasklet;
 	int			nokia_modem_rst_ind_irq;
@@ -285,6 +280,7 @@ static int nokia_modem_probe(struct device *dev)
 	struct hsi_port *port = hsi_get_port(cl);
 	int irq, pflags, err;
 	struct hsi_board_info ssip;
+	struct ssi_protocol_platform_data ssip_pdata;
 	struct hsi_board_info cmtspeech;
 
 	np = dev->of_node;
@@ -340,7 +336,9 @@ static int nokia_modem_probe(struct device *dev)
 	ssip.name = "ssi-protocol";
 	ssip.tx_cfg = cl->tx_cfg;
 	ssip.rx_cfg = cl->rx_cfg;
-	ssip.platform_data = NULL;
+	ssip_pdata.type = modem->type;
+	ssip_pdata.nokia_modem_dev = dev;
+	ssip.platform_data = &ssip_pdata;
 	ssip.archdata = NULL;
 
 	modem->ssi_protocol = hsi_new_client(port, &ssip);
diff --git a/drivers/hsi/clients/ssi_protocol.c b/drivers/hsi/clients/ssi_protocol.c
index cee33cab889e..3fb5b98b2c63 100644
--- a/drivers/hsi/clients/ssi_protocol.c
+++ b/drivers/hsi/clients/ssi_protocol.c
@@ -154,6 +154,7 @@ struct ssi_protocol {
 	int			channel_id_cmd;
 	int			channel_id_data;
 	struct blocking_notifier_head	modem_state_notifier;
+	enum nokia_modem_type	modem_type;
 };
 
 /* List of ssi protocol instances */
@@ -1080,10 +1081,20 @@ static void ssip_pn_setup(struct net_device *dev)
 	dev->header_ops		= &phonet_header_ops;
 }
 
+static ssize_t show_rapuyama_version(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct hsi_client *cl = to_hsi_client(dev);
+	struct ssi_protocol *ssi = hsi_client_drvdata(cl);
+
+	return sprintf(buf, "%d", ssi->modem_type);
+}
+static DEVICE_ATTR(rapuyama_version, S_IRUGO, show_rapuyama_version, 0);
+
 static int ssi_protocol_probe(struct device *dev)
 {
 	static const char ifname[] = "phonet%d";
 	struct hsi_client *cl = to_hsi_client(dev);
+	struct ssi_protocol_platform_data *pdata = dev_get_platdata(dev);
 	struct ssi_protocol *ssi;
 	int err;
 
@@ -1093,6 +1104,8 @@ static int ssi_protocol_probe(struct device *dev)
 		return -ENOMEM;
 	}
 
+	ssi->modem_type = pdata->type;
+
 	spin_lock_init(&ssi->lock);
 	init_timer_deferrable(&ssi->rx_wd);
 	init_timer_deferrable(&ssi->tx_wd);
@@ -1137,12 +1150,24 @@ static int ssi_protocol_probe(struct device *dev)
 		goto out1;
 	}
 
+	err = device_create_file(dev, &dev_attr_rapuyama_version);
+	if (err < 0) {
+		dev_err(dev, "Could not create sysfs file for rapuyama version");
+		goto out2;
+	}
+
+	err = sysfs_create_link(&dev->kobj, &pdata->nokia_modem_dev->kobj, "nokia-modem");
+	if (err < 0) {
+		dev_err(dev, "Could not create sysfs symlink to nokia-modem");
+		goto out3;
+	}
+
 	SET_NETDEV_DEV(ssi->netdev, dev);
 	netif_carrier_off(ssi->netdev);
 	err = register_netdev(ssi->netdev);
 	if (err < 0) {
 		dev_err(dev, "Register netdev failed (%d)\n", err);
-		goto out2;
+		goto out4;
 	}
 
 	list_add(&ssi->link, &ssip_list);
@@ -1151,6 +1176,10 @@ static int ssi_protocol_probe(struct device *dev)
 		ssi->channel_id_cmd, ssi->channel_id_data);
 
 	return 0;
+out4:
+	sysfs_remove_link(&dev->kobj, "nokia-modem");
+out3:
+	device_remove_file(dev, &dev_attr_rapuyama_version);
 out2:
 	free_netdev(ssi->netdev);
 out1:
@@ -1167,6 +1196,8 @@ static int ssi_protocol_remove(struct device *dev)
 	struct ssi_protocol *ssi = hsi_client_drvdata(cl);
 
 	list_del(&ssi->link);
+	sysfs_remove_link(&dev->kobj, "nokia-modem");
+	device_remove_file(dev, &dev_attr_rapuyama_version);
 	unregister_netdev(ssi->netdev);
 	ssip_free_cmds(ssi);
 	hsi_client_set_drvdata(cl, NULL);
diff --git a/include/linux/hsi/ssi_protocol.h b/include/linux/hsi/ssi_protocol.h
index 6b742e9368a7..ba069812341b 100644
--- a/include/linux/hsi/ssi_protocol.h
+++ b/include/linux/hsi/ssi_protocol.h
@@ -33,6 +33,17 @@ enum nokia_modem_state {
 	STATE_OFF,
 };
 
+enum nokia_modem_type {
+	UNKNOWN = 0,
+	RAPUYAMA_V1,
+	RAPUYAMA_V2,
+};
+
+struct ssi_protocol_platform_data {
+	enum nokia_modem_type type;
+	struct device *nokia_modem_dev;
+};
+
 static inline void ssip_slave_put_master(struct hsi_client *master)
 {
 }
-- 
2.7.0.rc3
