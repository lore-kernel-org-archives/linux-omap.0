From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 06/17] ARM: dts: dra7: add reset data
Date: Thu, 24 Sep 2015 17:26:47 +0300
Message-ID: <1443104818-993-7-git-send-email-t-kristo@ti.com>
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

Copy over the reset data from kernel to DT. Currently, only system reset
has been defined, but rest can be added later once needed.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 5d65db9..e299b07 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -199,6 +199,7 @@
 				compatible = "ti,dra7-prm";
 				reg = <0x6000 0x3000>;
 				interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
+				#reset-cells = <5>;
 
 				prm_clocks: clocks {
 					#address-cells = <1>;
@@ -207,6 +208,12 @@
 
 				prm_clockdomains: clockdomains {
 				};
+
+				system_reset: system_reset {
+					compatible = "ti,system-reset";
+					reset-names = "system";
+					resets = <&prm 0x1d00 0 0 4 0>;
+				};
 			};
 		};
 
-- 
1.7.9.5
