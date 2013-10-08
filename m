From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH v4 08/10] ARM/dts: am33xx: mcasp: Add location for data port registers to reg-property
Date: Tue, 8 Oct 2013 22:36:39 +0300
Message-ID: <37c7ee5f2eab24df86baba1bd36da66c5a637744.1381259962.git.jsarha@ti.com>
References: <cover.1381259962.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50358 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756428Ab3JHThG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 Oct 2013 15:37:06 -0400
In-Reply-To: <cover.1381259962.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, devicetree@vger.kernel.org
Cc: linux-omap@vger.kernel.org, broonie@kernel.org, mark.rutland@arm.com, joelf@ti.com, Jyri Sarha <jsarha@ti.com>, "Hebbar, Gururaja" <gururaja.hebbar@ti.com>, Darren Etheridge <detheridge@ti.com>

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
index 22659e7..c8ba19e 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -671,7 +671,9 @@
 		mcasp0: mcasp@48038000 {
 			compatible = "ti,omap2-mcasp-audio";
 			ti,hwmods = "mcasp0";
-			reg = <0x48038000 0x2000>;
+			reg = <0x48038000 0x2000>,
+			      <0x46400000 0x400000>;
+			reg-names = "mpu", "dat";
 			interrupts = <80>, <81>;
 			interrupts-names = "tx", "rx";
 			status = "disabled";
@@ -683,7 +685,9 @@
 		mcasp1: mcasp@4803C000 {
 			compatible = "ti,omap2-mcasp-audio";
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

