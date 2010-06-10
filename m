From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 1/2] DSPBRIDGE: fix a wrong clk index for gpt8
Date: Thu, 10 Jun 2010 07:14:04 -0500
Message-ID: <1276172045-17267-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55157 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753091Ab0FJMVR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Jun 2010 08:21:17 -0400
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id o5ACLGKs003426
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 10 Jun 2010 07:21:16 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ernesto Ramos Falcon <ernesto@ti.com>, Shivananda Hebbar <x0hebbar@ti.com>, Fernando Guzman Lugo <x0095840@ti.com>, Ivan Gomez Castellanos <ivan.gomez@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

Mismatch between index for gpt clocks will result in writting
out of bounds into dsp clock timer array when requesting gpt8,
for the other gpt the bogus code is being masked as it falls
within the array's range.

Discovered-by: Ernesto Ramos Falcon <ernesto@ti.com>
Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/dsp/bridge/core/dsp-clock.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/dsp/bridge/core/dsp-clock.c b/drivers/dsp/bridge/core/dsp-clock.c
index 4613de9..dba0535 100644
--- a/drivers/dsp/bridge/core/dsp-clock.c
+++ b/drivers/dsp/bridge/core/dsp-clock.c
@@ -212,7 +212,8 @@ int dsp_clk_enable(IN enum dsp_clk_id clk_id)
 		clk_enable(iva2_clk);
 		break;
 	case GPT_CLK:
-		timer[clk_id] = omap_dm_timer_request_specific(DMT_ID(clk_id));
+		timer[clk_id - 1] =
+				omap_dm_timer_request_specific(DMT_ID(clk_id));
 		break;
 	case MCBSP_CLK:
 		mcbsp_clk_prepare(true, clk_id);
@@ -287,7 +288,7 @@ int dsp_clk_disable(IN enum dsp_clk_id clk_id)
 		clk_disable(iva2_clk);
 		break;
 	case GPT_CLK:
-		omap_dm_timer_free(timer[clk_id]);
+		omap_dm_timer_free(timer[clk_id - 1]);
 		break;
 	case MCBSP_CLK:
 		mcbsp_clk_prepare(false, clk_id);
-- 
1.7.1

