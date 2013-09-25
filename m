From: Joel Fernandes <joelf-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 7/9] ARM: am437x: dts: Add DES node for am437x
Date: Wed, 25 Sep 2013 17:01:07 -0500
Message-ID: <1380146469-29496-8-git-send-email-joelf@ti.com>
References: <1380146469-29496-1-git-send-email-joelf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1380146469-29496-1-git-send-email-joelf-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Jason Kridner <jkridner-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>, Koen Kooi <koen-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>
Cc: Devicetree Discuss <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Joel Fernandes <joelf-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

AM437x SoC has a DES3DES module similar to the one on OMAP4.
Add DT node for the same.

Signed-off-by: Joel Fernandes <joelf-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/am4372.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index 3e631ab..6653e3d 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -419,5 +419,13 @@
 			interrupt-parent = <&gic>;
 			interrupts = <0 103 0x4>;
 		};
+
+		des: des@53701000 {
+			compatible = "ti,omap4-des";
+			ti,hwmods = "des";
+			reg = <0x53701000 0xa0>;
+			interrupt-parent = <&gic>;
+			interrupts = <0 130 0x4>;
+		};
 	};
 };
-- 
1.8.1.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
