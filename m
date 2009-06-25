From: sawsd wang <sawsdwang@gmail.com>
Subject: [PATCH 2/2] OMAP3: Implement separate function to send bypass command
	through VC
Date: Fri, 26 Jun 2009 07:56:00 +0800
Message-ID: <1950ceae0906251656k40d9514btd178f3c8ba36d055@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f186.google.com ([209.85.210.186]:34404 "EHLO
	mail-yx0-f186.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752683AbZFZAEO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Jun 2009 20:04:14 -0400
Received: by yxe16 with SMTP id 16so533293yxe.33
        for <linux-omap@vger.kernel.org>; Thu, 25 Jun 2009 17:04:17 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

>From 803cbdcd8df3d6f931089979c2dbad8942512cb4 Mon Sep 17 00:00:00 2001
From: Chunqiu Wang <cqwang@motorola.com>
Date: Wed, 24 Jun 2009 07:57:17 +0800
Subject: [PATCH] OMAP3: Implement separate function to send bypass
command through VC

Some system may need use OMAP VC to configure their Power IC,
so make the common code to send bypass command using SR VC

Signed-off-by: Chunqiu Wang <cqwang@motorola.com>
---
 arch/arm/mach-omap2/pm.h          |    1 +
 arch/arm/mach-omap2/pm34xx.c      |   36 ++++++++++++++++++++++
 arch/arm/mach-omap2/smartreflex.c |   59 +++---------------------------------
 3 files changed, 42 insertions(+), 54 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index ddc9453..fa118cd 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -44,6 +44,7 @@ extern int set_pwrdm_state(struct powerdomain
*pwrdm, u32 state);
 extern int omap3_pm_get_suspend_state(struct powerdomain *pwrdm);
 extern int omap3_pm_set_suspend_state(struct powerdomain *pwrdm, int state);
 extern void omap3_set_prm_setup_vc(struct prm_setup_vc *setup_vc);
+extern int omap3_vc_bypass_cmd(u8 slave_addr, u8 reg_addr, u8 cmd);

 #ifdef CONFIG_CPU_IDLE
 int omap3_idle_init(void);
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 7a4a525..85b0944 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -26,6 +26,7 @@
 #include <linux/err.h>
 #include <linux/gpio.h>
 #include <linux/clk.h>
+#include <linux/delay.h>

 #include <mach/sram.h>
 #include <mach/prcm.h>
@@ -1135,6 +1136,41 @@ err2:
 	return ret;
 }

+/* Program Power IC via OMAP3 voltage controller bypass interface */
+int omap3_vc_bypass_cmd(u8 slave_addr, u8 reg_addr, u8 cmd)
+{
+	u32 vc_bypass_value;
+	u32 loop_cnt = 0, retries_cnt = 0;
+
+	vc_bypass_value = (cmd << OMAP3430_DATA_SHIFT) |
+			(reg_addr << OMAP3430_REGADDR_SHIFT) |
+			(slave_addr << OMAP3430_SLAVEADDR_SHIFT);
+
+	prm_write_mod_reg(vc_bypass_value, OMAP3430_GR_MOD,
+			OMAP3_PRM_VC_BYPASS_VAL_OFFSET);
+
+	vc_bypass_value = prm_set_mod_reg_bits(OMAP3430_VALID, OMAP3430_GR_MOD,
+					OMAP3_PRM_VC_BYPASS_VAL_OFFSET);
+
+	while ((vc_bypass_value & OMAP3430_VALID) != 0x0) {
+		loop_cnt++;
+		if (retries_cnt > 10) {
+			printk(KERN_ERR"Loop count exceeded in check SR I2C"
+								"write\n");
+			return 1;
+		}
+		if (loop_cnt > 50) {
+			retries_cnt++;
+			loop_cnt = 0;
+			udelay(10);
+		}
+		vc_bypass_value = prm_read_mod_reg(OMAP3430_GR_MOD,
+					OMAP3_PRM_VC_BYPASS_VAL_OFFSET);
+	}
+
+	return 0;
+}
+
 static void __init configure_vc(void)
 {

diff --git a/arch/arm/mach-omap2/smartreflex.c
b/arch/arm/mach-omap2/smartreflex.c
index bacf602..2158b5c 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -35,6 +35,7 @@
 #include "prm.h"
 #include "smartreflex.h"
 #include "prm-regbits-34xx.h"
+#include "pm.h"

 struct omap_sr {
 	int		srid;
@@ -449,8 +450,6 @@ static int sr_reset_voltage(int srid)
 {
 	u32 target_opp_no, vsel = 0;
 	u32 reg_addr = 0;
-	u32 loop_cnt = 0, retries_cnt = 0;
-	u32 vc_bypass_value;
 	u32 t2_smps_steps = 0;
 	u32 t2_smps_delay = 0;
 	u32 prm_vp1_voltage, prm_vp2_voltage;
@@ -479,31 +478,8 @@ static int sr_reset_voltage(int srid)
 		t2_smps_steps = abs(vsel - prm_vp2_voltage);
 	}

-	vc_bypass_value = (vsel << OMAP3430_DATA_SHIFT) |
-			(reg_addr << OMAP3430_REGADDR_SHIFT) |
-			(R_SRI2C_SLAVE_ADDR << OMAP3430_SLAVEADDR_SHIFT);
-
-	prm_write_mod_reg(vc_bypass_value, OMAP3430_GR_MOD,
-			OMAP3_PRM_VC_BYPASS_VAL_OFFSET);
-
-	vc_bypass_value = prm_set_mod_reg_bits(OMAP3430_VALID, OMAP3430_GR_MOD,
-					OMAP3_PRM_VC_BYPASS_VAL_OFFSET);
-
-	while ((vc_bypass_value & OMAP3430_VALID) != 0x0) {
-		loop_cnt++;
-		if (retries_cnt > 10) {
-			pr_info("Loop count exceeded in check SR I2C"
-								"write\n");
-			return 1;
-		}
-		if (loop_cnt > 50) {
-			retries_cnt++;
-			loop_cnt = 0;
-			udelay(10);
-		}
-		vc_bypass_value = prm_read_mod_reg(OMAP3430_GR_MOD,
-					OMAP3_PRM_VC_BYPASS_VAL_OFFSET);
-	}
+	if (omap3_vc_bypass_cmd(R_SRI2C_SLAVE_ADDR, reg_addr, vsel))
+		return 1;

 	/*
 	 *  T2 SMPS slew rate (min) 4mV/uS, step size 12.5mV,
@@ -780,9 +756,7 @@ int sr_voltagescale_vcbypass(u32 target_opp, u32
current_opp,
 {
 	int sr_status = 0;
 	u32 vdd, target_opp_no, current_opp_no;
-	u32 vc_bypass_value;
 	u32 reg_addr = 0;
-	u32 loop_cnt = 0, retries_cnt = 0;
 	u32 t2_smps_steps = 0;
 	u32 t2_smps_delay = 0;

@@ -815,31 +789,8 @@ int sr_voltagescale_vcbypass(u32 target_opp, u32
current_opp,
 		reg_addr = R_VDD2_SR_CONTROL;
 	}

-	vc_bypass_value = (target_vsel << OMAP3430_DATA_SHIFT) |
-			(reg_addr << OMAP3430_REGADDR_SHIFT) |
-			(R_SRI2C_SLAVE_ADDR << OMAP3430_SLAVEADDR_SHIFT);
-
-	prm_write_mod_reg(vc_bypass_value, OMAP3430_GR_MOD,
-			OMAP3_PRM_VC_BYPASS_VAL_OFFSET);
-
-	vc_bypass_value = prm_set_mod_reg_bits(OMAP3430_VALID, OMAP3430_GR_MOD,
-					OMAP3_PRM_VC_BYPASS_VAL_OFFSET);
-
-	while ((vc_bypass_value & OMAP3430_VALID) != 0x0) {
-		loop_cnt++;
-		if (retries_cnt > 10) {
-			pr_info("Loop count exceeded in check SR I2C"
-								"write\n");
-			return 1;
-		}
-		if (loop_cnt > 50) {
-			retries_cnt++;
-			loop_cnt = 0;
-			udelay(10);
-		}
-		vc_bypass_value = prm_read_mod_reg(OMAP3430_GR_MOD,
-					OMAP3_PRM_VC_BYPASS_VAL_OFFSET);
-	}
+	if (omap3_vc_bypass_cmd(R_SRI2C_SLAVE_ADDR, reg_addr, target_vsel))
+		return 1;

 	/*
 	 *  T2 SMPS slew rate (min) 4mV/uS, step size 12.5mV,
-- 
1.5.4.3
