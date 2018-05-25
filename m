From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 08/15] arm: dts: dra74x: Add missing cooling device properties for CPUs
Date: Fri, 25 May 2018 16:01:54 +0530
Message-ID: <4860aab6e550b91ecc5c37c80cbffa6a6a70a4c9.1527244201.git.viresh.kumar@linaro.org>
References: <cover.1527244200.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1527244200.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1527244200.git.viresh.kumar@linaro.org>
References: <cover.1527244200.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: arm@kernel.org, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, ionela.voinescu@arm.com, Daniel Lezcano <daniel.lezcano@linaro.org>, chris.redpath@arm.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The cooling device properties, like "#cooling-cells" and
"dynamic-power-coefficient", should either be present for all the CPUs
of a cluster or none. If these are present only for a subset of CPUs of
a cluster then things will start falling apart as soon as the CPUs are
brought online in a different order. For example, this will happen
because the operating system looks for such properties in the CPU node
it is trying to bring up, so that it can register a cooling device.

Add such missing properties.

Fix other missing properties (clocks, supply, clock latency) as well to
make it all work.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm/boot/dts/dra74x.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/dra74x.dtsi b/arch/arm/boot/dts/dra74x.dtsi
index 91e93ab588ca..8f9df09155d8 100644
--- a/arch/arm/boot/dts/dra74x.dtsi
+++ b/arch/arm/boot/dts/dra74x.dtsi
@@ -18,6 +18,16 @@
 			compatible = "arm,cortex-a15";
 			reg = <1>;
 			operating-points-v2 = <&cpu0_opp_table>;
+
+			clocks = <&dpll_mpu_ck>;
+			clock-names = "cpu";
+
+			clock-latency = <300000>; /* From omap-cpufreq driver */
+
+			/* cooling options */
+			#cooling-cells = <2>; /* min followed by max */
+
+			vbb-supply = <&abb_mpu>;
 		};
 	};
 
-- 
2.15.0.194.g9af6a3dea062
