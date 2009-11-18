From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 1/8] OMAP3: clock: add clockdomains for UART1 & 2
Date: Tue, 17 Nov 2009 17:05:06 -0800
Message-ID: <1258506313-17115-2-git-send-email-khilman@deeprootsystems.com>
References: <1258506313-17115-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f187.google.com ([209.85.210.187]:61295 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756443AbZKRBFN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Nov 2009 20:05:13 -0500
Received: by mail-yx0-f187.google.com with SMTP id 17so614173yxe.33
        for <linux-omap@vger.kernel.org>; Tue, 17 Nov 2009 17:05:19 -0800 (PST)
In-Reply-To: <1258506313-17115-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

UART1 & 2 were missing clockdomains resulting in broken omap_hwmod
init for these devices.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/clock34xx.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
index a1b3de7..cbc3d8a 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -1507,6 +1507,7 @@ static struct clk uart2_fck = {
 	.parent		= &core_48m_fck,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430_EN_UART2_SHIFT,
+	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -1516,6 +1517,7 @@ static struct clk uart1_fck = {
 	.parent		= &core_48m_fck,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430_EN_UART1_SHIFT,
+	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
-- 
1.6.5.1

