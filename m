From: Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2 4/5] arm: dts: remove dm816x invalid DT l3_main hwmod
Date: Thu, 12 Nov 2015 15:07:45 +0100
Message-ID: <56449D31.7010801@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Brian Hutchinson <b.hutchman@gmail.com>, fisaksen@baylibre.com, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Remove invalid l3_main hwmod entry from dm816x DT ocp node.

Cc: Brian Hutchinson <b.hutchman@gmail.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/boot/dts/dm816x.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/dm816x.dtsi b/arch/arm/boot/dts/dm816x.dtsi
index 51ad4a9..b9feeea 100644
--- a/arch/arm/boot/dts/dm816x.dtsi
+++ b/arch/arm/boot/dts/dm816x.dtsi
@@ -64,7 +64,6 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges;
-		ti,hwmods = "l3_main";

 		prcm: prcm@48180000 {
 			compatible = "ti,dm816-prcm";
-- 
1.9.1
