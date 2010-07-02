From: Thara Gopinath <thara@ti.com>
Subject: [RFC 2/7] OMAP: Introduce API in the OPP layer to find the opp entry corresponding to a voltage.
Date: Fri,  2 Jul 2010 15:48:24 +0530
Message-ID: <1278065909-32148-3-git-send-email-thara@ti.com>
References: <1278065909-32148-1-git-send-email-thara@ti.com>
 <1278065909-32148-2-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56034 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752478Ab0GBKSm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 2 Jul 2010 06:18:42 -0400
In-Reply-To: <1278065909-32148-2-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com, p-basak2@ti.com, Thara Gopinath <thara@ti.com>

This patch adds an API in the opp layer to get the opp table entry
corresponding to the voltage passed as the parameter.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/plat-omap/include/plat/opp.h |    2 ++
 arch/arm/plat-omap/opp.c              |   28 ++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/opp.h b/arch/arm/plat-omap/include/plat/opp.h
index 29e3d03..893731f 100644
--- a/arch/arm/plat-omap/include/plat/opp.h
+++ b/arch/arm/plat-omap/include/plat/opp.h
@@ -75,6 +75,8 @@ struct omap_opp *opp_find_freq_floor(struct device *dev, unsigned long *freq);
 
 struct omap_opp *opp_find_freq_ceil(struct device *dev, unsigned long *freq);
 
+struct omap_opp *opp_find_voltage(struct device *dev, unsigned long volt);
+
 int opp_add(const struct omap_opp_def *opp_def);
 
 int opp_enable(struct omap_opp *opp);
diff --git a/arch/arm/plat-omap/opp.c b/arch/arm/plat-omap/opp.c
index 0273497..070ff5b 100644
--- a/arch/arm/plat-omap/opp.c
+++ b/arch/arm/plat-omap/opp.c
@@ -302,6 +302,34 @@ struct omap_opp *opp_find_freq_floor(struct device *dev, unsigned long *freq)
 	return opp;
 }
 
+/**
+ * opp_find_voltage() - search for an exact voltage
+ * @dev:	device pointer associated with the opp type
+ * @volt:	voltage to search for
+ *
+ * Searches for exact match in the opp list and returns handle to the matching
+ * opp if found, else returns ERR_PTR in case of error and should be handled
+ * using IS_ERR.
+ */
+struct omap_opp *opp_find_voltage(struct device *dev, unsigned long volt)
+{
+	struct device_opp *dev_opp;
+	struct omap_opp *temp_opp, *opp = ERR_PTR(-ENODEV);
+
+	dev_opp = find_device_opp(dev);
+	if (IS_ERR(dev_opp))
+		return opp;
+
+	list_for_each_entry(temp_opp, &dev_opp->opp_list, node) {
+		if (temp_opp->enabled && temp_opp->u_volt == volt) {
+			opp = temp_opp;
+			break;
+		}
+	}
+
+	return opp;
+}
+
 /* wrapper to reuse converting opp_def to opp struct */
 static void omap_opp_populate(struct omap_opp *opp,
 			      const struct omap_opp_def *opp_def)
-- 
1.7.0.rc1.33.g07cf0f

