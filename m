From: George Cherian <george.cherian@ti.com>
Subject: [PATCH] arm: dts: am33xx: Add mmc nodes for am33xx platform
Date: Fri, 6 Sep 2013 13:51:52 +0530
Message-ID: <1378455712-17379-1-git-send-email-george.cherian@ti.com>
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
To: linux-omap@vger.kernel.org, devicetree@vger.kernel.org
Cc: mark.rutland@arm.com, George Cherian <george.cherian@ti.com>, linux@arm.linux.org.uk, pawel.moll@arm.com, swarren@wwwdotorg.org, tony@atomide.com, ijc+devicetree@hellion.org.uk, linux-kernel@vger.kernel.org, rob.herring@calxeda.com, bcousson@baylibre.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Add mmc nodes for am33xx platforms

Signed-off-by: George Cherian <george.cherian@ti.com>
---
Verified after applying [1] and [2]
[1] - [PATCH v4 0/6] dma: edma: Support scatter-lists of any length - https://lkml.org/lkml/2013/8/29/466
[2] - [PATCH v2] ARM: dts: add AM33XX EDMA support - https://lkml.org/lkml/2013/8/26/57
 arch/arm/boot/dts/am33xx.dtsi | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index b0badff..1df512d 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -236,6 +236,41 @@
 			status = "disabled";
 		};
 
+		mmc1: mmc@48061000 {
+			compatible = "ti,omap4-hsmmc";
+			reg = <0x48060000 0x1000>;
+			interrupts = <64>;
+			ti,hwmods = "mmc1";
+			ti,dual-volt;
+			ti,needs-special-reset;
+			ti,needs-special-hs-handling;
+			dmas = <&edma 24
+				&edma 25>;
+			dma-names = "tx", "rx";
+			status = "disabled";
+		};
+
+		mmc2: mmc@481d8000 {
+			compatible = "ti,omap4-hsmmc";
+			reg = <0x481d8000 0x1000>;
+			interrupts = <28>;
+			ti,hwmods = "mmc2";
+			ti,needs-special-reset;
+			dmas = <&edma 2
+				&edma 3>;
+			dma-names = "tx", "rx";
+			status = "disabled";
+		};
+
+		mmc3: mmc@47810000 {
+			compatible = "ti,omap4-hsmmc";
+			reg = <0x47810000 0x1000>;
+			interrupts = <29>;
+			ti,hwmods = "mmc3";
+			ti,needs-special-reset;
+			status = "disabled";
+		};
+
 		wdt2: wdt@44e35000 {
 			compatible = "ti,omap3-wdt";
 			ti,hwmods = "wd_timer2";
-- 
1.8.1.4
