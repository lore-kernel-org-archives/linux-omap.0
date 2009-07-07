From: Ameya Palande <ameya.palande@nokia.com>
Subject: [PATCHv2 2/4] DSPBRIDGE: Heuristic fixes of strlen/malloc out by one
Date: Tue,  7 Jul 2009 18:02:05 +0300
Message-ID: <1246978928-7139-2-git-send-email-ameya.palande@nokia.com>
References: <1246978928-7139-1-git-send-email-ameya.palande@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:61413 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757809AbZGGPCU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Jul 2009 11:02:20 -0400
In-Reply-To: <1246978928-7139-1-git-send-email-ameya.palande@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: x0095840@ti.com, h-kanigeri2@ti.com, ext-phil.2.carmody@nokia.com

From: Phil Carmody <ext-phil.2.carmody@nokia.com>

I say 'heuristic', as I can't prove they're wrong, they just look
wrong, and for that reason should be given extra close scrutiny.
These are basically just the old malloc-one-more-than-strlen.

Signed-off-by: Phil Carmody <ext-phil.2.carmody@nokia.com>
---
 drivers/dsp/bridge/pmgr/wcd.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/dsp/bridge/pmgr/wcd.c b/drivers/dsp/bridge/pmgr/wcd.c
index aaf3019..563a1d8 100644
--- a/drivers/dsp/bridge/pmgr/wcd.c
+++ b/drivers/dsp/bridge/pmgr/wcd.c
@@ -532,8 +532,9 @@ u32 MGRWRAP_RegisterObject(union Trapped_Args *args)
 	cp_fm_usr(&pUuid, args->ARGS_MGR_REGISTEROBJECT.pUuid, status, 1);
 	if (DSP_FAILED(status))
 		goto func_end;
+	/* pathSize is increased by 1 to accommodate NULL */
 	pathSize = strlen_user((char *)
-				args->ARGS_MGR_REGISTEROBJECT.pszPathName);
+			args->ARGS_MGR_REGISTEROBJECT.pszPathName) + 1;
 	pszPathName = MEM_Alloc(pathSize, MEM_NONPAGED);
 	if (!pszPathName)
 		goto func_end;
@@ -544,7 +545,6 @@ u32 MGRWRAP_RegisterObject(union Trapped_Args *args)
 		status = DSP_EPOINTER;
 		goto func_end;
 	}
-	pszPathName[pathSize] = '\0';
 
 	GT_1trace(WCD_debugMask, GT_ENTER,
 		 "MGRWRAP_RegisterObject: entered pg2hMsg "
@@ -904,7 +904,8 @@ u32 PROCWRAP_Load(union Trapped_Args *args)
 		if (argv[i] != NULL) {
                         /* User space pointer to argument */
                        temp = (char *) argv[i];
-                       len = strlen_user((char *)temp);
+			/* len is increased by 1 to accommodate NULL */
+			len = strlen_user((char *)temp) + 1;
 			/* Kernel space pointer to argument */
 			argv[i] = MEM_Alloc(len, MEM_NONPAGED);
 			if (argv[i] == NULL) {
@@ -914,7 +915,6 @@ u32 PROCWRAP_Load(union Trapped_Args *args)
 			cp_fm_usr(argv[i], temp, status, len);
 			if (DSP_FAILED(status))
 				goto func_cont;
-
 		}
 	}
 	/* TODO: validate this */
@@ -937,7 +937,8 @@ u32 PROCWRAP_Load(union Trapped_Args *args)
 		for (i = 0; DSP_SUCCEEDED(status) && (envp[i] != NULL); i++) {
                         /* User space pointer to argument */
                        temp = (char *)envp[i];
-                       len = strlen_user((char *)temp);
+			/* len is increased by 1 to accommodate NULL */
+			len = strlen_user((char *)temp) + 1;
 			/* Kernel space pointer to argument */
 			envp[i] = MEM_Alloc(len, MEM_NONPAGED);
 			if (envp[i] == NULL) {
-- 
1.6.2.4

