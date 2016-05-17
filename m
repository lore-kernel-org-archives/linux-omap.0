From: Marek Belisko <marek@goldelico.com>
Subject: [PATCH 1/5] ARM: dts: omap3-gta04: Add backlight support
Date: Tue, 17 May 2016 21:48:47 +0200
Message-ID: <1463514531-7235-2-git-send-email-marek@goldelico.com>
References: <1463514531-7235-1-git-send-email-marek@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1463514531-7235-1-git-send-email-marek@goldelico.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: bcousson@baylibre.com, tony@atomide.com, robh+dt@kernel.org, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@armlinux.org.uk
Cc: devicetree@vger.kernel.org, hns@goldelico.com, linux-kernel@vger.kernel.org, Marek Belisko <marek@goldelico.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Define pwm backlight node which is using dmtimer pwm.

Signed-off-by: Marek Belisko <marek@goldelico.com>
---
 arch/arm/boot/dts/omap3-gta04.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index ab9fb8f..cef8b23 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -100,6 +100,22 @@
 		};
 	};
 
+	backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pwm11 0 2000000 0>;
+		pwm-names = "backlight";
+		brightness-levels = <0 11 20 30 40 50 60 70 80 90 100>;
+		default-brightness-level = <9>;	/* => 90 */
+		pinctrl-names = "default";
+		pinctrl-0 = <&backlight_pins>;
+	};
+
+	pwm11: dmtimer-pwm@11 {
+		compatible = "ti,omap-dmtimer-pwm";
+		ti,timers = <&timer11>;
+		#pwm-cells = <3>;
+	};
+
 	hsusb2_phy: hsusb2_phy {
 		compatible = "usb-nop-xceiv";
 		reset-gpios = <&gpio6 14 GPIO_ACTIVE_LOW>;
@@ -190,6 +206,12 @@
 		>;
 	};
 
+	backlight_pins: backlight_pins_pimnux {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x20ba, MUX_MODE3)		/* gpt11/gpio57 */
+		>;
+	};
+
 	dss_dpi_pins: pinmux_dss_dpi_pins {
                pinctrl-single,pins = <
 			OMAP3_CORE1_IOPAD(0x20d4, PIN_OUTPUT | MUX_MODE0)   /* dss_pclk.dss_pclk */
-- 
2.5.0
