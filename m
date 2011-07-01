From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [RFC 02/12] omap: mcbsp: Remove rx_/tx_word_length variables
Date: Fri,  1 Jul 2011 11:52:26 +0300
Message-ID: <1309510356-27147-3-git-send-email-jhnikula@gmail.com>
References: <1309510356-27147-1-git-send-email-jhnikula@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:58452 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755646Ab1GAIw6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Jul 2011 04:52:58 -0400
Received: by mail-bw0-f46.google.com with SMTP id 5so2453487bwd.19
        for <linux-omap@vger.kernel.org>; Fri, 01 Jul 2011 01:52:57 -0700 (PDT)
In-Reply-To: <1309510356-27147-1-git-send-email-jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jhnikula@gmail.com>

These variables got unused after ("omap: mcbsp: Drop in-driver transfer
support") but was noticed only afterwards.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
 arch/arm/plat-omap/include/plat/mcbsp.h |    2 --
 arch/arm/plat-omap/mcbsp.c              |    3 ---
 2 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/mcbsp.h b/arch/arm/plat-omap/include/plat/mcbsp.h
index 6c53508..63464ad 100644
--- a/arch/arm/plat-omap/include/plat/mcbsp.h
+++ b/arch/arm/plat-omap/include/plat/mcbsp.h
@@ -385,8 +385,6 @@ struct omap_mcbsp {
 	void __iomem *io_base;
 	u8 id;
 	u8 free;
-	omap_mcbsp_word_length rx_word_length;
-	omap_mcbsp_word_length tx_word_length;
 
 	int rx_irq;
 	int tx_irq;
diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index 2a3587e..6c62af1 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -869,9 +869,6 @@ void omap_mcbsp_start(unsigned int id, int tx, int rx)
 	if (cpu_is_omap34xx())
 		omap_st_start(mcbsp);
 
-	mcbsp->rx_word_length = (MCBSP_READ_CACHE(mcbsp, RCR1) >> 5) & 0x7;
-	mcbsp->tx_word_length = (MCBSP_READ_CACHE(mcbsp, XCR1) >> 5) & 0x7;
-
 	/* Only enable SRG, if McBSP is master */
 	w = MCBSP_READ_CACHE(mcbsp, PCR0);
 	if (w & (FSXM | FSRM | CLKXM | CLKRM))
-- 
1.7.0.4

