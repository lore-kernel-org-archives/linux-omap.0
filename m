From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH 4/5] dspbridge: static code analysis issues - failure to handle null paramters
Date: Fri, 31 Jul 2009 13:39:27 +0300
Message-ID: <1249036768-754-4-git-send-email-Hiroshi.DOYU@nokia.com>
References: <1249036768-754-1-git-send-email-Hiroshi.DOYU@nokia.com>
 <1249036768-754-2-git-send-email-Hiroshi.DOYU@nokia.com>
 <1249036768-754-3-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:37182 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752201AbZGaKjp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 31 Jul 2009 06:39:45 -0400
In-Reply-To: <1249036768-754-3-git-send-email-Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: ameya.palande@nokia.com, h-kanigeri2@ti.com, x0095840@ti.com, omar.ramirez@ti.com, Phil Carmody <ext-phil.2.carmody@nokia.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

From: Phil Carmody <ext-phil.2.carmody@nokia.com>

There's no point in continuing if zlLib is null, so just set the
status to an error value, and let the rest of the code be skipped
over naturally.

Signed-off-by: Phil Carmody <ext-phil.2.carmody@nokia.com>
Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 drivers/dsp/bridge/pmgr/dbll.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/dsp/bridge/pmgr/dbll.c b/drivers/dsp/bridge/pmgr/dbll.c
index 82430a3..c57f557 100644
--- a/drivers/dsp/bridge/pmgr/dbll.c
+++ b/drivers/dsp/bridge/pmgr/dbll.c
@@ -459,6 +459,8 @@ DSP_STATUS DBLL_getSect(struct DBLL_LibraryObj *lib, char *name, u32 *pAddr,
 			(*(zlLib->pTarget->attrs.fseek))(zlLib->fp,
 			 zlLib->ulPos, SEEK_SET);
 		}
+	} else {
+		status = DSP_EHANDLE;
 	}
 	if (DSP_SUCCEEDED(status)) {
 		uByteSize = 1;
@@ -834,8 +836,9 @@ DSP_STATUS DBLL_readSect(struct DBLL_LibraryObj *lib, char *name,
 			(*(zlLib->pTarget->attrs.fseek))(zlLib->fp,
 				zlLib->ulPos, SEEK_SET);
 		}
+	} else {
+		status = DSP_EHANDLE;
 	}
-
 	if (DSP_FAILED(status))
 		goto func_cont;
 
-- 
1.6.0.4

