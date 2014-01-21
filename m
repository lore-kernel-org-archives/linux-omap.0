From: Christoph Fritz <chf.fritz@googlemail.com>
Subject: [PATCH 6/6] [RFC] omapdss: remove FEAT_DPI_USES_VDDS_DSI from omap3
Date: Tue, 21 Jan 2014 20:47:40 +0100
Message-ID: <1390333660-30573-7-git-send-email-chf.fritz@googlemail.com>
References: <1390333660-30573-1-git-send-email-chf.fritz@googlemail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-la0-f47.google.com ([209.85.215.47]:53207 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753759AbaAUTsX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Jan 2014 14:48:23 -0500
In-Reply-To: <1390333660-30573-1-git-send-email-chf.fritz@googlemail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, bcousson@baylibre.com, Archit Taneja <archit@ti.com>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Daniel Mack <zonque@gmail.com>, "Hans J. Koch" <hjk@hansjkoch.de>
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org

DBB056 doesn't use DSI for its display, but omap3 forces this erroneously:

  | OMAP DSS rev 2.0
  | omapdss DPI error: can't get VDDS_DSI regulator
  | omapfb omapfb: failed to connect default display
  | omapfb omapfb: failed to init overlay connections
  | omapfb omapfb: failed to setup omapfb
  | platform omapfb: Driver omapfb requests probe deferral

So this patch just disables it for omap3. Consider this as a hack!
Is there a proper fix for this issue?
---
 drivers/video/omap2/dss/dss_features.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
index f8fd6db..0ae8a84 100644
--- a/drivers/video/omap2/dss/dss_features.c
+++ b/drivers/video/omap2/dss/dss_features.c
@@ -536,7 +536,6 @@ static const enum dss_feat_id omap3630_dss_feat_list[] = {
 	FEAT_ALPHA_FIXED_ZORDER,
 	FEAT_FIFO_MERGE,
 	FEAT_OMAP3_DSI_FIFO_BUG,
-	FEAT_DPI_USES_VDDS_DSI,
 };
 
 static const enum dss_feat_id omap4430_es1_0_dss_feat_list[] = {
-- 
1.7.10.4

