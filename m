From: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
Subject: [PATCH] ARM: OMAP3: Fix OMAP_CHIP_INIT usage
Date: Thu, 23 Apr 2009 12:43:07 +0300
Message-ID: <1240479787-16921-2-git-send-email-kalle.jokiniemi@digia.com>
References: <>
 <1240479787-16921-1-git-send-email-kalle.jokiniemi@digia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1.digia.com ([82.118.214.156]:23796 "EHLO smtp1.digia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753753AbZDWJnJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Apr 2009 05:43:09 -0400
In-Reply-To: <1240479787-16921-1-git-send-email-kalle.jokiniemi@digia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org, Kalle Jokiniemi <kalle.jokiniemi@digia.com>

Some modules have been specified only to exist in ES2.0
devices while they should exist on >= ES2.0 devices.
Fixed OMAP_CHIP_INIT() calls to take this to account.

Signed-off-by: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
---
 arch/arm/mach-omap2/omapdev3xxx.h  |    8 ++++----
 arch/arm/mach-omap2/resource34xx.h |    4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/omapdev3xxx.h b/arch/arm/mach-omap2/omapdev3xxx.h
index dce87df..d2772c4 100644
--- a/arch/arm/mach-omap2/omapdev3xxx.h
+++ b/arch/arm/mach-omap2/omapdev3xxx.h
@@ -374,7 +374,7 @@ static struct omapdev neon_3xxx_omapdev = {
 static struct omapdev sgx_3xxx_omapdev = {
 	.name		= "sgx_omapdev",
 	.pwrdm		= { .name = "sgx_pwrdm" },
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES2),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_GE_OMAP3430ES2),
 };
 
 /* CORE */
@@ -435,7 +435,7 @@ static struct omapdev hsmmc3_3xxx_omapdev = {
 	.pwrdm		= { .name = "core_pwrdm" },
 	.pdev_name	= "mmci-omap",
 	.pdev_id	= 2,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES2),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_GE_OMAP3430ES2),
 };
 
 static struct omapdev mcspi4_3xxx_omapdev = {
@@ -658,7 +658,7 @@ static struct omapdev usbhost_3xxx_omapdev = {
 	.pwrdm		= { .name = "usbhost_pwrdm" },
 	.pdev_name	= "ehci-omap",
 	.pdev_id	= 0,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES2),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_GE_OMAP3430ES2),
 };
 
 static struct omapdev usbotg_3xxx_omapdev = {
@@ -666,7 +666,7 @@ static struct omapdev usbotg_3xxx_omapdev = {
 	.pwrdm		= { .name = "usbhost_pwrdm" },
 	.pdev_name	= "musb_hdrc",
 	.pdev_id	= -1,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES2),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_GE_OMAP3430ES2),
 };
 
 static struct omapdev usbtll_3xxx_omapdev = {
diff --git a/arch/arm/mach-omap2/resource34xx.h b/arch/arm/mach-omap2/resource34xx.h
index b847208..8d95a00 100644
--- a/arch/arm/mach-omap2/resource34xx.h
+++ b/arch/arm/mach-omap2/resource34xx.h
@@ -133,7 +133,7 @@ static struct shared_resource gfx_pwrdm_latency = {
 
 static struct shared_resource sgx_pwrdm_latency = {
 	.name 		= "sgx_pwrdm_latency",
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES2),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_GE_OMAP3430ES2),
 	.resource_data  = &sgx_pwrdm_lat_db,
 	.ops		= &pd_lat_res_ops,
 };
@@ -208,7 +208,7 @@ static struct pd_latency_db usbhost_pwrdm_lat_db = {
 
 static struct shared_resource usbhost_pwrdm_latency = {
 	.name		= "usbhost_pwrdm_latency",
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES2),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_GE_OMAP3430ES2),
 	.resource_data  = &usbhost_pwrdm_lat_db,
 	.ops		= &pd_lat_res_ops,
 };
-- 
1.5.4.3

