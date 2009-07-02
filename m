From: Ameya Palande <ameya.palande@nokia.com>
Subject: [PATCH 2/4] DSPBRIDGE: Heuristic fixes of strlen/malloc out by one and termination errors
Date: Thu,  2 Jul 2009 17:21:06 +0300
Message-ID: <1246544468-14546-2-git-send-email-ameya.palande@nokia.com>
References: <1246544468-14546-1-git-send-email-ameya.palande@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:42690 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753728AbZGBOV4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Jul 2009 10:21:56 -0400
In-Reply-To: <1246544468-14546-1-git-send-email-ameya.palande@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: x0095840@ti.com, h-kanigeri2@ti.com, ext-phil.2.carmody@nokia.com

From: Phil Carmody <ext-phil.2.carmody@nokia.com>

I say 'heuristic', as I can't prove they're wrong, they just look
wrong, and for that reason should be given extra close scrutiny.
These are basically just the old malloc-one-more-than-strlen and
strncpy-doesn't-write-a-terminal-nil gotchas.

Signed-off-by: Phil Carmody <ext-phil.2.carmody@nokia.com>
---
 drivers/dsp/bridge/pmgr/wcd.c  |    7 ++++---
 drivers/dsp/bridge/rmgr/nldr.c |    3 ++-
 drivers/dsp/bridge/rmgr/node.c |    5 +++--
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/dsp/bridge/pmgr/wcd.c b/drivers/dsp/bridge/pmgr/wcd.c
index 7732492..00b2770 100644
--- a/drivers/dsp/bridge/pmgr/wcd.c
+++ b/drivers/dsp/bridge/pmgr/wcd.c
@@ -902,7 +902,7 @@ u32 PROCWRAP_Load(union Trapped_Args *args)
                        temp = (char *) argv[i];
                        len = strlen_user((char *)temp);
 			/* Kernel space pointer to argument */
-			argv[i] = MEM_Alloc(len, MEM_NONPAGED);
+			argv[i] = MEM_Alloc(len + 1, MEM_NONPAGED);
 			if (argv[i] == NULL) {
 				status = DSP_EMEMORY;
 				break;
@@ -910,7 +910,7 @@ u32 PROCWRAP_Load(union Trapped_Args *args)
 			cp_fm_usr(argv[i], temp, status, len);
 			if (DSP_FAILED(status))
 				goto func_cont;
-
+			argv[i][len] = '\0';
 		}
 	}
 	/* TODO: validate this */
@@ -935,7 +935,7 @@ u32 PROCWRAP_Load(union Trapped_Args *args)
                        temp = (char *)envp[i];
                        len = strlen_user((char *)temp);
 			/* Kernel space pointer to argument */
-			envp[i] = MEM_Alloc(len, MEM_NONPAGED);
+			envp[i] = MEM_Alloc(len + 1, MEM_NONPAGED);
 			if (envp[i] == NULL) {
 				status = DSP_EMEMORY;
 				break;
@@ -943,6 +943,7 @@ u32 PROCWRAP_Load(union Trapped_Args *args)
 			cp_fm_usr(envp[i], temp, status, len);
 			if (DSP_FAILED(status))
 				goto func_cont;
+			envp[i][len] = '\0';
 		}
 	}
 	GT_5trace(WCD_debugMask, GT_ENTER,
diff --git a/drivers/dsp/bridge/rmgr/nldr.c b/drivers/dsp/bridge/rmgr/nldr.c
index 79f7505..a6a0528 100644
--- a/drivers/dsp/bridge/rmgr/nldr.c
+++ b/drivers/dsp/bridge/rmgr/nldr.c
@@ -1128,7 +1128,8 @@ static DSP_STATUS AddOvlyNode(struct DSP_UUID *pUuid,
 			if (pBuf == NULL) {
 				status = DSP_EMEMORY;
 			} else {
-                               strncpy(pBuf, pNodeName, uLen);
+				strncpy(pBuf, pNodeName, uLen);
+				pBuf[uLen] = '\0';
 				hNldr->ovlyTable[hNldr->nNode].pNodeName = pBuf;
 				hNldr->nNode++;
 			}
diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr/node.c
index 53a42bf..9f7e4d4 100644
--- a/drivers/dsp/bridge/rmgr/node.c
+++ b/drivers/dsp/bridge/rmgr/node.c
@@ -3272,8 +3272,9 @@ static DSP_STATUS GetNodeProps(struct DCD_MANAGER *hDcdMgr,
 			if (hNode->pstrDevName == NULL) {
 				status = DSP_EMEMORY;
 			} else {
-                               strncpy(hNode->pstrDevName,
-					   pndbProps->acName, uLen);
+				strncpy(hNode->pstrDevName,
+					pndbProps->acName, uLen);
+				hNode->pstrDevName[uLen] = '\0';
 			}
 		}
 	}
-- 
1.6.2.4

