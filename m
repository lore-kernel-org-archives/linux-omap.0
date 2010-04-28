From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH v2] DSPBRIDGE: Now actually fail if a clk handle is wrong
Date: Tue, 27 Apr 2010 20:29:11 -0500
Message-ID: <1272418167-12630-4-git-send-email-omar.ramirez@ti.com>
References: <1272418167-12630-1-git-send-email-omar.ramirez@ti.com>
 <1272418167-12630-2-git-send-email-omar.ramirez@ti.com>
 <1272418167-12630-3-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45741 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753370Ab0D1BYb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Apr 2010 21:24:31 -0400
In-Reply-To: <1272418167-12630-3-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Nishanth Menon <nm@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

The value returned by clk_get on error is not NULL.

This checks if the value returned is an error or not.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/dsp/bridge/services/clk.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/dsp/bridge/services/clk.c b/drivers/dsp/bridge/services/clk.c
index 1089e72..b9fb9ef 100644
--- a/drivers/dsp/bridge/services/clk.c
+++ b/drivers/dsp/bridge/services/clk.c
@@ -126,7 +126,7 @@ bool services_clk_init(void)
 		clk_handle = clk_get(&dspbridge_device.dev,
 				     services_clks[i].clk_name);
 
-		if (!clk_handle) {
+		if (IS_ERR(clk_handle)) {
 			pr_err("%s: failed to get clk handle %s, dev id = %d\n",
 			       __func__, services_clks[i].clk_name,
 			       services_clks[i].id);
-- 
1.6.0.4

