From: jean.pihet@newoldbits.com
Subject: [PATCH 5/8] OMAP: PM CONSTRAINTS: add an enum for the classes of constraint
Date: Wed,  4 May 2011 15:35:14 +0200
Message-ID: <1304516117-9334-6-git-send-email-j-pihet@ti.com>
References: <1304516117-9334-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:60243 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753387Ab1EDNfm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 May 2011 09:35:42 -0400
Received: by wwk4 with SMTP id 4so4298473wwk.1
        for <linux-omap@vger.kernel.org>; Wed, 04 May 2011 06:35:40 -0700 (PDT)
In-Reply-To: <1304516117-9334-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, paul@pwsan.com
Cc: Jean Pihet <j-pihet@ti.com>

From: Jean Pihet <j-pihet@ti.com>

Defined values in the enum:
- OMAP_PM_CONSTRAINT_WKUP_LAT
- OMAP_PM_CONSTRAINT_THROUGHPUT

More classes can be added later if needed.

Tested on OMAP3 Beagleboard in RET/OFF using wake-up latency constraints
on MPU, CORE and PER.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/plat-omap/include/plat/omap-pm.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/omap-pm.h b/arch/arm/plat-omap/include/plat/omap-pm.h
index c0a7520..5f19cb2 100644
--- a/arch/arm/plat-omap/include/plat/omap-pm.h
+++ b/arch/arm/plat-omap/include/plat/omap-pm.h
@@ -70,6 +70,10 @@ void omap_pm_if_exit(void);
  * Device-driver-originated constraints (via board-*.c files, platform_data)
  */
 
+enum omap_pm_constraint_class {
+	OMAP_PM_CONSTRAINT_WKUP_LAT,
+	OMAP_PM_CONSTRAINT_THROUGHPUT
+};
 
 /**
  * omap_pm_set_max_mpu_wakeup_lat - set the maximum MPU wakeup latency
-- 
1.7.2.5

