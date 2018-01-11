From: Ravikumar Kattekola <rk@ti.com>
Subject: [PATCH 1/1] ARM: dts: dra7: Reduce shut down temperature of non-cpu thermal zones
Date: Thu, 11 Jan 2018 21:45:39 +0530
Message-ID: <20180111161539.23210-1-rk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: bcousson@baylibre.com
Cc: tony@atomide.com, robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On dra7, as per TRM, the HW shutdown (TSHUT) temperature is hardcoded
to 123C and cannot be modified by SW. This means that when the temperature
reaches 123C HW asserts TSHUT output which signals a warm reset.
The reset is held until the temperature goes below the TSHUT low (105C).

While in SW, the thermal driver continuously monitors current temperature
and takes decisions based on whether it reached an alert or a critical point.
The intention of setting a SW critical point is to prevent force reset by HW
and instead do an orderly_poweroff(). But if the SW critical temperature is
greater than or equal to that of HW then it defeats the purpose. To address
this and let SW take action before HW does keep the SW critical temperature
less than HW TSHUT value.

The value for SW critical temperature was chosen as 120C just to ensure
we give SW sometime before HW catches up.

Document reference
SPRUI30C – DRA75x, DRA74x Technical Reference Manual - November 2016
SPRUHZ6H - AM572x Technical Reference Manual - November 2016

Tested on:
DRA75x PG 2.0 Rev H EVM

Signed-off-by: Ravikumar Kattekola <rk@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index ac92162..4b3e3582 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -2089,4 +2089,20 @@
 	temperature = <120000>; /* milli Celsius */
 };
 
+&core_crit {
+	temperature = <120000>; /* milli Celsius */
+};
+
+&gpu_crit {
+	temperature = <120000>; /* milli Celsius */
+};
+
+&dspeve_crit {
+	temperature = <120000>; /* milli Celsius */
+};
+
+&iva_crit {
+	temperature = <120000>; /* milli Celsius */
+};
+
 /include/ "dra7xx-clocks.dtsi"
-- 
2.8.2.396.g5fe494c
