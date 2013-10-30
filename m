From: Sricharan R <r.sricharan@ti.com>
Subject: [PATCH V2 5/7] ARM: DTS: DRA7: Add routable-irqs property for gic node
Date: Wed, 30 Oct 2013 20:27:18 +0530
Message-ID: <1383145040-15852-6-git-send-email-r.sricharan@ti.com>
References: <1383145040-15852-1-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1383145040-15852-1-git-send-email-r.sricharan@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linus.walleij@linaro.org, linux@arm.linux.org.uk, tony@atomide.com, rnayak@ti.com, marc.zyngier@arm.com, grant.likely@linaro.org, mark.rutland@arm.com, robherring2@gmail.com, tglx@linutronix.de, santosh.shilimkar@ti.com, r.sricharan@ti.com
Cc: Benoit Cousson <bcousson@baylibre.com>
List-Id: linux-omap@vger.kernel.org

There is a IRQ crossbar device in the soc, which maps the
irq requests from the peripherals to the mpu interrupt
controller's inputs. The gic provides the support for such
IPs in the form of routable-irqs. So adding the property
here to gic node.

Cc: Benoit Cousson <bcousson@baylibre.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sricharan R <r.sricharan@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index afb89f1..6a5404f 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -59,6 +59,7 @@
 		compatible = "arm,cortex-a15-gic";
 		interrupt-controller;
 		#interrupt-cells = <3>;
+		arm,routable-irqs = <160>;
 		reg = <0x48211000 0x1000>,
 		      <0x48212000 0x1000>,
 		      <0x48214000 0x2000>,
-- 
1.7.9.5
