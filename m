From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 7/7] arm: omap2: clksel: fix compile warning
Date: Mon, 17 Jan 2011 06:31:20 +0200
Message-ID: <1295238680-26738-8-git-send-email-balbi@ti.com>
References: <1295238680-26738-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:43885 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752121Ab1AQEcR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sun, 16 Jan 2011 23:32:17 -0500
Received: by mail-gw0-f43.google.com with SMTP id 17so1751905gwb.16
        for <linux-omap@vger.kernel.org>; Sun, 16 Jan 2011 20:32:17 -0800 (PST)
In-Reply-To: <1295238680-26738-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

Fix the following compile warning:
arch/arm/mach-omap2/clkt_clksel.c: In function '_get_div_and_fieldval':
arch/arm/mach-omap2/clkt_clksel.c:100:35: warning: 'max_clkr' may be
used uninitialized in this function

While at that, also add a check to avoid using max_clkr while NULL.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/clkt_clksel.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/clkt_clksel.c b/arch/arm/mach-omap2/clkt_clksel.c
index a781cd6..baf0b6b 100644
--- a/arch/arm/mach-omap2/clkt_clksel.c
+++ b/arch/arm/mach-omap2/clkt_clksel.c
@@ -97,7 +97,7 @@ static u8 _get_div_and_fieldval(struct clk *src_clk, struct clk *clk,
 				u32 *field_val)
 {
 	const struct clksel *clks;
-	const struct clksel_rate *clkr, *max_clkr;
+	const struct clksel_rate *clkr, *max_clkr = NULL;
 	u8 max_div = 0;
 
 	clks = _get_clksel_by_parent(clk, src_clk);
@@ -123,6 +123,9 @@ static u8 _get_div_and_fieldval(struct clk *src_clk, struct clk *clk,
 		}
 	}
 
+	if (!max_clkr)
+		return 0;
+
 	if (max_div == 0) {
 		/* This indicates an error in the clksel data */
 		WARN(1, "clock: Could not find divisor for clock %s parent %s"
-- 
1.7.3.4.598.g85356

