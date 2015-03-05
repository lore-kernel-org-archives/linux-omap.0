From: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 2/2] ARM: dts: am33xx: Move wkup_m3 node to soc node and add ranges
Date: Wed, 4 Mar 2015 22:12:22 -0600
Message-ID: <1425528742-3087-3-git-send-email-d-gerlach@ti.com>
References: <1425528742-3087-1-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1425528742-3087-1-git-send-email-d-gerlach-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>, Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Signed-off-by: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Signed-off-by: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/am33xx.dtsi | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index acd3705..086415c 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -77,10 +77,23 @@
 	 */
 	soc {
 		compatible = "ti,omap-infra";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0     0x44d00000 0x4000>,
+			 <0x80000 0x44d80000 0x2000>;
+
 		mpu {
 			compatible = "ti,omap3-mpu";
 			ti,hwmods = "mpu";
 		};
+
+		wkup_m3: wkup_m3@44d00000 {
+			compatible = "ti,am3353-wkup-m3";
+			reg = <0x0     0x4000>,	/* M3 UMEM */
+			      <0x80000 0x2000>;	/* M3 DMEM */
+			ti,hwmods = "wkup_m3";
+			ti,pm-firmware = "am335x-pm-firmware.elf";
+		};
 	};
 
 	am33xx_control_module: control_module@4a002000 {
@@ -755,14 +768,6 @@
 			reg = <0x40300000 0x10000>; /* 64k */
 		};
 
-		wkup_m3: wkup_m3@44d00000 {
-			compatible = "ti,am3353-wkup-m3";
-			reg = <0x44d00000 0x4000	/* M3 UMEM */
-			       0x44d80000 0x2000>;	/* M3 DMEM */
-			ti,hwmods = "wkup_m3";
-			ti,no-reset-on-init;
-		};
-
 		elm: elm@48080000 {
 			compatible = "ti,am3352-elm";
 			reg = <0x48080000 0x2000>;
-- 
2.3.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
