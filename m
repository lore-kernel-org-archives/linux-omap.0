From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH v5 DTS 2/4] ARM/dts: am33xx: mcasp: Add location for data port registers to reg-property
Date: Sun, 20 Oct 2013 20:04:09 +0300
Message-ID: <c3bd6043ada6dfaf6a27f9a679a1628197ae712b.1382288457.git.jsarha@ti.com>
References: <cover.1382288454.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53387 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751261Ab3JTREa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 20 Oct 2013 13:04:30 -0400
In-Reply-To: <cover.1382288454.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, bcousson@baylibre.com
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
index 861382f..3465d4b 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -746,7 +746,9 @@
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
@@ -758,7 +760,9 @@
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

