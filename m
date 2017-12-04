From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 2/2] ARM: dts: Fix dm814x missing phy-cells property
Date: Mon,  4 Dec 2017 08:27:18 -0800
Message-ID: <20171204162718.11222-2-tony@atomide.com>
References: <20171204162718.11222-1-tony@atomide.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171204162718.11222-1-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

We have phy-cells for usb_phy0, but it's missing for usb_phy1 and we get:

Warning (phys_property): Missing property '#phy-cells' in node
/ocp/l4ls@48000000/control@140000/usb-phy@1b00 or bad phandle
(referred from /ocp/usb@47400000/usb@47401800:phys[0])

Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 arch/arm/boot/dts/dm814x.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/dm814x.dtsi b/arch/arm/boot/dts/dm814x.dtsi
--- a/arch/arm/boot/dts/dm814x.dtsi
+++ b/arch/arm/boot/dts/dm814x.dtsi
@@ -386,6 +386,7 @@
 					reg = <0x1b00 0x100>;
 					reg-names = "phy";
 					ti,ctrl_mod = <&usb_ctrl_mod>;
+					#phy-cells = <0>;
 				};
 			};
 
-- 
2.15.0
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
