From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 6/8] OMAP: omap_device: use read_persistent_clock() instead of getnstimeofday()
Date: Tue, 17 Nov 2009 17:05:11 -0800
Message-ID: <1258506313-17115-7-git-send-email-khilman@deeprootsystems.com>
References: <1258506313-17115-1-git-send-email-khilman@deeprootsystems.com>
 <1258506313-17115-2-git-send-email-khilman@deeprootsystems.com>
 <1258506313-17115-3-git-send-email-khilman@deeprootsystems.com>
 <1258506313-17115-4-git-send-email-khilman@deeprootsystems.com>
 <1258506313-17115-5-git-send-email-khilman@deeprootsystems.com>
 <1258506313-17115-6-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f187.google.com ([209.85.210.187]:61295 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756725AbZKRBFc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Nov 2009 20:05:32 -0500
Received: by mail-yx0-f187.google.com with SMTP id 17so614173yxe.33
        for <linux-omap@vger.kernel.org>; Tue, 17 Nov 2009 17:05:38 -0800 (PST)
In-Reply-To: <1258506313-17115-6-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

During suspend and resume, when omap_device deactivation and
activation is happening, the timekeeping subsystem has likely already
been suspended.  Thus getnstimeofday() will fail and trigger a WARN().

Use read_persistent_clock() instead of getnstimeofday() to avoid this.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/plat-omap/omap_device.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index 6a8b0ce..f6cdf1a 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -134,12 +134,12 @@ static int _omap_device_activate(struct omap_device *od, u8 ignore_lat)
 		    (od->dev_wakeup_lat <= od->_dev_wakeup_lat_limit))
 			break;
 
-		getnstimeofday(&a);
+		read_persistent_clock(&a);
 
 		/* XXX check return code */
 		odpl->activate_func(od);
 
-		getnstimeofday(&b);
+		read_persistent_clock(&b);
 
 		c = timespec_sub(b, a);
 		act_lat = timespec_to_ns(&c) * NSEC_PER_USEC;
@@ -190,12 +190,12 @@ static int _omap_device_deactivate(struct omap_device *od, u8 ignore_lat)
 		     od->_dev_wakeup_lat_limit))
 			break;
 
-		getnstimeofday(&a);
+		read_persistent_clock(&a);
 
 		/* XXX check return code */
 		odpl->deactivate_func(od);
 
-		getnstimeofday(&b);
+		read_persistent_clock(&b);
 
 		c = timespec_sub(b, a);
 		deact_lat = timespec_to_ns(&c) * NSEC_PER_USEC;
-- 
1.6.5.1

