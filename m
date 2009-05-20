From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 09/13] OMAP3: PM: D2D clockdomain supports SW supervised transitions
Date: Wed, 20 May 2009 16:19:32 -0700
Message-ID: <1242861576-13008-10-git-send-email-khilman@deeprootsystems.com>
References: <1242861576-13008-1-git-send-email-khilman@deeprootsystems.com>
 <1242861576-13008-2-git-send-email-khilman@deeprootsystems.com>
 <1242861576-13008-3-git-send-email-khilman@deeprootsystems.com>
 <1242861576-13008-4-git-send-email-khilman@deeprootsystems.com>
 <1242861576-13008-5-git-send-email-khilman@deeprootsystems.com>
 <1242861576-13008-6-git-send-email-khilman@deeprootsystems.com>
 <1242861576-13008-7-git-send-email-khilman@deeprootsystems.com>
 <1242861576-13008-8-git-send-email-khilman@deeprootsystems.com>
 <1242861576-13008-9-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.173]:37575 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757446AbZETXUB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 May 2009 19:20:01 -0400
Received: by wf-out-1314.google.com with SMTP id 26so241368wfd.4
        for <linux-omap@vger.kernel.org>; Wed, 20 May 2009 16:20:03 -0700 (PDT)
In-Reply-To: <1242861576-13008-9-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/clockdomains.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomains.h b/arch/arm/mach-omap2/clockdomains.h
index 281d5da..fe319ae 100644
--- a/arch/arm/mach-omap2/clockdomains.h
+++ b/arch/arm/mach-omap2/clockdomains.h
@@ -195,7 +195,7 @@ static struct clockdomain sgx_clkdm = {
 static struct clockdomain d2d_clkdm = {
 	.name		= "d2d_clkdm",
 	.pwrdm		= { .name = "core_pwrdm" },
-	.flags		= CLKDM_CAN_HWSUP,
+	.flags		= CLKDM_CAN_HWSUP_SWSUP,
 	.clktrctrl_mask = OMAP3430ES1_CLKTRCTRL_D2D_MASK,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
-- 
1.6.2.2

