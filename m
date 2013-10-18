From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH v5 09/12] ARM/dts: am33xx: mcasp: Add location for data port registers to reg-property
Date: Fri, 18 Oct 2013 18:37:48 +0300
Message-ID: <42a07ec95e568eb3158b8c15645e55e9ecb2a7e0.1382110090.git.jsarha@ti.com>
References: <cover.1382110089.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37532 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756261Ab3JRPiM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Oct 2013 11:38:12 -0400
In-Reply-To: <cover.1382110089.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, bcousson@baylibre.com, mark.rutland@arm.com
Cc: linux-omap@vger.kernel.org, broonie@kernel.org, joelf@ti.com, Jyri Sarha <jsarha@ti.com>, "Hebbar, Gururaja" <gururaja.hebbar@ti.com>, Darren Etheridge <detheridge@ti.com>

This patch adds a second tuple to reg property. The new property tuple
describes the memory location for data port registers mapped trough
L3 bus on am33xx. The both property tuples are named accordingly in
the reg-names property.

Signed-off-by: Hebbar, Gururaja <gururaja.hebbar@ti.com>
Signed-off-by: Darren Etheridge <detheridge@ti.com>
Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 72c416d..b1d2d3f 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -671,7 +671,9 @@
 		mcasp0: mcasp@48038000 {
 			compatible = "ti,am33xx-mcasp-audio";
 			ti,hwmods = "mcasp0";
-			reg = <0x48038000 0x2000>;
+			reg = <0x48038000 0x2000>,
+			      <0x46000000 0x400000>;
+			reg-names = "mpu", "dat";
 			interrupts = <80>, <81>;
 			interrupts-names = "tx", "rx";
 			status = "disabled";
@@ -683,7 +685,9 @@
 		mcasp1: mcasp@4803C000 {
 			compatible = "ti,am33xx-mcasp-audio";
 			ti,hwmods = "mcasp1";
-			reg = <0x4803C000 0x2000>;
+			reg = <0x4803C000 0x2000>,
+			      <0x46400000 0x400000>;
+			reg-names = "mpu", "dat";
 			interrupts = <82>, <83>;
 			interrupts-names = "tx", "rx";
 			status = "disabled";
-- 
1.7.9.5

