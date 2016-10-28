From: Milo Kim <woogyom.kim@gmail.com>
Subject: [PATCH v2 5/8] dt-bindings: mfd: Provide human readable defines for TPS65217 interrupts
Date: Fri, 28 Oct 2016 21:36:59 +0900
Message-ID: <20161028123702.21849-6-woogyom.kim@gmail.com>
References: <20161028123702.21849-1-woogyom.kim@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161028123702.21849-1-woogyom.kim@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: bcousson@baylibre.com, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Robert Nelson <robertcnelson@gmail.com>, Milo Kim <woogyom.kim@gmail.com>
List-Id: linux-omap@vger.kernel.org

TPS65217 supports three interrupt sources. This patch enables assigning
each IRQ number in the charger and power button node. Then corresponding
IRQ will be requested by each driver.

Signed-off-by: Milo Kim <woogyom.kim@gmail.com>
---
 include/dt-bindings/mfd/tps65217.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 include/dt-bindings/mfd/tps65217.h

diff --git a/include/dt-bindings/mfd/tps65217.h b/include/dt-bindings/mfd/tps65217.h
new file mode 100644
index 0000000..cafb9e6
--- /dev/null
+++ b/include/dt-bindings/mfd/tps65217.h
@@ -0,0 +1,26 @@
+/*
+ * This header provides macros for TI TPS65217 DT bindings.
+ *
+ * Copyright (C) 2016 Texas Instruments
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef __DT_BINDINGS_TPS65217_H__
+#define __DT_BINDINGS_TPS65217_H__
+
+#define TPS65217_IRQ_USB	0
+#define TPS65217_IRQ_AC		1
+#define TPS65217_IRQ_PB		2
+
+#endif
-- 
2.9.3
