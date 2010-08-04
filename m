From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 3/3] OMAP: hwmod: Force a softreset during _setup
Date: Thu,  5 Aug 2010 00:12:48 +0200
Message-ID: <1280959968-23933-4-git-send-email-b-cousson@ti.com>
References: <1280959968-23933-1-git-send-email-b-cousson@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59266 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756707Ab0HDWNB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 4 Aug 2010 18:13:01 -0400
In-Reply-To: <1280959968-23933-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@deeprootsystems.com, paul@pwsan.com
Cc: rnayak@ti.com, santosh.shilimkar@ti.com, Benoit Cousson <b-cousson@ti.com>

Force the softreset of every IPs during the _setup phase.
IPs that cannot support softreset or that should not
be reset must set the HWMOD_INIT_NO_RESET flag in the
hwmod struct.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |   17 ++++++++---------
 1 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 53b08e3..91ad9c6 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -856,8 +856,8 @@ static int _reset(struct omap_hwmod *oh)
 
 	/* clocks must be on for this operation */
 	if (oh->_state != _HWMOD_STATE_ENABLED) {
-		WARN(1, "omap_hwmod: %s: reset can only be entered from "
-		     "enabled state\n", oh->name);
+		pr_warning("omap_hwmod: %s: reset can only be entered from "
+			   "enabled state\n", oh->name);
 		return -EINVAL;
 	}
 
@@ -874,8 +874,8 @@ static int _reset(struct omap_hwmod *oh)
 			  MAX_MODULE_RESET_WAIT, c);
 
 	if (c == MAX_MODULE_RESET_WAIT)
-		WARN(1, "omap_hwmod: %s: failed to reset in %d usec\n",
-		     oh->name, MAX_MODULE_RESET_WAIT);
+		pr_warning("omap_hwmod: %s: failed to reset in %d usec\n",
+			   oh->name, MAX_MODULE_RESET_WAIT);
 	else
 		pr_debug("omap_hwmod: %s: reset in %d usec\n", oh->name, c);
 
@@ -1074,12 +1074,11 @@ static int _setup(struct omap_hwmod *oh, void *data)
 	}
 
 	if (!(oh->flags & HWMOD_INIT_NO_RESET)) {
+		_reset(oh);
 		/*
-		 * XXX Do the OCP_SYSCONFIG bits need to be
-		 * reprogrammed after a reset?  If not, then this can
-		 * be removed.  If they do, then probably the
-		 * _omap_hwmod_enable() function should be split to avoid the
-		 * rewrite of the OCP_SYSCONFIG register.
+		 * OCP_SYSCONFIG bits need to be reprogrammed after a softreset.
+		 * The _omap_hwmod_enable() function should be split to
+		 * avoid the rewrite of the OCP_SYSCONFIG register.
 		 */
 		if (oh->class->sysc) {
 			_update_sysc_cache(oh);
-- 
1.6.1.3

