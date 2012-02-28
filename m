From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH] ARM: OMAP2+: Remove apply_uV constraints for fixed regulator
Date: Tue, 28 Feb 2012 15:02:34 +0530
Message-ID: <1330421554-29369-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47232 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932308Ab2B1Jcp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Feb 2012 04:32:45 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

VUSB is a fixed regulator, so get rid of the apply_uV constraint
for it, which fixes the following error seen at boot on omap4
SDP and PANDA boards.

machine_constraints_voltage: VUSB: failed to apply 3300000uV constraint
twl_reg twl_reg.46: can't register VUSB, -22
twl_reg: probe of twl_reg.46 failed with error -22

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/twl-common.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/twl-common.c b/arch/arm/mach-omap2/twl-common.c
index 10b20c6..4b57757 100644
--- a/arch/arm/mach-omap2/twl-common.c
+++ b/arch/arm/mach-omap2/twl-common.c
@@ -270,7 +270,6 @@ static struct regulator_init_data omap4_vusb_idata = {
 	.constraints = {
 		.min_uV			= 3300000,
 		.max_uV			= 3300000,
-		.apply_uV		= true,
 		.valid_modes_mask	= REGULATOR_MODE_NORMAL
 					| REGULATOR_MODE_STANDBY,
 		.valid_ops_mask		= REGULATOR_CHANGE_MODE
-- 
1.7.1

