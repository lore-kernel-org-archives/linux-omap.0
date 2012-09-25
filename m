From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv5 07/10] ARM: OMAP4: clock data: set autoidle flag for dss_fck
Date: Tue, 25 Sep 2012 12:32:42 +0300
Message-ID: <1348565565-14744-8-git-send-email-t-kristo@ti.com>
References: <1348565565-14744-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33053 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754411Ab2IYJdI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Sep 2012 05:33:08 -0400
In-Reply-To: <1348565565-14744-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, khilman@ti.com
Cc: linux-arm-kernel@lists.infradead.org

dss_fck is currently being used improperly within the hwmod database
as an interface clock for DSS hwmods. This causes the dss_fck to
be enabled even if the dss powerdomain itself is idle, resulting
in wrong data within the powerdomain usecounts. Marked dss_fck as
autoidle which makes the clock to disappear from usecounts for now.
This patch can be reverted once the interface clocks for DSS hwmods
have been properly fixed.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/clock44xx_data.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index d7f55e4..95834d7 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -1408,6 +1408,7 @@ static struct clk dss_fck = {
 	.clkdm_name	= "l3_dss_clkdm",
 	.parent		= &l3_div_ck,
 	.recalc		= &followparent_recalc,
+	.autoidle	= true,
 };
 
 static struct clk efuse_ctrl_cust_fck = {
-- 
1.7.4.1

