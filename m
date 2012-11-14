From: AnilKumar Ch <anilkumar@ti.com>
Subject: [PATCH 3/3] ARM: dts: AM33XX: Add memory resource to d_can node
Date: Wed, 14 Nov 2012 23:38:25 +0530
Message-ID: <1352916505-12343-4-git-send-email-anilkumar@ti.com>
References: <1352916505-12343-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
In-Reply-To: <1352916505-12343-1-git-send-email-anilkumar@ti.com>
Sender: linux-can-owner@vger.kernel.org
To: wg@grandegger.com, mkl@pengutronix.de
Cc: swarren@wwwdotorg.org, linux-can@vger.kernel.org, tony@atomide.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, grant.likely@secretlab.ca, devicetree-discuss@lists.ozlabs.org, AnilKumar Ch <anilkumar@ti.com>
List-Id: linux-omap@vger.kernel.org

Add a new address space/memory resource to d_can device tree node. D_CAN
RAM initialization is achieved through RAMINIT register which is part of
AM33XX control module address space. D_CAN RAM init or de-init should be
done by writing instance corresponding value to control module register.

Till we have a separate control module driver to write to control module,
d_can driver will handle the register writes to control module by itself.
So a new address space to represent this control module register is added
to d_can driver.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index c92c35f..ea011d6 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -227,7 +227,8 @@
 		dcan0: d_can@481cc000 {
 			compatible = "bosch,d_can";
 			ti,hwmods = "d_can0";
-			reg = <0x481cc000 0x2000>;
+			reg = <0x481cc000 0x2000
+				0x44e10644 0x4>;
 			interrupts = <52>;
 			status = "disabled";
 		};
@@ -235,7 +236,8 @@
 		dcan1: d_can@481d0000 {
 			compatible = "bosch,d_can";
 			ti,hwmods = "d_can1";
-			reg = <0x481d0000 0x2000>;
+			reg = <0x481d0000 0x2000
+				0x44e10644 0x4>;
 			interrupts = <55>;
 			status = "disabled";
 		};
-- 
1.7.9.5

