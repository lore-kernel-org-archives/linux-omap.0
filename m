From: Sricharan R <r.sricharan@ti.com>
Subject: [RFC PATCH 3/6] ARM: DTS: DRA: Add crossbar device binding
Date: Mon, 30 Sep 2013 19:29:21 +0530
Message-ID: <1380549564-31045-4-git-send-email-r.sricharan@ti.com>
References: <1380549564-31045-1-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1380549564-31045-1-git-send-email-r.sricharan@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: tglx@linutronix.de, linus.walleij@linaro.org, santosh.shilimkar@ti.com, linux@arm.linux.org.uk, tony@atomide.com, rnayak@ti.com, marc.zyngier@arm.com, r.sricharan@ti.com, grant.likely@linaro.org, rob.herring@calxeda.com, mark.rutland@arm.com, Benoit Cousson <bcousson@baylibre.com>
List-Id: linux-omap@vger.kernel.org

This adds the irq crossbar device node.

There is a IRQ crossbar device in the soc, which
maps the irq requests from the peripherals to the
mpu interrupt controller's inputs. The Peripheral irq
requests are connected to only one crossbar
input and the output of the crossbar is connected to only one
controller's input line. The crossbar device is used to map
a peripheral input to a free mpu's interrupt controller line.

Cc: Benoit Cousson <bcousson@baylibre.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sricharan R <r.sricharan@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index b35cb12..799b7be 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -492,5 +492,14 @@
 			dmas = <&sdma 70>, <&sdma 71>;
 			dma-names = "tx0", "rx0";
 		};
+
+		crossbar_mpu: @4a020000 {
+			compatible = "ti,irq-crossbar";
+			reg = <0x4a002a48 0x130>;
+			max-irqs = <160>;
+			reg-size = <2>;
+			irqs-reserved = <0 1 2 3 5 6 131 132 139 140>;
+		};
+
 	};
 };
-- 
1.7.9.5

