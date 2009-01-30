From: "Ramirez Luna, Omar" <x00omar@ti.com>
Subject: [OMAPZOOM][PATCH 3/6] DSPBRIDGE Fix for DCD stack overflow
Date: Thu, 29 Jan 2009 18:15:27 -0600
Message-ID: <27F9C60D11D683428E133F85D2BB4A5303F7EA52BD@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47162 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751931AbZA3APe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Jan 2009 19:15:34 -0500
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n0U0FSKo003754
	for <linux-omap@vger.kernel.org>; Thu, 29 Jan 2009 18:15:33 -0600
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id n0U0FSMC016387
	for <linux-omap@vger.kernel.org>; Thu, 29 Jan 2009 18:15:28 -0600 (CST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

From: Fernando Guzman Lugo <x0095840@ti.com>
Date: Wed, 28 Jan 2009 19:23:24 -0600
Subject: [PATCH] DSPBRIDGE Fix for DCD stack overflow

Fixed DCD stack buffer overflow.

Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
---
 drivers/dsp/bridge/rmgr/dbdcd.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/dbdcd.c b/drivers/dsp/bridge/rmgr/dbdcd.c
index 129c16b..6fbe03f 100644
--- a/drivers/dsp/bridge/rmgr/dbdcd.c
+++ b/drivers/dsp/bridge/rmgr/dbdcd.c
@@ -473,7 +473,7 @@ DSP_STATUS DCD_GetObjectDef(IN struct DCD_MANAGER *hDcdMgr,
 	u32 dwBufSize;	/* Used by REG functions */
 	char szRegKey[REG_MAXREGPATHLENGTH];
 	char *szUuid;		/*[MAXUUIDLEN];*/
-	char szRegData[MAXUUIDLEN];
+	char szRegData[REG_MAXREGPATHLENGTH];
 	char szSectName[MAXUUIDLEN + 2];	/* ".[UUID]\0" */
 	char *pszCoffBuf;
 	u32 dwKeyLen;		/* Len of REG key. */
-- 
1.5.4.3

