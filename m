From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 02/10] ARM: dts: omap: Remove "cooling-{min|max}-level" for CPU nodes
Date: Fri,  9 Feb 2018 14:28:02 +0530
Message-ID: <65c21dd1f5299d624ddb0b5e607226d86f745e19.1518166039.git.viresh.kumar@linaro.org>
References: <cover.1518166039.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1518166039.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1518166039.git.viresh.kumar@linaro.org>
References: <cover.1518166039.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, daniel.lezcano@linaro.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The "cooling-min-level" and "cooling-max-level" properties are not
parsed by any part of the kernel currently and the max cooling state of
a CPU cooling device is found by referring to the cpufreq table instead.

Remove the unused properties from the CPU nodes.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm/boot/dts/dra7.dtsi     | 2 --
 arch/arm/boot/dts/omap443x.dtsi | 2 --
 arch/arm/boot/dts/omap4460.dtsi | 2 --
 arch/arm/boot/dts/omap5.dtsi    | 2 --
 4 files changed, 8 deletions(-)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index e4a420f16800..f4ddd86f2c77 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -92,8 +92,6 @@
 			clock-latency = <300000>; /* From omap-cpufreq driver */
 
 			/* cooling options */
-			cooling-min-level = <0>;
-			cooling-max-level = <2>;
 			#cooling-cells = <2>; /* min followed by max */
 
 			vbb-supply = <&abb_mpu>;
diff --git a/arch/arm/boot/dts/omap443x.dtsi b/arch/arm/boot/dts/omap443x.dtsi
index 03c8ad91ddac..cbcdcb4e7d1c 100644
--- a/arch/arm/boot/dts/omap443x.dtsi
+++ b/arch/arm/boot/dts/omap443x.dtsi
@@ -24,8 +24,6 @@
 			clock-latency = <300000>; /* From legacy driver */
 
 			/* cooling options */
-			cooling-min-level = <0>;
-			cooling-max-level = <3>;
 			#cooling-cells = <2>; /* min followed by max */
 		};
 	};
diff --git a/arch/arm/boot/dts/omap4460.dtsi b/arch/arm/boot/dts/omap4460.dtsi
index c43f2a2d0a1e..ad97493e4e46 100644
--- a/arch/arm/boot/dts/omap4460.dtsi
+++ b/arch/arm/boot/dts/omap4460.dtsi
@@ -22,8 +22,6 @@
 			clock-latency = <300000>; /* From legacy driver */
 
 			/* cooling options */
-			cooling-min-level = <0>;
-			cooling-max-level = <2>;
 			#cooling-cells = <2>; /* min followed by max */
 		};
 	};
diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 35d4298da83d..511606c17a04 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -55,8 +55,6 @@
 			clock-latency = <300000>; /* From omap-cpufreq driver */
 
 			/* cooling options */
-			cooling-min-level = <0>;
-			cooling-max-level = <2>;
 			#cooling-cells = <2>; /* min followed by max */
 		};
 		cpu@1 {
-- 
2.15.0.194.g9af6a3dea062
