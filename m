From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH 4/5] ARM: dts: OMAP2+: Update DMTIMER compatibility property
Date: Tue, 19 Mar 2013 12:38:18 -0500
Message-ID: <1363714699-29622-5-git-send-email-jon-hunter@ti.com>
References: <1363714699-29622-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35237 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757097Ab3CSRil (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Mar 2013 13:38:41 -0400
In-Reply-To: <1363714699-29622-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>
Cc: device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Jon Hunter <jon-hunter@ti.com>

Update the DMTIMER compatibility property to reflect the register level
compatibilty between devices and update the various OMAP/AM timer
bindings with the appropriate compatibility string.

By doing this we can add platform specific data applicable to specific
timer versions to the driver. For example, errata flags can be populated
for the timer versions that are impacted.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 .../devicetree/bindings/arm/omap/timer.txt         |   17 ++++++++++++--
 arch/arm/boot/dts/am33xx.dtsi                      |   14 ++++++------
 arch/arm/boot/dts/omap2.dtsi                       |   22 +++++++++---------
 arch/arm/boot/dts/omap2420.dtsi                    |    2 +-
 arch/arm/boot/dts/omap2430.dtsi                    |    2 +-
 arch/arm/boot/dts/omap3.dtsi                       |   24 ++++++++++----------
 arch/arm/boot/dts/omap4.dtsi                       |   22 +++++++++---------
 arch/arm/boot/dts/omap5.dtsi                       |   22 +++++++++---------
 arch/arm/mach-omap2/timer.c                        |    7 +++++-
 arch/arm/plat-omap/dmtimer.c                       |    7 +++++-
 10 files changed, 81 insertions(+), 58 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/omap/timer.txt b/Documentation/devicetree/bindings/arm/omap/timer.txt
index 8732d4d..d02e27c 100644
--- a/Documentation/devicetree/bindings/arm/omap/timer.txt
+++ b/Documentation/devicetree/bindings/arm/omap/timer.txt
@@ -1,7 +1,20 @@
 OMAP Timer bindings
 
 Required properties:
-- compatible:		Must be "ti,omap2-timer" for OMAP2+ controllers.
+- compatible:		Should be set to one of the below. Please note that
+			OMAP44xx devices have timer instances that are 100%
+			register compatible with OMAP3xxx devices as well as
+			newer timers that are not 100% register compatible.
+			So for OMAP44xx devices timer instances may use
+			different compatible strings.
+
+			ti,omap2420-timer (applicable to OMAP24xx devices)
+			ti,omap3430-timer (applicable to OMAP3xxx/44xx devices)
+			ti,omap4430-timer (applicable to OMAP44xx devices)
+			ti,omap5430-timer (applicable to OMAP543x devices)
+			ti,am335x-timer	(applicable to AM335x devices)
+			ti,am335x-timer-1ms (applicable to AM335x devices)
+
 - reg:			Contains timer register address range (base address and
 			length).
 - interrupts: 		Contains the interrupt information for the timer. The
@@ -22,7 +35,7 @@ Optional properties:
 Example:
 
 timer12: timer@48304000 {
-	compatible = "ti,omap2-timer";
+	compatible = "ti,omap3430-timer";
 	reg = <0x48304000 0x400>;
 	interrupts = <95>;
 	ti,hwmods = "timer12"
diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 0957645..e82c58d 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -239,7 +239,7 @@
 		};
 
 		timer1: timer@44e31000 {
-			compatible = "ti,omap2-timer";
+			compatible = "ti,am335x-timer-1ms";
 			reg = <0x44e31000 0x400>;
 			interrupts = <67>;
 			ti,hwmods = "timer1";
@@ -247,21 +247,21 @@
 		};
 
 		timer2: timer@48040000 {
-			compatible = "ti,omap2-timer";
+			compatible = "ti,am335x-timer";
 			reg = <0x48040000 0x400>;
 			interrupts = <68>;
 			ti,hwmods = "timer2";
 		};
 
 		timer3: timer@48042000 {
-			compatible = "ti,omap2-timer";
+			compatible = "ti,am335x-timer";
 			reg = <0x48042000 0x400>;
 			interrupts = <69>;
 			ti,hwmods = "timer3";
 		};
 
 		timer4: timer@48044000 {
-			compatible = "ti,omap2-timer";
+			compatible = "ti,am335x-timer";
 			reg = <0x48044000 0x400>;
 			interrupts = <92>;
 			ti,hwmods = "timer4";
@@ -269,7 +269,7 @@
 		};
 
 		timer5: timer@48046000 {
-			compatible = "ti,omap2-timer";
+			compatible = "ti,am335x-timer";
 			reg = <0x48046000 0x400>;
 			interrupts = <93>;
 			ti,hwmods = "timer5";
@@ -277,7 +277,7 @@
 		};
 
 		timer6: timer@48048000 {
-			compatible = "ti,omap2-timer";
+			compatible = "ti,am335x-timer";
 			reg = <0x48048000 0x400>;
 			interrupts = <94>;
 			ti,hwmods = "timer6";
@@ -285,7 +285,7 @@
 		};
 
 		timer7: timer@4804a000 {
-			compatible = "ti,omap2-timer";
+			compatible = "ti,am335x-timer";
 			reg = <0x4804a000 0x400>;
 			interrupts = <95>;
 			ti,hwmods = "timer7";
diff --git a/arch/arm/boot/dts/omap2.dtsi b/arch/arm/boot/dts/omap2.dtsi
index 761c4b6..8279b5f 100644
--- a/arch/arm/boot/dts/omap2.dtsi
+++ b/arch/arm/boot/dts/omap2.dtsi
@@ -68,28 +68,28 @@
 		};
 
 		timer2: timer@4802a000 {
-			compatible = "ti,omap2-timer";
+			compatible = "ti,omap2420-timer";
 			reg = <0x4802a000 0x400>;
 			interrupts = <38>;
 			ti,hwmods = "timer2";
 		};
 
 		timer3: timer@48078000 {
-			compatible = "ti,omap2-timer";
+			compatible = "ti,omap2420-timer";
 			reg = <0x48078000 0x400>;
 			interrupts = <39>;
 			ti,hwmods = "timer3";
 		};
 
 		timer4: timer@4807a000 {
-			compatible = "ti,omap2-timer";
+			compatible = "ti,omap2420-timer";
 			reg = <0x4807a000 0x400>;
 			interrupts = <40>;
 			ti,hwmods = "timer4";
 		};
 
 		timer5: timer@4807c000 {
-			compatible = "ti,omap2-timer";
+			compatible = "ti,omap2420-timer";
 			reg = <0x4807c000 0x400>;
 			interrupts = <41>;
 			ti,hwmods = "timer5";
@@ -97,7 +97,7 @@
 		};
 
 		timer6: timer@4807e000 {
-			compatible = "ti,omap2-timer";
+			compatible = "ti,omap2420-timer";
 			reg = <0x4807e000 0x400>;
 			interrupts = <42>;
 			ti,hwmods = "timer6";
@@ -105,7 +105,7 @@
 		};
 
 		timer7: timer@48080000 {
-			compatible = "ti,omap2-timer";
+			compatible = "ti,omap2420-timer";
 			reg = <0x48080000 0x400>;
 			interrupts = <43>;
 			ti,hwmods = "timer7";
@@ -113,7 +113,7 @@
 		};
 
 		timer8: timer@48082000 {
-			compatible = "ti,omap2-timer";
+			compatible = "ti,omap2420-timer";
 			reg = <0x48082000 0x400>;
 			interrupts = <44>;
 			ti,hwmods = "timer8";
@@ -121,7 +121,7 @@
 		};
 
 		timer9: timer@48084000 {
-			compatible = "ti,omap2-timer";
+			compatible = "ti,omap2420-timer";
 			reg = <0x48084000 0x400>;
 			interrupts = <45>;
 			ti,hwmods = "timer9";
@@ -129,7 +129,7 @@
 		};
 
 		timer10: timer@48086000 {
-			compatible = "ti,omap2-timer";
+			compatible = "ti,omap2420-timer";
 			reg = <0x48086000 0x400>;
 			interrupts = <46>;
 			ti,hwmods = "timer10";
@@ -137,7 +137,7 @@
 		};
 
 		timer11: timer@48088000 {
-			compatible = "ti,omap2-timer";
+			compatible = "ti,omap2420-timer";
 			reg = <0x48088000 0x400>;
 			interrupts = <47>;
 			ti,hwmods = "timer11";
@@ -145,7 +145,7 @@
 		};
 
 		timer12: timer@4808a000 {
-			compatible = "ti,omap2-timer";
+			compatible = "ti,omap2420-timer";
 			reg = <0x4808a000 0x400>;
 			interrupts = <48>;
 			ti,hwmods = "timer12";
diff --git a/arch/arm/boot/dts/omap2420.dtsi b/arch/arm/boot/dts/omap2420.dtsi
index af65609..aa58896 100644
--- a/arch/arm/boot/dts/omap2420.dtsi
+++ b/arch/arm/boot/dts/omap2420.dtsi
@@ -50,7 +50,7 @@
 		};
 
 		timer1: timer@48028000 {
-			compatible = "ti,omap2-timer";
+			compatible = "ti,omap2420-timer";
 			reg = <0x48028000 0x400>;
 			interrupts = <37>;
 			ti,hwmods = "timer1";
diff --git a/arch/arm/boot/dts/omap2430.dtsi b/arch/arm/boot/dts/omap2430.dtsi
index c392445..07065b4 100644
--- a/arch/arm/boot/dts/omap2430.dtsi
+++ b/arch/arm/boot/dts/omap2430.dtsi
@@ -91,7 +91,7 @@
 		};
 
 		timer1: timer@49018000 {
-			compatible = "ti,omap2-timer";
+			compatible = "ti,omap2420-timer";
 			reg = <0x49018000 0x400>;
 			interrupts = <37>;
 			ti,hwmods = "timer1";
diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index 1acc261..2477ce3 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -304,7 +304,7 @@
 		};
 
 		timer1: timer@48318000 {
-			compatible = "ti,omap2-timer";
+			compatible = "ti,omap3430-timer";
 			reg = <0x48318000 0x400>;
 			interrupts = <37>;
 			ti,hwmods = "timer1";
@@ -312,28 +312,28 @@
 		};
 
 		timer2: timer@49032000 {
-			compatible = "ti,omap2-timer";
+			compatible = "ti,omap3430-timer";
 			reg = <0x49032000 0x400>;
 			interrupts = <38>;
 			ti,hwmods = "timer2";
 		};
 
 		timer3: timer@49034000 {
-			compatible = "ti,omap2-timer";
+			compatible = "ti,omap3430-timer";
 			reg = <0x49034000 0x400>;
 			interrupts = <39>;
 			ti,hwmods = "timer3";
 		};
 
 		timer4: timer@49036000 {
-			compatible = "ti,omap2-timer";
+			compatible = "ti,omap3430-timer";
 			reg = <0x49036000 0x400>;
 			interrupts = <40>;
 			ti,hwmods = "timer4";
 		};
 
 		timer5: timer@49038000 {
-			compatible = "ti,omap2-timer";
+			compatible = "ti,omap3430-timer";
 			reg = <0x49038000 0x400>;
 			interrupts = <41>;
 			ti,hwmods = "timer5";
@@ -341,7 +341,7 @@
 		};
 
 		timer6: timer@4903a000 {
-			compatible = "ti,omap2-timer";
+			compatible = "ti,omap3430-timer";
 			reg = <0x4903a000 0x400>;
 			interrupts = <42>;
 			ti,hwmods = "timer6";
@@ -349,7 +349,7 @@
 		};
 
 		timer7: timer@4903c000 {
-			compatible = "ti,omap2-timer";
+			compatible = "ti,omap3430-timer";
 			reg = <0x4903c000 0x400>;
 			interrupts = <43>;
 			ti,hwmods = "timer7";
@@ -357,7 +357,7 @@
 		};
 
 		timer8: timer@4903e000 {
-			compatible = "ti,omap2-timer";
+			compatible = "ti,omap3430-timer";
 			reg = <0x4903e000 0x400>;
 			interrupts = <44>;
 			ti,hwmods = "timer8";
@@ -366,7 +366,7 @@
 		};
 
 		timer9: timer@49040000 {
-			compatible = "ti,omap2-timer";
+			compatible = "ti,omap3430-timer";
 			reg = <0x49040000 0x400>;
 			interrupts = <45>;
 			ti,hwmods = "timer9";
@@ -374,7 +374,7 @@
 		};
 
 		timer10: timer@48086000 {
-			compatible = "ti,omap2-timer";
+			compatible = "ti,omap3430-timer";
 			reg = <0x48086000 0x400>;
 			interrupts = <46>;
 			ti,hwmods = "timer10";
@@ -382,7 +382,7 @@
 		};
 
 		timer11: timer@48088000 {
-			compatible = "ti,omap2-timer";
+			compatible = "ti,omap3430-timer";
 			reg = <0x48088000 0x400>;
 			interrupts = <47>;
 			ti,hwmods = "timer11";
@@ -390,7 +390,7 @@
 		};
 
 		timer12: timer@48304000 {
-			compatible = "ti,omap2-timer";
+			compatible = "ti,omap3430-timer";
 			reg = <0x48304000 0x400>;
 			interrupts = <95>;
 			ti,hwmods = "timer12";
diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 739bb79..bd14384 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -441,7 +441,7 @@
 		};
 
 		timer1: timer@4a318000 {
-			compatible = "ti,omap2-timer";
+			compatible = "ti,omap3430-timer";
 			reg = <0x4a318000 0x80>;
 			interrupts = <0 37 0x4>;
 			ti,hwmods = "timer1";
@@ -449,28 +449,28 @@
 		};
 
 		timer2: timer@48032000 {
-			compatible = "ti,omap2-timer";
+			compatible = "ti,omap3430-timer";
 			reg = <0x48032000 0x80>;
 			interrupts = <0 38 0x4>;
 			ti,hwmods = "timer2";
 		};
 
 		timer3: timer@48034000 {
-			compatible = "ti,omap2-timer";
+			compatible = "ti,omap4430-timer";
 			reg = <0x48034000 0x80>;
 			interrupts = <0 39 0x4>;
 			ti,hwmods = "timer3";
 		};
 
 		timer4: timer@48036000 {
-			compatible = "ti,omap2-timer";
+			compatible = "ti,omap4430-timer";
 			reg = <0x48036000 0x80>;
 			interrupts = <0 40 0x4>;
 			ti,hwmods = "timer4";
 		};
 
 		timer5: timer@40138000 {
-			compatible = "ti,omap2-timer";
+			compatible = "ti,omap4430-timer";
 			reg = <0x40138000 0x80>,
 			      <0x49038000 0x80>;
 			interrupts = <0 41 0x4>;
@@ -479,7 +479,7 @@
 		};
 
 		timer6: timer@4013a000 {
-			compatible = "ti,omap2-timer";
+			compatible = "ti,omap4430-timer";
 			reg = <0x4013a000 0x80>,
 			      <0x4903a000 0x80>;
 			interrupts = <0 42 0x4>;
@@ -488,7 +488,7 @@
 		};
 
 		timer7: timer@4013c000 {
-			compatible = "ti,omap2-timer";
+			compatible = "ti,omap4430-timer";
 			reg = <0x4013c000 0x80>,
 			      <0x4903c000 0x80>;
 			interrupts = <0 43 0x4>;
@@ -497,7 +497,7 @@
 		};
 
 		timer8: timer@4013e000 {
-			compatible = "ti,omap2-timer";
+			compatible = "ti,omap4430-timer";
 			reg = <0x4013e000 0x80>,
 			      <0x4903e000 0x80>;
 			interrupts = <0 44 0x4>;
@@ -507,7 +507,7 @@
 		};
 
 		timer9: timer@4803e000 {
-			compatible = "ti,omap2-timer";
+			compatible = "ti,omap4430-timer";
 			reg = <0x4803e000 0x80>;
 			interrupts = <0 45 0x4>;
 			ti,hwmods = "timer9";
@@ -515,7 +515,7 @@
 		};
 
 		timer10: timer@48086000 {
-			compatible = "ti,omap2-timer";
+			compatible = "ti,omap3430-timer";
 			reg = <0x48086000 0x80>;
 			interrupts = <0 46 0x4>;
 			ti,hwmods = "timer10";
@@ -523,7 +523,7 @@
 		};
 
 		timer11: timer@48088000 {
-			compatible = "ti,omap2-timer";
+			compatible = "ti,omap4430-timer";
 			reg = <0x48088000 0x80>;
 			interrupts = <0 47 0x4>;
 			ti,hwmods = "timer11";
diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 790bb2a..31f5a5f 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -387,7 +387,7 @@
 		};
 
 		timer1: timer@4ae18000 {
-			compatible = "ti,omap2-timer";
+			compatible = "ti,omap5430-timer";
 			reg = <0x4ae18000 0x80>;
 			interrupts = <0 37 0x4>;
 			ti,hwmods = "timer1";
@@ -395,28 +395,28 @@
 		};
 
 		timer2: timer@48032000 {
-			compatible = "ti,omap2-timer";
+			compatible = "ti,omap5430-timer";
 			reg = <0x48032000 0x80>;
 			interrupts = <0 38 0x4>;
 			ti,hwmods = "timer2";
 		};
 
 		timer3: timer@48034000 {
-			compatible = "ti,omap2-timer";
+			compatible = "ti,omap5430-timer";
 			reg = <0x48034000 0x80>;
 			interrupts = <0 39 0x4>;
 			ti,hwmods = "timer3";
 		};
 
 		timer4: timer@48036000 {
-			compatible = "ti,omap2-timer";
+			compatible = "ti,omap5430-timer";
 			reg = <0x48036000 0x80>;
 			interrupts = <0 40 0x4>;
 			ti,hwmods = "timer4";
 		};
 
 		timer5: timer@40138000 {
-			compatible = "ti,omap2-timer";
+			compatible = "ti,omap5430-timer";
 			reg = <0x40138000 0x80>,
 			      <0x49038000 0x80>;
 			interrupts = <0 41 0x4>;
@@ -425,7 +425,7 @@
 		};
 
 		timer6: timer@4013a000 {
-			compatible = "ti,omap2-timer";
+			compatible = "ti,omap5430-timer";
 			reg = <0x4013a000 0x80>,
 			      <0x4903a000 0x80>;
 			interrupts = <0 42 0x4>;
@@ -435,7 +435,7 @@
 		};
 
 		timer7: timer@4013c000 {
-			compatible = "ti,omap2-timer";
+			compatible = "ti,omap5430-timer";
 			reg = <0x4013c000 0x80>,
 			      <0x4903c000 0x80>;
 			interrupts = <0 43 0x4>;
@@ -444,7 +444,7 @@
 		};
 
 		timer8: timer@4013e000 {
-			compatible = "ti,omap2-timer";
+			compatible = "ti,omap5430-timer";
 			reg = <0x4013e000 0x80>,
 			      <0x4903e000 0x80>;
 			interrupts = <0 44 0x4>;
@@ -454,21 +454,21 @@
 		};
 
 		timer9: timer@4803e000 {
-			compatible = "ti,omap2-timer";
+			compatible = "ti,omap5430-timer";
 			reg = <0x4803e000 0x80>;
 			interrupts = <0 45 0x4>;
 			ti,hwmods = "timer9";
 		};
 
 		timer10: timer@48086000 {
-			compatible = "ti,omap2-timer";
+			compatible = "ti,omap5430-timer";
 			reg = <0x48086000 0x80>;
 			interrupts = <0 46 0x4>;
 			ti,hwmods = "timer10";
 		};
 
 		timer11: timer@48088000 {
-			compatible = "ti,omap2-timer";
+			compatible = "ti,omap5430-timer";
 			reg = <0x48088000 0x80>;
 			interrupts = <0 47 0x4>;
 			ti,hwmods = "timer11";
diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 2bdd4cf..14b89af 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -143,7 +143,12 @@ static struct property device_disabled = {
 };
 
 static struct of_device_id omap_timer_match[] __initdata = {
-	{ .compatible = "ti,omap2-timer", },
+	{ .compatible = "ti,omap2420-timer", },
+	{ .compatible = "ti,omap3430-timer", },
+	{ .compatible = "ti,omap4430-timer", },
+	{ .compatible = "ti,omap5430-timer", },
+	{ .compatible = "ti,am335x-timer", },
+	{ .compatible = "ti,am335x-timer-1ms", },
 	{ }
 };
 
diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 05efb37..b50d478 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -895,7 +895,12 @@ static int omap_dm_timer_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id omap_timer_match[] = {
-	{ .compatible = "ti,omap2-timer", },
+	{ .compatible = "ti,omap2420-timer", },
+	{ .compatible = "ti,omap3430-timer", },
+	{ .compatible = "ti,omap4430-timer", },
+	{ .compatible = "ti,omap5430-timer", },
+	{ .compatible = "ti,am335x-timer", },
+	{ .compatible = "ti,am335x-timer-1ms", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, omap_timer_match);
-- 
1.7.10.4

