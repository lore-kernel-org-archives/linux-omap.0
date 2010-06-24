From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH v2 07/13] OMAP: hwmod: don't auto-disable hwmod when !CONFIG_PM_RUNTIME
Date: Thu, 24 Jun 2010 16:44:38 -0700
Message-ID: <1277423084-25528-8-git-send-email-khilman@deeprootsystems.com>
References: <1277423084-25528-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:45007 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753734Ab0FXXpA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Jun 2010 19:45:00 -0400
Received: by mail-pv0-f174.google.com with SMTP id 2so587510pvg.19
        for <linux-omap@vger.kernel.org>; Thu, 24 Jun 2010 16:45:00 -0700 (PDT)
In-Reply-To: <1277423084-25528-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com

When runtime PM is disabled, the pm_runtime_idle() and _enable()
functions will be effectively noops and will not result in enable
and idle calls at the hwmod level.

In order for drivers to still work when runtime PM is disabled, ensure
that all hwmods are left in an enabled state so that even without
runtime PM management, they will still work.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index fa11139..e57d9c5 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1059,6 +1059,14 @@ static int _setup(struct omap_hwmod *oh)
 		}
 	}
 
+#ifndef CONFIG_PM_RUNTIME
+	/*
+	 * If runtime PM is not enabled, leave the device enabled
+	 * since runtime PM will not be dynamically managing the device.
+	 */
+	oh->flags |= HWMOD_INIT_NO_IDLE;
+#endif
+
 	if (!(oh->flags & HWMOD_INIT_NO_IDLE))
 		_omap_hwmod_idle(oh);
 
-- 
1.7.0.2

