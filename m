From: Sricharan R <r.sricharan@ti.com>
Subject: [PATCH V5 1/3] arm: dts: dra7: Add crossbar device binding
Date: Tue, 6 May 2014 19:26:17 +0530
Message-ID: <1399384579-25620-2-git-send-email-r.sricharan@ti.com>
References: <1399384579-25620-1-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1399384579-25620-1-git-send-email-r.sricharan@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linus.walleij@linaro.org, linux@arm.linux.org.uk, tony@atomide.com, rnayak@ti.com, marc.zyngier@arm.com, grant.likely@linaro.org, mark.rutland@arm.com, tglx@linutronix.de, galak@codeaurora.org, santosh.shilimkar@ti.com, nm@ti.com, bcousson@baylibre.com, robherring2@gmail.com
Cc: Sricharan R <r.sricharan@ti.com>
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
Signed-off-by: Nishanth Menon <nm@ti.com>
---
[V5] Rebased on top of 3.15-rc4 and corrected the
     irqs-reserved list

 arch/arm/boot/dts/dra7.dtsi |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 149b550..0274a86 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -790,6 +790,14 @@
 			status = "disabled";
 		};
 	};
+
+	crossbar_mpu: crossbar@4a020000 {
+		compatible = "ti,irq-crossbar";
+		reg = <0x4a002a48 0x130>;
+		ti,max-irqs = <160>;
+		ti,reg-size = <2>;
+		ti,irqs-reserved = <0 1 2 3 5 6 131 132>;
+	};
 };
 
 /include/ "dra7xx-clocks.dtsi"
-- 
1.7.9.5
