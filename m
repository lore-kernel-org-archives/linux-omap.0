From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH v2 19/32] OMAP3: PM: Fix PLL_MOD CLKEN offset in scratchpad
Date: Thu, 22 Oct 2009 16:09:40 -0700
Message-ID: <1256252993-24328-20-git-send-email-khilman@deeprootsystems.com>
References: <1256252993-24328-1-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-2-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-3-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-4-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-5-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-6-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-7-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-8-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-9-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-10-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-11-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-12-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-13-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-14-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-15-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-16-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-17-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-18-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-19-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f194.google.com ([209.85.221.194]:37878 "EHLO
	mail-qy0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755526AbZJVXLC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Oct 2009 19:11:02 -0400
Received: by mail-qy0-f194.google.com with SMTP id 32so5544712qyk.4
        for <linux-omap@vger.kernel.org>; Thu, 22 Oct 2009 16:11:07 -0700 (PDT)
In-Reply-To: <1256252993-24328-19-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Kalle Jokiniemi <kalle.jokiniemi@digia.com>

From: Kalle Jokiniemi <kalle.jokiniemi@digia.com>

The CM_CLKEN_PLL register saved in scratchpad memory
was wrongly using offset of 0x0004 instead of 0x0000.

The effect of this was that boot ROM code would
restore the wrong value when waking up from off mode.
This wrong value, however, will be overwritten by
prcm context restore. Still, a short period of wrong
clock settings in CM_CLKEN_PLL remained between ROM
code and prcm context restore. This is fixed by the
patch.

Problem reported by: Jouni Hogander <jouni.hogander@nokia.com>

Signed-off-by: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/control.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index b84cff7..c41565e 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -230,7 +230,7 @@ void omap3_save_scratchpad_contents(void)
 	prcm_block_contents.cm_clksel_wkup =
 			cm_read_mod_reg(WKUP_MOD, CM_CLKSEL);
 	prcm_block_contents.cm_clken_pll =
-			cm_read_mod_reg(PLL_MOD, OMAP3430_CM_CLKEN_PLL);
+			cm_read_mod_reg(PLL_MOD, CM_CLKEN);
 	prcm_block_contents.cm_autoidle_pll =
 			cm_read_mod_reg(PLL_MOD, OMAP3430_CM_AUTOIDLE_PLL);
 	prcm_block_contents.cm_clksel1_pll =
-- 
1.6.4.3

