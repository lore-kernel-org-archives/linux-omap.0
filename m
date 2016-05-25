From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v4 2/7] ARM: dts: omap3: Add clocks to McBSP nodes
Date: Wed, 25 May 2016 17:20:56 +0300
Message-ID: <1464186061-28639-3-git-send-email-peter.ujfalusi@ti.com>
References: <1464186061-28639-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464186061-28639-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, jarkko.nikula@bitmer.com, paul@pwsan.com, lgirdwood@gmail.com, broonie@kernel.org
Cc: t-kristo@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: linux-omap@vger.kernel.org

Add clock properties to the McBSP nodes. McBSP2 and 3 need to have ick also
since the Sidetone block of these modules are operating using the McBSP
interface clock.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/omap3.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index 9fbda38528dc..4c3c471d2a83 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -493,6 +493,8 @@
 			dmas = <&sdma 31>,
 			       <&sdma 32>;
 			dma-names = "tx", "rx";
+			clocks = <&mcbsp1_fck>;
+			clock-names = "fck";
 			status = "disabled";
 		};
 
@@ -511,6 +513,8 @@
 			dmas = <&sdma 33>,
 			       <&sdma 34>;
 			dma-names = "tx", "rx";
+			clocks = <&mcbsp2_fck>, <&mcbsp2_ick>;
+			clock-names = "fck", "ick";
 			status = "disabled";
 		};
 
@@ -529,6 +533,8 @@
 			dmas = <&sdma 17>,
 			       <&sdma 18>;
 			dma-names = "tx", "rx";
+			clocks = <&mcbsp3_fck>, <&mcbsp3_ick>;
+			clock-names = "fck", "ick";
 			status = "disabled";
 		};
 
@@ -545,6 +551,8 @@
 			dmas = <&sdma 19>,
 			       <&sdma 20>;
 			dma-names = "tx", "rx";
+			clocks = <&mcbsp4_fck>;
+			clock-names = "fck";
 			status = "disabled";
 		};
 
@@ -561,6 +569,8 @@
 			dmas = <&sdma 21>,
 			       <&sdma 22>;
 			dma-names = "tx", "rx";
+			clocks = <&mcbsp5_fck>;
+			clock-names = "fck";
 			status = "disabled";
 		};
 
-- 
2.8.2
