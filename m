From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH 6/7] thermal: ti-soc-thermal: Remove redundant constants
Date: Wed, 1 Mar 2017 15:59:49 +0530
Message-ID: <1488364190-23488-7-git-send-email-j-keerthy@ti.com>
References: <1488364190-23488-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1488364190-23488-1-git-send-email-j-keerthy@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: tony@atomide.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, j-keerthy@ti.com, linux-kernel@vger.kernel.org, t-kristo@ti.com, robh+dt@kernel.org, rui.zhang@intel.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Now that slope and offset data are being passed from
device tree no need to populate in driver data.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 drivers/thermal/ti-soc-thermal/dra752-thermal-data.c | 10 ----------
 drivers/thermal/ti-soc-thermal/omap4-thermal-data.c  |  4 ----
 drivers/thermal/ti-soc-thermal/omap5-thermal-data.c  |  4 ----
 3 files changed, 18 deletions(-)

diff --git a/drivers/thermal/ti-soc-thermal/dra752-thermal-data.c b/drivers/thermal/ti-soc-thermal/dra752-thermal-data.c
index 118d7d8..4167373 100644
--- a/drivers/thermal/ti-soc-thermal/dra752-thermal-data.c
+++ b/drivers/thermal/ti-soc-thermal/dra752-thermal-data.c
@@ -410,8 +410,6 @@
 		.domain = "cpu",
 		.register_cooling = ti_thermal_register_cpu_cooling,
 		.unregister_cooling = ti_thermal_unregister_cpu_cooling,
-		.slope = DRA752_GRADIENT_SLOPE,
-		.constant = DRA752_GRADIENT_CONST,
 		.slope_pcb = DRA752_GRADIENT_SLOPE_W_PCB,
 		.constant_pcb = DRA752_GRADIENT_CONST_W_PCB,
 		},
@@ -419,8 +417,6 @@
 		.registers = &dra752_gpu_temp_sensor_registers,
 		.ts_data = &dra752_gpu_temp_sensor_data,
 		.domain = "gpu",
-		.slope = DRA752_GRADIENT_SLOPE,
-		.constant = DRA752_GRADIENT_CONST,
 		.slope_pcb = DRA752_GRADIENT_SLOPE_W_PCB,
 		.constant_pcb = DRA752_GRADIENT_CONST_W_PCB,
 		},
@@ -428,8 +424,6 @@
 		.registers = &dra752_core_temp_sensor_registers,
 		.ts_data = &dra752_core_temp_sensor_data,
 		.domain = "core",
-		.slope = DRA752_GRADIENT_SLOPE,
-		.constant = DRA752_GRADIENT_CONST,
 		.slope_pcb = DRA752_GRADIENT_SLOPE_W_PCB,
 		.constant_pcb = DRA752_GRADIENT_CONST_W_PCB,
 		},
@@ -437,8 +431,6 @@
 		.registers = &dra752_dspeve_temp_sensor_registers,
 		.ts_data = &dra752_dspeve_temp_sensor_data,
 		.domain = "dspeve",
-		.slope = DRA752_GRADIENT_SLOPE,
-		.constant = DRA752_GRADIENT_CONST,
 		.slope_pcb = DRA752_GRADIENT_SLOPE_W_PCB,
 		.constant_pcb = DRA752_GRADIENT_CONST_W_PCB,
 		},
@@ -446,8 +438,6 @@
 		.registers = &dra752_iva_temp_sensor_registers,
 		.ts_data = &dra752_iva_temp_sensor_data,
 		.domain = "iva",
-		.slope = DRA752_GRADIENT_SLOPE,
-		.constant = DRA752_GRADIENT_CONST,
 		.slope_pcb = DRA752_GRADIENT_SLOPE_W_PCB,
 		.constant_pcb = DRA752_GRADIENT_CONST_W_PCB,
 		},
diff --git a/drivers/thermal/ti-soc-thermal/omap4-thermal-data.c b/drivers/thermal/ti-soc-thermal/omap4-thermal-data.c
index d255d33..965de0e 100644
--- a/drivers/thermal/ti-soc-thermal/omap4-thermal-data.c
+++ b/drivers/thermal/ti-soc-thermal/omap4-thermal-data.c
@@ -82,8 +82,6 @@
 		.registers = &omap4430_mpu_temp_sensor_registers,
 		.ts_data = &omap4430_mpu_temp_sensor_data,
 		.domain = "cpu",
-		.slope = OMAP_GRADIENT_SLOPE_4430,
-		.constant = OMAP_GRADIENT_CONST_4430,
 		.slope_pcb = OMAP_GRADIENT_SLOPE_W_PCB_4430,
 		.constant_pcb = OMAP_GRADIENT_CONST_W_PCB_4430,
 		.register_cooling = ti_thermal_register_cpu_cooling,
@@ -222,8 +220,6 @@
 		.registers = &omap4460_mpu_temp_sensor_registers,
 		.ts_data = &omap4460_mpu_temp_sensor_data,
 		.domain = "cpu",
-		.slope = OMAP_GRADIENT_SLOPE_4460,
-		.constant = OMAP_GRADIENT_CONST_4460,
 		.slope_pcb = OMAP_GRADIENT_SLOPE_W_PCB_4460,
 		.constant_pcb = OMAP_GRADIENT_CONST_W_PCB_4460,
 		.register_cooling = ti_thermal_register_cpu_cooling,
diff --git a/drivers/thermal/ti-soc-thermal/omap5-thermal-data.c b/drivers/thermal/ti-soc-thermal/omap5-thermal-data.c
index 79ff70c..cd9a304 100644
--- a/drivers/thermal/ti-soc-thermal/omap5-thermal-data.c
+++ b/drivers/thermal/ti-soc-thermal/omap5-thermal-data.c
@@ -336,8 +336,6 @@
 		.domain = "cpu",
 		.register_cooling = ti_thermal_register_cpu_cooling,
 		.unregister_cooling = ti_thermal_unregister_cpu_cooling,
-		.slope = OMAP_GRADIENT_SLOPE_5430_CPU,
-		.constant = OMAP_GRADIENT_CONST_5430_CPU,
 		.slope_pcb = OMAP_GRADIENT_SLOPE_W_PCB_5430_CPU,
 		.constant_pcb = OMAP_GRADIENT_CONST_W_PCB_5430_CPU,
 		},
@@ -345,8 +343,6 @@
 		.registers = &omap5430_gpu_temp_sensor_registers,
 		.ts_data = &omap5430_gpu_temp_sensor_data,
 		.domain = "gpu",
-		.slope = OMAP_GRADIENT_SLOPE_5430_GPU,
-		.constant = OMAP_GRADIENT_CONST_5430_GPU,
 		.slope_pcb = OMAP_GRADIENT_SLOPE_W_PCB_5430_GPU,
 		.constant_pcb = OMAP_GRADIENT_CONST_W_PCB_5430_GPU,
 		},
-- 
1.9.1
