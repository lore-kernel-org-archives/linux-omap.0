From: Felix Brack <fb@ltec.ch>
Subject: [PATCH] ARM: dts: am33xx: Fix syntax of alias names
Date: Mon, 11 Jun 2018 16:45:53 +0200
Message-ID: <1528728353-5889-1-git-send-email-fb@ltec.ch>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: bcousson@baylibre.com, tony@atomide.com, robh+dt@kernel.org, mark.rutland@arm.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, fb@ltec.ch
List-Id: linux-omap@vger.kernel.org

DT specifications do not allow the underscore character in alias names.
Replace all underscores in alias names by dashes.

Signed-off-by: Felix Brack <fb@ltec.ch>
---
 arch/arm/boot/dts/am33xx.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 9cd62bc2..d3dd6a1 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -29,8 +29,8 @@
 		serial3 = &uart3;
 		serial4 = &uart4;
 		serial5 = &uart5;
-		d_can0 = &dcan0;
-		d_can1 = &dcan1;
+		d-can0 = &dcan0;
+		d-can1 = &dcan1;
 		usb0 = &usb0;
 		usb1 = &usb1;
 		phy0 = &usb0_phy;
-- 
2.7.4
