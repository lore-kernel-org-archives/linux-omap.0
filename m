From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH 1/2] ARM: omap: hwmod: Add an 'ick' clkdev alias
Date: Fri, 11 May 2012 19:23:17 +0530
Message-ID: <1336744398-23803-2-git-send-email-tarun.kanti@ti.com>
References: <1336744398-23803-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34624 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759847Ab2EKNxa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 May 2012 09:53:30 -0400
In-Reply-To: <1336744398-23803-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, tony@atomide.com, santosh.shilimkar@ti.com, khilman@ti.com, b-cousson@ti.com, Rajendra Nayak <rnayak@ti.com>

From: Rajendra Nayak <rnayak@ti.com>

For all hwmods' with just one slave interface, use the
slave->clk to add an 'ick' clkdev alias in the table.
This is useful for drivers of such devices to get
the interface clock using 'clk_get(dev, "ick")'

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/plat-omap/omap_device.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index d50cbc6..c8bc005 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -311,6 +311,9 @@ static void _add_hwmod_clocks_clkdev(struct omap_device *od,
 
 	for (i = 0; i < oh->opt_clks_cnt; i++)
 		_add_clkdev(od, oh->opt_clks[i].role, oh->opt_clks[i].clk);
+
+	if (oh->slaves_cnt == 1)
+		_add_clkdev(od, "ick", oh->slaves[0]->clk);
 }
 
 
-- 
1.7.0.4

