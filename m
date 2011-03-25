From: Hema Kalliguddi <hemahk@ti.com>
Subject: RE: [RFC PATCH 2/2] OMAP2+: PANDA: Fix up random or missing MAC
 addresses for eth0 and wlan0
Date: Fri, 25 Mar 2011 13:09:38 +0530
Message-ID: <78b7faad4cdc37c6b507c008fde18ef3@mail.gmail.com>
References: <20110324211451.14936.39750.stgit@otae.warmcat.com> <20110324212737.14936.21228.stgit@otae.warmcat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:54425 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751417Ab1CYHju (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Mar 2011 03:39:50 -0400
Received: by ewy5 with SMTP id 5so421914ewy.6
        for <linux-omap@vger.kernel.org>; Fri, 25 Mar 2011 00:39:45 -0700 (PDT)
In-Reply-To: <20110324212737.14936.21228.stgit@otae.warmcat.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andy Green <andy@warmcat.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: patches@linaro.org, nicolas.pitre@linaro.org, arnd@arndb.de, David Anders <x0132446@ti.com>, Sebastien Jan <s-jan@ti.com>, tony@atomide.com, Alan Cox <alan@lxorguk.ukuu.org.uk>, Andy Green <andy.green@linaro.org>

Hi,

one Minor comment.

>-----Original Message-----
>From: linux-omap-owner@vger.kernel.org
>[mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Andy Green
>Sent: Friday, March 25, 2011 2:58 AM
>To: linux-arm-kernel@lists.infradead.org; linux-omap@vger.kernel.org
>Cc: patches@linaro.org; nicolas.pitre@linaro.org;
>arnd@arndb.de; x0132446@ti.com; s-jan@ti.com;
>tony@atomide.com; Alan Cox; Andy Green
>Subject: [RFC PATCH 2/2] OMAP2+: PANDA: Fix up random or
>missing MAC addresses for eth0 and wlan0
>
>This patch registers a network device notifier callback to set the mac
>addresses for the onboard network assets of Panda correctly,
>despite the
>drivers involved have used a random or all-zeros MAC address.
>
>The technique was suggested by Alan Cox on lkml.
>
>It works by device path so it corrects the MAC addresses even if the
>drivers are in modules loaded in an order that changes their interface
>name from usual (eg, the onboard module might be "wlan1" if there is a
>USB wireless stick plugged in and its module is inserted first.)
>
>Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
>Signed-off-by: Andy Green <andy.green@linaro.org>
>---
>
> arch/arm/mach-omap2/board-omap4panda.c |   91
>++++++++++++++++++++++++++++++++
> 1 files changed, 91 insertions(+), 0 deletions(-)
>
>diff --git a/arch/arm/mach-omap2/board-omap4panda.c
>b/arch/arm/mach-omap2/board-omap4panda.c
>index 80b8860..0b92873 100644
>--- a/arch/arm/mach-omap2/board-omap4panda.c
>+++ b/arch/arm/mach-omap2/board-omap4panda.c
>@@ -28,9 +28,12 @@
> #include <linux/regulator/machine.h>
> #include <linux/regulator/fixed.h>
> #include <linux/wl12xx.h>
>+#include <linux/netdevice.h>
>+#include <linux/if_ether.h>
>
> #include <mach/hardware.h>
> #include <mach/omap4-common.h>
>+#include <mach/id.h>
> #include <asm/mach-types.h>
> #include <asm/mach/arch.h>
> #include <asm/mach/map.h>
>@@ -506,6 +509,92 @@ static inline void board_serial_init(void)
> }
> #endif
>
>+/*
>+ * These device paths represent the onboard USB <-> Ethernet
>bridge, and
>+ * the WLAN module on Panda, both of which need their random
>or all-zeros
>+ * mac address replacing with a per-cpu stable generated one
>+ */
>+
>+static const char * const panda_fixup_mac_device_paths[] = {
>+	"usb1/1-1/1-1.1/1-1.1:1.0",
>+	"mmc1:0001:2",
>+};
>+
>+static int panda_device_path_need_mac(struct device *dev)
>+{
>+	const char **try = panda_fixup_mac_device_paths;
>+	const char *path;
>+	int count = ARRAY_SIZE(panda_fixup_mac_device_paths);
>+	const char *p;
>+	int len;
>+	struct device *devn;
>+
>+	while (count--) {
>+
>+		p = *try + strlen(*try);
>+		devn = dev;
>+
>+		while (devn) {
>+
>+			path = dev_name(devn);
>+			len = strlen(path);
>+
>+			if ((p - *try) < len) {
>+				devn = NULL;
>+				continue;
>+			}
>+
>+			p -= len;
>+
>+			if (strncmp(path, p, len)) {
>+				devn = NULL;
>+				continue;
>+			}
>+
>+			devn = devn->parent;
>+			if (p == *try)
>+				return count;
>+
>+			if (devn != NULL && (p - *try) < 2)
>+				devn = NULL;
>+
>+			p--;
>+			if (devn != NULL && *p != '/')
>+				devn = NULL;
>+		}
>+
>+		try++;
>+	}
>+
>+	return -ENOENT;
>+}
>+
>+static int omap_panda_netdev_event(struct notifier_block *this,
>+						 unsigned long
>event, void *ptr)
>+{
>+	struct net_device *dev = ptr;
>+	struct sockaddr sa;
>+	int n;
>+
>+	if (event != NETDEV_REGISTER)
>+		return NOTIFY_DONE;
>+
>+	n = panda_device_path_need_mac(dev->dev.parent);
>+	if (n >= 0) {
>+		sa.sa_family = dev->type;
>+		omap2_die_id_to_ethernet_mac(sa.sa_data, n);
>+		dev->netdev_ops->ndo_set_mac_address(dev, &sa);
>+	}
>+
>+	return NOTIFY_DONE;
>+}
>+
>+static struct notifier_block omap_panda_netdev_notifier = {
>+	.notifier_call = omap_panda_netdev_event,
>+	.priority = 1,
>+};
>+
>+

One extra blank line not needed.

Regards,
Hema

> static void __init omap4_panda_init(void)
> {
> 	int package = OMAP_PACKAGE_CBS;
>@@ -517,6 +606,8 @@ static void __init omap4_panda_init(void)
> 	if (wl12xx_set_platform_data(&omap_panda_wlan_data))
> 		pr_err("error setting wl12xx data\n");
>
>+	register_netdevice_notifier(&omap_panda_netdev_notifier);
>+
> 	omap4_panda_i2c_init();
> 	platform_add_devices(panda_devices, ARRAY_SIZE(panda_devices));
> 	platform_device_register(&omap_vwlan_device);
>
>--
>To unsubscribe from this list: send the line "unsubscribe
>linux-omap" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
