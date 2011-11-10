From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] ARM: OMAP: Fix dpll_data compile error when omap2 only is
 selected
Date: Thu, 10 Nov 2011 12:05:58 -0800
Message-ID: <20111110200558.GV31337@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:56186 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751491Ab1KJUGB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Nov 2011 15:06:01 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Paul Walmsley <paul@pwsan.com>

Without this patch we get the following error:

arch/arm/mach-omap2/clkt_dpll.c: In function '_dpll_test_fint':
arch/arm/mach-omap2/clkt_dpll.c:98: error: 'struct dpll_data' has no member named 'flags'

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/plat-omap/include/plat/clock.h b/arch/arm/plat-omap/include/plat/clock.h
index 197ca03..eb73ab4 100644
--- a/arch/arm/plat-omap/include/plat/clock.h
+++ b/arch/arm/plat-omap/include/plat/clock.h
@@ -165,8 +165,8 @@ struct dpll_data {
 	u8			auto_recal_bit;
 	u8			recal_en_bit;
 	u8			recal_st_bit;
-	u8			flags;
 #  endif
+	u8			flags;
 };
 
 #endif
