From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] ARM: dts: omap4-panda: Fix model and SoC family details
Date: Thu, 28 Aug 2014 15:45:03 -0500
Message-ID: <1409258703-21188-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Currently we claim that omap4-panda and omap4-panda-es are essentially
the same, but they are not since PandaBoard-ES uses OMAP4460 and
PandaBoard uses OMAP4430.

So, split the common definition and make the model name available.

Signed-off-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
---
Based on v3.17-rc2

Testing logs: (boot test):
Before Patch(v3.17-rc2)
1: pandaboard-es:  Boot PASS: http://slexy.org/raw/s209HfpVTs
2: pandaboard-vanilla:  Boot PASS: http://slexy.org/raw/s21YNmOhQL

After Patch
1: pandaboard-es:  Boot PASS: http://slexy.org/raw/s20FH76BTn
2: pandaboard-vanilla:  Boot PASS: http://slexy.org/raw/s2vFLcfkBu

Note: 'ti,omap4-panda-es' is not documented in bindings, not entirely
sure if we should be doing the same for every board compatibility.

 arch/arm/boot/dts/omap4-panda-common.dtsi |    3 ---
 arch/arm/boot/dts/omap4-panda-es.dts      |    5 +++++
 arch/arm/boot/dts/omap4-panda.dts         |    5 +++++
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/omap4-panda-common.dtsi b/arch/arm/boot/dts/omap4-panda-common.dtsi
index 8cfa3c8..1505135 100644
--- a/arch/arm/boot/dts/omap4-panda-common.dtsi
+++ b/arch/arm/boot/dts/omap4-panda-common.dtsi
@@ -8,9 +8,6 @@
 #include "elpida_ecb240abacn.dtsi"
 
 / {
-	model = "TI OMAP4 PandaBoard";
-	compatible = "ti,omap4-panda", "ti,omap4430", "ti,omap4";
-
 	memory {
 		device_type = "memory";
 		reg = <0x80000000 0x40000000>; /* 1 GB */
diff --git a/arch/arm/boot/dts/omap4-panda-es.dts b/arch/arm/boot/dts/omap4-panda-es.dts
index 816d1c9..2f1dabc 100644
--- a/arch/arm/boot/dts/omap4-panda-es.dts
+++ b/arch/arm/boot/dts/omap4-panda-es.dts
@@ -10,6 +10,11 @@
 #include "omap4460.dtsi"
 #include "omap4-panda-common.dtsi"
 
+/ {
+	model = "TI OMAP4 PandaBoard-ES";
+	compatible = "ti,omap4-panda-es", "ti,omap4-panda", "ti,omap4460", "ti,omap4430", "ti,omap4";
+};
+
 /* Audio routing is differnet between PandaBoard4430 and PandaBoardES */
 &sound {
 	ti,model = "PandaBoardES";
diff --git a/arch/arm/boot/dts/omap4-panda.dts b/arch/arm/boot/dts/omap4-panda.dts
index 6189a8b..a0e28b2 100644
--- a/arch/arm/boot/dts/omap4-panda.dts
+++ b/arch/arm/boot/dts/omap4-panda.dts
@@ -9,3 +9,8 @@
 
 #include "omap443x.dtsi"
 #include "omap4-panda-common.dtsi"
+
+/ {
+	model = "TI OMAP4 PandaBoard";
+	compatible = "ti,omap4-panda", "ti,omap4430", "ti,omap4";
+};
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
