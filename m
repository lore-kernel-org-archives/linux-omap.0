From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCHv5 03/10] HSI: export method to (un)register clients
Date: Sat, 10 May 2014 18:37:43 +0200
Message-ID: <1399739870-13526-4-git-send-email-sre@kernel.org>
References: <1399739870-13526-1-git-send-email-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1399739870-13526-1-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Shubhrajyoti Datta <omaplinuxkernel@gmail.com>, Carlos Chinea <cch.devel@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, =?UTF-8?q?=D0=98=D0=B2=D0=B0=D0=B9=D0=BB=D0=BE=20=D0=94=D0=B8=D0=BC=D0=B8=D1=82=D1=80=D0=BE=D0=B2?= <freemangordon@abv.bg>, Joni Lapilainen <joni.lapilainen@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-omap@vger.kernel.org

Expose method for registering and unregistering HSI clients, so that
client drivers can register other client drivers.

This is useful for HSI drivers, which want to use the functionality
of other HSI drivers. For example the N900 modem driver can load HSI
drivers for mcsaab protocol and speech protocol.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
Reviewed-by: Pavel Machek <pavel@ucw.cz>
Tested-By: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
---
 drivers/hsi/hsi.c       | 11 ++++++++---
 include/linux/hsi/hsi.h |  3 +++
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/hsi/hsi.c b/drivers/hsi/hsi.c
index de2ad8f..834a2d6 100644
--- a/drivers/hsi/hsi.c
+++ b/drivers/hsi/hsi.c
@@ -69,14 +69,15 @@ static void hsi_client_release(struct device *dev)
 	kfree(cl);
 }
 
-static void hsi_new_client(struct hsi_port *port, struct hsi_board_info *info)
+struct hsi_client *hsi_new_client(struct hsi_port *port,
+						struct hsi_board_info *info)
 {
 	struct hsi_client *cl;
 	size_t size;
 
 	cl = kzalloc(sizeof(*cl), GFP_KERNEL);
 	if (!cl)
-		return;
+		return NULL;
 
 	cl->tx_cfg = info->tx_cfg;
 	if (cl->tx_cfg.channels) {
@@ -103,7 +104,10 @@ static void hsi_new_client(struct hsi_port *port, struct hsi_board_info *info)
 		pr_err("hsi: failed to register client: %s\n", info->name);
 		put_device(&cl->device);
 	}
+
+	return cl;
 }
+EXPORT_SYMBOL_GPL(hsi_new_client);
 
 static void hsi_scan_board_info(struct hsi_controller *hsi)
 {
@@ -119,12 +123,13 @@ static void hsi_scan_board_info(struct hsi_controller *hsi)
 		}
 }
 
-static int hsi_remove_client(struct device *dev, void *data __maybe_unused)
+int hsi_remove_client(struct device *dev, void *data __maybe_unused)
 {
 	device_unregister(dev);
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(hsi_remove_client);
 
 static int hsi_remove_port(struct device *dev, void *data __maybe_unused)
 {
diff --git a/include/linux/hsi/hsi.h b/include/linux/hsi/hsi.h
index e3cff94..e20a399 100644
--- a/include/linux/hsi/hsi.h
+++ b/include/linux/hsi/hsi.h
@@ -296,6 +296,9 @@ struct hsi_controller *hsi_alloc_controller(unsigned int n_ports, gfp_t flags);
 void hsi_put_controller(struct hsi_controller *hsi);
 int hsi_register_controller(struct hsi_controller *hsi);
 void hsi_unregister_controller(struct hsi_controller *hsi);
+struct hsi_client *hsi_new_client(struct hsi_port *port,
+						struct hsi_board_info *info);
+int hsi_remove_client(struct device *dev, void *data);
 void hsi_port_unregister_clients(struct hsi_port *port);
 
 static inline void hsi_controller_set_drvdata(struct hsi_controller *hsi,
-- 
2.0.0.rc0
