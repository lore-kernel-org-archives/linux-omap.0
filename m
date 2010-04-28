From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH v2 03/19] DSPBRIDGE: Now actually fail if a clk handle is wrong
Date: Wed, 28 Apr 2010 10:29:41 -0500
Message-ID: <1272468597-6748-4-git-send-email-omar.ramirez@ti.com>
References: <1272468597-6748-1-git-send-email-omar.ramirez@ti.com>
 <1272468597-6748-2-git-send-email-omar.ramirez@ti.com>
 <1272468597-6748-3-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59998 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754971Ab0D1PY5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 28 Apr 2010 11:24:57 -0400
In-Reply-To: <1272468597-6748-3-git-send-email-omar.ramirez@ti.com>
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
1.6.2.4

