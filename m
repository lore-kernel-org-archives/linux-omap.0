From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: [PATCH] OMAP3: I2C: hwmod: Fix PRCM module offset
Date: Mon,  8 Nov 2010 19:54:10 +0530
Message-ID: <1289226250-11366-1-git-send-email-manjugk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49596 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754371Ab0KHOXm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 8 Nov 2010 09:23:42 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Charulatha V <charu@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@ti.com>, Benoit Cousson <b-cousson@ti.com>

The commit '311225e6' is missing '.module_offs' in prcm
structure in omap3 hwmod data base which results in accessing
wrong register for I2Cx IDLEST bit monitoring.

Added module offsets for accessing register CM_IDLEST1_CORE.

Patch tested on Zoom3 using omap2plus_defconfig

Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
Signed-off-by: Charulatha V <charu@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index d0d8030..22831e9 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -642,6 +642,7 @@ static struct omap_hwmod omap3xxx_i2c1_hwmod = {
 	.main_clk	= "i2c1_fck",
 	.prcm		= {
 		.omap2 = {
+			.module_offs = CORE_MOD,
 			.prcm_reg_id = 1,
 			.module_bit = OMAP3430_EN_I2C1_SHIFT,
 			.idlest_reg_id = 1,
@@ -683,6 +684,7 @@ static struct omap_hwmod omap3xxx_i2c2_hwmod = {
 	.main_clk	= "i2c2_fck",
 	.prcm		= {
 		.omap2 = {
+			.module_offs = CORE_MOD,
 			.prcm_reg_id = 1,
 			.module_bit = OMAP3430_EN_I2C2_SHIFT,
 			.idlest_reg_id = 1,
@@ -724,6 +726,7 @@ static struct omap_hwmod omap3xxx_i2c3_hwmod = {
 	.main_clk	= "i2c3_fck",
 	.prcm		= {
 		.omap2 = {
+			.module_offs = CORE_MOD,
 			.prcm_reg_id = 1,
 			.module_bit = OMAP3430_EN_I2C3_SHIFT,
 			.idlest_reg_id = 1,
-- 
1.7.1

