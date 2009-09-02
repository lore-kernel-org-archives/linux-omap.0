From: Ameya Palande <ameya.palande@nokia.com>
Subject: [PATCHv2] DSPBRIDGE: Fix memory leak in PROC_AutoStart()
Date: Wed,  2 Sep 2009 22:07:36 +0300
Message-ID: <1251918456-24501-1-git-send-email-ameya.palande@nokia.com>
References: <1251917982-23690-1-git-send-email-ameya.palande@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:20345 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753328AbZIBTHo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Sep 2009 15:07:44 -0400
In-Reply-To: <1251917982-23690-1-git-send-email-ameya.palande@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: omar.ramirez@ti.com, x0095840@ti.com

Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
---
 drivers/dsp/bridge/rmgr/proc.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index a75b64a..eb8b4a9 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -512,6 +512,7 @@ DSP_STATUS PROC_AutoStart(struct CFG_DEVNODE *hDevNode,
 			 "No Exec file found \n");
 	}
 func_cont:
+	MEM_Free(hProcObject->g_pszLastCoff);
 	MEM_FreeObject(hProcObject);
 func_end:
 	GT_1trace(PROC_DebugMask, GT_ENTER,
-- 
1.6.2.4

