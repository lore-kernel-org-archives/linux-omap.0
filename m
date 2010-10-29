From: Thara Gopinath <thara@ti.com>
Subject: [PATCH v2 12/14] OMAP3: Introduce voltage domain info in the hwmod structures.
Date: Fri, 29 Oct 2010 21:08:26 +0530
Message-ID: <1288366708-32302-13-git-send-email-thara@ti.com>
References: <1288366708-32302-1-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34620 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933887Ab0J2Pim (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 29 Oct 2010 11:38:42 -0400
In-Reply-To: <1288366708-32302-1-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, khilman@deeprootsystems.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com, Thara Gopinath <thara@ti.com>

This patch adds voltage domain info in the relevant
device hwmod structures so as to enable OMAP3 DVFS
support.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index a6fbb6f..f73d4b7 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -86,6 +86,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_l3_main_masters[] = {
 static struct omap_hwmod omap3xxx_l3_main_hwmod = {
 	.name		= "l3_main",
 	.class		= &l3_hwmod_class,
+	.vdd_name	= "core",
 	.masters	= omap3xxx_l3_main_masters,
 	.masters_cnt	= ARRAY_SIZE(omap3xxx_l3_main_masters),
 	.slaves		= omap3xxx_l3_main_slaves,
@@ -376,6 +377,7 @@ static struct omap_hwmod omap3xxx_mpu_hwmod = {
 	.name		= "mpu",
 	.class		= &mpu_hwmod_class,
 	.main_clk	= "arm_fck",
+	.vdd_name	= "mpu",
 	.masters	= omap3xxx_mpu_masters,
 	.masters_cnt	= ARRAY_SIZE(omap3xxx_mpu_masters),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
@@ -404,6 +406,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_iva_masters[] = {
 static struct omap_hwmod omap3xxx_iva_hwmod = {
 	.name		= "iva",
 	.class		= &iva_hwmod_class,
+	.vdd_name	= "mpu",
 	.masters	= omap3xxx_iva_masters,
 	.masters_cnt	= ARRAY_SIZE(omap3xxx_iva_masters),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-- 
1.7.0.4

