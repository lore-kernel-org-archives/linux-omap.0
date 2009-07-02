From: Ameya Palande <ameya.palande@nokia.com>
Subject: [PATCH 1/4] DSPBRIDGE: always malloc strlen+1 for the trailing \0
Date: Thu,  2 Jul 2009 17:21:05 +0300
Message-ID: <1246544468-14546-1-git-send-email-ameya.palande@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:42689 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753483AbZGBOV4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Jul 2009 10:21:56 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: x0095840@ti.com, h-kanigeri2@ti.com, ext-phil.2.carmody@nokia.com

From: Phil Carmody <ext-phil.2.carmody@nokia.com>

Array member [pathSize] is set to \0, so the array must be
pathSize+1 bytes in size.

Signed-off-by: Phil Carmody <ext-phil.2.carmody@nokia.com>
---
 drivers/dsp/bridge/pmgr/wcd.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/dsp/bridge/pmgr/wcd.c b/drivers/dsp/bridge/pmgr/wcd.c
index 86812c6..7732492 100644
--- a/drivers/dsp/bridge/pmgr/wcd.c
+++ b/drivers/dsp/bridge/pmgr/wcd.c
@@ -530,7 +530,7 @@ u32 MGRWRAP_RegisterObject(union Trapped_Args *args)
 		goto func_end;
 	pathSize = strlen_user((char *)
 				args->ARGS_MGR_REGISTEROBJECT.pszPathName);
-	pszPathName = MEM_Alloc(pathSize, MEM_NONPAGED);
+	pszPathName = MEM_Alloc(pathSize + 1, MEM_NONPAGED);
 	if (!pszPathName)
 		goto func_end;
 	retVal = strncpy_from_user(pszPathName,
-- 
1.6.2.4

