From: Oleksandr Kozaruk <oleksandr.kozaruk@ti.com>
Subject: [PATCH v3 1/2] ARM: dts: twl: Add GPADC data to device tree
Date: Fri, 12 Jul 2013 10:18:01 +0300
Message-ID: <1373613482-28390-2-git-send-email-oleksandr.kozaruk@ti.com>
References: <1373613482-28390-1-git-send-email-oleksandr.kozaruk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1373613482-28390-1-git-send-email-oleksandr.kozaruk@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, benoit.cousson@linaro.org, rnayak@ti.com, peter.ujfalusi@ti.com, kishon@ti.com, jic23@cam.ac.uk, grant.likely@linaro.org, rob.herring@calxeda.com, lars@metafoo.de, sameo@linux.intel.com, ch.naveen@samsung.com, poeschel@lemonage.de, milo.kim@ti.com, balajitk@ti.com, gg@slimlogic.co.uk
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

GPADC is the general purpose ADC present on twl6030.
The dt data is interrupt used to trigger end of ADC
conversion.

Signed-off-by: Oleksandr Kozaruk <oleksandr.kozaruk@ti.com>
---
 arch/arm/boot/dts/twl6030.dtsi |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/twl6030.dtsi b/arch/arm/boot/dts/twl6030.dtsi
index 2e3bd31..434842c 100644
--- a/arch/arm/boot/dts/twl6030.dtsi
+++ b/arch/arm/boot/dts/twl6030.dtsi
@@ -103,4 +103,10 @@
 		compatible = "ti,twl6030-pwmled";
 		#pwm-cells = <2>;
 	};
+
+	gpadc: twl6030_gpadc {
+		compatible = "ti,twl6030_gpadc";
+		interrupts = <3>;
+		#io-channel-cells = <1>;
+	};
 };
-- 
1.7.9.5
