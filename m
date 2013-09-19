From: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v3 10/11] ARM/dts: am33xx: mcasp: Add new dma register location to reg-property
Date: Thu, 19 Sep 2013 14:29:43 +0300
Message-ID: <c7a2c57b695804f52927ed5fd865bc8a9988335a.1379590036.git.jsarha@ti.com>
References: <cover.1379590035.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1379590035.git.jsarha-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, peter.ujfalusi-l0cyMroinI0@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, liam.r.girdwood-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, joelf-l0cyMroinI0@public.gmane.org, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>, "Hebbar, Gururaja" <gururaja.hebbar-l0cyMroinI0@public.gmane.org>, Darren Etheridge <detheridge-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

This patch adds an optional address range to reg property. The range
describes the register location for DMA controller on am33xx. The both
address ranges are named accordingly in the reg-names property.

Signed-off-by: Hebbar, Gururaja <gururaja.hebbar-l0cyMroinI0@public.gmane.org>
Signed-off-by: Darren Etheridge <detheridge-l0cyMroinI0@public.gmane.org>
Signed-off-by: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/am33xx.dtsi |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index fe53ce0..4dc388a 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -556,19 +556,29 @@
 		mcasp0: mcasp@48038000 {
 			compatible = "ti,omap2-mcasp-audio";
 			ti,hwmods = "mcasp0";
-			reg = <0x48038000 0x2000>;
+			reg = <0x48038000 0x2000>,
+			      <0x46400000 0x400000>;
+			reg-names = "mpu", "dma";
 			interrupts = <80 81>;
 			interrupts-names = "tx", "rx";
 			status = "disabled";
+			dmas = <&edma 8
+				&edma 9>;
+			dma-names = "tx", "rx";
 		};
 
 		mcasp1: mcasp@4803C000 {
 			compatible = "ti,omap2-mcasp-audio";
 			ti,hwmods = "mcasp1";
-			reg = <0x4803C000 0x2000>;
+			reg = <0x4803C000 0x2000>,
+			      <0x46400000 0x400000>;
+			reg-names = "mpu", "dma";
 			interrupts = <82 83>;
 			interrupts-names = "tx", "rx";
 			status = "disabled";
+			dmas = <&edma 10
+				&edma 11>;
+			dma-names = "tx", "rx";
 		};
 
 	};
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
