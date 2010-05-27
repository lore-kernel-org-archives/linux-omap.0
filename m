From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 5/5] OMAP2/3: hwmod: L3 and L4 CORE/PER/WKUP hwmods don't have IDLEST
Date: Thu, 27 May 2010 14:13:36 -0700
Message-ID: <1274994816-30335-6-git-send-email-khilman@deeprootsystems.com>
References: <1274994816-30335-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:44665 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756733Ab0E0VNs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 May 2010 17:13:48 -0400
Received: by mail-px0-f174.google.com with SMTP id 18so219680pxi.19
        for <linux-omap@vger.kernel.org>; Thu, 27 May 2010 14:13:48 -0700 (PDT)
In-Reply-To: <1274994816-30335-1-git-send-email-khilman@deeprootsystems.com>
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
index e5530c5..a8b57a6 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -65,7 +65,8 @@ static struct omap_hwmod omap2420_l3_hwmod = {
 	.masters_cnt	= ARRAY_SIZE(omap2420_l3_masters),
 	.slaves		= omap2420_l3_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2420_l3_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420)
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
+	.flags		= HWMOD_NO_IDLEST,
 };
 
 static struct omap_hwmod omap2420_l4_wkup_hwmod;
@@ -95,7 +96,8 @@ static struct omap_hwmod omap2420_l4_core_hwmod = {
 	.masters_cnt	= ARRAY_SIZE(omap2420_l4_core_masters),
 	.slaves		= omap2420_l4_core_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2420_l4_core_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420)
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
+	.flags		= HWMOD_NO_IDLEST,
 };
 
 /* Slave interfaces on the L4_WKUP interconnect */
@@ -115,7 +117,8 @@ static struct omap_hwmod omap2420_l4_wkup_hwmod = {
 	.masters_cnt	= ARRAY_SIZE(omap2420_l4_wkup_masters),
 	.slaves		= omap2420_l4_wkup_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2420_l4_wkup_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420)
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
+	.flags		= HWMOD_NO_IDLEST,
 };
 
 /* Master interfaces on the MPU device */
diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index 0852d95..8b1f74b 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -65,7 +65,8 @@ static struct omap_hwmod omap2430_l3_hwmod = {
 	.masters_cnt	= ARRAY_SIZE(omap2430_l3_masters),
 	.slaves		= omap2430_l3_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2430_l3_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430)
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
+	.flags		= HWMOD_NO_IDLEST,
 };
 
 static struct omap_hwmod omap2430_l4_wkup_hwmod;
@@ -97,7 +98,8 @@ static struct omap_hwmod omap2430_l4_core_hwmod = {
 	.masters_cnt	= ARRAY_SIZE(omap2430_l4_core_masters),
 	.slaves		= omap2430_l4_core_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2430_l4_core_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430)
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
+	.flags		= HWMOD_NO_IDLEST,
 };
 
 /* Slave interfaces on the L4_WKUP interconnect */
@@ -117,7 +119,8 @@ static struct omap_hwmod omap2430_l4_wkup_hwmod = {
 	.masters_cnt	= ARRAY_SIZE(omap2430_l4_wkup_masters),
 	.slaves		= omap2430_l4_wkup_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2430_l4_wkup_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430)
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
+	.flags		= HWMOD_NO_IDLEST,
 };
 
 /* Master interfaces on the MPU device */
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 39b0c0e..e288b20 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -76,7 +76,8 @@ static struct omap_hwmod omap3xxx_l3_hwmod = {
 	.masters_cnt	= ARRAY_SIZE(omap3xxx_l3_masters),
 	.slaves		= omap3xxx_l3_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_l3_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.flags		= HWMOD_NO_IDLEST,
 };
 
 static struct omap_hwmod omap3xxx_l4_wkup_hwmod;
@@ -106,7 +107,8 @@ static struct omap_hwmod omap3xxx_l4_core_hwmod = {
 	.masters_cnt	= ARRAY_SIZE(omap3xxx_l4_core_masters),
 	.slaves		= omap3xxx_l4_core_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_l4_core_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.flags		= HWMOD_NO_IDLEST,
 };
 
 /* Slave interfaces on the L4_PER interconnect */
@@ -126,7 +128,8 @@ static struct omap_hwmod omap3xxx_l4_per_hwmod = {
 	.masters_cnt	= ARRAY_SIZE(omap3xxx_l4_per_masters),
 	.slaves		= omap3xxx_l4_per_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_l4_per_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.flags		= HWMOD_NO_IDLEST,
 };
 
 /* Slave interfaces on the L4_WKUP interconnect */
@@ -146,7 +149,8 @@ static struct omap_hwmod omap3xxx_l4_wkup_hwmod = {
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

