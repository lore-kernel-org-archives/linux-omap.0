From: Ravi B <ravibabu-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v6 06/11] arm/dts: am33xx: Add dt data for usbss
Date: Fri, 27 Jul 2012 14:02:02 +0530
Message-ID: <1343377927-7850-6-git-send-email-ravibabu@ti.com>
References: <1343377927-7850-1-git-send-email-ravibabu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1343377927-7850-1-git-send-email-ravibabu-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, ajayguptaj-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>, Ravi B <ravibabu-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>

Added device tree data for usbss on am33xx. There are two musb controllers
on am33xx platform so have port0_mode and port1_mode additional data.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Signed-off-by: Ravi B <ravibabu-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/am33xx.dtsi |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 59509c4..08e9a40 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -154,5 +154,16 @@
 			#size-cells = <0>;
 			ti,hwmods = "i2c3";
 		};
+
+		usb_otg_hs: usb_otg_hs {
+			compatible = "ti,musb-am33xx";
+			ti,hwmods = "usb_otg_hs";
+			multipoint = <1>;
+			num_eps = <16>;
+			ram_bits = <12>;
+			port0_mode = <3>;
+			port1_mode = <1>;
+			power = <250>;
+		};
 	};
 };
-- 
1.7.0.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
