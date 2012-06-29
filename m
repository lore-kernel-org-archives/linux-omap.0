From: Andy Green <andy.green@linaro.org>
Subject: [PATCH 2/3] OMAP2+ devices add mac address allocation register api
Date: Fri, 29 Jun 2012 13:55:19 +0800
Message-ID: <20120629055516.11091.82899.stgit@build.warmcat.com>
References: <20120629054404.11091.31289.stgit@build.warmcat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from warmcat.com ([87.106.134.80]:41558 "EHLO warmcat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751027Ab2F2FzX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 29 Jun 2012 01:55:23 -0400
In-Reply-To: <20120629054404.11091.31289.stgit@build.warmcat.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: nicolas.pitre@linaro.org, s-jan@ti.com, arnd@arndb.de, patches@linaro.org, tony@atomide.com, rostedt@goodmis.org

From: Andy Green <andy@warmcat.com>

This exposes a new API in devices.c that lets a board register
a list of device paths representing network devices that have
no arrangements for their MAC address to be set by the board.

It watches network device registrations via a notifier and
gives the devices requiring them a synthetic - but constant for
a given board - MAC address immediately.

This approach is compatible with devices with asynchronous
probe such as the USB-based Etherent PHY and SDIO-based
wlan module found on PandaBoard / ES.

It has also been tested on PandaBoard 5 successfully but that
support is not part of this series.

Signed-off-by: Andy Green <andy.green@linaro.org>
---
 arch/arm/mach-omap2/common.h  |    2 +
 arch/arm/mach-omap2/devices.c |   89 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 91 insertions(+)

diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index 5d99c1b..ae4d8a9 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -116,6 +116,8 @@ static inline int omap_mux_late_init(void)
 #endif
 
 extern void omap2_init_common_infrastructure(void);
+extern int omap_register_mac_device_fixup_paths(const char * const *paths,
+								    int count);
 
 extern struct sys_timer omap2_timer;
 extern struct sys_timer omap3_timer;
diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 91ef6699..d0a3d2d 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -18,12 +18,15 @@
 #include <linux/slab.h>
 #include <linux/of.h>
 #include <linux/platform_data/omap4-keypad.h>
+#include <linux/netdevice.h>
+#include <linux/if_ether.h>
 
 #include <mach/hardware.h>
 #include <mach/irqs.h>
 #include <asm/mach-types.h>
 #include <asm/mach/map.h>
 #include <asm/pmu.h>
+#include <mach/id.h>
 
 #include "iomap.h"
 #include <plat/board.h>
@@ -39,6 +42,9 @@
 #define L3_MODULES_MAX_LEN 12
 #define L3_MODULES 3
 
+static const char * const *mac_device_fixup_paths;
+int count_mac_device_fixup_paths;
+
 static int __init omap3_l3_init(void)
 {
 	struct omap_hwmod *oh;
@@ -627,6 +633,89 @@ static void omap_init_vout(void)
 static inline void omap_init_vout(void) {}
 #endif
 
+static int omap_device_path_need_mac(struct device *dev)
+{
+	const char **try = (const char **)mac_device_fixup_paths;
+	const char *path;
+	int count = count_mac_device_fixup_paths;
+	const char *p;
+	int len;
+	struct device *devn;
+
+	while (count--) {
+
+		p = *try + strlen(*try);
+		devn = dev;
+
+		while (devn) {
+
+			path = dev_name(devn);
+			len = strlen(path);
+
+			if ((p - *try) < len) {
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
+			if (p == *try)
+				return count;
+
+			if (devn != NULL && (p - *try) < 2)
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
+	return -ENOENT;
+}
+
+static int omap_panda_netdev_event(struct notifier_block *this,
+						unsigned long event, void *ptr)
+{
+	struct net_device *dev = ptr;
+	struct sockaddr sa;
+	int n;
+
+	if (event != NETDEV_REGISTER)
+		return NOTIFY_DONE;
+
+	n = omap_device_path_need_mac(dev->dev.parent);
+	if (n < 0)
+		return NOTIFY_DONE;
+
+	sa.sa_family = dev->type;
+	omap2_die_id_to_ethernet_mac(sa.sa_data, n);
+	dev->netdev_ops->ndo_set_mac_address(dev, &sa);
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block omap_panda_netdev_notifier = {
+	.notifier_call = omap_panda_netdev_event,
+	.priority = 1,
+};
+
+int omap_register_mac_device_fixup_paths(const char * const *paths, int count)
+{
+	mac_device_fixup_paths = paths;
+	count_mac_device_fixup_paths = count;
+
+	return register_netdevice_notifier(&omap_panda_netdev_notifier);
+}
+
 /*-------------------------------------------------------------------------*/
 
 static int __init omap2_init_devices(void)

