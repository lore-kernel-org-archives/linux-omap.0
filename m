From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 07/11] OMAP3: PM: D2D clockdomain supports SW supervised transitions
Date: Fri, 15 May 2009 11:40:47 -0700
Message-ID: <1242412851-16606-8-git-send-email-khilman@deeprootsystems.com>
References: <1242412851-16606-1-git-send-email-khilman@deeprootsystems.com>
 <1242412851-16606-2-git-send-email-khilman@deeprootsystems.com>
 <1242412851-16606-3-git-send-email-khilman@deeprootsystems.com>
 <1242412851-16606-4-git-send-email-khilman@deeprootsystems.com>
 <1242412851-16606-5-git-send-email-khilman@deeprootsystems.com>
 <1242412851-16606-6-git-send-email-khilman@deeprootsystems.com>
 <1242412851-16606-7-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f123.google.com ([209.85.216.123]:57189 "EHLO
	mail-px0-f123.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753692AbZEOSlW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 May 2009 14:41:22 -0400
Received: by mail-px0-f123.google.com with SMTP id 29so1179213pxi.33
        for <linux-omap@vger.kernel.org>; Fri, 15 May 2009 11:41:23 -0700 (PDT)
In-Reply-To: <1242412851-16606-7-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>

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

