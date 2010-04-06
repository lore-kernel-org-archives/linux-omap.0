From: Laine Walker-Avina <lwalkera@ieee.org>
Subject: [PATCH 4/5] OMAP: Add support for setting the divider for sys_clkout2 using clk_set_rate
Date: Tue,  6 Apr 2010 09:51:07 -0700
Message-ID: <1270572668-2336-5-git-send-email-lwalkera@ieee.org>
References: <1270572668-2336-1-git-send-email-lwalkera@ieee.org>
 <1270572668-2336-2-git-send-email-lwalkera@ieee.org>
 <1270572668-2336-3-git-send-email-lwalkera@ieee.org>
 <1270572668-2336-4-git-send-email-lwalkera@ieee.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from exprod7og109.obsmtp.com ([64.18.2.171]:53209 "HELO
	exprod7og109.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755737Ab0DFRCX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Apr 2010 13:02:23 -0400
In-Reply-To: <1270572668-2336-4-git-send-email-lwalkera@ieee.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Laine Walker-Avina <lwalkera@ieee.org>


Signed-off-by: Laine Walker-Avina <lwalkera@ieee.org>
---
 arch/arm/mach-omap2/clock3xxx_data.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index d5153b6..2a62779 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -1111,6 +1111,7 @@ static struct clk sys_clkout2 = {
 	.clksel_mask	= OMAP3430_CLKOUT2_DIV_MASK,
 	.clksel		= sys_clkout2_clksel,
 	.recalc		= &omap2_clksel_recalc,
+	.set_rate	= &omap2_clksel_set_rate,
 };
 
 /* CM OUTPUT CLOCKS */
-- 
1.6.3.3

