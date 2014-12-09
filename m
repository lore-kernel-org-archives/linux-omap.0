From: Felipe Balbi <balbi@ti.com>
Subject: [RFC/PATCH 4/7] arm: omap: device: add support for generating sysconfig data from DT
Date: Tue, 9 Dec 2014 16:27:49 -0600
Message-ID: <1418164072-19087-5-git-send-email-balbi@ti.com>
References: <1418164072-19087-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44482 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753263AbaLIW21 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 9 Dec 2014 17:28:27 -0500
In-Reply-To: <1418164072-19087-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Paul Walmsley <paul@pwsan.com>, Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org, Felipe Balbi <balbi@ti.com>

After moving sysconfig data to DT, we need to make
sure we can generate the same data we have today in C
files out of the DT provided properties.

This patch adds support for all optional properties
documented by a previous commit.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/omap_device.c | 115 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 115 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_device.c b/arch/arm/mach-omap2/omap_device.c
index abd622b..ea729aa 100644
--- a/arch/arm/mach-omap2/omap_device.c
+++ b/arch/arm/mach-omap2/omap_device.c
@@ -25,6 +25,7 @@
  */
 #undef DEBUG
 
+#include <linux/ctype.h>
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
@@ -109,6 +110,115 @@ static void _add_hwmod_clocks_clkdev(struct omap_device *od,
 		_add_clkdev(od, oh->opt_clks[i].role, oh->opt_clks[i].clk);
 }
 
+static int omap_hwmod_has_sysc_bindings(struct device *dev)
+{
+	struct device_node *node = dev->of_node;
+	char *properties[] = {
+		"ti,rev_offs",
+		"ti,sysc_offs",
+		"ti,syss_offs",
+		"ti,sysc_flags",
+		"ti,srst_udelay",
+		"ti,idlemodes",
+		"ti,clockact",
+		"ti,sysc_type",
+		NULL
+	};
+	char **tmp = properties;
+
+	while (*tmp) {
+		if (of_property_read_bool(node, *tmp)) {
+			return true;
+		}
+		tmp++;
+	}
+
+	return 0;
+}
+
+static int omap_hwmod_init_sysc(struct device *dev,
+		struct omap_hwmod *oh, int index)
+{
+	struct device_node *node = dev->of_node;
+	struct omap_hwmod_class *class = oh->class;
+	struct omap_hwmod_class_sysconfig *sysc;
+	int ret;
+	int i;
+	char name[128];
+	const char *tmp = oh->name;
+	u32 prop;
+
+	/* if data isn't provided by DT, skip */
+	if ((class && class->sysc) || !omap_hwmod_has_sysc_bindings(dev))
+		return 0;
+
+	class = kzalloc(sizeof(*class), GFP_KERNEL);
+	if (!class)
+		return -ENOMEM;
+
+	i = 0;
+	while (*tmp) {
+		if (isalpha(*tmp))
+			name[i++] = *tmp;
+		tmp++;
+	}
+	name[i] = '\0';
+
+	class->name = kzalloc(sizeof(name), GFP_KERNEL);
+	if (!class->name)
+		return -ENOMEM;
+	strncpy(class->name, name, sizeof(name) - 1);
+
+	sysc = kzalloc(sizeof(*sysc), GFP_KERNEL);
+	if (!sysc)
+		return -ENOMEM;
+
+	ret = of_property_read_u32_index(node, "ti,rev_offs", index, &prop);
+	if (!ret)
+		sysc->rev_offs = prop;
+
+	ret = of_property_read_u32_index(node, "ti,sysc_offs", index, &prop);
+	if (!ret)
+		sysc->sysc_offs = prop;
+
+	ret = of_property_read_u32_index(node, "ti,syss_offs", index, &prop);
+	if (!ret)
+		sysc->syss_offs = prop;
+
+	ret = of_property_read_u32_index(node, "ti,sysc_flags", index, &prop);
+	if (!ret)
+		sysc->sysc_flags = prop & 0xffff;
+
+	ret = of_property_read_u32_index(node, "ti,srst_udelay", index, &prop);
+	if (!ret)
+		sysc->srst_udelay = prop & 0xff;
+
+	ret = of_property_read_u32_index(node, "ti,idlemodes", index, &prop);
+	if (!ret)
+		sysc->idlemodes = prop & 0xff;
+
+	ret = of_property_read_u32_index(node, "ti,clockact", index, &prop);
+	if (!ret)
+		sysc->clockact = prop & 0xff;
+
+	ret = of_property_read_u32_index(node, "ti,sysc_type", index, &prop);
+	if (ret)
+		prop = 1;
+
+	switch (prop) {
+	case 2:
+		sysc->sysc_fields = &omap_hwmod_sysc_type2;
+		break;
+	case 3:
+		sysc->sysc_fields = &omap_hwmod_sysc_type3;
+		break;
+	case 1:
+	default:
+		sysc->sysc_fields = &omap_hwmod_sysc_type1;
+	}
+
+	return 0;
+}
 
 /**
  * omap_device_build_from_dt - build an omap_device with multiple hwmods
@@ -154,6 +264,11 @@ static int omap_device_build_from_dt(struct platform_device *pdev)
 			goto odbfd_exit1;
 		}
 		hwmods[i] = oh;
+
+		ret = omap_hwmod_init_sysc(&pdev->dev, oh, i);
+		if (ret)
+			goto odbfd_exit1;
+
 		if (oh->flags & HWMOD_INIT_NO_IDLE)
 			device_active = true;
 
-- 
2.2.0

