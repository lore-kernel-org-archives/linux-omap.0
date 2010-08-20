From: "kishore kadiyala" <kishore.kadiyala@ti.com>
Subject: [PATCH 03/10] [PM-WIP-MMC] OMAP2/OMAP3: Updating hwmod name for
     MMC controller
Date: Sat, 21 Aug 2010 01:40:38 +0530 (IST)
Message-ID: <16095.10.24.255.18.1282335038.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46738 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751442Ab0HTUKm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Aug 2010 16:10:42 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, tony@atomide.com, b-cousson@ti.com

Updating oh_name for MMC controller with "mmcx" instead of "mmcx_hwmod".

Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
---
 arch/arm/mach-omap2/devices.c              |    2 +-
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |    4 ++--
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    6 +++---
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 6df1e52..5b0e171 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -756,7 +756,7 @@ void __init omap2_init_mmc(struct omap_mmc_platform_data **mmc_data,
 		int idx = i - 1;

 		l = snprintf(oh_name, MAX_OMAP_MMC_HWMOD_NAME_LEN,
-			     "mmc%d_hwmod", i);
+			     "mmc%d", i);
 		WARN(l >= MAX_OMAP_MMC_HWMOD_NAME_LEN,
 		     "String buffer overflow in MMC%d device setup\n", i);
 		oh = omap_hwmod_lookup(oh_name);
diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index d342f58..2eb6868 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -440,7 +440,7 @@ static struct omap_hwmod_ocp_if *omap2430_mmc1_slaves[] = {
 };

 static struct omap_hwmod omap2430_mmc1_hwmod = {
-	.name		= "mmc1_hwmod",
+	.name		= "mmc1",
 	.mpu_irqs	= mmc1_mpu_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(mmc1_mpu_irqs),
 	.sdma_reqs	= mmc1_sdma_reqs,
@@ -488,7 +488,7 @@ static struct omap_hwmod_ocp_if *omap2430_mmc2_slaves[] = {
 };

 static struct omap_hwmod omap2430_mmc2_hwmod = {
-	.name		= "mmc2_hwmod",
+	.name		= "mmc2",
 	.mpu_irqs	= mmc2_mpu_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(mmc2_mpu_irqs),
 	.sdma_reqs	= mmc2_sdma_reqs,
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 6412cc4..990638e 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -567,7 +567,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_mmc1_slaves[] = {
 };

 static struct omap_hwmod omap3xxx_mmc1_hwmod = {
-	.name		= "mmc1_hwmod",
+	.name		= "mmc1",
 	.mpu_irqs	= mmc1_mpu_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(mmc1_mpu_irqs),
 	.sdma_reqs	= mmc1_sdma_reqs,
@@ -615,7 +615,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_mmc2_slaves[] = {
 };

 static struct omap_hwmod omap3xxx_mmc2_hwmod = {
-	.name		= "mmc2_hwmod",
+	.name		= "mmc2",
 	.mpu_irqs	= mmc2_mpu_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(mmc2_mpu_irqs),
 	.sdma_reqs	= mmc2_sdma_reqs,
@@ -661,7 +661,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_mmc3_slaves[] = {
 };

 static struct omap_hwmod omap3xxx_mmc3_hwmod = {
-	.name		= "mmc3_hwmod",
+	.name		= "mmc3",
 	.mpu_irqs	= mmc3_mpu_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(mmc3_mpu_irqs),
 	.sdma_reqs	= mmc3_sdma_reqs,
-- 
1.7.0.4


