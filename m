From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 1/2] ARM: OMAP: Get rid of reset for system timer
Date: Thu, 2 Feb 2012 19:33:54 +0530
Message-ID: <1328191435-18652-2-git-send-email-santosh.shilimkar@ti.com>
References: <1328191435-18652-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38237 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756151Ab2BBOEG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 2 Feb 2012 09:04:06 -0500
In-Reply-To: <1328191435-18652-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, tony@atomide.com, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

From: Rajendra Nayak <rnayak@ti.com>

hwmod setup already does a reset and sets the OCP sysconfig
registers appropriately. Avoid doing a reset again and overriding
the OCP sysconfig settings in the system timer init code.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/timer.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 6eeff0e..ccd2d6a 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -195,7 +195,6 @@ static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
 		}
 	}
 	__omap_dm_timer_init_regs(timer);
-	__omap_dm_timer_reset(timer, 1, 1);
 	timer->posted = 1;
 
 	timer->rate = clk_get_rate(timer->fclk);
-- 
1.7.4.1

