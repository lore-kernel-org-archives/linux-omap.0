From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH v5 08/12] ARM/dts: am33xx: Add mcasp0 and mcasp1 device tree entries
Date: Fri, 18 Oct 2013 18:37:47 +0300
Message-ID: <8bf7af0d55f9637959f5414ed95fe26e477c2700.1382110090.git.jsarha@ti.com>
References: <cover.1382110089.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48897 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756258Ab3JRPiM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 Oct 2013 11:38:12 -0400
In-Reply-To: <cover.1382110089.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, bcousson@baylibre.com, mark.rutland@arm.com
Cc: linux-omap@vger.kernel.org, broonie@kernel.org, joelf@ti.com, Pantelis Antoniou <panto@antoniou-consulting.com>, Darren Etheridge <detheridge@ti.com>, Jyri Sarha <jsarha@ti.com>

From: Pantelis Antoniou <panto@antoniou-consulting.com>

Add missing mcasp entries in the am33xx.dtsi include file.

Signed-off-by: Pantelis Antoniou <panto@antoniou-consulting.com>
Signed-off-by: Darren Etheridge <detheridge@ti.com>
Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi |   25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 9ce85e5..72c416d 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -667,5 +667,30 @@
 			#size-cells = <1>;
 			status = "disabled";
 		};
+
+		mcasp0: mcasp@48038000 {
+			compatible = "ti,am33xx-mcasp-audio";
+			ti,hwmods = "mcasp0";
+			reg = <0x48038000 0x2000>;
+			interrupts = <80>, <81>;
+			interrupts-names = "tx", "rx";
+			status = "disabled";
+			dmas = <&edma 8>,
+				<&edma 9>;
+			dma-names = "tx", "rx";
+		};
+
+		mcasp1: mcasp@4803C000 {
+			compatible = "ti,am33xx-mcasp-audio";
+			ti,hwmods = "mcasp1";
+			reg = <0x4803C000 0x2000>;
+			interrupts = <82>, <83>;
+			interrupts-names = "tx", "rx";
+			status = "disabled";
+			dmas = <&edma 10>,
+				<&edma 11>;
+			dma-names = "tx", "rx";
+		};
+
 	};
 };
-- 
1.7.9.5

