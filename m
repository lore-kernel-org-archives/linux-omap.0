From: Nishanth Menon <nm@ti.com>
Subject: [PM-WIP/voltdm_c][PATCH 11/11] OMAP4: PM: TWL6030: add cmd register
Date: Wed, 18 May 2011 00:17:34 -0500
Message-ID: <1305695854-9638-12-git-send-email-nm@ti.com>
References: <1305695854-9638-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47765 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752639Ab1ERFRk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 May 2011 01:17:40 -0400
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p4I5HeZD028667
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 18 May 2011 00:17:40 -0500
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep34.itg.ti.com (8.13.7/8.13.7) with ESMTP id p4I5HdeT002958
	for <linux-omap@vger.kernel.org>; Wed, 18 May 2011 00:17:39 -0500 (CDT)
In-Reply-To: <1305695854-9638-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: kevin <khilman@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Nishanth Menon <nm@ti.com>

Without the command register, ON/ONLP/RET/OFF voltages are
useless. and TWL will be unable to use these

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/omap_twl.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_twl.c b/arch/arm/mach-omap2/omap_twl.c
index 54a6e02..147e858 100644
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
 	.i2c_scll_low		= 0x28,
 	.i2c_scll_high		= 0x2C,
@@ -235,6 +239,7 @@ static struct omap_voltdm_pmic omap4_iva_pmic = {
 	.vp_timeout_us		= OMAP4_VP_VLIMITTO_TIMEOUT_US,
 	.i2c_slave_addr		= OMAP4_SRI2C_SLAVE_ADDR,
 	.volt_reg_addr		= OMAP4_VDD_IVA_SR_VOLT_REG,
+	.cmd_reg_addr		= OMAP4_VDD_IVA_SR_CMD_REG,
 	.i2c_high_speed		= true,
 	.i2c_scll_low		= 0x28,
 	.i2c_scll_high		= 0x2C,
@@ -265,6 +270,7 @@ static struct omap_voltdm_pmic omap4_core_pmic = {
 	.i2c_hscll_low		= 0x0B,
 	.i2c_hscll_high		= 0x00,
 	.volt_reg_addr		= OMAP4_VDD_CORE_SR_VOLT_REG,
+	.cmd_reg_addr		= OMAP4_VDD_CORE_SR_CMD_REG,
 	.vsel_to_uv		= twl6030_vsel_to_uv,
 	.uv_to_vsel		= twl6030_uv_to_vsel,
 };
-- 
1.7.0.4

