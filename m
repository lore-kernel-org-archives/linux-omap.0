From: Thara Gopinath <thara@ti.com>
Subject: [PATCH 12/13] OMAP3: Introduce voltage domain info in the hwmod structures.
Date: Wed, 18 Aug 2010 16:50:11 +0530
Message-ID: <1282130412-12027-13-git-send-email-thara@ti.com>
References: <1282130412-12027-1-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41244 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752809Ab0HRLU1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Aug 2010 07:20:27 -0400
In-Reply-To: <1282130412-12027-1-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, vishwanath.bs@ti.com, sawant@ti.com, b-cousson@ti.com, Thara Gopinath <thara@ti.com>

This patch adds voltage domain info in the relevant
device hwmod structures so as to enable OMAP3 DVFS
support.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index c9f0948..a6a67ed 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -77,6 +77,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_l3_main_masters[] = {
 static struct omap_hwmod omap3xxx_l3_main_hwmod = {
 	.name		= "l3_main",
 	.class		= &l3_hwmod_class,
+	.vdd_name	= "core",
 	.masters	= omap3xxx_l3_main_masters,
 	.masters_cnt	= ARRAY_SIZE(omap3xxx_l3_main_masters),
 	.slaves		= omap3xxx_l3_main_slaves,
@@ -206,6 +207,7 @@ static struct omap_hwmod omap3xxx_mpu_hwmod = {
 	.name		= "mpu",
 	.class		= &mpu_hwmod_class,
 	.main_clk	= "arm_fck",
+	.vdd_name	= "mpu",
 	.masters	= omap3xxx_mpu_masters,
 	.masters_cnt	= ARRAY_SIZE(omap3xxx_mpu_masters),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
@@ -234,6 +236,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_iva_masters[] = {
 static struct omap_hwmod omap3xxx_iva_hwmod = {
 	.name		= "iva",
 	.class		= &iva_hwmod_class,
+	.vdd_name	= "mpu",
 	.masters	= omap3xxx_iva_masters,
 	.masters_cnt	= ARRAY_SIZE(omap3xxx_iva_masters),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-- 
1.7.1.GIT

