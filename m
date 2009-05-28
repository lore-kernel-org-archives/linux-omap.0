From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 06/06] OMAP3: PM: Update VDD1 OPP2 voltage level from 1.05 to 1.075
Date: Thu, 28 May 2009 18:13:07 +0530
Message-ID: <1243514587-5323-6-git-send-email-rnayak@ti.com>
References: <1243514587-5323-1-git-send-email-rnayak@ti.com>
 <1243514587-5323-2-git-send-email-rnayak@ti.com>
 <1243514587-5323-3-git-send-email-rnayak@ti.com>
 <1243514587-5323-4-git-send-email-rnayak@ti.com>
 <1243514587-5323-5-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41543 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757880AbZE1MnO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 May 2009 08:43:14 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n4SCh9JM004741
	for <linux-omap@vger.kernel.org>; Thu, 28 May 2009 07:43:15 -0500
In-Reply-To: <1243514587-5323-5-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Rajendra Nayak <rnayak@ti.com>

This patch updates the VDD1 OPP2 volatge according to the latest
Operating Condition Addendum from 1.05v to 1.075v

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/omap3-opp.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap3-opp.h b/arch/arm/mach-omap2/omap3-opp.h
index 4bb165e..3c9a582 100644
--- a/arch/arm/mach-omap2/omap3-opp.h
+++ b/arch/arm/mach-omap2/omap3-opp.h
@@ -26,7 +26,7 @@ static struct omap_opp omap3_mpu_rate_table[] = {
 	/*OPP1*/
 	{S125M, VDD1_OPP1, 0x1E},
 	/*OPP2*/
-	{S250M, VDD1_OPP2, 0x24},
+	{S250M, VDD1_OPP2, 0x26},
 	/*OPP3*/
 	{S500M, VDD1_OPP3, 0x30},
 	/*OPP4*/
@@ -50,7 +50,7 @@ static struct omap_opp omap3_dsp_rate_table[] = {
 	/*OPP1*/
 	{S90M, VDD1_OPP1, 0x1E},
 	/*OPP2*/
-	{S180M, VDD1_OPP2, 0x24},
+	{S180M, VDD1_OPP2, 0x26},
 	/*OPP3*/
 	{S360M, VDD1_OPP3, 0x30},
 	/*OPP4*/
-- 
1.5.4.7

