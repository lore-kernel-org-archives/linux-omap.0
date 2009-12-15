From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 10/17] DSPBRIDGE: support loading 4 dependent DLL
Date: Tue, 15 Dec 2009 00:19:51 -0600
Message-ID: <1260857998-19349-11-git-send-email-omar.ramirez@ti.com>
References: <1260857998-19349-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45444 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753218AbZLOGMx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Dec 2009 01:12:53 -0500
In-Reply-To: <1260857998-19349-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Fernando Guzman <x0095840@ti.com>, Ernesto Ramos <ernesto@ti.com>

From: Fernando Guzman Lugo <x0095840@ti.com>

This patch fixes loading a SN that has 4 dependent DLLs, previously
it was failing due to a non-null terminated string.

Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
---
 drivers/dsp/bridge/rmgr/dbdcd.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/dbdcd.c b/drivers/dsp/bridge/rmgr/dbdcd.c
index b1391e2..fb06ff2 100644
--- a/drivers/dsp/bridge/rmgr/dbdcd.c
+++ b/drivers/dsp/bridge/rmgr/dbdcd.c
@@ -1529,7 +1529,7 @@ static DSP_STATUS GetDepLibInfo(IN struct DCD_MANAGER *hDcdMgr,
 		goto func_cont;
 
 	/* Allocate zeroed buffer. */
-	pszCoffBuf = MEM_Calloc(ulLen, MEM_PAGED);
+	pszCoffBuf = MEM_Calloc(ulLen + 4, MEM_PAGED);
 	if (pszCoffBuf == NULL)
 		status = DSP_EMEMORY;
 
-- 
1.6.2.4

