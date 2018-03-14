From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 5/6] ARM: dts: omap5: add fref_xtal_ck support
Date: Wed, 14 Mar 2018 15:53:14 +0200
Message-ID: <20180314135315.11215-6-peter.ujfalusi@ti.com>
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

The clock is directly sourced from sys_clkin, and provides an external
output clock for (typically) TWL6040 chip.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Tested-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/omap54xx-clocks.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/omap54xx-clocks.dtsi b/arch/arm/boot/dts/omap54xx-clocks.dtsi
index 9619a746d657..ecc5573d264c 100644
--- a/arch/arm/boot/dts/omap54xx-clocks.dtsi
+++ b/arch/arm/boot/dts/omap54xx-clocks.dtsi
@@ -1179,3 +1179,13 @@
 		};
 	};
 };
+
+&scm_wkup_pad_conf_clocks {
+	fref_xtal_ck: fref_xtal_ck {
+		#clock-cells = <0>;
+		compatible = "ti,gate-clock";
+		clocks = <&sys_clkin>;
+		ti,bit-shift = <28>;
+		reg = <0x14>;
+	};
+};
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
