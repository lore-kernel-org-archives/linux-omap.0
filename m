From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 1/5] OMAP: hwmod: allow idle after HWMOD_INIT_NO_IDLE
Date: Thu, 27 May 2010 14:13:32 -0700
Message-ID: <1274994816-30335-2-git-send-email-khilman@deeprootsystems.com>
References: <1274994816-30335-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f176.google.com ([209.85.222.176]:64008 "EHLO
	mail-pz0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754206Ab0E0VNl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 May 2010 17:13:41 -0400
Received: by mail-pz0-f176.google.com with SMTP id 6so314656pzk.1
        for <linux-omap@vger.kernel.org>; Thu, 27 May 2010 14:13:41 -0700 (PDT)
In-Reply-To: <1274994816-30335-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

If an omap_hwmod is setup using HWMOD_INIT_NO_IDLE flag, there is
currently way to idle it since omap_hwmod_idle() requires the hwmod to
be in the enabled state.

This patch adds a check to omap_hwmod_idle() so if the hwmod was has
the INIT_NO_IDLE flag, calling omap_hwmod_idle() will still succeed.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 2fff39f..a127c9b 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -939,7 +939,13 @@ static int _enable(struct omap_hwmod *oh)
  */
 static int _idle(struct omap_hwmod *oh)
 {
-	if (oh->_state != _HWMOD_STATE_ENABLED) {
+	/*
+	 * To idle, hwmod must be enabled, EXCEPT if hwmod was
+	 * initialized using the INIT_NO_IDLE flag.  In this case it
+	 * will not yet be enabled so we have to allow it to be idled.
+	 */
+	if ((oh->_state != _HWMOD_STATE_ENABLED) &&
+	    !(oh->flags & HWMOD_INIT_NO_IDLE)) {
 		WARN(1, "omap_hwmod: %s: idle state can only be entered from "
 		     "enabled state\n", oh->name);
 		return -EINVAL;
@@ -954,6 +960,9 @@ static int _idle(struct omap_hwmod *oh)
 
 	oh->_state = _HWMOD_STATE_IDLE;
 
+	/* Clear init flag which should only affect first call to idle */
+	oh->flags &= ~HWMOD_INIT_NO_IDLE;
+
 	return 0;
 }
 
-- 
1.7.0.2

