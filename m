From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH] ARM: OMAP2420: Cosmetic fix for timer clock aliases
Date: Thu, 13 Sep 2012 18:46:33 -0500
Message-ID: <1347579993-4529-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50630 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751026Ab2IMXqk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Sep 2012 19:46:40 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Jon Hunter <jon-hunter@ti.com>

In commit c59b537 (ARM: OMAP2+: Simplify dmtimer clock aliases) new clock
aliases were added for OMAP2+ devices. For OMAP2420, I incorrectly set the
clock flag as CK_243X instead of CK_242X. This did not introduce a regression
as the clock flags are not checked for OMAP2 devices. This also explains why
I did not catch this when testing on OMAP2420.

Fix the clock flags for these aliases for correctness.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/clock2420_data.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/clock2420_data.c b/arch/arm/mach-omap2/clock2420_data.c
index 0027451..ebf3dfb 100644
--- a/arch/arm/mach-omap2/clock2420_data.c
+++ b/arch/arm/mach-omap2/clock2420_data.c
@@ -1897,9 +1897,9 @@ static struct omap_clk omap2420_clks[] = {
 	CLK(NULL,	"pka_ick",	&pka_ick,	CK_242X),
 	CLK(NULL,	"usb_fck",	&usb_fck,	CK_242X),
 	CLK("musb-hdrc",	"fck",	&osc_ck,	CK_242X),
-	CLK(NULL,	"timer_32k_ck",	&func_32k_ck,	CK_243X),
-	CLK(NULL,	"timer_sys_ck",	&sys_ck,	CK_243X),
-	CLK(NULL,	"timer_ext_ck",	&alt_ck,	CK_243X),
+	CLK(NULL,	"timer_32k_ck",	&func_32k_ck,	CK_242X),
+	CLK(NULL,	"timer_sys_ck",	&sys_ck,	CK_242X),
+	CLK(NULL,	"timer_ext_ck",	&alt_ck,	CK_242X),
 };
 
 /*
-- 
1.7.9.5

