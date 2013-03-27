From: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Subject: [RFC 10/14] ARM: omap4.dtsi: add omapdss information
Date: Wed, 27 Mar 2013 10:45:17 +0200
Message-ID: <1364373921-7599-11-git-send-email-tomi.valkeinen@ti.com>
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
 arch/arm/boot/dts/omap4.dtsi |   71 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 739bb79..967f706 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -529,5 +529,76 @@
 			ti,hwmods = "timer11";
 			ti,timer-pwm;
 		};
+
+		dss@58000000 {
+			compatible = "ti,omap4-dss", "simple-bus";
+			reg = <0x58000000 0x80>;
+			ti,hwmods = "dss_core";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			dispc@58001000 {
+				compatible = "ti,omap4-dispc";
+				reg = <0x58001000 0x1000>;
+				interrupts = <0 25 0x4>;
+				ti,hwmods = "dss_dispc";
+			};
+
+			dpi: dpi {
+				compatible = "ti,omap4-dpi";
+			};
+
+			rfbi: rfbi@58002000  {
+				compatible = "ti,omap4-rfbi";
+				reg = <0x58002000 0x1000>;
+				ti,hwmods = "dss_rfbi";
+			};
+
+			/*
+			 * Accessing venc registers cause a crash on omap4, so
+			 * this is disabled for now.
+			 */
+			/*
+			venc: venc@58003000 {
+				compatible = "ti,omap4-venc";
+				reg = <0x58003000 0x1000>;
+				ti,hwmods = "dss_venc";
+			};
+			*/
+
+			dsi1: dsi@58004000 {
+				compatible = "ti,omap4-dsi";
+				reg = <0x58004000 0x200>;
+				interrupts = <0 53 0x4>;
+				ti,hwmods = "dss_dsi1";
+
+				/*
+				 * XXX dss_core needs to know module-id,
+				 * so this data should be there.
+				 */
+				ti,dsi-module-id = <0>;
+			};
+
+			dsi2: dsi@58005000 {
+				compatible = "ti,omap4-dsi";
+				reg = <0x58005000 0x200>;
+				interrupts = <0 84 0x4>;
+				ti,hwmods = "dss_dsi2";
+
+				/*
+				 * XXX dss_core needs to know module-id,
+				 * so this data should be there.
+				 */
+				ti,dsi-module-id = <1>;
+			};
+
+			hdmi: hdmi@58006000 {
+				compatible = "ti,omap4-hdmi";
+				reg = <0x58006000 0x1000>;
+				interrupts = <0 101 0x4>;
+				ti,hwmods = "dss_hdmi";
+			};
+		};
 	};
 };
-- 
1.7.10.4
