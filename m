From: "Avinash.H.M" <avinashhm@ti.com>
Subject: [PATCH 1/2] omap4: hwmod: Reset i2c modules as a part of omap_hwmod init
Date: Wed, 22 Jun 2011 17:16:13 +0530
Message-ID: <1308743174-12265-1-git-send-email-avinashhm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42705 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754337Ab1FVLqd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Jun 2011 07:46:33 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: "Avinash.H.M" <avinashhm@ti.com>, Rajendra Nayak <rnayak@ti.com>, Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>

The i2c module should be reset as part of the hwmod setup for i2c modules.
This is happening for omap2 and omap3 i2c modules. But for omap4, the i2c is
not reset because of the HWMOD_INIT_NO_RESET reset flags. Remove these flags
to ensure i2c is reset as a part of setup.

Cc: Rajendra Nayak <rnayak@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
Signed-off-by: Avinash.H.M <avinashhm@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index e1c69ff..2eaf40a 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -2164,7 +2164,6 @@ static struct omap_hwmod_ocp_if *omap44xx_i2c1_slaves[] = {
 static struct omap_hwmod omap44xx_i2c1_hwmod = {
 	.name		= "i2c1",
 	.class		= &omap44xx_i2c_hwmod_class,
-	.flags		= HWMOD_INIT_NO_RESET,
 	.mpu_irqs	= omap44xx_i2c1_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_i2c1_irqs),
 	.sdma_reqs	= omap44xx_i2c1_sdma_reqs,
@@ -2217,7 +2216,6 @@ static struct omap_hwmod_ocp_if *omap44xx_i2c2_slaves[] = {
 static struct omap_hwmod omap44xx_i2c2_hwmod = {
 	.name		= "i2c2",
 	.class		= &omap44xx_i2c_hwmod_class,
-	.flags		= HWMOD_INIT_NO_RESET,
 	.mpu_irqs	= omap44xx_i2c2_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_i2c2_irqs),
 	.sdma_reqs	= omap44xx_i2c2_sdma_reqs,
@@ -2270,7 +2268,6 @@ static struct omap_hwmod_ocp_if *omap44xx_i2c3_slaves[] = {
 static struct omap_hwmod omap44xx_i2c3_hwmod = {
 	.name		= "i2c3",
 	.class		= &omap44xx_i2c_hwmod_class,
-	.flags		= HWMOD_INIT_NO_RESET,
 	.mpu_irqs	= omap44xx_i2c3_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_i2c3_irqs),
 	.sdma_reqs	= omap44xx_i2c3_sdma_reqs,
@@ -2323,7 +2320,6 @@ static struct omap_hwmod_ocp_if *omap44xx_i2c4_slaves[] = {
 static struct omap_hwmod omap44xx_i2c4_hwmod = {
 	.name		= "i2c4",
 	.class		= &omap44xx_i2c_hwmod_class,
-	.flags		= HWMOD_INIT_NO_RESET,
 	.mpu_irqs	= omap44xx_i2c4_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_i2c4_irqs),
 	.sdma_reqs	= omap44xx_i2c4_sdma_reqs,
-- 
1.7.1

