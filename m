From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv6 6/6] omap3: voltage: add external controller for VDD1 and VDD2
Date: Fri, 25 Nov 2011 18:29:22 +0200
Message-ID: <1322238562-19943-7-git-send-email-t-kristo@ti.com>
References: <1322238562-19943-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49731 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754457Ab1KYQ34 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Nov 2011 11:29:56 -0500
In-Reply-To: <1322238562-19943-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, broonie@opensource.wolfsonmicro.com, lrg@ti.com, gg@slimlogic.co.uk, rnayak@ti.com, b-cousson@ti.com

VDD1 and VDD2 will now use voltage controller when regulator voltage
is changed.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/omap_twl.c |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_twl.c b/arch/arm/mach-omap2/omap_twl.c
index f515a1a..4f69d8d 100644
--- a/arch/arm/mach-omap2/omap_twl.c
+++ b/arch/arm/mach-omap2/omap_twl.c
@@ -17,6 +17,7 @@
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/i2c/twl.h>
+#include <linux/regulator/consumer.h>
 
 #include "voltage.h"
 
@@ -72,6 +73,23 @@ static bool __initdata twl_sr_enable_autoinit;
 #define REG_SMPS_OFFSET         0xE0
 #define SMARTREFLEX_ENABLE     BIT(3)
 
+static int twl_set_voltage(void *data, int min_uV, int max_uV)
+{
+	struct voltagedomain *voltdm = (struct voltagedomain *)data;
+	return voltdm_scale(voltdm, min_uV);
+}
+
+static int twl_get_voltage(void *data)
+{
+	struct voltagedomain *voltdm = (struct voltagedomain *)data;
+	return voltdm_get_voltage(voltdm);
+}
+
+struct regulator_ext_ops twl_ext_ops = {
+	.get_voltage = twl_get_voltage,
+	.set_voltage = twl_set_voltage,
+};
+
 static unsigned long twl4030_vsel_to_uv(const u8 vsel)
 {
 	return (((vsel * 125) + 6000)) * 100;
@@ -284,6 +302,7 @@ int __init omap4_twl_init(void)
 int __init omap3_twl_init(void)
 {
 	struct voltagedomain *voltdm;
+	struct regulator *reg;
 
 	if (!cpu_is_omap34xx())
 		return -ENODEV;
@@ -309,9 +328,11 @@ int __init omap3_twl_init(void)
 
 	voltdm = voltdm_lookup("mpu_iva");
 	omap_voltage_register_pmic(voltdm, &omap3_mpu_pmic);
+	regulator_set_external_ctrl("mpu.0", "vcc", &twl_ext_ops, voltdm);
 
 	voltdm = voltdm_lookup("core");
 	omap_voltage_register_pmic(voltdm, &omap3_core_pmic);
+	regulator_set_external_ctrl("l3_main.0", "vcc", &twl_ext_ops, voltdm);
 
 	return 0;
 }
-- 
1.7.4.1

