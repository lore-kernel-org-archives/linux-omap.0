From: <jgq516@gmail.com>
Subject: [PATCHv2 1/3] arm/dts: add wdt node for omap3 and omap4
Date: Fri, 1 Jun 2012 12:44:14 +0800
Message-ID: <1338525856-4359-2-git-send-email-jgq516@gmail.com>
References: <1338525856-4359-1-git-send-email-jgq516@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1338525856-4359-1-git-send-email-jgq516@gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: grant.likely@secretlab.ca, rob.herring@calxeda.com, rob@landley.net, linux@arm.linux.org.uk, b-cousson@ti.com, rnayak@ti.com, tony@atomide.com, wim@iguana.be, jon-hunter@ti.com
Cc: devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-watchdog@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Xiao Jiang <jgq516@gmail.com>

Add wdt node to support dt.

Signed-off-by: Xiao Jiang <jgq516@gmail.com>
---
 .../devicetree/bindings/watchdog/omap-wdt.txt      |   14 ++++++++++++++
 arch/arm/boot/dts/omap3.dtsi                       |    5 +++++
 arch/arm/boot/dts/omap4.dtsi                       |    5 +++++
 3 files changed, 24 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/watchdog/omap-wdt.txt

diff --git a/Documentation/devicetree/bindings/watchdog/omap-wdt.txt b/Documentation/devicetree/bindings/watchdog/omap-wdt.txt
new file mode 100644
index 0000000..c227970
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/omap-wdt.txt
@@ -0,0 +1,14 @@
+TI Watchdog Timer (WDT) Controller for OMAP
+
+Required properties:
+compatible:
+- "ti,omap3-wdt" for OMAP3
+- "ti,omap4-wdt" for OMAP4
+- ti,hwmods: Name of the hwmod associated to the WDT
+
+Examples:
+
+wdt2: wdt@4a314000 {
+	compatible = "ti,omap4-wdt", "ti,omap3-wdt";
+	ti,hwmods = "wd_timer2";
+};
diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index 99474fa..8109471 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -215,5 +215,10 @@
 			compatible = "ti,omap3-hsmmc";
 			ti,hwmods = "mmc3";
 		};
+
+		wdt2: wdt@48314000 {
+			compatible = "ti,omap3-wdt";
+			ti,hwmods = "wd_timer2";
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 359c497..3664641 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -272,5 +272,10 @@
 			ti,hwmods = "mmc5";
 			ti,needs-special-reset;
 		};
+
+		wdt2: wdt@4a314000 {
+			compatible = "ti,omap4-wdt", "ti,omap3-wdt";
+			ti,hwmods = "wd_timer2";
+		};
 	};
 };
-- 
1.7.3

