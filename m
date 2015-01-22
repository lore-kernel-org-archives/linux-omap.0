From: Marek Belisko <marek@goldelico.com>
Subject: [PATCH 10/13] ARM: dts: omap3-gta04: add gyroscope
Date: Thu, 22 Jan 2015 21:38:16 +0100
Message-ID: <1421959099-28319-11-git-send-email-marek@goldelico.com>
References: <1421959099-28319-1-git-send-email-marek@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1421959099-28319-1-git-send-email-marek@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: bcousson@baylibre.com, tony@atomide.com
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, hns@goldelico.com, neilb@suse.de, NeilBrown <neil@brown.name>
List-Id: linux-omap@vger.kernel.org

From: NeilBrown <neil@brown.name>

Signed-off-by: NeilBrown <neil@brown.name>
---
 arch/arm/boot/dts/omap3-gta04.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index ab5dd98..08f0b25 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -240,6 +240,14 @@
 		interrupts = <19 IRQ_TYPE_LEVEL_HIGH>; /* GPIO_115 */
 	};
 
+	/* gyroscope */
+	itg3200@68 {
+		compatible = "invensense,itg3200";
+		reg = <0x68>;
+		interrupt-parent = <&gpio2>;
+		interrupts = <24 0>; /* GPIO_56 */
+	};
+
 	/* leds */
 	tca6507@45 {
 		compatible = "ti,tca6507";
-- 
1.9.1
