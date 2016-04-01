From: Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Subject: [PATCH 5/5] ARM: dts: omap: add missing unit names to bandgap nodes
Date: Fri,  1 Apr 2016 16:20:22 -0400
Message-ID: <1459542022-17246-6-git-send-email-javier@osg.samsung.com>
References: <1459542022-17246-1-git-send-email-javier@osg.samsung.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1459542022-17246-1-git-send-email-javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

This patch fixes the following DTC warnings:

"bandgap has a reg or ranges property, but no unit name"

Signed-off-by: Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>

---

 arch/arm/boot/dts/omap34xx.dtsi | 2 +-
 arch/arm/boot/dts/omap36xx.dtsi | 2 +-
 arch/arm/boot/dts/omap443x.dtsi | 2 +-
 arch/arm/boot/dts/omap4460.dtsi | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/omap34xx.dtsi b/arch/arm/boot/dts/omap34xx.dtsi
index 387dc31822fe..5cdba1f6499f 100644
--- a/arch/arm/boot/dts/omap34xx.dtsi
+++ b/arch/arm/boot/dts/omap34xx.dtsi
@@ -55,7 +55,7 @@
 			};
 		};
 
-		bandgap {
+		bandgap@48002524 {
 			reg = <0x48002524 0x4>;
 			compatible = "ti,omap34xx-bandgap";
 			#thermal-sensor-cells = <0>;
diff --git a/arch/arm/boot/dts/omap36xx.dtsi b/arch/arm/boot/dts/omap36xx.dtsi
index f19c87bd6bf3..ce1e242d4dc0 100644
--- a/arch/arm/boot/dts/omap36xx.dtsi
+++ b/arch/arm/boot/dts/omap36xx.dtsi
@@ -87,7 +87,7 @@
 			};
 		};
 
-		bandgap {
+		bandgap@48002524 {
 			reg = <0x48002524 0x4>;
 			compatible = "ti,omap36xx-bandgap";
 			#thermal-sensor-cells = <0>;
diff --git a/arch/arm/boot/dts/omap443x.dtsi b/arch/arm/boot/dts/omap443x.dtsi
index 0adfa1d1ef20..fc6a8610c24c 100644
--- a/arch/arm/boot/dts/omap443x.dtsi
+++ b/arch/arm/boot/dts/omap443x.dtsi
@@ -35,7 +35,7 @@
 	};
 
 	ocp {
-		bandgap: bandgap {
+		bandgap: bandgap@4a002260 {
 			reg = <0x4a002260 0x4
 			       0x4a00232C 0x4>;
 			compatible = "ti,omap4430-bandgap";
diff --git a/arch/arm/boot/dts/omap4460.dtsi b/arch/arm/boot/dts/omap4460.dtsi
index 5fa68f191af7..ef66e12e0a67 100644
--- a/arch/arm/boot/dts/omap4460.dtsi
+++ b/arch/arm/boot/dts/omap4460.dtsi
@@ -40,7 +40,7 @@
 	};
 
 	ocp {
-		bandgap: bandgap {
+		bandgap: bandgap@4a002260 {
 			reg = <0x4a002260 0x4
 			       0x4a00232C 0x4
 			       0x4a002378 0x18>;
-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
