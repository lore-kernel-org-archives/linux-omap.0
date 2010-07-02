From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 06/20] OMAP2/3: hwmod: L3 and L4 CORE/PER/WKUP hwmods don't
 have IDLEST
Date: Fri, 02 Jul 2010 09:29:20 -0600
Message-ID: <20100702152918.6221.71045.stgit@localhost.localdomain>
References: <20100702152703.6221.33529.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:45271 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758876Ab0GBPbB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Jul 2010 11:31:01 -0400
In-Reply-To: <20100702152703.6221.33529.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>

From: Kevin Hilman <khilman@deeprootsystems.com>

Since these hwmods do not have IDLEST, set the HWMOD_NO_IDLEST flag,
otherwise _enable() will fail due to failing _wait_target_ready().

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
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


