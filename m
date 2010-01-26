From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 2/2] OMAP: omap_device: when 'called from invalid state', print state
Date: Tue, 26 Jan 2010 11:00:44 -0800
Message-ID: <1264532444-22706-2-git-send-email-khilman@deeprootsystems.com>
References: <1264532444-22706-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f220.google.com ([209.85.220.220]:46166 "EHLO
	mail-fx0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754901Ab0AZTA4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Jan 2010 14:00:56 -0500
Received: by fxm20 with SMTP id 20so714414fxm.21
        for <linux-omap@vger.kernel.org>; Tue, 26 Jan 2010 11:00:55 -0800 (PST)
In-Reply-To: <1264532444-22706-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

The omap_device_[enable|idle|shutdown] functions print a warning
when called from an invalid state.  Print the invalid state in
the warning messages.  This also uses __func__ to get the function
name.

Also, move the entire print string onto a single line to facilitate
grepping or error messages.  Recent discussions on LKML show
strong preference for grep-able code vs. strict 80 column limit.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/plat-omap/omap_device.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index 187a08f..d4f34ea 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -476,8 +476,8 @@ int omap_device_enable(struct platform_device *pdev)
 	od = _find_by_pdev(pdev);
 
 	if (od->_state == OMAP_DEVICE_STATE_ENABLED) {
-		WARN(1, "omap_device: %s.%d: omap_device_enable() called from "
-		     "invalid state\n", od->pdev.name, od->pdev.id);
+		WARN(1, "omap_device: %s.%d: %s() called from invalid state %d\n",
+		     od->pdev.name, od->pdev.id, __func__, od->_state);
 		return -EINVAL;
 	}
 
@@ -515,8 +515,8 @@ int omap_device_idle(struct platform_device *pdev)
 	od = _find_by_pdev(pdev);
 
 	if (od->_state != OMAP_DEVICE_STATE_ENABLED) {
-		WARN(1, "omap_device: %s.%d: omap_device_idle() called from "
-		     "invalid state\n", od->pdev.name, od->pdev.id);
+		WARN(1, "omap_device: %s.%d: %s() called from invalid state %d\n",
+		     od->pdev.name, od->pdev.id, __func__, od->_state);
 		return -EINVAL;
 	}
 
@@ -548,8 +548,8 @@ int omap_device_shutdown(struct platform_device *pdev)
 
 	if (od->_state != OMAP_DEVICE_STATE_ENABLED &&
 	    od->_state != OMAP_DEVICE_STATE_IDLE) {
-		WARN(1, "omap_device: %s.%d: omap_device_shutdown() called "
-		     "from invalid state\n", od->pdev.name, od->pdev.id);
+		WARN(1, "omap_device: %s.%d: %s() called from invalid state %d\n",
+		     od->pdev.name, od->pdev.id, __func__, od->_state);
 		return -EINVAL;
 	}
 
-- 
1.6.6

