From: Sanjeev Premi <premi@ti.com>
Subject: [PATCH] Fix compiler warnings in smartreflex.c
Date: Fri, 10 Oct 2008 18:07:17 +0530
Message-ID: <1223642237-9345-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44133 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755776AbYJJMh0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 10 Oct 2008 08:37:26 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id m9ACbJDP012425
	for <linux-omap@vger.kernel.org>; Fri, 10 Oct 2008 07:37:25 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sanjeev Premi <premi@ti.com>

Fix these compiler warnings:
smartreflex.c:126: warning: initialization makes integer from pointer without a cast
smartreflex.c:134: warning: initialization makes integer from pointer without a cast

Signed-off-by: Sanjeev Premi <premi@ti.com>
---
 arch/arm/mach-omap2/smartreflex.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index e54c0fb..8460633 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -123,7 +123,7 @@ static struct omap_sr sr1 = {
 	.is_sr_reset		= 1,
 	.is_autocomp_active	= 0,
 	.clk_length		= 0,
-	.srbase_addr		= OMAP2_IO_ADDRESS(OMAP34XX_SR1_BASE),
+	.srbase_addr		= (u32)OMAP2_IO_ADDRESS(OMAP34XX_SR1_BASE),
 };
 
 static struct omap_sr sr2 = {
@@ -131,7 +131,7 @@ static struct omap_sr sr2 = {
 	.is_sr_reset		= 1,
 	.is_autocomp_active	= 0,
 	.clk_length		= 0,
-	.srbase_addr		= OMAP2_IO_ADDRESS(OMAP34XX_SR2_BASE),
+	.srbase_addr		= (u32)OMAP2_IO_ADDRESS(OMAP34XX_SR2_BASE),
 };
 
 static struct sr_custom_clk sr1_custom_clk = {
-- 
1.5.6

