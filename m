From: Sekhar Nori <nsekhar@ti.com>
Subject: [PATCH] ARM: dts: am57xx-idk: tpic2810 is on I2C bus, not SPI
Date: Wed, 15 Feb 2017 20:42:52 +0530
Message-ID: <f884c250c4142ef44ec0c770aab277803f1f5da3.1487171304.git.nsekhar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>, "Andrew F. Davis" <afd@ti.com>
List-Id: linux-omap@vger.kernel.org

commit 50e95b6b854c ("ARM: dts: am57xx-idk: Add Industrial
output support") added the TPIC2810 device-tree node under
SPI bus instead of I2C1.

Fix it. Tested on AM572x IDK by driving on-board LEDs
connected to TPIC2810

Fixes: 50e95b6b854c ("ARM: dts: am57xx-idk: Add Industrial output support")
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/boot/dts/am57xx-idk-common.dtsi | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/am57xx-idk-common.dtsi b/arch/arm/boot/dts/am57xx-idk-common.dtsi
index 814a720d5c3d..d0a55b845690 100644
--- a/arch/arm/boot/dts/am57xx-idk-common.dtsi
+++ b/arch/arm/boot/dts/am57xx-idk-common.dtsi
@@ -311,6 +311,13 @@
 			/* ID & VBUS GPIOs provided in board dts */
 		};
 	};
+
+	tpic2810: tpic2810@60 {
+		compatible = "ti,tpic2810";
+		reg = <0x60>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
 };
 
 &mcspi3 {
@@ -326,13 +333,6 @@
 		spi-max-frequency = <1000000>;
 		spi-cpol;
 	};
-
-	tpic2810: tpic2810@60 {
-		compatible = "ti,tpic2810";
-		reg = <0x60>;
-		gpio-controller;
-		#gpio-cells = <2>;
-	};
 };
 
 &uart3 {
-- 
2.9.0
