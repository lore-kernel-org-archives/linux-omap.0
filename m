From: Christoph Fritz <chf.fritz@googlemail.com>
Subject: [PATCH v2 5/5] [RFC] omapdss: remove FEAT_DPI_USES_VDDS_DSI from omap3
Date: Wed, 22 Jan 2014 20:04:20 +0100
Message-ID: <1390417460-3134-6-git-send-email-chf.fritz@googlemail.com>
References: <1390417460-3134-1-git-send-email-chf.fritz@googlemail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:41770 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755989AbaAVTEz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Jan 2014 14:04:55 -0500
In-Reply-To: <1390417460-3134-1-git-send-email-chf.fritz@googlemail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Ulf Hansson <ulf.hansson@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Archit Taneja <archit@ti.com>, bcousson@baylibre.com, "Hans J. Koch" <hjk@hansjkoch.de>, Daniel Mack <zonque@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

DBB056 doesn't use DSI for its display, but omap3 forces this
erroneously for all its boards:

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
index 7f89691..dbf5894 100644
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

