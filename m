From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH 2/2] ARM: dts: am4372: Add idle_states for cpuidle
Date: Thu, 12 Dec 2019 22:17:25 -0600
Message-ID: <20191213041725.16831-3-d-gerlach@ti.com>
References: <20191213041725.16831-1-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20191213041725.16831-1-d-gerlach@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <ssantosh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Dave Gerlach <d-gerlach@ti.com>
List-Id: linux-omap@vger.kernel.org

Add idle_states table for CPU on am437x. Currently just add C1 state
which gates the MPU clock domain.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 arch/arm/boot/dts/am4372.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index ca0aa3f26c0a..71ff2bf68d56 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -45,6 +45,7 @@
 		#size-cells = <0>;
 		cpu: cpu@0 {
 			compatible = "arm,cortex-a9";
+			enable-method = "ti,am4372";
 			device_type = "cpu";
 			reg = <0>;
 
@@ -54,6 +55,17 @@
 			operating-points-v2 = <&cpu0_opp_table>;
 
 			clock-latency = <300000>; /* From omap-cpufreq driver */
+			cpu-idle-states = <&mpu_gate>;
+		};
+
+		idle-states {
+			mpu_gate: mpu_gate {
+				compatible = "arm,idle-state";
+				entry-latency-us = <40>;
+				exit-latency-us = <100>;
+				min-residency-us = <300>;
+				local-timer-stop;
+			};
 		};
 	};
 
-- 
2.20.1
