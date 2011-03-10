From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: [PATCH v2 2/7] OMAP: PM CONSTRAINTS: add an enum for the classes of constraint
Date: Thu, 10 Mar 2011 18:47:22 +0100
Message-ID: <1299779247-20511-3-git-send-email-j-pihet@ti.com>
References: <1299779247-20511-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:55430 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753463Ab1CJRrq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Mar 2011 12:47:46 -0500
Received: by wya21 with SMTP id 21so1681959wya.19
        for <linux-omap@vger.kernel.org>; Thu, 10 Mar 2011 09:47:44 -0800 (PST)
In-Reply-To: <1299779247-20511-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, paul@pwsan.com
Cc: Jean Pihet <j-pihet@ti.com>

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
1.7.2.3

