From: Vaibhav Hiremath <hvaibhav-l0cyMroinI0@public.gmane.org>
Subject: [PATCH-V2 6/6] ARM: dts: AM33XX: Add default pinctrl binding for
 UART0 device
Date: Thu, 28 Mar 2013 12:12:43 +0530
Message-ID: <1364452963-22083-7-git-send-email-hvaibhav@ti.com>
References: <1364452963-22083-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1364452963-22083-1-git-send-email-hvaibhav-l0cyMroinI0@public.gmane.org>
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
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: mporter-l0cyMroinI0@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Add pin control binding for UART0 device nodes in all
board specific DT files.

Signed-off-by: Vaibhav Hiremath <hvaibhav-l0cyMroinI0@public.gmane.org>
Acked-by: Matt Porter <mporter-l0cyMroinI0@public.gmane.org>
Cc: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/am335x-bone.dts  |   10 ++++++++++
 arch/arm/boot/dts/am335x-evm.dts   |   10 ++++++++++
 arch/arm/boot/dts/am335x-evmsk.dts |   10 ++++++++++
 3 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x-bone.dts
index be2c501..bfba6fc 100644
--- a/arch/arm/boot/dts/am335x-bone.dts
+++ b/arch/arm/boot/dts/am335x-bone.dts
@@ -43,10 +43,20 @@
 				0x18c 0x30	/* i2c0_scl.i2c0_scl PULLUP | INPUTENABLE | MODE0 */
 			>;
 		};
+
+		uart0_pins: pinmux_uart0_pins {
+			pinctrl-single,pins = <
+				0x170 0x30	/* uart0_rxd.uart0_rxd PULLUP | INPUTENABLE | MODE0 */
+				0x174 0x00	/* uart0_txd.uart0_txd PULLDOWN | MODE0 */
+			>;
+		};
 	};

 	ocp {
 		uart0: serial@44e09000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&uart0_pins>;
+
 			status = "okay";
 		};

diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index 2f3f5be..f598ed2 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -58,10 +58,20 @@
 				0x15c 0x32	/* spi0_cs0.i2c1_scl PULLUP | INPUTENABLE | MODE2 */
 			>;
 		};
+
+		uart0_pins: pinmux_uart0_pins {
+			pinctrl-single,pins = <
+				0x170 0x30	/* uart0_rxd.uart0_rxd PULLUP | INPUTENABLE | MODE0 */
+				0x174 0x00	/* uart0_txd.uart0_txd PULLDOWN | MODE0 */
+			>;
+		};
 	};

 	ocp {
 		uart0: serial@44e09000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&uart0_pins>;
+
 			status = "okay";
 		};

diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/am335x-evmsk.dts
index bcd7028..0eec644 100644
--- a/arch/arm/boot/dts/am335x-evmsk.dts
+++ b/arch/arm/boot/dts/am335x-evmsk.dts
@@ -58,10 +58,20 @@
 				0x18c 0x30	/* i2c0_scl.i2c0_scl PULLUP | INPUTENABLE | MODE0 */
 			>;
 		};
+
+		uart0_pins: pinmux_uart0_pins {
+			pinctrl-single,pins = <
+				0x170 0x30	/* uart0_rxd.uart0_rxd PULLUP | INPUTENABLE | MODE0 */
+				0x174 0x00	/* uart0_txd.uart0_txd PULLDOWN | MODE0 */
+			>;
+		};
 	};

 	ocp {
 		uart0: serial@44e09000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&uart0_pins>;
+
 			status = "okay";
 		};

--
1.7.0.4
