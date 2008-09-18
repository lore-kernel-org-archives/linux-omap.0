From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH PM-0] ARM: OMAP3: HSMMC: Ensure HSMMC is fully reset on boot
Date: Thu, 18 Sep 2008 15:22:32 +0300
Message-ID: <1221740552-27110-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.186]:6750 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752800AbYIRMWi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Sep 2008 08:22:38 -0400
Received: by nf-out-0910.google.com with SMTP id d3so1998583nfc.21
        for <linux-omap@vger.kernel.org>; Thu, 18 Sep 2008 05:22:37 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>

This ensures that an unused HSMMC block will not interfere with sleep.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/hsmmc.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index 7334d86..03fe820 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -280,8 +280,16 @@ static struct omap_mmc_platform_data hsmmc_data = {
 	},
 };
 
+static void __init hsmmc_reset(void)
+{
+       omap_writel(MMCHS_SYSCONFIG_SWRESET, MMCHS1_SYSCONFIG);
+       omap_writel(MMCHS_SYSCONFIG_SWRESET, MMCHS2_SYSCONFIG);
+       omap_writel(MMCHS_SYSCONFIG_SWRESET, MMCHS3_SYSCONFIG);
+}
+
 void __init hsmmc_init(void)
 {
+	hsmmc_reset();
 	omap2_init_mmc(&hsmmc_data);
 }
 
-- 
1.5.4.3

