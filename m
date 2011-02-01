From: Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: [PATCH] arm: mach-omap2: board-rm680: fix rm680_vemmc regulator constraints
Date: Tue,  1 Feb 2011 17:36:28 +0200
Message-ID: <1296574588-23588-1-git-send-email-aaro.koskinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.26]:56601 "EHLO mgw-da02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750998Ab1BAPeG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 1 Feb 2011 10:34:06 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Aaro Koskinen <aaro.koskinen@nokia.com>

With the commit 757902513019e6ee469791ff76f954b19ca8d036 fixed voltage
regulator setup will fail if there are voltage constraints defined. This
made MMC unusable on this board. Fix by just deleting those redundant
constraints.

Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
---
 arch/arm/mach-omap2/board-rm680.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rm680.c b/arch/arm/mach-omap2/board-rm680.c
index cb77be7..39a71bb 100644
--- a/arch/arm/mach-omap2/board-rm680.c
+++ b/arch/arm/mach-omap2/board-rm680.c
@@ -40,9 +40,6 @@ static struct regulator_consumer_supply rm680_vemmc_consumers[] = {
 static struct regulator_init_data rm680_vemmc = {
 	.constraints =	{
 		.name			= "rm680_vemmc",
-		.min_uV			= 2900000,
-		.max_uV			= 2900000,
-		.apply_uV		= 1,
 		.valid_modes_mask	= REGULATOR_MODE_NORMAL
 					| REGULATOR_MODE_STANDBY,
 		.valid_ops_mask		= REGULATOR_CHANGE_STATUS
-- 
1.5.6.5

