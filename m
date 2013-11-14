From: Sricharan R <r.sricharan@ti.com>
Subject: [PATCH V4 1/3] ARM: DTS: DRA7: Add crossbar device binding
Date: Thu, 14 Nov 2013 17:55:25 +0530
Message-ID: <1384431928-2328-2-git-send-email-r.sricharan@ti.com>
References: <1384431928-2328-1-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1384431928-2328-1-git-send-email-r.sricharan@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: r.sricharan@ti.com, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linus.walleij@linaro.org, linux@arm.linux.org.uk, tony@atomide.com, rnayak@ti.com, marc.zyngier@arm.com, grant.likely@linaro.org, mark.rutland@arm.com, robherring2@gmail.com, tglx@linutronix.de, galak@codeaurora.org, rob.herring@calxeda.com, santosh.shilimkar@ti.com, nm@ti.com, bcousson@baylibre.com
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
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index d0df4c4..cf0d6ca 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -583,4 +583,12 @@
 			status = "disabled";
 		};
 	};
+
+	crossbar_mpu: crossbar@4a020000 {
+		compatible = "ti,irq-crossbar";
+		reg = <0x4a002a48 0x130>;
+		ti,max-irqs = <160>;
+		ti,reg-size = <2>;
+		ti,irqs-reserved = <0 1 2 3 5 6 131 132 139 140>;
+	};
 };
-- 
1.7.9.5

