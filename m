From: Milo Kim <woogyom.kim@gmail.com>
Subject: [PATCH v2 4/8] ARM: dts: am335x: Support the PMIC interrupt
Date: Fri, 28 Oct 2016 21:36:58 +0900
Message-ID: <20161028123702.21849-5-woogyom.kim@gmail.com>
References: <20161028123702.21849-1-woogyom.kim@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161028123702.21849-1-woogyom.kim@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: bcousson@baylibre.com, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Robert Nelson <robertcnelson@gmail.com>, Milo Kim <woogyom.kim@gmail.com>
List-Id: linux-omap@vger.kernel.org

AM335x bone based boards have the PMIC interrupt named NMI which is
connected to TPS65217 device. AM335x main interrupt controller provides it
and the number is 7.

Signed-off-by: Milo Kim <woogyom.kim@gmail.com>
---
 arch/arm/boot/dts/am335x-bone-common.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi b/arch/arm/boot/dts/am335x-bone-common.dtsi
index 007b5e5..25303d9 100644
--- a/arch/arm/boot/dts/am335x-bone-common.dtsi
+++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
@@ -310,6 +310,10 @@
 	 * by the hardware problems. (Tip: double-check by performing a current
 	 * measurement after shutdown: it should be less than 1 mA.)
 	 */
+
+	interrupts = <7>; /* NMI */
+	interrupt-parent = <&intc>;
+
 	ti,pmic-shutdown-controller;
 
 	regulators {
-- 
2.9.3
