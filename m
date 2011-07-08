From: Jan Weitzel <j.weitzel@phytec.de>
Subject: [PATCH 2/3] ARM: OMAP4: add pcm049 DEBUGLL
Date: Fri, 8 Jul 2011 12:04:23 +0200
Message-ID: <1310119464-3514-3-git-send-email-j.weitzel@phytec.de>
References: <1310119464-3514-1-git-send-email-j.weitzel@phytec.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.x-arc.co.uk ([217.6.246.34]:42552 "EHLO root.phytec.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753037Ab1GHKEf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 Jul 2011 06:04:35 -0400
In-Reply-To: <1310119464-3514-1-git-send-email-j.weitzel@phytec.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: tony@atomide.com, Jan Weitzel <j.weitzel@phytec.de>


Signed-off-by: Jan Weitzel <j.weitzel@phytec.de>
---
 arch/arm/plat-omap/include/plat/uncompress.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/uncompress.h b/arch/arm/plat-omap/include/plat/uncompress.h
index ac4b60d..10507a6 100644
--- a/arch/arm/plat-omap/include/plat/uncompress.h
+++ b/arch/arm/plat-omap/include/plat/uncompress.h
@@ -164,6 +164,7 @@ static inline void __arch_decomp_setup(unsigned long arch_id)
 		/* omap4 based boards using UART3 */
 		DEBUG_LL_OMAP4(3, omap_4430sdp);
 		DEBUG_LL_OMAP4(3, omap4_panda);
+		DEBUG_LL_OMAP4(3, pcm049);
 
 		/* zoom2/3 external uart */
 		DEBUG_LL_ZOOM(omap_zoom2);
-- 
1.7.0.4

