From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH 2/5] dspbridge: static code analysis issues - useless null pointer checks
Date: Fri, 31 Jul 2009 13:39:25 +0300
Message-ID: <1249036768-754-2-git-send-email-Hiroshi.DOYU@nokia.com>
References: <1249036768-754-1-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:49320 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752208AbZGaKjt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 31 Jul 2009 06:39:49 -0400
In-Reply-To: <1249036768-754-1-git-send-email-Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: ameya.palande@nokia.com, h-kanigeri2@ti.com, x0095840@ti.com, omar.ramirez@ti.com, Phil Carmody <ext-phil.2.carmody@nokia.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

From: Phil Carmody <ext-phil.2.carmody@nokia.com>

Given that dl_state.myio can only be 0 or init, the additional check
for init to be non-null is unnecessary once we know dl_state.myio is
non-NULL. (This assumes NULL is all-bits-zero, but as this is
platform/implementation-specific code, that's a fair assumption to
make.)

Signed-off-by: Phil Carmody <ext-phil.2.carmody@nokia.com>
Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 drivers/dsp/bridge/dynload/cload.c |   27 ++++++++++++---------------
 1 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/dsp/bridge/dynload/cload.c b/drivers/dsp/bridge/dynload/cload.c
index 271ab81..ef5d7d9 100644
--- a/drivers/dsp/bridge/dynload/cload.c
+++ b/drivers/dsp/bridge/dynload/cload.c
@@ -177,18 +177,14 @@ int Dynamic_Load_Module(struct Dynamic_Loader_Stream *module,
 
 		init_module_handle(&dl_state);
 
+		/* dl_state.myio is init or 0 at this point. */
 		if (dl_state.myio) {
 			if ((!dl_state.dload_errcount) &&
-			   (dl_state.dfile_hdr.df_entry_secn != DN_UNDEF)) {
-				if (init != NULL) {
-					if (!init->execute(init,
-					   dl_state.dfile_hdr.df_entrypt))
-						dload_error(&dl_state,
-						    "Init->Execute Failed");
-				} else {
-					dload_error(&dl_state, "init is NULL");
-				}
-			}
+			    (dl_state.dfile_hdr.df_entry_secn != DN_UNDEF) &&
+			    (!init->execute(init,
+					    dl_state.dfile_hdr.df_entrypt)))
+				dload_error(&dl_state,
+					    "Init->Execute Failed");
 			init->release(init);
 		}
 
@@ -287,12 +283,13 @@ Dynamic_Open_Module(struct Dynamic_Loader_Stream *module,
 
 		init_module_handle(&dl_state);
 
+		/* dl_state.myio is either 0 or init at this point. */
 		if (dl_state.myio) {
-			if ((!dl_state.dload_errcount)
-			    && (dl_state.dfile_hdr.df_entry_secn != DN_UNDEF))
-				if (!init->execute(init,
-				   dl_state.dfile_hdr.df_entrypt))
-					dload_error(&dl_state,
+			if ((!dl_state.dload_errcount) &&
+			    (dl_state.dfile_hdr.df_entry_secn != DN_UNDEF) &&
+			    (!init->execute(init,
+					    dl_state.dfile_hdr.df_entrypt)))
+				dload_error(&dl_state,
 					    "Init->Execute Failed");
 			init->release(init);
 		}
-- 
1.6.0.4

