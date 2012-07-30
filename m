From: Juha Kuikka <juha.kuikka@gmail.com>
Subject: [PATCH v1 1/1] ARM: OMAP3: Use OMAP3_HAS_IVA_REGS with OMAP3503
Date: Mon, 30 Jul 2012 16:50:39 -0700
Message-ID: <1343692239-10393-2-git-send-email-juha.kuikka@gmail.com>
References: <1343692239-10393-1-git-send-email-juha.kuikka@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:39365 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751373Ab2G3Xva (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Jul 2012 19:51:30 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so10640046pbb.19
        for <linux-omap@vger.kernel.org>; Mon, 30 Jul 2012 16:51:30 -0700 (PDT)
In-Reply-To: <1343692239-10393-1-git-send-email-juha.kuikka@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Juha Kuikka <juha.kuikka@gmail.com>

Similarly to am3703, it seems that omap3503 has an IVA control
registers even though the subsystem is non-functional.

This patch sets the OMAP3_HAS_IVA_REGS feature to force
initialization of there registers.

Based in Mark A. Greer's patch
"ARM: OMAP3: Add OMAP3_HAS_IVA_REGS feature".

Signed-off-by: Juha Kuikka <juha.kuikka@gmail.com>
---
 arch/arm/mach-omap2/id.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 4072fbd..45d3eb4 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -244,7 +244,7 @@ void __init omap3xxx_check_features(void)
 	if (cpu_is_omap3630())
 		omap_features |= OMAP3_HAS_192MHZ_CLK | OMAP3_HAS_IVA_REGS;
 	if (cpu_is_omap3430() || cpu_is_omap3630())
-		omap_features |= OMAP3_HAS_IO_WAKEUP;
+		omap_features |= OMAP3_HAS_IO_WAKEUP | OMAP3_HAS_IVA_REGS;
 	if (cpu_is_omap3630() || omap_rev() == OMAP3430_REV_ES3_1 ||
 	    omap_rev() == OMAP3430_REV_ES3_1_2)
 		omap_features |= OMAP3_HAS_IO_CHAIN_CTRL;
-- 
1.7.5.4

