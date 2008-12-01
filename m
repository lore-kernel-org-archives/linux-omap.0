From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH v2 4/5] OMAP3: PM: D2D clockdomain supports SW supervised transitions
Date: Mon,  1 Dec 2008 08:22:45 -0800
Message-ID: <1228148566-9358-5-git-send-email-khilman@deeprootsystems.com>
References: <1228148566-9358-1-git-send-email-khilman@deeprootsystems.com>
 <1228148566-9358-2-git-send-email-khilman@deeprootsystems.com>
 <1228148566-9358-3-git-send-email-khilman@deeprootsystems.com>
 <1228148566-9358-4-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.227]:21102 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751139AbYLAQW6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Dec 2008 11:22:58 -0500
Received: by rv-out-0506.google.com with SMTP id k40so2527683rvb.1
        for <linux-omap@vger.kernel.org>; Mon, 01 Dec 2008 08:22:57 -0800 (PST)
In-Reply-To: <1228148566-9358-4-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>

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

