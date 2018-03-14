From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 3/6] ARM: dts: omap5: add support for control module wkup
 pad config
Date: Wed, 14 Mar 2018 15:53:12 +0200
Message-ID: <20180314135315.11215-4-peter.ujfalusi@ti.com>
References: <20180314135315.11215-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180314135315.11215-1-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: tony@atomide.com, t-kristo@ti.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

From: Tero Kristo <t-kristo@ti.com>

The pad configuration area under control module wkup has some miscellaneous
config registers, that are not pinmux related. Add a separate area for
these, and add support for syscon / clocks under this new area.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Tested-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/omap5.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 511606c17a04..732b61a0e990 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -287,6 +287,28 @@
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
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
