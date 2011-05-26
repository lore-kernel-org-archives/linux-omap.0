From: Nishanth Menon <nm@ti.com>
Subject: [RFC][PATCH 8/9] OMAP4: clockdomain: Use CHIP_IS_44XX to reuse all CD's on 4460
Date: Wed, 25 May 2011 18:56:55 -0700
Message-ID: <1306375016-707-9-git-send-email-nm@ti.com>
References: <1306375016-707-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:46647 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757036Ab1EZB5e (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 May 2011 21:57:34 -0400
Received: by gxk9 with SMTP id 9so146316gxk.40
        for <linux-omap@vger.kernel.org>; Wed, 25 May 2011 18:57:33 -0700 (PDT)
In-Reply-To: <1306375016-707-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Rajendra Nayak <rnayak@ti.com>

From: Rajendra Nayak <rnayak@ti.com>

The 4460 platform has no difference in the clockdomains
as compared to the 4430 platform.
Hence just update the .omap_chip field to make sure
the same clockdomains model data can be reused on the
4460 platform.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/clockdomains44xx_data.c |  200 +++++++++++++-------------
 1 files changed, 100 insertions(+), 100 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomains44xx_data.c b/arch/arm/mach-omap2/clockdomains44xx_data.c
index a607ec1..f9c980e 100644
--- a/arch/arm/mach-omap2/clockdomains44xx_data.c
+++ b/arch/arm/mach-omap2/clockdomains44xx_data.c
@@ -35,55 +35,55 @@
 static struct clkdm_dep ducati_wkup_sleep_deps[] = {
 	{
 		.clkdm_name	 = "abe_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX)
 	},
 	{
 		.clkdm_name	 = "ivahd_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX)
 	},
 	{
 		.clkdm_name	 = "l3_1_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX)
 	},
 	{
 		.clkdm_name	 = "l3_2_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX)
 	},
 	{
 		.clkdm_name	 = "l3_dss_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX)
 	},
 	{
 		.clkdm_name	 = "l3_emif_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX)
 	},
 	{
 		.clkdm_name	 = "l3_gfx_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX)
 	},
 	{
 		.clkdm_name	 = "l3_init_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX)
 	},
 	{
 		.clkdm_name	 = "l4_cfg_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX)
 	},
 	{
 		.clkdm_name	 = "l4_per_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX)
 	},
 	{
 		.clkdm_name	 = "l4_secure_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX)
 	},
 	{
 		.clkdm_name	 = "l4_wkup_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX)
 	},
 	{
 		.clkdm_name	 = "tesla_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX)
 	},
 	{ NULL },
 };
@@ -91,15 +91,15 @@ static struct clkdm_dep ducati_wkup_sleep_deps[] = {
 static struct clkdm_dep iss_wkup_sleep_deps[] = {
 	{
 		.clkdm_name	 = "ivahd_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX)
 	},
 	{
 		.clkdm_name	 = "l3_1_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX)
 	},
 	{
 		.clkdm_name	 = "l3_emif_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX)
 	},
 	{ NULL },
 };
@@ -107,11 +107,11 @@ static struct clkdm_dep iss_wkup_sleep_deps[] = {
 static struct clkdm_dep ivahd_wkup_sleep_deps[] = {
 	{
 		.clkdm_name	 = "l3_1_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX)
 	},
 	{
 		.clkdm_name	 = "l3_emif_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX)
 	},
 	{ NULL },
 };
@@ -119,35 +119,35 @@ static struct clkdm_dep ivahd_wkup_sleep_deps[] = {
 static struct clkdm_dep l3_d2d_wkup_sleep_deps[] = {
 	{
 		.clkdm_name	 = "abe_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX)
 	},
 	{
 		.clkdm_name	 = "ivahd_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX)
 	},
 	{
 		.clkdm_name	 = "l3_1_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX)
 	},
 	{
 		.clkdm_name	 = "l3_2_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX)
 	},
 	{
 		.clkdm_name	 = "l3_emif_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX)
 	},
 	{
 		.clkdm_name	 = "l3_init_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX)
 	},
 	{
 		.clkdm_name	 = "l4_cfg_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX)
 	},
 	{
 		.clkdm_name	 = "l4_per_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX)
 	},
 	{ NULL },
 };
@@ -155,47 +155,47 @@ static struct clkdm_dep l3_d2d_wkup_sleep_deps[] = {
 static struct clkdm_dep l3_dma_wkup_sleep_deps[] = {
 	{
 		.clkdm_name	 = "abe_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX)
 	},
 	{
 		.clkdm_name	 = "ducati_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX)
 	},
 	{
 		.clkdm_name	 = "ivahd_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX)
 	},
 	{
 		.clkdm_name	 = "l3_1_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX)
 	},
 	{
 		.clkdm_name	 = "l3_dss_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX)
 	},
 	{
 		.clkdm_name	 = "l3_emif_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX)
 	},
 	{
 		.clkdm_name	 = "l3_init_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX)
 	},
 	{
 		.clkdm_name	 = "l4_cfg_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX)
 	},
 	{
 		.clkdm_name	 = "l4_per_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX)
 	},
 	{
 		.clkdm_name	 = "l4_secure_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX)
 	},
 	{
 		.clkdm_name	 = "l4_wkup_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX)
 	},
 	{ NULL },
 };
@@ -203,15 +203,15 @@ static struct clkdm_dep l3_dma_wkup_sleep_deps[] = {
 static struct clkdm_dep l3_dss_wkup_sleep_deps[] = {
 	{
 		.clkdm_name	 = "ivahd_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX)
 	},
 	{
 		.clkdm_name	 = "l3_2_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX)
 	},
 	{
 		.clkdm_name	 = "l3_emif_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX)
 	},
 	{ NULL },
 };
@@ -219,15 +219,15 @@ static struct clkdm_dep l3_dss_wkup_sleep_deps[] = {
 static struct clkdm_dep l3_gfx_wkup_sleep_deps[] = {
 	{
 		.clkdm_name	 = "ivahd_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX)
 	},
 	{
 		.clkdm_name	 = "l3_1_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX)
 	},
 	{
 		.clkdm_name	 = "l3_emif_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX)
 	},
 	{ NULL },
 };
@@ -235,31 +235,31 @@ static struct clkdm_dep l3_gfx_wkup_sleep_deps[] = {
 static struct clkdm_dep l3_init_wkup_sleep_deps[] = {
 	{
 		.clkdm_name	 = "abe_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX)
 	},
 	{
 		.clkdm_name	 = "ivahd_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX)
 	},
 	{
 		.clkdm_name	 = "l3_emif_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX)
 	},
 	{
 		.clkdm_name	 = "l4_cfg_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX)
 	},
 	{
 		.clkdm_name	 = "l4_per_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX)
 	},
 	{
 		.clkdm_name	 = "l4_secure_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX)
 	},
 	{
 		.clkdm_name	 = "l4_wkup_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX)
 	},
 	{ NULL },
 };
@@ -267,15 +267,15 @@ static struct clkdm_dep l3_init_wkup_sleep_deps[] = {
 static struct clkdm_dep l4_secure_wkup_sleep_deps[] = {
 	{
 		.clkdm_name	 = "l3_1_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX)
 	},
 	{
 		.clkdm_name	 = "l3_emif_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX)
 	},
 	{
 		.clkdm_name	 = "l4_per_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX)
 	},
 	{ NULL },
 };
@@ -283,59 +283,59 @@ static struct clkdm_dep l4_secure_wkup_sleep_deps[] = {
 static struct clkdm_dep mpuss_wkup_sleep_deps[] = {
 	{
 		.clkdm_name	 = "abe_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX)
 	},
 	{
 		.clkdm_name	 = "ducati_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX)
 	},
 	{
 		.clkdm_name	 = "ivahd_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX)
 	},
 	{
 		.clkdm_name	 = "l3_1_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX)
 	},
 	{
 		.clkdm_name	 = "l3_2_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX)
 	},
 	{
 		.clkdm_name	 = "l3_dss_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX)
 	},
 	{
 		.clkdm_name	 = "l3_emif_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX)
 	},
 	{
 		.clkdm_name	 = "l3_gfx_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX)
 	},
 	{
 		.clkdm_name	 = "l3_init_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX)
 	},
 	{
 		.clkdm_name	 = "l4_cfg_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX)
 	},
 	{
 		.clkdm_name	 = "l4_per_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX)
 	},
 	{
 		.clkdm_name	 = "l4_secure_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX)
 	},
 	{
 		.clkdm_name	 = "l4_wkup_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX)
 	},
 	{
 		.clkdm_name	 = "tesla_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX)
 	},
 	{ NULL },
 };
@@ -343,39 +343,39 @@ static struct clkdm_dep mpuss_wkup_sleep_deps[] = {
 static struct clkdm_dep tesla_wkup_sleep_deps[] = {
 	{
 		.clkdm_name	 = "abe_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX)
 	},
 	{
 		.clkdm_name	 = "ivahd_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX)
 	},
 	{
 		.clkdm_name	 = "l3_1_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX)
 	},
 	{
 		.clkdm_name	 = "l3_2_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX)
 	},
 	{
 		.clkdm_name	 = "l3_emif_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX)
 	},
 	{
 		.clkdm_name	 = "l3_init_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX)
 	},
 	{
 		.clkdm_name	 = "l4_cfg_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX)
 	},
 	{
 		.clkdm_name	 = "l4_per_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX)
 	},
 	{
 		.clkdm_name	 = "l4_wkup_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX)
 	},
 	{ NULL },
 };
@@ -387,7 +387,7 @@ static struct clockdomain l4_cefuse_44xx_clkdm = {
 	.cm_inst	  = OMAP4430_CM2_CEFUSE_INST,
 	.clkdm_offs	  = OMAP4430_CM2_CEFUSE_CEFUSE_CDOFFS,
 	.flags		  = CLKDM_CAN_FORCE_WAKEUP | CLKDM_CAN_HWSUP,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 static struct clockdomain l4_cfg_44xx_clkdm = {
@@ -398,7 +398,7 @@ static struct clockdomain l4_cfg_44xx_clkdm = {
 	.clkdm_offs	  = OMAP4430_CM2_CORE_L4CFG_CDOFFS,
 	.dep_bit	  = OMAP4430_L4CFG_STATDEP_SHIFT,
 	.flags		  = CLKDM_CAN_HWSUP,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 static struct clockdomain tesla_44xx_clkdm = {
@@ -411,7 +411,7 @@ static struct clockdomain tesla_44xx_clkdm = {
 	.wkdep_srcs	  = tesla_wkup_sleep_deps,
 	.sleepdep_srcs	  = tesla_wkup_sleep_deps,
 	.flags		  = CLKDM_CAN_HWSUP_SWSUP,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 static struct clockdomain l3_gfx_44xx_clkdm = {
@@ -424,7 +424,7 @@ static struct clockdomain l3_gfx_44xx_clkdm = {
 	.wkdep_srcs	  = l3_gfx_wkup_sleep_deps,
 	.sleepdep_srcs	  = l3_gfx_wkup_sleep_deps,
 	.flags		  = CLKDM_CAN_HWSUP_SWSUP,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 static struct clockdomain ivahd_44xx_clkdm = {
@@ -437,7 +437,7 @@ static struct clockdomain ivahd_44xx_clkdm = {
 	.wkdep_srcs	  = ivahd_wkup_sleep_deps,
 	.sleepdep_srcs	  = ivahd_wkup_sleep_deps,
 	.flags		  = CLKDM_CAN_HWSUP_SWSUP,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 static struct clockdomain l4_secure_44xx_clkdm = {
@@ -450,7 +450,7 @@ static struct clockdomain l4_secure_44xx_clkdm = {
 	.wkdep_srcs	  = l4_secure_wkup_sleep_deps,
 	.sleepdep_srcs	  = l4_secure_wkup_sleep_deps,
 	.flags		  = CLKDM_CAN_HWSUP_SWSUP,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 static struct clockdomain l4_per_44xx_clkdm = {
@@ -461,7 +461,7 @@ static struct clockdomain l4_per_44xx_clkdm = {
 	.clkdm_offs	  = OMAP4430_CM2_L4PER_L4PER_CDOFFS,
 	.dep_bit	  = OMAP4430_L4PER_STATDEP_SHIFT,
 	.flags		  = CLKDM_CAN_HWSUP_SWSUP,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 static struct clockdomain abe_44xx_clkdm = {
@@ -472,7 +472,7 @@ static struct clockdomain abe_44xx_clkdm = {
 	.clkdm_offs	  = OMAP4430_CM1_ABE_ABE_CDOFFS,
 	.dep_bit	  = OMAP4430_ABE_STATDEP_SHIFT,
 	.flags		  = CLKDM_CAN_HWSUP_SWSUP,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 static struct clockdomain l3_instr_44xx_clkdm = {
@@ -481,7 +481,7 @@ static struct clockdomain l3_instr_44xx_clkdm = {
 	.prcm_partition	  = OMAP4430_CM2_PARTITION,
 	.cm_inst	  = OMAP4430_CM2_CORE_INST,
 	.clkdm_offs	  = OMAP4430_CM2_CORE_L3INSTR_CDOFFS,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 static struct clockdomain l3_init_44xx_clkdm = {
@@ -494,7 +494,7 @@ static struct clockdomain l3_init_44xx_clkdm = {
 	.wkdep_srcs	  = l3_init_wkup_sleep_deps,
 	.sleepdep_srcs	  = l3_init_wkup_sleep_deps,
 	.flags		  = CLKDM_CAN_HWSUP_SWSUP,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 static struct clockdomain mpuss_44xx_clkdm = {
@@ -506,7 +506,7 @@ static struct clockdomain mpuss_44xx_clkdm = {
 	.wkdep_srcs	  = mpuss_wkup_sleep_deps,
 	.sleepdep_srcs	  = mpuss_wkup_sleep_deps,
 	.flags		  = CLKDM_CAN_FORCE_WAKEUP | CLKDM_CAN_HWSUP,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 static struct clockdomain mpu0_44xx_clkdm = {
@@ -516,7 +516,7 @@ static struct clockdomain mpu0_44xx_clkdm = {
 	.cm_inst	  = OMAP4430_PRCM_MPU_CPU0_INST,
 	.clkdm_offs	  = OMAP4430_PRCM_MPU_CPU0_CPU0_CDOFFS,
 	.flags		  = CLKDM_CAN_FORCE_WAKEUP | CLKDM_CAN_HWSUP,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 static struct clockdomain mpu1_44xx_clkdm = {
@@ -526,7 +526,7 @@ static struct clockdomain mpu1_44xx_clkdm = {
 	.cm_inst	  = OMAP4430_PRCM_MPU_CPU1_INST,
 	.clkdm_offs	  = OMAP4430_PRCM_MPU_CPU1_CPU1_CDOFFS,
 	.flags		  = CLKDM_CAN_FORCE_WAKEUP | CLKDM_CAN_HWSUP,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 static struct clockdomain l3_emif_44xx_clkdm = {
@@ -537,7 +537,7 @@ static struct clockdomain l3_emif_44xx_clkdm = {
 	.clkdm_offs	  = OMAP4430_CM2_CORE_MEMIF_CDOFFS,
 	.dep_bit	  = OMAP4430_MEMIF_STATDEP_SHIFT,
 	.flags		  = CLKDM_CAN_FORCE_WAKEUP | CLKDM_CAN_HWSUP,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 static struct clockdomain l4_ao_44xx_clkdm = {
@@ -547,7 +547,7 @@ static struct clockdomain l4_ao_44xx_clkdm = {
 	.cm_inst	  = OMAP4430_CM2_ALWAYS_ON_INST,
 	.clkdm_offs	  = OMAP4430_CM2_ALWAYS_ON_ALWON_CDOFFS,
 	.flags		  = CLKDM_CAN_FORCE_WAKEUP | CLKDM_CAN_HWSUP,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 static struct clockdomain ducati_44xx_clkdm = {
@@ -560,7 +560,7 @@ static struct clockdomain ducati_44xx_clkdm = {
 	.wkdep_srcs	  = ducati_wkup_sleep_deps,
 	.sleepdep_srcs	  = ducati_wkup_sleep_deps,
 	.flags		  = CLKDM_CAN_HWSUP_SWSUP,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 static struct clockdomain l3_2_44xx_clkdm = {
@@ -571,7 +571,7 @@ static struct clockdomain l3_2_44xx_clkdm = {
 	.clkdm_offs	  = OMAP4430_CM2_CORE_L3_2_CDOFFS,
 	.dep_bit	  = OMAP4430_L3_2_STATDEP_SHIFT,
 	.flags		  = CLKDM_CAN_HWSUP,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 static struct clockdomain l3_1_44xx_clkdm = {
@@ -582,7 +582,7 @@ static struct clockdomain l3_1_44xx_clkdm = {
 	.clkdm_offs	  = OMAP4430_CM2_CORE_L3_1_CDOFFS,
 	.dep_bit	  = OMAP4430_L3_1_STATDEP_SHIFT,
 	.flags		  = CLKDM_CAN_HWSUP,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 static struct clockdomain l3_d2d_44xx_clkdm = {
@@ -594,7 +594,7 @@ static struct clockdomain l3_d2d_44xx_clkdm = {
 	.wkdep_srcs	  = l3_d2d_wkup_sleep_deps,
 	.sleepdep_srcs	  = l3_d2d_wkup_sleep_deps,
 	.flags		  = CLKDM_CAN_FORCE_WAKEUP | CLKDM_CAN_HWSUP,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 static struct clockdomain iss_44xx_clkdm = {
@@ -606,7 +606,7 @@ static struct clockdomain iss_44xx_clkdm = {
 	.wkdep_srcs	  = iss_wkup_sleep_deps,
 	.sleepdep_srcs	  = iss_wkup_sleep_deps,
 	.flags		  = CLKDM_CAN_HWSUP_SWSUP,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 static struct clockdomain l3_dss_44xx_clkdm = {
@@ -619,7 +619,7 @@ static struct clockdomain l3_dss_44xx_clkdm = {
 	.wkdep_srcs	  = l3_dss_wkup_sleep_deps,
 	.sleepdep_srcs	  = l3_dss_wkup_sleep_deps,
 	.flags		  = CLKDM_CAN_HWSUP_SWSUP,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 static struct clockdomain l4_wkup_44xx_clkdm = {
@@ -630,7 +630,7 @@ static struct clockdomain l4_wkup_44xx_clkdm = {
 	.clkdm_offs	  = OMAP4430_PRM_WKUP_CM_WKUP_CDOFFS,
 	.dep_bit	  = OMAP4430_L4WKUP_STATDEP_SHIFT,
 	.flags		  = CLKDM_CAN_HWSUP,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 static struct clockdomain emu_sys_44xx_clkdm = {
@@ -640,7 +640,7 @@ static struct clockdomain emu_sys_44xx_clkdm = {
 	.cm_inst	  = OMAP4430_PRM_EMU_CM_INST,
 	.clkdm_offs	  = OMAP4430_PRM_EMU_CM_EMU_CDOFFS,
 	.flags		  = CLKDM_CAN_HWSUP,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 static struct clockdomain l3_dma_44xx_clkdm = {
@@ -652,7 +652,7 @@ static struct clockdomain l3_dma_44xx_clkdm = {
 	.wkdep_srcs	  = l3_dma_wkup_sleep_deps,
 	.sleepdep_srcs	  = l3_dma_wkup_sleep_deps,
 	.flags		  = CLKDM_CAN_FORCE_WAKEUP | CLKDM_CAN_HWSUP,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 static struct clockdomain *clockdomains_omap44xx[] __initdata = {
-- 
1.7.1

