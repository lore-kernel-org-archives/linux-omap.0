From: Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH] omap-mcbsp: properly check for availablity of mcbsp mux settings
Date: Sun, 19 Aug 2012 21:14:52 +0200
Message-ID: <1345403692-20829-1-git-send-email-andreas@kemnade.info>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from h1355771.stratoserver.net ([85.214.105.140]:34738 "EHLO
	h1355771.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750790Ab2HSTnI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 19 Aug 2012 15:43:08 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: peter.ujfalusi@ti.com, jarkko.nikula@bitmer.com, linux-omap@vger.kernel.org
Cc: Andreas Kemnade <andreas@kemnade.info>

The code did return -EINVAl when the mux_signal function pointer is available.
If not, the corresponding function (the NULL pointer) is called.
This patch inverts that logic.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 sound/soc/omap/mcbsp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/omap/mcbsp.c b/sound/soc/omap/mcbsp.c
index 34835e8..d33c48b 100644
--- a/sound/soc/omap/mcbsp.c
+++ b/sound/soc/omap/mcbsp.c
@@ -745,7 +745,7 @@ int omap_mcbsp_6pin_src_mux(struct omap_mcbsp *mcbsp, u8 mux)
 {
 	const char *signal, *src;
 
-	if (mcbsp->pdata->mux_signal)
+	if (!mcbsp->pdata->mux_signal)
 		return -EINVAL;
 
 	switch (mux) {
-- 
1.7.2.5

