From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH v1] ARM: dts: omap3-n900: Specify peripherals LDO regulators initial mode
Date: Sun, 17 Apr 2016 17:29:23 +0300
Message-ID: <1460903363-2197-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
References: <20160417122933.GA8093@earth>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160417122933.GA8093@earth>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, bcousson@baylibre.com
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, sre@kernel.org, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
List-Id: linux-omap@vger.kernel.org

Without that, regulators are left in the mode last set by the bootloader or
by the kernel the device was rebooted from. This leads to various problems,
like non-working peripherals.

Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
---
 arch/arm/boot/dts/omap3-n900.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
index b3c26a9..d9e2d9c 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -329,6 +329,7 @@
 	regulator-name = "V28";
 	regulator-min-microvolt = <2800000>;
 	regulator-max-microvolt = <2800000>;
+	regulator-initial-mode = <0x0e>; /* RES_STATE_ACTIVE */
 	regulator-always-on; /* due to battery cover sensor */
 };
 
@@ -336,30 +337,35 @@
 	regulator-name = "VCSI";
 	regulator-min-microvolt = <1800000>;
 	regulator-max-microvolt = <1800000>;
+	regulator-initial-mode = <0x0e>; /* RES_STATE_ACTIVE */
 };
 
 &vaux3 {
 	regulator-name = "VMMC2_30";
 	regulator-min-microvolt = <2800000>;
 	regulator-max-microvolt = <3000000>;
+	regulator-initial-mode = <0x0e>; /* RES_STATE_ACTIVE */
 };
 
 &vaux4 {
 	regulator-name = "VCAM_ANA_28";
 	regulator-min-microvolt = <2800000>;
 	regulator-max-microvolt = <2800000>;
+	regulator-initial-mode = <0x0e>; /* RES_STATE_ACTIVE */
 };
 
 &vmmc1 {
 	regulator-name = "VMMC1";
 	regulator-min-microvolt = <1850000>;
 	regulator-max-microvolt = <3150000>;
+	regulator-initial-mode = <0x0e>; /* RES_STATE_ACTIVE */
 };
 
 &vmmc2 {
 	regulator-name = "V28_A";
 	regulator-min-microvolt = <2800000>;
 	regulator-max-microvolt = <3000000>;
+	regulator-initial-mode = <0x0e>; /* RES_STATE_ACTIVE */
 	regulator-always-on; /* due VIO leak to AIC34 VDDs */
 };
 
@@ -367,6 +373,7 @@
 	regulator-name = "VPLL";
 	regulator-min-microvolt = <1800000>;
 	regulator-max-microvolt = <1800000>;
+	regulator-initial-mode = <0x0e>; /* RES_STATE_ACTIVE */
 	regulator-always-on;
 };
 
@@ -374,6 +381,7 @@
 	regulator-name = "VSDI_CSI";
 	regulator-min-microvolt = <1800000>;
 	regulator-max-microvolt = <1800000>;
+	regulator-initial-mode = <0x0e>; /* RES_STATE_ACTIVE */
 	regulator-always-on;
 };
 
@@ -381,6 +389,7 @@
 	regulator-name = "VMMC2_IO_18";
 	regulator-min-microvolt = <1800000>;
 	regulator-max-microvolt = <1800000>;
+	regulator-initial-mode = <0x0e>; /* RES_STATE_ACTIVE */
 };
 
 &vio {
-- 
1.9.1
