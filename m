From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 2/2] OMAP2&3: hwmod: Remove _hwmod prefix in name string
Date: Mon, 24 May 2010 23:23:14 +0200
Message-ID: <1274736194-30652-3-git-send-email-b-cousson@ti.com>
References: <1274736194-30652-1-git-send-email-b-cousson@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57646 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758020Ab0EXVXY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 24 May 2010 17:23:24 -0400
In-Reply-To: <1274736194-30652-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com
Cc: Benoit Cousson <b-cousson@ti.com>, Rajendra Nayak <rnayak@ti.com>

In the lastest OMAP4 hwmod data file, the _hwmod was removed
in order to save some memory space and because it does not
bring a lot.
Align OMAP2420, 2430 and 3430 data files with the same convention.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |    6 +++---
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |    6 +++---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    8 ++++----
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
index e5530c5..73e27c7 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -59,7 +59,7 @@ static struct omap_hwmod_ocp_if *omap2420_l3_masters[] = {
 
 /* L3 */
 static struct omap_hwmod omap2420_l3_hwmod = {
-	.name		= "l3_hwmod",
+	.name		= "l3_main",
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
index 0852d95..75b57c4 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -59,7 +59,7 @@ static struct omap_hwmod_ocp_if *omap2430_l3_masters[] = {
 
 /* L3 */
 static struct omap_hwmod omap2430_l3_hwmod = {
-	.name		= "l3_hwmod",
+	.name		= "l3_main",
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
index 39b0c0e..3c9b903 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -70,7 +70,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_l3_masters[] = {
 
 /* L3 */
 static struct omap_hwmod omap3xxx_l3_hwmod = {
-	.name		= "l3_hwmod",
+	.name		= "l3_main",
 	.class		= &l3_hwmod_class,
 	.masters	= omap3xxx_l3_masters,
 	.masters_cnt	= ARRAY_SIZE(omap3xxx_l3_masters),
@@ -100,7 +100,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_l4_core_masters[] = {
 
 /* L4 CORE */
 static struct omap_hwmod omap3xxx_l4_core_hwmod = {
-	.name		= "l4_core_hwmod",
+	.name		= "l4_core",
 	.class		= &l4_hwmod_class,
 	.masters	= omap3xxx_l4_core_masters,
 	.masters_cnt	= ARRAY_SIZE(omap3xxx_l4_core_masters),
@@ -120,7 +120,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_l4_per_masters[] = {
 
 /* L4 PER */
 static struct omap_hwmod omap3xxx_l4_per_hwmod = {
-	.name		= "l4_per_hwmod",
+	.name		= "l4_per",
 	.class		= &l4_hwmod_class,
 	.masters	= omap3xxx_l4_per_masters,
 	.masters_cnt	= ARRAY_SIZE(omap3xxx_l4_per_masters),
@@ -140,7 +140,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_l4_wkup_masters[] = {
 
 /* L4 WKUP */
 static struct omap_hwmod omap3xxx_l4_wkup_hwmod = {
-	.name		= "l4_wkup_hwmod",
+	.name		= "l4_wkup",
 	.class		= &l4_hwmod_class,
 	.masters	= omap3xxx_l4_wkup_masters,
 	.masters_cnt	= ARRAY_SIZE(omap3xxx_l4_wkup_masters),
-- 
1.6.1.3

