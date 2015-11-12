From: Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2 5/5] arm: dts: Add omap4-hwspinlock support in dm816x
Date: Thu, 12 Nov 2015 15:07:49 +0100
Message-ID: <56449D35.1040104@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Brian Hutchinson <b.hutchman@gmail.com>, fisaksen@baylibre.com, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Add dm816x DT entries for omap4-hwspinlock support as hwmod spinbox.

Cc: Brian Hutchinson <b.hutchman@gmail.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/boot/dts/dm816x.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/dm816x.dtsi b/arch/arm/boot/dts/dm816x.dtsi
index b9feeea..eb9bea1 100644
--- a/arch/arm/boot/dts/dm816x.dtsi
+++ b/arch/arm/boot/dts/dm816x.dtsi
@@ -226,6 +226,13 @@
 			};
 		};

+		spinbox: spinbox@480ca000 {
+			compatible = "ti,omap4-hwspinlock";
+			reg = <0x480ca000 0x2000>;
+			ti,hwmods = "spinbox";
+			#hwlock-cells = <1>;
+		};
+
 		mdio: mdio@4a100800 {
 			compatible = "ti,davinci_mdio";
 			#address-cells = <1>;
-- 
1.9.1
