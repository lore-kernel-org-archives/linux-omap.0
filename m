From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 1/2] OMAP2/3: HS-MMC: correct hwmod offsets for SYSCONFIG/SYSSTATUS
Date: Tue,  7 Jul 2009 17:17:36 -0700
Message-ID: <1247012257-19407-2-git-send-email-khilman@deeprootsystems.com>
References: <1247012257-19407-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f193.google.com ([209.85.222.193]:45729 "EHLO
	mail-pz0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757930AbZGHARn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Jul 2009 20:17:43 -0400
Received: by pzk31 with SMTP id 31so3280922pzk.33
        for <linux-omap@vger.kernel.org>; Tue, 07 Jul 2009 17:17:42 -0700 (PDT)
In-Reply-To: <1247012257-19407-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: linux-omap@vger.kernel.org

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/omap_hwmod_2430.h |    4 ++--
 arch/arm/mach-omap2/omap_hwmod_34xx.h |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2430.h b/arch/arm/mach-omap2/omap_hwmod_2430.h
index 0ae23f3..48077c7 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430.h
+++ b/arch/arm/mach-omap2/omap_hwmod_2430.h
@@ -170,8 +170,8 @@ static struct omap_hwmod omap2430_mpu_hwmod = {
 /* MMC/SD/SDIO common */
 
 static struct omap_hwmod_sysconfig mmc_if_ctrl = {
-	.rev_offs	= 0x10,
-	.sysc_offs	= 0x14,
+	.sysc_offs	= 0x10,
+	.syss_offs	= 0x14,
 	.sysc_flags	= (SYSC_HAS_CLOCKACTIVITY | SYSC_HAS_SIDLEMODE |
 			   SYSC_HAS_ENAWAKEUP | SYSC_HAS_SOFTRESET |
 			   SYSC_HAS_AUTOIDLE | SYSS_MISSING),
diff --git a/arch/arm/mach-omap2/omap_hwmod_34xx.h b/arch/arm/mach-omap2/omap_hwmod_34xx.h
index afc3cd4..34319c3 100644
--- a/arch/arm/mach-omap2/omap_hwmod_34xx.h
+++ b/arch/arm/mach-omap2/omap_hwmod_34xx.h
@@ -236,8 +236,8 @@ static struct omap_hwmod omap34xx_mpu_hwmod = {
 /* MMC/SD/SDIO common */
 
 static struct omap_hwmod_sysconfig mmc_if_ctrl = {
-	.rev_offs	= 0x10,
-	.sysc_offs	= 0x14,
+	.sysc_offs	= 0x10,
+	.syss_offs      = 0x14,
 	.sysc_flags	= (SYSC_HAS_CLOCKACTIVITY | SYSC_HAS_SIDLEMODE |
 			   SYSC_HAS_ENAWAKEUP | SYSC_HAS_SOFTRESET |
 			   SYSC_HAS_AUTOIDLE),
-- 
1.6.3.3

