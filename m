From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] ARM: dts: am335x-boneblack: move fixed regulator to board level
Date: Thu, 19 Sep 2013 12:12:44 -0500
Message-ID: <1379610764-758-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Koen Kooi <koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Joel Fernandes <joelf-l0cyMroinI0@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Balaji T K <balajitk-l0cyMroinI0@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

3.3V fixed regulator does not belong to TPS node - as a result
the fixed regulator is never probed and MMC is continually deferred due
to lack of regulator.

Move the fixed regulator to be at root of platform.

Signed-off-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
---

Based on: (benoit's for_3.13/dts branch)
https://git.kernel.org/cgit/linux/kernel/git/bcousson/linux-omap-dt.git/log/?h=for_3.13/dts
 +
https://patchwork.kernel.org/patch/2902711/

Test Log:
before: http://pastebin.com/UuCsBg2d
After: http://pastebin.com/149FWujf
notice how "vmmcsd_fixed: 3300 mV " does not appear in the log before the patch.

 arch/arm/boot/dts/am335x-bone-common.dtsi |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi b/arch/arm/boot/dts/am335x-bone-common.dtsi
index 56361ce..fe2742e 100644
--- a/arch/arm/boot/dts/am335x-bone-common.dtsi
+++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
@@ -215,6 +215,13 @@
 			default-state = "off";
 		};
 	};
+
+	vmmcsd_fixed: fixedregulator@0 {
+		compatible = "regulator-fixed";
+		regulator-name = "vmmcsd_fixed";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
 };
 
 /include/ "tps65217.dtsi"
@@ -259,13 +266,6 @@
 			regulator-always-on;
 		};
 	};
-
-	vmmcsd_fixed: fixedregulator@0 {
-		compatible = "regulator-fixed";
-		regulator-name = "vmmcsd_fixed";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-	};
 };
 
 &cpsw_emac0 {
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
