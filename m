From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 3/4] ARM: OMAP2+: hsmmc: Let board files specify if an external transceiver exists
Date: Fri, 9 Mar 2012 14:41:48 +0530
Message-ID: <1331284309-22101-4-git-send-email-rnayak@ti.com>
References: <1331284309-22101-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42382 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751264Ab2CIJMW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Mar 2012 04:12:22 -0500
In-Reply-To: <1331284309-22101-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>, Balaji TK <balajitk@ti.com>, Venkatraman S <svenkatr@ti.com>

The omap2_hsmmc_info structure provides a way for board files to specify
if an external transciever exists for the mmc module. So get rid of the
assumption based on external clock.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Cc: Balaji TK <balajitk@ti.com>
Cc: Venkatraman S <svenkatr@ti.com>
---
 arch/arm/mach-omap2/hsmmc.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index 0133b29..0aa4587 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -387,8 +387,6 @@ static int omap_hsmmc_pdata_init(struct omap2_hsmmc_info *c,
 			mmc->select_input_clk_src = hsmmc1_select_input_clk_src;
 		break;
 	case 2:
-		if (c->ext_clock)
-			c->transceiver = 1;
 		if (c->transceiver && (c->caps & MMC_CAP_8_BIT_DATA)) {
 			c->caps &= ~MMC_CAP_8_BIT_DATA;
 			c->caps |= MMC_CAP_4_BIT_DATA;
-- 
1.7.1

