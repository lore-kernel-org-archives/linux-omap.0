From: "Suresh Rajashekara" <suresh@mistralsolutions.com>
Subject: [PATCH] Fix section mismatch warning on OSK
Date: Tue, 11 Nov 2008 16:18:20 -0800
Message-ID: <deb0f030811111618q5e70e18doeea15271bdb7e2e8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.244]:52318 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752459AbYKLASV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Nov 2008 19:18:21 -0500
Received: by an-out-0708.google.com with SMTP id d40so98788and.1
        for <linux-omap@vger.kernel.org>; Tue, 11 Nov 2008 16:18:20 -0800 (PST)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Section mismatch warnings when compiling latest git for MACH_OMAP_OSK.
Missing __initdata on the omap1_clk_functions.

Signed-off-by: Suresh Rajashekara <suresh@mistralsolutions.com>
---
 arch/arm/mach-omap1/clock.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)
diff --git a/arch/arm/mach-omap1/clock.c b/arch/arm/mach-omap1/clock.c
index 4d0c444..aab7ab1 100644
--- a/arch/arm/mach-omap1/clock.c
+++ b/arch/arm/mach-omap1/clock.c
@@ -636,7 +636,7 @@ static void __init omap1_clk_disable_unused(struct clk *clk)
 #define omap1_clk_disable_unused NULL
 #endif

-static struct clk_functions omap1_clk_functions = {
+static struct clk_functions omap1_clk_functions __initdata = {
  .clk_enable = omap1_clk_enable,
  .clk_disable = omap1_clk_disable,
  .clk_round_rate = omap1_clk_round_rate,
-- 
1.4.4.4
