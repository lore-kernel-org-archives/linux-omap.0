From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: [PATCH 08/18] ARM: dts: omap: Add common file for SMSC9221
Date: Thu,  9 Jan 2014 17:48:02 +0100
Message-ID: <1389286092-27087-9-git-send-email-florian.vaussard@epfl.ch>
References: <1389286092-27087-1-git-send-email-florian.vaussard@epfl.ch>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp4.epfl.ch ([128.178.224.219]:41038 "EHLO smtp4.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755863AbaAIQsr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 9 Jan 2014 11:48:47 -0500
In-Reply-To: <1389286092-27087-1-git-send-email-florian.vaussard@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Benoit Cousson <bcousson@baylibre.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, florian.vaussard@epfl.ch

Some devices (SMSC9217, SMSC9218 and SMSC9221 at least) have better
timings, allowing a higher transfer speed. Create a common file
with these timings.

Performance results with iperf:

- omap-gpmc-smsc911x.dtsi => 54.9 Mbps
- omap-gpmc-smsc9221.dtsi => 92.7 Mbps

Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
---
 arch/arm/boot/dts/omap-gpmc-smsc9221.dtsi | 58 +++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 arch/arm/boot/dts/omap-gpmc-smsc9221.dtsi

diff --git a/arch/arm/boot/dts/omap-gpmc-smsc9221.dtsi b/arch/arm/boot/dts/omap-gpmc-smsc9221.dtsi
new file mode 100644
index 0000000..73e272f
--- /dev/null
+++ b/arch/arm/boot/dts/omap-gpmc-smsc9221.dtsi
@@ -0,0 +1,58 @@
+/*
+ * Common file for GPMC connected smsc9221 on omaps
+ *
+ * Compared to smsc911x, smsc9221 (and others like smsc9217
+ * or smsc 9218) has faster timings, leading to higher
+ * bandwidth.
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
+		compatible = "smsc,lan9221","smsc,lan9115";
+		bank-width = <2>;
+
+		gpmc,mux-add-data;
+		gpmc,cs-on-ns = <0>;
+		gpmc,cs-rd-off-ns = <42>;
+		gpmc,cs-wr-off-ns = <36>;
+		gpmc,adv-on-ns = <6>;
+		gpmc,adv-rd-off-ns = <12>;
+		gpmc,adv-wr-off-ns = <12>;
+		gpmc,oe-on-ns = <0>;
+		gpmc,oe-off-ns = <42>;
+		gpmc,we-on-ns = <0>;
+		gpmc,we-off-ns = <36>;
+		gpmc,rd-cycle-ns = <60>;
+		gpmc,wr-cycle-ns = <54>;
+		gpmc,access-ns = <36>;
+		gpmc,page-burst-access-ns = <0>;
+		gpmc,bus-turnaround-ns = <0>;
+		gpmc,cycle2cycle-delay-ns = <0>;
+		gpmc,wr-data-mux-bus-ns = <18>;
+		gpmc,wr-access-ns = <42>;
+		gpmc,cycle2cycle-samecsen;
+		gpmc,cycle2cycle-diffcsen;
+
+		vddvario-supply = <&vddvario>;
+		vdd33a-supply = <&vdd33a>;
+		reg-io-width = <4>;
+		smsc,save-mac-address;
+	};
+};
-- 
1.8.1.2

