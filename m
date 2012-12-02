From: Ming Lei <tom.leiming-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [RFC PATCH 3/5] USB: hub: apply power controller on usb port
Date: Sun,  2 Dec 2012 23:01:05 +0800
Message-ID: <1354460467-28006-4-git-send-email-tom.leiming@gmail.com>
References: <1354460467-28006-1-git-send-email-tom.leiming@gmail.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1354460467-28006-1-git-send-email-tom.leiming-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Sarah Sharp <sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ming Lei <tom.leiming-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andy Green <andy.green-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

This patch applies the power controller on usb port, so that
hub driver can power on one port which isn't provided power
by bus.

Cc: Andy Green <andy.green-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Signed-off-by: Ming Lei <tom.leiming-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/usb/core/hub.c   |   31 ++++++++++++++++++++++++++++---
 include/linux/usb/port.h |   16 ++++++++++++++++
 2 files changed, 44 insertions(+), 3 deletions(-)
 create mode 100644 include/linux/usb/port.h

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index a815fd2..f8075d7 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -26,6 +26,8 @@
 #include <linux/mutex.h>
 #include <linux/freezer.h>
 #include <linux/random.h>
+#include <linux/power_controller.h>
+#include <linux/usb/port.h>
 
 #include <asm/uaccess.h>
 #include <asm/byteorder.h>
@@ -848,8 +850,15 @@ static unsigned hub_power_on(struct usb_hub *hub, bool do_delay)
 	else
 		dev_dbg(hub->intfdev, "trying to enable port power on "
 				"non-switchable hub\n");
-	for (port1 = 1; port1 <= hub->descriptor->bNbrPorts; port1++)
+	for (port1 = 1; port1 <= hub->descriptor->bNbrPorts; port1++) {
+		struct usb_port *port = hub->ports[port1 - 1];
+		struct pc_dev_data *pc_data = dev_pc_get_data(&port->dev);
+
+		/* The power supply for this port isn't managed by bus only */
+		if (pc_data)
+			dev_pc_power_on(&port->dev);
 		set_port_feature(hub->hdev, port1, USB_PORT_FEAT_POWER);
+	}
 
 	/* Wait at least 100 msec for power to become stable */
 	delay = max(pgood_delay, (unsigned) 100);
@@ -1541,10 +1550,20 @@ static int hub_configure(struct usb_hub *hub,
 	if (hub->has_indicators && blinkenlights)
 		hub->indicator [0] = INDICATOR_CYCLE;
 
-	for (i = 0; i < hdev->maxchild; i++)
+	for (i = 0; i < hdev->maxchild; i++) {
 		if (usb_hub_create_port_device(hub, i + 1) < 0)
 			dev_err(hub->intfdev,
 				"couldn't create port%d device.\n", i + 1);
+		else {
+			struct usb_port *port = hub->ports[i];
+			struct pc_dev_data *pc_data = dev_pc_get_data(&port->dev);
+			if (pc_data && pc_data->dev_data) {
+				struct usb_port_power_switch_data *up =
+					pc_data->dev_data;
+				usb_set_hub_port_connect_type(hdev, i + 1, up->type);
+			}
+		}
+	}
 
 	hub_activate(hub, HUB_INIT);
 	return 0;
@@ -1587,8 +1606,14 @@ static void hub_disconnect(struct usb_interface *intf)
 
 	usb_set_intfdata (intf, NULL);
 
-	for (i = 0; i < hdev->maxchild; i++)
+	for (i = 0; i < hdev->maxchild; i++) {
+		struct usb_port *port = hub->ports[i];
+		struct pc_dev_data *pc_data = dev_pc_get_data(&port->dev);
+		if (pc_data)
+			dev_pc_power_off(&port->dev);
+
 		usb_hub_remove_port_device(hub, i + 1);
+	}
 	hub->hdev->maxchild = 0;
 
 	if (hub->hdev->speed == USB_SPEED_HIGH)
diff --git a/include/linux/usb/port.h b/include/linux/usb/port.h
new file mode 100644
index 0000000..a853d5e
--- /dev/null
+++ b/include/linux/usb/port.h
@@ -0,0 +1,16 @@
+#ifndef __USB_CORE_PORT_H
+#define __USB_CORE_PORT_H
+
+#include <linux/usb.h>
+
+/*
+ * Only used for describing power switch which provide power to
+ * hardwired self-powered device which attached to the port
+ */
+struct usb_port_power_switch_data {
+	int hub_tier;	/* root hub is zero, next tier is 1, ... */
+	int port_number;
+	enum usb_port_connect_type type;
+};
+
+#endif
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
