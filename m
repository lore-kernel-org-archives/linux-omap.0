From: Sricharan R <r.sricharan@ti.com>
Subject: [RFC PATCH 2/4] ARM: DTS: DRA: Add crossbar device binding
Date: Thu, 12 Sep 2013 21:09:09 +0530
Message-ID: <1379000351-15672-3-git-send-email-r.sricharan@ti.com>
References: <1379000351-15672-1-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1379000351-15672-1-git-send-email-r.sricharan@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: linux@arm.linux.org.uk, tony@atomide.com, linus.walleij@linaro.org, rnayak@ti.com, r.sricharan@ti.com, santosh.shilimkar@ti.com, tglx@linutronix.de
List-Id: linux-omap@vger.kernel.org

This adds the irq crossbar device node.

There is a IRQ crossbar device in the soc, which
maps the irq requests from the peripherals to the
mpu interrupt controller's inputs. The Peripheral irq
requests are connected to only one crossbar
input and the output of the crossbar is connected to only one
controller's input line. This models the crossbar as an interrupt
controller. This a cascaded irqchip where the peripheral interrupt
lines are connected to the crossbar and the crossbar's outputs
are in turn connected to the GIC.

Signed-off-by: Sricharan R <r.sricharan@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index a5d9350..da977e1 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -84,6 +84,7 @@
 		#size-cells = <1>;
 		ranges;
 		ti,hwmods = "l3_main_1", "l3_main_2";
+		interrupt-parent = <&crossbar_mpu>;
 
 		counter32k: counter@4ae04000 {
 			compatible = "ti,omap-counter32k";
@@ -491,5 +492,20 @@
 			dmas = <&sdma 70>, <&sdma 71>;
 			dma-names = "tx0", "rx0";
 		};
+
+		crossbar_mpu: @4a020000 {
+			compatible = "crossbar-irqchip";
+			interrupt-parent = <&gic>;
+			interrupt-controller;
+			#interrupt-cells = <3>;
+			reg = <0x4a002a48 0x130>;
+			max-crossbar-lines = <512>;
+			max-irqs = <160>;
+			reg-size = <2>;
+			irqs-reserved = <0 1 2 3 5 6 131 132 139 140>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+		};
+
 	};
 };
-- 
1.7.9.5
