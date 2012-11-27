From: "Philip, Avinash" <avinashphilip-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v5 10/12] ARM: dts: AM33XX: Add PWMSS device tree nodes
Date: Tue, 27 Nov 2012 14:18:15 +0530
Message-ID: <1354006097-25895-11-git-send-email-avinashphilip@ti.com>
References: <1354006097-25895-1-git-send-email-avinashphilip@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1354006097-25895-1-git-send-email-avinashphilip-l0cyMroinI0@public.gmane.org>
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
To: thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org
Cc: linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gururaja.hebbar-l0cyMroinI0@public.gmane.org, "Philip,
 Avinash" <avinashphilip-l0cyMroinI0@public.gmane.org>, vaibhav.bedia-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Add PWMSS device tree nodes in relation with ECAP & EHRPWM DT nodes to
AM33XX SoC family. Also populates device tree nodes for ECAP & EHRPWM by
adding necessary properties like pwm-cells, base reg & set disabled as
status.

Signed-off-by: Philip, Avinash <avinashphilip-l0cyMroinI0@public.gmane.org>
Reviewed-by: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
---
Changes since v2:
	- ranges property populated to handle child devices address range

 arch/arm/boot/dts/am33xx.dtsi |   84 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 84 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 20a3f29..4393161 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -338,5 +338,89 @@
 			power = <250>;
 			ti,hwmods = "usb_otg_hs";
 		};
+
+		epwmss0: epwmss@48300000 {
+			compatible = "ti,am33xx-pwmss";
+			reg = <0x48300000 0x10>;
+			ti,hwmods = "epwmss0";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			status = "disabled";
+			ranges = <0x48300100 0x48300100 0x80   /* ECAP */
+				  0x48300180 0x48300180 0x80   /* EQEP */
+				  0x48300200 0x48300200 0x80>; /* EHRPWM */
+
+			ecap0: ecap@48300100 {
+				compatible = "ti,am33xx-ecap";
+				#pwm-cells = <3>;
+				reg = <0x48300100 0x80>;
+				ti,hwmods = "ecap0";
+				status = "disabled";
+			};
+
+			ehrpwm0: ehrpwm@48300200 {
+				compatible = "ti,am33xx-ehrpwm";
+				#pwm-cells = <3>;
+				reg = <0x48300200 0x80>;
+				ti,hwmods = "ehrpwm0";
+				status = "disabled";
+			};
+		};
+
+		epwmss1: epwmss@48302000 {
+			compatible = "ti,am33xx-pwmss";
+			reg = <0x48302000 0x10>;
+			ti,hwmods = "epwmss1";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			status = "disabled";
+			ranges = <0x48302100 0x48302100 0x80   /* ECAP */
+				  0x48302180 0x48302180 0x80   /* EQEP */
+				  0x48302200 0x48302200 0x80>; /* EHRPWM */
+
+			ecap1: ecap@48302100 {
+				compatible = "ti,am33xx-ecap";
+				#pwm-cells = <3>;
+				reg = <0x48302100 0x80>;
+				ti,hwmods = "ecap1";
+				status = "disabled";
+			};
+
+			ehrpwm1: ehrpwm@48302200 {
+				compatible = "ti,am33xx-ehrpwm";
+				#pwm-cells = <3>;
+				reg = <0x48302200 0x80>;
+				ti,hwmods = "ehrpwm1";
+				status = "disabled";
+			};
+		};
+
+		epwmss2: epwmss@48304000 {
+			compatible = "ti,am33xx-pwmss";
+			reg = <0x48304000 0x10>;
+			ti,hwmods = "epwmss2";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			status = "disabled";
+			ranges = <0x48304100 0x48304100 0x80   /* ECAP */
+				  0x48304180 0x48304180 0x80   /* EQEP */
+				  0x48304200 0x48304200 0x80>; /* EHRPWM */
+
+			ecap2: ecap@48304100 {
+				compatible = "ti,am33xx-ecap";
+				#pwm-cells = <3>;
+				reg = <0x48304100 0x80>;
+				ti,hwmods = "ecap2";
+				status = "disabled";
+			};
+
+			ehrpwm2: ehrpwm@48304200 {
+				compatible = "ti,am33xx-ehrpwm";
+				#pwm-cells = <3>;
+				reg = <0x48304200 0x80>;
+				ti,hwmods = "ehrpwm2";
+				status = "disabled";
+			};
+		};
 	};
 };
-- 
1.7.0.4
