From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 02/13] OMAP: hwmod: allow idle after HWMOD_INIT_NO_IDLE
Date: Wed, 23 Jun 2010 16:42:32 -0700
Message-ID: <1277336563-24988-3-git-send-email-khilman@deeprootsystems.com>
References: <1277336563-24988-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:33107 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753904Ab0FWXmu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Jun 2010 19:42:50 -0400
Received: by pzk3 with SMTP id 3so196876pzk.19
        for <linux-omap@vger.kernel.org>; Wed, 23 Jun 2010 16:42:49 -0700 (PDT)
In-Reply-To: <1277336563-24988-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com

If an omap_hwmod is setup using HWMOD_INIT_NO_IDLE flag, there is
currently way to idle it since omap_hwmod_idle() requires the hwmod to
be in the enabled state.

This patch adds a check to omap_hwmod_idle() so if the hwmod was has
the INIT_NO_IDLE flag, calling omap_hwmod_idle() will still succeed.

Cc: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 95c9a5f..ac75407 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -938,7 +938,13 @@ static int _enable(struct omap_hwmod *oh)
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
@@ -953,6 +959,9 @@ static int _idle(struct omap_hwmod *oh)
 
 	oh->_state = _HWMOD_STATE_IDLE;
 
+	/* Clear init flag which should only affect first call to idle */
+	oh->flags &= ~HWMOD_INIT_NO_IDLE;
+
 	return 0;
 }
 
-- 
1.7.0.2

