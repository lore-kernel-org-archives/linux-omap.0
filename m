From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 1/5] ARM: dts: omap2420-n810: Enable McBSP2 for
	audio
Date: Thu, 26 Apr 2018 14:51:11 +0300
Message-ID: <20180426115115.13744-2-peter.ujfalusi@ti.com>
References: <20180426115115.13744-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20180426115115.13744-1-peter.ujfalusi@ti.com>
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

McBSP2 is used with the tlv320aic33 codec for audio.
Pin mux change is needed to get the needed signals in/out from the SoC.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/omap2420-n810.dts | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/omap2420-n810.dts b/arch/arm/boot/dts/omap2420-n810.dts
index 7c485fbfa535..4c412a480c3e 100644
--- a/arch/arm/boot/dts/omap2420-n810.dts
+++ b/arch/arm/boot/dts/omap2420-n810.dts
@@ -8,9 +8,26 @@
 	compatible = "nokia,n810", "nokia,n8x0", "ti,omap2420", "ti,omap2";
 };
 
+&omap2420_pmx {
+	mcbsp2_pins: mcbsp2_pins {
+		pinctrl-single,pins = <
+			OMAP2420_CORE_IOPAD(0x0124, PIN_INPUT | MUX_MODE1)	/* eac_ac_sclk.mcbsp2_clkx */
+			OMAP2420_CORE_IOPAD(0x0125, PIN_INPUT | MUX_MODE1)	/* eac_ac_fs.mcbsp2_fsx */
+			OMAP2420_CORE_IOPAD(0x0126, PIN_INPUT | MUX_MODE1)	/* eac_ac_din.mcbsp2_dr */
+			OMAP2420_CORE_IOPAD(0x0127, PIN_OUTPUT | MUX_MODE1)	/* eac_ac_dout.mcbsp2_dx */
+		>;
+	};
+};
+
 &i2c2 {
 	aic3x@18 {
 		compatible = "tlv320aic3x";
 		reg = <0x18>;
 	};
 };
+&mcbsp2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcbsp2_pins>;
+
+	status = "okay";
+};
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
