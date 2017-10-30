From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 23/27] dt-bindings: clk: add dm814 clkctrl definitions
Date: Mon, 30 Oct 2017 15:04:41 +0200
Message-ID: <1509368685-29112-24-git-send-email-t-kristo@ti.com>
References: <1509368685-29112-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1509368685-29112-1-git-send-email-t-kristo@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: linux-clk@vger.kernel.org, sboyd@codeaurora.org, mturquette@baylibre.com
Cc: linux-omap@vger.kernel.org, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

Contains offsets for all dm814 clkctrl main and optional clocks.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 include/dt-bindings/clock/dm814.h | 45 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 include/dt-bindings/clock/dm814.h

diff --git a/include/dt-bindings/clock/dm814.h b/include/dt-bindings/clock/dm814.h
new file mode 100644
index 0000000..0e7099a
--- /dev/null
+++ b/include/dt-bindings/clock/dm814.h
@@ -0,0 +1,45 @@
+/*
+ * Copyright 2017 Texas Instruments, Inc.
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+#ifndef __DT_BINDINGS_CLK_DM814_H
+#define __DT_BINDINGS_CLK_DM814_H
+
+#define DM814_CLKCTRL_OFFSET	0x0
+#define DM814_CLKCTRL_INDEX(offset)	((offset) - DM814_CLKCTRL_OFFSET)
+
+/* default clocks */
+#define DM814_USB_OTG_HS_CLKCTRL	DM814_CLKCTRL_INDEX(0x58)
+
+/* alwon clocks */
+#define DM814_UART1_CLKCTRL	DM814_CLKCTRL_INDEX(0x150)
+#define DM814_UART2_CLKCTRL	DM814_CLKCTRL_INDEX(0x154)
+#define DM814_UART3_CLKCTRL	DM814_CLKCTRL_INDEX(0x158)
+#define DM814_GPIO1_CLKCTRL	DM814_CLKCTRL_INDEX(0x15c)
+#define DM814_GPIO2_CLKCTRL	DM814_CLKCTRL_INDEX(0x160)
+#define DM814_I2C1_CLKCTRL	DM814_CLKCTRL_INDEX(0x164)
+#define DM814_I2C2_CLKCTRL	DM814_CLKCTRL_INDEX(0x168)
+#define DM814_WD_TIMER_CLKCTRL	DM814_CLKCTRL_INDEX(0x18c)
+#define DM814_MCSPI1_CLKCTRL	DM814_CLKCTRL_INDEX(0x190)
+#define DM814_GPMC_CLKCTRL	DM814_CLKCTRL_INDEX(0x1d0)
+#define DM814_CPGMAC0_CLKCTRL	DM814_CLKCTRL_INDEX(0x1d4)
+#define DM814_MPU_CLKCTRL	DM814_CLKCTRL_INDEX(0x1dc)
+#define DM814_RTC_CLKCTRL	DM814_CLKCTRL_INDEX(0x1f0)
+#define DM814_TPCC_CLKCTRL	DM814_CLKCTRL_INDEX(0x1f4)
+#define DM814_TPTC0_CLKCTRL	DM814_CLKCTRL_INDEX(0x1f8)
+#define DM814_TPTC1_CLKCTRL	DM814_CLKCTRL_INDEX(0x1fc)
+#define DM814_TPTC2_CLKCTRL	DM814_CLKCTRL_INDEX(0x200)
+#define DM814_TPTC3_CLKCTRL	DM814_CLKCTRL_INDEX(0x204)
+#define DM814_MMC1_CLKCTRL	DM814_CLKCTRL_INDEX(0x21c)
+#define DM814_MMC2_CLKCTRL	DM814_CLKCTRL_INDEX(0x220)
+#define DM814_MMC3_CLKCTRL	DM814_CLKCTRL_INDEX(0x224)
+
+#endif
-- 
1.9.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
