From: Balaji T K <balajitk@ti.com>
Subject: [PATCH] OMAP4:Fix -EINVAL for vana, vcxio, vdac
Date: Mon,  7 Feb 2011 20:59:59 +0530
Message-ID: <1297092599-428-1-git-send-email-balajitk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50081 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754068Ab1BGP2a (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 7 Feb 2011 10:28:30 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linux@arm.linux.org.uk, Balaji T K <balajitk@ti.com>

Fixed regulators in twl6030 do not have set_voltage hook.
Regulator core returns -22 if set_voltage is NULL and apply_uV is set
while applying the constraint to set voltage resulting in failure during probe
of these regulators.
Do not set apply_uV for fixed regulators which don't have set_voltage.

machine_constraints_voltage: VANA: failed to apply 2100000uV constraint
twl_reg twl_reg.43: can't register VANA, -22
twl_reg: probe of twl_reg.43 failed with error -22
machine_constraints_voltage: VCXIO: failed to apply 1800000uV constraint
twl_reg twl_reg.44: can't register VCXIO, -22
twl_reg: probe of twl_reg.44 failed with error -22
machine_constraints_voltage: VDAC: failed to apply 1800000uV constraint
twl_reg twl_reg.45: can't register VDAC, -22
twl_reg: probe of twl_reg.45 failed with error -22

Signed-off-by: Balaji T K <balajitk@ti.com>
---
Boot tested on OMAP4SDP with omap2plus_defconfig

 arch/arm/mach-omap2/board-4430sdp.c    |    3 ---
 arch/arm/mach-omap2/board-omap4panda.c |    3 ---
 2 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 07d1b20..1b16525 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -434,7 +434,6 @@ static struct regulator_init_data sdp4430_vana = {
 	.constraints = {
 		.min_uV			= 2100000,
 		.max_uV			= 2100000,
-		.apply_uV		= true,
 		.valid_modes_mask	= REGULATOR_MODE_NORMAL
 					| REGULATOR_MODE_STANDBY,
 		.valid_ops_mask	 = REGULATOR_CHANGE_MODE
@@ -446,7 +445,6 @@ static struct regulator_init_data sdp4430_vcxio = {
 	.constraints = {
 		.min_uV			= 1800000,
 		.max_uV			= 1800000,
-		.apply_uV		= true,
 		.valid_modes_mask	= REGULATOR_MODE_NORMAL
 					| REGULATOR_MODE_STANDBY,
 		.valid_ops_mask	 = REGULATOR_CHANGE_MODE
@@ -458,7 +456,6 @@ static struct regulator_init_data sdp4430_vdac = {
 	.constraints = {
 		.min_uV			= 1800000,
 		.max_uV			= 1800000,
-		.apply_uV		= true,
 		.valid_modes_mask	= REGULATOR_MODE_NORMAL
 					| REGULATOR_MODE_STANDBY,
 		.valid_ops_mask	 = REGULATOR_CHANGE_MODE
diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index e001a04..3686533 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -305,7 +305,6 @@ static struct regulator_init_data omap4_panda_vana = {
 	.constraints = {
 		.min_uV			= 2100000,
 		.max_uV			= 2100000,
-		.apply_uV		= true,
 		.valid_modes_mask	= REGULATOR_MODE_NORMAL
 					| REGULATOR_MODE_STANDBY,
 		.valid_ops_mask	 = REGULATOR_CHANGE_MODE
@@ -317,7 +316,6 @@ static struct regulator_init_data omap4_panda_vcxio = {
 	.constraints = {
 		.min_uV			= 1800000,
 		.max_uV			= 1800000,
-		.apply_uV		= true,
 		.valid_modes_mask	= REGULATOR_MODE_NORMAL
 					| REGULATOR_MODE_STANDBY,
 		.valid_ops_mask	 = REGULATOR_CHANGE_MODE
@@ -329,7 +327,6 @@ static struct regulator_init_data omap4_panda_vdac = {
 	.constraints = {
 		.min_uV			= 1800000,
 		.max_uV			= 1800000,
-		.apply_uV		= true,
 		.valid_modes_mask	= REGULATOR_MODE_NORMAL
 					| REGULATOR_MODE_STANDBY,
 		.valid_ops_mask	 = REGULATOR_CHANGE_MODE
-- 
1.7.0.4

