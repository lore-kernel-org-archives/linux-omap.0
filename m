From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 1/3] ARM: DTS: omap3: Remove mcbsp2/3_sidetone hwmod reference for McBSP2/3
Date: Fri, 18 Mar 2016 16:23:25 +0200
Message-ID: <1458311007-19168-2-git-send-email-peter.ujfalusi@ti.com>
References: <1458311007-19168-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1458311007-19168-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, jarkko.nikula@bitmer.com, paul@pwsan.com
Cc: t-kristo@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The mcbsp2/3_sidetone hwmod is a dummy hwmod and servers as a placeholder
to attach the register address and irq number to the main mcbsp2/3 hwmod.
The hwmod for the McBSP sidetone module is going to be removed from the
kernel.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/omap3.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index b41d07e8e765..d6b7abce7a55 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -507,7 +507,7 @@
 				     <4>;  /* Sidetone */
 			interrupt-names = "common", "tx", "rx", "sidetone";
 			ti,buffer-size = <1280>;
-			ti,hwmods = "mcbsp2", "mcbsp2_sidetone";
+			ti,hwmods = "mcbsp2";
 			dmas = <&sdma 33>,
 			       <&sdma 34>;
 			dma-names = "tx", "rx";
@@ -525,7 +525,7 @@
 				     <5>;  /* Sidetone */
 			interrupt-names = "common", "tx", "rx", "sidetone";
 			ti,buffer-size = <128>;
-			ti,hwmods = "mcbsp3", "mcbsp3_sidetone";
+			ti,hwmods = "mcbsp3";
 			dmas = <&sdma 17>,
 			       <&sdma 18>;
 			dma-names = "tx", "rx";
-- 
2.7.3
