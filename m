From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCH] DTS: ARM: OMAP3-N900: Add n900-battery support
Date: Sat, 15 Nov 2014 03:08:24 +0100
Message-ID: <1416017304-6879-1-git-send-email-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, linux-omap@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Sebastian Reichel <sre@kernel.org>
List-Id: linux-omap@vger.kernel.org

This adds support for the N900's battery to the
Nokia N900 DTS file.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 arch/arm/boot/dts/omap3-n900.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
index bc82a12..39778e5 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -115,6 +115,12 @@
 		eci-switch-gpios = <&gpio6 22 GPIO_ACTIVE_HIGH>; /* 182 */
 		speaker-amplifier-gpios = <&twl_gpio 7 GPIO_ACTIVE_HIGH>;
 	};
+
+	battery: n900-battery {
+		compatible = "nokia,n900-battery";
+		io-channels = <&twl_madc 0>, <&twl_madc 4>, <&twl_madc 12>;
+		io-channel-names = "temp", "bsi", "vbat";
+	};
 };
 
 &omap3_pmx_core {
-- 
2.1.1
