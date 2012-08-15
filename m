From: Vaibhav Hiremath <hvaibhav-l0cyMroinI0@public.gmane.org>
Subject: [PATCH-V2] arm/dts: AM33XX: Set the default status of module to
 "disabled" state
Date: Wed, 15 Aug 2012 16:53:25 +0530
Message-ID: <1345029805-27987-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Ideally in common SoC dtsi file should set all modules
to "disabled" state and it should get enabled in respective
EVM/Board dts file as per usage.

This patch sets default status of all modules to "disabled"
state in am33xx.dtsi file. Currently there are no modules
supported as part of Bone and EVM dts support, so care
to add entry "status = "okay"" while adding support for any
module.

Signed-off-by: Vaibhav Hiremath <hvaibhav-l0cyMroinI0@public.gmane.org>
Acked-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
Changes from V1:
	- Fixed indentation issue caused due to extra spaces.

 arch/arm/boot/dts/am335x-bone.dts |    6 ++++++
 arch/arm/boot/dts/am335x-evm.dts  |    6 ++++++
 arch/arm/boot/dts/am33xx.dtsi     |    9 +++++++++
 3 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x-bone.dts
index a9af4db..a7906cb 100644
--- a/arch/arm/boot/dts/am335x-bone.dts
+++ b/arch/arm/boot/dts/am335x-bone.dts
@@ -17,4 +17,10 @@
 		device_type = "memory";
 		reg = <0x80000000 0x10000000>; /* 256 MB */
 	};
+
+	ocp {
+		uart1: serial@44E09000 {
+			status = "okay";
+		};
+	};
 };
diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index d6a97d9..5dd8a6b 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -17,4 +17,10 @@
 		device_type = "memory";
 		reg = <0x80000000 0x10000000>; /* 256 MB */
 	};
+
+	ocp {
+		uart1: serial@44E09000 {
+			status = "okay";
+		};
+	};
 };
diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 59509c4..5f6c8e3 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -102,36 +102,42 @@
 			compatible = "ti,omap3-uart";
 			ti,hwmods = "uart1";
 			clock-frequency = <48000000>;
+			status = "disabled";
 		};

 		uart2: serial@48022000 {
 			compatible = "ti,omap3-uart";
 			ti,hwmods = "uart2";
 			clock-frequency = <48000000>;
+			status = "disabled";
 		};

 		uart3: serial@48024000 {
 			compatible = "ti,omap3-uart";
 			ti,hwmods = "uart3";
 			clock-frequency = <48000000>;
+			status = "disabled";
 		};

 		uart4: serial@481A6000 {
 			compatible = "ti,omap3-uart";
 			ti,hwmods = "uart4";
 			clock-frequency = <48000000>;
+			status = "disabled";
 		};

 		uart5: serial@481A8000 {
 			compatible = "ti,omap3-uart";
 			ti,hwmods = "uart5";
 			clock-frequency = <48000000>;
+			status = "disabled";
 		};

 		uart6: serial@481AA000 {
 			compatible = "ti,omap3-uart";
 			ti,hwmods = "uart6";
 			clock-frequency = <48000000>;
+			status = "disabled";
 		};

 		i2c1: i2c@44E0B000 {
@@ -139,6 +145,7 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "i2c1";
+			status = "disabled";
 		};

 		i2c2: i2c@4802A000 {
@@ -146,6 +153,7 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "i2c2";
+			status = "disabled";
 		};

 		i2c3: i2c@4819C000 {
@@ -153,6 +161,7 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "i2c3";
+			status = "disabled";
 		};
 	};
 };
--
1.7.0.4
