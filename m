From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 4/5] OMAP3: PM: D2D clockdomain supports SW supervised transitions
Date: Wed, 26 Nov 2008 16:05:48 -0800
Message-ID: <1227744349-12118-5-git-send-email-khilman@deeprootsystems.com>
References: <1227744349-12118-1-git-send-email-khilman@deeprootsystems.com>
 <1227744349-12118-2-git-send-email-khilman@deeprootsystems.com>
 <1227744349-12118-3-git-send-email-khilman@deeprootsystems.com>
 <1227744349-12118-4-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rn-out-0910.google.com ([64.233.170.184]:16375 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754570AbYK0AGI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Nov 2008 19:06:08 -0500
Received: by rn-out-0910.google.com with SMTP id k40so712652rnd.17
        for <linux-omap@vger.kernel.org>; Wed, 26 Nov 2008 16:06:07 -0800 (PST)
In-Reply-To: <1227744349-12118-4-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/clockdomains.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomains.h b/arch/arm/mach-omap2/clockdomains.h
index bafa650..49a5774 100644
--- a/arch/arm/mach-omap2/clockdomains.h
+++ b/arch/arm/mach-omap2/clockdomains.h
@@ -198,7 +198,7 @@ static struct clockdomain sgx_clkdm = {
 static struct clockdomain d2d_clkdm = {
 	.name		= "d2d_clkdm",
 	.pwrdm		= { .name = "core_pwrdm" },
-	.flags		= CLKDM_CAN_HWSUP,
+	.flags		= CLKDM_CAN_HWSUP_SWSUP,
 	.clktrctrl_mask = OMAP3430ES1_CLKTRCTRL_D2D_MASK,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
-- 
1.6.0.3

