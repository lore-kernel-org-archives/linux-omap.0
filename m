From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 09/10] OMAP: hwmod: Rename hwmod name for the MPU
Date: Fri,  7 May 2010 17:44:14 +0200
Message-ID: <1273247055-15165-10-git-send-email-b-cousson@ti.com>
References: <1273247055-15165-1-git-send-email-b-cousson@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58171 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756706Ab0EGPod (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 7 May 2010 11:44:33 -0400
In-Reply-To: <1273247055-15165-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@ti.com>

In the lastest OMAP4 hwmod data file, the _hwmod was removed
in order to save some memory space and because it does not
bring a lot.

The same cleanup will be have to done for other hwmods in
OMAP2 & 3 data files.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c           |    2 +-
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |    2 +-
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |    2 +-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index b624ad6..b6031e4 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -58,7 +58,7 @@
 #define MAX_MODULE_RESET_WAIT		10000
 
 /* Name of the OMAP hwmod for the MPU */
-#define MPU_INITIATOR_NAME		"mpu_hwmod"
+#define MPU_INITIATOR_NAME		"mpu"
 
 /* omap_hwmod_list contains all registered struct omap_hwmods */
 static LIST_HEAD(omap_hwmod_list);
diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
index eb7ee24..e5530c5 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -125,7 +125,7 @@ static struct omap_hwmod_ocp_if *omap2420_mpu_masters[] = {
 
 /* MPU */
 static struct omap_hwmod omap2420_mpu_hwmod = {
-	.name		= "mpu_hwmod",
+	.name		= "mpu",
 	.class		= &mpu_hwmod_class,
 	.main_clk	= "mpu_ck",
 	.masters	= omap2420_mpu_masters,
diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index 241bd82..0852d95 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -127,7 +127,7 @@ static struct omap_hwmod_ocp_if *omap2430_mpu_masters[] = {
 
 /* MPU */
 static struct omap_hwmod omap2430_mpu_hwmod = {
-	.name		= "mpu_hwmod",
+	.name		= "mpu",
 	.class		= &mpu_hwmod_class,
 	.main_clk	= "mpu_ck",
 	.masters	= omap2430_mpu_masters,
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index ed60840..39b0c0e 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -156,7 +156,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_mpu_masters[] = {
 
 /* MPU */
 static struct omap_hwmod omap3xxx_mpu_hwmod = {
-	.name		= "mpu_hwmod",
+	.name		= "mpu",
 	.class		= &mpu_hwmod_class,
 	.main_clk	= "arm_fck",
 	.masters	= omap3xxx_mpu_masters,
-- 
1.6.1.3

