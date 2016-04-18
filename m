From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 1/2] ARM: dts: omap5-board-common: fix ldo1_reg and ldo4_reg
 ranges
Date: Mon, 18 Apr 2016 13:06:06 +0300
Message-ID: <1460973967-25077-1-git-send-email-tomi.valkeinen@ti.com>
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
Cc: Tero Kristo <t-kristo@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Mark Brown <broonie@kernel.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

ldo4_reg is connected to DSS, and should always be 1.8V. However the
The dts defines a range of 1.5V-1.8V, which requires somethings to set
the actual voltage at runtime. Currently we set the voltage in omapdss
driver.

As the voltage must always be 1.8V, let's just define the range to 1.8V
so that the driver doesn't need to deal with the voltage. In fact, the
driver should not touch the voltage, except in the cases where the
voltage needs to be changed at runtime.

I presume the situation is the same for ldo1_reg, used for CSI, although
I think it is not currently used in the mainline.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/boot/dts/omap5-board-common.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/omap5-board-common.dtsi b/arch/arm/boot/dts/omap5-board-common.dtsi
index 902657d6713b..914bf4c47404 100644
--- a/arch/arm/boot/dts/omap5-board-common.dtsi
+++ b/arch/arm/boot/dts/omap5-board-common.dtsi
@@ -472,7 +472,7 @@
 				ldo1_reg: ldo1 {
 					/* VDDAPHY_CAM: vdda_csiport */
 					regulator-name = "ldo1";
-					regulator-min-microvolt = <1500000>;
+					regulator-min-microvolt = <1800000>;
 					regulator-max-microvolt = <1800000>;
 				};
 
@@ -498,7 +498,7 @@
 				ldo4_reg: ldo4 {
 					/* VDDAPHY_DISP: vdda_dsiport/hdmi */
 					regulator-name = "ldo4";
-					regulator-min-microvolt = <1500000>;
+					regulator-min-microvolt = <1800000>;
 					regulator-max-microvolt = <1800000>;
 				};
 
-- 
2.5.0
