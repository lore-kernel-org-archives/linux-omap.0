From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 08/17] ARM: dts: am33xx: add reset data
Date: Thu, 24 Sep 2015 17:26:49 +0300
Message-ID: <1443104818-993-9-git-send-email-t-kristo@ti.com>
References: <1443104818-993-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1443104818-993-1-git-send-email-t-kristo@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org, tony@atomide.com, s-anna@ti.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Add reset data for pruss, gfx, wkup-m3, and system reset.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index d23e252..3974c3b 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -110,11 +110,14 @@
 				reg-names = "umem", "dmem";
 				ti,hwmods = "wkup_m3";
 				ti,pm-firmware = "am335x-pm-firmware.elf";
+				reset-names = "wkup_m3";
+				resets = <&prcm 0xd00 0 3 0xc 5>;
 			};
 
 			prcm: prcm@200000 {
 				compatible = "ti,am3-prcm";
 				reg = <0x200000 0x4000>;
+				#reset-cells = <5>;
 
 				prcm_clocks: clocks {
 					#address-cells = <1>;
@@ -123,6 +126,12 @@
 
 				prcm_clockdomains: clockdomains {
 				};
+
+				system_reset: system_reset {
+					compatible = "ti,system-reset";
+					reset-names = "system";
+					resets = <&prcm 0xf00 0 0 8 1>;
+				};
 			};
 
 			scm: scm@210000 {
@@ -879,6 +888,21 @@
 			reg = <0x48310000 0x2000>;
 			interrupts = <111>;
 		};
+
+		pruss: pruss@4a300000 {
+			compatible = "ti,am3352-pruss";
+			ti,hwmods = "pruss";
+			reset-names = "pruss";
+			resets = <&prcm 0xc00 0 1 0 1>;
+		};
+
+		gfx: gfx@56000000 {
+			compatible = "ti,am3352-sgx530", "img,sgx530";
+			ti,hwmods = "gfx";
+			status = "disabled";
+			reset-names = "gfx";
+			resets = <&prcm 0x1100 0x4 0 0x14 0>;
+		};
 	};
 };
 
-- 
1.7.9.5
