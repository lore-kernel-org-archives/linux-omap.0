From: Nishanth Menon <nm@ti.com>
Subject: [PATCH V5 2/6] ARM: dts: OMAP3: add clock nodes for CPU
Date: Wed, 8 May 2013 14:06:12 -0500
Message-ID: <1368039976-29648-3-git-send-email-nm@ti.com>
References: <1368039976-29648-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1368039976-29648-1-git-send-email-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>, Mike Turquette <mturquette@linaro.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

OMAP34xx and OMAP36xx platforms use dpll1 clock. Add same to common
definition.

Cc: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
no change in current revision.
Previous version: http://marc.info/?l=linux-kernel&m=136580740024201&w=2

 arch/arm/boot/dts/omap3.dtsi |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index 4ad03d9..4f445ca 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -23,6 +23,8 @@
 	cpus {
 		cpu@0 {
 			compatible = "arm,cortex-a8";
+			clocks = <&dpll1>;
+			clock-names = "cpu";
 		};
 	};
 
@@ -73,6 +75,11 @@
 			ti,hwmods = "counter_32k";
 		};
 
+		dpll1: dpll1 {
+			#clock-cells = <0>;
+			compatible = "ti,omap-clock";
+		};
+
 		intc: interrupt-controller@48200000 {
 			compatible = "ti,omap2-intc";
 			interrupt-controller;
-- 
1.7.9.5
