From: Nishanth Menon <nm@ti.com>
Subject: [PATCH V2] ARM: dts: OMAP5: Add device nodes for ABB
Date: Thu, 5 Jun 2014 20:11:12 -0500
Message-ID: <1402017072-12599-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37599 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751693AbaFFBL4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Jun 2014 21:11:56 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nm@ti.com

From: "Andrii.Tseglytskyi" <andrii.tseglytskyi@ti.com>

Add ABB device nodes for OMAP5 family of devices. Data is based on
final production OMAP543x Technical Reference Manual revision Z (April 2013).
Final production Data Manual for OMAP5432 SWPS050F(APRIL 2014).

[nm@ti.com: co-developer and updates to latest documentation]
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Andrii.Tseglytskyi <andrii.tseglytskyi@ti.com>
---
Original patch (v1): https://patchwork.kernel.org/patch/3555191/

Rest of the series was accepted, however, I had to drop this
previously to ensure that the data we introduce is compatible with
production samples and existing pre-production samples on various
OMAP5uEVMs already in circulation.

 arch/arm/boot/dts/omap5.dtsi |   60 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index a4ed549..8eee6fb 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -985,6 +985,66 @@
 				dma-names = "audio_tx";
 			};
 		};
+
+		abb_mpu: regulator-abb-mpu {
+			compatible = "ti,abb-v2";
+			regulator-name = "abb_mpu";
+			#address-cells = <0>;
+			#size-cells = <0>;
+			clocks = <&sys_clkin>;
+			ti,settling-time = <50>;
+			ti,clock-cycles = <16>;
+
+			reg = <0x4ae07cdc 0x8>, <0x4ae06014 0x4>,
+			      <0x4a0021c4 0x8>, <0x4ae0c318 0x4>;
+			reg-names = "base-address", "int-address",
+				    "efuse-address", "ldo-address";
+			ti,tranxdone-status-mask = <0x80>;
+			/* LDOVBBMPU_MUX_CTRL */
+			ti,ldovbb-override-mask = <0x400>;
+			/* LDOVBBMPU_VSET_OUT */
+			ti,ldovbb-vset-mask = <0x1F>;
+
+			/*
+			 * NOTE: only FBB mode used but actual vset will
+			 * determine final biasing
+			 */
+			ti,abb_info = <
+			/*uV		ABB	efuse	rbb_m fbb_m	vset_m*/
+			1060000		0	0x0	0 0x02000000 0x01F00000
+			1250000		0	0x4	0 0x02000000 0x01F00000
+			>;
+		};
+
+		abb_mm: regulator-abb-mm {
+			compatible = "ti,abb-v2";
+			regulator-name = "abb_mm";
+			#address-cells = <0>;
+			#size-cells = <0>;
+			clocks = <&sys_clkin>;
+			ti,settling-time = <50>;
+			ti,clock-cycles = <16>;
+
+			reg = <0x4ae07ce4 0x8>, <0x4ae06010 0x4>,
+			      <0x4a0021a4 0x8>, <0x4ae0c314 0x4>;
+			reg-names = "base-address", "int-address",
+				    "efuse-address", "ldo-address";
+			ti,tranxdone-status-mask = <0x80000000>;
+			/* LDOVBBMM_MUX_CTRL */
+			ti,ldovbb-override-mask = <0x400>;
+			/* LDOVBBMM_VSET_OUT */
+			ti,ldovbb-vset-mask = <0x1F>;
+
+			/*
+			 * NOTE: only FBB mode used but actual vset will
+			 * determine final biasing
+			 */
+			ti,abb_info = <
+			/*uV		ABB	efuse	rbb_m fbb_m	vset_m*/
+			1025000		0	0x0	0 0x02000000 0x01F00000
+			1120000		0	0x4	0 0x02000000 0x01F00000
+			>;
+		};
 	};
 };
 
-- 
1.7.9.5

