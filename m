From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 07/14] omap: Use getnstimeofday for omap_device
Date: Fri, 16 Oct 2009 16:41:27 -0700
Message-ID: <20091016234126.2463.85187.stgit@localhost>
References: <20091016233624.2463.26653.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:60661 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751400AbZJPXlX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Oct 2009 19:41:23 -0400
In-Reply-To: <20091016233624.2463.26653.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org

Use getnstimeofday for omap_device

Acked-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/omap_device.c |   50 ++++++++++++++------------------------
 1 files changed, 19 insertions(+), 31 deletions(-)

diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index 2c409fc..12513f4 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -103,21 +103,6 @@
 /* Private functions */
 
 /**
- * _read_32ksynct - read the OMAP 32K sync timer
- *
- * Returns the current value of the 32KiHz synchronization counter.
- * XXX this should be generalized to simply read the system clocksource.
- * XXX this should be moved to a separate synctimer32k.c file
- */
-static u32 _read_32ksynct(void)
-{
-	if (!cpu_class_is_omap2())
-		BUG();
-
-	return __raw_readl(OMAP2_IO_ADDRESS(OMAP_32KSYNCT_BASE + 0x010));
-}
-
-/**
  * _omap_device_activate - increase device readiness
  * @od: struct omap_device *
  * @ignore_lat: increase to latency target (0) or full readiness (1)?
@@ -133,13 +118,13 @@ static u32 _read_32ksynct(void)
  */
 static int _omap_device_activate(struct omap_device *od, u8 ignore_lat)
 {
-	u32 a, b;
+	struct timespec a, b, c;
 
 	pr_debug("omap_device: %s: activating\n", od->pdev.name);
 
 	while (od->pm_lat_level > 0) {
 		struct omap_device_pm_latency *odpl;
-		int act_lat = 0;
+		unsigned long long act_lat = 0;
 
 		od->pm_lat_level--;
 
@@ -149,20 +134,22 @@ static int _omap_device_activate(struct omap_device *od, u8 ignore_lat)
 		    (od->dev_wakeup_lat <= od->_dev_wakeup_lat_limit))
 			break;
 
-		a = _read_32ksynct();
+		getnstimeofday(&a);
 
 		/* XXX check return code */
 		odpl->activate_func(od);
 
-		b = _read_32ksynct();
+		getnstimeofday(&b);
 
-		act_lat = (b - a) >> 15; /* 32KiHz cycles to microseconds */
+		c = timespec_sub(b, a);
+		act_lat = timespec_to_ns(&c) * NSEC_PER_USEC;
 
 		pr_debug("omap_device: %s: pm_lat %d: activate: elapsed time "
-			 "%d usec\n", od->pdev.name, od->pm_lat_level, act_lat);
+			 "%llu usec\n", od->pdev.name, od->pm_lat_level,
+			 act_lat);
 
 		WARN(act_lat > odpl->activate_lat, "omap_device: %s.%d: "
-		     "activate step %d took longer than expected (%d > %d)\n",
+		     "activate step %d took longer than expected (%llu > %d)\n",
 		     od->pdev.name, od->pdev.id, od->pm_lat_level,
 		     act_lat, odpl->activate_lat);
 
@@ -188,13 +175,13 @@ static int _omap_device_activate(struct omap_device *od, u8 ignore_lat)
  */
 static int _omap_device_deactivate(struct omap_device *od, u8 ignore_lat)
 {
-	u32 a, b;
+	struct timespec a, b, c;
 
 	pr_debug("omap_device: %s: deactivating\n", od->pdev.name);
 
 	while (od->pm_lat_level < od->pm_lats_cnt) {
 		struct omap_device_pm_latency *odpl;
-		int deact_lat = 0;
+		unsigned long long deact_lat = 0;
 
 		odpl = od->pm_lats + od->pm_lat_level;
 
@@ -203,23 +190,24 @@ static int _omap_device_deactivate(struct omap_device *od, u8 ignore_lat)
 		     od->_dev_wakeup_lat_limit))
 			break;
 
-		a = _read_32ksynct();
+		getnstimeofday(&a);
 
 		/* XXX check return code */
 		odpl->deactivate_func(od);
 
-		b = _read_32ksynct();
+		getnstimeofday(&b);
 
-		deact_lat = (b - a) >> 15; /* 32KiHz cycles to microseconds */
+		c = timespec_sub(b, a);
+		deact_lat = timespec_to_ns(&c) * NSEC_PER_USEC;
 
 		pr_debug("omap_device: %s: pm_lat %d: deactivate: elapsed time "
-			 "%d usec\n", od->pdev.name, od->pm_lat_level,
+			 "%llu usec\n", od->pdev.name, od->pm_lat_level,
 			 deact_lat);
 
 		WARN(deact_lat > odpl->deactivate_lat, "omap_device: %s.%d: "
-		     "deactivate step %d took longer than expected (%d > %d)\n",
-		     od->pdev.name, od->pdev.id, od->pm_lat_level,
-		     deact_lat, odpl->deactivate_lat);
+		     "deactivate step %d took longer than expected "
+		     "(%llu > %d)\n", od->pdev.name, od->pdev.id,
+		     od->pm_lat_level, deact_lat, odpl->deactivate_lat);
 
 		od->dev_wakeup_lat += odpl->activate_lat;
 

