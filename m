From: Ameya Palande <ameya.palande@nokia.com>
Subject: [PATCH 4/4] DSPBRIDGE: Remove unnecessary conditions from some for loops
Date: Thu,  2 Jul 2009 17:21:08 +0300
Message-ID: <1246544468-14546-4-git-send-email-ameya.palande@nokia.com>
References: <1246544468-14546-1-git-send-email-ameya.palande@nokia.com>
 <1246544468-14546-2-git-send-email-ameya.palande@nokia.com>
 <1246544468-14546-3-git-send-email-ameya.palande@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:42768 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753590AbZGBOWS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Jul 2009 10:22:18 -0400
In-Reply-To: <1246544468-14546-3-git-send-email-ameya.palande@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: x0095840@ti.com, h-kanigeri2@ti.com, ext-phil.2.carmody@nokia.com

The status cannot be a failure value at the start of the loops,
and the only changes to a failure state are accompanied by a
break or goto, so these conditions are always true.

Signed-off-by: Phil Carmody <ext-phil.2.carmody@nokia.com>
---
 drivers/dsp/bridge/pmgr/wcd.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dsp/bridge/pmgr/wcd.c b/drivers/dsp/bridge/pmgr/wcd.c
index 2fd9f8c..a1bd2c7 100644
--- a/drivers/dsp/bridge/pmgr/wcd.c
+++ b/drivers/dsp/bridge/pmgr/wcd.c
@@ -900,7 +900,7 @@ u32 PROCWRAP_Load(union Trapped_Args *args)
 		goto func_cont;
 	}
 
-	for (i = 0; DSP_SUCCEEDED(status) && (i < count); i++) {
+	for (i = 0; i < count; i++) {
 		if (argv[i] != NULL) {
                         /* User space pointer to argument */
 			temp = (char *) argv[i];
@@ -941,7 +941,7 @@ u32 PROCWRAP_Load(union Trapped_Args *args)
 			envp = NULL;
 			goto func_cont;
 		}
-		for (i = 0; DSP_SUCCEEDED(status) && (envp[i] != NULL); i++) {
+		for (i = 0; envp[i] != NULL; i++) {
                         /* User space pointer to argument */
 			temp = (char *)envp[i];
 			len = strlen_user((char *)temp);
-- 
1.6.2.4

