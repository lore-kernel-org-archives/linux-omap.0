From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 6/6] arm: omap2: clksel: fix compile warning
Date: Tue, 15 Feb 2011 14:49:16 +0200
Message-ID: <1297774156-23312-7-git-send-email-balbi@ti.com>
References: <1297774156-23312-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:57081 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754988Ab1BOMty (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Feb 2011 07:49:54 -0500
Received: by mail-yw0-f41.google.com with SMTP id 3so57722ywj.0
        for <linux-omap@vger.kernel.org>; Tue, 15 Feb 2011 04:49:53 -0800 (PST)
In-Reply-To: <1297774156-23312-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

Fix the following compile warning:
arch/arm/mach-omap2/clkt_clksel.c: In function '_get_div_and_fieldval':
arch/arm/mach-omap2/clkt_clksel.c:100:35: warning: 'max_clkr' may be
used uninitialized in this function

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/clkt_clksel.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/clkt_clksel.c b/arch/arm/mach-omap2/clkt_clksel.c
index a781cd6..e25364d 100644
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
-- 
1.7.4.rc2

