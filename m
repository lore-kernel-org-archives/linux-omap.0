From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [PATCH 05/15] staging: omap-thermal: remove from register map soc and
 mode on OMAP5
Date: Tue, 26 Feb 2013 18:53:28 -0400
Message-ID: <1361919218-9788-6-git-send-email-eduardo.valentin@ti.com>
References: <1361919218-9788-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1361919218-9788-1-git-send-email-eduardo.valentin@ti.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
 <mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel/>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
 <mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: devel-bounces@linuxdriverproject.org
Sender: "devel" <devel-bounces@linuxdriverproject.org>
To: gregkh@linuxfoundation.org
Cc: devel@driverdev.osuosl.org, Eduardo Valentin <eduardo.valentin@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On OMAP54xx ES2.0 there is no single read and only one mode: continuous
mode. For this reason, there is no point in defining register fields
for these operations.

Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 drivers/staging/omap-thermal/omap5-thermal.c |   11 -----------
 1 files changed, 0 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/omap-thermal/omap5-thermal.c b/drivers/staging/omap-thermal/omap5-thermal.c
index 4965556..32d3f878 100644
--- a/drivers/staging/omap-thermal/omap5-thermal.c
+++ b/drivers/staging/omap-thermal/omap5-thermal.c
@@ -27,7 +27,6 @@ static struct temp_sensor_registers
 omap5430_mpu_temp_sensor_registers = {
 	.temp_sensor_ctrl = OMAP5430_TEMP_SENSOR_MPU_OFFSET,
 	.bgap_tempsoff_mask = OMAP5430_BGAP_TEMPSOFF_MASK,
-	.bgap_soc_mask = OMAP5430_BGAP_TEMP_SENSOR_SOC_MASK,
 	.bgap_eocz_mask = OMAP5430_BGAP_TEMP_SENSOR_EOCZ_MASK,
 	.bgap_dtemp_mask = OMAP5430_BGAP_TEMP_SENSOR_DTEMP_MASK,
 
@@ -35,8 +34,6 @@ omap5430_mpu_temp_sensor_registers = {
 	.mask_hot_mask = OMAP5430_MASK_HOT_MPU_MASK,
 	.mask_cold_mask = OMAP5430_MASK_COLD_MPU_MASK,
 
-	.bgap_mode_ctrl = OMAP5430_BGAP_COUNTER_MPU_OFFSET,
-	.mode_ctrl_mask = OMAP5430_REPEAT_MODE_MASK,
 
 	.bgap_counter = OMAP5430_BGAP_COUNTER_MPU_OFFSET,
 	.counter_mask = OMAP5430_COUNTER_MASK,
@@ -66,7 +63,6 @@ static struct temp_sensor_registers
 omap5430_gpu_temp_sensor_registers = {
 	.temp_sensor_ctrl = OMAP5430_TEMP_SENSOR_GPU_OFFSET,
 	.bgap_tempsoff_mask = OMAP5430_BGAP_TEMPSOFF_MASK,
-	.bgap_soc_mask = OMAP5430_BGAP_TEMP_SENSOR_SOC_MASK,
 	.bgap_eocz_mask = OMAP5430_BGAP_TEMP_SENSOR_EOCZ_MASK,
 	.bgap_dtemp_mask = OMAP5430_BGAP_TEMP_SENSOR_DTEMP_MASK,
 
@@ -74,9 +70,6 @@ omap5430_gpu_temp_sensor_registers = {
 	.mask_hot_mask = OMAP5430_MASK_HOT_GPU_MASK,
 	.mask_cold_mask = OMAP5430_MASK_COLD_GPU_MASK,
 
-	.bgap_mode_ctrl = OMAP5430_BGAP_COUNTER_GPU_OFFSET,
-	.mode_ctrl_mask = OMAP5430_REPEAT_MODE_MASK,
-
 	.bgap_counter = OMAP5430_BGAP_COUNTER_GPU_OFFSET,
 	.counter_mask = OMAP5430_COUNTER_MASK,
 
@@ -105,7 +98,6 @@ static struct temp_sensor_registers
 omap5430_core_temp_sensor_registers = {
 	.temp_sensor_ctrl = OMAP5430_TEMP_SENSOR_CORE_OFFSET,
 	.bgap_tempsoff_mask = OMAP5430_BGAP_TEMPSOFF_MASK,
-	.bgap_soc_mask = OMAP5430_BGAP_TEMP_SENSOR_SOC_MASK,
 	.bgap_eocz_mask = OMAP5430_BGAP_TEMP_SENSOR_EOCZ_MASK,
 	.bgap_dtemp_mask = OMAP5430_BGAP_TEMP_SENSOR_DTEMP_MASK,
 
@@ -113,9 +105,6 @@ omap5430_core_temp_sensor_registers = {
 	.mask_hot_mask = OMAP5430_MASK_HOT_CORE_MASK,
 	.mask_cold_mask = OMAP5430_MASK_COLD_CORE_MASK,
 
-	.bgap_mode_ctrl = OMAP5430_BGAP_COUNTER_CORE_OFFSET,
-	.mode_ctrl_mask = OMAP5430_REPEAT_MODE_MASK,
-
 	.bgap_counter = OMAP5430_BGAP_COUNTER_CORE_OFFSET,
 	.counter_mask = OMAP5430_COUNTER_MASK,
 
-- 
1.7.7.1.488.ge8e1c
