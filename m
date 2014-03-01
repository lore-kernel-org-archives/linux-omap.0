From: Marek Belisko <marek@goldelico.com>
Subject: [PATCH v2 3/7] ARM: dts: omap3-gta04: Add touchscreen properties
Date: Sat,  1 Mar 2014 14:58:50 +0100
Message-ID: <1393682334-26805-4-git-send-email-marek@goldelico.com>
References: <1393682334-26805-1-git-send-email-marek@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1393682334-26805-1-git-send-email-marek@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: bcousson@baylibre.com, tony@atomide.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, hns@goldelico.com, Marek Belisko <marek@goldelico.com>
List-Id: linux-omap@vger.kernel.org

Gta04 using tcs2007 touchscreen. Add support for that.

Signed-off-by: Marek Belisko <marek@goldelico.com>
---
 arch/arm/boot/dts/omap3-gta04.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-gta04.dts b/arch/arm/boot/dts/omap3-gta04.dts
index d9917b8..7f29315 100644
--- a/arch/arm/boot/dts/omap3-gta04.dts
+++ b/arch/arm/boot/dts/omap3-gta04.dts
@@ -130,6 +130,16 @@
 		compatible = "honeywell,hmc5843";
 		reg = <0x1e>;
 	};
+
+	/* touchscreen */
+	tsc2007@48 {
+		compatible = "ti,tsc2007";
+		reg = <0x48>;
+		interrupt-parent = <&gpio6>;
+		interrupts = <0 IRQ_TYPE_EDGE_FALLING>;
+		gpios = <&gpio6 0 GPIO_ACTIVE_LOW>;
+		ti,x-plate-ohms = <600>;
+	};
 };
 
 &i2c3 {
-- 
1.8.3.2
