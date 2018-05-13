From: =?UTF-8?q?Hern=C3=A1n=20Gonzalez?= <hernan@vanguardiasur.com.ar>
Subject: [PATCH] ARM: dts: am335x-boneblue: Use IRQ_TYPE specifier
Date: Sun, 13 May 2018 20:19:56 -0300
Message-ID: <1526253596-3468-1-git-send-email-hernan@vanguardiasur.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: bcousson@baylibre.com
Cc: tony@atomide.com, robh+dt@kernel.org, mark.rutland@arm.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Hern=C3=A1n=20Gonzalez?= <hernan@vanguardiasur.com.ar>
List-Id: linux-omap@vger.kernel.org

GPIO_ACTIVE_LOW was being used to specify an interrupt, use
IRQ_TYPE_EDGE_RISING instead. This improves DT readability.

Signed-off-by: Hernán Gonzalez <hernan@vanguardiasur.com.ar>
---
 arch/arm/boot/dts/am335x-boneblue.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am335x-boneblue.dts b/arch/arm/boot/dts/am335x-boneblue.dts
index 58baee1..7bcd726 100644
--- a/arch/arm/boot/dts/am335x-boneblue.dts
+++ b/arch/arm/boot/dts/am335x-boneblue.dts
@@ -364,7 +364,7 @@
 		compatible = "invensense,mpu9250";
 		reg = <0x68>;
 		interrupt-parent = <&gpio3>;
-		interrupts = <21 GPIO_ACTIVE_LOW>;
+		interrupts = <21 IRQ_TYPE_EDGE_RISING>;
 		i2c-gate {
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
2.7.4
