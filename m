From: Nishanth Menon <nm@ti.com>
Subject: [PATCH V4 2/6] ARM: dts: OMAP3: add clock nodes for CPU
Date: Fri, 12 Apr 2013 17:54:34 -0500
Message-ID: <1365807278-554-3-git-send-email-nm@ti.com>
References: <1365807278-554-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1365807278-554-1-git-send-email-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, Mike Turquette <mturquette@linaro.org>, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

OMAP34xx and OMAP36xx platforms use dpll1 clock. Add same to common
definition.

Cc: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
RFC of this patch was discussed in http://marc.info/?t=136370325600009&r=1&w=2
along with the detailed context as to why this is an intermediate step.

previous revisions of cpufreq-cpu0 support do not use this approach.

[Probably belongs to Benoit's tree]
 arch/arm/boot/dts/omap3.dtsi |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index 559b02f..58c6ed6 100644
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
