From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH pm-wip/uart 2/4] OMAP2/3: hwmod: L3 and L4 CORE/PER/WKUP hwmods don't have IDLEST
Date: Wed, 26 May 2010 16:05:13 -0700
Message-ID: <1274915115-28355-3-git-send-email-khilman@deeprootsystems.com>
References: <1274915115-28355-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:36727 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755110Ab0EZXFZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 May 2010 19:05:25 -0400
Received: by mail-pw0-f46.google.com with SMTP id 7so430965pwi.19
        for <linux-omap@vger.kernel.org>; Wed, 26 May 2010 16:05:25 -0700 (PDT)
In-Reply-To: <1274915115-28355-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Since these hwmods do not have IDLEST, set the HWMOD_NO_IDLEST flag,
otherwise _enable() will fail due to failing _wait_target_ready().

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |    9 ++++++---
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |    9 ++++++---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   12 ++++++++----
 3 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
index bbe3006..b9a957d 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -66,7 +66,8 @@ static struct omap_hwmod omap2420_l3_hwmod = {
 	.masters_cnt	= ARRAY_SIZE(omap2420_l3_masters),
 	.slaves		= omap2420_l3_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2420_l3_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420)
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
+	.flags		= HWMOD_NO_IDLEST,
 };
 
 static struct omap_hwmod omap2420_l4_wkup_hwmod;
@@ -156,7 +157,8 @@ static struct omap_hwmod omap2420_l4_core_hwmod = {
 	.masters_cnt	= ARRAY_SIZE(omap2420_l4_core_masters),
 	.slaves		= omap2420_l4_core_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2420_l4_core_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420)
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
+	.flags		= HWMOD_NO_IDLEST,
 };
 
 /* Slave interfaces on the L4_WKUP interconnect */
@@ -176,7 +178,8 @@ static struct omap_hwmod omap2420_l4_wkup_hwmod = {
 	.masters_cnt	= ARRAY_SIZE(omap2420_l4_wkup_masters),
 	.slaves		= omap2420_l4_wkup_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2420_l4_wkup_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420)
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
+	.flags		= HWMOD_NO_IDLEST,
 };
 
 /* Master interfaces on the MPU device */
diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index 45767b1..d7faef2 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -66,7 +66,8 @@ static struct omap_hwmod omap2430_l3_hwmod = {
 	.masters_cnt	= ARRAY_SIZE(omap2430_l3_masters),
 	.slaves		= omap2430_l3_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2430_l3_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430)
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
+	.flags		= HWMOD_NO_IDLEST,
 };
 
 static struct omap_hwmod omap2430_l4_wkup_hwmod;
@@ -155,7 +156,8 @@ static struct omap_hwmod omap2430_l4_core_hwmod = {
 	.masters_cnt	= ARRAY_SIZE(omap2430_l4_core_masters),
 	.slaves		= omap2430_l4_core_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2430_l4_core_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430)
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
+	.flags		= HWMOD_NO_IDLEST,
 };
 
 /* Slave interfaces on the L4_WKUP interconnect */
@@ -178,7 +180,8 @@ static struct omap_hwmod omap2430_l4_wkup_hwmod = {
 	.masters_cnt	= ARRAY_SIZE(omap2430_l4_wkup_masters),
 	.slaves		= omap2430_l4_wkup_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2430_l4_wkup_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430)
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
+	.flags		= HWMOD_NO_IDLEST,
 };
 
 /* Master interfaces on the MPU device */
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 5bf8690..6bc1173 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -77,7 +77,8 @@ static struct omap_hwmod omap3xxx_l3_hwmod = {
 	.masters_cnt	= ARRAY_SIZE(omap3xxx_l3_masters),
 	.slaves		= omap3xxx_l3_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_l3_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.flags		= HWMOD_NO_IDLEST,
 };
 
 static struct omap_hwmod omap3xxx_l4_wkup_hwmod;
@@ -185,7 +186,8 @@ static struct omap_hwmod omap3xxx_l4_core_hwmod = {
 	.masters_cnt	= ARRAY_SIZE(omap3xxx_l4_core_masters),
 	.slaves		= omap3xxx_l4_core_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_l4_core_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.flags		= HWMOD_NO_IDLEST,
 };
 
 /* Slave interfaces on the L4_PER interconnect */
@@ -207,7 +209,8 @@ static struct omap_hwmod omap3xxx_l4_per_hwmod = {
 	.masters_cnt	= ARRAY_SIZE(omap3xxx_l4_per_masters),
 	.slaves		= omap3xxx_l4_per_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_l4_per_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.flags		= HWMOD_NO_IDLEST,
 };
 
 /* Slave interfaces on the L4_WKUP interconnect */
@@ -227,7 +230,8 @@ static struct omap_hwmod omap3xxx_l4_wkup_hwmod = {
 	.masters_cnt	= ARRAY_SIZE(omap3xxx_l4_wkup_masters),
 	.slaves		= omap3xxx_l4_wkup_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_l4_wkup_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.flags		= HWMOD_NO_IDLEST,
 };
 
 /* Master interfaces on the MPU device */
-- 
1.7.0.2

