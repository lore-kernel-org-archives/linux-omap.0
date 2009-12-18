From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH v2 4/4] OMAP OPP: hide struct omap_opp internals in OPP layer implementation
Date: Fri, 18 Dec 2009 15:05:39 -0800
Message-ID: <1261177539-15429-5-git-send-email-khilman@deeprootsystems.com>
References: <1261177539-15429-1-git-send-email-khilman@deeprootsystems.com>
 <1261177539-15429-2-git-send-email-khilman@deeprootsystems.com>
 <1261177539-15429-3-git-send-email-khilman@deeprootsystems.com>
 <1261177539-15429-4-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f189.google.com ([209.85.216.189]:39115 "EHLO
	mail-px0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933328AbZLRXFu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Dec 2009 18:05:50 -0500
Received: by mail-px0-f189.google.com with SMTP id 27so720163pxi.4
        for <linux-omap@vger.kernel.org>; Fri, 18 Dec 2009 15:05:49 -0800 (PST)
In-Reply-To: <1261177539-15429-4-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: nm@ti.com

Now that we have accessor/helper functions for all the OPP layer
details, move 'struct omap_opp' into the OPP layer so no direct
accesses to OPP internals can be done.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/plat-omap/include/plat/opp.h |   19 +------------------
 arch/arm/plat-omap/opp.c              |   19 +++++++++++++++++++
 2 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/opp.h b/arch/arm/plat-omap/include/plat/opp.h
index 6fe574c..9f91ad3 100644
--- a/arch/arm/plat-omap/include/plat/opp.h
+++ b/arch/arm/plat-omap/include/plat/opp.h
@@ -17,24 +17,7 @@ extern struct omap_opp *mpu_opps;
 extern struct omap_opp *dsp_opps;
 extern struct omap_opp *l3_opps;
 
-/**
- * struct omap_opp - OMAP OPP description structure
- * @enabled:	true/false - marking this OPP as enabled/disabled
- * @rate:	Frequency in hertz
- * @opp_id:	(DEPRECATED) opp identifier
- * @u_volt:     minimum microvolts DC required for this OPP to function
- *
- * This structure stores the OPP information for a given domain.
- * Due to legacy reasons, this structure is currently exposed and
- * will soon be removed elsewhere and will only be used as a handle
- * from the OPP internal referencing mechanism
- */
-struct omap_opp {
-	bool enabled;
-	unsigned long rate;
-	unsigned long u_volt;
-	u8 __deprecated opp_id;
-};
+struct omap_opp;
 
 /**
  * opp_get_voltage() - Gets the voltage corresponding to an opp
diff --git a/arch/arm/plat-omap/opp.c b/arch/arm/plat-omap/opp.c
index 4f7fa22..4fe1933 100644
--- a/arch/arm/plat-omap/opp.c
+++ b/arch/arm/plat-omap/opp.c
@@ -19,6 +19,25 @@
 #include <plat/opp_twl_tps.h>
 #include <plat/opp.h>
 
+/**
+ * struct omap_opp - OMAP OPP description structure
+ * @enabled:	true/false - marking this OPP as enabled/disabled
+ * @rate:	Frequency in hertz
+ * @opp_id:	(DEPRECATED) opp identifier
+ * @u_volt:     minimum microvolts DC required for this OPP to function
+ *
+ * This structure stores the OPP information for a given domain.
+ * Due to legacy reasons, this structure is currently exposed and
+ * will soon be removed elsewhere and will only be used as a handle
+ * from the OPP internal referencing mechanism
+ */
+struct omap_opp {
+	bool enabled;
+	unsigned long rate;
+	unsigned long u_volt;
+	u8 opp_id;
+};
+
 /*
  * DEPRECATED: Meant to detect end of opp array
  * This is meant to help co-exist with current SRF etc
-- 
1.6.6.rc2.1.g42108

