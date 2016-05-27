From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH 1/2] ARM: dts: am437x-idk-evm: Mark MAC as having only one PHY
Date: Fri, 27 May 2016 13:17:42 -0500
Message-ID: <20160527181743.8401-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, "Andrew F . Davis" <afd@ti.com>
List-Id: linux-omap@vger.kernel.org

Currently am4372.dtsi declares the MAC controller to have two
slave ports, on this board we only use one, so set the slave
count to one. This eliminates a console error message when
the non-existent PHY is not detected.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 arch/arm/boot/dts/am437x-idk-evm.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/am437x-idk-evm.dts b/arch/arm/boot/dts/am437x-idk-evm.dts
index 76dcfc6..12a6951 100644
--- a/arch/arm/boot/dts/am437x-idk-evm.dts
+++ b/arch/arm/boot/dts/am437x-idk-evm.dts
@@ -382,6 +382,7 @@
 };
 
 &mac {
+	slaves = <1>;
 	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&cpsw_default>;
 	pinctrl-1 = <&cpsw_sleep>;
-- 
2.8.3
