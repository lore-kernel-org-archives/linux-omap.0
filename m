From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 1/2] ARM: dts: am57xx-beagle-x15: Fix IRQ type for mcp7941x
Date: Wed, 8 Apr 2015 18:56:26 -0500
Message-ID: <1428537387-18776-2-git-send-email-nm@ti.com>
References: <1428537387-18776-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1428537387-18776-1-git-send-email-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>
Cc: Grygorii Strashko <Grygorii.Strashko@linaro.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Grygorii Strashko <Grygorii.Strashko@linaro.org>

The interrupt polarity provided in devicetree is used to configure
the interrupt controller(ARM GIC), however, it seems that we have an
inverter at the GIC boundary inside AM57xx which inverts the signal
input from sys_irq external interrupt source.

Further, as per GIC distributor TRM,
http://infocenter.arm.com/help/topic/com.arm.doc.ddi0438d/BGBHIACJ.html#BABJFCFB
ARM GIC distributor does not support IRQ trigger type
IRQ_TYPE_LEVEL_LOW, and only rising or level high signals.

However, for some reason, the current configuration(which gets ignored
by GIC driver) functions on some platforms, however, on few platforms
results in infinite interrupts hogging the system down.

Switch over to rising edge for GIC configuration which is also aligned
with trigger point from the RTC chip and the internal inversion.

Fixes: 5a0f93c6576a ("ARM: dts: Add am57xx-beagle-x15")
Signed-off-by: Grygorii Strashko <Grygorii.Strashko@linaro.org>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/boot/dts/am57xx-beagle-x15.dts |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am57xx-beagle-x15.dts b/arch/arm/boot/dts/am57xx-beagle-x15.dts
index fe141c47d647..57279e3b439b 100644
--- a/arch/arm/boot/dts/am57xx-beagle-x15.dts
+++ b/arch/arm/boot/dts/am57xx-beagle-x15.dts
@@ -455,7 +455,7 @@
 	mcp_rtc: rtc@6f {
 		compatible = "microchip,mcp7941x";
 		reg = <0x6f>;
-		interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_LOW>;  /* IRQ_SYS_1N */
+		interrupts = <GIC_SPI 2 IRQ_TYPE_EDGE_RISING>;  /* IRQ_SYS_1N */
 
 		pinctrl-names = "default";
 		pinctrl-0 = <&mcp79410_pins_default>;
-- 
1.7.9.5
