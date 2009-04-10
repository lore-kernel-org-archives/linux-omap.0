From: Arun KS <arunks@mistralsolutions.com>
Subject: [PATCH] Typo fix for clock in omap1
Date: Fri, 10 Apr 2009 19:39:54 +0530
Message-ID: <1239372594-28383-1-git-send-email-arunks@mistralsolutions.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.182]:31653 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S938604AbZDJOKB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Apr 2009 10:10:01 -0400
Received: by wa-out-1112.google.com with SMTP id j5so570565wah.21
        for <linux-omap@vger.kernel.org>; Fri, 10 Apr 2009 07:10:00 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, paul@pwsan.com, khilman@deeprootsystems.com, Arun KS <arunks@mistralsolutions.com>

Typo error when requesting for clock for dsp in omap1

Signed-off-by: Arun KS <arunks@mistralsolutions.com>
---
 arch/arm/mach-omap1/mcbsp.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap1/mcbsp.c b/arch/arm/mach-omap1/mcbsp.c
index d040c3f..a2d7814 100644
--- a/arch/arm/mach-omap1/mcbsp.c
+++ b/arch/arm/mach-omap1/mcbsp.c
@@ -40,8 +40,8 @@ static void omap1_mcbsp_request(unsigned int id)
 	 */
 	if (id == OMAP_MCBSP1 || id == OMAP_MCBSP3) {
 		if (dsp_use++ == 0) {
-			api_clk = clk_get(NULL, "api_clk");
-			dsp_clk = clk_get(NULL, "dsp_clk");
+			api_clk = clk_get(NULL, "api_ck");
+			dsp_clk = clk_get(NULL, "dsp_ck");
 			if (!IS_ERR(api_clk) && !IS_ERR(dsp_clk)) {
 				clk_enable(api_clk);
 				clk_enable(dsp_clk);
-- 
1.5.6.3

