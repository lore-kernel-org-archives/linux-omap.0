From: Mike Turquette <mturquette@linaro.org>
Subject: [PATCH RFC 1/3] clk: omap: introduce clock driver
Date: Mon,  3 Jun 2013 23:39:16 -0700
Message-ID: <1370327958-19776-2-git-send-email-mturquette@linaro.org>
References: <1370327958-19776-1-git-send-email-mturquette@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f50.google.com ([209.85.160.50]:63751 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751359Ab3FDGjf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Jun 2013 02:39:35 -0400
Received: by mail-pb0-f50.google.com with SMTP id wy17so6710860pbc.23
        for <linux-omap@vger.kernel.org>; Mon, 03 Jun 2013 23:39:35 -0700 (PDT)
In-Reply-To: <1370327958-19776-1-git-send-email-mturquette@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Tero Kristo <t-kristo@ti.com>, Rajendra <rnayak@ti.com>, Nishanth Menon <nm@ti.com>, Benoit Cousson <b-cousson@ti.com>, Mike Turquette <mturquette@linaro.org>, Joel A Fernandes <joelagnel@ti.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>

Parses OMAP clock data from DT and registers those clocks with the clock
framework.  dt_omap_clk_init must be called early during boot for timer
initialization so it is exported and called from the existing clock code
instead of probing like a real driver.

Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>
Cc: Joel A Fernandes <joelagnel@ti.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Mike Turquette <mturquette@linaro.org>
---
This driver simply matches the basic bindings (so far).  Eventually it
would match omap-specific bindings for DPLLs, CLKOUTX2 and strange leaf
clocks as well.  This doesn't scale well since non-OMAP related clock
data (e.g. a pmic or discrete audio codec) will get grouped into this
driver if it matches on a basic clock type.  Suggestions?

 drivers/clk/Makefile      |  1 +
 drivers/clk/omap/Makefile |  1 +
 drivers/clk/omap/clk.c    | 55 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/clk/omap.h  | 24 +++++++++++++++++++++
 4 files changed, 81 insertions(+)
 create mode 100644 drivers/clk/omap/Makefile
 create mode 100644 drivers/clk/omap/clk.c
 create mode 100644 include/linux/clk/omap.h

diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index f51b52b..efd4f2a 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -31,6 +31,7 @@ obj-$(CONFIG_ARCH_VT8500)	+= clk-vt8500.o
 obj-$(CONFIG_ARCH_ZYNQ)		+= clk-zynq.o
 obj-$(CONFIG_ARCH_TEGRA)	+= tegra/
 obj-$(CONFIG_PLAT_SAMSUNG)	+= samsung/
+obj-$(CONFIG_ARCH_OMAP)		+= omap/
 
 obj-$(CONFIG_X86)		+= x86/
 
diff --git a/drivers/clk/omap/Makefile b/drivers/clk/omap/Makefile
new file mode 100644
index 0000000..8195931
--- /dev/null
+++ b/drivers/clk/omap/Makefile
@@ -0,0 +1 @@
+obj-y					+= clk.o
diff --git a/drivers/clk/omap/clk.c b/drivers/clk/omap/clk.c
new file mode 100644
index 0000000..e9e5c95
--- /dev/null
+++ b/drivers/clk/omap/clk.c
@@ -0,0 +1,55 @@
+/*
+ * OMAP PRCM clock driver
+ *
+ * Copyright (C) 2013 Linaro.org - http://www.linaro.org
+ * 	Mike Turquette <mturquette@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/clk/omap.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+
+/* FIXME - should the OMAP PRCM clock driver match generic types? */
+static const struct of_device_id clk_match[] = {
+	{.compatible = "fixed-clock", .data = of_fixed_clk_setup, },
+	{.compatible = "mux-clock", .data = of_mux_clk_setup, },
+	{.compatible = "fixed-factor-clock",
+		.data = of_fixed_factor_clk_setup, },
+	{},
+};
+
+static int omap_clk_probe(struct platform_device *pdev)
+{
+	of_clk_init(clk_match);
+	return 0;
+}
+
+static struct platform_driver omap_clk_driver = {
+	.probe = omap_clk_probe,
+	.driver = {
+		   .name = "omap_clk",
+		   .of_match_table = of_match_ptr(clk_match),
+		   },
+};
+
+/* FIXME - need to initialize early; skip real driver registration & probe */
+int __init dt_omap_clk_init(void)
+{
+	return omap_clk_probe(NULL);
+}
+
+MODULE_DESCRIPTION("OMAP Clock driver");
+MODULE_AUTHOR("Texas Instruments Inc.");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/clk/omap.h b/include/linux/clk/omap.h
new file mode 100644
index 0000000..504e838
--- /dev/null
+++ b/include/linux/clk/omap.h
@@ -0,0 +1,24 @@
+/*
+ * Copyright (C) 2010 Broadcom
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#ifndef __LINUX_CLK_OMAP_H_
+#define __LINUX_CLK_OMAP_H_
+
+int __init dt_omap_clk_init(void);
+
+#endif
-- 
1.8.1.2

