From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [RESEND][PATCH 4/5] DSPBRIDGE: Remove multiple initializations of
 REG module
Date: Mon, 25 Jan 2010 19:57:06 -0600
Message-ID: <4B5E4BF2.6000708@ti.com>
References: <1264217604-8021-1-git-send-email-omar.ramirez@ti.com> <1264217604-8021-2-git-send-email-omar.ramirez@ti.com> <1264217604-8021-3-git-send-email-omar.ramirez@ti.com> <1264217604-8021-4-git-send-email-omar.ramirez@ti.com> <1264217604-8021-5-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37710 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751973Ab0AZB5M (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 25 Jan 2010 20:57:12 -0500
In-Reply-To: <1264217604-8021-5-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, "Menon, Nishanth" <nm@ti.com>

 From cab08d7241af701397f6e78723d8e2125c3f2306 Mon Sep 17 00:00:00 2001
From: Omar Ramirez Luna <omar.ramirez@ti.com>
Date: Thu, 21 Jan 2010 20:34:20 -0600
Subject: [PATCH 08/15] DSPBRIDGE: Remove multiple initializations of REG 
module

REG module should be only initialized by services layer.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
  drivers/dsp/bridge/rmgr/dbdcd.c |    9 +--------
  1 files changed, 1 insertions(+), 8 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/dbdcd.c 
b/drivers/dsp/bridge/rmgr/dbdcd.c
index cb244f4..caa57f1 100644
--- a/drivers/dsp/bridge/rmgr/dbdcd.c
+++ b/drivers/dsp/bridge/rmgr/dbdcd.c
@@ -350,7 +350,6 @@ void DCD_Exit(void)

  	cRefs--;
  	if (cRefs == 0) {
-		REG_Exit();
  		COD_Exit();
  	}

@@ -821,7 +820,6 @@ DSP_STATUS DCD_GetLibraryName(IN struct DCD_MANAGER 
*hDcdMgr,
   */
  bool DCD_Init(void)
  {
-	bool fInitREG;
  	bool fInitCOD;
  	bool fInit = true;

@@ -833,18 +831,13 @@ bool DCD_Init(void)
  	if (cRefs == 0) {
  		/* Initialize required modules. */
  		fInitCOD = COD_Init();
-		fInitREG = REG_Init();

-		if (!fInitCOD || !fInitREG) {
+		if (!fInitCOD) {
  			fInit = false;
  			GT_0trace(curTrace, GT_6CLASS, "DCD_Init failed\n");
  			/* Exit initialized modules. */
  			if (fInitCOD)
  				COD_Exit();
-
-			if (fInitREG)
-				REG_Exit();
-
  		}
  	}

-- 
1.6.2.4

