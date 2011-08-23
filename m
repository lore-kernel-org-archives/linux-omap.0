From: Hemant Pedanekar <hemantp@ti.com>
Subject: [RFC PATCH v2 3/6] TI816X: clock: Add clockdomains and powerdomains data
Date: Tue, 23 Aug 2011 22:43:34 +0530
Message-ID: <1314119614-22951-1-git-send-email-hemantp@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42512 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751959Ab1HWRNq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Aug 2011 13:13:46 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Hemant Pedanekar <hemantp@ti.com>

This patch adds data for various clock domains and power domains in TI816X.

Note that at present this is not exhaustive and need to add missing domains.

Signed-off-by: Hemant Pedanekar <hemantp@ti.com>
---
 arch/arm/mach-omap2/clockdomains816x_data.c |  172 +++++++++++++++++++++++++++
 arch/arm/mach-omap2/powerdomains816x_data.c |   68 +++++++++++
 2 files changed, 240 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/clockdomains816x_data.c
 create mode 100644 arch/arm/mach-omap2/powerdomains816x_data.c

diff --git a/arch/arm/mach-omap2/clockdomains816x_data.c b/arch/arm/mach-omap2/clockdomains816x_data.c
new file mode 100644
index 0000000..41ad561
--- /dev/null
+++ b/arch/arm/mach-omap2/clockdomains816x_data.c
@@ -0,0 +1,172 @@
+/*
+ * TI816X Clock Domain data.
+ *
+ * Copyright (C) 2010 Texas Instruments, Inc. - http://www.ti.com/
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/kernel.h>
+#include <linux/io.h>
+
+#include "clockdomain.h"
+#include "cm.h"
+#include "cm816x.h"
+#include "cm-regbits-816x.h"
+
+static struct clockdomain alwon_mpu_816x_clkdm = {
+	.name		= "alwon_mpu_clkdm",
+	.pwrdm		= { .name = "alwon_pwrdm" },
+	.cm_inst	= TI816X_CM_ALWON_MOD,
+	.clkdm_offs	= TI816X_CM_ALWON_MPU_CLKDM,
+	.clktrctrl_mask	= TI816X_CLKTRCTRL_MASK,
+	.flags		= CLKDM_CAN_HWSUP_SWSUP,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_TI816X),
+};
+
+static struct clockdomain alwon_l3_slow_816x_clkdm = {
+	.name		= "alwon_l3_slow_clkdm",
+	.pwrdm		= { .name = "alwon_pwrdm" },
+	.cm_inst	= TI816X_CM_ALWON_MOD,
+	.clkdm_offs	= TI816X_CM_ALWON_L3_SLOW_CLKDM,
+	.clktrctrl_mask	= TI816X_CLKTRCTRL_MASK,
+	.flags		= CLKDM_CAN_HWSUP_SWSUP,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_TI816X),
+};
+
+static struct clockdomain alwon_l3_fast_816x_clkdm = {
+	.name		= "alwon_l3_fast_clkdm",
+	.pwrdm		= { .name = "alwon_pwrdm" },
+	.cm_inst	= TI816X_CM_ALWON_MOD,
+	.clkdm_offs	= TI816X_CM_ALWON_L3_FAST_CLKDM,
+	.clktrctrl_mask	= TI816X_CLKTRCTRL_MASK,
+	.flags		= CLKDM_CAN_HWSUP_SWSUP,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_TI816X),
+};
+
+static struct clockdomain alwon_ethernet_816x_clkdm = {
+	.name		= "alwon_ethernet_clkdm",
+	.pwrdm		= { .name = "alwon_pwrdm" },
+	.cm_inst	= TI816X_CM_ALWON_MOD,
+	.clkdm_offs	= TI816X_CM_ETHERNET_CLKDM,
+	.clktrctrl_mask	= TI816X_CLKTRCTRL_MASK,
+	.flags		= CLKDM_CAN_HWSUP_SWSUP,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_TI816X),
+};
+
+static struct clockdomain mmu_816x_clkdm = {
+	.name		= "mmu_clkdm",
+	.pwrdm		= { .name = "alwon_pwrdm" },
+	.cm_inst	= TI816X_CM_ALWON_MOD,
+	.clkdm_offs	= TI816X_CM_MMU_CLKDM,
+	.clktrctrl_mask	= TI816X_CLKTRCTRL_MASK,
+	.flags		= CLKDM_CAN_HWSUP_SWSUP,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_TI816X),
+};
+
+static struct clockdomain mmu_cfg_816x_clkdm = {
+	.name		= "mmu_cfg_clkdm",
+	.pwrdm		= { .name = "alwon_pwrdm" },
+	.cm_inst	= TI816X_CM_ALWON_MOD,
+	.clkdm_offs	= TI816X_CM_MMUCFG_CLKDM,
+	.clktrctrl_mask	= TI816X_CLKTRCTRL_MASK,
+	.flags		= CLKDM_CAN_HWSUP_SWSUP,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_TI816X),
+};
+
+static struct clockdomain active_gem_816x_clkdm = {
+	.name		= "active_gem_clkdm",
+	.pwrdm		= { .name = "active_pwrdm" },
+	.cm_inst	= TI816X_CM_ACTIVE_MOD,
+	.clkdm_offs	= TI816X_CM_ACTIVE_GEM_CLKDM,
+	.clktrctrl_mask	= TI816X_CLKTRCTRL_MASK,
+	.flags		= CLKDM_CAN_HWSUP_SWSUP,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_TI816X),
+};
+
+static struct clockdomain hdvicp0_816x_clkdm = {
+	.name		= "hdvicp0_clkdm",
+	.pwrdm		= { .name = "hdvicp0_pwrdm" },
+	.cm_inst	= TI816X_CM_IVAHD0_MOD,
+	.clkdm_offs	= TI816X_CM_IVAHD0_CLKDM,
+	.clktrctrl_mask	= TI816X_CLKTRCTRL_MASK,
+	.flags		= CLKDM_CAN_HWSUP_SWSUP,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_TI816X),
+};
+
+static struct clockdomain hdvicp1_816x_clkdm = {
+	.name		= "hdvicp1_clkdm",
+	.pwrdm		= { .name = "hdvicp1_pwrdm" },
+	.cm_inst	= TI816X_CM_IVAHD1_MOD,
+	.clkdm_offs	= TI816X_CM_IVAHD1_CLKDM,
+	.clktrctrl_mask	= TI816X_CLKTRCTRL_MASK,
+	.flags		= CLKDM_CAN_HWSUP_SWSUP,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_TI816X),
+};
+
+static struct clockdomain hdvicp2_816x_clkdm = {
+	.name		= "hdvicp2_clkdm",
+	.pwrdm		= { .name = "hdvicp2_pwrdm" },
+	.cm_inst	= TI816X_CM_IVAHD2_MOD,
+	.clkdm_offs	= TI816X_CM_IVAHD2_CLKDM,
+	.clktrctrl_mask	= TI816X_CLKTRCTRL_MASK,
+	.flags		= CLKDM_CAN_HWSUP_SWSUP,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_TI816X),
+};
+
+static struct clockdomain sgx_816x_clkdm = {
+	.name		= "sgx_clkdm",
+	.pwrdm		= { .name = "sgx_pwrdm" },
+	.cm_inst	= TI816X_CM_SGX_MOD,
+	.clkdm_offs	= TI816X_CM_SGX_CLKDM,
+	.clktrctrl_mask	= TI816X_CLKTRCTRL_MASK,
+	.flags		= CLKDM_CAN_HWSUP_SWSUP,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_TI816X),
+};
+
+static struct clockdomain default_l3_med_816x_clkdm = {
+	.name		= "default_l3_med_clkdm",
+	.pwrdm		= { .name = "default_pwrdm" },
+	.cm_inst	= TI816X_CM_DEFAULT_MOD,
+	.clkdm_offs	= TI816X_CM_DEFAULT_L3_MED_CLKDM,
+	.clktrctrl_mask	= TI816X_CLKTRCTRL_MASK,
+	.flags		= CLKDM_CAN_HWSUP_SWSUP,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_TI816X),
+};
+
+static struct clockdomain default_ducati_816x_clkdm = {
+	.name		= "default_ducati_clkdm",
+	.pwrdm		= { .name = "default_pwrdm" },
+	.cm_inst	= TI816X_CM_DEFAULT_MOD,
+	.clkdm_offs	= TI816X_CM_DEFAULT_DUCATI_CLKDM,
+	.clktrctrl_mask	= TI816X_CLKTRCTRL_MASK,
+	.flags		= CLKDM_CAN_HWSUP_SWSUP,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_TI816X),
+};
+
+static struct clockdomain default_pcie_816x_clkdm = {
+	.name		= "default_pcie_clkdm",
+	.pwrdm		= { .name = "default_pwrdm" },
+	.cm_inst	= TI816X_CM_DEFAULT_MOD,
+	.clkdm_offs	= TI816X_CM_DEFAULT_PCI_CLKDM,
+	.clktrctrl_mask	= TI816X_CLKTRCTRL_MASK,
+	.flags		= CLKDM_CAN_HWSUP_SWSUP,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_TI816X),
+};
+
+static struct clockdomain default_usb_816x_clkdm = {
+	.name		= "default_usb_clkdm",
+	.pwrdm		= { .name = "default_pwrdm" },
+	.cm_inst	= TI816X_CM_DEFAULT_MOD,
+	.clkdm_offs	= TI816X_CM_DEFAULT_L3_SLOW_CLKDM,
+	.clktrctrl_mask	= TI816X_CLKTRCTRL_MASK,
+	.flags		= CLKDM_CAN_HWSUP_SWSUP,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_TI816X),
+};
diff --git a/arch/arm/mach-omap2/powerdomains816x_data.c b/arch/arm/mach-omap2/powerdomains816x_data.c
new file mode 100644
index 0000000..f42c968
--- /dev/null
+++ b/arch/arm/mach-omap2/powerdomains816x_data.c
@@ -0,0 +1,68 @@
+/*
+ * TI816X Power Domain data.
+ *
+ * Copyright (C) 2010 Texas Instruments, Inc. - http://www.ti.com/
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/kernel.h>
+
+#include "powerdomain.h"
+#include "prcm-common.h"
+#include "prm2xxx_3xxx.h"
+
+static struct powerdomain alwon_816x_pwrdm = {
+	.name		  = "alwon_pwrdm",
+	.prcm_offs	  = TI816X_PRM_ALWON_MOD,
+	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_TI816X),
+};
+
+static struct powerdomain active_816x_pwrdm = {
+	.name		  = "active_pwrdm",
+	.prcm_offs	  = TI816X_PRM_ACTIVE_MOD,
+	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_TI816X),
+	.pwrsts		  = PWRSTS_OFF_ON,
+};
+
+static struct powerdomain default_816x_pwrdm = {
+	.name		  = "default_pwrdm",
+	.prcm_offs	  = TI816X_PRM_DEFAULT_MOD,
+	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_TI816X),
+	.pwrsts		  = PWRSTS_OFF_ON,
+};
+
+static struct powerdomain hdvicp0_816x_pwrdm = {
+	.name		  = "hdvicp0_pwrdm",
+	.prcm_offs	  = TI816X_PRM_IVAHD0_MOD,
+	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_TI816X),
+	.pwrsts		  = PWRSTS_OFF_ON,
+};
+
+static struct powerdomain hdvicp1_816x_pwrdm = {
+	.name		  = "hdvicp1_pwrdm",
+	.prcm_offs	  = TI816X_PRM_IVAHD1_MOD,
+	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_TI816X),
+	.pwrsts		  = PWRSTS_OFF_ON,
+};
+
+static struct powerdomain hdvicp2_816x_pwrdm = {
+	.name		  = "hdvicp2_pwrdm",
+	.prcm_offs	  = TI816X_PRM_IVAHD2_MOD,
+	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_TI816X),
+	.pwrsts		  = PWRSTS_OFF_ON,
+};
+
+static struct powerdomain sgx_816x_pwrdm = {
+	.name		  = "sgx_pwrdm",
+	.prcm_offs	  = TI816X_PRM_SGX_MOD,
+	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_TI816X),
+	.pwrsts		  = PWRSTS_OFF_ON,
+};
-- 
1.7.3.5

