From: Milo Kim <woogyom.kim@gmail.com>
Subject: [PATCH v2 8/8] mfd: tps65217: Fix mismatched interrupt number
Date: Fri, 28 Oct 2016 21:37:02 +0900
Message-ID: <20161028123702.21849-9-woogyom.kim@gmail.com>
References: <20161028123702.21849-1-woogyom.kim@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161028123702.21849-1-woogyom.kim@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: bcousson@baylibre.com, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Robert Nelson <robertcnelson@gmail.com>, Milo Kim <woogyom.kim@gmail.com>
List-Id: linux-omap@vger.kernel.org

Enum value of 'tps65217_irq_type' is not matched with DT parsed hwirq
number[*].

The MFD driver gets the IRQ data by referencing hwirq, but the value is
different. So, irq_to_tps65217_irq() returns mismatched IRQ data.
Eventually, the power button driver enables not PB but USB interrupt
when it is probed.

According to the TPS65217 register map[**], USB interrupt is the LSB.
This patch defines synchronized IRQ value.

[*]  include/dt-bindings/mfd/tps65217.h
[**] http://www.ti.com/lit/ds/symlink/tps65217.pdf

Signed-off-by: Milo Kim <woogyom.kim@gmail.com>
---
 include/linux/mfd/tps65217.h | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/include/linux/mfd/tps65217.h b/include/linux/mfd/tps65217.h
index 4ccda89..3cbec4b 100644
--- a/include/linux/mfd/tps65217.h
+++ b/include/linux/mfd/tps65217.h
@@ -234,12 +234,11 @@ struct tps65217_bl_pdata {
 	int dft_brightness;
 };
 
-enum tps65217_irq_type {
-	TPS65217_IRQ_PB,
-	TPS65217_IRQ_AC,
-	TPS65217_IRQ_USB,
-	TPS65217_NUM_IRQ
-};
+/* Interrupt numbers */
+#define TPS65217_IRQ_USB		0
+#define TPS65217_IRQ_AC			1
+#define TPS65217_IRQ_PB			2
+#define TPS65217_NUM_IRQ		3
 
 /**
  * struct tps65217_board - packages regulator init data
-- 
2.9.3
