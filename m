From: Ameya Palande <ameya.palande@nokia.com>
Subject: [PATCH 4/4] DSPBRIDGE: Remove unnecessary conditions from some for loops
Date: Tue,  7 Jul 2009 18:02:07 +0300
Message-ID: <1246978928-7139-4-git-send-email-ameya.palande@nokia.com>
References: <1246978928-7139-1-git-send-email-ameya.palande@nokia.com>
 <1246978928-7139-2-git-send-email-ameya.palande@nokia.com>
 <1246978928-7139-3-git-send-email-ameya.palande@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:61470 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757809AbZGGPC0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Jul 2009 11:02:26 -0400
In-Reply-To: <1246978928-7139-3-git-send-email-ameya.palande@nokia.com>
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
index 811b2fc..6b2136a 100644
--- a/drivers/dsp/bridge/pmgr/wcd.c
+++ b/drivers/dsp/bridge/pmgr/wcd.c
@@ -904,7 +904,7 @@ u32 PROCWRAP_Load(union Trapped_Args *args)
 		goto func_cont;
 	}
 
-	for (i = 0; DSP_SUCCEEDED(status) && (i < count); i++) {
+	for (i = 0; i < count; i++) {
 		if (argv[i]) {
 			/* User space pointer to argument */
 			temp = (char *) argv[i];
@@ -945,7 +945,7 @@ u32 PROCWRAP_Load(union Trapped_Args *args)
 			envp = NULL;
 			goto func_cont;
 		}
-		for (i = 0; DSP_SUCCEEDED(status) && envp[i]; i++) {
+		for (i = 0; envp[i]; i++) {
 			/* User space pointer to argument */
 			temp = (char *)envp[i];
 			/* len is increased by 1 to accommodate NULL */
-- 
1.6.2.4

