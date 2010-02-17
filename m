From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 2/2] twl6030: regulator: Configure STATE register instead of REMAP
Date: Wed, 17 Feb 2010 20:54:15 +0530
Message-ID: <1266420255-4307-2-git-send-email-rnayak@ti.com>
References: <1266420255-4307-1-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51991 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757424Ab0BQPY3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 17 Feb 2010 10:24:29 -0500
In-Reply-To: <1266420255-4307-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Rajendra Nayak <rnayak@ti.com>, Liam Girdwood <lrg@slimlogic.co.uk>, Samuel Ortiz <sameo@linux.intel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>

This is no REMAP register on twl6030, instead there is a STATE register
to drive a resource to a given state.
The state register can be used to specify what state the resource should
enter when its associated with a GRP.
Register Bit field description is as below. The patch programmes the
corresponding STATE registers for all LDO's to turn ON when assocaited
with GRP_P1.

STATE REG:
Bit7   |Bit6   |Bit5   |Bit4  |Bit3  |Bit2  |Bit1   |Bit0
P3_GRP |P2_GRP |P1_GRP |RES   |RES   |RES   |State1 |State0

State can be specified as below
00: OFF
01: ON
10: OFF
11: SLEEP

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: Samuel Ortiz <sameo@linux.intel.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/regulator/twl-regulator.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/regulator/twl-regulator.c b/drivers/regulator/twl-regulator.c
index e7871d6..f4ccccc 100644
--- a/drivers/regulator/twl-regulator.c
+++ b/drivers/regulator/twl-regulator.c
@@ -534,16 +534,16 @@ static struct twlreg_info twl_regs[] = {
 	/* 6030 REG with base as PMC Slave Misc : 0x0030 */
 	/* Turnon-delay and remap configuration values for 6030 are not
 	   verified since the specification is not public */
-	TWL6030_ADJUSTABLE_LDO(VAUX1_6030, 0x54, 1, 0, 0x08),
-	TWL6030_ADJUSTABLE_LDO(VAUX2_6030, 0x58, 2, 0, 0x08),
-	TWL6030_ADJUSTABLE_LDO(VAUX3_6030, 0x5c, 3, 0, 0x08),
-	TWL6030_ADJUSTABLE_LDO(VMMC, 0x68, 4, 0, 0x08),
-	TWL6030_ADJUSTABLE_LDO(VPP, 0x6c, 5, 0, 0x08),
-	TWL6030_ADJUSTABLE_LDO(VUSIM, 0x74, 7, 0, 0x08),
-	TWL6030_FIXED_LDO(VANA, 0x50, 2100, 15, 0, 0x08),
-	TWL6030_FIXED_LDO(VCXIO, 0x60, 1800, 16, 0, 0x08),
-	TWL6030_FIXED_LDO(VDAC, 0x64, 1800, 17, 0, 0x08),
-	TWL6030_FIXED_LDO(VUSB, 0x70, 3300, 18, 0, 0x08)
+	TWL6030_ADJUSTABLE_LDO(VAUX1_6030, 0x54, 1, 0, 0x21),
+	TWL6030_ADJUSTABLE_LDO(VAUX2_6030, 0x58, 2, 0, 0x21),
+	TWL6030_ADJUSTABLE_LDO(VAUX3_6030, 0x5c, 3, 0, 0x21),
+	TWL6030_ADJUSTABLE_LDO(VMMC, 0x68, 4, 0, 0x21),
+	TWL6030_ADJUSTABLE_LDO(VPP, 0x6c, 5, 0, 0x21),
+	TWL6030_ADJUSTABLE_LDO(VUSIM, 0x74, 7, 0, 0x21),
+	TWL6030_FIXED_LDO(VANA, 0x50, 2100, 15, 0, 0x21),
+	TWL6030_FIXED_LDO(VCXIO, 0x60, 1800, 16, 0, 0x21),
+	TWL6030_FIXED_LDO(VDAC, 0x64, 1800, 17, 0, 0x21),
+	TWL6030_FIXED_LDO(VUSB, 0x70, 3300, 18, 0, 0x21)
 };
 
 static int twlreg_probe(struct platform_device *pdev)
-- 
1.5.4.7

