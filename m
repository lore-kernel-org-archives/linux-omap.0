From: Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH] ARM: dts: omap3-gta04: add pulldown/up settings for twl4030 gpio
Date: Mon, 24 Sep 2018 19:29:57 +0200
Message-ID: <20180924172957.20366-1-andreas@kemnade.info>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>
Cc: Andreas Kemnade <andreas@kemnade.info>
List-Id: linux-omap@vger.kernel.org

Pullup and down settings were missing, so add them to avoid
floating pins and make headset detection working.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 arch/arm/boot/dts/omap3-gta04.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index 09e45e7ad4bc..6bcb459c1b20 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -657,6 +657,19 @@
 	status = "disabled";
 };
 
+#define BIT(x) (1 << (x))
+&twl_gpio {
+	/* pullups: BIT(2) */
+	ti,pullups = <BIT(2)>;
+	/*
+	 * pulldowns:
+	 * BIT(0),  BIT(1), BIT(6), BIT(7), BIT(8), BIT(13)
+	 * BIT(15), BIT(16), BIT(17)
+	 */
+	ti,pulldowns = <(BIT(0) | BIT(1) | BIT(6) | BIT(7) | BIT(8) |
+			 BIT(13) | BIT(15) | BIT(16) | BIT(17))>;
+};
+
 &twl_keypad {
 	status = "disabled";
 };
-- 
2.11.0
