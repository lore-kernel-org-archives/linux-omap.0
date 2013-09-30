From: Nishanth Menon <nm@ti.com>
Subject: [PATCH V2] ARM: dts: am335x-boneblack: move fixed regulator to board
 level
Date: Mon, 30 Sep 2013 09:40:16 -0500
Message-ID: <1380552016-23904-1-git-send-email-nm@ti.com>
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
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org, Joel Fernandes <joelf@ti.com>, Koen Kooi <koen@dominion.thruhere.net>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

3.3V fixed regulator does not belong to TPS node - as a result
the fixed regulator is never probed and MMC is continually deferred due
to lack of regulator.

Move the fixed regulator to be at root of platform.

Cc: Joel Fernandes <joelf@ti.com>
Cc: Sekhar Nori <nsekhar@ti.com>
Cc: Koen Kooi <koen@dominion.thruhere.net>

Signed-off-by: Nishanth Menon <nm@ti.com>
Tested-by: Felipe Balbi <balbi@ti.com>
Tested-by: Balaji T K <balajitk@ti.com>
---
V2: no changes - just rebase (carry forward of tested-bys)
V1: https://patchwork.kernel.org/patch/2912711/

Based on: (benoit's for_3.13/dts branch
Commit 45646cda707f13fe4a462bf3148f5178f817ef58)
https://git.kernel.org/cgit/linux/kernel/git/bcousson/linux-omap-dt.git/log/?h=for_3.13/dts
 +
https://patchwork.kernel.org/patch/2902711/

Test Log:
Before: http://pastebin.com/jAabNAcS
After: http://pastebin.com/pDZJKSvW
 arch/arm/boot/dts/am335x-bone-common.dtsi |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi b/arch/arm/boot/dts/am335x-bone-common.dtsi
index ff5c3ca..b3e6fcf 100644
--- a/arch/arm/boot/dts/am335x-bone-common.dtsi
+++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
@@ -55,6 +55,13 @@
 			default-state = "off";
 		};
 	};
+
+	vmmcsd_fixed: fixedregulator@0 {
+		compatible = "regulator-fixed";
+		regulator-name = "vmmcsd_fixed";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
 };
 
 &am33xx_pinmux {
@@ -257,13 +264,6 @@
 			regulator-always-on;
 		};
 	};
-
-	vmmcsd_fixed: fixedregulator@0 {
-		compatible = "regulator-fixed";
-		regulator-name = "vmmcsd_fixed";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-	};
 };
 
 &cpsw_emac0 {
-- 
1.7.9.5
