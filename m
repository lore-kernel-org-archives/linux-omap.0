From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 12/26] ARM: AM43xx: hwmod: use OMAP4 hardreset ops instead of the AM33xx version
Date: Mon, 1 Sep 2014 21:09:01 +0300
Message-ID: <1409594955-1476-13-git-send-email-t-kristo@ti.com>
References: <1409594955-1476-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34861 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754675AbaIASKD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Sep 2014 14:10:03 -0400
In-Reply-To: <1409594955-1476-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

AM43xx is using OMAP4+ PRM driver, so it should be using the corresponding
hardreset ops from the hwmod also.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 0267af5..c52dc4c 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -4115,9 +4115,9 @@ void __init omap_hwmod_init(void)
 		soc_ops.enable_module = _omap4_enable_module;
 		soc_ops.disable_module = _omap4_disable_module;
 		soc_ops.wait_target_ready = _omap4_wait_target_ready;
-		soc_ops.assert_hardreset = _am33xx_assert_hardreset;
-		soc_ops.deassert_hardreset = _am33xx_deassert_hardreset;
-		soc_ops.is_hardreset_asserted = _am33xx_is_hardreset_asserted;
+		soc_ops.assert_hardreset = _omap4_assert_hardreset;
+		soc_ops.deassert_hardreset = _omap4_deassert_hardreset;
+		soc_ops.is_hardreset_asserted = _omap4_is_hardreset_asserted;
 		soc_ops.init_clkdm = _init_clkdm;
 	} else if (soc_is_am33xx()) {
 		soc_ops.enable_module = _omap4_enable_module;
-- 
1.7.9.5

