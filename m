From: Oleksandr Kozaruk <oleksandr.kozaruk@ti.com>
Subject: [PATCH v7 1/2] ARM: dts: twl: Add GPADC data to device tree
Date: Mon, 22 Jul 2013 15:22:51 +0300
Message-ID: <1374495772-17758-2-git-send-email-oleksandr.kozaruk@ti.com>
References: <1374495772-17758-1-git-send-email-oleksandr.kozaruk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1374495772-17758-1-git-send-email-oleksandr.kozaruk@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, benoit.cousson@linaro.org, rnayak@ti.com, peter.ujfalusi@ti.com, kishon@ti.com, jic23@cam.ac.uk, grant.likely@linaro.org, rob.herring@calxeda.com, lars@metafoo.de, sameo@linux.intel.com, ch.naveen@samsung.com, poeschel@lemonage.de, milo.kim@ti.com, balajitk@ti.com, gg@slimlogic.co.uk
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

GPADC is the general purpose ADC present on twl6030.
The dt data is interrupt used to trigger end of ADC
conversion.

Signed-off-by: Oleksandr Kozaruk <oleksandr.kozaruk@ti.com>
---
 arch/arm/boot/dts/twl6030.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/twl6030.dtsi b/arch/arm/boot/dts/twl6030.dtsi
index 2e3bd31..b78e1d5 100644
--- a/arch/arm/boot/dts/twl6030.dtsi
+++ b/arch/arm/boot/dts/twl6030.dtsi
@@ -103,4 +103,10 @@
 		compatible = "ti,twl6030-pwmled";
 		#pwm-cells = <2>;
 	};
+
+	adc {
+		compatible = "ti,twl6030-gpadc";
+		interrupts = <3>;
+		#io-channel-cells = <1>;
+	};
 };
-- 
1.8.1.2
