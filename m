From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 2/6] ARM: dts: omap2420-n810: Correct the
	audio codec (tlv320aic33) node
Date: Fri, 27 Apr 2018 11:17:11 +0300
Message-ID: <20180427081715.28791-3-peter.ujfalusi@ti.com>
References: <20180427081715.28791-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20180427081715.28791-1-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, jarkko.nikula@bitmer.com, tony@atomide.com
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, aaro.koskinen@iki.fi
List-Id: linux-omap@vger.kernel.org

- The n810 uses tlv320aic33 codec.
- GPIO118 is used as reset GPIO for the codec, which was missing.
- The MCLK of the codec is connected to the SYS_CLKOUT2 of omap2420. The
  SYS_CLKOUT2 needs to be running at 12MHz.
- Add the pinctrl entries to configure the pins for GPIO118 and SYS_CLKOUT2
- Set DMIC clk mode for GPIO1
- Set DMIC data in for GPIO2
- Select 2V for the DMIC bias
- Add fixed regulators for the codec

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/omap2420-n810.dts | 46 +++++++++++++++++++++++++++--
 1 file changed, 44 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/omap2420-n810.dts b/arch/arm/boot/dts/omap2420-n810.dts
index 4c412a480c3e..96b9913ecc1f 100644
--- a/arch/arm/boot/dts/omap2420-n810.dts
+++ b/arch/arm/boot/dts/omap2420-n810.dts
@@ -6,6 +6,20 @@
 / {
 	model = "Nokia N810";
 	compatible = "nokia,n810", "nokia,n8x0", "ti,omap2420", "ti,omap2";
+
+	vio_ape: vio_ape {
+		compatible = "regulator-fixed";
+		regulator-name = "vio_ape";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
+	v28_aic: v28_aic {
+		compatible = "regulator-fixed";
+		regulator-name = "v28_aic";
+		regulator-min-microvolt = <2800000>;
+		regulator-max-microvolt = <2800000>;
+	};
 };
 
 &omap2420_pmx {
@@ -17,14 +31,42 @@
 			OMAP2420_CORE_IOPAD(0x0127, PIN_OUTPUT | MUX_MODE1)	/* eac_ac_dout.mcbsp2_dx */
 		>;
 	};
+
+	aic33_pins: aic33_pins {
+		pinctrl-single,pins = <
+			OMAP2420_CORE_IOPAD(0x0129, PIN_OUTPUT | MUX_MODE3)	/* eac_ac_rst.gpio118 */
+			OMAP2420_CORE_IOPAD(0x00e8, PIN_OUTPUT | MUX_MODE2)	/* vlynq_tx1.sys_clkout2 */
+		>;
+	};
 };
 
 &i2c2 {
-	aic3x@18 {
-		compatible = "tlv320aic3x";
+	aic33@18 {
+		compatible = "ti,tlv320aic33";
 		reg = <0x18>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&aic33_pins>;
+
+		gpio-reset = <&gpio4 22 GPIO_ACTIVE_LOW>; /* gpio118 */
+
+		ai3x-gpio-func = <
+			10 /* AIC3X_GPIO1_FUNC_DIGITAL_MIC_MODCLK */
+			5 /* AIC3X_GPIO2_FUNC_DIGITAL_MIC_INPUT */
+		>;
+		ai3x-micbias-vg = <1>; /* 2V */
+
+		AVDD-supply = <&v28_aic>;
+		DRVDD-supply = <&v28_aic>;
+		IOVDD-supply = <&vio_ape>;
+		DVDD-supply = <&vio_ape>;
+
+		assigned-clocks = <&sys_clkout2_src>, <&sys_clkout2>;
+		assigned-clock-parents = <&func_96m_ck>;
+		assigned-clock-rates = <0>, <12000000>;
 	};
 };
+
 &mcbsp2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mcbsp2_pins>;
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
