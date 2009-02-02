From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: [PATCH 1/1] Do a warm reboot instead of a cold boot
Date: Mon,  2 Feb 2009 19:10:24 +0200
Message-ID: <1233594624-21615-2-git-send-email-peter.de-schrijver@nokia.com>
References: <1233594624-21615-1-git-send-email-peter.de-schrijver@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:23988 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752730AbZBBRKd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Feb 2009 12:10:33 -0500
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n12HAPUq025325
	for <linux-omap@vger.kernel.org>; Mon, 2 Feb 2009 19:10:31 +0200
In-Reply-To: <1233594624-21615-1-git-send-email-peter.de-schrijver@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>

This patch makes omap_prcm_arch_reset do a warm reboot instead of a cold boot

Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
---
 arch/arm/mach-omap2/prcm.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
index c64b668..b405e01 100644
--- a/arch/arm/mach-omap2/prcm.c
+++ b/arch/arm/mach-omap2/prcm.c
@@ -135,7 +135,7 @@ void omap_prcm_arch_reset(char mode)
 	else
 		WARN_ON(1);
 
-	prm_set_mod_reg_bits(OMAP_RST_DPLL3, prcm_offs, RM_RSTCTRL);
+	prm_set_mod_reg_bits(OMAP_RST_GS, prcm_offs, RM_RSTCTRL);
 }
 
 static inline u32 __omap_prcm_read(void __iomem *base, s16 module, u16 reg)
-- 
1.5.6.3

