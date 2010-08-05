From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH v3 7/7] OMAP: hwmod: Temporary prevent reset during _setup for I2Cs
Date: Thu,  5 Aug 2010 17:47:56 +0200
Message-ID: <1281023276-15679-8-git-send-email-b-cousson@ti.com>
References: <1281023276-15679-1-git-send-email-b-cousson@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35486 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933438Ab0HEPsU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 5 Aug 2010 11:48:20 -0400
In-Reply-To: <1281023276-15679-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@deeprootsystems.com, paul@pwsan.com
Cc: rnayak@ti.com, santosh.shilimkar@ti.com, Benoit Cousson <b-cousson@ti.com>

For some reason, I2C 1, 2, 3 and 4 does not return the resetdone
status after a softreset.
Prevent the softreset until the root cause is found.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 5d440d5..9736a49 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -2268,6 +2268,7 @@ static struct omap_hwmod_ocp_if *omap44xx_i2c1_slaves[] = {
 static struct omap_hwmod omap44xx_i2c1_hwmod = {
 	.name		= "i2c1",
 	.class		= &omap44xx_i2c_hwmod_class,
+	.flags		= HWMOD_INIT_NO_RESET,
 	.mpu_irqs	= omap44xx_i2c1_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_i2c1_irqs),
 	.sdma_reqs	= omap44xx_i2c1_sdma_reqs,
@@ -2320,6 +2321,7 @@ static struct omap_hwmod_ocp_if *omap44xx_i2c2_slaves[] = {
 static struct omap_hwmod omap44xx_i2c2_hwmod = {
 	.name		= "i2c2",
 	.class		= &omap44xx_i2c_hwmod_class,
+	.flags		= HWMOD_INIT_NO_RESET,
 	.mpu_irqs	= omap44xx_i2c2_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_i2c2_irqs),
 	.sdma_reqs	= omap44xx_i2c2_sdma_reqs,
@@ -2372,6 +2374,7 @@ static struct omap_hwmod_ocp_if *omap44xx_i2c3_slaves[] = {
 static struct omap_hwmod omap44xx_i2c3_hwmod = {
 	.name		= "i2c3",
 	.class		= &omap44xx_i2c_hwmod_class,
+	.flags		= HWMOD_INIT_NO_RESET,
 	.mpu_irqs	= omap44xx_i2c3_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_i2c3_irqs),
 	.sdma_reqs	= omap44xx_i2c3_sdma_reqs,
@@ -2424,6 +2427,7 @@ static struct omap_hwmod_ocp_if *omap44xx_i2c4_slaves[] = {
 static struct omap_hwmod omap44xx_i2c4_hwmod = {
 	.name		= "i2c4",
 	.class		= &omap44xx_i2c_hwmod_class,
+	.flags		= HWMOD_INIT_NO_RESET,
 	.mpu_irqs	= omap44xx_i2c4_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_i2c4_irqs),
 	.sdma_reqs	= omap44xx_i2c4_sdma_reqs,
-- 
1.6.1.3

