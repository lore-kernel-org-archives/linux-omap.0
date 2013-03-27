From: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Subject: [RFC 09/14] ARM: omap3.dtsi: add omapdss information
Date: Wed, 27 Mar 2013 10:45:16 +0200
Message-ID: <1364373921-7599-10-git-send-email-tomi.valkeinen@ti.com>
References: <1364373921-7599-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1364373921-7599-1-git-send-email-tomi.valkeinen-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, Archit Taneja <archit-l0cyMroinI0@public.gmane.org>, Andy Gross <andy.gross-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Signed-off-by: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/omap3.dtsi |   49 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index 1acc261..49de390 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -397,5 +397,54 @@
 			ti,timer-alwon;
 			ti,timer-secure;
 		};
+
+		dss@48050000 {
+			compatible = "ti,omap3-dss", "simple-bus";
+			reg = <0x48050000 0x200>;
+			ti,hwmods = "dss_core";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			dispc@48050400 {
+				compatible = "ti,omap3-dispc";
+				reg = <0x48050400 0x400>;
+				interrupts = <25>;
+				ti,hwmods = "dss_dispc";
+			};
+
+			dpi: dpi {
+				compatible = "ti,omap3-dpi";
+			};
+
+			sdi: sdi {
+				compatible = "ti,omap3-sdi";
+			};
+
+			dsi: dsi@4804fc00 {
+				compatible = "ti,omap3-dsi";
+				reg = <0x4804fc00 0x400>;
+				interrupts = <25>;
+				ti,hwmods = "dss_dsi1";
+
+				/*
+				 * XXX dss_core needs to know module-id,
+				 * so this data should be there.
+				 */
+				ti,dsi-module-id = <0>;
+			};
+
+			rfbi: rfbi@48050800 {
+				compatible = "ti,omap3-rfbi";
+				reg = <0x48050800 0x100>;
+				ti,hwmods = "dss_rfbi";
+			};
+
+			venc: venc@48050c00 {
+				compatible = "ti,omap3-venc";
+				reg = <0x48050c00 0x100>;
+				ti,hwmods = "dss_venc";
+			};
+		};
 	};
 };
-- 
1.7.10.4
