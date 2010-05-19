From: "Guzman Lugo, Fernando" <fernando.lugo@ti.com>
Subject: [PATCH] DSPBRIDGE: fix incorrect reset in bridge_brd_start function
Date: Tue, 18 May 2010 20:22:02 -0500
Message-ID: <496565EC904933469F292DDA3F1663E602CB7A83DB@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41376 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754725Ab0ESBWH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 May 2010 21:22:07 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>

>From 595a54c6a886d8e707e04cbf5d0d9b6d6de7c6ec Mon Sep 17 00:00:00 2001
From: Fernando Guzman Lugo <x0095840@ti.com>
Date: Tue, 18 May 2010 20:14:20 -0500
Subject: [PATCH] DSPBRIDGE: fix incorrect reset in bridge_brd_start function

IVA mmu reset was not being done properly, so dsp bootaddress
was not copied to SYSC register. Given as a result DSP was not
booting from that address after reloading baseimage.

Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
---
 drivers/dsp/bridge/core/tiomap3430.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/dsp/bridge/core/tiomap3430.c b/drivers/dsp/bridge/core/tiomap3430.c
index c7b0d83..805e6f3 100644
--- a/drivers/dsp/bridge/core/tiomap3430.c
+++ b/drivers/dsp/bridge/core/tiomap3430.c
@@ -443,7 +443,7 @@ static dsp_status bridge_brd_start(struct bridge_dev_context *hDevContext,
 		/* Reset and Unreset the RST2, so that BOOTADDR is copied to
 		 * IVA2 SYSC register */
 		(*pdata->dsp_prm_rmw_bits)(OMAP3430_RST2_IVA2,
-			OMAP3430_RST1_IVA2, OMAP3430_IVA2_MOD, RM_RSTCTRL);
+			OMAP3430_RST2_IVA2, OMAP3430_IVA2_MOD, RM_RSTCTRL);
 		udelay(100);
 		(*pdata->dsp_prm_rmw_bits)(OMAP3430_RST2_IVA2, 0,
 					OMAP3430_IVA2_MOD, RM_RSTCTRL);
-- 
1.6.3.3
