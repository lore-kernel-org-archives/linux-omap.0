From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 04/20] ARM: DTS: am43xx-epos-evm: Add gpio-hog for
 configuring the display/audio mux
Date: Thu, 2 Jul 2015 17:06:19 +0300
Message-ID: <1435845995-19085-5-git-send-email-peter.ujfalusi@ti.com>
References: <1435845995-19085-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1435845995-19085-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: tony@atomide.com
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org, balbi@ti.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

GPIO2_1 is used as a mux switch between LCD and HDMI displays. This mux
affects audio routing as well since in LCD mode HDMI audio is not possible
and when HDMI is selected analog audio is not working.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/am43x-epos-evm.dts | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
index 795d68af6df9..77919c570fe1 100644
--- a/arch/arm/boot/dts/am43x-epos-evm.dts
+++ b/arch/arm/boot/dts/am43x-epos-evm.dts
@@ -35,17 +35,6 @@
 		compatible = "osddisplays,osd057T0559-34ts", "panel-dpi";
 		label = "lcd";
 
-		pinctrl-names = "default";
-		pinctrl-0 = <&lcd_pins>;
-
-		/*
-		 * SelLCDorHDMI, LOW to select HDMI. This is not really the
-		 * panel's enable GPIO, but we don't have HDMI driver support nor
-		 * support to switch between two displays, so using this gpio as
-		 * panel's enable should be safe.
-		 */
-		enable-gpios = <&gpio2 1 GPIO_ACTIVE_HIGH>;
-
 		panel-timing {
 			clock-frequency = <33000000>;
 			hactive = <800>;
@@ -278,7 +267,7 @@
 			>;
 		};
 
-		lcd_pins: lcd_pins {
+		display_mux_pins: display_mux_pins {
 			pinctrl-single,pins = <
 				/* GPMC CLK -> GPIO 2_1 to select LCD / HDMI */
 				0x08C (PIN_OUTPUT_PULLUP | MUX_MODE7)
@@ -458,7 +447,21 @@
 };
 
 &gpio2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&display_mux_pins>;
 	status = "okay";
+
+	p1 {
+		/*
+		 * SelLCDorHDMI selects between display and audio paths:
+		 * Low: HDMI display with audio via HDMI
+		 * High: LCD display with analog audio via aic3111 codec
+		 */
+		gpio-hog;
+		gpios = <1 GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "SelLCDorHDMI";
+	};
 };
 
 &gpio3 {
-- 
2.4.5
