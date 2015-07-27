From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v2 1/3] ARM: dts: dra7: Remove ctrl_core and ctrl_general nodes
Date: Mon, 27 Jul 2015 13:27:28 +0300
Message-ID: <1437992850-6008-2-git-send-email-rogerq@ti.com>
References: <1437992850-6008-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1437992850-6008-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: kishon@ti.com, tony@atomide.com
Cc: nm@ti.com, nsekhar@ti.com, balbi@ti.com, grygorii.strashko@ti.com, t-kristo@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

These nodes are wrongly placed. They must come under the
scm node. Nobody uses them either so get rid of them.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 4a0718c..cf2931e 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -286,16 +286,6 @@
 				#thermal-sensor-cells = <1>;
 		};
 
-		dra7_ctrl_core: ctrl_core@4a002000 {
-			compatible = "syscon";
-			reg = <0x4a002000 0x6d0>;
-		};
-
-		dra7_ctrl_general: tisyscon@4a002e00 {
-			compatible = "syscon";
-			reg = <0x4a002e00 0x7c>;
-		};
-
 		sdma: dma-controller@4a056000 {
 			compatible = "ti,omap4430-sdma";
 			reg = <0x4a056000 0x1000>;
-- 
2.1.4
