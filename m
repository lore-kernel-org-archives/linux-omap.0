From: "Philip, Avinash" <avinashphilip-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 09/10] ARM: dts: AM33XX: Add PWMSS device tree nodes
Date: Thu, 8 Nov 2012 13:23:16 +0530
Message-ID: <1352361197-27442-10-git-send-email-avinashphilip@ti.com>
References: <1352361197-27442-1-git-send-email-avinashphilip@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1352361197-27442-1-git-send-email-avinashphilip-l0cyMroinI0@public.gmane.org>
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
---
:100644 100644 bb31bff... cf5e049... M	arch/arm/boot/dts/am33xx.dtsi
 arch/arm/boot/dts/am33xx.dtsi |   90 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 90 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index bb31bff..cf5e049 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -210,5 +210,95 @@
 			interrupt-parent = <&intc>;
 			interrupts = <91>;
 		};
+
+		epwmss0: epwmss@48300000 {
+			compatible = "ti,am33xx-pwmss";
+			reg = <0x48300000 0x10
+				0x48300100 0x80
+				0x48300180 0x80
+				0x48300200 0x80>;
+			ti,hwmods = "epwmss0";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			status = "disabled";
+			ranges;
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
+				tbclkgating;
+			};
+		};
+
+		epwmss1: epwmss@48302000 {
+			compatible = "ti,am33xx-pwmss";
+			reg = <0x48302000 0x10
+				0x48302100 0x80
+				0x48302180 0x80
+				0x48302200 0x80>;
+			ti,hwmods = "epwmss1";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			status = "disabled";
+			ranges;
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
+				tbclkgating;
+			};
+		};
+
+		epwmss2: epwmss@48304000 {
+			compatible = "ti,am33xx-pwmss";
+			reg = <0x48304000 0x10
+				0x48304100 0x80
+				0x48304180 0x80
+				0x48304200 0x80>;
+			ti,hwmods = "epwmss2";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			status = "disabled";
+			ranges;
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
+				tbclkgating;
+			};
+		};
 	};
 };
-- 
1.7.0.4
