From: felipe.balbi@nokia.com
Subject: [PATCH 1/2] Manual revert of "omap: Fix compile for early_param and omap_smc1"
Date: Thu,  4 Mar 2010 09:57:16 +0200
Message-ID: <1267689436-20340-1-git-send-email-felipe.balbi@nokia.com>
References: <20100304075022.GJ15954@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:18556 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753651Ab0CDH5v (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Mar 2010 02:57:51 -0500
In-Reply-To: <20100304075022.GJ15954@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>

From: Felipe Balbi <felipe.balbi@nokia.com>

This reverts the early_param part of commit
a91741262f0ae82d651c7270bc1354016c5bb9dd.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 arch/arm/mach-omap2/board-omap3touchbook.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3touchbook.c b/arch/arm/mach-omap2/board-omap3touchbook.c
index 07b7a32..2a5bf5c 100644
--- a/arch/arm/mach-omap2/board-omap3touchbook.c
+++ b/arch/arm/mach-omap2/board-omap3touchbook.c
@@ -493,7 +493,7 @@ static void __init omap3touchbook_flash_init(void)
 	}
 }
 
-static struct ehci_hcd_omap_platform_data ehci_pdata __initdata = {
+static struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
 
 	.port_mode[0] = EHCI_HCD_OMAP_MODE_PHY,
 	.port_mode[1] = EHCI_HCD_OMAP_MODE_PHY,
-- 
1.7.0.rc0.33.g7c3932

