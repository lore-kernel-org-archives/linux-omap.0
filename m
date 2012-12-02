From: Ming Lei <tom.leiming@gmail.com>
Subject: [RFC PATCH 4/5] arm: omap2: support port power on lan95xx devices
Date: Sun,  2 Dec 2012 23:01:06 +0800
Message-ID: <1354460467-28006-5-git-send-email-tom.leiming@gmail.com>
References: <1354460467-28006-1-git-send-email-tom.leiming@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1354460467-28006-1-git-send-email-tom.leiming@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Lan Tianyu <tianyu.lan@intel.com>, Sarah Sharp <sarah.a.sharp@linux.intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org, Oliver Neukum <oneukum@suse.de>, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, Ming Lei <tom.leiming@gmail.com>, Andy Green <andy.green@linaro.org>, Roger Quadros <rogerq@ti.com>, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

This patch defines power controller for powering on/off LAN95xx
USB hub and USB ethernet devices, and implements one match function
to associate the power controller with related USB port device.
The big problem of this approach is that it depends on the global
device ADD/DEL notifier.

Another idea of associating power controller with port device
is by introducing usb port driver, and move all this port power
control stuff from platform code to the port driver, which is just
what I think of and looks doable. The problem of the idea is that
port driver is per board, so maybe cause lots of platform sort of
code to be put under drivers/usb/port/, but this approach can avoid
global device ADD/DEL notifier.

I'd like to get some feedback about which one is better or other choice,
then I may do it in next cycle.

Cc: Andy Green <andy.green@linaro.org>
Cc: Roger Quadros <rogerq@ti.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Felipe Balbi <balbi@ti.com>
Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 arch/arm/mach-omap2/board-omap4panda.c |   99 +++++++++++++++++++++++++++++++-
 1 file changed, 96 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index 5c8e9ce..3183832 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -32,6 +32,8 @@
 #include <linux/usb/musb.h>
 #include <linux/wl12xx.h>
 #include <linux/platform_data/omap-abe-twl6040.h>
+#include <linux/power_controller.h>
+#include <linux/usb/port.h>
 
 #include <asm/hardware/gic.h>
 #include <asm/mach-types.h>
@@ -154,6 +156,99 @@ static struct gpio panda_ehci_gpios[] __initdata = {
 	{ GPIO_HUB_NRESET,	GPIOF_OUT_INIT_LOW,  "hub_nreset" },
 };
 
+static void ehci_hub_power_on(struct power_controller *pc, struct device *dev)
+{
+	gpio_set_value(GPIO_HUB_NRESET, 1);
+	gpio_set_value(GPIO_HUB_POWER, 1);
+}
+
+static void ehci_hub_power_off(struct power_controller *pc, struct device *dev)
+{
+	gpio_set_value(GPIO_HUB_NRESET, 0);
+	gpio_set_value(GPIO_HUB_POWER, 0);
+}
+
+static struct usb_port_power_switch_data root_hub_port_data = {
+	.hub_tier	= 0,
+	.port_number = 1,
+	.type = USB_PORT_CONNECT_TYPE_HARD_WIRED,
+};
+
+static struct usb_port_power_switch_data smsc_hub_port_data = {
+	.hub_tier	= 1,
+	.port_number = 1,
+	.type = USB_PORT_CONNECT_TYPE_HARD_WIRED,
+};
+
+static struct power_controller pc = {
+	.name = "omap_hub_eth_pc",
+	.count = ATOMIC_INIT(0),
+	.power_on = ehci_hub_power_on,
+	.power_off = ehci_hub_power_off,
+};
+
+static inline int omap_ehci_hub_port(struct device *dev)
+{
+	/* we expect dev->parent points to ehcd controller */
+	if (dev->parent && !strcmp(dev_name(dev->parent), "ehci-omap.0"))
+		return 1;
+	return 0;
+}
+
+static inline int dev_pc_match(struct device *dev)
+{
+	struct device *anc;
+	int ret = 0;
+
+	if (likely(strcmp(dev_name(dev), "port1")))
+		goto exit;
+
+	if (dev->parent && (anc = dev->parent->parent)) {
+		if (omap_ehci_hub_port(anc)) {
+			ret = 1;
+			goto exit;
+		}
+
+		/* is it port of lan95xx hub? */
+		if ((anc = anc->parent) && omap_ehci_hub_port(anc)) {
+			ret = 2;
+			goto exit;
+		}
+	}
+exit:
+	return ret;
+}
+
+/*
+ * Notifications of device registration
+ */
+static int device_notify(struct notifier_block *nb, unsigned long action, void *data)
+{
+	struct device *dev = data;
+	int ret;
+
+	switch (action) {
+	case DEV_NOTIFY_ADD_DEVICE:
+		ret = dev_pc_match(dev);
+		if (likely(!ret))
+			goto exit;
+		if (ret == 1)
+			dev_pc_bind(&pc, dev, &root_hub_port_data, sizeof(root_hub_port_data));
+		else
+			dev_pc_bind(&pc, dev, &smsc_hub_port_data, sizeof(smsc_hub_port_data));
+		break;
+
+	case DEV_NOTIFY_DEL_DEVICE:
+		break;
+	}
+exit:
+	return 0;
+}
+
+static struct notifier_block usb_port_nb = {
+	.notifier_call = device_notify,
+};
+
 static void __init omap4_ehci_init(void)
 {
 	int ret;
@@ -178,12 +273,10 @@ static void __init omap4_ehci_init(void)
 
 	gpio_export(GPIO_HUB_POWER, 0);
 	gpio_export(GPIO_HUB_NRESET, 0);
-	gpio_set_value(GPIO_HUB_NRESET, 1);
 
 	usbhs_init(&usbhs_bdata);
 
-	/* enable power to hub */
-	gpio_set_value(GPIO_HUB_POWER, 1);
+	dev_register_notifier(&usb_port_nb);
 }
 
 static struct omap_musb_board_data musb_board_data = {
-- 
1.7.9.5

