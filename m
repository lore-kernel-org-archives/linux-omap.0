From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH 3/5] dspbridge: static code analysis issues - remember if GS_init succeeded
Date: Fri, 31 Jul 2009 13:39:26 +0300
Message-ID: <1249036768-754-3-git-send-email-Hiroshi.DOYU@nokia.com>
References: <1249036768-754-1-git-send-email-Hiroshi.DOYU@nokia.com>
 <1249036768-754-2-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:31874 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752208AbZGaKjv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 31 Jul 2009 06:39:51 -0400
In-Reply-To: <1249036768-754-2-git-send-email-Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: ameya.palande@nokia.com, h-kanigeri2@ti.com, x0095840@ti.com, omar.ramirez@ti.com, Phil Carmody <ext-phil.2.carmody@nokia.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

From: Phil Carmody <ext-phil.2.carmody@nokia.com>

Not that it can fail, and not that we actually do anything if it
does the impossible. But at least we now remember the state.

Signed-off-by: Phil Carmody <ext-phil.2.carmody@nokia.com>
Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 drivers/dsp/bridge/gen/gs.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/dsp/bridge/gen/gs.c b/drivers/dsp/bridge/gen/gs.c
index ef5f923..71298b4 100644
--- a/drivers/dsp/bridge/gen/gs.c
+++ b/drivers/dsp/bridge/gen/gs.c
@@ -101,8 +101,6 @@ void GS_init(void)
 	static bool curInit;
 
 	if (curInit == false) {
-		curInit = true;
-
-		MEM_Init();
+		curInit = MEM_Init(); /* which can't fail currently. */
 	}
 }
-- 
1.6.0.4

