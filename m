From: "Derald D. Woods" <woods.technical@gmail.com>
Subject: [PATCH v2 4/4] ARM: dts: omap3-evm: Add DSS {vdds_dsi,vdda_video}-supply references
Date: Mon, 11 Sep 2017 22:46:59 -0500
Message-ID: <20170912034659.13184-5-woods.technical@gmail.com>
References: <20170903003816.5536-1-woods.technical@gmail.com>
 <20170912034659.13184-1-woods.technical@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170912034659.13184-1-woods.technical@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, linux-kernel@vger.kernel.org, "Derald D. Woods" <woods.technical@gmail.com>
List-Id: linux-omap@vger.kernel.org

This commit eliminates two dummy regulator assignments.

Signed-off-by: Derald D. Woods <woods.technical@gmail.com>

---
 arch/arm/boot/dts/omap3-evm-processor-common.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-evm-processor-common.dtsi b/arch/arm/boot/dts/omap3-evm-processor-common.dtsi
index c1fb6ecd5aff..ce7f42f9448c 100644
--- a/arch/arm/boot/dts/omap3-evm-processor-common.dtsi
+++ b/arch/arm/boot/dts/omap3-evm-processor-common.dtsi
@@ -15,6 +15,8 @@
 };
 
 &dss {
+	vdds_dsi-supply = <&vpll2>;
+	vdda_video-supply = <&lcd_3v3>;
 	pinctrl-names = "default";
 	pinctrl-0 = <
 		&dss_dpi_pins1
-- 
2.14.1
