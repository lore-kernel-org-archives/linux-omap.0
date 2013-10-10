From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/8] ARM: dts: Shared file for omap GPMC connected smsc911x
Date: Thu, 10 Oct 2013 15:20:49 -0700
Message-ID: <20131010222049.9063.76211.stgit@localhost>
References: <20131010221833.9063.49904.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:48209 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753259Ab3JJWUu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Oct 2013 18:20:50 -0400
In-Reply-To: <20131010221833.9063.49904.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org

Looks like at least Igep, Zoom and EVM boards can use a
common file for the GPMC connected smsc911x.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/omap-gpmc-smsc911x.dtsi |   52 +++++++++++++++++++++++++++++
 arch/arm/boot/dts/omap3-igep0020.dts      |   45 +------------------------
 2 files changed, 54 insertions(+), 43 deletions(-)
 create mode 100644 arch/arm/boot/dts/omap-gpmc-smsc911x.dtsi

diff --git a/arch/arm/boot/dts/omap-gpmc-smsc911x.dtsi b/arch/arm/boot/dts/omap-gpmc-smsc911x.dtsi
new file mode 100644
index 0000000..9c18adf
--- /dev/null
+++ b/arch/arm/boot/dts/omap-gpmc-smsc911x.dtsi
@@ -0,0 +1,52 @@
+/*
+ * Common file for GPMC connected smsc911x on omaps
+ *
+ * Note that the board specifc DTS file needs to specify
+ * ranges, pinctrl, reg, interrupt parent and interrupts.
+ */
+
+/ {
+	vddvario: regulator-vddvario {
+		  compatible = "regulator-fixed";
+		  regulator-name = "vddvario";
+		  regulator-always-on;
+	};
+
+	vdd33a: regulator-vdd33a {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd33a";
+		regulator-always-on;
+	};
+};
+
+&gpmc {
+	ethernet@gpmc {
+		compatible = "smsc,lan9221", "smsc,lan9115";
+		bank-width = <2>;
+		gpmc,mux-add-data;
+		gpmc,cs-on-ns = <0>;
+		gpmc,cs-rd-off-ns = <186>;
+		gpmc,cs-wr-off-ns = <186>;
+		gpmc,adv-on-ns = <12>;
+		gpmc,adv-rd-off-ns = <48>;
+		gpmc,adv-wr-off-ns = <48>;
+		gpmc,oe-on-ns = <54>;
+		gpmc,oe-off-ns = <168>;
+		gpmc,we-on-ns = <54>;
+		gpmc,we-off-ns = <168>;
+		gpmc,rd-cycle-ns = <186>;
+		gpmc,wr-cycle-ns = <186>;
+		gpmc,access-ns = <114>;
+		gpmc,page-burst-access-ns = <6>;
+		gpmc,bus-turnaround-ns = <12>;
+		gpmc,cycle2cycle-delay-ns = <18>;
+		gpmc,wr-data-mux-bus-ns = <90>;
+		gpmc,wr-access-ns = <186>;
+		gpmc,cycle2cycle-samecsen;
+		gpmc,cycle2cycle-diffcsen;
+		vmmc-supply = <&vddvario>;
+		vmmc_aux-supply = <&vdd33a>;
+		reg-io-width = <4>;
+		smsc,save-mac-address;
+	};
+};
diff --git a/arch/arm/boot/dts/omap3-igep0020.dts b/arch/arm/boot/dts/omap3-igep0020.dts
index e8c4828..503d928 100644
--- a/arch/arm/boot/dts/omap3-igep0020.dts
+++ b/arch/arm/boot/dts/omap3-igep0020.dts
@@ -10,6 +10,7 @@
  */
 
 #include "omap3-igep.dtsi"
+#include "omap-gpmc-smsc911x.dtsi"
 
 / {
 	model = "IGEPv2";
@@ -40,18 +41,6 @@
 			gpios = <&twl_gpio 19 GPIO_ACTIVE_LOW>;
 		};
 	};
-
-	vddvario: regulator-vddvario {
-		  compatible = "regulator-fixed";
-		  regulator-name = "vddvario";
-		  regulator-always-on;
-	};
-
-	vdd33a: regulator-vdd33a {
-		compatible = "regulator-fixed";
-		regulator-name = "vdd33a";
-		regulator-always-on;
-	};
 };
 
 &i2c3 {
@@ -117,41 +106,11 @@
 		};
 	};
 
-	ethernet@5,0 {
+	ethernet@gpmc {
 		pinctrl-names = "default";
 		pinctrl-0 = <&smsc911x_pins>;
-		compatible = "smsc,lan9221", "smsc,lan9115";
 		reg = <5 0 0xff>;
-		bank-width = <2>;
-
-		gpmc,mux-add-data;
-		gpmc,cs-on-ns = <0>;
-		gpmc,cs-rd-off-ns = <186>;
-		gpmc,cs-wr-off-ns = <186>;
-		gpmc,adv-on-ns = <12>;
-		gpmc,adv-rd-off-ns = <48>;
-		gpmc,adv-wr-off-ns = <48>;
-		gpmc,oe-on-ns = <54>;
-		gpmc,oe-off-ns = <168>;
-		gpmc,we-on-ns = <54>;
-		gpmc,we-off-ns = <168>;
-		gpmc,rd-cycle-ns = <186>;
-		gpmc,wr-cycle-ns = <186>;
-		gpmc,access-ns = <114>;
-		gpmc,page-burst-access-ns = <6>;
-		gpmc,bus-turnaround-ns = <12>;
-		gpmc,cycle2cycle-delay-ns = <18>;
-		gpmc,wr-data-mux-bus-ns = <90>;
-		gpmc,wr-access-ns = <186>;
-		gpmc,cycle2cycle-samecsen;
-		gpmc,cycle2cycle-diffcsen;
-
 		interrupt-parent = <&gpio6>;
 		interrupts = <16 8>;
-		vmmc-supply = <&vddvario>;
-		vmmc_aux-supply = <&vdd33a>;
-		reg-io-width = <4>;
-
-		smsc,save-mac-address;
 	};
 };

