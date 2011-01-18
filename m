From: Martin Hostettler <martin@neutronstar.dyndns.org>
Subject: [PATCH] OMAP: PM: Export omap_pm_set_min_bus_tput to modules
Date: Tue, 18 Jan 2011 22:34:20 +0100
Message-ID: <1295386460-13960-1-git-send-email-martin@neutronstar.dyndns.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:59646 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751308Ab1ARVhi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Jan 2011 16:37:38 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Paul Walmsley <paul@pwsan.com>, Martin Hostettler <martin@neutronstar.dyndns.org>

This patch exports omap_pm_set_min_bus_tput from omap-pm-noop.c to modules,
to allow building omap3-isp as module without another pm implementation.

Signed-off-by: Martin Hostettler <martin@neutronstar.dyndns.org>
---
 arch/arm/plat-omap/omap-pm-noop.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/omap-pm-noop.c b/arch/arm/plat-omap/omap-pm-noop.c
index e129ce8..0f8275b 100644
--- a/arch/arm/plat-omap/omap-pm-noop.c
+++ b/arch/arm/plat-omap/omap-pm-noop.c
@@ -88,6 +88,7 @@ int omap_pm_set_min_bus_tput(struct device *dev, u8 agent_id, unsigned long r)
 
 	return 0;
 }
+EXPORT_SYMBOL(omap_pm_set_min_bus_tput);
 
 int omap_pm_set_max_dev_wakeup_lat(struct device *req_dev, struct device *dev,
 				   long t)
-- 
1.7.1

