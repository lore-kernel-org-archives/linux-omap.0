From: Sebastian Reichel <sre@debian.org>
Subject: [PATCHv2 2/6] HSI: Add function to register HSI clients from DT
Date: Sun,  9 Mar 2014 23:25:52 +0100
Message-ID: <1394403956-17297-3-git-send-email-sre@debian.org>
References: <1393199401-27197-1-git-send-email-sre@debian.org>
 <1394403956-17297-1-git-send-email-sre@debian.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1394403956-17297-1-git-send-email-sre@debian.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@ring0.de>, Linus Walleij <linus.walleij@linaro.org>, Shubhrajyoti Datta <omaplinuxkernel@gmail.com>, Carlos Chinea <cch.devel@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, =?UTF-8?q?=D0=98=D0=B2=D0=B0=D0=B9=D0=BB=D0=BE=20=D0=94=D0=B8=D0=BC=D0=B8=D1=82=D1=80=D0=BE=D0=B2?= <freemangordon@abv.bg>, Joni Lapilainen <joni.lapilainen@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Sebastian Reichel <sre@debian.org>
List-Id: linux-omap@vger.kernel.org

Add new method hsi_add_clients_from_dt, which can be used
to initialize HSI clients from a device tree node.

The function currently only registers the generic hsi_char
device, which is the only one available in the Linux kernel.
Support for loading generic hsi clients will be added once
a common binding has been specified for them.

Signed-off-by: Sebastian Reichel <sre@debian.org>
---
 drivers/hsi/hsi.c       | 32 +++++++++++++++++++++++++++++++-
 include/linux/hsi/hsi.h |  2 ++
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/hsi/hsi.c b/drivers/hsi/hsi.c
index 749f7b5..6fde590 100644
--- a/drivers/hsi/hsi.c
+++ b/drivers/hsi/hsi.c
@@ -26,8 +26,14 @@
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/notifier.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 #include "hsi_core.h"
 
+static struct hsi_board_info hsi_char_dev_info = {
+	.name = "hsi_char",
+};
+
 static ssize_t modalias_show(struct device *dev,
 			struct device_attribute *a __maybe_unused, char *buf)
 {
@@ -50,7 +56,13 @@ static int hsi_bus_uevent(struct device *dev, struct kobj_uevent_env *env)
 
 static int hsi_bus_match(struct device *dev, struct device_driver *driver)
 {
-	return strcmp(dev_name(dev), driver->name) == 0;
+	if (of_driver_match_device(dev, driver))
+		return true;
+
+	if (strcmp(dev_name(dev), driver->name) == 0)
+		return true;
+
+	return false;
 }
 
 static struct bus_type hsi_bus_type = {
@@ -101,6 +113,24 @@ static void hsi_scan_board_info(struct hsi_controller *hsi)
 		}
 }
 
+static void hsi_add_client_from_dt(struct hsi_port *port,
+						struct device_node *client)
+{
+	/* TODO */
+}
+
+void hsi_add_clients_from_dt(struct hsi_port *port, struct device_node *clients)
+{
+	struct device_node *child;
+
+	/* register hsi-char device */
+	hsi_new_client(port, &hsi_char_dev_info);
+
+	for_each_available_child_of_node(clients, child)
+		hsi_add_client_from_dt(port, child);
+}
+EXPORT_SYMBOL_GPL(hsi_add_clients_from_dt);
+
 static int hsi_remove_client(struct device *dev, void *data __maybe_unused)
 {
 	device_unregister(dev);
diff --git a/include/linux/hsi/hsi.h b/include/linux/hsi/hsi.h
index 0dca785..fb07339 100644
--- a/include/linux/hsi/hsi.h
+++ b/include/linux/hsi/hsi.h
@@ -282,6 +282,8 @@ struct hsi_controller *hsi_alloc_controller(unsigned int n_ports, gfp_t flags);
 void hsi_put_controller(struct hsi_controller *hsi);
 int hsi_register_controller(struct hsi_controller *hsi);
 void hsi_unregister_controller(struct hsi_controller *hsi);
+void hsi_add_clients_from_dt(struct hsi_port *port,
+						struct device_node *clients);
 
 static inline void hsi_controller_set_drvdata(struct hsi_controller *hsi,
 								void *data)
-- 
1.9.0
