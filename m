From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 07/17] ARM: dts: am4372: add reset data
Date: Thu, 24 Sep 2015 17:26:48 +0300
Message-ID: <1443104818-993-8-git-send-email-t-kristo@ti.com>
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

Add reset data for pruss, gfx, wkup-m3 and system reset.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/boot/dts/am4372.dtsi |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index 0447c04a..fcc8d31 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -116,12 +116,15 @@
 				reg-names = "umem", "dmem";
 				ti,hwmods = "wkup_m3";
 				ti,pm-firmware = "am335x-pm-firmware.elf";
+				reset-names = "wkup_m3";
+				resets = <&prcm 0x2000 0x10 3 0x14 5>;
 			};
 
 			prcm: prcm@1f0000 {
 				compatible = "ti,am4-prcm";
 				reg = <0x1f0000 0x11000>;
 				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+				#reset-cells = <5>;
 
 				prcm_clocks: clocks {
 					#address-cells = <1>;
@@ -130,6 +133,12 @@
 
 				prcm_clockdomains: clockdomains {
 				};
+
+				system_reset: system_reset {
+					compatible = "ti,system-reset";
+					reset-names = "system";
+					reset-cells = <&prcm 0x4000 0 0 4 0>;
+				};
 			};
 
 			scm: scm@210000 {
@@ -1053,6 +1062,21 @@
 			ti,hwmods = "vpfe1";
 			status = "disabled";
 		};
+
+		gfx: gfx@56000000 {
+			compatible = "ti,am4376-sgx530", "img,sgx530";
+			ti,hwmods = "gfx";
+			status = "disabled";
+			reset-names = "gfx";
+			resets = <&prcm 0x400 0x10 0 0x14 0>;
+		};
+
+		pruss: pruss@54400000 {
+			compatible = "ti,am4372-pruss";
+			ti,hwmods = "pruss";
+			reset-names = "pruss";
+			resets = <&prcm 0x800 0x10 1 0x14 0>;
+		};
 	};
 };
 
-- 
1.7.9.5
