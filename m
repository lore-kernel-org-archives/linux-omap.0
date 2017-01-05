From: Teresa Remmet <t.remmet-guT5V/WYfQezQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH 1/6] ARM: dts: am335x-phycore-som: Update NAND partition table
Date: Thu, 5 Jan 2017 15:50:46 +0100
Message-ID: <1483627851-17996-2-git-send-email-t.remmet@phytec.de>
References: <1483627851-17996-1-git-send-email-t.remmet@phytec.de>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1483627851-17996-1-git-send-email-t.remmet-guT5V/WYfQezQB+pC5nmwQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

To improve NAND safety we updated the partition layout.
Added barebox backup partition and removed kernel and oftree
partition. They are kept in ubi now.

Signed-off-by: Teresa Remmet <t.remmet-guT5V/WYfQezQB+pC5nmwQ@public.gmane.org>
---
 arch/arm/boot/dts/am335x-phycore-som.dtsi | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-phycore-som.dtsi b/arch/arm/boot/dts/am335x-phycore-som.dtsi
index 75e24ad..ef3fe5a 100644
--- a/arch/arm/boot/dts/am335x-phycore-som.dtsi
+++ b/arch/arm/boot/dts/am335x-phycore-som.dtsi
@@ -222,21 +222,19 @@
 			label = "barebox";
 			reg = <0x80000 0x80000>;
 		};
+
 		partition@5 {
-			label = "bareboxenv";
-			reg = <0x100000 0x40000>;
+			label = "barebox_backup";
+			reg = <0x100000 0x80000>;
 		};
+
 		partition@6 {
-			label = "oftree";
-			reg = <0x140000 0x40000>;
+			label = "bareboxenv";
+			reg = <0x180000 0x40000>;
 		};
 		partition@7 {
-			label = "kernel";
-			reg = <0x180000 0x800000>;
-		};
-		partition@8 {
 			label = "root";
-			reg = <0x980000 0x0>;
+			reg = <0x1C0000 0x0>;
 		};
 	};
 };
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
