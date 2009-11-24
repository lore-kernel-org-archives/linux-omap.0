From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 2/2] OMAP: hwmod: allow idle after HWMOD_INIT_NO_IDLE
Date: Tue, 24 Nov 2009 10:10:41 -0800
Message-ID: <1259086241-14088-2-git-send-email-khilman@deeprootsystems.com>
References: <1259086241-14088-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f215.google.com ([209.85.219.215]:40077 "EHLO
	mail-ew0-f215.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933737AbZKXSKw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Nov 2009 13:10:52 -0500
Received: by ewy7 with SMTP id 7so5714ewy.28
        for <linux-omap@vger.kernel.org>; Tue, 24 Nov 2009 10:10:56 -0800 (PST)
In-Reply-To: <1259086241-14088-1-git-send-email-khilman@deeprootsystems.com>
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
index c5c4ddc..0cdcbdc 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -869,7 +869,13 @@ static int _enable(struct omap_hwmod *oh)
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
@@ -884,6 +890,9 @@ static int _idle(struct omap_hwmod *oh)
 
 	oh->_state = _HWMOD_STATE_IDLE;
 
+	/* Clear init flag which should only affect first call to idle */
+	oh->flags &= ~HWMOD_INIT_NO_IDLE;
+
 	return 0;
 }
 
-- 
1.6.5.1

