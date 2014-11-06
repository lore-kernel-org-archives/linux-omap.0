From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 2/2] arm: boot: dts: am4372: enable dwc3 suspend PHY quirk
Date: Thu, 6 Nov 2014 11:36:06 -0600
Message-ID: <1415295366-593-2-git-send-email-balbi@ti.com>
References: <1415295366-593-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1415295366-593-1-git-send-email-balbi-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Linux ARM Kernel Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Whenever Suspend PHY bit is set on AM437x devices,
USB will not work due to Set EP Configuration command
always failing.

This was only found after a recent commit 2164a47 (usb:
dwc3: set SUSPHY bit for all cores, which will be merged
for v3.19) added a missing *required* step to dwc3
initialization. Synopsys Databook requires that we enable
Suspend PHY bit after initialization but that, unfortunately,
breaks AM437x.

Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/am4372.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index 46660ff..e19068d 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -817,6 +817,8 @@
 				maximum-speed = "high-speed";
 				dr_mode = "otg";
 				status = "disabled";
+				snps,dis_u3_susphy_quirk;
+				snps,dis_u2_susphy_quirk;
 			};
 		};
 
@@ -839,6 +841,8 @@
 				maximum-speed = "high-speed";
 				dr_mode = "otg";
 				status = "disabled";
+				snps,dis_u3_susphy_quirk;
+				snps,dis_u2_susphy_quirk;
 			};
 		};
 
-- 
2.1.0.GIT

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
