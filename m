From: "Stanley.Miao" <stanley.miao@windriver.com>
Subject: [PATCH 7/9] OMAP: fix a gpmc nand problem
Date: Mon, 19 Apr 2010 18:20:45 +0800
Message-ID: <1271672447-3639-8-git-send-email-stanley.miao@windriver.com>
References: <1271672447-3639-1-git-send-email-stanley.miao@windriver.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:51748 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753858Ab0DSKMH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Apr 2010 06:12:07 -0400
In-Reply-To: <1271672447-3639-1-git-send-email-stanley.miao@windriver.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, hvaibhav@ti.com, srk@ti.com

If gpmc_t isn't given, we don't need to set timing for gpmc, or it will cause
a Oops.

Signed-off-by: Stanley.Miao <stanley.miao@windriver.com>
---
 arch/arm/mach-omap2/gpmc-nand.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc-nand.c b/arch/arm/mach-omap2/gpmc-nand.c
index 64d74f0..e57fb29 100644
--- a/arch/arm/mach-omap2/gpmc-nand.c
+++ b/arch/arm/mach-omap2/gpmc-nand.c
@@ -39,6 +39,9 @@ static int omap2_nand_gpmc_retime(void)
 	struct gpmc_timings t;
 	int err;
 
+	if (!gpmc_nand_data->gpmc_t)
+		return 0;
+
 	memset(&t, 0, sizeof(t));
 	t.sync_clk = gpmc_round_ns_to_ticks(gpmc_nand_data->gpmc_t->sync_clk);
 	t.cs_on = gpmc_round_ns_to_ticks(gpmc_nand_data->gpmc_t->cs_on);
-- 
1.5.4.3

