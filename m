From: Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v3 2/2] arm/dts: twl: Pass regulator data from dt
Date: Thu, 23 Feb 2012 17:05:54 +0530
Message-ID: <1329996954-27083-3-git-send-email-rnayak@ti.com>
References: <1329996954-27083-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <1329996954-27083-1-git-send-email-rnayak-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Cc: linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lrg-l0cyMroinI0@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Pass all the voltage regulator information for
twl6030/twl4030 PMIC from device tree.

Signed-off-by: Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>
Signed-off-by: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/omap3-beagle.dts |    6 +++
 arch/arm/boot/dts/twl4030.dtsi     |   18 +++++++++++
 arch/arm/boot/dts/twl6030.dtsi     |   60 ++++++++++++++++++++++++++++++++++++
 3 files changed, 84 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/omap3-beagle.dts
index 714ba5d..54556b1 100644
--- a/arch/arm/boot/dts/omap3-beagle.dts
+++ b/arch/arm/boot/dts/omap3-beagle.dts
@@ -26,6 +26,12 @@
 		reg = <0x48>;
 		interrupts = <7>; /* SYS_NIRQ cascaded to intc */
 		interrupt-parent = <&intc>;
+
+		vsim: regulator@10 {
+			compatible = "ti,twl4030-vsim";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <3000000>;
+		};
 	};
 };
 
diff --git a/arch/arm/boot/dts/twl4030.dtsi b/arch/arm/boot/dts/twl4030.dtsi
index 8be5223..a94654c 100644
--- a/arch/arm/boot/dts/twl4030.dtsi
+++ b/arch/arm/boot/dts/twl4030.dtsi
@@ -18,4 +18,22 @@
 		compatible = "ti,twl4030-rtc";
 		interrupts = <11>;
 	};
+
+	vdac: regulator@0 {
+		compatible = "ti,twl4030-vdac";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
+	vpll2: regulator@1 {
+		compatible = "ti,twl4030-vpll2";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
+	vmmc1: regulator@2 {
+		compatible = "ti,twl4030-vmmc1";
+		regulator-min-microvolt = <1850000>;
+		regulator-max-microvolt = <3150000>;
+	};
 };
diff --git a/arch/arm/boot/dts/twl6030.dtsi b/arch/arm/boot/dts/twl6030.dtsi
index b7b4e5e..efa19e8 100644
--- a/arch/arm/boot/dts/twl6030.dtsi
+++ b/arch/arm/boot/dts/twl6030.dtsi
@@ -19,4 +19,64 @@
 		compatible = "ti,twl4030-rtc";
 		interrupts = <11>;
 	};
+
+	vaux1: regulator@0 {
+		compatible = "ti,twl6030-vaux1";
+		regulator-min-microvolt = <1000000>;
+		regulator-max-microvolt = <3000000>;
+	};
+
+	vaux2: regulator@1 {
+		compatible = "ti,twl6030-vaux2";
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <2800000>;
+	};
+
+	vaux3: regulator@2 {
+		compatible = "ti,twl6030-vaux3";
+		regulator-min-microvolt = <1000000>;
+		regulator-max-microvolt = <3000000>;
+	};
+
+	vmmc: regulator@3 {
+		compatible = "ti,twl6030-vmmc";
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <3000000>;
+	};
+
+	vpp: regulator@4 {
+		compatible = "ti,twl6030-vpp";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <2500000>;
+	};
+
+	vusim: regulator@5 {
+		compatible = "ti,twl6030-vusim";
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <2900000>;
+	};
+
+	vdac: regulator@6 {
+		compatible = "ti,twl6030-vdac";
+	};
+
+	vana: regulator@7 {
+		compatible = "ti,twl6030-vana";
+	};
+
+	vcxio: regulator@8 {
+		compatible = "ti,twl6030-vcxio";
+	};
+
+	vusb: regulator@9 {
+		compatible = "ti,twl6030-vusb";
+	};
+
+	vusb: regulator@9 {
+		compatible = "ti,twl6030-vusb";
+	};
+
+	clk32kg: regulator@10 {
+		compatible = "ti,twl6030-clk32kg";
+	};
 };
-- 
1.7.1
