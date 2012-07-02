From: Andy Green <andy.green@linaro.org>
Subject: [PATCH 2 2/4] net ethernet introduce mac_la_ap helper
Date: Mon, 02 Jul 2012 14:40:56 +0800
Message-ID: <20120702064054.26782.79849.stgit@build.warmcat.com>
References: <20120702063545.26782.98908.stgit@build.warmcat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from warmcat.com ([87.106.134.80]:54208 "EHLO warmcat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751485Ab2GBGlB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 2 Jul 2012 02:41:01 -0400
In-Reply-To: <20120702063545.26782.98908.stgit@build.warmcat.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: s-jan@ti.com, arnd@arndb.de, patches@linaro.org, tony@atomide.com, rostedt@goodmis.org, linux-arm-kernel@lists.infradead.org

From: Andy Green <andy@warmcat.com>

This introduces a small helper in net/ethernet, which registers a
network notifier on init, and accepts registrations of expected asynchronously-
probed network device paths (like, "usb1/1-1/1-1.1/1-1.1:1.0") and the MAC
that is needed to be assigned to the device when it appears.

This allows platform code to enforce valid, consistent MAC addresses on to
devices that have not been probed at boot-time, but due to being wired on the
board are always present at the same interface.  It has been tested with USB
and SDIO probed devices.

To make use of this safely you also need to make sure that any drivers that
may compete for the bus ordinal you are using (eg, mUSB and ehci in Panda
case) are loaded in a deterministic order.

At registration it makes a copy of the incoming data, so the data may be
__initdata or otherwise transitory.  Registration can be called multiple times
so registrations from Device Tree and platform may be mixed.

Since it needs to be called quite early in boot and there is no lifecycle for
what it does, it could not be modular and is not a driver.

Via suggestions from Arnd Bergmann and Tony Lindgren.

Signed-off-by: Andy Green <andy.green@linaro.org>
---
 include/net/mac-la-ap.h  |   28 ++++++++
 net/Kconfig              |   14 ++++
 net/ethernet/Makefile    |    2 +
 net/ethernet/mac-la-ap.c |  165 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 209 insertions(+)
 create mode 100644 include/net/mac-la-ap.h
 create mode 100644 net/ethernet/mac-la-ap.c

diff --git a/include/net/mac-la-ap.h b/include/net/mac-la-ap.h
new file mode 100644
index 0000000..d5189b5
--- /dev/null
+++ b/include/net/mac-la-ap.h
@@ -0,0 +1,28 @@
+/*
+ * mac-la-ap.h:  Locally Administered MAC address for Async probed devices
+ */
+
+/**
+ * struct mac_la_ap - associates asynchronously probed device path with
+ *		      MAC address to be assigned to the device when it
+ *		      is created
+ *
+ * @device_path: device path name of network device
+ * @mac: MAC address to assign to network device matching device path
+ * @list: can be left uninitialized when passing from platform
+ */
+
+struct mac_la_ap {
+	char *device_path;
+	u8 mac[6];
+	struct list_head list; /* unused in platform data usage */
+};
+
+/**
+ * mac_la_ap_register_device_macs - add an array of device path to monitor
+ *                                  and MAC to apply when the network device
+ *                                  at the device path appears
+ * @macs: array of struct mac_la_ap terminated by entry with NULL device_path
+ */
+int mac_la_ap_register_device_macs(const struct mac_la_ap *macs);
+
diff --git a/net/Kconfig b/net/Kconfig
index 245831b..76ba70e 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -335,6 +335,20 @@ source "net/caif/Kconfig"
 source "net/ceph/Kconfig"
 source "net/nfc/Kconfig"
 
+config MAC_LA_AP
+	bool "Locally Administered MAC for Aysnchronously Probed devices"
+	---help---
+	This helper allows platforms to mandate a locally-administered
+	sythesized MAC address for network devices that are on asynchronously-
+	probed buses like USB or SDIO.  This is necessary when the board has
+	these network assets but no arrangements for storing or setting the
+	MAC address of the network asset (nor any official MAC address
+	reserved for the device).  In that case, seen in Panda and other
+	boards, the platform can synthesize a constant locally-administered
+	MAC address from SoC UID bits that has a good probability of differing
+	between boards but will be constant on any give board.  This helper
+	will take care of watching for the network devices to appear and
+	force the MAC to the synthesized one when they do.
 
 endif   # if NET
 
diff --git a/net/ethernet/Makefile b/net/ethernet/Makefile
index 7cef1d8..94ee883 100644
--- a/net/ethernet/Makefile
+++ b/net/ethernet/Makefile
@@ -5,3 +5,5 @@
 obj-y					+= eth.o
 obj-$(subst m,y,$(CONFIG_IPX))		+= pe2.o
 obj-$(subst m,y,$(CONFIG_ATALK))	+= pe2.o
+obj-$(CONFIG_MAC_LA_AP)			+= mac-la-ap.o
+
diff --git a/net/ethernet/mac-la-ap.c b/net/ethernet/mac-la-ap.c
new file mode 100644
index 0000000..4216c41
--- /dev/null
+++ b/net/ethernet/mac-la-ap.c
@@ -0,0 +1,165 @@
+/*
+ * Helper to allow setting locally-administered MAC addresses automatically on
+ * asynchronously probed devices, such as SDIO and USB based devices.
+ *
+ * Because the "device path" is used for matching, this is only useful for
+ * network assets physcally wired on the board, and also requires any
+ * different drivers that can compete for bus ordinals (eg mUSB vs ehci) to
+ * have fixed initialization ordering, eg, by having ehci in monolithic
+ * kernel
+ *
+ * Neither a driver nor a module as needs to be callable from machine file
+ * before the network devices are registered.
+ *
+ * (c) 2012 Andy Green <andy.green@linaro.org>
+ */
+
+#include <linux/netdevice.h>
+#include <linux/if_ether.h>
+#include <net/mac-la-ap.h>
+
+static struct mac_la_ap mac_la_ap_list;
+DEFINE_MUTEX(mac_la_ap_mutex);
+bool mac_la_ap_started;
+
+static struct mac_la_ap *__mac_la_ap_check(struct device *dev)
+{
+	const char *path;
+	const char *p;
+	const char *try;
+	int len;
+	struct device *devn;
+	struct mac_la_ap *tmp;
+	struct list_head *pos;
+
+	list_for_each(pos, &mac_la_ap_list.list) {
+
+		tmp = list_entry(pos, struct mac_la_ap, list);
+
+		try = tmp->device_path;
+
+		p = try + strlen(try);
+		devn = dev;
+
+		while (devn) {
+
+			path = dev_name(devn);
+			len = strlen(path);
+
+			if ((p - try) < len) {
+				devn = NULL;
+				continue;
+			}
+
+			p -= len;
+
+			if (strncmp(path, p, len)) {
+				devn = NULL;
+				continue;
+			}
+
+			devn = devn->parent;
+			if (p == try)
+				return tmp;
+
+			if (devn != NULL && (p - try) < 2)
+				devn = NULL;
+
+			p--;
+			if (devn != NULL && *p != '/')
+				devn = NULL;
+		}
+
+		try++;
+	}
+
+	return NULL;
+}
+
+static int mac_la_ap_netdev_event(struct notifier_block *this,
+						unsigned long event, void *ptr)
+{
+	struct net_device *dev = ptr;
+	struct sockaddr sa;
+	struct mac_la_ap *match;
+
+	if (event != NETDEV_REGISTER)
+		return NOTIFY_DONE;
+
+	mutex_lock(&mac_la_ap_mutex);
+
+	match = __mac_la_ap_check(dev->dev.parent);
+	if (match == NULL)
+		goto bail;
+
+	sa.sa_family = dev->type;
+	memcpy(sa.sa_data, match->mac, sizeof match->mac);
+	dev->netdev_ops->ndo_set_mac_address(dev, &sa);
+
+bail:
+	mutex_unlock(&mac_la_ap_mutex);
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block mac_la_ap_netdev_notifier = {
+	.notifier_call = mac_la_ap_netdev_event,
+	.priority = 1,
+};
+
+static int mac_la_ap_init(void)
+{
+	int ret;
+
+	INIT_LIST_HEAD(&mac_la_ap_list.list);
+	mutex_init(&mac_la_ap_mutex);
+	ret = register_netdevice_notifier(&mac_la_ap_netdev_notifier);
+	if (!ret)
+		mac_la_ap_started = 1;
+	else
+		pr_err("mac_la_ap_init: Notifier registration failed\n");
+
+	return ret;
+}
+
+int mac_la_ap_register_device_macs(const struct mac_la_ap *macs)
+{
+	struct mac_la_ap *next;
+	int ret = 0;
+
+	if (!mac_la_ap_started) {
+		ret = mac_la_ap_init();
+		if (ret)
+			return ret;
+	}
+
+	mutex_lock(&mac_la_ap_mutex);
+
+	while (macs->device_path) {
+
+		next = kmalloc(sizeof(struct mac_la_ap), GFP_KERNEL);
+		if (!next) {
+			ret = -ENOMEM;
+			goto bail;
+		}
+
+		next->device_path = kmalloc(strlen(macs->device_path) + 1,
+								   GFP_KERNEL);
+		if (!next->device_path) {
+			ret = -ENOMEM;
+			goto bail;
+		}
+
+		strcpy(next->device_path, macs->device_path);
+		memcpy(next->mac, macs->mac, sizeof macs->mac);
+		list_add(&next->list, &mac_la_ap_list.list);
+
+		macs++;
+	}
+
+bail:
+	mutex_unlock(&mac_la_ap_mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mac_la_ap_register_device_macs);

