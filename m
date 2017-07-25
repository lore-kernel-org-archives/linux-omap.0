From: karthik-fINqtvHxh+hg9hUCZPvPmw@public.gmane.org
Subject: [RESEND PATCH] arm: dts: omap3: Remove needless interrupt-parent property
Date: Tue, 25 Jul 2017 15:17:29 +0530
Message-ID: <1500976049-5825-1-git-send-email-karthik@techveda.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sunil.m-fINqtvHxh+hg9hUCZPvPmw@public.gmane.org, Karthik Tummala <karthik-fINqtvHxh+hg9hUCZPvPmw@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Karthik Tummala <karthik-fINqtvHxh+hg9hUCZPvPmw@public.gmane.org>

All nodes inhert "interrupt-parent" property from root
node. Removed the aforementioned property from usbhsohci,
usbhsehci, ssi_port1, ssi_port2 nodes to avoid duplication.

Signed-off-by: Karthik Tummala <karthik-fINqtvHxh+hg9hUCZPvPmw@public.gmane.org>
---
 arch/arm/boot/dts/omap3.dtsi | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index a3ff493..bdaf30c 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -713,14 +713,12 @@
 			usbhsohci: ohci@48064400 {
 				compatible = "ti,ohci-omap3";
 				reg = <0x48064400 0x400>;
-				interrupt-parent = <&intc>;
 				interrupts = <76>;
 			};
 
 			usbhsehci: ehci@48064800 {
 				compatible = "ti,ehci-omap";
 				reg = <0x48064800 0x400>;
-				interrupt-parent = <&intc>;
 				interrupts = <77>;
 			};
 		};
@@ -831,7 +829,6 @@
 				reg-names = "tx",
 					    "rx";
 
-				interrupt-parent = <&intc>;
 				interrupts = <67>,
 					     <68>;
 			};
@@ -844,7 +841,6 @@
 				reg-names = "tx",
 					    "rx";
 
-				interrupt-parent = <&intc>;
 				interrupts = <69>,
 					     <70>;
 			};
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
