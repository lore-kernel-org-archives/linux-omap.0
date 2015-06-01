From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH 3/5] ARM: dts: DRA7: Add TBCLK for PWMSS
Date: Mon, 1 Jun 2015 17:23:32 +0530
Message-ID: <1433159614-437-4-git-send-email-vigneshr@ti.com>
References: <1433159614-437-1-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1433159614-437-1-git-send-email-vigneshr@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Paul Walmsley <paul@pwsan.com>, Tero Kristo <t-kristo@ti.com>, Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Mike Turquette <mturquette@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-pwm@vger.kernel.org, Vignesh R <vigneshr@ti.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

tbclk is used by ehrpwm to generate PWM waveform on DRA7 SoC. Add Linux
clock to control ehrpwm tbclk.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi          |  5 +++++
 arch/arm/boot/dts/dra7xx-clocks.dtsi | 26 ++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index f03a091cd076..387c76ca41f9 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -131,6 +131,11 @@
 							regulator-max-microvolt = <3000000>;
 						};
 					};
+
+					scm_conf_clocks: clocks {
+						#address-cells = <1>;
+						#size-cells = <0>;
+					};
 				};
 
 				dra7_pmx_core: pinmux@1400 {
diff --git a/arch/arm/boot/dts/dra7xx-clocks.dtsi b/arch/arm/boot/dts/dra7xx-clocks.dtsi
index 3b933f74d000..92452d61cf58 100644
--- a/arch/arm/boot/dts/dra7xx-clocks.dtsi
+++ b/arch/arm/boot/dts/dra7xx-clocks.dtsi
@@ -2136,3 +2136,29 @@
 		clocks = <&dpll_usb_ck>;
 	};
 };
+
+&scm_conf_clocks {
+       ehrpwm0_tbclk: ehrpwm0_tbclk {
+		#clock-cells = <0>;
+		compatible = "ti,gate-clock";
+		clocks = <&l4_root_clk_div>;
+		ti,bit-shift = <20>;
+		reg = <0x0558>;
+	};
+
+	ehrpwm1_tbclk: ehrpwm1_tbclk {
+		#clock-cells = <0>;
+		compatible = "ti,gate-clock";
+		clocks = <&l4_root_clk_div>;
+		ti,bit-shift = <21>;
+		reg = <0x0558>;
+	};
+
+	ehrpwm2_tbclk: ehrpwm2_tbclk {
+		#clock-cells = <0>;
+		compatible = "ti,gate-clock";
+		clocks = <&l4_root_clk_div>;
+		ti,bit-shift = <22>;
+		reg = <0x0558>;
+	};
+};
-- 
2.4.1
