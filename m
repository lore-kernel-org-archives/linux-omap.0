From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 04/19] DSPBRIDGE: Now actually fail if a clk handle is wrong
Date: Thu,  8 Apr 2010 18:15:53 -0500
Message-ID: <1270768568-10712-5-git-send-email-omar.ramirez@ti.com>
References: <1270768568-10712-1-git-send-email-omar.ramirez@ti.com>
 <1270768568-10712-2-git-send-email-omar.ramirez@ti.com>
 <1270768568-10712-3-git-send-email-omar.ramirez@ti.com>
 <1270768568-10712-4-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57285 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933809Ab0DHW7c (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 Apr 2010 18:59:32 -0400
In-Reply-To: <1270768568-10712-4-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@gmail.com>, Ameya Palande <ameya.palande@nokia.com>, Guzman Lugo Fernando <x0095840@ti.com>, Nishanth Menon <nm@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

The value returned by clk_get on error is not NULL.

This checks if the value returned is an error or not.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/dsp/bridge/services/clk.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/dsp/bridge/services/clk.c b/drivers/dsp/bridge/services/clk.c
index 57cf6e3..74542c7 100644
--- a/drivers/dsp/bridge/services/clk.c
+++ b/drivers/dsp/bridge/services/clk.c
@@ -128,7 +128,7 @@ bool services_clk_init(void)
 		clk_handle = clk_get(&dspbridge_device.dev,
 				     services_clks[i].clk_name);
 
-		if (!clk_handle) {
+		if (IS_ERR(clk_handle)) {
 			pr_err("%s: failed to get clk handle %s, dev id = %d\n",
 			       __func__, services_clks[i].clk_name,
 			       services_clks[i].id);
-- 
1.6.2.4

