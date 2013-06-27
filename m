From: Oleksandr Kozaruk <oleksandr.kozaruk@ti.com>
Subject: [PATCH v1 1/2] ARM: dts: twl: Add GPADC data to device tree
Date: Thu, 27 Jun 2013 13:43:37 +0300
Message-ID: <1372329818-12384-2-git-send-email-oleksandr.kozaruk@ti.com>
References: <1372329818-12384-1-git-send-email-oleksandr.kozaruk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1372329818-12384-1-git-send-email-oleksandr.kozaruk@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rob@landley.net, sameo@linux.intel.com, grant.likely@linaro.org, rob.herring@calxeda.com, balajitk@ti.com, gg@slimlogic.co.uk
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

GPADC is the general purpose ADC present on twl6030.
The dt data is interrupt used to trigger end of ADC
conversion.

Signed-off-by: Oleksandr Kozaruk <oleksandr.kozaruk@ti.com>
---
 arch/arm/boot/dts/twl6030.dtsi |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/twl6030.dtsi b/arch/arm/boot/dts/twl6030.dtsi
index 2e3bd31..189872c 100644
--- a/arch/arm/boot/dts/twl6030.dtsi
+++ b/arch/arm/boot/dts/twl6030.dtsi
@@ -103,4 +103,9 @@
 		compatible = "ti,twl6030-pwmled";
 		#pwm-cells = <2>;
 	};
+
+	twl6030_gpadc {
+		compatible = "ti,twl6030_gpadc";
+		interrupts = <3>;
+	};
 };
-- 
1.7.9.5
