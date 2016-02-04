From: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 2/2] arm: omap: remove deprecated property
Date: Thu,  4 Feb 2016 14:18:02 +0200
Message-ID: <1454588282-14383-2-git-send-email-balbi@kernel.org>
References: <1454588282-14383-1-git-send-email-balbi@kernel.org>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1454588282-14383-1-git-send-email-balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

DWC3's tx-fifo-resize property has been deprecated
because of it being unnecessary to any HW other than
OMAP5 ES1.0.

Signed-off-by: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 arch/arm/boot/dts/dra7.dtsi   | 3 ---
 arch/arm/boot/dts/dra74x.dtsi | 1 -
 arch/arm/boot/dts/omap5.dtsi  | 1 -
 3 files changed, 5 deletions(-)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index c4d9175b90dc..d4e5312b032e 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -1357,7 +1357,6 @@
 						  "otg";
 				phys = <&usb2_phy1>, <&usb3_phy1>;
 				phy-names = "usb2-phy", "usb3-phy";
-				tx-fifo-resize;
 				maximum-speed = "super-speed";
 				dr_mode = "otg";
 				snps,dis_u3_susphy_quirk;
@@ -1385,7 +1384,6 @@
 						  "otg";
 				phys = <&usb2_phy2>;
 				phy-names = "usb2-phy";
-				tx-fifo-resize;
 				maximum-speed = "high-speed";
 				dr_mode = "otg";
 				snps,dis_u3_susphy_quirk;
@@ -1413,7 +1411,6 @@
 				interrupt-names = "peripheral",
 						  "host",
 						  "otg";
-				tx-fifo-resize;
 				maximum-speed = "high-speed";
 				dr_mode = "otg";
 				snps,dis_u3_susphy_quirk;
diff --git a/arch/arm/boot/dts/dra74x.dtsi b/arch/arm/boot/dts/dra74x.dtsi
index 8bcc47db1cd1..4220eeffc65a 100644
--- a/arch/arm/boot/dts/dra74x.dtsi
+++ b/arch/arm/boot/dts/dra74x.dtsi
@@ -76,7 +76,6 @@
 				interrupt-names = "peripheral",
 						  "host",
 						  "otg";
-				tx-fifo-resize;
 				maximum-speed = "high-speed";
 				dr_mode = "otg";
 			};
diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index ca3c17fde5a0..614a437abd1b 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -885,7 +885,6 @@
 				phys = <&usb2_phy>, <&usb3_phy>;
 				phy-names = "usb2-phy", "usb3-phy";
 				dr_mode = "peripheral";
-				tx-fifo-resize;
 			};
 		};
 
-- 
2.7.0

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
