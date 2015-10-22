From: Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 4/4] arm: dts: Add omap4-hwspinlock support in dm816x
Date: Thu, 22 Oct 2015 11:19:29 +0200
Message-ID: <5628AA21.5070801@baylibre.com>
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
index 51ad4a9..f655ce1 100644
--- a/arch/arm/boot/dts/dm816x.dtsi
+++ b/arch/arm/boot/dts/dm816x.dtsi
@@ -227,6 +227,13 @@
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
