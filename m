From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH 5/5] OMAP4: PM: TWL6030: add cmd register
Date: Mon, 29 Aug 2011 11:15:21 -0700
Message-ID: <1314641721-5172-6-git-send-email-khilman@ti.com>
References: <1314641721-5172-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:57694 "EHLO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754416Ab1H2SPC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Aug 2011 14:15:02 -0400
Received: by mail-pz0-f46.google.com with SMTP id 32so9738599pzk.19
        for <linux-omap@vger.kernel.org>; Mon, 29 Aug 2011 11:15:01 -0700 (PDT)
In-Reply-To: <1314641721-5172-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

From: Nishanth Menon <nm@ti.com>

Without the command register, ON/ONLP/RET/OFF voltages are
useless. and TWL will be unable to use these

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/omap_twl.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_twl.c b/arch/arm/mach-omap2/omap_twl.c
index 4bc99fb..f515a1a 100644
--- a/arch/arm/mach-omap2/omap_twl.c
+++ b/arch/arm/mach-omap2/omap_twl.c
@@ -42,8 +42,11 @@
 
 #define OMAP4_SRI2C_SLAVE_ADDR		0x12
 #define OMAP4_VDD_MPU_SR_VOLT_REG	0x55
+#define OMAP4_VDD_MPU_SR_CMD_REG	0x56
 #define OMAP4_VDD_IVA_SR_VOLT_REG	0x5B
+#define OMAP4_VDD_IVA_SR_CMD_REG	0x5C
 #define OMAP4_VDD_CORE_SR_VOLT_REG	0x61
+#define OMAP4_VDD_CORE_SR_CMD_REG	0x62
 
 #define OMAP4_VP_CONFIG_ERROROFFSET	0x00
 #define OMAP4_VP_VSTEPMIN_VSTEPMIN	0x01
@@ -210,6 +213,7 @@ static struct omap_voltdm_pmic omap4_mpu_pmic = {
 	.vp_timeout_us		= OMAP4_VP_VLIMITTO_TIMEOUT_US,
 	.i2c_slave_addr		= OMAP4_SRI2C_SLAVE_ADDR,
 	.volt_reg_addr		= OMAP4_VDD_MPU_SR_VOLT_REG,
+	.cmd_reg_addr		= OMAP4_VDD_MPU_SR_CMD_REG,
 	.i2c_high_speed		= true,
 	.vsel_to_uv		= twl6030_vsel_to_uv,
 	.uv_to_vsel		= twl6030_uv_to_vsel,
@@ -231,6 +235,7 @@ static struct omap_voltdm_pmic omap4_iva_pmic = {
 	.vp_timeout_us		= OMAP4_VP_VLIMITTO_TIMEOUT_US,
 	.i2c_slave_addr		= OMAP4_SRI2C_SLAVE_ADDR,
 	.volt_reg_addr		= OMAP4_VDD_IVA_SR_VOLT_REG,
+	.cmd_reg_addr		= OMAP4_VDD_IVA_SR_CMD_REG,
 	.i2c_high_speed		= true,
 	.vsel_to_uv		= twl6030_vsel_to_uv,
 	.uv_to_vsel		= twl6030_uv_to_vsel,
@@ -252,6 +257,7 @@ static struct omap_voltdm_pmic omap4_core_pmic = {
 	.vp_timeout_us		= OMAP4_VP_VLIMITTO_TIMEOUT_US,
 	.i2c_slave_addr		= OMAP4_SRI2C_SLAVE_ADDR,
 	.volt_reg_addr		= OMAP4_VDD_CORE_SR_VOLT_REG,
+	.cmd_reg_addr		= OMAP4_VDD_CORE_SR_CMD_REG,
 	.vsel_to_uv		= twl6030_vsel_to_uv,
 	.uv_to_vsel		= twl6030_uv_to_vsel,
 };
-- 
1.7.6

