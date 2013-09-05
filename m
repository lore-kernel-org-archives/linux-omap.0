From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: [PATCH RESEND] am33xx: cpsw: default to ethernet hwaddr from efuse if not defined in dt
Date: Thu,  5 Sep 2013 23:08:26 +0200
Message-ID: <1378415306-28821-1-git-send-email-jacmet@sunsite.dk>
References: <CAOesGMj7t4WAGtcE+PUau0OhANoGNdokCHpUoNF2t+hs+83iCg@mail.gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ea0-f176.google.com ([209.85.215.176]:47823 "EHLO
	mail-ea0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753525Ab3IEVI6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Sep 2013 17:08:58 -0400
Received: by mail-ea0-f176.google.com with SMTP id q16so1181712ead.21
        for <linux-omap@vger.kernel.org>; Thu, 05 Sep 2013 14:08:57 -0700 (PDT)
In-Reply-To: <CAOesGMj7t4WAGtcE+PUau0OhANoGNdokCHpUoNF2t+hs+83iCg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, olof@lixom.net, khilman@linaro.org, tony@atomide.com
Cc: mugunthanvnm@ti.com, mpfj-list@newflow.co.uk, koen@dominion.thruhere.net, matt.porter@linaro.org, Peter Korsgaard <jacmet@sunsite.dk>

When booting with CONFIG_ARM_APPENDED_DTB (either because of using an old
U-Boot, not wanting the hassle of 2 files or when using Falcon fast boot
mode in U-Boot), nothing updates the ethernet hwaddr specified for the
CPSW slaves, causing the driver to use a random hwaddr, which is some times
troublesome.

The am33xx has unique ethernet hwaddrs programmed in the efuse, so it makes
more sense to default to these rather than random ones. Add a fixup step
which adds mac-address dt properties using the efuse addresses if the DTB
didn't contain valid ones.

Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
Acked-by: Mugunthan V N <mugunthanvnm@ti.com>
Tested-by: Mark Jackson <mpfj-list@newflow.co.uk>
Tested-by: Koen Kooi <koen@dominion.thruhere.net>
Tested-by: Matt Porter <matt.porter@linaro.org>
---
Resent without changes.

 arch/arm/mach-omap2/Makefile      |    3 ++
 arch/arm/mach-omap2/am33xx-cpsw.c |   94 +++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/control.h     |    4 ++
 3 files changed, 101 insertions(+)
 create mode 100644 arch/arm/mach-omap2/am33xx-cpsw.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index afb457c..0afee42 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -305,4 +305,7 @@ endif
 emac-$(CONFIG_TI_DAVINCI_EMAC)		:= am35xx-emac.o
 obj-y					+= $(emac-m) $(emac-y)
 
+cpsw-$(CONFIG_TI_CPSW)			:= am33xx-cpsw.o
+obj-y					+= $(cpsw-m) $(cpsw-y)
+
 obj-y					+= common-board-devices.o twl-common.o dss-common.o
diff --git a/arch/arm/mach-omap2/am33xx-cpsw.c b/arch/arm/mach-omap2/am33xx-cpsw.c
new file mode 100644
index 0000000..5a674d9
--- /dev/null
+++ b/arch/arm/mach-omap2/am33xx-cpsw.c
@@ -0,0 +1,94 @@
+/*
+ * am335x specific cpsw dt fixups
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/etherdevice.h>
+#include <linux/of.h>
+#include <linux/of_net.h>
+
+#include "soc.h"
+#include "control.h"
+
+/**
+ * am33xx_dt_cpsw_set_mac_from_efuse - Add mac-address property using
+ * ethernet hwaddr from efuse
+ * @np:		Pointer to the cpsw slave to set mac address of
+ * @idx:	Mac address index to use from efuse
+ */
+static void am33xx_dt_cpsw_set_mac_from_efuse(struct device_node *np, int idx)
+{
+	struct property *prop;
+	u32 lo, hi;
+	u8 *mac;
+
+	switch (idx) {
+	case 0:
+		lo = omap_ctrl_readl(AM33XX_CONTROL_MAC_ID0_LOW);
+		hi = omap_ctrl_readl(AM33XX_CONTROL_MAC_ID0_HIGH);
+		break;
+
+	case 1:
+		lo = omap_ctrl_readl(AM33XX_CONTROL_MAC_ID1_LOW);
+		hi = omap_ctrl_readl(AM33XX_CONTROL_MAC_ID1_HIGH);
+		break;
+
+	default:
+		pr_err("cpsw.%d: too many slaves found\n", idx);
+		return;
+	}
+
+	prop = kzalloc(sizeof(*prop) + ETH_ALEN, GFP_KERNEL);
+	if (!prop)
+		return;
+
+	prop->value = prop + 1;
+	prop->length = ETH_ALEN;
+	prop->name = kstrdup("mac-address", GFP_KERNEL);
+	if (!prop->name) {
+		kfree(prop);
+		return;
+	}
+
+	mac = prop->value;
+
+	mac[0] = hi;
+	mac[1] = hi >> 8;
+	mac[2] = hi >> 16;
+	mac[3] = hi >> 24;
+	mac[4] = lo;
+	mac[5] = lo >> 8;
+
+	of_update_property(np, prop);
+
+	pr_info("cpsw.%d: No hwaddr in dt. Using %pM from efuse\n", idx, mac);
+}
+
+static int __init am33xx_dt_cpsw_mac_fixup(void)
+{
+	struct device_node *np, *slave;
+	int idx = 0;
+
+	if (!soc_is_am33xx())
+		return -ENODEV;
+
+	for_each_compatible_node(np, NULL, "ti,cpsw")
+		for_each_node_by_name(slave, "slave") {
+			if (!of_get_mac_address(slave))
+				am33xx_dt_cpsw_set_mac_from_efuse(slave, idx);
+			idx++;
+		}
+
+	return 0;
+}
+arch_initcall(am33xx_dt_cpsw_mac_fixup);
diff --git a/arch/arm/mach-omap2/control.h b/arch/arm/mach-omap2/control.h
index f7d7c2e..5d684b7 100644
--- a/arch/arm/mach-omap2/control.h
+++ b/arch/arm/mach-omap2/control.h
@@ -352,6 +352,10 @@
 /* AM33XX CONTROL_STATUS register */
 #define AM33XX_CONTROL_STATUS		0x040
 #define AM33XX_CONTROL_SEC_CLK_CTRL	0x1bc
+#define AM33XX_CONTROL_MAC_ID0_LOW	0x630
+#define AM33XX_CONTROL_MAC_ID0_HIGH	0x634
+#define AM33XX_CONTROL_MAC_ID1_LOW	0x638
+#define AM33XX_CONTROL_MAC_ID1_HIGH	0x63c
 
 /* AM33XX CONTROL_STATUS bitfields (partial) */
 #define AM33XX_CONTROL_STATUS_SYSBOOT1_SHIFT		22
-- 
1.7.10.4

