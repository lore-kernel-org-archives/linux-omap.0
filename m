From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH v2 05/13] OMAP2&3: hwmod: Remove _hwmod prefix in name string
Date: Thu, 24 Jun 2010 16:44:36 -0700
Message-ID: <1277423084-25528-6-git-send-email-khilman@deeprootsystems.com>
References: <1277423084-25528-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:45007 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753033Ab0FXXo5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Jun 2010 19:44:57 -0400
Received: by pvg2 with SMTP id 2so587510pvg.19
        for <linux-omap@vger.kernel.org>; Thu, 24 Jun 2010 16:44:56 -0700 (PDT)
In-Reply-To: <1277423084-25528-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, Benoit Cousson <b-cousson@ti.com>, Rajendra Nayak <rnayak@ti.com>

From: Benoit Cousson <b-cousson@ti.com>

In the lastest OMAP4 hwmod data file, the _hwmod was removed
in order to save some memory space and because it does not
bring a lot.
Align OMAP2420, 2430 and 3430 data files with the same convention.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |    6 +++---
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |    6 +++---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    8 ++++----
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
index a8b57a6..646386c 100644
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
@@ -90,7 +90,7 @@ static struct omap_hwmod_ocp_if *omap2420_l4_core_masters[] = {
 
 /* L4 CORE */
 static struct omap_hwmod omap2420_l4_core_hwmod = {
-	.name		= "l4_core_hwmod",
+	.name		= "l4_core",
 	.class		= &l4_hwmod_class,
 	.masters	= omap2420_l4_core_masters,
 	.masters_cnt	= ARRAY_SIZE(omap2420_l4_core_masters),
@@ -111,7 +111,7 @@ static struct omap_hwmod_ocp_if *omap2420_l4_wkup_masters[] = {
 
 /* L4 WKUP */
 static struct omap_hwmod omap2420_l4_wkup_hwmod = {
-	.name		= "l4_wkup_hwmod",
+	.name		= "l4_wkup",
 	.class		= &l4_hwmod_class,
 	.masters	= omap2420_l4_wkup_masters,
 	.masters_cnt	= ARRAY_SIZE(omap2420_l4_wkup_masters),
diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index 8b1f74b..b2100cf 100644
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
@@ -92,7 +92,7 @@ static struct omap_hwmod_ocp_if *omap2430_l4_core_masters[] = {
 
 /* L4 CORE */
 static struct omap_hwmod omap2430_l4_core_hwmod = {
-	.name		= "l4_core_hwmod",
+	.name		= "l4_core",
 	.class		= &l4_hwmod_class,
 	.masters	= omap2430_l4_core_masters,
 	.masters_cnt	= ARRAY_SIZE(omap2430_l4_core_masters),
@@ -113,7 +113,7 @@ static struct omap_hwmod_ocp_if *omap2430_l4_wkup_masters[] = {
 
 /* L4 WKUP */
 static struct omap_hwmod omap2430_l4_wkup_hwmod = {
-	.name		= "l4_wkup_hwmod",
+	.name		= "l4_wkup",
 	.class		= &l4_hwmod_class,
 	.masters	= omap2430_l4_wkup_masters,
 	.masters_cnt	= ARRAY_SIZE(omap2430_l4_wkup_masters),
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index e288b20..ec6a5f8 100644
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
@@ -101,7 +101,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_l4_core_masters[] = {
 
 /* L4 CORE */
 static struct omap_hwmod omap3xxx_l4_core_hwmod = {
-	.name		= "l4_core_hwmod",
+	.name		= "l4_core",
 	.class		= &l4_hwmod_class,
 	.masters	= omap3xxx_l4_core_masters,
 	.masters_cnt	= ARRAY_SIZE(omap3xxx_l4_core_masters),
@@ -122,7 +122,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_l4_per_masters[] = {
 
 /* L4 PER */
 static struct omap_hwmod omap3xxx_l4_per_hwmod = {
-	.name		= "l4_per_hwmod",
+	.name		= "l4_per",
 	.class		= &l4_hwmod_class,
 	.masters	= omap3xxx_l4_per_masters,
 	.masters_cnt	= ARRAY_SIZE(omap3xxx_l4_per_masters),
@@ -143,7 +143,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_l4_wkup_masters[] = {
 
 /* L4 WKUP */
 static struct omap_hwmod omap3xxx_l4_wkup_hwmod = {
-	.name		= "l4_wkup_hwmod",
+	.name		= "l4_wkup",
 	.class		= &l4_hwmod_class,
 	.masters	= omap3xxx_l4_wkup_masters,
 	.masters_cnt	= ARRAY_SIZE(omap3xxx_l4_wkup_masters),
-- 
1.7.0.2

