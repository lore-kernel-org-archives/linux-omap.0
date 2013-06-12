From: Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH] extcon: Add an API to get extcon device from dt node
Date: Wed, 12 Jun 2013 10:39:09 +0900
Message-ID: <1371001149-16906-1-git-send-email-cw00.choi@samsung.com>
References: <1370276020-17446-2-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-reply-to: <1370276020-17446-2-git-send-email-kishon-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: kishon-l0cyMroinI0@public.gmane.org, myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org, anish198519851985-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, benoit.cousson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: linux-omap@vger.kernel.org

From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>

Added an API of_extcon_get_extcon_dev() to be used by drivers to get
extcon device in the case of dt boot (this can be used instead of
extcon_get_extcon_dev()).

Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Signed-off-by: Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Myungjoo Ham <myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/extcon/Makefile          |  3 +++
 drivers/extcon/of-extcon.c       | 56 ++++++++++++++++++++++++++++++++++++++++
 include/linux/extcon/of-extcon.h | 30 +++++++++++++++++++++
 3 files changed, 89 insertions(+)
 create mode 100644 drivers/extcon/of-extcon.c
 create mode 100644 include/linux/extcon/of-extcon.h

diff --git a/drivers/extcon/Makefile b/drivers/extcon/Makefile
index 540e2c3..39cdf95 100644
--- a/drivers/extcon/Makefile
+++ b/drivers/extcon/Makefile
@@ -2,9 +2,12 @@
 # Makefile for external connector class (extcon) devices
 #
 
+obj-$(CONFIG_OF)		+= of-extcon.o
+
 obj-$(CONFIG_EXTCON)		+= extcon-class.o
 obj-$(CONFIG_EXTCON_GPIO)	+= extcon-gpio.o
 obj-$(CONFIG_EXTCON_ADC_JACK)	+= extcon-adc-jack.o
+
 obj-$(CONFIG_EXTCON_MAX77693)	+= extcon-max77693.o
 obj-$(CONFIG_EXTCON_MAX8997)	+= extcon-max8997.o
 obj-$(CONFIG_EXTCON_ARIZONA)	+= extcon-arizona.o
diff --git a/drivers/extcon/of-extcon.c b/drivers/extcon/of-extcon.c
new file mode 100644
index 0000000..29f82b4
--- /dev/null
+++ b/drivers/extcon/of-extcon.c
@@ -0,0 +1,56 @@
+/*
+ * OF helpers for External connector (extcon) framework
+ *
+ * Copyright (C) 2013 Texas Instruments, Inc.
+ * Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
+ *
+ * Copyright (C) 2013 Samsung Electronics
+ * Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/extcon.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/extcon/of-extcon.h>
+
+struct extcon_dev *of_extcon_get_extcon_dev(struct device *dev, int index)
+{
+	struct device_node *node;
+	struct extcon_dev *edev;
+	struct platform_device *extcon_parent_dev;
+
+	if (!dev->of_node) {
+		dev_dbg(dev, "device does not have a device node entry\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	node = of_parse_phandle(dev->of_node, "extcon", index);
+	if (!node) {
+		dev_dbg(dev, "failed to get phandle in %s node\n",
+			dev->of_node->full_name);
+		return ERR_PTR(-ENODEV);
+	}
+
+	extcon_parent_dev = of_find_device_by_node(node);
+	if (!extcon_parent_dev) {
+		dev_dbg(dev, "unable to find device by node\n");
+		return ERR_PTR(-EPROBE_DEFER);
+	}
+
+	edev = extcon_get_extcon_dev(dev_name(&extcon_parent_dev->dev));
+	if (!edev) {
+		dev_dbg(dev, "unable to get extcon device : %s\n",
+				dev_name(&extcon_parent_dev->dev));
+		return ERR_PTR(-ENODEV);
+	}
+
+	return edev;
+}
+EXPORT_SYMBOL_GPL(of_extcon_get_extcon_dev);
diff --git a/include/linux/extcon/of-extcon.h b/include/linux/extcon/of-extcon.h
new file mode 100644
index 0000000..77d01ba
--- /dev/null
+++ b/include/linux/extcon/of-extcon.h
@@ -0,0 +1,30 @@
+/*
+ * OF helpers for External connector (extcon) framework
+ *
+ * Copyright (C) 2013 Texas Instruments, Inc.
+ * Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
+ *
+ * Copyright (C) 2013 Samsung Electronics
+ * Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#ifndef __LINUX_OF_EXTCON_H
+#define __LINUX_OF_EXTCON_H
+
+#if defined(CONFIG_OF)
+extern struct extcon_dev
+	*of_extcon_get_extcon_dev(struct device *dev, int index);
+#else
+static inline struct extcon_dev
+	*of_extcon_get_extcon_dev(struct device *dev, int index);
+{
+	return NULL;
+}
+#endif /* CONFIG_OF */
+
+#endif /* __LINUX_OF_EXTCON_H */
-- 
1.8.0
