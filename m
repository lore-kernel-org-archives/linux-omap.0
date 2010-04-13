From: "Stanley.Miao" <stanley.miao@windriver.com>
Subject: [PATCH 08/11] OMAP: fix a gpmc nand problem
Date: Tue, 13 Apr 2010 17:31:58 +0800
Message-ID: <1271151118-12999-9-git-send-email-stanley.miao@windriver.com>
References: <1271151118-12999-1-git-send-email-stanley.miao@windriver.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:51257 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752594Ab0DMJXm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Apr 2010 05:23:42 -0400
In-Reply-To: <1271151118-12999-1-git-send-email-stanley.miao@windriver.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com

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

