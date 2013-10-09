From: <y@dflp33.itg.ti.com>
Subject: [PATCH v4.1 08/10] ARM/dts: am33xx: mcasp: Add location for data port registers to reg-property
Date: Wed, 9 Oct 2013 15:44:34 +0300
Message-ID: <9643.4214887724$1381322724@news.gmane.org>
References: <525513F8.1040103@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <525513F8.1040103-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, joelf-l0cyMroinI0@public.gmane.org, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>, "Hebbar, Gururaja" <gururaja.hebbar-l0cyMroinI0@public.gmane.org>, Darren Etheridge <detheridge-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>

This patch adds a second tuple to reg property. The new property tuple
describes the memory location for data port registers mapped trough
L3 bus on am33xx. The both property tuples are named accordingly in
the reg-names property.

Signed-off-by: Hebbar, Gururaja <gururaja.hebbar-l0cyMroinI0@public.gmane.org>
Signed-off-by: Darren Etheridge <detheridge-l0cyMroinI0@public.gmane.org>
Signed-off-by: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/am33xx.dtsi |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 22659e7..4a86762 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -671,7 +671,9 @@
 		mcasp0: mcasp@48038000 {
 			compatible = "ti,omap2-mcasp-audio";
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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
