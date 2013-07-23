From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv4 02/33] clk: omap: introduce clock driver
Date: Tue, 23 Jul 2013 10:19:57 +0300
Message-ID: <1374564028-11352-3-git-send-email-t-kristo@ti.com>
References: <1374564028-11352-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46690 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752670Ab3GWHWD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Jul 2013 03:22:03 -0400
In-Reply-To: <1374564028-11352-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, khilman@linaro.org, tony@atomide.com, mturquette@linaro.org, nm@ti.com, rnayak@ti.com
Cc: linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

Parses OMAP clock data from DT and registers those clocks with the clock
framework.  dt_omap_clk_init must be called early during boot for timer
initialization so it is exported and called from the existing clock code
instead of probing like a real driver. Based on initial work done by
Mike Turquette.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Cc: Mike Turquette <mturquette@linaro.org>
---
 drivers/clk/Makefile      |    1 +
 drivers/clk/omap/Makefile |    1 +
 drivers/clk/omap/clk.c    |   39 +++++++++++++++++++++++++++++++++++++++
 include/linux/clk/omap.h  |   24 ++++++++++++++++++++++++
 4 files changed, 65 insertions(+)
 create mode 100644 drivers/clk/omap/Makefile
 create mode 100644 drivers/clk/omap/clk.c
 create mode 100644 include/linux/clk/omap.h

diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 4038c2b..d3c3733 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -32,6 +32,7 @@ obj-$(CONFIG_ARCH_VT8500)	+= clk-vt8500.o
 obj-$(CONFIG_ARCH_ZYNQ)		+= zynq/
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
index 0000000..4bf1929
--- /dev/null
+++ b/drivers/clk/omap/clk.c
@@ -0,0 +1,39 @@
+/*
+ * OMAP PRCM clock driver
+ *
+ * Copyright (C) 2013 Texas Instruments, Inc.
+ *     Tero Kristo <t-kristo@ti.com>
+ *     Mike Turquette <mturquette@linaro.org>
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
+#include <linux/of_device.h>
+
+/* FIXME - should the OMAP PRCM clock driver match generic types? */
+static const struct of_device_id clk_match[] = {
+	{.compatible = "fixed-clock", .data = of_fixed_clk_setup, },
+	{.compatible = "mux-clock", .data = of_mux_clk_setup, },
+	{.compatible = "fixed-factor-clock",
+		.data = of_fixed_factor_clk_setup, },
+	{.compatible = "divider-clock", .data = of_divider_clk_setup, },
+	{.compatible = "gate-clock", .data = of_gate_clk_setup, },
+	{},
+};
+
+/* FIXME - need to initialize early; skip real driver registration & probe */
+int __init dt_omap_clk_init(void)
+{
+	of_clk_init(clk_match);
+	return 0;
+}
diff --git a/include/linux/clk/omap.h b/include/linux/clk/omap.h
new file mode 100644
index 0000000..647f02f
--- /dev/null
+++ b/include/linux/clk/omap.h
@@ -0,0 +1,24 @@
+/*
+ * Copyright (C) 2013 Texas Instruments, Inc.
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
1.7.9.5

