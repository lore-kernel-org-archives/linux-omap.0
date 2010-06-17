From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 01/12] OMAP2/3: hwmod: remove '_hwmod' suffix from names
Date: Wed, 16 Jun 2010 17:17:02 -0700
Message-ID: <1276733833-18510-2-git-send-email-khilman@deeprootsystems.com>
References: <1276733833-18510-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:49651 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755476Ab0FQARS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Jun 2010 20:17:18 -0400
Received: by pwi1 with SMTP id 1so3974097pwi.19
        for <linux-omap@vger.kernel.org>; Wed, 16 Jun 2010 17:17:18 -0700 (PDT)
In-Reply-To: <1276733833-18510-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: nm@ti.com, thara@ti.com, b-cousson@ti.com

As per new naming convention for hwmods, remove the redundant _hwmod suffix
from all hwmod names.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |    6 +++---
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |    6 +++---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    8 ++++----
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
index e5530c5..284fb23 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -59,7 +59,7 @@ static struct omap_hwmod_ocp_if *omap2420_l3_masters[] = {
 
 /* L3 */
 static struct omap_hwmod omap2420_l3_hwmod = {
-	.name		= "l3_hwmod",
+	.name		= "l3",
 	.class		= &l3_hwmod_class,
 	.masters	= omap2420_l3_masters,
 	.masters_cnt	= ARRAY_SIZE(omap2420_l3_masters),
@@ -89,7 +89,7 @@ static struct omap_hwmod_ocp_if *omap2420_l4_core_masters[] = {
 
 /* L4 CORE */
 static struct omap_hwmod omap2420_l4_core_hwmod = {
-	.name		= "l4_core_hwmod",
+	.name		= "l4_core",
 	.class		= &l4_hwmod_class,
 	.masters	= omap2420_l4_core_masters,
 	.masters_cnt	= ARRAY_SIZE(omap2420_l4_core_masters),
@@ -109,7 +109,7 @@ static struct omap_hwmod_ocp_if *omap2420_l4_wkup_masters[] = {
 
 /* L4 WKUP */
 static struct omap_hwmod omap2420_l4_wkup_hwmod = {
-	.name		= "l4_wkup_hwmod",
+	.name		= "l4_wkup",
 	.class		= &l4_hwmod_class,
 	.masters	= omap2420_l4_wkup_masters,
 	.masters_cnt	= ARRAY_SIZE(omap2420_l4_wkup_masters),
diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index 0852d95..1e780b1 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -59,7 +59,7 @@ static struct omap_hwmod_ocp_if *omap2430_l3_masters[] = {
 
 /* L3 */
 static struct omap_hwmod omap2430_l3_hwmod = {
-	.name		= "l3_hwmod",
+	.name		= "l3",
 	.class		= &l3_hwmod_class,
 	.masters	= omap2430_l3_masters,
 	.masters_cnt	= ARRAY_SIZE(omap2430_l3_masters),
@@ -91,7 +91,7 @@ static struct omap_hwmod_ocp_if *omap2430_l4_core_masters[] = {
 
 /* L4 CORE */
 static struct omap_hwmod omap2430_l4_core_hwmod = {
-	.name		= "l4_core_hwmod",
+	.name		= "l4_core",
 	.class		= &l4_hwmod_class,
 	.masters	= omap2430_l4_core_masters,
 	.masters_cnt	= ARRAY_SIZE(omap2430_l4_core_masters),
@@ -111,7 +111,7 @@ static struct omap_hwmod_ocp_if *omap2430_l4_wkup_masters[] = {
 
 /* L4 WKUP */
 static struct omap_hwmod omap2430_l4_wkup_hwmod = {
-	.name		= "l4_wkup_hwmod",
+	.name		= "l4_wkup",
 	.class		= &l4_hwmod_class,
 	.masters	= omap2430_l4_wkup_masters,
 	.masters_cnt	= ARRAY_SIZE(omap2430_l4_wkup_masters),
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 074347f..f1df4c9 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -73,7 +73,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_l3_masters[] = {
 
 /* L3 */
 static struct omap_hwmod omap3xxx_l3_hwmod = {
-	.name		= "l3_hwmod",
+	.name		= "l3",
 	.class		= &l3_hwmod_class,
 	.masters	= omap3xxx_l3_masters,
 	.masters_cnt	= ARRAY_SIZE(omap3xxx_l3_masters),
@@ -141,7 +141,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_l4_core_masters[] = {
 
 /* L4 CORE */
 static struct omap_hwmod omap3xxx_l4_core_hwmod = {
-	.name		= "l4_core_hwmod",
+	.name		= "l4_core",
 	.class		= &l4_hwmod_class,
 	.masters	= omap3xxx_l4_core_masters,
 	.masters_cnt	= ARRAY_SIZE(omap3xxx_l4_core_masters),
@@ -161,7 +161,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_l4_per_masters[] = {
 
 /* L4 PER */
 static struct omap_hwmod omap3xxx_l4_per_hwmod = {
-	.name		= "l4_per_hwmod",
+	.name		= "l4_per",
 	.class		= &l4_hwmod_class,
 	.masters	= omap3xxx_l4_per_masters,
 	.masters_cnt	= ARRAY_SIZE(omap3xxx_l4_per_masters),
@@ -181,7 +181,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_l4_wkup_masters[] = {
 
 /* L4 WKUP */
 static struct omap_hwmod omap3xxx_l4_wkup_hwmod = {
-	.name		= "l4_wkup_hwmod",
+	.name		= "l4_wkup",
 	.class		= &l4_hwmod_class,
 	.masters	= omap3xxx_l4_wkup_masters,
 	.masters_cnt	= ARRAY_SIZE(omap3xxx_l4_wkup_masters),
-- 
1.7.0.2

