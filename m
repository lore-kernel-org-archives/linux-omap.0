From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH v3 2/3] ARM: dts: AM33xx: Update and move wkup_m3 node to l4 node
Date: Wed, 1 Apr 2015 14:47:09 -0500
Message-ID: <1427917630-43961-3-git-send-email-d-gerlach@ti.com>
References: <1427917630-43961-1-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1427917630-43961-1-git-send-email-d-gerlach@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Suman Anna <s-anna@ti.com>, Kevin Hilman <khilman@linaro.org>, Tony Lindgren <tony@atomide.com>, Dave Gerlach <d-gerlach@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Suman Anna <s-anna@ti.com>

The WakeupM3 remote processor device node has been moved to
be a child node of the newly created l4_wkup node, to reflect
its presence properly within the SoC. The node was added
previously before any driver support, it is now updated as
per the wkup_m3_rproc bindings added alongside the driver
support.

Signed-off-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 21fcc44..4c1b4a8 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -103,6 +103,15 @@
 			#size-cells = <1>;
 			ranges = <0 0x44c00000 0x280000>;
 
+			wkup_m3: wkup_m3@100000 {
+				compatible = "ti,am3352-wkup-m3";
+				reg = <0x100000 0x4000>,
+				      <0x180000	0x2000>;
+				reg-names = "umem", "dmem";
+				ti,hwmods = "wkup_m3";
+				ti,pm-firmware = "am335x-pm-firmware.elf";
+			};
+
 			prcm: prcm@200000 {
 				compatible = "ti,am3-prcm";
 				reg = <0x200000 0x4000>;
@@ -762,14 +771,6 @@
 			reg = <0x40300000 0x10000>; /* 64k */
 		};
 
-		wkup_m3: wkup_m3@44d00000 {
-			compatible = "ti,am3353-wkup-m3";
-			reg = <0x44d00000 0x4000	/* M3 UMEM */
-			       0x44d80000 0x2000>;	/* M3 DMEM */
-			ti,hwmods = "wkup_m3";
-			ti,no-reset-on-init;
-		};
-
 		elm: elm@48080000 {
 			compatible = "ti,am3352-elm";
 			reg = <0x48080000 0x2000>;
-- 
2.3.0
