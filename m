From: Sricharan R <r.sricharan@ti.com>
Subject: [PATCH V6 1/2] arm: dts: dra7: Add routable-irqs property for gic node
Date: Wed, 7 May 2014 17:46:37 +0530
Message-ID: <1399464998-23216-2-git-send-email-r.sricharan@ti.com>
References: <1399464998-23216-1-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1399464998-23216-1-git-send-email-r.sricharan@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linus.walleij@linaro.org, linux@arm.linux.org.uk, tony@atomide.com, rnayak@ti.com, marc.zyngier@arm.com, grant.likely@linaro.org, mark.rutland@arm.com, tglx@linutronix.de, galak@codeaurora.org, santosh.shilimkar@ti.com, nm@ti.com, bcousson@baylibre.com, robherring2@gmail.com
Cc: Sricharan R <r.sricharan@ti.com>
List-Id: linux-omap@vger.kernel.org

There is a IRQ crossbar device in the soc, which maps the
irq requests from the peripherals to the mpu interrupt
controller's inputs. The gic provides the support for such
IPs in the form of routable-irqs. So adding the property
here to gic node.

Signed-off-by: Sricharan R <r.sricharan@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
Cc: Benoit Cousson <bcousson@baylibre.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Tested-by: Darren Etheridge <detheridge@ti.com>
Tested-by: Roger Quadros <rogerq@ti.com>
---
[V6] Reordered patch 3 from V5 to patch 1

 arch/arm/boot/dts/dra7.dtsi |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 149b550..52df16a 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -72,6 +72,7 @@
 		compatible = "arm,cortex-a15-gic";
 		interrupt-controller;
 		#interrupt-cells = <3>;
+		arm,routable-irqs = <192>;
 		reg = <0x48211000 0x1000>,
 		      <0x48212000 0x1000>,
 		      <0x48214000 0x2000>,
-- 
1.7.9.5
