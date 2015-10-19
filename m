From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 1/3] ARM: dts: omap3-igep0020: Use IOPAD pinmux macro
Date: Mon, 19 Oct 2015 17:34:19 +0200
Message-ID: <1445268861-11857-2-git-send-email-javier@osg.samsung.com>
References: <1445268861-11857-1-git-send-email-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1445268861-11857-1-git-send-email-javier@osg.samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-kernel@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier@osg.samsung.com>, linux-omap@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Use the OMAP3 pinmux IOPAD macro to define the physical address instead
of the offset from the padconf address. It makes the DTS easier to read
since matches the addresses listed in the Technical Reference Manual.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 arch/arm/boot/dts/omap3-igep0020-common.dtsi | 58 ++++++++++++++--------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-igep0020-common.dtsi b/arch/arm/boot/dts/omap3-igep0020-common.dtsi
index 5ad688c57a00..17bf58fb9520 100644
--- a/arch/arm/boot/dts/omap3-igep0020-common.dtsi
+++ b/arch/arm/boot/dts/omap3-igep0020-common.dtsi
@@ -111,40 +111,40 @@
 
 	tfp410_pins: pinmux_tfp410_pins {
 		pinctrl-single,pins = <
-			0x196 (PIN_OUTPUT | MUX_MODE4)   /* hdq_sio.gpio_170 */
+			OMAP3_CORE1_IOPAD(0x21c6, PIN_OUTPUT | MUX_MODE4)   /* hdq_sio.gpio_170 */
 		>;
 	};
 
 	dss_dpi_pins: pinmux_dss_dpi_pins {
 		pinctrl-single,pins = <
-			0x0a4 (PIN_OUTPUT | MUX_MODE0)   /* dss_pclk.dss_pclk */
-			0x0a6 (PIN_OUTPUT | MUX_MODE0)   /* dss_hsync.dss_hsync */
-			0x0a8 (PIN_OUTPUT | MUX_MODE0)   /* dss_vsync.dss_vsync */
-			0x0aa (PIN_OUTPUT | MUX_MODE0)   /* dss_acbias.dss_acbias */
-			0x0ac (PIN_OUTPUT | MUX_MODE0)   /* dss_data0.dss_data0 */
-			0x0ae (PIN_OUTPUT | MUX_MODE0)   /* dss_data1.dss_data1 */
-			0x0b0 (PIN_OUTPUT | MUX_MODE0)   /* dss_data2.dss_data2 */
-			0x0b2 (PIN_OUTPUT | MUX_MODE0)   /* dss_data3.dss_data3 */
-			0x0b4 (PIN_OUTPUT | MUX_MODE0)   /* dss_data4.dss_data4 */
-			0x0b6 (PIN_OUTPUT | MUX_MODE0)   /* dss_data5.dss_data5 */
-			0x0b8 (PIN_OUTPUT | MUX_MODE0)   /* dss_data6.dss_data6 */
-			0x0ba (PIN_OUTPUT | MUX_MODE0)   /* dss_data7.dss_data7 */
-			0x0bc (PIN_OUTPUT | MUX_MODE0)   /* dss_data8.dss_data8 */
-			0x0be (PIN_OUTPUT | MUX_MODE0)   /* dss_data9.dss_data9 */
-			0x0c0 (PIN_OUTPUT | MUX_MODE0)   /* dss_data10.dss_data10 */
-			0x0c2 (PIN_OUTPUT | MUX_MODE0)   /* dss_data11.dss_data11 */
-			0x0c4 (PIN_OUTPUT | MUX_MODE0)   /* dss_data12.dss_data12 */
-			0x0c6 (PIN_OUTPUT | MUX_MODE0)   /* dss_data13.dss_data13 */
-			0x0c8 (PIN_OUTPUT | MUX_MODE0)   /* dss_data14.dss_data14 */
-			0x0ca (PIN_OUTPUT | MUX_MODE0)   /* dss_data15.dss_data15 */
-			0x0cc (PIN_OUTPUT | MUX_MODE0)   /* dss_data16.dss_data16 */
-			0x0ce (PIN_OUTPUT | MUX_MODE0)   /* dss_data17.dss_data17 */
-			0x0d0 (PIN_OUTPUT | MUX_MODE0)   /* dss_data18.dss_data18 */
-			0x0d2 (PIN_OUTPUT | MUX_MODE0)   /* dss_data19.dss_data19 */
-			0x0d4 (PIN_OUTPUT | MUX_MODE0)   /* dss_data20.dss_data20 */
-			0x0d6 (PIN_OUTPUT | MUX_MODE0)   /* dss_data21.dss_data21 */
-			0x0d8 (PIN_OUTPUT | MUX_MODE0)   /* dss_data22.dss_data22 */
-			0x0da (PIN_OUTPUT | MUX_MODE0)   /* dss_data23.dss_data23 */
+			OMAP3_CORE1_IOPAD(0x20d4, PIN_OUTPUT | MUX_MODE0)   /* dss_pclk.dss_pclk */
+			OMAP3_CORE1_IOPAD(0x20d6, PIN_OUTPUT | MUX_MODE0)   /* dss_hsync.dss_hsync */
+			OMAP3_CORE1_IOPAD(0x20d8, PIN_OUTPUT | MUX_MODE0)   /* dss_vsync.dss_vsync */
+			OMAP3_CORE1_IOPAD(0x20da, PIN_OUTPUT | MUX_MODE0)   /* dss_acbias.dss_acbias */
+			OMAP3_CORE1_IOPAD(0x20dc, PIN_OUTPUT | MUX_MODE0)   /* dss_data0.dss_data0 */
+			OMAP3_CORE1_IOPAD(0x20de, PIN_OUTPUT | MUX_MODE0)   /* dss_data1.dss_data1 */
+			OMAP3_CORE1_IOPAD(0x20e0, PIN_OUTPUT | MUX_MODE0)   /* dss_data2.dss_data2 */
+			OMAP3_CORE1_IOPAD(0x20e2, PIN_OUTPUT | MUX_MODE0)   /* dss_data3.dss_data3 */
+			OMAP3_CORE1_IOPAD(0x20e4, PIN_OUTPUT | MUX_MODE0)   /* dss_data4.dss_data4 */
+			OMAP3_CORE1_IOPAD(0x20e6, PIN_OUTPUT | MUX_MODE0)   /* dss_data5.dss_data5 */
+			OMAP3_CORE1_IOPAD(0x20e8, PIN_OUTPUT | MUX_MODE0)   /* dss_data6.dss_data6 */
+			OMAP3_CORE1_IOPAD(0x20ea, PIN_OUTPUT | MUX_MODE0)   /* dss_data7.dss_data7 */
+			OMAP3_CORE1_IOPAD(0x20ec, PIN_OUTPUT | MUX_MODE0)   /* dss_data8.dss_data8 */
+			OMAP3_CORE1_IOPAD(0x20ee, PIN_OUTPUT | MUX_MODE0)   /* dss_data9.dss_data9 */
+			OMAP3_CORE1_IOPAD(0x20f0, PIN_OUTPUT | MUX_MODE0)   /* dss_data10.dss_data10 */
+			OMAP3_CORE1_IOPAD(0x20f2, PIN_OUTPUT | MUX_MODE0)   /* dss_data11.dss_data11 */
+			OMAP3_CORE1_IOPAD(0x20f4, PIN_OUTPUT | MUX_MODE0)   /* dss_data12.dss_data12 */
+			OMAP3_CORE1_IOPAD(0x20f6, PIN_OUTPUT | MUX_MODE0)   /* dss_data13.dss_data13 */
+			OMAP3_CORE1_IOPAD(0x20f8, PIN_OUTPUT | MUX_MODE0)   /* dss_data14.dss_data14 */
+			OMAP3_CORE1_IOPAD(0x20fa, PIN_OUTPUT | MUX_MODE0)   /* dss_data15.dss_data15 */
+			OMAP3_CORE1_IOPAD(0x20fc, PIN_OUTPUT | MUX_MODE0)   /* dss_data16.dss_data16 */
+			OMAP3_CORE1_IOPAD(0x20fe, PIN_OUTPUT | MUX_MODE0)   /* dss_data17.dss_data17 */
+			OMAP3_CORE1_IOPAD(0x2100, PIN_OUTPUT | MUX_MODE0)   /* dss_data18.dss_data18 */
+			OMAP3_CORE1_IOPAD(0x2102, PIN_OUTPUT | MUX_MODE0)   /* dss_data19.dss_data19 */
+			OMAP3_CORE1_IOPAD(0x2104, PIN_OUTPUT | MUX_MODE0)   /* dss_data20.dss_data20 */
+			OMAP3_CORE1_IOPAD(0x2106, PIN_OUTPUT | MUX_MODE0)   /* dss_data21.dss_data21 */
+			OMAP3_CORE1_IOPAD(0x2108, PIN_OUTPUT | MUX_MODE0)   /* dss_data22.dss_data22 */
+			OMAP3_CORE1_IOPAD(0x210a, PIN_OUTPUT | MUX_MODE0)   /* dss_data23.dss_data23 */
 		>;
 	};
 
-- 
2.4.3
