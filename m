From: Nishanth Menon <nm@ti.com>
Subject: [PATCH] ARM: dts: omap3-n9 family: mark proper OMAP version
Date: Tue, 11 Feb 2014 09:29:01 -0600
Message-ID: <1392132541-25340-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Nishanth Menon <nm@ti.com>, Aaro Koskinen <aaro.koskinen@iki.fi>
List-Id: linux-omap@vger.kernel.org

Nokia N900 uses OMAP3430 and N9/N950 uses OMAP3630. Mark SoC compatibilty
as per Documentation/devicetree/bindings/arm/omap/omap.txt else
N9/N950 will be probed as a OMAP3430 type device, since default ti,omap3
maps to OMAP3430 compatibility.

Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Signed-off-by: Nishanth Menon <nm@ti.com>
---

just build tested. but given examples such as 
http://thread.gmane.org/gmane.linux.ports.arm.omap/110006

I guess, some form of failure is expected.

based on v3.14-rc2

 arch/arm/boot/dts/omap3-n9.dts   |    2 +-
 arch/arm/boot/dts/omap3-n900.dts |    2 +-
 arch/arm/boot/dts/omap3-n950.dts |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-n9.dts b/arch/arm/boot/dts/omap3-n9.dts
index 39828ce..9938b5d 100644
--- a/arch/arm/boot/dts/omap3-n9.dts
+++ b/arch/arm/boot/dts/omap3-n9.dts
@@ -14,5 +14,5 @@
 
 / {
 	model = "Nokia N9";
-	compatible = "nokia,omap3-n9", "ti,omap3";
+	compatible = "nokia,omap3-n9", "ti,omap36xx", "ti,omap3";
 };
diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
index 6fc85f9..97db027 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -13,7 +13,7 @@
 
 / {
 	model = "Nokia N900";
-	compatible = "nokia,omap3-n900", "ti,omap3";
+	compatible = "nokia,omap3-n900", "ti,omap3430", "ti,omap3";
 
 	cpus {
 		cpu@0 {
diff --git a/arch/arm/boot/dts/omap3-n950.dts b/arch/arm/boot/dts/omap3-n950.dts
index b076a52..261c558 100644
--- a/arch/arm/boot/dts/omap3-n950.dts
+++ b/arch/arm/boot/dts/omap3-n950.dts
@@ -14,5 +14,5 @@
 
 / {
 	model = "Nokia N950";
-	compatible = "nokia,omap3-n950", "ti,omap3";
+	compatible = "nokia,omap3-n950", "ti,omap36xx", "ti,omap3";
 };
-- 
1.7.9.5
