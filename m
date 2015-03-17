From: Suman Anna <s-anna@ti.com>
Subject: [PATCH 2/2] ARM: OMAP: dmtimer: disable pm runtime on remove
Date: Mon, 16 Mar 2015 20:14:03 -0500
Message-ID: <1426554843-42641-3-git-send-email-s-anna@ti.com>
References: <1426554843-42641-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48430 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753100AbbCQBOd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Mar 2015 21:14:33 -0400
In-Reply-To: <1426554843-42641-1-git-send-email-s-anna@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Suman Anna <s-anna@ti.com>

Disable the pm_runtime of the device upon remove. This is
added to balance the pm_runtime_enable() invoked in the probe.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/plat-omap/dmtimer.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index f32c74c0e1de..8ca94d379bc3 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -910,6 +910,8 @@ static int omap_dm_timer_remove(struct platform_device *pdev)
 		}
 	spin_unlock_irqrestore(&dm_timer_lock, flags);
 
+	pm_runtime_disable(&pdev->dev);
+
 	return ret;
 }
 
-- 
2.3.2

