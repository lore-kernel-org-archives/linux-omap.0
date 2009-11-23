From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 1/3] OMAP: omap_device: fix nsec/usec conversion in latency calculations
Date: Mon, 23 Nov 2009 09:33:40 -0800
Message-ID: <1258997622-13923-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f171.google.com ([209.85.222.171]:46131 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752786AbZKWRdi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Nov 2009 12:33:38 -0500
Received: by pzk1 with SMTP id 1so4102157pzk.33
        for <linux-omap@vger.kernel.org>; Mon, 23 Nov 2009 09:33:45 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Use

   usecs = nsecs / NSEC_PER_USEC;

instead of

   usecs = nsecs * NSEC_PER_USEC;

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/plat-omap/omap_device.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index 288fd12..722f2c8 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -142,7 +142,7 @@ static int _omap_device_activate(struct omap_device *od, u8 ignore_lat)
 		read_persistent_clock(&b);
 
 		c = timespec_sub(b, a);
-		act_lat = timespec_to_ns(&c) * NSEC_PER_USEC;
+		act_lat = timespec_to_ns(&c) / NSEC_PER_USEC;
 
 		pr_debug("omap_device: %s: pm_lat %d: activate: elapsed time "
 			 "%llu usec\n", od->pdev.name, od->pm_lat_level,
@@ -198,7 +198,7 @@ static int _omap_device_deactivate(struct omap_device *od, u8 ignore_lat)
 		read_persistent_clock(&b);
 
 		c = timespec_sub(b, a);
-		deact_lat = timespec_to_ns(&c) * NSEC_PER_USEC;
+		deact_lat = timespec_to_ns(&c) / NSEC_PER_USEC;
 
 		pr_debug("omap_device: %s: pm_lat %d: deactivate: elapsed time "
 			 "%llu usec\n", od->pdev.name, od->pm_lat_level,
-- 
1.6.5.1

