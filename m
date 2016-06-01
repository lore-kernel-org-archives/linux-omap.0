From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 2/5] ARM: dts: omap5: add support for control module wkup pad
 config
Date: Wed, 1 Jun 2016 20:35:23 +0300
Message-ID: <1464802526-16372-3-git-send-email-t-kristo@ti.com>
References: <1464802526-16372-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1464802526-16372-1-git-send-email-t-kristo@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org, tony@atomide.com, peter.ujfalusi@ti.com
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The pad configuration area under control module wkup has some miscellaneous
config registers, that are not pinmux related. Add a separate area for
these, and add support for syscon / clocks under this new area.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 .../devicetree/bindings/arm/omap/ctrl.txt          |  1 +
 arch/arm/boot/dts/omap5.dtsi                       | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/omap/ctrl.txt b/Documentation/devicetree/bindings/arm/omap/ctrl.txt
index 3a4e590..33e459e 100644
--- a/Documentation/devicetree/bindings/arm/omap/ctrl.txt
+++ b/Documentation/devicetree/bindings/arm/omap/ctrl.txt
@@ -23,6 +23,7 @@ Required properties:
 		"ti,omap4-scm-padconf-core"
 		"ti,omap5-scm-core"
 		"ti,omap5-scm-padconf-core"
+		"ti,omap5-scm-wkup-pad-conf"
 		"ti,dra7-scm-core"
 - reg:		Contains Control Module register address range
 		(base address and length)
diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 84c1019..6fef4fa 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -277,6 +277,28 @@
 				pinctrl-single,register-width = <16>;
 				pinctrl-single,function-mask = <0x7fff>;
 			};
+
+			omap5_scm_wkup_pad_conf: omap5_scm_wkup_pad_conf@cda0 {
+				compatible = "ti,omap5-scm-wkup-pad-conf",
+					     "simple-bus";
+				reg = <0xcda0 0x60>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0 0xcda0 0x60>;
+
+				scm_wkup_pad_conf: scm_conf@0 {
+					compatible = "syscon", "simple-bus";
+					reg = <0x0 0x60>;
+					#address-cells = <1>;
+					#size-cells = <1>;
+					ranges = <0 0x0 0x60>;
+
+					scm_wkup_pad_conf_clocks: clocks@0 {
+						#address-cells = <1>;
+						#size-cells = <0>;
+					};
+				};
+			};
 		};
 
 		ocmcram: ocmcram@40300000 {
-- 
1.9.1
