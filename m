From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 12/12] OMAP: SRF: must be initialized before allowing constraints to be set
Date: Wed, 16 Jun 2010 17:17:13 -0700
Message-ID: <1276733833-18510-13-git-send-email-khilman@deeprootsystems.com>
References: <1276733833-18510-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:49651 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759607Ab0FQARm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Jun 2010 20:17:42 -0400
Received: by mail-pw0-f46.google.com with SMTP id 1so3974097pwi.19
        for <linux-omap@vger.kernel.org>; Wed, 16 Jun 2010 17:17:42 -0700 (PDT)
In-Reply-To: <1276733833-18510-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: nm@ti.com, thara@ti.com, b-cousson@ti.com

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/plat-omap/omap-pm-srf.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/omap-pm-srf.c b/arch/arm/plat-omap/omap-pm-srf.c
index 5ebcda3..bf9163e 100644
--- a/arch/arm/plat-omap/omap-pm-srf.c
+++ b/arch/arm/plat-omap/omap-pm-srf.c
@@ -29,6 +29,8 @@
 #define LAT_RES_POSTAMBLE "_latency"
 #define MAX_LATENCY_RES_NAME 30
 
+static int initialized;
+
 /**
  * get_lat_res_name - gets the latency resource name given a power domain name
  * @pwrdm_name: Name of the power domain.
@@ -52,6 +54,9 @@ void get_lat_res_name(const char *pwrdm_name, char **lat_name, int size)
 
 void omap_pm_set_max_mpu_wakeup_lat(struct device *dev, long t)
 {
+	if (!initialized)
+		return;
+
 	if (!dev || t < -1) {
 		WARN_ON(1);
 		return;
@@ -291,6 +296,8 @@ int __init omap_pm_if_early_init(void)
 int __init omap_pm_if_init(void)
 {
 	resource_init(resources_omap);
+	initialized = 1;
+
 	return 0;
 }
 
-- 
1.7.0.2

