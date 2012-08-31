From: Ravi Babu <ravibabu-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v9 12/13] arm/dts: am33xx: add phy phandle to usbss
Date: Fri, 31 Aug 2012 16:39:58 +0530
Message-ID: <1346411399-23964-13-git-send-email-ravibabu@ti.com>
References: <1346411399-23964-1-git-send-email-ravibabu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1346411399-23964-1-git-send-email-ravibabu-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

From: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>

Added NOP PHY phandle to usbss device node as same will be used
to get the phy from otg framework.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Signed-off-by: Santhapuri, Damodar <damodar.santhapuri-l0cyMroinI0@public.gmane.org>
Signed-off-by: Ravi Babu <ravibabu-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/am33xx.dtsi |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 4b3a2b7..1e77b0b 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -172,6 +172,8 @@
 			port0-mode = <3>;
 			port1-mode = <3>;
 			power = <250>;
+			usb0-phy = <&usb0_phy>;
+			usb1-phy = <&usb1_phy>;
 		};
 	};
 };
-- 
1.7.0.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
