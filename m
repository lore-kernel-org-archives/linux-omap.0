From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 4/7] omap4: Panda: Add DEBUG_LL support
Date: Thu,  9 Sep 2010 16:53:12 +0530
Message-ID: <1284031395-25988-5-git-send-email-santosh.shilimkar@ti.com>
References: <1284031395-25988-1-git-send-email-santosh.shilimkar@ti.com>
 <1284031395-25988-2-git-send-email-santosh.shilimkar@ti.com>
 <1284031395-25988-3-git-send-email-santosh.shilimkar@ti.com>
 <1284031395-25988-4-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53100 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752906Ab0IILX0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 9 Sep 2010 07:23:26 -0400
In-Reply-To: <1284031395-25988-4-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, khilman@deeprootsystems.com, David Anders <x0132446@ti.com>

From: David Anders <x0132446@ti.com>

Add support for use of DEBUG_LL for use with PandaBoard.

Signed-off-by: David Anders <x0132446@ti.com>
---
 arch/arm/plat-omap/include/plat/uncompress.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/uncompress.h b/arch/arm/plat-omap/include/plat/uncompress.h
index ddf723b..57dffa7 100644
--- a/arch/arm/plat-omap/include/plat/uncompress.h
+++ b/arch/arm/plat-omap/include/plat/uncompress.h
@@ -153,6 +153,7 @@ static inline void __arch_decomp_setup(unsigned long arch_id)
 
 		/* omap4 based boards using UART3 */
 		DEBUG_LL_OMAP4(3, omap_4430sdp);
+		DEBUG_LL_OMAP4(3, omap4_panda);
 
 		/* zoom2/3 external uart */
 		DEBUG_LL_ZOOM(omap_zoom2);
-- 
1.6.0.4

