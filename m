From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH v2 6/6] OMAP4: clockdomain: Reuse on 4460 using CHIP_IS_44XX
Date: Sat, 2 Jul 2011 08:00:26 +0530
Message-ID: <1309573826-10615-7-git-send-email-rnayak@ti.com>
References: <1309573826-10615-1-git-send-email-rnayak@ti.com>
 <1309573826-10615-2-git-send-email-rnayak@ti.com>
 <1309573826-10615-3-git-send-email-rnayak@ti.com>
 <1309573826-10615-4-git-send-email-rnayak@ti.com>
 <1309573826-10615-5-git-send-email-rnayak@ti.com>
 <1309573826-10615-6-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43131 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752971Ab1GBCbu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Jul 2011 22:31:50 -0400
In-Reply-To: <1309573826-10615-6-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, khilman@ti.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>, Nishanth Menon <nm@ti.com>

The 4460 platform has no difference in the clockdomains as compared
to the 4430 platform. Hence just update the .omap_chip field to make
sure the same clockdomain data can be reused on the 4460 platform.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Reviewed-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/clockdomains44xx_data.c |  200 +++++++++++++-------------
 1 files changed, 100 insertions(+), 100 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomains44xx_data.c b/arch/arm/mach-omap2/clockdomains44xx_data.c
index 66090f2..d88e6ac 100644
--- a/arch/arm/mach-omap2/clockdomains44xx_data.c
+++ b/arch/arm/mach-omap2/clockdomains44xx_data.c
@@ -36,35 +36,35 @@
 static struct clkdm_dep d2d_wkup_sleep_deps[] = {
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
@@ -72,55 +72,55 @@ static struct clkdm_dep d2d_wkup_sleep_deps[] = {
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
@@ -128,15 +128,15 @@ static struct clkdm_dep ducati_wkup_sleep_deps[] = {
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
@@ -144,11 +144,11 @@ static struct clkdm_dep iss_wkup_sleep_deps[] = {
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
@@ -156,47 +156,47 @@ static struct clkdm_dep ivahd_wkup_sleep_deps[] = {
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
@@ -204,15 +204,15 @@ static struct clkdm_dep l3_dma_wkup_sleep_deps[] = {
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
@@ -220,15 +220,15 @@ static struct clkdm_dep l3_dss_wkup_sleep_deps[] = {
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
@@ -236,31 +236,31 @@ static struct clkdm_dep l3_gfx_wkup_sleep_deps[] = {
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
@@ -268,15 +268,15 @@ static struct clkdm_dep l3_init_wkup_sleep_deps[] = {
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
@@ -284,59 +284,59 @@ static struct clkdm_dep l4_secure_wkup_sleep_deps[] = {
 static struct clkdm_dep mpu_wkup_sleep_deps[] = {
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
@@ -344,39 +344,39 @@ static struct clkdm_dep mpu_wkup_sleep_deps[] = {
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
@@ -388,7 +388,7 @@ static struct clockdomain l4_cefuse_44xx_clkdm = {
 	.cm_inst	  = OMAP4430_CM2_CEFUSE_INST,
 	.clkdm_offs	  = OMAP4430_CM2_CEFUSE_CEFUSE_CDOFFS,
 	.flags		  = CLKDM_CAN_FORCE_WAKEUP | CLKDM_CAN_HWSUP,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 static struct clockdomain l4_cfg_44xx_clkdm = {
@@ -399,7 +399,7 @@ static struct clockdomain l4_cfg_44xx_clkdm = {
 	.clkdm_offs	  = OMAP4430_CM2_CORE_L4CFG_CDOFFS,
 	.dep_bit	  = OMAP4430_L4CFG_STATDEP_SHIFT,
 	.flags		  = CLKDM_CAN_HWSUP,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 static struct clockdomain tesla_44xx_clkdm = {
@@ -412,7 +412,7 @@ static struct clockdomain tesla_44xx_clkdm = {
 	.wkdep_srcs	  = tesla_wkup_sleep_deps,
 	.sleepdep_srcs	  = tesla_wkup_sleep_deps,
 	.flags		  = CLKDM_CAN_HWSUP_SWSUP,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 static struct clockdomain l3_gfx_44xx_clkdm = {
@@ -425,7 +425,7 @@ static struct clockdomain l3_gfx_44xx_clkdm = {
 	.wkdep_srcs	  = l3_gfx_wkup_sleep_deps,
 	.sleepdep_srcs	  = l3_gfx_wkup_sleep_deps,
 	.flags		  = CLKDM_CAN_HWSUP_SWSUP,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 static struct clockdomain ivahd_44xx_clkdm = {
@@ -438,7 +438,7 @@ static struct clockdomain ivahd_44xx_clkdm = {
 	.wkdep_srcs	  = ivahd_wkup_sleep_deps,
 	.sleepdep_srcs	  = ivahd_wkup_sleep_deps,
 	.flags		  = CLKDM_CAN_HWSUP_SWSUP,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 static struct clockdomain l4_secure_44xx_clkdm = {
@@ -451,7 +451,7 @@ static struct clockdomain l4_secure_44xx_clkdm = {
 	.wkdep_srcs	  = l4_secure_wkup_sleep_deps,
 	.sleepdep_srcs	  = l4_secure_wkup_sleep_deps,
 	.flags		  = CLKDM_CAN_HWSUP_SWSUP,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 static struct clockdomain l4_per_44xx_clkdm = {
@@ -462,7 +462,7 @@ static struct clockdomain l4_per_44xx_clkdm = {
 	.clkdm_offs	  = OMAP4430_CM2_L4PER_L4PER_CDOFFS,
 	.dep_bit	  = OMAP4430_L4PER_STATDEP_SHIFT,
 	.flags		  = CLKDM_CAN_HWSUP_SWSUP,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 static struct clockdomain abe_44xx_clkdm = {
@@ -473,7 +473,7 @@ static struct clockdomain abe_44xx_clkdm = {
 	.clkdm_offs	  = OMAP4430_CM1_ABE_ABE_CDOFFS,
 	.dep_bit	  = OMAP4430_ABE_STATDEP_SHIFT,
 	.flags		  = CLKDM_CAN_HWSUP_SWSUP,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 static struct clockdomain l3_instr_44xx_clkdm = {
@@ -482,7 +482,7 @@ static struct clockdomain l3_instr_44xx_clkdm = {
 	.prcm_partition	  = OMAP4430_CM2_PARTITION,
 	.cm_inst	  = OMAP4430_CM2_CORE_INST,
 	.clkdm_offs	  = OMAP4430_CM2_CORE_L3INSTR_CDOFFS,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 static struct clockdomain l3_init_44xx_clkdm = {
@@ -495,7 +495,7 @@ static struct clockdomain l3_init_44xx_clkdm = {
 	.wkdep_srcs	  = l3_init_wkup_sleep_deps,
 	.sleepdep_srcs	  = l3_init_wkup_sleep_deps,
 	.flags		  = CLKDM_CAN_HWSUP_SWSUP,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 static struct clockdomain d2d_44xx_clkdm = {
@@ -507,7 +507,7 @@ static struct clockdomain d2d_44xx_clkdm = {
 	.wkdep_srcs	  = d2d_wkup_sleep_deps,
 	.sleepdep_srcs	  = d2d_wkup_sleep_deps,
 	.flags		  = CLKDM_CAN_FORCE_WAKEUP | CLKDM_CAN_HWSUP,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 static struct clockdomain mpu0_44xx_clkdm = {
@@ -517,7 +517,7 @@ static struct clockdomain mpu0_44xx_clkdm = {
 	.cm_inst	  = OMAP4430_PRCM_MPU_CPU0_INST,
 	.clkdm_offs	  = OMAP4430_PRCM_MPU_CPU0_CPU0_CDOFFS,
 	.flags		  = CLKDM_CAN_FORCE_WAKEUP | CLKDM_CAN_HWSUP,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 static struct clockdomain mpu1_44xx_clkdm = {
@@ -527,7 +527,7 @@ static struct clockdomain mpu1_44xx_clkdm = {
 	.cm_inst	  = OMAP4430_PRCM_MPU_CPU1_INST,
 	.clkdm_offs	  = OMAP4430_PRCM_MPU_CPU1_CPU1_CDOFFS,
 	.flags		  = CLKDM_CAN_FORCE_WAKEUP | CLKDM_CAN_HWSUP,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 static struct clockdomain l3_emif_44xx_clkdm = {
@@ -538,7 +538,7 @@ static struct clockdomain l3_emif_44xx_clkdm = {
 	.clkdm_offs	  = OMAP4430_CM2_CORE_MEMIF_CDOFFS,
 	.dep_bit	  = OMAP4430_MEMIF_STATDEP_SHIFT,
 	.flags		  = CLKDM_CAN_FORCE_WAKEUP | CLKDM_CAN_HWSUP,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 static struct clockdomain l4_ao_44xx_clkdm = {
@@ -548,7 +548,7 @@ static struct clockdomain l4_ao_44xx_clkdm = {
 	.cm_inst	  = OMAP4430_CM2_ALWAYS_ON_INST,
 	.clkdm_offs	  = OMAP4430_CM2_ALWAYS_ON_ALWON_CDOFFS,
 	.flags		  = CLKDM_CAN_FORCE_WAKEUP | CLKDM_CAN_HWSUP,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 static struct clockdomain ducati_44xx_clkdm = {
@@ -561,7 +561,7 @@ static struct clockdomain ducati_44xx_clkdm = {
 	.wkdep_srcs	  = ducati_wkup_sleep_deps,
 	.sleepdep_srcs	  = ducati_wkup_sleep_deps,
 	.flags		  = CLKDM_CAN_HWSUP_SWSUP,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 static struct clockdomain mpu_44xx_clkdm = {
@@ -573,7 +573,7 @@ static struct clockdomain mpu_44xx_clkdm = {
 	.wkdep_srcs	  = mpu_wkup_sleep_deps,
 	.sleepdep_srcs	  = mpu_wkup_sleep_deps,
 	.flags		  = CLKDM_CAN_FORCE_WAKEUP | CLKDM_CAN_HWSUP,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 static struct clockdomain l3_2_44xx_clkdm = {
@@ -584,7 +584,7 @@ static struct clockdomain l3_2_44xx_clkdm = {
 	.clkdm_offs	  = OMAP4430_CM2_CORE_L3_2_CDOFFS,
 	.dep_bit	  = OMAP4430_L3_2_STATDEP_SHIFT,
 	.flags		  = CLKDM_CAN_HWSUP,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 static struct clockdomain l3_1_44xx_clkdm = {
@@ -595,7 +595,7 @@ static struct clockdomain l3_1_44xx_clkdm = {
 	.clkdm_offs	  = OMAP4430_CM2_CORE_L3_1_CDOFFS,
 	.dep_bit	  = OMAP4430_L3_1_STATDEP_SHIFT,
 	.flags		  = CLKDM_CAN_HWSUP,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 static struct clockdomain iss_44xx_clkdm = {
@@ -607,7 +607,7 @@ static struct clockdomain iss_44xx_clkdm = {
 	.wkdep_srcs	  = iss_wkup_sleep_deps,
 	.sleepdep_srcs	  = iss_wkup_sleep_deps,
 	.flags		  = CLKDM_CAN_HWSUP_SWSUP,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 static struct clockdomain l3_dss_44xx_clkdm = {
@@ -620,7 +620,7 @@ static struct clockdomain l3_dss_44xx_clkdm = {
 	.wkdep_srcs	  = l3_dss_wkup_sleep_deps,
 	.sleepdep_srcs	  = l3_dss_wkup_sleep_deps,
 	.flags		  = CLKDM_CAN_HWSUP_SWSUP,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 static struct clockdomain l4_wkup_44xx_clkdm = {
@@ -631,7 +631,7 @@ static struct clockdomain l4_wkup_44xx_clkdm = {
 	.clkdm_offs	  = OMAP4430_PRM_WKUP_CM_WKUP_CDOFFS,
 	.dep_bit	  = OMAP4430_L4WKUP_STATDEP_SHIFT,
 	.flags		  = CLKDM_CAN_HWSUP,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 static struct clockdomain emu_sys_44xx_clkdm = {
@@ -641,7 +641,7 @@ static struct clockdomain emu_sys_44xx_clkdm = {
 	.cm_inst	  = OMAP4430_PRM_EMU_CM_INST,
 	.clkdm_offs	  = OMAP4430_PRM_EMU_CM_EMU_CDOFFS,
 	.flags		  = CLKDM_CAN_HWSUP,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 static struct clockdomain l3_dma_44xx_clkdm = {
@@ -653,7 +653,7 @@ static struct clockdomain l3_dma_44xx_clkdm = {
 	.wkdep_srcs	  = l3_dma_wkup_sleep_deps,
 	.sleepdep_srcs	  = l3_dma_wkup_sleep_deps,
 	.flags		  = CLKDM_CAN_FORCE_WAKEUP | CLKDM_CAN_HWSUP,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 /* As clockdomains are added or removed above, this list must also be changed */
-- 
1.7.4.1

