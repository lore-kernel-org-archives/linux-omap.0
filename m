From: Milo Kim <woogyom.kim@gmail.com>
Subject: [PATCH 7/7] mfd: tps65217: Fix mismatched interrupt number
Date: Fri, 21 Oct 2016 23:01:06 +0900
Message-ID: <20161021140106.21531-8-woogyom.kim@gmail.com>
References: <20161021140106.21531-1-woogyom.kim@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161021140106.21531-1-woogyom.kim@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: bcousson@baylibre.com, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Milo Kim <woogyom.kim@gmail.com>
List-Id: linux-omap@vger.kernel.org

Enum value of 'tps65217_irq_type' is not matched with DT parsed hwirq
number[*].

The MFD driver gets the IRQ data by referencing hwirq, but the value is
different. So, irq_to_tps65217_irq() returns mismatched IRQ data.
Eventually, the power button driver enables not PB but USB interrupt
when it is probed.

According to the TPS65217 register map[**], USB interrupt is the LSB.
This patch synchronizes TPS65217 IRQ index.

[*]  include/dt-bindings/mfd/tps65217.h
[**] http://www.ti.com/lit/ds/symlink/tps65217.pdf

Signed-off-by: Milo Kim <woogyom.kim@gmail.com>
---
 include/linux/mfd/tps65217.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/mfd/tps65217.h b/include/linux/mfd/tps65217.h
index 4ccda89..75a3a5f 100644
--- a/include/linux/mfd/tps65217.h
+++ b/include/linux/mfd/tps65217.h
@@ -235,9 +235,9 @@ struct tps65217_bl_pdata {
 };
 
 enum tps65217_irq_type {
-	TPS65217_IRQ_PB,
-	TPS65217_IRQ_AC,
 	TPS65217_IRQ_USB,
+	TPS65217_IRQ_AC,
+	TPS65217_IRQ_PB,
 	TPS65217_NUM_IRQ
 };
 
-- 
2.9.3
